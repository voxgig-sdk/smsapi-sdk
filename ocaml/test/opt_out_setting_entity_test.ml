(* Generated opt_out_setting entity test. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Testutil

let () =
  test "opt_out_setting.entity_instance" (fun () ->
      let client = Sdk_client.test () in
      let ent = Sdk_client.opt_out_setting client Noval in
      check_str "name" ent.e_name "opt_out_setting")

let () =
  test "opt_out_setting.seeded_ops" (fun () ->
      let record = jo [("id", Str "opt_out_setting01")] in
      let seed = jo [("opt_out_setting",
                      jo [("opt_out_setting01", record)])] in
      let client = Sdk_client.test_with (jo [("entity", seed)]) Noval in
      let ent = Sdk_client.opt_out_setting client Noval in
      ignore ent;
      let loaded = ent.e_load (jo [("id", Str "opt_out_setting01")]) Noval in
      let loaded_data = loaded.e_data_get () in
      check "load data is a map" (ismap loaded_data);
      ())
