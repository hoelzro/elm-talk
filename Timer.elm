import Html exposing (Html, text)
import Time exposing (Time, every, second)

type alias Model = Time
type Message = Tick Time

init : (Model, Cmd Message)
init = (0, Cmd.none)

update : Message -> Model -> (Model, Cmd Message)
update (Tick t) _ = (t, Cmd.none)

subscriptions : Model -> Sub Message
subscriptions _ = every second Tick

view : model -> Html a
view t = text <| toString t
-- "text <| toString t" is shorthand for "text (toString t)"

main : Program Never Model Message
main = Html.program {
    init = init,
    update = update,
    subscriptions = subscriptions,
    view = view
  }
