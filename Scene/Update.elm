module Scene.Update exposing (..)

import Scene.Messages exposing (Msg(..))
import Scene.Models exposing (Scene, toRelativeCoords)


update : Msg -> Scene -> ( Scene, Cmd Msg )
update message scene =
    case message of
        Clicked click ->
            Debug.log (toString (toRelativeCoords click))
                ( scene, Cmd.none )

        NoOp ->
            ( scene, Cmd.none )
