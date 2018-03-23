# Tag class, describes a tag (categorization for Sources)
# @author Quentin Sonrel
class Tag < ApplicationRecord
  has_and_belongs_to_many :sources

  validates :name, :color, presence: true, uniqueness: true
end
