module Main exposing (..)

import Html exposing (Html, text)


main : Html msg
main =
    { part1 = distanceOf 361527
    }
        |> toString
        |> text


{-| Determine in which ring a number is. Look at the NOTES to understand what "ring" means.
-}
ring n =
    let
        ring_ i =
            if n <= (2 * i + 1) ^ 2 then
                i
            else
                ring_ (i + 1)
    in
    ring_ 0


distanceOf n =
    let
        r =
            ring n

        center =
            (2 * r) ^ 2 + 1

        centers =
            [ center - 3 * r, center - r, center + r, center + 3 * r ]
    in
    centers
        |> List.map (\c -> abs (n - c))
        |> List.minimum
        |> Maybe.map ((+) r)



{- NOTES for Part 1

   - let's draw a bigger spiral:

   37  36  35  34  33  32  31
   38  17  16  15  14  13  30
   39  18   5   4   3  12  29
   40  19   6   1   2  11  28
   41  20   7   8   9  10  27
   42  21  22  23  24  25  26
   43  44  45  46  47  48  49

   interesting:
   - biggest number (`max`) in each "ring" `n > 0` is `(2n + 1)^2`. (9, 25, 49, ...)
   - numbers per ring is (2*n)*4 (8, 16, 24, ...)

   - let's draw the distance map:

    6   5   4   3   4   5   6
    5   4   3   2   3   4   5
    4   3   2   1   2   3   4
    3   2   1   0   1   2   3
    4   3   2   1   2   3   4
    5   4   3   2   3   4   5
    6   5   4   3   4   5   6

   - middle number of each ring is 2n^2 + 1.
   idea: find ring of number, compute diffs to smallest distances and take the smallest one. add this one to the ring-index.
-}
