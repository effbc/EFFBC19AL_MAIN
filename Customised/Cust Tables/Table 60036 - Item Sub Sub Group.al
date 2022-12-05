table 60036 "Item Sub Sub Group"
{
    // version B2B1.0

    LookupPageID = "Item Sub Sub Group";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item Sub Group Code"; Code[20])
        {
            TableRelation = "Item Sub Group".Code;
            DataClassification = CustomerContent;
        }
        field(2; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(4; Module; Text[100])
        {
            Description = 'added by sujani on 06-May-19 for Module tracking';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Item Sub Group Code", "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

