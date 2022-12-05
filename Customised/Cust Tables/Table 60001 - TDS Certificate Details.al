table 60001 "TDS Certificate Details"
{
    // version B2B1.0

    LookupPageID = "TDS Certificate Details";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(2; "Document Type"; Option)
        {
            Editable = false;
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Posting,FullFinal,Reimbursement;
            DataClassification = CustomerContent;
        }
        field(3; "Customer Acc.No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(4; "Invoice No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(5; "TDS / Work Tax Amount"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6; "Posting Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(7; Type; Option)
        {
            Editable = false;
            OptionMembers = TDS,"Work Tax ";
            DataClassification = CustomerContent;
        }
        field(8; "TDS Certificate No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus;
            end;
        }
        field(9; "Certificate Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus;
            end;
        }
        field(10; "Receipt Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus;
            end;
        }
        field(11; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,Released;
            DataClassification = CustomerContent;
        }
        field(12; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(13; Assign; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Document No.", "Document Type", "Customer Acc.No.", "Invoice No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        Error('You cannot delete TDS Certificate Detials');
    end;


    procedure TestStatus();
    begin
        TestField(Status, Status::Open);
    end;
}

