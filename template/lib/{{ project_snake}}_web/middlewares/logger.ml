open Opium_kernel

let m =
  let open Lwt.Syntax in
  let filter handler req =
    let uri = req.Rock.Request.target |> Uri.of_string |> Uri.path_and_query in
    let* response = handler req in
    let code = Httpaf.Status.to_code response.Rock.Response.status in
    let+ () = Logs_lwt.info (fun m -> m "Responded to '%s' with %d" uri code) in
    response
  in
  Rock.Middleware.create ~name:"Logger" ~filter
