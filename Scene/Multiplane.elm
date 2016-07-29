module Scene.Multiplane exposing (..)

import Html exposing (..)
import Html.Attributes exposing (id, src, style)
import Html.Events exposing (on)
import Scene.Messages exposing (..)
import Scene.Models exposing (Scene, Picture, Order(..), Click)
import Scene.Decoders exposing (decodeClickEvent)
import Json.Decode as Decode


multiplaneStyle : Attribute a
multiplaneStyle =
    style
        [ ( "position", "relative" )
        ]


imageStyle : Attribute a
imageStyle =
    style
        [ ( "position", "absolute" )
        ]


onClick : (Click -> Msg) -> Attribute Msg
onClick message =
    on "click" (Decode.map message decodeClickEvent)


view : Scene -> Html Msg
view scene =
    div [ id "multiplane", multiplaneStyle ]
        (imagesFromScene scene)


imagesFromScene : Scene -> List (Html Msg)
imagesFromScene scene =
    [ imageFromPicture scene.background Background
    , imageFromPicture scene.foreground Foreground
    ]


imageFromPicture : Picture -> Scene.Models.Order -> Html Msg
imageFromPicture picture order =
    img [ src picture, id (idFromOrder order), imageStyle, onClick Scene.Messages.Clicked ]
        []


idFromOrder : Scene.Models.Order -> String
idFromOrder order =
    case order of
        Foreground ->
            "fg"

        Background ->
            "bg"
