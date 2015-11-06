import Graphics.Element exposing (Element, leftAligned)
import Text exposing (fromString)
import Time exposing (every, second)

main : Signal Element
main = Signal.map (\t -> leftAligned <| fromString <| toString t) <| every second
