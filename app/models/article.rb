# Article class, describes an RSS feed entry
# @author Quentin Sonrel
class Article < ApplicationRecord
  belongs_to :source
  has_one :content, dependent: :destroy
  has_many :tags, through: :source

  validates :title, :date, :url, presence: true

  scope :since, ->(date) { where('date >= ?', date) if date }
  scope :until, ->(date) { where('date <= ?', date) if date }

  scope :from_sources, (lambda do |sources|
    joins(:source).where('sources.name in (?)', sources)
  end)

  scope :with_tags, (lambda do |tags|
    joins('
      inner join sources_tags on articles.source_id = sources_tags.source_id
      inner join tags on sources_tags.tag_id = tags.id
    ').where('tags.name in (?)', tags).distinct
  end)
end
