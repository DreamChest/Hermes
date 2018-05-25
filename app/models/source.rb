# Source class, describes a RSS feed
# @author Quentin Sonrel
class Source < ApplicationRecord
  require 'open-uri'

  belongs_to :user
  has_many :articles, dependent: :destroy
  has_and_belongs_to_many :tags

  validates :name, :url, presence: true, uniqueness: { scope: :user_id }
  validates :url, url: true, feed: true

  attr_accessor :tags_string

  before_save unless: proc { tags_string.nil? } do
    self.tags = user.tags.from_string(tags_string)
  end

  before_save :fetch_favicon
  before_destroy :remove_favicon

  scope :by_tag, (lambda do |tag|
    joins(:tags).where('tags.id = :id or tags.name = :id', id: tag)
  end)

  # New Articles (since last update)
  # @return [Array] array of new Articles
  def new_articles
    @new_articles ||= feed.entries.map do |e|
      parse(e) if e.published.utc > last_update
    end.compact
  end

  # Updates Articles form feed
  # @return [Boolean] whether or not new Articles were fetched
  def update_articles
    return false if new_articles.blank?
    articles << new_articles
    update(last_update: articles.first.date)
  end

  # Clear (delete all) Articles from Source
  # @return [Boolean] if the Articles were successfully cleared
  def clear
    articles.destroy_all
  end

  # Reset (like if it were just created) a Source
  # @return [Boolean] if the Source was successfully reset
  def reset
    @feed = nil
    @new_articles = nil
    update(last_update: Time.at(0).utc) if clear
  end

  private

  attr_writer :feed, :new_articles

  # Feedjira RSS feed
  # @return [Feedjira::Parser::RSS] the Feedjira RSS feed
  def feed
    @feed ||= Feedjira::Feed.fetch_and_parse(url)
  end

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

  # Fetch the favicon
  # @return [Boolean] if the favicon was succesfully fetched
  def fetch_favicon
    self.favicon_url ||= "#{feed.url}/favicon.ico"

    open(Hermes::FAVICON_TEMP_PATH, 'wb') do |file|
      file << open(favicon_url).read
    end

    Magick::Image.read(Hermes::FAVICON_TEMP_PATH).first
                 .write("#{Hermes::FAVICON_BASE_DIR}/#{name}.png")

    self.favicon_path = "#{Hermes::FAVICON_BASE_URL}/#{name}.png"
  rescue StandardError => ex
    logger.warn ex.message
    false
  end

  # Remove the favicon (used upon destruction)
  # @return [Boolean] if the favicon file was removed
  def remove_favicon
    path = "#{Hermes::FAVICON_BASE_DIR}/#{name}.png"
    FileUtils.rm(path) if File.exist?(path)
  end
end
