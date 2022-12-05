table 33000923 "Multimeter QC Details"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Serial No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Next Calibration Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(4; Remarks; Text[200])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.", "Serial No.")
        {
        }
    }

    fieldgroups
    {
    }
}

