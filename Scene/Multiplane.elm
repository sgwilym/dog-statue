module Scene.Multiplane exposing (..)

import Html exposing (..)
import Html.Attributes exposing (id, src, style)
import Scene.Messages exposing (..)
import Scene.Models exposing (Scene, Picture, Order(..))

multiplaneStyle =
  style
    [ ("position", "relative")
    ]

imageStyle =
  style
    [ ("position", "absolute")
    ]

view : Scene -> Html Msg
view scene =
  div [ id "multiplane", multiplaneStyle ]
    ( imagesFromScene scene )

imagesFromScene : Scene -> List (Html Msg)
imagesFromScene scene =
  [ imageFromPicture scene.background Background,
    imageFromPicture scene.foreground Foreground
  ]

imageFromPicture : Picture -> Scene.Models.Order -> Html Msg
imageFromPicture picture order =
  img [ src picture, id (idFromOrder order), imageStyle ]
    []

idFromOrder : Scene.Models.Order -> String
idFromOrder order =
  case order of
    Foreground ->
      "fg"
    Background ->
      "bg"
