(* Generated blacklist entity test. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Testutil

let () =
  test "blacklist.entity_instance" (fun () ->
      let client = Sdk_client.test () in
      let ent = Sdk_client.blacklist client Noval in
      check_str "name" ent.e_name "blacklist")

let () =
  test "blacklist.seeded_ops" (fun () ->
      let record = jo [("id", Str "blacklist01")] in
      let seed = jo [("blacklist",
                      jo [("blacklist01", record)])] in
      let client = Sdk_client.test_with (jo [("entity", seed)]) Noval in
      let ent = Sdk_client.blacklist client Noval in
      ignore ent;
      let loaded = ent.e_load (jo [("id", Str "blacklist01")]) Noval in
      let loaded_data = loaded.e_data_get () in
      check "load data is a map" (ismap loaded_data);
      check_vstr "load id" (getp loaded_data "id") "blacklist01";
      ())
