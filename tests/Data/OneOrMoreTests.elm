module Data.OneOrMoreTests exposing (all)

import Data.OneOrMore as OneOrMore
import Expect
import Json.Decode as Decode
import Test


all : Test.Test
all =
    Test.describe "OneOrMore Test Suite"
        [ Test.test "Decode list with 1 item" <|
            \_ ->
                """ [ "string" ] """
                    |> Decode.decodeString (OneOrMore.decode Decode.string)
                    |> Expect.ok
        , Test.test "Decode list with 2 items" <|
            \_ ->
                """ [ "string", "string2" ] """
                    |> Decode.decodeString (OneOrMore.decode Decode.string)
                    |> Expect.ok
        , Test.test "Decode list with 4 items" <|
            \_ ->
                """ [ "string", "string2", "string3" ] """
                    |> Decode.decodeString (OneOrMore.decode Decode.string)
                    |> Expect.ok
        , Test.test "Should fail - []" <|
            \_ ->
                """ [] """
                    |> Decode.decodeString (OneOrMore.decode Decode.string)
                    |> Expect.err
        , Test.test "Should fail - {}" <|
            \_ ->
                """ {} """
                    |> Decode.decodeString (OneOrMore.decode Decode.string)
                    |> Expect.err
        , Test.test "Should fail - string" <|
            \_ ->
                """ "string" """
                    |> Decode.decodeString (OneOrMore.decode Decode.string)
                    |> Expect.err
        ]
