table 60028 "Excepted Rcpt.Date Tracking"
{
    // version B2B1.0

    LookupPageID = "Except Rcpt. Date Tracking";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Enum ExceptedRcptDateTracking)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(2; "Document No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(3; "Document Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(4; "Item No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; "Excepted Receipt Old Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6; "Excepted Receipt New Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(7; Reason; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Entry No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(9; "Deviated By"; Option)
        {
            OptionMembers = Vendor,Organisation;
            DataClassification = CustomerContent;
        }
        field(10; "User Id"; Code[50])
        {
            Description = 'Rev01';
            DataClassification = CustomerContent;
        }
        field(11; "Modified Date"; Date)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Document No.", "Document Line No.")
        {
        }
        key(Key2; "Document No.", "Document Line No.", "Modified Date", "Excepted Receipt Old Date")
        {
        }
    }

    fieldgroups
    {
    }
}

