(* Type aliases for the sake of documentation and explication *)

type 'err caqti_conn_pool =
  (Caqti_lwt.connection, ([> Caqti_error.connect ] as 'err)) Caqti_lwt.Pool.t

type ('res, 'err) query =
  Caqti_lwt.connection -> ('res, ([< Caqti_error.t ] as 'err)) Result.t Lwt.t

type ('res, 'err) query_result =
  ('res, ([> Caqti_error.call_or_retrieve ] as 'err)) Result.t Lwt.t

val query
  :  (Caqti_lwt.connection
      -> ( 'a
         , [< Caqti_error.t > `Connect_failed `Connect_rejected `Post_connect ]
         )
         Result.t
         Lwt.t)
  -> ('a, string) Lwt_result.t
(** * [query_pool query pool] is the [Ok res] of the [res] obtained by executing
    the database [query], or else the [Error err] reporting the error causing
    the query to fail. *)

(** {{1} API for database migrations } *)

module Migration : sig
  (** Interface for executing database migrations *)

  type 'a migration_error =
    [< Caqti_error.t > `Connect_failed `Connect_rejected `Post_connect ] as 'a

  type 'a migration_operation =
    Caqti_lwt.connection -> unit -> (unit, 'a migration_error) result Lwt.t

  type 'a migration_step = string * 'a migration_operation

  val execute : _ migration_step list -> (unit, string) result Lwt.t
  (** [execute steps] is [Ok ()] if all the migration tasks in [steps] can be
      executed or [Error err] where [err] explains the reason for failure. *)
end