table 80802 "Sales Line Vat"
{
    DataClassification = CustomerContent;
    // version B2Bupg


    fields
    {
        field(1; "Document Type"; Enum "Purchase Document Type")
        {
            Caption = 'Document Type';

            DataClassification = CustomerContent;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = FIELD("Document Type"));
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
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

