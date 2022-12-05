table 33000899 "Str Rdso report"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Issue No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Issue Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Production Order"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Sales Order No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Product No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Issued Qty"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Return Qy"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(10; Lot; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Issue No.")
        {
        }
        key(Key2; "Sales Order No.", "Product No.", Lot, "Production Order")
        {
            SumIndexFields = "Issued Qty", "Return Qy";
        }
    }

    fieldgroups
    {
    }
}

