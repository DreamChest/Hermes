require 'test_helper'

class TagTest < ActiveSupport::TestCase
  test 'validations valid' do
    1.upto(5) { |i| assert(tags("tag_#{i}").valid?) }
  end

  test 'validation attribute presence' do
    assert_not(tags(:missing_name).valid?)
  end

  test 'validations attribute uniqueness' do
    tags(:duplicate_base, :duplicate_name).each do |t|
      assert_not(t.valid?)
    end
  end

  test 'validations name validity' do
    assert_not(tags(:invalid_name).valid?)
  end

  test 'source filtering' do
    sources(:source_1).tag([tags(:tag_1)])

    assert_includes(Tag.filter_by_source(sources(:source_1)), tags(:tag_1))
  end

  test 'tags cleaning' do
    sources(:source_1).tag([tags(:tag_1)])
    Tag.clean

    assert_equal(1, Tag.count)
  end
end
