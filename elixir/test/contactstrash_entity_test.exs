# Contactstrash entity test (offline, mock transport)

defmodule Smsapi.ContactstrashEntityTest do
  use ExUnit.Case

  alias Voxgig.Struct, as: S
  alias Smsapi.Helpers, as: H
  alias Smsapi.Json

  defp fixture do
    Json.parse(File.read!("../.sdk/test/entity/contactstrash/ContactstrashTestData.json"))
  end

  defp mk_sdk do
    existing = H.or_(S.getpath(fixture(), "existing"), S.jm([]))
    Smsapi.test(S.jm(["entity", existing]))
  end

  defp first_id do
    existing = H.or_(S.getpath(fixture(), "existing.contactstrash"), S.jm([]))
    keys = S.keysof(existing)
    if keys == [], do: nil, else: hd(keys)
  end

  test "should create instance" do
    sdk = Smsapi.test()
    ent = Smsapi.contactstrash(sdk)
    assert ent != nil
  end
end
