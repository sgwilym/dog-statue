module Scene.Update exposing (..)

import Scene.Messages exposing (Msg(..))
import Scene.Models exposing (Scene, toRelativeCoords, isMouseOverSceneTarget)


update : Msg -> Scene -> ( Scene, Cmd Msg )
update message scene =
    case message of
        MouseMove event ->
            Debug.log (toString (isMouseOverSceneTarget (toRelativeCoords event) scene))
                ( scene, Cmd.none )

        Clicked click ->
            Debug.log (toString (isMouseOverSceneTarget (toRelativeCoords click) scene))
                ( scene, Cmd.none )

        NoOp ->
            ( scene, Cmd.none )
