open Alcotest
open Opium_kernel
open Lwt.Infix

let check_handler_body ~request ~expected handler =
  handler request >>= fun response ->
  Body.to_string response.Rock.Response.body >|= fun body ->
  check string "same string" body expected
