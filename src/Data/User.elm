module Data.User exposing (Model, decode)

import Data.Address as Address
import Data.Date as Date
import Data.Document as Document
import Data.Family as Family
import Data.OneOrMore as OneOrMore
import Json.Decode as Decode
import Json.Decode.Pipeline as Pipeline


type Model
    = Model User


type alias User =
    { id : String
    , name : String
    , bornDate : Date.Model
    , address : Address.Model
    , documents : OneOrMore.Model Document.Model
    , family : Family.Model
    }


decode : Decode.Decoder Model
decode =
    Decode.map Model decoderUserResponse


decoderUserResponse : Decode.Decoder User
