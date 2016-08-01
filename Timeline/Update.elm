module Timeline.Update exposing (..)

import Timeline.Messages exposing (Msg(..))
import Timeline.Models exposing (Timeline, presentScene, updateScenes, resetScenes)
import Scene.Update


update : Msg -> Timeline -> ( Timeline, Cmd Msg )
update message timeline =
    case message of
        ChangePresent newPresent ->
            ( { timeline | present = newPresent, scenes = resetScenes (timeline.scenes) }, Cmd.none )

        SceneMsg subMsg ->
            let
                ( updatedScene, sceneCmd ) =
                    Scene.Update.update subMsg (presentScene timeline)

                scenes' =
                    updateScenes timeline.present updatedScene timeline.scenes
            in
                ( { timeline | scenes = scenes' }, Cmd.map SceneMsg sceneCmd )
