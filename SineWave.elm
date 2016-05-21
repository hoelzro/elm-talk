-- vim:fdm=marker

import Color exposing (Color, black, green, red)
import Collage exposing (Form, circle, collage, filled, move)
import Element
import Html exposing (Html)
import Html.App as App
import Time exposing (Time)

type alias Model = {
  currentX   : Float,
  previousXS : List Float
}

type Message = Tick

-- {{{ Configuration
framesPerSecond : Int
framesPerSecond = 10

yScale : Float
yScale = 20.0

xScale : Float
xScale = 20.0

width : Int
width  = 400

height : Int
height = 400

currentSize : Int
currentSize = 5

previousSize : Int
previousSize = 2

xIncrease : Float
xIncrease = pi / 10

initialState : Model
initialState = {
  currentX   = 0,
  previousXS = [] }

historySize : Int
historySize = 10
--}}}

-- {{{ Code
fps : Int -> (Time -> msg) -> Sub msg
fps framesPerSecond = Time.every ((toFloat <| 1000 // framesPerSecond) * Time.millisecond)

render : Color -> Int -> Float -> Form
render color size x =
  let y = sin x
  in move (x * xScale, y * yScale) <| filled color <| circle <| toFloat size

view : Model -> Html Message
view {currentX, previousXS} =
  let renderedCurrent  = render red currentSize currentX
      renderedPrevious = List.map (render black previousSize) previousXS
  in
    Element.toHtml <| collage width height <| renderedCurrent :: renderedPrevious

init : (Model, Cmd Message)
init = (initialState, Cmd.none)

update : Message -> Model -> (Model, Cmd Message)
update Tick {currentX, previousXS} =
  let maxX = (toFloat width) / 2.0
      minX = 0 - maxX
      newX =
        if xScale * (currentX + xIncrease) > maxX
          then minX / xScale
          else currentX + xIncrease
  in
    ({
      currentX   = newX,
      previousXS = currentX :: List.take historySize previousXS
    }, Cmd.none)

subscriptions : Model -> Sub Message
subscriptions _ = fps framesPerSecond <| always Tick

main : Program Never
main = App.program {
    init = init,
    view = view,
    update = update,
    subscriptions = subscriptions
  }
-- }}}
