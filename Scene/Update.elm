module Scene.Update exposing (..)

import Scene.Messages exposing (Msg(..))
import Scene.Models exposing (Scene, toRelativeCoords, isMouseOverSceneTarget, targetFromMousePosition)
import Vignette.Update
import Vignette.Models


update : Msg -> Scene -> ( Scene, Cmd Msg )
update message scene =
    case message of
        MouseMove event ->
            ( { scene | mouseOverTarget = isMouseOverSceneTarget (toRelativeCoords event) scene }, Cmd.none )

        Clicked click ->
            let
                target =
                    targetFromMousePosition (toRelativeCoords click) scene
            in
                case target of
                    Nothing ->
                        ( scene, Cmd.none )

                    Just target ->
                        ( { scene | vignette = Just (Vignette.Models.new target.slides) }, Cmd.none )

        VignetteMsg subMsg ->
            case scene.vignette of
                Nothing ->
                    ( scene, Cmd.none )

                Just vignette ->
                    let
                        ( updatedVignette, vignetteCmd ) =
                            Vignette.Update.update subMsg vignette
                    in
                        case updatedVignette of
                            Nothing ->
                                ( { scene | vignette = Nothing }, Cmd.map VignetteMsg vignetteCmd )

                            Just vignette ->
                                ( { scene | vignette = Just vignette }, Cmd.map VignetteMsg vignetteCmd )
