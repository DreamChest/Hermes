# EmailValidator class, for validating user email
# @author Quentin Sonrel
class EmailValidator < ActiveModel::EachValidator
  # Validate attributes (mandatory from EachValidator)
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || 'is not an email') unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end
end
