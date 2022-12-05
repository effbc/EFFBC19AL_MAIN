table 60000 "Form Tracking"
{
    // version B2B1.0

    DrillDownPageID = "Form Tracking";
    LookupPageID = "Form Tracking";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Form Code"; Code[10])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(2; "Form No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(4; State; Code[10])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; "Document Type"; Option)
        {
            Editable = false;
            OptionMembers = "Order",Invoice;
            DataClassification = CustomerContent;
        }
        field(6; "Document No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(7; "Vendor / Customer No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(8; "Invoice Base Amount"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(9; "Sales Tax Base Amount"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(10; "Sales Tax Amount"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(11; Status; Option)
        {
            OptionMembers = Open,Released;
            DataClassification = CustomerContent;
        }
        field(12; Type; Option)
        {
            Editable = false;
            OptionMembers = Purchase,Sale;
            DataClassification = CustomerContent;
        }
        field(13; "Posting Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(14; "Entry No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(15; "Release Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16; "Issue Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(17; "Assign Form No."; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Form Code", "Document No.", "Entry No.")
        {
        }
        key(Key2; "Form Code", "Form No.", "Vendor / Customer No.")
        {
            SumIndexFields = "Sales Tax Base Amount";
        }
    }

    fieldgroups
    {
    }
}

