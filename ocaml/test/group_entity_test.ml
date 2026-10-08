(* Generated group entity test. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Testutil

let () =
  test "group.entity_instance" (fun () ->
      let client = Sdk_client.test () in
      let ent = Sdk_client.group client Noval in
      check_str "name" ent.e_name "group")

let () =
  test "group.seeded_ops" (fun () ->
      let record = jo [("id", Str "group01")] in
      let seed = jo [("group",
                      jo [("group01", record)])] in
      let client = Sdk_client.test_with (jo [("entity", seed)]) Noval in
      let ent = Sdk_client.group client Noval in
      ignore ent;
      let loaded = ent.e_load (jo [("id", Str "group01")]) Noval in
      let loaded_data = loaded.e_data_get () in
      check "load data is a map" (ismap loaded_data);
      check_vstr "load id" (getp loaded_data "id") "group01";
      ())

let () =
  test "group.validate" (fun () ->
      if Harness.has_feature "validate" then begin
        let client = Sdk_client.test_with Noval
            (jo [("feature", jo [("validate", jo [("active", Bool true)])])]) in
        let ent = Sdk_client.group client Noval in
        let err = (try ignore (ent.e_load (jo [("id", Num 1.)]) Noval); None with e -> Some e) in
        check_str "validate refuses an invalid request"
          (match err with Some (Sdk_error_exc er) -> er.err_code | _ -> "<no SDK error>") "validate_failed"
      end)
