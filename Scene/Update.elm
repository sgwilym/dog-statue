module Scene.Update exposing (..)

import Scene.Messages exposing (Msg(..))
import Scene.Models exposing (Scene)


update : Msg -> Scene -> ( Scene, Cmd Msg )
update message scene =
    case message of
        NoOp ->
            ( scene, Cmd.none )
