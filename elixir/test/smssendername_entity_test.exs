# Smssendername entity test (offline, mock transport)

defmodule Smsapi.SmssendernameEntityTest do
  use ExUnit.Case

  alias Voxgig.Struct, as: S

  test "should create instance" do
    sdk = Smsapi.test()
    ent = Smsapi.smssendername(sdk)
    assert ent != nil
  end

  test "should refuse an invalid request" do
    if Smsapi.FeatureHarness.has_feature("validate") do
      client = Smsapi.test(nil, S.jm(["feature", S.jm(["validate", S.jm(["active", true])])]))

      err =
        assert_raise Smsapi.Error, fn ->
          Smsapi.Entity.Smssendername.create(Smsapi.smssendername(client), S.jm(["sender", 1]))
        end

      assert err.code == "validate_failed"
    end
  end
end
