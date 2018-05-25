# FeedValidator class, for validating RSS feed URLs
# @author Quentin Sonrel
class FeedValidator < ActiveModel::EachValidator
  # Validate attributes (mandatory from EachValidator)
  def validate_each(record, attribute, value)
    Feedjira::Feed.fetch_and_parse(value)
  rescue StandardError
    record.errors[attribute] << 'must be a valid RSS feed URL'
  end
end
