# FeedValidator class, for validating RSS feed URLs
# @author Quentin Sonrel
class FeedValidator < ActiveModel::EachValidator
  # Validate attributes (mandatory from EachValidator)
  def validate_each(record, attribute, value)
    record.feed = Feedjira::Feed.fetch_and_parse(value)
  rescue StandardError
    record.errors[attribute] << 'must be a valid RSS feed URL'
  end
end

# Source class, describes a RSS feed
# @author Quentin Sonrel
class Source < ApplicationRecord
  require 'open-uri'

  has_many :articles, dependent: :destroy
  has_and_belongs_to_many :tags
  belongs_to :user

  validates :name, :url, presence: true, uniqueness: { scope: :user_id }
  validates :url, url: true, feed: true

  attr_accessor :feed, :new_articles, :tags_string

  # Filter Sources by tag
  # @param tag Tag to filter by
  # @return [Source::ActiveRecord_Relation] collection of Sources containing the Tag
  def self.filter_by_tag(tag)
    joins(:tags).where('tags.id = :id or tags.name = :id', id: tag)
  end

  # Fetch and parse entries from feed URL
  # @return [Boolean] if the feed was successfully fetched
  def fetch
    self.feed = Feedjira::Feed.fetch_and_parse(url)
    true
  rescue StandardError => ex
    err = "feed could not be fetched\n(Feedjira says: #{ex.message})"
    logger.error "#{name}: #{err}"
    errors[:url] << err
    false
  end

  # Extract Articles from feed entries
  # @return [Array] array of Articles extracted from Source feed
  def extract
    self.new_articles = feed.entries.map do |e|
      parse(e) if e.published.utc > last_update
    end.compact
  end

  # Save Articles to DB
  # @return [Boolean] if the Articles were succesfully saved
  def save_articles
    return false if new_articles.blank?
    articles << new_articles
    update(last_update: new_articles.first.date)
  end

  # Fetch the favicon
  # @return [Boolean] if the favicon was succesfully fetched
  def fetch_favicon
    favicon_url ||= "#{feed.url}/favicon.ico"

    open(Hermes::FAVICON_TEMP_PATH, 'wb') do |file|
      file << open(favicon_url).read
    end

    Magick::Image.read(Hermes::FAVICON_TEMP_PATH).first
                 .write("#{Hermes::FAVICON_BASE_DIR}/#{id}.png")

    update(favicon_path: "#{Hermes::FAVICON_BASE_URL}/#{id}.png")
  rescue StandardError => ex
    logger.warn ex.message
    false
  end

  # Tag the source from a space separated string of Tags
  # @param tags list of tags (space-separated string)
  # @return [Array] array of Tags attributed to Source
  def tag(tags)
    self.tags.clear
    tags.each do |tag|
      self.tags << (Tag.where('name = ?', tag).first || Tag.create(name: tag))
    end
  end

  # Clear (delete all) Articles from Source
  # @return [Boolean] if the Articles were successfully cleared
  def clear
    articles.destroy_all
  end

  # Reset (like if it were just created) a Source
  # @return [Boolean] if the Source was successfully reset
  def reset
    update(last_update: Time.at(0).utc) if clear
  end

  private

  # Parse a feed entry to an Article
  # @return [Article] the parsed Article
  def parse(entry)
    Article.new do |a|
      a.title = entry.title
      a.date = entry.published.utc
      a.url = entry.url
      a.content = Content.new(html: entry.content || entry.summary)
    end
  end
end
