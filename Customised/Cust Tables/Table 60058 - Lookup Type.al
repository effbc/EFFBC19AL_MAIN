table 60058 "Lookup Type"
{
    DataClassification = CustomerContent;
    // version B2B1.0


    fields
    {
        field(1; "No."; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(2; Name; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "No Series"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[250])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }
}

