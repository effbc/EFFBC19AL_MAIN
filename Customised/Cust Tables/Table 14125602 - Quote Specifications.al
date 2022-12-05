table 14125602 "Quote Specifications"
{
    DataClassification = CustomerContent;
    // version B2BQTO


    fields
    {
        field(1; "LookUp Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Lookup Name"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(4; Item; Text[250])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "LookUp Code", Item)
        {
        }
    }

    fieldgroups
    {
    }
}

