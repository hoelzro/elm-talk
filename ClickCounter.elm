import Graphics.Element exposing (Element, leftAligned)
import Text exposing (fromString)
import Mouse

update : () -> Int -> Int
update _ currentValue =
  currentValue + 1

main : Signal Element
main =
  Signal.map (\clicks -> leftAligned <| fromString <| toString t)
    <| Signal.foldp update 0 Mouse.clicks
