module Main (..) where

import Html exposing (Html)
import Html.Events as Events

type alias Model =
  { count : Int
  }

type Action
  = NoOp
  | MouseClick
  | KeyPress

initialModel : Model
initialModel =
  { count = 0
  }

update : Action -> Model -> Model
update action model =
  case action of
    MouseClick ->
  { model | count = model.count + 1 }

    KeyPress ->
  { model | count = model.count - 1 }

    _ ->
      model


view : Signal.Address Action -> Model -> Html
view address model =
  Html.div
    []
    [ Html.div [] [ Html.text (toString model.count) ]
    , Html.button
      [ Events.onClick address MouseClick ]
      [ Html.text "Increase" ]
    ]

mb : Signal.Mailbox Action
mb =
  Signal.mailbox NoOp

modelSignal : Signal Model
modelSignal =
  Signal.foldp update initialModel mb.signal


main : Signal.Signal Html
main =
  Signal.map (view mb.address) modelSignal
