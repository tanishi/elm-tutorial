module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }
