module Scene.Multiplane exposing (..)

import Html exposing (..)
import Html.Attributes exposing (id, src, style)
import Html.Events exposing (on)
import Html.App
import Scene.Messages exposing (..)
import Scene.Models exposing (Scene, Picture, Order(..), MouseEvent)
import Scene.Decoders exposing (decodeMouseEvent)
import Json.Decode as Decode
import Vignette.SlideViewer exposing (..)


multiplaneStyle : Attribute a
multiplaneStyle =
    style
        [ ( "position", "relative" )
        , ( "display", "inline-block" )
        ]


touchLayerStyle : Scene -> Attribute a
touchLayerStyle scene =
    style
        [ ( "position", "absolute" )
        , ( "top", "0" )
        , ( "left", "0" )
        , ( "right", "0" )
        , ( "bottom", "0" )
        , ( "cursor"
          , if scene.mouseOverTarget then
                "pointer"
            else
                "auto"
          )
        ]


onClick : (MouseEvent -> Msg) -> Attribute Msg
onClick message =
    on "click" (Decode.map message decodeMouseEvent)


onMouseMove : (MouseEvent -> Msg) -> Attribute Msg
onMouseMove message =
    on "mousemove" (Decode.map message decodeMouseEvent)


view : Scene -> Html Msg
view scene =
    let
        childrenWithoutVignette =
            imagesFromScene scene
                ++ [ touchLayer scene ]

        children =
            case scene.vignette of
                Nothing ->
                    childrenWithoutVignette

                Just vignette ->
                    childrenWithoutVignette
                        ++ [ Html.App.map VignetteMsg (Vignette.SlideViewer.view vignette) ]
    in
        div
            [ id "multiplane"
            , multiplaneStyle
            ]
            children


touchLayer : Scene -> Html Msg
touchLayer scene =
    div
        [ id "touch-layer"
        , touchLayerStyle scene
        , onClick Scene.Messages.Clicked
        , onMouseMove Scene.Messages.MouseMove
        ]
        []


imagesFromScene : Scene -> List (Html Msg)
imagesFromScene scene =
    [ imageFromPicture scene.background Background
    , imageFromPicture scene.foreground Foreground
    ]


imageFromPicture : Picture -> Scene.Models.Order -> Html Msg
imageFromPicture picture order =
    img
        [ src picture
        , id (idFromOrder order)
        , styleFromOrder order
        ]
        []


styleFromOrder : Scene.Models.Order -> Attribute a
styleFromOrder order =
    case order of
        Foreground ->
            style [ ( "position", "absolute" ), ( "top", "0" ), ( "left", "0" ) ]

        Background ->
            style []


idFromOrder : Scene.Models.Order -> String
idFromOrder order =
    case order of
        Foreground ->
            "fg"

        Background ->
            "bg"
