require_relative 'test_helper'

class WHMCSBaseTest < Minitest::Test
  # in certain occasions encrypt call returns hash that includes '='
  def test__passwordEncryption
    result = WHMCS::Misc.encrypt_password(:password2 => 'test')

    decrypted = WHMCS::Misc.decrypt_password(:password2 => result['password'])

    assert_equal(decrypted['password'], 'test')
  end

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

end
