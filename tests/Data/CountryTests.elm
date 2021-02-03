module Data.CountryTests exposing (all)

import Data.Country as Country
import Expect
import Json.Decode as Decode
import Test


all : Test.Test
all =
    Test.describe "Country Test Suite"
        [ Test.test "Decode CZ country" <|
            \_ ->
                """ "CZ" """
                    |> Decode.decodeString Country.decode
                    |> Expect.ok
        , Test.test "Decode SK country" <|
            \_ ->
                """ "SK" """
                    |> Decode.decodeString Country.decode
                    |> Expect.ok
        , Test.test "Decode whatever country" <|
            \_ ->
                """ "whatever" """
                    |> Decode.decodeString Country.decode
                    |> Expect.ok
        , Test.test "Should fail - invalid type" <|
            \_ ->
                """ { "country": "CZ" } """
                    |> Decode.decodeString Country.decode
                    |> Expect.err
        ]
