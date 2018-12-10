module Part2Test exposing (..)

import Expect
import Part2
import Test exposing (..)


suite : Test
suite =
    describe "part2"
        [ test "example1" <|
            \_ ->
                Part2.solve """+1
                              -1"""
                    |> Expect.equal "0"
        , test "example2" <|
            \_ ->
                Part2.solve """+3
                             +3
                             +4
                             -2
                             -4"""
                    |> Expect.equal "10"
        , test "example3" <|
            \_ ->
                Part2.solve """-6
                             +3
                             +8
                             +5
                             -6"""
                    |> Expect.equal "5"
        , test "example4" <|
            \_ ->
                Part2.solve """+7
                             +7
                             -2
                             -7
                             -4"""
                    |> Expect.equal "14"
        ]
