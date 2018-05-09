# ValidNameValidator class, for validating Tag name
# @author Quentin Sonrel
class ValidNameValidator < ActiveModel::EachValidator
  # Validate attributes (mandatory from EachValidator)
  def validate_each(record, attribute, value)
    record.errors[attribute] << 'must have a different value' if value == 'clean'
  end
end

# Tag class, describes a tag (categorization for Sources)
# @author Quentin Sonrel
class Tag < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :sources
  has_many :articles, through: :sources

  validates :name, presence: true, uniqueness: { scope: :user_id }, valid_name: true

  scope :by_source, (lambda do |source|
    joins(:sources).where('sources.id = :id or sources.name = :id', id: source)
  end)

  # Remove unused Tags
  # @return [Array] array of remaining Tags
  def self.clean
    all.each { |t| t.destroy if t.sources.blank? }
  end
end
