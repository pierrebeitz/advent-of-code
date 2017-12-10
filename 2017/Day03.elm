module Main exposing (..)

import Array
import Array.Extra as Array
import Html exposing (Html, text)


main : Html msg
main =
    { part1 = distanceOf 361527
    , part2 = iterateTillValue 361527 -- 363010
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
        |> List.map (\center -> abs (n - center))
        |> List.minimum
        |> Maybe.map (\min -> min + r)



-- PART 2


iterateTillValue num =
    let
        iterateTillValueHelp index list =
            let
                largestVal =
                    Array.getUnsafe (index - 1) list
            in
            if largestVal > num then
                ( largestVal, list )
            else
                indexesToSumUp index
                    |> List.map (\i -> Array.getUnsafe i list)
                    |> List.sum
                    |> (\sum -> Array.append list (Array.fromList [ sum ]))
                    |> iterateTillValueHelp (index + 1)
    in
    iterateTillValueHelp (Array.length lazyMansStart) lazyMansStart


{-| as it already took enough time to figure stuff out and i'm too lazy to think about what to do if a field is
`isOneBeforeCorner` AND `isOneAfterCorner` at the same time, let's just start with the input from the puzzle description :D
-}
lazyMansStart =
    Array.fromList [ 0, 1, 1, 2, 4, 5, 10, 11, 23, 25 ]


{-| find out which previous indexes to sum up for a given index.

This can be found out looking at the "corners" (3, 5, 7, 10, 13, 17, 21 and so on...)

Then there are a couple cases:

  - we're on a corner -> We just "see" our predecessor (pred) + the corner in the ring below.
    (13 -> [12, 3])
  - one index before a corner -> pred + corner "below" + one before
    (12 -> [11, 3, 2])
  - one index after a corner -> pred + corner "below" + one after + the second previous
    (14 -> [13, 12, 2])
  - on any other index -> pred + one ring below + the one before that + the one after that
    (15 -> [14, 4, 3, 5])

-}
indexesToSumUp index =
    let
        -- the index on the current ring starting at 1
        indexOnRing =
            index - (((2 * ring index) - 1) ^ 2)

        edgeLength =
            2 * ring index

        cornerOffset n =
            List.any (\c -> c == indexOnRing + n)
                [ 1, edgeLength, 2 * edgeLength, 3 * edgeLength, 4 * edgeLength + 1 ]

        innerRingIndexes =
            List.map (\i -> index - ((ring index - 1) * 8) - (((indexOnRing - 1) // edgeLength) * 2 + 1) + i)
    in
    if cornerOffset 0 then
        (index - 1)
            :: innerRingIndexes
                [ if indexOnRing == 1 then
                    1
                  else
                    -1
                ]
    else if cornerOffset 1 then
        index - 1 :: innerRingIndexes [ 0, -1 ]
    else if cornerOffset -1 then
        index - 1 :: index - 2 :: innerRingIndexes [ 0, 1 ]
    else
        index - 1 :: innerRingIndexes [ -1, 0, 1 ]



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

   - the average number of each ring is 2n^2 + 1.
   idea: find ring of number, compute diffs to numbers on the cross through 1 and take the smallest one. add this one to the ring-index.
   this means that we first "approach" to the cross through 1 and then move towards it.
   here's a drawing containing multiple n's and their paths (to get the idea). (n in [36, 44, 49])

   37  36--->---+  33  32  31
   38  17  16   v  14  13  30
   39  18   5   v   3  12  29
   40  19   6   O   2  11  28
   41  20   7   ^   9  10  27
   42  21  22   ^  24  25  26
   43  44--->---+---<---<--49
-}
