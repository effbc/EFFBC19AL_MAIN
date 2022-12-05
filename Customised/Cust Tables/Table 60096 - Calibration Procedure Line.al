table 60096 "Calibration Procedure Line"
{
    // version Cal1.0

    Caption = 'Calibration Procedure Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = "Calibration Procedure Header";
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; Comment; Text[80])
        {
            Caption = 'Comment';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

