open Opium_kernel

let index _req =
  Lwt.return
  @@ Rock.Response.make
       ~body:(Body.of_string (Views.Page.index ()))
       ~status:`OK
       ()