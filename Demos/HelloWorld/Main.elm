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
    case msg of
        _ ->
            model
--}


view model =
    div []
        [ span [ style [ ( "fontSize", (toString model.size) ++ "pt" ) ] ] [ text model.statement ] ]
