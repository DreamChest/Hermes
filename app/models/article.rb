# Article class, describes an RSS feed entry
# @author Quentin Sonrel
class Article < ApplicationRecord
  belongs_to :source
  has_one :content, dependent: :destroy

  validates :title, :date, :url, presence: true

  def self.filter_by_source(sources)
    Source
      .where('name in (?)', sources)
      .map(&:articles)
      .flatten
  end

  def self.filter_by_tags(tags)
    Tag
      .where('name in (?)', tags)
      .map(&:sources)
      .flatten
      .map(&:articles)
      .flatten
  end
end
