open Tyxml.Html

let index () =
  h1 [ txt "Welcome !" ] |> Layout.make |> Layout.render
