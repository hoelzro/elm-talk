import Html exposing (Html, text)
import Html.App as App
import Http
import Task

type alias Model = String
type Message = GoodResponse String | BadResponse Http.Error

view : Model-> Html a
view model = text model

init : (Model, Cmd Message)
init =
    let fetchTask = Http.getString "http://localhost:5000/fibonacci/5"
    in ("", Task.perform BadResponse GoodResponse fetchTask)

update : Message -> Model -> (Model, Cmd Message)
update message model =
  case message of
    GoodResponse result -> (result, Cmd.none)
    BadResponse _ -> (model, Cmd.none)

subscriptions : Model -> Sub Message
subscriptions _ = Sub.none

main : Program Never
main = App.program {
    init = init,
    view = view,
    update = update,
    subscriptions = subscriptions
  }
