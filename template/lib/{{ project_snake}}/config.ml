(** Configuration of the connection *)

let url = "localhost"

let port = 5432

let database = "{{ project_snake }}"

let connection_uri = Printf.sprintf "postgresql://%s:%i/%s" url port database