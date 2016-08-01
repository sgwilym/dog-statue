module Vignette.SlideViewer exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, src)
import Vignette.Messages exposing (Msg(..))
import Vignette.Models exposing (..)


view : Vignette -> Html Msg
view vignette =
    button
        [ onClick Progress
        , style
            [ ( "top", "30px" )
            , ( "left", "30px" )
            , ( "right", "30px" )
            , ( "bottom", "30px" )
            , ( "z-index", "2" )
            , ( "position", "absolute" )
            ]
        ]
        [ case currentSlide vignette of
            Picture url ->
                img [ src url ] []

            Intertitle text ->
                Html.text text
        ]
