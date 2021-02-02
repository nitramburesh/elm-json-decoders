module Data.AddressTests exposing (all)

import Data.Address as Address
import Expect
import Json.Decode as Decode
import Test


all : Test.Test
all =
    Test.describe "Address Test Suite"
        [ Test.test "Decode address" <|
            \_ ->
                """ { "city": "Prague", "zip": "12345", "country": "CZ", "address": "address line" } """
                    |> Decode.decodeString Address.decode
                    |> Expect.ok
        , Test.test "Should fail - missing city field" <|
            \_ ->
                """ {  "zip": "12345", "country": "CZ", "address": "address line" } """
                    |> Decode.decodeString Address.decode
                    |> Expect.err
        , Test.test "Should fail - missing zip field" <|
            \_ ->
                """ { "city": "Prague", "country": "CZ", "address": "address line" } """
                    |> Decode.decodeString Address.decode
                    |> Expect.err
        , Test.test "Should fail - missing country field" <|
            \_ ->
                """ { "city": "Prague", "zip": "12345", "address": "address line" } """
                    |> Decode.decodeString Address.decode
                    |> Expect.err
        , Test.test "Should fail - missing address field" <|
            \_ ->
                """ { "city": "Prague", "zip": "12345", "country": "CZ" } """
                    |> Decode.decodeString Address.decode
                    |> Expect.err
        ]
