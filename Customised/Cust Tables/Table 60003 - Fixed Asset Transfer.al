table 60003 "Fixed Asset Transfer"
{
    DataClassification = CustomerContent;
    // version B2B1.0


    fields
    {
        field(1; "Entry No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(2; "Fixed Asset No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(3; "FA Location"; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(4; "FA New Location"; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; Date; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6; "User id"; Code[50])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(7; "Location Trns. Reason"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Responsible Employee"; Code[50])
        {
            Caption = 'Responsible Employee';
            Editable = true;
            TableRelation = Employee;
            DataClassification = CustomerContent;
        }
        field(9; "New Responsible Employee"; Code[50])
        {
            Caption = 'New Responsible Employee';
            Editable = false;
            TableRelation = Employee;
            DataClassification = CustomerContent;
        }
        field(10; "Employee Trns. Reason"; Text[100])
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

