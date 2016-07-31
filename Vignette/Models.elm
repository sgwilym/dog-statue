module Vignette.Models exposing (..)

import Array exposing (Array)


type alias Vignette =
    { slides : Array Slide
    , currentSlide : Int
    }


type alias Slides =
    Array Slide


type Slide
    = Picture String
    | Intertitle String


type ProgressResult
    = Next Int
    | Finished


new : Slides -> Vignette
new slides =
    { slides = slides
    , currentSlide = 0
    }


newSlides : Array Slide
newSlides =
    Array.fromList
        [ Intertitle "A day like any other. The same faces of the same old withered men with nothing to do but talk about the weather. The same pounding heat of the day, and the same breathtaking cold of the night…"
        , Intertitle "… and of course, the same old dog statue."
        , Intertitle "But today wouldn't be completely the same. In fact, nothing will ever be the same again for me."
        , Intertitle "Because tonight’s the night I'm meeting him. The man who will crush up this sameness and throw it to the wind. The man who, I admit, was the man I wish I could be."
        , Intertitle "And here he was."
        , Picture "http://gwil.co/projects/dog-statue/s1.png"
        ]


slideFromVignette : Int -> Vignette -> Slide
slideFromVignette n vignette =
    Maybe.withDefault (Intertitle "Error!") (Array.get n vignette.slides)


currentSlide : Vignette -> Slide
currentSlide vignette =
    slideFromVignette vignette.currentSlide vignette


nextSlide : Vignette -> ProgressResult
nextSlide vignette =
    if vignette.currentSlide + 1 >= Array.length vignette.slides then
        Finished
    else
        Next (vignette.currentSlide + 1)
