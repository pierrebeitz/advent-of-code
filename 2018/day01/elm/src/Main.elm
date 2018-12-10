module Main exposing (..)

import Html exposing (Html)
import Part1
import Part2


{-| Shows the solutions as HTML in the browser.
-}
main : Html msg
main =
    Html.div []
        [ Html.div [] [ "Part1: " ++ Part1.solve """PASTE YOUR INPUT HERE""" |> Html.text ]
        , Html.div [] [ "Part2: " ++ Part2.solve """PASTE YOUR INPUT HERE""" |> Html.text ]
        ]
