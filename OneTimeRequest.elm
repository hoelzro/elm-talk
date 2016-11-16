import Html exposing (Html, text)
import Http

type alias Model = Maybe Int
type Msg = HttpResult (Result Http.Error String)

subscriptions : Model -> Sub Msg
subscriptions _ = Sub.none

init : (Model, Cmd Msg)
init =
    let request = Http.getString "http://localhost:5000/fibonacci/5"
    in (Nothing, Http.send HttpResult request)

view : Model -> Html Msg
view model =
  case model of
    Nothing    -> text ""
    Just value -> text <| toString value

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    HttpResult (Ok result) ->
      case String.toInt result of
        Ok newValue -> (Just newValue, Cmd.none)
        Err _ -> (model, Cmd.none)
    HttpResult (Err _) -> (model, Cmd.none)

main : Program Never Model Msg
main = Html.program {
    init = init,
    view = view,
    update = update,
    subscriptions = subscriptions
  }
