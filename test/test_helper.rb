require 'simplecov'
require 'codacy-coverage'

formatters = [SimpleCov::Formatter::HTMLFormatter, Codacy::Formatter]
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(formatters)
SimpleCov.start('rails')

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    NB_USERS = 1

    # Ensures that obj.valid? is true
    # @param obj [Object] Object on which to test validity
    # @param msg [String] Optionnal message in case of error
    def assert_valid(obj, msg = "#{obj.class} should be valid")
      assert(obj.valid?, msg)
    end

    # Ensures that obj.valid? is false
    # @param obj [Object] Object on which to test non validity
    # @param msg [String] Optionnal message in case of error
    def assert_invalid(obj, msg = "#{obj.class} should be invalid")
      assert_not(obj.valid?, msg)
    end

    # Ensures that obj.count == expected
    # @param expected [Integer] expected count of elements in obj
    # @param obj object to count elements from
    def assert_count(expected, obj)
      assert_equal(expected, obj.count)
    end
  end
end
