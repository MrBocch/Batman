module Model exposing (Model, init)

import Msg exposing (Msg(..))

type alias Model =
    { messages : List String
    , sentMessages : List String
    , inputText : String
    }

initModel : Model
initModel =
    { messages = []
    , sentMessages = []
    , inputText = ""
    }

init : () -> (Model, Cmd Msg)
init _ = (initModel, Cmd.none)
