require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test 'validations valid' do
    1.upto(50) do |i|
      assert(articles("article_#{i}").valid?)
    end
  end
end
