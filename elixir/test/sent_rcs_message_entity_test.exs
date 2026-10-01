# SentRcsMessage entity test (offline, mock transport)

defmodule Smsapi.SentRcsMessageEntityTest do
  use ExUnit.Case

  alias Voxgig.Struct, as: S
  alias Smsapi.Helpers, as: H
  alias Smsapi.Json

  defp fixture do
    Json.parse(File.read!("../.sdk/test/entity/sent_rcs_message/SentRcsMessageTestData.json"))
  end

  defp mk_sdk do
    existing = H.or_(S.getpath(fixture(), "existing"), S.jm([]))
    Smsapi.test(S.jm(["entity", existing]))
  end

  defp first_id do
    existing = H.or_(S.getpath(fixture(), "existing.sent_rcs_message"), S.jm([]))
    keys = S.keysof(existing)
    if keys == [], do: nil, else: hd(keys)
  end

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
end
