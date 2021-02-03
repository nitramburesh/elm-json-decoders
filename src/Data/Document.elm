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
