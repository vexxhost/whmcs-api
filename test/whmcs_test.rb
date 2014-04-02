require_relative 'test_helper'

class WHMCSTest < Test::Unit::TestCase
  def test__EncDecPassword__returningCorrectVal
    # ensuring encrypted password returns '=' at the end
    test = "test13413412asdfasdflkhjasdf"

    result    = WHMCS::Misc.encrypt_password(:password2 => test)
    decrypted = WHMCS::Misc.decrypt_password(:password2 => result['password'])

    assert_equal(decrypted['password'], test)
    assert_equal(result['result'], decrypted['result']) 
  end

  def test__EncryptWithEqualSign__parsedCorrectly
    
    expected = "result=succes;password=12lkjdfosifusdlfsdfmlasdof==;"
    parsed = WHMCS::Base.parse_response(expected)
    assert_equal('12lkjdfosifusdlfsdfmlasdof==', parsed['password'])
  end

end