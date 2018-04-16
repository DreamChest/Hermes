# User class, describes an authentifiable user for the API
# @author Quentin Sonrel
class User < ApplicationRecord
  has_secure_password

  has_many :sources
end
