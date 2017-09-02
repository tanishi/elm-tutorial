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
    { title : String, description : String, todoList : TodoList }


type alias Todo =
    { title : String
    , description : String
    , done : Bool
    }


type alias TodoList =
    List Todo


model : Model
model =
    Model "" "" []


type Msg
    = Title String
    | Description String
    | Create


update : Msg -> Model -> Model
update msg model =
    case msg of
        Title title ->
            { model | title = title }

        Description description ->
            { model | description = description }

        Create ->
            { model | todoList = (L.append model.todoList [ Todo model.title model.description False ]) }


view : Model -> Html Msg
view model =
    div [ id "container", style Styles.container ]
        [ div []
            [ input [ placeholder "Title", onInput Title ] []
            , input [ placeholder "Description", onInput Description ] []
            , button [ onClick Create ] [ text "Create ToDo" ]
            ]
        , div [] (todoList model.todoList)
        ]


todoList : TodoList -> List (Html Msg)
todoList xs =
    case L.length xs of
        0 ->
            []

        _ ->
            (div []
                [ (M.withDefault (Todo "" "" False) (L.head xs)) |> \todo -> text todo.title
                , (M.withDefault (Todo "" "" False) (L.head xs)) |> \todo -> text todo.description
                ]
            )
                :: (todoList (M.withDefault [] (L.tail xs)))
