require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test 'articles validity' do
    assert_valid(articles(:valid))
    assert_valid(articles(:another_valid))
    articles(:date_1, :date_2, :date_3).each { |a| assert_valid(a) }
  end

  test 'title presence' do
    assert_invalid(articles(:missing_title))
  end

  test 'date presence' do
    assert_invalid(articles(:missing_date))
  end

  test 'url presence' do
    assert_invalid(articles(:missing_url))
  end

  test 'filtering since date' do
    date1 = articles(:date_1)
    date2 = articles(:date_2)
    date3 = articles(:date_3)
    filtered = Article.since(date2.date)

    assert_not_includes(filtered, date1)
    assert_includes(filtered, date2)
    assert_includes(filtered, date3)
  end

  test 'filtering until date' do
    date1 = articles(:date_1)
    date2 = articles(:date_2)
    date3 = articles(:date_3)
    filtered = Article.until(date2.date)

    assert_includes(filtered, date1)
    assert_includes(filtered, date2)
    assert_not_includes(filtered, date3)
  end

  test 'sources filtering' do
    source1 = sources(:valid)
    source2 = sources(:another_valid)
    article1 = articles(:valid)
    article2 = articles(:another_valid)

    assert_includes(Article.from_sources(source1.name), article1)
    assert_not_includes(Article.from_sources(source1.name), article2)
    assert_includes(Article.from_sources(source2.name), article2)
    assert_not_includes(Article.from_sources(source2.name), article1)
  end

  test 'tags filtering' do
    source1 = sources(:valid)
    source2 = sources(:another_valid)
    article1 = articles(:valid)
    article2 = articles(:another_valid)

    source1.update(tags_string: 'tag1')
    source2.update(tags_string: 'tag2')

    assert_includes(Article.with_tags('tag1'), article1)
    assert_not_includes(Article.with_tags('tag1'), article2)
    assert_includes(Article.with_tags('tag2'), article2)
    assert_not_includes(Article.with_tags('tag2'), article1)
  end
end
