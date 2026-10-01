defmodule Smsapi.ExistsTest do
  use ExUnit.Case

  test "should create test sdk" do
    testsdk = Smsapi.test()
    assert testsdk != nil
  end
end
