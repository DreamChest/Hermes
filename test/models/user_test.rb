require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'users validity' do
    assert_valid(users(:valid))
    100.upto(200) { |i| assert_valid(users("user_#{i}")) }
  end

  test 'password presence' do
    assert_invalid(users(:missing_password))
  end

  test 'email presence' do
    assert_invalid(users(:missing_email))
  end

  test 'email uniqueness' do
    users(:duplicate_email1, :duplicate_email2).each { |u| assert_invalid(u) }
  end

  test 'email validity' do
    assert_invalid(users(:invalid_email))
  end

  test 'tags string parsing' do
    user = users(:user_100)
    tags_string = 'tag1 tag2'

    assert_count(2, user.tags.parse_str(tags_string))
    user.tags.parse_str(tags_string).each { |t| assert_includes(user.tags, t) }
  end
end
