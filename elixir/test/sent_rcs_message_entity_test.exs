# SentRcsMessage entity test (offline, mock transport)

defmodule Smsapi.SentRcsMessageEntityTest do
  use ExUnit.Case

  alias Voxgig.Struct, as: S

  test "should create instance" do
    sdk = Smsapi.test()
    ent = Smsapi.sent_rcs_message(sdk)
    assert ent != nil
  end

  test "should create then read back" do
    sdk = Smsapi.test(S.jm(["entity", S.jm(["sent_rcs_message", S.jm([])])]))
    ent = Smsapi.sent_rcs_message(sdk)
    created = Smsapi.Entity.SentRcsMessage.create(ent, S.jm(["name", "test-create"]))
    made = Smsapi.EntityBase.data_get(created)
    assert S.ismap(made)
    assert S.getprop(made, "id") != nil
  end

  test "should refuse an invalid request" do
    if Smsapi.FeatureHarness.has_feature("validate") do
      client = Smsapi.test(nil, S.jm(["feature", S.jm(["validate", S.jm(["active", true])])]))

      err =
        assert_raise Smsapi.Error, fn ->
          Smsapi.Entity.SentRcsMessage.create(Smsapi.sent_rcs_message(client), S.jm(["phone_number", 1, "sender", "x"]))
        end

      assert err.code == "validate_failed"
    end
  end
end
