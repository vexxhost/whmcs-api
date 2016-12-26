require_relative 'test_helper'

class WHMCSBaseTest < Minitest::Test
  def test_parse_response_with_multiple_equal_signs
    response = "result=success;password=12lkjdfosifusdlfsdfmlasdof==;"
    parsed = WHMCS::Base.parse_response(response)

    assert_equal('success', parsed['result'])
    assert_equal('12lkjdfosifusdlfsdfmlasdof==', parsed['password'])
  end

  def test_parse_response_with_html_entities
    response = 'result=success;firstname=Foo&#039;;lastname=Bar'
    parsed = WHMCS::Base.parse_response(response)

    assert_equal('success', parsed['result'])
    assert_equal('Foo\'', parsed['firstname'])
    assert_equal('Bar', parsed['lastname'])
  end

  def test_send_invalid_request
    stub_request(:post, ENV['WHMCS_URL']).
      with(:body => {
        "accesskey" => ENV['WHMCS_KEY'],
        "action" => "do_me_a_favor",
        "password" => ENV['WHMCS_PASS'],
        "username" => ENV['WHMCS_USER']
      }, :headers => {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Content-Type' => 'application/x-www-form-urlencoded',
        'User-Agent' => 'Ruby'
      }).
      to_return(:body => 'result=error;message=Command Not Found;')

    response = WHMCS::Base.send_request(:action => 'do_me_a_favor')

    assert response.is_a?(Hash)
    assert_equal('error', response['result'])
    assert_equal('Command Not Found', response['message'])
  end
end
