module Timeline.Update exposing (..)

import Timeline.Messages exposing (Msg(..))
import Timeline.Models exposing (Timeline, presentScene)
import Scene.Update


update : Msg -> Timeline -> ( Timeline, Cmd Msg )
update message timeline =
    case message of
        ChangePresent newPresent ->
            ( { timeline | present = newPresent }, Cmd.none )

        SceneMsg subMsg ->
            let
                ( updatedScenes, sceneCmd ) =
                    Scene.Update.update subMsg (presentScene timeline)
            in
                ( timeline, Cmd.map SceneMsg sceneCmd )
