# EmailValidator class, for validating user email
# @author Quentin Sonrel
class EmailValidator < ActiveModel::EachValidator
  # Validate attributes (mandatory from EachValidator)
  def validate_each(record, attribute, value)
    error = (options[:message] || 'is not an email')
    regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    record.errors[attribute] << error unless value =~ regex
  end
end
