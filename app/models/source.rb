# FeedValidator class, for validating RSS feed URLs
# @author Quentin Sonrel
class FeedValidator < ActiveModel::EachValidator
  # Validate attributes (mandatory from FeedValidator)
  def validate_each(record, attribute, value)
    record.feed = Feedjira::Feed.fetch_and_parse(value)
  rescue StandardError
    record.errors[attribute] << 'must be a valid RSS feed URL'
  end
end

# Source class, describes a RSS feed
# @author Quentin Sonrel
class Source < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_and_belongs_to_many :tags

  validates :name, :url, presence: true, uniqueness: true
  validates :url, url: true, feed: true

  attr_accessor :feed, :new_articles

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
  # @return [Array] the new Articles extracted from feed
  def extract
    self.new_articles = []

    feed.entries.each do |e|
      new_articles << parse(e) if e.published.utc > last_update
    end

    new_articles
  end

  # Save Articles to DB
  # @return [Boolean] if the Articles were succesfully saved
  def save_articles
    return false if new_articles.empty?
    articles << new_articles
    update(last_update: new_articles.first.date)
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
  # @return [Article] the parsed article
  def parse(entry)
    Article.new do |a|
      a.title = entry.title
      a.date = entry.published.utc
      a.url = entry.url
    end
  end
end
