table 90100 "IJL Table"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(4; Rate; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Line No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(8; Location; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(9; amount; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(10; total; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Jnl Batch Name"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Jnl Template"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(13; IPG; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(14; GPPG; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(15; UOM; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(16; "Qty per"; Decimal)
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

