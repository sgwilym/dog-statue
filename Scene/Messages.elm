module Scene.Messages exposing (..)

import Scene.Models exposing (MouseEvent)


type Msg
    = MouseMove MouseEvent
    | Clicked MouseEvent
    | NoOp
