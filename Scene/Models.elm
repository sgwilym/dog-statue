module Scene.Models exposing (..)

type alias Picture = String

type Order = Background | Foreground

type alias Scene =
  { background : Picture
  , foreground : Picture
  }

new : Scene
new =
  { background = "./bg.png"
  , foreground = "./fg.png"
  }
