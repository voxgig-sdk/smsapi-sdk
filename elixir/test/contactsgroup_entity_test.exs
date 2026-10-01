# Contactsgroup entity test (offline, mock transport)

defmodule Smsapi.ContactsgroupEntityTest do
  use ExUnit.Case

  alias Voxgig.Struct, as: S
  alias Smsapi.Helpers, as: H
  alias Smsapi.Json

  defp fixture do
    Json.parse(File.read!("../.sdk/test/entity/contactsgroup/ContactsgroupTestData.json"))
  end

  defp mk_sdk do
    existing = H.or_(S.getpath(fixture(), "existing"), S.jm([]))
    Smsapi.test(S.jm(["entity", existing]))
  end

  defp first_id do
    existing = H.or_(S.getpath(fixture(), "existing.contactsgroup"), S.jm([]))
    keys = S.keysof(existing)
    if keys == [], do: nil, else: hd(keys)
  end

  test "should create instance" do
    sdk = Smsapi.test()
    ent = Smsapi.contactsgroup(sdk)
    assert ent != nil
  end

  test "should list records" do
    sdk = mk_sdk()
    ent = Smsapi.contactsgroup(sdk)
    # The op resolves to one ENTITY per record; the record is reached with
    # data_get. See AGENTS.md "Entity operations return ENTITIES".
    result = Smsapi.Entity.Contactsgroup.list(ent, S.jm([]))
    assert S.islist(result)
    if S.size(result) > 0 do
      Enum.each(0..(S.size(result) - 1), fn i ->
        assert S.ismap(Smsapi.EntityBase.data_get(S.getelem(result, i)))
      end)
    end
  end

  test "should create then read back" do
    sdk = Smsapi.test(S.jm(["entity", S.jm(["contactsgroup", S.jm([])])]))
    ent = Smsapi.contactsgroup(sdk)
    created = Smsapi.Entity.Contactsgroup.create(ent, S.jm(["name", "test-create"]))
    made = Smsapi.EntityBase.data_get(created)
    assert S.ismap(made)
    assert S.getprop(made, "id") != nil
  end
end
