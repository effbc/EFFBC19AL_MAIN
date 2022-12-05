table 60073 "FDR Master"
{
    // version B2B1.0

    LookupPageID = "FDR List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; "FDR Document No."; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Issued To"; Option)
        {
            OptionMembers = " ",Customer;
            DataClassification = CustomerContent;
        }
        field(5; "Issued Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Issuing Bank"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Date of Issue"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Expiry Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(9; Purpose; Option)
        {
            Editable = false;
            OptionMembers = " ",EMD,"Security Deposit","Adjusted to SD";
            DataClassification = CustomerContent;
        }
        field(10; Remarks; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(11; "FDR Value"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Posted = true then
                    Error('You can not change the FDR value the entry is already posted');
            end;
        }
        field(12; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,Released;
            DataClassification = CustomerContent;
        }
        field(13; "FDR Surrended to Bank"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(14; "FDR Surrended Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(15; "Creation Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16; "Last Modified Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(17; Extended; Option)
        {
            OptionMembers = " ",Amount,Date,Both;
            DataClassification = CustomerContent;
        }
        field(18; "Mode of Payment"; Option)
        {
            OptionMembers = Cash,Bank;
            DataClassification = CustomerContent;
        }
        field(19; "Payment Account No."; Code[20])
        {
            TableRelation = IF ("Mode of Payment" = CONST(Cash)) "G/L Account"."No." WHERE("Cash Account" = CONST(true))
            ELSE
            IF ("Mode of Payment" = CONST(Bank)) "Bank Account"."No." WHERE("Currency Code" = FILTER(= ''));
            DataClassification = CustomerContent;
        }
        field(20; Closed; Boolean)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50; "Issued/Received"; Option)
        {
            Editable = false;
            OptionMembers = " ",Issued,Received;
            DataClassification = CustomerContent;
        }
        field(51; "Tender No."; Code[20])
        {
            Editable = false;
            TableRelation = "Tender Header"."Tender No.";
            DataClassification = CustomerContent;
        }
        field(52; "Mode of Receipt"; Option)
        {
            OptionMembers = Cash,Bank;
            DataClassification = CustomerContent;
        }
        field(53; "Receipt Account No."; Code[20])
        {
            TableRelation = IF ("Mode of Receipt" = CONST(Cash)) "G/L Account"."No." WHERE("Cash Account" = CONST(true))
            ELSE
            IF ("Mode of Receipt" = CONST(Bank)) "Bank Account"."No." WHERE("Currency Code" = FILTER(= ''));
            DataClassification = CustomerContent;
        }
        field(101; "Posting Account No."; Code[20])
        {
            TableRelation = "G/L Account"."No.";
            DataClassification = CustomerContent;
        }
        field(102; Posted; Boolean)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(103; "FDR Posting Status"; Option)
        {
            Editable = false;
            OptionMembers = " ",Purchased,Surrendered;
            DataClassification = CustomerContent;
        }
        field(60000; "Customer Order No."; Text[30])
        {
            Caption = 'Customer Order No.';
            Description = 'B2B';
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                if PAGE.RunModal(45, SalesHeader) = ACTION::LookupOK then
                    "Customer Order No." := SalesHeader."Customer OrderNo.";
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        "Creation Date" := WorkDate;
    end;

    trigger OnModify();
    begin
        "Last Modified Date" := WorkDate;
    end;

    var
        SalesHeader: Record "Sales Header";


    procedure FDRAttachments();
    var
        Attachments: Record Attachments;
    begin
        Attachments.Reset;
        Attachments.SetRange("Table ID", DATABASE::"FDR Master");
        Attachments.SetRange("Document No.", "No.");

        PAGE.Run(PAGE::"ESPL Attachments", Attachments);
    end;
}

