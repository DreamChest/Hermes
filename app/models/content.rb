class Content < ApplicationRecord
  belongs_to :article

  validates :html, presence: true
end
