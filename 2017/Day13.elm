module Main exposing (..)

import Dict
import Html exposing (Html, text)
import List.Extra as List
import String


-- 293880 too low


main : Html msg
main =
    { part1 = severity 0
    , part2 = smallestWithoutSeverity 0
    }
        |> toString
        |> text


{-| this is really bad performance-wise. one could go with a sieve-approach. but as rewriting would take more than the ~20s of computation time on my machine... screw it! :D
-}
smallestWithoutSeverity i =
    if severity i == 0 || i > 9999999 then
        i
    else
        smallestWithoutSeverity (i + 1)


severity delay =
    let
        isCaught depth =
            Dict.get depth input
                |> Maybe.map (\levels -> (depth + delay) % ((levels - 1) * 2))
                |> (\currentDepth -> currentDepth == Just 0)
    in
    Dict.foldl
        (\depth range severity ->
            if isCaught depth then
                severity + (depth + delay) * range
            else
                severity
        )
        0
        input


input =
    """0: 5
1: 2
2: 3
4: 4
6: 6
8: 4
10: 8
12: 6
14: 6
16: 8
18: 6
20: 9
22: 8
24: 10
26: 8
28: 8
30: 12
32: 8
34: 12
36: 10
38: 12
40: 12
42: 12
44: 12
46: 12
48: 14
50: 12
52: 14
54: 12
56: 14
58: 12
60: 14
62: 14
64: 14
66: 14
68: 14
70: 14
72: 14
76: 14
80: 18
84: 14
90: 18
92: 17"""
        |> String.split "\n"
        |> List.map
            (\line ->
                case String.split ": " line of
                    depth :: range :: [] ->
                        ( String.toInt depth |> Result.withDefault 0
                        , String.toInt range |> Result.withDefault 0
                        )

                    _ ->
                        Debug.crash "Error while parsing input"
            )
        |> Dict.fromList
