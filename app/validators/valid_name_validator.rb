# ValidNameValidator class, for validating Tag name
# @author Quentin Sonrel
class ValidNameValidator < ActiveModel::EachValidator
  # Validate attributes (mandatory from EachValidator)
  def validate_each(record, attribute, value)
    record.errors[attribute] << 'must have a different value' if value == 'clean'
  end
end
