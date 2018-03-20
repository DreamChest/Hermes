class Article < ApplicationRecord
  belongs_to :source
  has_one :content

  validates :title, :date, :url, presence: true
end
