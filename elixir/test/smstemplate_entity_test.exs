# Smstemplate entity test (offline, mock transport)

defmodule Smsapi.SmstemplateEntityTest do
  use ExUnit.Case

  alias Voxgig.Struct, as: S

  test "should create instance" do
    sdk = Smsapi.test()
    ent = Smsapi.smstemplate(sdk)
    assert ent != nil
  end

  test "should refuse an invalid request" do
    if Smsapi.FeatureHarness.has_feature("validate") do
      client = Smsapi.test(nil, S.jm(["feature", S.jm(["validate", S.jm(["active", true])])]))

      err =
        assert_raise Smsapi.Error, fn ->
          Smsapi.Entity.Smstemplate.remove(Smsapi.smstemplate(client), S.jm(["id", 1]))
        end

      assert err.code == "validate_failed"
    end
  end
end
