# Contactstrash entity test (offline, mock transport)

defmodule Smsapi.ContactstrashEntityTest do
  use ExUnit.Case

  test "should create instance" do
    sdk = Smsapi.test()
    ent = Smsapi.contactstrash(sdk)
    assert ent != nil
  end
end
