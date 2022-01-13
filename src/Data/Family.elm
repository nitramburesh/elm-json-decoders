module Data.Family exposing
    ( Model
    , bothParentsDecoded
    , brotherDecoded
    , decode
    , fatherDecoded
    , motherDecoded
    , noFamilyMembersDecoded
    , sisterDecoded
    , withBothParentsAndsSiblingsDecoded
    , withSiblingsDecoded
    )

import Data.OneOrMore as OneOrMore
import Json.Decode as Decode
import Json.Decode.Pipeline as Pipeline


type Model
    = Model Family


type alias Family =
    { parents : Parents
    , siblings : Siblings
    }


type Siblings
    = OnlyChild
    | OneBrotherOrMore (OneOrMore.Model Brother)
    | OneSisterOrMore (OneOrMore.Model Sister)
    | WithSiblings (OneOrMore.Model Sister) (OneOrMore.Model Brother)


type alias Parents =
    { mother : Maybe Mother
    , father : Maybe Father
    }


type Brother
    = Brother


type Sister
    = Sister


type Mother
    = Mother


type Father
    = Father


decode : Decode.Decoder Model
decode =
    Decode.map Model decodeFamily


decodeMother : Decode.Decoder Mother
decodeMother =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "mother" ->
                        Decode.succeed Mother

                    _ ->
                        Decode.fail (string ++ " is not Mother")
            )


decodeFather : Decode.Decoder Father
decodeFather =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "father" ->
                        Decode.succeed Father

                    _ ->
                        Decode.fail (string ++ " is not Father")
            )


decodeParents : Decode.Decoder Parents
decodeParents =
    Decode.succeed Parents
        |> Pipeline.optional "mother" (Decode.map Just decodeMother) Nothing
        |> Pipeline.optional "father" (Decode.map Just decodeFather) Nothing


decodeSiblings : Decode.Decoder Siblings
decodeSiblings =
    Decode.list Decode.string
        |> Decode.andThen
            (\siblings ->
                case siblings of
                    0 ->
                        Decode.succeed OnlyChild

                    0 ->
                        Decode.succeed OnlyChild

                    0 ->
                        Decode.succeed OnlyChild

                    0 ->
                        Decode.succeed OnlyChild
            )


decodeFamily : Decode.Decoder Family
decodeFamily =
    Decode.succeed Family
        |> Pipeline.required "parents" decodeParents
        |> Pipeline.required "siblings" decodeSiblings


toSiblings : ( List Sister, List Brother ) -> Siblings
toSiblings siblingsTuple =
    case siblingsTuple of
        ( [], [] ) ->
            OnlyChild

        ( sister :: sisters, [] ) ->
            OneSisterOrMore (OneOrMore.toModel ( sister, sisters ))

        ( [], brother :: brothers ) ->
            OneBrotherOrMore (OneOrMore.toModel ( brother, brothers ))

        ( sister :: sisters, brother :: brothers ) ->
            WithSiblings (OneOrMore.toModel ( sister, sisters )) (OneOrMore.toModel ( brother, brothers ))



---- For test purposes !!! ---


motherDecoded : Model
motherDecoded =
    Model
        { parents = { mother = Just Mother, father = Nothing }
        , siblings = OnlyChild
        }


fatherDecoded : Model
fatherDecoded =
    Model
        { parents = { mother = Nothing, father = Just Father }
        , siblings = OnlyChild
        }


sisterDecoded : Model
sisterDecoded =
    Model
        { parents = { mother = Nothing, father = Nothing }
        , siblings = OneSisterOrMore <| OneOrMore.toModel ( Sister, [] )
        }


brotherDecoded : Model
brotherDecoded =
    Model
        { parents = { mother = Nothing, father = Nothing }
        , siblings = OneBrotherOrMore <| OneOrMore.toModel ( Brother, [] )
        }


bothParentsDecoded : Model
bothParentsDecoded =
    Model
        { parents = { mother = Just Mother, father = Just Father }
        , siblings = OnlyChild
        }


withSiblingsDecoded : Model
withSiblingsDecoded =
    Model
        { parents = { mother = Nothing, father = Nothing }
        , siblings = WithSiblings (OneOrMore.toModel ( Sister, [] )) (OneOrMore.toModel ( Brother, [] ))
        }


withBothParentsAndsSiblingsDecoded : Model
withBothParentsAndsSiblingsDecoded =
    Model
        { parents = { mother = Just Mother, father = Just Father }
        , siblings = WithSiblings (OneOrMore.toModel ( Sister, [] )) (OneOrMore.toModel ( Brother, [] ))
        }


noFamilyMembersDecoded : Model
noFamilyMembersDecoded =
    Model
        { parents = { mother = Nothing, father = Nothing }
        , siblings = OnlyChild
        }
