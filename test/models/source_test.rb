require 'test_helper'

class SourceTest < ActiveSupport::TestCase
  test 'validations' do
    assert(sources(:valid).valid?)

    sources(:missing_user, :missing_name, :missing_url).each do |s|
      assert_not(s.valid?)
    end

    assert(sources(:duplicate_step1).valid?)
  end
end
