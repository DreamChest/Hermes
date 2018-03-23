# Content class, describes an feed entry raw HTML content
# @author Quentin Sonrel
class Content < ApplicationRecord
  belongs_to :article

  validates :html, presence: true
end
