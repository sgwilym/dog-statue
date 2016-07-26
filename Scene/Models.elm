module Scene.Models exposing (..)


type alias Picture =
    String


type Order
    = Background
    | Foreground


type alias Scene =
    { background : Picture
    , foreground : Picture
    }


new : Int -> Scene
new n =
    { background = "http://gwil.co/projects/dog-statue/bg1.png"
    , foreground = "http://gwil.co/projects/dog-statue/fg" ++ toString (n + 1) ++ ".png"
    }
