(* Generated mfa_code entity test. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Testutil

let () =
  test "mfa_code.entity_instance" (fun () ->
      let client = Sdk_client.test () in
      let ent = Sdk_client.mfa_code client Noval in
      check_str "name" ent.e_name "mfa_code")
