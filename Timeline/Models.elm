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
            , targets = []
            , mouseOverTarget = False
            }
    in
        Maybe.withDefault errorScene (Array.get i timeline.scenes)


presentScene : Timeline -> Scene
presentScene timeline =
    sceneFromTimeline timeline (timeline.present)


updateScenes : Int -> Scene -> Array Scene -> Array Scene
updateScenes n scene scenes =
    Array.set n scene scenes
