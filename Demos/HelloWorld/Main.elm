module Main exposing (..)

import Html exposing (..)
import Html.App
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


main =
    Html.App.beginnerProgram
        { model = { statement = "Hello World", size = 14 }
        , update = update
        , view = view
        }


update msg model =
    model


view model =
    div []
        [ p [ size model.size ] [ text model.statement ]
        ]


size : Int -> Html.Attribute msg
size num =
    style [ ( "fontSize", (toString num) ++ "pt" ) ]
