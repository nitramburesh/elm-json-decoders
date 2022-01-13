module Data.Document exposing (Model, decode)

import Data.Date as Date
import Json.Decode as Decode
import Json.Decode.Pipeline as Pipeline


type Model
    = Model Document


type alias Document =
    { id : String
    , expireDate : Date.Model
    , documentType : DocumentType
    }


type DocumentType
    = IdentityCard
    | DrivingLicense DrivingLicenseData


type alias DrivingLicenseData =
    { group : String
    }


decode : Decode.Decoder Model
decode =
    Decode.map Model decodeDocument


decodeDocument : Decode.Decoder Document
decodeDocument =
    Decode.succeed Document
        |> Pipeline.required "id" Decode.string
        |> Pipeline.required "expireDate" Date.decode
        |> Pipeline.required "documentType" decodeDocumentType


decodeDocumentType : Decode.Decoder DocumentType
decodeDocumentType =
    Decode.string
        |> Decode.andThen
            (\documentType ->
                case documentType of
                    "identityCard" ->
                        Decode.succeed IdentityCard

                    "drivingLicense" ->
                        Decode.map DrivingLicense decodeDrivingLicenseData

                    _ ->
                        Decode.fail (documentType ++ " is not a valid document type")
            )


decodeDrivingLicenseData : Decode.Decoder DrivingLicenseData
decodeDrivingLicenseData =
    Decode.succeed DrivingLicenseData
        |> Pipeline.required "group" Decode.string
