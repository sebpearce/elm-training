module App exposing (..)

import Html exposing (..)
import Html.App exposing (program)
import Time exposing (..)
import Date exposing (..)
import String

main = program { init = init, view = view, update = update, subscriptions = subscriptions }

subscriptions a = every Time.second Update

init : (Model, Cmd Msg)
init = ({ theTime = 0.0 }, Cmd.none)

-- MODEL

type alias Model = {
  theTime : Time
}


-- UPDATE

type Msg = Reset
         | Update Time

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Reset -> (model, Cmd.none)
    Update newTime -> ({ model | theTime = newTime }, Cmd.none)

-- VIEW

view : Model -> Html Msg
view model =
  div [] [text ( formatTime model.theTime ) ]


formatTime : Time -> String
formatTime time =
  let a = [ Date.hour (Date.fromTime time)
          , Date.minute (Date.fromTime time)
          , Date.second (Date.fromTime time)
          ]
      components = (List.map padWithZeros (List.map toString a))
  in
    String.join ":" components

padWithZeros : String -> String
padWithZeros string =
  String.padLeft 2 '0' string
