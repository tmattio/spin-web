open Opium_kernel
let router = Router.create ()

(** The router of the application.
    It will try to match the requested URI with one of the defined route. If it
    finds a match, it will call the appropriate handler. If no route is found,
    it will call the default handler. *)
let m = Router.m router
