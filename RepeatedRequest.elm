import Html exposing (Html, text)
import Http
import Mouse

type alias Model = (Int, Maybe Int)
type Msg = HttpResult (Result Http.Error String) | Click

init : (Model, Cmd Msg)
init = ((0, Nothing), Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions _ = Mouse.clicks <| always Click

view : Model -> Html Msg
view model = text <| toString model

sendRequest : Int -> Cmd Msg
sendRequest clicks =
  let url = "http://localhost:5000/fibonacci/" ++ (toString clicks)
      request = Http.getString url
  in Http.send HttpResult request

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  let (clicks, fib) = model
  in case msg of
    Click -> ((clicks + 1, fib), sendRequest <| clicks + 1)
    HttpResult (Ok result) ->
      case String.toInt result of
        Ok newFib -> ((clicks, Just newFib), Cmd.none)
        Err _ -> (model, Cmd.none)
    HttpResult (Err _) -> (model, Cmd.none)

main : Program Never Model Msg
main = Html.program {
    init = init,
    view = view,
    update = update,
    subscriptions = subscriptions
  }
