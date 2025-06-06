module Msg exposing (Msg(..))

import Http

type Msg
    = UpdateString String
    | KeyPressed String
    | GotRealtimeEvent String
    | GotPostResponse (Result Http.Error ())
