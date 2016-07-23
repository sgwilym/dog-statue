module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Scene.Update

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    SceneMsg subMsg ->
      let
        ( updatedScene, cmd ) =
          Scene.Update.update subMsg model.scene
      in
        ( { model | scene = updatedScene}, Cmd.map SceneMsg cmd )
