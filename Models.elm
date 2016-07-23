module Models exposing (..)

import Scene.Models exposing (Scene)

type alias Model =
  { scene : Scene
  }

initialModel : Model
initialModel =
  { scene = Scene.Models.new
  }
