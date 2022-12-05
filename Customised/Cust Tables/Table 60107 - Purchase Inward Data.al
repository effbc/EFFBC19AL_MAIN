table 60107 "Purchase Inward Data"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Purchase Order"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Location Code"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(4; Item; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(5; Qty; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Batch Code"; Code[15])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Not Available"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Posting Date Mismmatch"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(9; "location code Mismatch"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Qty Mismatch"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Batch Code Mismatch"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Purchase Order", "Posting Date", "Location Code", Item, Qty, "Batch Code")
        {
            SumIndexFields = Qty;
        }
        key(Key2; "Purchase Order", Item)
        {
            SumIndexFields = Qty;
        }
    }

    fieldgroups
    {
    }
}

