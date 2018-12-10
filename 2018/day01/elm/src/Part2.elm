module Part2 exposing (solve)

import Part1
import Set


solve : String -> String
solve input =
    case
        Part1.parseInput input
            |> Result.map firstDuplicate
    of
        Ok dup ->
            String.fromInt dup

        Err msg ->
            msg


firstDuplicate : List Int -> Int
firstDuplicate freqs =
    let
        help seen current changes =
            if Set.member current seen then
                current

            else
                case changes of
                    fst :: rest ->
                        help (Set.insert current seen) (current + fst) rest

                    -- start over with the initially given frequencies. this possibly produces an inifite loop.
                    [] ->
                        help seen current freqs
    in
    help Set.empty 0 freqs
