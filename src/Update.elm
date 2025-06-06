module Update exposing (update)

import Url exposing (baseUrl)
import Http
import Json.Encode

import Model exposing (Model)
import Msg exposing (Msg(..))


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        GotRealtimeEvent s ->
            ( { model | messages = List.append model.messages [s] }
            , Cmd.none
            )

        KeyPressed char ->
            let
                newModel =
                    case char of
                        "Backspace" -> { model | inputText = String.dropRight 1 model.inputText }
                        "CapsLock" -> model
                        "Shift" -> model
                        "Escape" -> model
                        "Alt" -> model
                        "Control" -> model
                        "Meta" -> model
                        "Tab" -> { model | inputText = (model.inputText ++ "  ") }
                        "Enter" -> { model | inputText = "", sentMessages = List.append model.sentMessages [model.inputText] } -- also sends the command
                        _ -> { model | inputText = ( String.toUpper (model.inputText ++ char) ) }

                newCmd = if char == "Enter" then
                            createPost model.inputText
                            else
                            Cmd.none
            in
            ( newModel
            , newCmd
            )

        _ -> (model, Cmd.none)


createPost : String -> Cmd Msg
createPost content =
    let
        body =
            Http.jsonBody <|
                Json.Encode.object
                    [ ( "Text", Json.Encode.string content )
                    ]
    in
    Http.request
        { method = "POST"
        , headers = []
        , url = (baseUrl ++ "api/collections/posts/records")
        , body = body
        , expect = Http.expectWhatever GotPostResponse
        , timeout = Nothing
        , tracker = Nothing
        }

-- when you send a POST to posts collection, it will then
-- send a SSE to everyone listening to the collection, including
-- the same client which sent the message.

-- what i want is everyone else to have a <?> prepended to their message
-- and the client could not see that for their own messages
-- that should be handled from the view
-- (set theory) what i want is the difference between [1,2,3] \ [1,2] -> [3] prepend "<?>" to 3
-- elm comes with Set datastructure that lets you do that
-- i want to just List.member for now
