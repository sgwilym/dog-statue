module View exposing (..)

import Html exposing (Html, div)
import Html.App
import Messages exposing (Msg(..))
import Models exposing (Model)
import Scene.Multiplane

view : Model -> Html Msg
view model =
  div []
    [ page model ]

page : Model -> Html Msg
page model =
  Html.App.map SceneMsg (Scene.Multiplane.view model.scene)
