open Tyxml.Html
open Helpers
open Context

let main_css =
  match Assets.read "main.css" with
  | Some body ->
    style [ txt body ]
  | None ->
    style []

let main_js =
  match Assets.read "main.js" with
  | Some body ->
    script (txt body)
  | None ->
    script (txt "")

let page_head ~title =
  head
    (Tyxml.Html.title (txt title))
    [ meta ~a:[ a_charset "utf-8" ] ()
    ; meta ~a:[ a_http_equiv "X-UA-Compatible"; a_content "IE=edge" ] ()
    ; meta
        ~a:
          [ a_name "viewport"
          ; a_content "width=device-width, initial-scale=1.0"
          ]
        ()
    ; main_css
    ]

let page_body content =
  body
    [ main [ content ]
    ; main_js
    ]

let make ?(title = "{{ project_name }}") content =
  html (page_head ~title) (page_body content)

let render document = document |> Format.asprintf "%a" (pp ())
