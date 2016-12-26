require_relative 'test_helper'

class WHMCSBaseTest < Minitest::Test
  def test_encrypt_password
    stub_request(:post, ENV['WHMCS_URL']).
      with(:body => {
        "accesskey" => ENV['WHMCS_KEY'],
        "action" => "encryptpassword",
        "password" => ENV['WHMCS_PASS'],
        "password2" => "test",
        "username" => ENV['WHMCS_USER']
      }, :headers => {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Content-Type' => 'application/x-www-form-urlencoded',
        'User-Agent' => 'Ruby'
      }).
      to_return(:body => 'result=success;password=12lkjdfosifusdlfsdfmlasdof==;')

    response = WHMCS::Misc.encrypt_password(:password2 => 'test')

    assert_equal('success', response['result'])
    assert_equal('12lkjdfosifusdlfsdfmlasdof==', response['password'])
  end
end
