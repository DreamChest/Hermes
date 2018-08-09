require 'test_helper'

class SourceTest < ActiveSupport::TestCase
  test 'sources validity' do
    assert_valid(sources(:valid))
    assert_valid(sources(:another_valid))
  end

  test 'name presence' do
    assert_invalid(sources(:missing_name))
  end

  test 'url presence' do
    assert_invalid(sources(:missing_url))
  end

  test 'name uniquess' do
    assert_invalid(sources(:duplicate_name))
  end

  test 'url uniquess' do
    assert_invalid(sources(:duplicate_url))
  end

  test 'url is an url' do
    assert_invalid(sources(:invalid_url))
  end

  test 'url is a feed' do
    assert_invalid(sources(:invalid_feed))
  end

  test 'source tagging' do
    source = sources(:valid)
    tags_string = 'tag1 tag2'

    source.update(tags_string: tags_string)

    assert_not_empty(source.tags)
    assert_equal(source.tags, source.user.tags.parse_str(tags_string))
  end

  test 'favicon url default presence' do
    source = sources(:valid)

    source.save

    assert_not_nil(source.favicon_url)
  end

  test 'favicon fetching' do
    source = sources(:valid)

    source.save

    assert_not_nil(source.favicon_path)
    assert(File.exist?("public/#{source.favicon_path}"))
  end

  test 'favicon deletion' do
    source = sources(:valid)

    source.save
    source.destroy

    assert_not(File.exist?("public/#{source.favicon_path}"))
  end

  test 'tags filtering' do
    source = sources(:valid)

    source.update(tags_string: 'tag1 tag2')

    assert_includes(Source.with_tag('tag1'), source)
    assert_includes(Source.with_tag('tag2'), source)
  end

  test 'new articles' do
    assert_not_empty(sources(:valid).new_articles)
  end

  test 'articles update' do
    source = sources(:valid)

    assert(source.update_articles)
    assert_not_empty(source.articles)
  end

  test 'article clearing' do
    source = sources(:valid)

    source.update_articles

    assert(source.clear)
    assert_empty(source.articles)
  end

  test 'source resett' do
    source = sources(:valid)

    source.update_articles

    assert(source.reset)
    assert_empty(source.articles)
    assert_equal(Time.at(0).utc, source.last_update)
  end
end
