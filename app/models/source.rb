class Source < ApplicationRecord
  has_many :articles
  has_and_belongs_to_many :tags

  validates :name, :url, presence: true, uniqueness: true
end
