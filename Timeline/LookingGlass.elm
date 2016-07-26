module Timeline.LookingGlass exposing (..)

import Array exposing (Array)
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (id, class)
import Html.App
import Timeline.Messages exposing (..)
import Timeline.Models exposing (..)
import Scene.Models exposing (Scene)
import Scene.Multiplane exposing (..)


view : Timeline -> Html Msg
view timeline =
    div [ id "looking-glass" ]
        [ nav timeline.scenes
        , Html.App.map SceneMsg (Scene.Multiplane.view (presentScene timeline))
        ]


nav : Array Scene -> Html Msg
nav scenes =
    let
        nav =
            Array.toList
                (Array.indexedMap (\n scene -> div [ class "scene", onClick (Timeline.Messages.ChangePresent n) ] [ Html.text ("Scene " ++ toString (n + 1)) ]) scenes)
    in
        div []
            nav
