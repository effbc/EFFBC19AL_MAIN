table 60031 "QCS Header"
{
    DataClassification = CustomerContent;
    // version B2B1.0


    fields
    {
        field(1; "RFQ No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Vendor No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Vendor Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Quote No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(5; "PD Comment"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Total Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(7; "RFQ Date"; Date)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "RFQ No.", "Quote No.")
        {
        }
    }

    fieldgroups
    {
    }
}

