table 60075 "Tender Ledger Entries"
{
    // version B2B1.0

    DrillDownPageID = "Tender Ledger Entries";
    LookupPageID = "Tender Ledger Entries";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Tender No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(5; Type; Option)
        {
            OptionMembers = EMD,SD,Cost;
            DataClassification = CustomerContent;
        }
        field(6; "Transaction Type"; Option)
        {
            OptionMembers = Payment,Receipt,Adjustment,"Write off";
            DataClassification = CustomerContent;
        }
        field(7; "Mode of Receipt / Payment"; Option)
        {
            OptionMembers = Cash,Bank,FDR,BG,Customer," ";
            DataClassification = CustomerContent;
        }
        field(8; "No."; Code[20])
        {
            TableRelation = IF ("Mode of Receipt / Payment" = CONST(Cash)) "G/L Account"."No."
            ELSE
            IF ("Mode of Receipt / Payment" = CONST(Bank)) "Bank Account"."No."
            ELSE
            IF ("Mode of Receipt / Payment" = CONST(BG)) "Bank Guarantee"."BG No."
            ELSE
            IF ("Mode of Receipt / Payment" = CONST(FDR)) "FDR Master"."No.";
            DataClassification = CustomerContent;
        }
        field(9; Description; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(12; Amount; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(13; "Cheque No."; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(14; "Cheque Date."; Date)
        {
            DataClassification = CustomerContent;
        }
        field(15; "Tender Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(16; "Document No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Tender No.", "Transaction Type", Type, "Mode of Receipt / Payment")
        {
            SumIndexFields = Amount;
        }
        key(Key3; "Document No.")
        {
        }
    }

    fieldgroups
    {
    }
}

