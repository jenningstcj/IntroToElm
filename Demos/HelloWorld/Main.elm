module Main exposing (..)

import Html exposing (..)
import Html.App
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


main =
    Html.App.beginnerProgram
        { model = { statement = "hello", size = 14 }
        , update = update
        , view = view
        }


type Msg
    = Increase
    | Decrease


update msg model =
    case msg of
        Increase ->
            { model | size = model.size + 2 }

        Decrease ->
            { model | size = model.size - 2 }


view model =
    div [ style [ ( "fontSize", (toString model.size) ++ "pt" ) ] ]
        [ text (model.statement ++ " world!")
        , div []
            [ button [ onClick Increase ] [ text "Increase" ]
            , button [ onClick Decrease ] [ text "Decrease" ]
            ]
        ]
