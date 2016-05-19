import Html exposing (Html, text)
import Html.App as App

view : () -> Html a
view _ = text "Hello, World!"

update _ m = m

main : Program Never
main = App.beginnerProgram {
    model = (),
    view = view,
    update = update
  }
