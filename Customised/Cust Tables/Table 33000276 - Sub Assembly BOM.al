table 33000276 "Sub Assembly BOM"
{
    DataClassification = CustomerContent;
    // version WIP1.0


    fields
    {
        field(1; "Parent Item No."; Code[20])
        {
            TableRelation = "Sub Assembly";
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Sub Assembly No."; Code[20])
        {
            TableRelation = "Sub Assembly";
            DataClassification = CustomerContent;
        }
        field(4; "Bill of Material"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(5; Description; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Unit of Measure Code"; Code[10])
        {
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(7; "Quantity per"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(8; Position; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Position 2"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Position 3"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Machine No."; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Production Lead Time"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(13; "BOM Description"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(14; "Installed in Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(15; "Installed in SA No."; Code[10])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Parent Item No.")
        {
        }
    }

    fieldgroups
    {
    }
}

