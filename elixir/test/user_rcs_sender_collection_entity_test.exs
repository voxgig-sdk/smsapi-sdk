# UserRcsSenderCollection entity test (offline, mock transport)

defmodule Smsapi.UserRcsSenderCollectionEntityTest do
  use ExUnit.Case

  alias Voxgig.Struct, as: S
  alias Smsapi.Helpers, as: H
  alias Smsapi.Json

  defp fixture do
    Json.parse(File.read!("../.sdk/test/entity/user_rcs_sender_collection/UserRcsSenderCollectionTestData.json"))
  end

  defp mk_sdk do
    existing = H.or_(S.getpath(fixture(), "existing"), S.jm([]))
    Smsapi.test(S.jm(["entity", existing]))
  end

  defp first_id do
    existing = H.or_(S.getpath(fixture(), "existing.user_rcs_sender_collection"), S.jm([]))
    keys = S.keysof(existing)
    if keys == [], do: nil, else: hd(keys)
  end

  test "should create instance" do
    sdk = Smsapi.test()
    ent = Smsapi.user_rcs_sender_collection(sdk)
    assert ent != nil
  end

  test "should list records" do
    sdk = mk_sdk()
    ent = Smsapi.user_rcs_sender_collection(sdk)
    # The op resolves to one ENTITY per record; the record is reached with
    # data_get. See AGENTS.md "Entity operations return ENTITIES".
    result = Smsapi.Entity.UserRcsSenderCollection.list(ent, S.jm([]))
    assert S.islist(result)
    if S.size(result) > 0 do
      Enum.each(0..(S.size(result) - 1), fn i ->
        assert S.ismap(Smsapi.EntityBase.data_get(S.getelem(result, i)))
      end)
    end
  end
end
