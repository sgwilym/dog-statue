module Scene.Messages exposing (..)

import Scene.Models exposing (MouseEvent)
import Vignette.Messages


type Msg
    = VignetteMsg Vignette.Messages.Msg
    | MouseMove MouseEvent
    | Clicked MouseEvent
