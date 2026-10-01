(* Generated permission entity test. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Testutil

let () =
  test "permission.entity_instance" (fun () ->
      let client = Sdk_client.test () in
      let ent = Sdk_client.permission client Noval in
      check_str "name" ent.e_name "permission")

let () =
  test "permission.seeded_ops" (fun () ->
      let record = jo [("id", Str "permission01")] in
      let seed = jo [("permission",
                      jo [("permission01", record)])] in
      let client = Sdk_client.test_with (jo [("entity", seed)]) Noval in
      let ent = Sdk_client.permission client Noval in
      ignore ent;
      let loaded = ent.e_load (jo [("id", Str "permission01")]) Noval in
      let loaded_data = loaded.e_data_get () in
      check "load data is a map" (ismap loaded_data);
      check_vstr "load id" (getp loaded_data "id") "permission01";
      ())
