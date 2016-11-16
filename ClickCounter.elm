import Html exposing (Html, text)
import Mouse

type Message = Click
type alias Model = Int

init : (Model, Cmd Message)
init = (0, Cmd.none)

update : Message -> Model -> (Model, Cmd Message)
update Click numClicks = (numClicks + 1, Cmd.none)

subscriptions : Model -> Sub Message
subscriptions _ = Mouse.clicks <| always Click

view : Model -> Html Message
view numClicks = text <| toString numClicks

main : Program Never Model Message
main = Html.program {
    init = init,
    update = update,
    subscriptions = subscriptions,
    view = view
  }
