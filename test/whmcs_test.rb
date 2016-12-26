require_relative 'test_helper'

class WHMCSTest < Minitest::Test
  def test__send_request__returningHash
    resulted = WHMCS::Base.send_request(:action => 'do_me_a_favor')
    assert resulted.is_a?(Hash)
    assert_equal('Command Not Found', resulted['message'])
  end
end
