module Timeline.Messages exposing (..)

import Scene.Messages


type Msg
    = SceneMsg Scene.Messages.Msg
    | ChangePresent Int
