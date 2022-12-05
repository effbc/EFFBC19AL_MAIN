table 33000895 "Authorized Shortage Items"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No."; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Production Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Location Code"; Code[10])
        {
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(5; Shortage; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Item No.", "Production Date", "Location Code")
        {
        }
    }

    fieldgroups
    {
    }
}

