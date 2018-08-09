require 'test_helper'

class ContentTest < ActiveSupport::TestCase
  test 'contents validity' do
    assert_valid(contents(:valid))
  end

  test 'html presence' do
    assert_invalid(contents(:missing_html))
  end
end
