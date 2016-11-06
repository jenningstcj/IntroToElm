module Main exposing (..)

import Html exposing (..)
import Html.App
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import String


main =
    Html.App.beginnerProgram
        { model = { statement = "Hello World" }
        , update = update
        , view = view
        }


update msg model =
    model


view model =
    div []
        [ p [] [ text model.statement ]
        ]
