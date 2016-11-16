-- vim:fdm=marker

import Color exposing (Color, black, green, red)
import Collage exposing (Form, circle, collage, filled, move)
import Element exposing (Element)
import Html exposing (Html)
import Time exposing (Time)

type alias State = {
  currentX   : Float,
  previousXS : List Float
}

-- {{{ Configuration
framesPerSecond : Float
framesPerSecond = 10.0

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

initialState : State
initialState = {
  currentX   = 0,
  previousXS = [] }

historySize : Int
historySize = 10
--}}}

-- {{{ Code
render : Color -> Int -> Float -> Form
render color size x =
  let y = sin x
  in move (x * xScale, y * yScale) <| filled color <| circle <| toFloat size

view : State -> Html msg
view {currentX, previousXS} =
  let renderedCurrent  = render red currentSize currentX
      renderedPrevious = List.map (render black previousSize) previousXS
  in
    Element.toHtml <| collage width height <| renderedCurrent :: renderedPrevious

update : Time -> State -> (State, Cmd Time)
update _ {currentX, previousXS} =
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

main : Program Never State Time
main = Html.program {
    update = update,
    view = view,
    init = (initialState, Cmd.none),
    subscriptions = always <| Time.every (Time.second / framesPerSecond) identity
  }
-- }}}
