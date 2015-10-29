import Http

import Graphics.Element exposing (Element, leftAligned, show)
import Mouse
import Task exposing (Task, andThen)

clicksThusFar : Signal Int
clicksThusFar = Signal.foldp (\_ count -> count + 1) 0 Mouse.clicks

fibMailbox : Signal.Mailbox String
fibMailbox = Signal.mailbox ""

fibTask : Int -> Task Http.Error ()
fibTask input =
  let url      = "http://localhost:5000/fibonacci/" ++ (toString input)
      httpTask = Http.getString url
      sendTask = Signal.send fibMailbox.address
  in httpTask `andThen` sendTask

port getFib : Signal (Task Http.Error ())
port getFib = Signal.map fibTask clicksThusFar

view : Int -> String -> Element
view clicks fibResult =
  show (clicks, fibResult)

main : Signal Element
main = Signal.map2 view clicksThusFar fibMailbox.signal
