# EmailValidator class, for validating User email
# @author Quentin Sonrel
class EmailValidator < ActiveModel::EachValidator
  # Validate attributes (mandatory from EachValidator)
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || 'is not an email') unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end
end

# User class, describes an authentifiable user for the API
# @author Quentin Sonrel
class User < ApplicationRecord
  has_secure_password

  has_many :sources
  has_many :tags

  validates :email, presence: true, email: true
end
