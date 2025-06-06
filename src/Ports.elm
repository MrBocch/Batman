port module Ports exposing (..)

port realtimeEvent : (String -> msg) -> Sub msg
