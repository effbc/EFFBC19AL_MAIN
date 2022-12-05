table 88877 "Temp Dim Values"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Dimension Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Dimension Value"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

