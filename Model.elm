module Main (..) where

import Html exposing (Html)
import Mouse

type alias Model =
  { count : Int
  }

initialModel : Model
initialModel =
  { count = 0
  }

update : () -> Model -> Model
update _ model =
  { model | count = model.count + 1
  }


view : Model -> Html
view model =
  Html.text (toString model.count)


modelSignal : Signal Model
modelSignal =
  Signal.foldp update initialModel Mouse.clicks


main : Signal.Signal Html
main =
  Signal.map view modelSignal
