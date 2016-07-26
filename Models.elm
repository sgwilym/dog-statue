module Models exposing (..)

import Timeline.Models exposing (Timeline)

type alias Model =
  { timeline : Timeline
  }

initialModel : Model
initialModel =
  { timeline = Timeline.Models.new
  }
