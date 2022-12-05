table 60027 "Indent Consolidation"
{
    DataClassification = CustomerContent;
    // version B2B1.0


    fields
    {
        field(1; "ICN No."; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Indent No."; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; Describtion; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(5; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Vendor No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "ICN No.", "Vendor No.", "Item No.")
        {
        }
    }

    fieldgroups
    {
    }
}

