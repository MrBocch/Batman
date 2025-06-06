module Main exposing (main, baseUrl)

import Browser

import Model exposing (init)
import View exposing (view)
import Update exposing (update)
import Subscriptions exposing (subscriptions)

baseUrl = "http://localhost:8090/"


main = Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
