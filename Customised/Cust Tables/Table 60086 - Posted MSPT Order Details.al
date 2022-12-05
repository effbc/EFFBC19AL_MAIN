table 60086 "Posted MSPT Order Details"
{
    DataClassification = CustomerContent;
    // version MSPT1.0

    // B2B Software Technologies
    // ---------------------------------------------------
    // Project : Mile Stone Payment Terms
    // B2B
    // No. sign   Description
    // ---------------------------------------------------
    // 01  B2B    Posted MSPT Order Details


    fields
    {
        field(1; Type; Option)
        {
            OptionMembers = Sale,Purchase;
            DataClassification = CustomerContent;
        }
        field(2; "Document Type"; Option)
        {
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
            DataClassification = CustomerContent;
        }
        field(3; "Party Type"; Option)
        {
            OptionMembers = Customer,Vendor;
            DataClassification = CustomerContent;
        }
        field(4; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Document Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Party No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(7; "MSPT Header Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Calculation Type"; Option)
        {
            Enabled = false;
            OptionMembers = Percentage,"Fixed Value";
            DataClassification = CustomerContent;
        }
        field(9; "MSPT Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(10; "MSPT Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(11; Percentage; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(12; Description; Text[80])
        {
            DataClassification = CustomerContent;
        }
        field(13; "Calulation Period"; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(14; Amount; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(15; Remarks; Text[80])
        {
            DataClassification = CustomerContent;
        }
        field(16; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Type, "Document Type", "Party Type", "Document No.", "Document Line No.", "Party No.", "MSPT Header Code", "MSPT Line No.", "MSPT Code", Percentage, Description, "Calulation Period", "Due Date")
        {
        }
    }

    fieldgroups
    {
    }
}

