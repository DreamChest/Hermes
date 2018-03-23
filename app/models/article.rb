# Article class, describes an RSS feed entry
# @author Quentin Sonrel
class Article < ApplicationRecord
  belongs_to :source
  has_one :content, dependent: :destroy

  validates :title, :date, :url, presence: true
end
