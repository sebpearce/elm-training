module App exposing (..)

import Html exposing (..)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onInput)
import String exposing (toList, fromList)
import Char exposing (toCode, fromCode)
import List exposing (map)

main = beginnerProgram { model = initialModel, view = view, update = update }

initialModel : Model
initialModel = {
  word = "wow" }

-- MODEL

type alias Model = {
  word : String
}


-- UPDATE

type Msg = Reset
         | Change String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Reset -> model
    Change newText ->  { model | word = translate newText }


-- VIEW

translate : String -> String
translate src =
  let characters = String.toList src
  in
    String.fromList <| List.map convertToNextChar characters

convertToNextChar : Char -> Char
convertToNextChar input =
  let
    a = Char.toCode input
    b = a + 1
  in
    Char.fromCode b


view : Model -> Html Msg
view model =
  div [] [
    h1 [] [text "Seb's Caesar Cypher"]
    , div [] [ input [onInput Change] [] ]
    , div [] [ text model.word ]
  ]


