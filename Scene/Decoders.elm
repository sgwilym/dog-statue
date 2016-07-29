module Scene.Decoders exposing (..)

import Scene.Models exposing (Click, ElementWithOffsets, ParentElement)
import Json.Decode as Decode
import Json.Decode exposing (..)
import Json.Decode.Extra exposing ((|:), lazy)


decodeClickEvent : Decode.Decoder Click
decodeClickEvent =
    succeed Click
        |: ("pageX" := int)
        |: ("pageY" := int)
        |: (Decode.at [ "target", "parentElement" ] decodeElementWithOffsets)


decodeElementWithOffsets : Decode.Decoder ElementWithOffsets
decodeElementWithOffsets =
    succeed ElementWithOffsets
        |: ("offsetLeft" := int)
        |: ("offsetTop" := int)
        |: ("parentElement" := lazy (\_ -> decodeParentElement))


decodeParentElement : Decode.Decoder ParentElement
decodeParentElement =
    oneOf
        [ null Scene.Models.Nothing
        , map Scene.Models.ParentElement decodeElementWithOffsets
        ]
