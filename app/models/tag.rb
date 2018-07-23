# Tag class, describes a tag (categorization for Sources)
# @author Quentin Sonrel
class Tag < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :sources
  has_many :articles, through: :sources

  validates :name, presence: true, uniqueness: { scope: :user_id }, valid_name: true

  scope :from_source, (lambda do |source|
    joins(:sources).where('sources.id = :id or sources.name = :id', id: source)
  end)

  # Remove unused tags
  # @return [Array] array of remaining tags
  def self.clean
    all.each { |t| t.destroy if t.sources.blank? }
  end
end
