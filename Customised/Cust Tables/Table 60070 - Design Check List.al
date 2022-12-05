table 60070 "Design Check List"
{
    DataClassification = CustomerContent;
    // version B2B1.0


    fields
    {
        field(1; "Tender No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; Description1; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(4; "QTY."; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(5; Description2; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(6; Description3; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Item No."; Code[20])
        {
            TableRelation = Item."No.";
            DataClassification = CustomerContent;
        }
        field(8; Remarks; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(9; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(10; Status; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Tender No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

