table 33000918 "PCB Box data"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Product; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(2; CPCB; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "CPCB Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(4; Box; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Item No."; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(6; Description; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(7; Quantity; Decimal)
        {
            DecimalPlaces = 4 : 4;
            DataClassification = CustomerContent;
        }
        field(8; Color; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Color Code"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(10; "BOX Sort"; Integer)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Product, CPCB, Box, "Item No.")
        {
        }
        key(Key2; Product, CPCB, "Item No.")
        {
        }
    }

    fieldgroups
    {
    }
}

