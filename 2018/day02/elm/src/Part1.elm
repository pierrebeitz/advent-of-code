module Part1 exposing (main)

import Dict
import Dict.Extra as Dict
import Html exposing (Html)
import List.Extra as List


main : Html msg
main =
    Html.text <| String.fromInt <| exactlyNLettersCount 2 * exactlyNLettersCount 3


exactlyNLettersCount : Int -> Int
exactlyNLettersCount n =
    input |> List.count (String.toList >> Dict.frequencies >> Dict.any (\_ frequency -> frequency == n))


input : List String
input =
    String.split "\n" <|
        """PASTE_YOUR_INPUT_HERE"""
