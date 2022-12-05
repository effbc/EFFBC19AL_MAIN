table 60109 "Site Old Stock Data"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Serial No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Lot No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(5; Mismatch; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(6; Remarks; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(7; Replace; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(8; Avb; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Avb at Site"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Present Location"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(12; Remain; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(13; "Last Transaction Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(14; "Latest Location"; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
        }
    }

    fieldgroups
    {
    }
}

