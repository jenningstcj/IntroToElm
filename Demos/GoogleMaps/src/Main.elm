import Html exposing (Html, div, p, text, button)
import Html.Events exposing (onClick)
import Html.App
import Time exposing (..)
import Http
import Json.Decode exposing (..)
import Task


import SharedModels exposing (GMPos)
import GMaps exposing (moveMap, mapMoved)


-- MAIN

main : Program Never
main = Html.App.program
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

-- MODEL

type alias Model =
  { pos : GMPos
  , alt : Float
  , vel : Float
  }


type alias ISS_JSON =
    { latitude : Float
    , longitude : Float
    , altitude : Float
    , velocity : Float
    }

-- UPDATE

type Msg
  = MapMoved GMPos
  | FetchSucceed ISS_JSON
  | FetchFail Http.Error
  | FetchPosition Time

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    MapMoved newPos ->
      ( { model | pos = newPos }
      , Cmd.none
      )
    FetchSucceed newISSPos ->
      let
        newPos = GMPos newISSPos.latitude newISSPos.longitude
      in
        ({model | pos = newPos, vel = (kilometersToMiles newISSPos.velocity), alt = (kilometersToMiles newISSPos.altitude) }, moveMap newPos)
    FetchFail _ ->
      (model, Cmd.none)
    FetchPosition time ->
      (model, getLocation)

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ p [] [ text ("Latitude: " ++ toString model.pos.lat)]
    , p [] [text ("Longitude: " ++ toString model.pos.lng)]
    , p [] [text ("Altitude: " ++ toString model.alt ++ " miles")]
    , p [] [text ("Velocity: " ++ toString model.vel ++ " miles per hour")]
    ]


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ mapMoved MapMoved
    , Time.every (5 * second) FetchPosition
    ]


-- Http

getLocation : Cmd Msg
getLocation =
  let
    url = "https://api.wheretheiss.at/v1/satellites/25544"
  in
    Task.perform FetchFail FetchSucceed (Http.get decodeISSPosition url)


decodeISSPosition : Decoder ISS_JSON
decodeISSPosition =
  object4 ISS_JSON
    ("latitude" := float)
    ("longitude" := float)
    ("altitude" := float)
    ("velocity" := float)


kilometersToMiles : Float -> Float
kilometersToMiles km =
  km * 0.62137



-- INIT

init : (Model, Cmd Msg)
init =
  let
    knoxville = ( GMPos 35.9335673 -84.016913 )
  in
    ( Model knoxville 0 0, moveMap knoxville )
