# Article class, describes an RSS feed entry
# @author Quentin Sonrel
class Article < ApplicationRecord
  belongs_to :source
  has_one :content, dependent: :destroy

  delegate :tags, to: :source

  validates :title, :date, :url, presence: true

  # Filter Articles
  # @param by type of filter (:sources, :tags or :none)
  # @param array collection to filter by (array of Sources or Tags or nothing)
  # @return [Article::ActiveRecord_Relation] filtered collection of Articles
  def self.filter(by = :none, array = [])
    case by
    when :sources
      filter_by_sources(array)
    when :tags
      filter_by_tags(array)
    else
      Article.all
    end
  end

  # Filter Articles by Sources
  # @param sources Sources to filter by (array of Source names (strings))
  # @return [Article::ActiveRecord_Relation] collection of Articles filtered by Sources
  def self.filter_by_sources(sources)
    joins(:source).where('sources.name in (?)', sources)
  end

  # Filter Articles by Tags
  # @param tags Tags to filter by (array of Tag names (strings))
  # @return [Article::ActiveRecord_Relation] collection of Articles filtered by Tags
  def self.filter_by_tags(tags)
    joins('
      inner join sources_tags on articles.source_id = sources_tags.source_id
      inner join tags on sources_tags.tag_id = tags.id
    ').where('tags.name in (?)', tags)
  end
end
