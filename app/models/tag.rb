# Tag class, describes a tag (categorization for Sources)
# @author Quentin Sonrel
class Tag < ApplicationRecord
  extend FriendlyId

  friendly_id :name

  belongs_to :user
  has_and_belongs_to_many :sources
  has_many :articles, through: :sources

  validates :name, presence: true, uniqueness: { scope: :user_id }

  scope :from_source, (lambda do |source|
    joins(:sources).where(
      'sources.id = ? or sources.name = ?',
      source.to_i,
      source
    )
  end)

  # Remove unused tags
  # @return [Array] array of remaining tags
  def self.clean
    all.each { |t| t.destroy if t.sources.blank? }
    all
  end
end
