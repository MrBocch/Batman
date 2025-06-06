module Subscriptions exposing (subscriptions)

import Model exposing (Model)
import Msg exposing (Msg(..))
import Ports

import Browser.Events
import Json.Decode exposing (..)

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Ports.realtimeEvent GotRealtimeEvent
        , Browser.Events.onKeyDown (Json.Decode.map KeyPressed keyDecoder)
        ]

keyDecoder : Json.Decode.Decoder String
keyDecoder =
    Json.Decode.field "key" Json.Decode.string
