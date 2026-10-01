# Smsapi SDK exists test

require "minitest/autorun"
require_relative "../Smsapi_sdk"

class ExistsTest < Minitest::Test
  def test_create_test_sdk
    testsdk = SmsapiSDK.test(nil, nil)
    assert !testsdk.nil?
  end
end
