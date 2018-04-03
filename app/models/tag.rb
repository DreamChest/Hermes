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
  has_and_belongs_to_many :sources

  validates :name, presence: true, uniqueness: true, valid_name: true

  def self.filter_by_source(source)
    joins(:sources).where('sources.name = :id or sources.name = :id', id: source)
  end

  # Remove unused Tags
  def self.clean
    all.each { |t| t.destroy if t.sources.blank? }
  end
end
