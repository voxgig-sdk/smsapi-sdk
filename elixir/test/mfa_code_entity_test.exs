# MfaCode entity test (offline, mock transport)

defmodule Smsapi.MfaCodeEntityTest do
  use ExUnit.Case

  alias Voxgig.Struct, as: S

  test "should create instance" do
    sdk = Smsapi.test()
    ent = Smsapi.mfa_code(sdk)
    assert ent != nil
  end

  test "should create then read back" do
    sdk = Smsapi.test(S.jm(["entity", S.jm(["mfa_code", S.jm([])])]))
    ent = Smsapi.mfa_code(sdk)
    created = Smsapi.Entity.MfaCode.create(ent, S.jm(["name", "test-create"]))
    made = Smsapi.EntityBase.data_get(created)
    assert S.ismap(made)
    assert S.getprop(made, "id") != nil
  end

  test "should refuse an invalid request" do
    if Smsapi.FeatureHarness.has_feature("validate") do
      client = Smsapi.test(nil, S.jm(["feature", S.jm(["validate", S.jm(["active", true])])]))

      err =
        assert_raise Smsapi.Error, fn ->
          Smsapi.Entity.MfaCode.create(Smsapi.mfa_code(client), S.jm(["content", 1, "phone_number", "x"]))
        end

      assert err.code == "validate_failed"
    end
  end
end
