# Smsdo entity test (offline, mock transport)

defmodule Smsapi.SmsdoEntityTest do
  use ExUnit.Case

  alias Voxgig.Struct, as: S
  alias Smsapi.Helpers, as: H
  alias Smsapi.Json

  defp fixture do
    Json.parse(File.read!("../.sdk/test/entity/smsdo/SmsdoTestData.json"))
  end

  defp mk_sdk do
    existing = H.or_(S.getpath(fixture(), "existing"), S.jm([]))
    Smsapi.test(S.jm(["entity", existing]))
  end

  defp first_id do
    existing = H.or_(S.getpath(fixture(), "existing.smsdo"), S.jm([]))
    keys = S.keysof(existing)
    if keys == [], do: nil, else: hd(keys)
  end

  test "should create instance" do
    sdk = Smsapi.test()
    ent = Smsapi.smsdo(sdk)
    assert ent != nil
  end

  test "should create then read back" do
    sdk = Smsapi.test(S.jm(["entity", S.jm(["smsdo", S.jm([])])]))
    ent = Smsapi.smsdo(sdk)
    created = Smsapi.Entity.Smsdo.create(ent, S.jm(["name", "test-create"]))
    made = Smsapi.EntityBase.data_get(created)
    assert S.ismap(made)
    assert S.getprop(made, "id") != nil
  end
end
