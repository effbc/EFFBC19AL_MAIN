table 80803 "SalesInvLine Vat"
{
    DataClassification = CustomerContent;
    // version B2Bupg


    fields
    {
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(5; "Vat %age"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Vat Base"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Vat Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

