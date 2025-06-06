module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)

import Model exposing (Model)
import Msg exposing (Msg(..))


view : Model -> Html Msg
view model =
    div []
        [div [ class "chat" ] (List.map (\s -> p [ class "text" ] [text s] ) (prependQuestionmark model) )
        , span [ class "text" ] [ text ("> " ++ model.inputText) ]
        ]

prependQuestionmark : Model -> List String
prependQuestionmark model =
    model.messages |>
    List.map
        (\s -> if List.member s model.sentMessages then ">>> " ++ s else "<?> " ++ s) -- watchout, HTML strips whitespace
