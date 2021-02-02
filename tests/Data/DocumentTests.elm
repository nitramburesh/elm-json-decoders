module Data.DocumentTests exposing (all)

import Data.Document as Document
import Expect
import Json.Decode as Decode
import Test


all : Test.Test
all =
    Test.describe "Document Test Suite"
        [ Test.test "Decode IdentityCard document" <|
            \_ ->
                """ { "id": "docId", "documentType": "identityCard", "expireDate": "2021-02-03T08:15:30-00:00" } """
                    |> Decode.decodeString Document.decode
                    |> Expect.ok
        , Test.test "Decode DrivingLicense document" <|
            \_ ->
                """ { "id": "docId", "documentType": "drivingLicense", "expireDate": "2021-02-03T08:15:30-00:00", "group": "B" } """
                    |> Decode.decodeString Document.decode
                    |> Expect.ok
        , Test.test "Should fail - missing id field" <|
            \_ ->
                """ { "documentType": "drivingLicense", "expireDate": "2021-02-03T08:15:30-00:00" } """
                    |> Decode.decodeString Document.decode
                    |> Expect.err
        , Test.test "Should fail - missing documentType field" <|
            \_ ->
                """ { "id": "docId", "expireDate": "2021-02-03T08:15:30-00:00" } """
                    |> Decode.decodeString Document.decode
                    |> Expect.err
        , Test.test "Should fail - missing expireDate field" <|
            \_ ->
                """ { "id": "docId", "documentType": "drivingLicense" } """
                    |> Decode.decodeString Document.decode
                    |> Expect.err
        , Test.test "Should fail - unknown documentType field" <|
            \_ ->
                """ { "id": "docId", "documentType": "bankCard", "expireDate": "2021-02-03T08:15:30-00:00" } """
                    |> Decode.decodeString Document.decode
                    |> Expect.err
        , Test.test "Should fail - missing group field for DrivingLicense DocumentType" <|
            \_ ->
                """ { "id": "docId", "documentType": "drivingLicense", "expireDate": "2021-02-03T08:15:30-00:00" } """
                    |> Decode.decodeString Document.decode
                    |> Expect.err
        ]
