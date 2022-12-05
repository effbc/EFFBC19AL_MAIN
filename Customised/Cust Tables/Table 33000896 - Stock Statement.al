table 33000896 "Stock Statement"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Month; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; Item; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Stock Qty"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Total Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Month Name"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(7; Year; Integer)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Month, Year, Item)
        {
        }
        key(Key2; Month, Year, "Total Cost")
        {
        }
    }

    fieldgroups
    {
    }
}

