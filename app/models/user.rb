# User class, describes an authentifiable user for the API
# @author Quentin Sonrel
class User < ApplicationRecord
  has_secure_password

  has_many :sources
  has_many :tags do
    # Fetch or a create tags from a string
    # @param str space-separated list of Tags
    # @return the matching collection of Tags
    def parse_str(str)
      str.split.map do |name|
        where(name: name).first_or_create(name: name)
      end
    end
  end
  has_many :articles, through: :sources

  validates :email, presence: true, email: true
end
