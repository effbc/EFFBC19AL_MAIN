table 33000894 "Item Wise Requirement1"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No."; Code[30])
        {
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Required Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(4; "Qty. In Material Issues"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Item No.")
        {
        }
    }

    fieldgroups
    {
    }
}

