import Html exposing (Html, text)

view : () -> Html a
view _ = text "Hello, World!"

update _ m = m

main : Program Never () ()
main = Html.beginnerProgram {
    model = (),
    view = view,
    update = update
  }
