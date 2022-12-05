table 60074 "Tender Documents"
{
    // version B2B1.0

    DrillDownPageID = "Tender Documents Subform";
    LookupPageID = "Tender Documents Subform";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; Type; Option)
        {
            OptionMembers = FDR,BG;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(4; Purpose; Option)
        {
            OptionMembers = " ",EMD,SD;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(5; "No."; Code[20])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(6; "Payment/Receipt/Adjusted Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(8; Amount; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Transaction Type"; Option)
        {
            OptionMembers = Payment,Receipt,Adjustment;
            DataClassification = CustomerContent;
        }
        field(10; "Received / Adjusted"; Boolean)
        {
            Editable = false;
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


    procedure TestStatusOpen();
    var
        TenderHeader: Record "Tender Header";
    begin
        TenderHeader.SetRange("Tender No.", "Document No.");
        if TenderHeader.Find('-') then
            TenderHeader.TestField(Status, TenderHeader.Status::Open);
    end;
}

