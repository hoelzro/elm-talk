import Html exposing (Html, text)
import Html.App as App
import Http
import Mouse
import Task

type alias Model = {
    clicksThusFar : Int,
    lastResponse : String
  }

type Message = Click | GoodResponse String | BadResponse Http.Error

init : (Model, Cmd Message)
init = ({clicksThusFar = 0, lastResponse = ""}, Cmd.none)

view : Model -> Html a
view {lastResponse, clicksThusFar} = text <| toString (lastResponse, clicksThusFar)

update : Message -> Model -> (Model, Cmd Message)
update message {clicksThusFar, lastResponse} =
  case message of
    Click -> 
      let
        successor = {clicksThusFar = clicksThusFar + 1, lastResponse = lastResponse}
        fetchTask = Http.getString ("http://localhost:5000/fibonacci/" ++ toString (clicksThusFar + 1))
      in
        (successor, Task.perform BadResponse GoodResponse fetchTask)
    BadResponse _ -> ({clicksThusFar = clicksThusFar, lastResponse = lastResponse}, Cmd.none)
    GoodResponse result -> ({clicksThusFar = clicksThusFar, lastResponse = result}, Cmd.none)

subscriptions : Model -> Sub Message
subscriptions _ = Mouse.clicks <| always Click

main : Program Never
main = App.program {
    init = init,
    view = view,
    update = update,
    subscriptions = subscriptions
  }
