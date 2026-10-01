-- Smsapi SDK exists test

local sdk = require("smsapi_sdk")

describe("SmsapiSDK", function()
  it("should create test SDK", function()
    local testsdk = sdk.test(nil, nil)
    assert.is_not_nil(testsdk)
  end)
end)
