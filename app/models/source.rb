class Source < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_and_belongs_to_many :tags

  validates :name, :url, presence: true, uniqueness: true

  attr_accessor :feed, :new_articles

  def fetch
    self.feed = Feedjira::Feed.fetch_and_parse(url)
  rescue
    nil
  end

  def extract
    self.new_articles = []

    feed.entries.each do |e|
      new_articles << parse(e) if e.published.utc > last_update
    end

    new_articles
  end

  def write
    return false if new_articles.empty?
    articles << new_articles
    update(last_update: new_articles.first.date)
  end

  private

  def parse(entry)
    Article.new do |a|
      a.title = entry.title
      a.date = entry.published.utc
      a.url = entry.url
    end
  end
end
