require 'test_helper'

class SourceTest < ActiveSupport::TestCase
  test 'validations valid' do
    1.upto(5) { |i| assert(sources("source_#{i}").valid?) }
  end

  test 'validations attributes presence' do
    sources(:missing_user, :missing_name, :missing_url).each do |s|
      assert_not(s.valid?)
    end
  end

  test 'validations attributes uniqueness' do
    sources(:duplicate_base, :duplicate_name, :duplicate_url).each do |s|
      assert_not(s.valid?)
    end
  end

  test 'validations URL validity' do
    sources(:url_not_url, :url_not_feed).each { |s| assert_not(s.valid?) }
  end

  test 'tags attribution' do
    sources(:source_1).tag(tags(:tag_1, :tag_2))

    assert_equal(2, sources(:source_1).tags.count)
    assert_includes(sources(:source_1).tags, tags(:tag_1))
    assert_includes(sources(:source_1).tags, tags(:tag_2))
  end

  test 'tag filtering' do
    sources(:source_1).tag([tags(:tag_1)])

    assert_includes(Source.filter_by_tag(tags(:tag_1)), sources(:source_1))
  end

  test 'feed fetching' do
    assert(sources(:source_1).fetch)
    assert_not_nil(sources(:source_1).feed)
  end

  test 'feed extraction' do
    sources(:source_1).fetch

    assert_instance_of(Array, sources(:source_1).extract)
    assert_not_empty(sources(:source_1).extract)
  end

  test 'feed articles saving' do
    sources(:source_1).fetch
    sources(:source_1).extract

    assert(sources(:source_1).save_articles)
    assert_not_empty(sources(:source_1).articles)
    assert_includes(sources(:source_1).articles, sources(:source_1).new_articles.sample)
  end

  test 'source clearing' do
    sources(:source_1).fetch
    sources(:source_1).extract
    sources(:source_1).save_articles
    sources(:source_1).clear

    assert_empty(sources(:source_1).articles)
  end

  test 'source reseting' do
    sources(:source_1).fetch
    sources(:source_1).extract
    sources(:source_1).save_articles
    sources(:source_1).reset

    assert_equal(Time.at(0).utc, sources(:source_1).last_update)
  end
end
