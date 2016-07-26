module Timeline.Models exposing (..)

import Array exposing (Array)
import Scene.Models exposing (Scene)


type alias Timeline =
    { scenes : Array Scene
    , present : Int
    }


new : Timeline
new =
    { scenes = Array.initialize 4 (\n -> Scene.Models.new n)
    , present = 0
    }


sceneFromTimeline : Timeline -> Int -> Scene
sceneFromTimeline timeline i =
    let
        errorScene =
            { foreground = "error.png"
            , background = "error.png"
            }
    in
        Maybe.withDefault errorScene (Array.get i timeline.scenes)


presentScene : Timeline -> Scene
presentScene timeline =
    sceneFromTimeline timeline (timeline.present)
