table 60108 "Inwards2 data"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Purchase Order"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Item; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Location Code"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(4; Inward_Qty_Old; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(5; Inward_Qty_New; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Location Code Mismatch"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Qty Mismatch"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Not Availabel"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Purchase Order", Item)
        {
        }
    }

    fieldgroups
    {
    }
}

