# Article class, describes an RSS feed entry
# @author Quentin Sonrel
class Article < ApplicationRecord
  belongs_to :source
  has_one :content, dependent: :destroy

  validates :title, :date, :url, presence: true

  # Filter Articles by Sources
  # @param sources Sources to filter by (array of Source names (strings))
  # @return [Array] array of articles filtered by Sources
  def self.filter_by_source(sources)
    Source
      .where('name in (?)', sources)
      .map(&:articles)
      .flatten
  end

  # Filter Articles by Tags
  # @param tags Tags to filter by (array of Tag names (strings))
  # @return [Array] array of Articles filtered by Tags
  def self.filter_by_tags(tags)
    Tag
      .where('name in (?)', tags)
      .map(&:sources)
      .flatten
      .map(&:articles)
      .flatten
  end
end
