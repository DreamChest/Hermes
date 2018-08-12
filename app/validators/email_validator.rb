# EmailValidator class, for validating user email
# @author Quentin Sonrel
class EmailValidator < ActiveModel::EachValidator
  # Validate attributes (mandatory from EachValidator)
  # @param record record on which to perform validation
  # @param attribute attribute to validate
  # @param value value to validate
  def validate_each(record, attribute, value)
    error = (options[:message] || 'is not an email')
    regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    record.errors[attribute] << error unless value =~ regex
  end
end
