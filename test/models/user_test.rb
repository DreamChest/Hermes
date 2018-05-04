require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'validations' do
    assert(users(:valid).valid?)
    assert_not(users(:missing_email).valid?)
    assert_not(users(:invalid_email).valid?)
  end
end
