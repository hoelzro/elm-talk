import Graphics.Element exposing (Element, leftAligned)
import Text exposing (fromString)

main : Element
main = leftAligned <| fromString "Hello, World!"
-- "leftAligned <| fromString s" is equivalent to leftAligned (fromString s)
