module Main exposing (..)

import Html exposing (Html, div, input, text, button, p)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import String
import List as L
import Maybe as M
import Styles


main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }


type alias Model =
    { inputting : String, tasks : List String }


model : Model
model =
    Model "" []


type Msg
    = Input String
    | Save


update : Msg -> Model -> Model
update msg model =
    case msg of
        Input new ->
            { model | inputting = new }

        Save ->
            { model | inputting = "", tasks = (L.append model.tasks [ model.inputting ]) }


view : Model -> Html Msg
view model =
    div [ id "container", style Styles.container ]
        [ input [ onInput Input, value model.inputting ] []
        , div [] [ text model.inputting ]
        , button [ onClick Save ] [ text "save" ]
        , div [] (taskList model.tasks)
        ]


taskList : List String -> List (Html Msg)
taskList x =
    case L.length x of
        0 ->
            []

        _ ->
            (div []
                [ p [] [ text (M.withDefault "" (L.head x)) ]
                , input [ type_ "checkbox" ] []
                ]
            )
                :: (taskList (M.withDefault [] (L.tail x)))
