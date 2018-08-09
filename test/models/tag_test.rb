require 'test_helper'

class TagTest < ActiveSupport::TestCase
  test 'tags validity' do
    assert_valid(tags(:valid))
  end

  test 'name presence' do
    assert_invalid(tags(:missing_name))
  end

  test 'name uniquess' do
    tags(:duplicate_name1, :duplicate_name2).each { |t| assert_invalid(t) }
  end

  test 'source filtering' do
    source = sources(:valid)
    tag = tags(:valid)
    user = tag.user

    assert_equal(user, source.user) # The test is irrelevant otherwise

    source.update(tags_string: tag.name)

    assert_includes(user.tags.from_source(source.name), tag)
  end

  test 'tags cleanup' do
    source = sources(:valid)

    assert_empty(Tag.clean)

    source.update(tags_string: 'tag1')

    assert_not_empty(Tag.clean)
  end
end
