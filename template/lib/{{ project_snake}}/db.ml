type 'err caqti_conn_pool =
  (Caqti_lwt.connection, ([> Caqti_error.connect ] as 'err)) Caqti_lwt.Pool.t

type ('res, 'err) query =
  Caqti_lwt.connection -> ('res, ([< Caqti_error.t ] as 'err)) Result.t Lwt.t

type ('res, 'err) query_result =
  ('res, ([> Caqti_error.call_or_retrieve ] as 'err)) Result.t Lwt.t

let connect () =
  Config.connection_uri |> Uri.of_string |> Caqti_lwt.connect_pool ~max_size:10
  |> function
  | Ok pool ->
    pool
  | Error err ->
    failwith (Caqti_error.show err)

let pool = connect ()

let query query =
  Caqti_lwt.Pool.use query pool |> Lwt_result.map_err Caqti_error.show

module Migration = struct
  type 'a migration_error =
    [< Caqti_error.t > `Connect_failed `Connect_rejected `Post_connect ] as 'a

  type 'a migration_operation =
    Caqti_lwt.connection -> unit -> (unit, 'a migration_error) Result.t Lwt.t

  type 'a migration_step = string * 'a migration_operation

  let execute migrations =
    let open Lwt in
    let rec run migrations =
      match migrations with
      | [] ->
        Lwt_result.return ()
      | (name, migration) :: migrations ->
        Lwt_io.printf "Running: %s\n" name >>= fun () ->
        query (fun c -> migration c ()) >>= ( function
        | Ok () ->
          run migrations
        | Error err ->
          return (Error err) )
    in
    run migrations
end