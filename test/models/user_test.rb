require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'validations valid' do
    1.upto(100) { |i| assert(users("user_#{i}").valid?) }
  end

  test 'validations attribute presence' do
    assert_not(users(:missing_email).valid?)
  end

  test 'validation email validity' do
    assert_not(users(:invalid_email).valid?)
  end
end
