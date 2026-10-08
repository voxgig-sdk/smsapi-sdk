(* Generated sent_rcs_message entity test. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Testutil

let () =
  test "sent_rcs_message.entity_instance" (fun () ->
      let client = Sdk_client.test () in
      let ent = Sdk_client.sent_rcs_message client Noval in
      check_str "name" ent.e_name "sent_rcs_message")

let () =
  test "sent_rcs_message.validate" (fun () ->
      if Harness.has_feature "validate" then begin
        let client = Sdk_client.test_with Noval
            (jo [("feature", jo [("validate", jo [("active", Bool true)])])]) in
        let ent = Sdk_client.sent_rcs_message client Noval in
        let err = (try ignore (ent.e_create (jo [("phone_number", Num 1.); ("sender", Str "x")]) Noval); None with e -> Some e) in
        check_str "validate refuses an invalid request"
          (match err with Some (Sdk_error_exc er) -> er.err_code | _ -> "<no SDK error>") "validate_failed"
      end)
