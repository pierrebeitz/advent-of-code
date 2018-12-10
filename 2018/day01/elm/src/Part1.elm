{-
   The implementation here is quite a bit more complex than it needs to be, mainly because i wanted to try out the new elm/parser package.
   With `fredcy/elm-parseint` we could bring it down to the following:

        input
           |> String.split "\n"
           |> List.map ParseInt.parseInt
           |> solve
-}


module Part1 exposing (parseInput, solve, sum)

import Parser as P exposing ((|.), (|=), Parser)


solve : String -> String
solve input_ =
    case parseInput input_ of
        Ok frequencies ->
            sum frequencies
                |> String.fromInt

        Err error ->
            error


{-| Returns the resulting frequency for the list of given frequency changes.
-}
sum : List Int -> Int
sum frequencies =
    List.foldr (+) 0 frequencies


{-| Parses the given string (be sure to replace `PASTE YOUR INPUT HERE`) and returns a `Result` with either a list of integers or an error message.
-}
parseInput : String -> Result String (List Int)
parseInput input_ =
    let
        line : Parser Int
        line =
            P.oneOf
                [ P.succeed (\int -> -int)
                    |. P.symbol "-"
                    |= P.int
                    |. P.spaces
                , P.succeed (\int -> int)
                    |. P.symbol "+"
                    |= P.int
                    |. P.spaces
                ]

        lines : Parser (List Int)
        lines =
            P.loop [] <|
                \list ->
                    P.oneOf
                        [ P.succeed (\res -> P.Loop (res :: list)) |= line
                        , P.succeed () |> P.map (\_ -> P.Done (List.reverse list))
                        ]
    in
    P.run lines input_
        |> Result.mapError P.deadEndsToString
