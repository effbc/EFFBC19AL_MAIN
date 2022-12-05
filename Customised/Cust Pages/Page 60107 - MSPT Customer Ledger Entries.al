page 60107 "MSPT Customer Ledger Entries"
{
    // version MSPT1.0,Rev01

    // B2B Software Technologies
    // ---------------------------------------------------
    // Project : Mile Stone Payment Terms
    // B2B
    // No. sign   Description
    // ---------------------------------------------------
    // 01  B2B    MSPT Customer Ledger Entry

    DataCaptionFields = "Customer No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "MSPT Customer Ledger Entry";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("MSPT Percentage"; Rec."MSPT Percentage")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("MSPT Amount"; Rec."MSPT Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("MSPT Remaining Amount"; Rec."MSPT Remaining Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Open; Rec.Open)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("MSPT Header Code"; Rec."MSPT Header Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("MSPT Line Code"; Rec."MSPT Line Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("MSPT Due Date"; Rec."MSPT Due Date")
                {
                    ApplicationArea = All;
                }
                field("MSPT Entry No."; Rec."MSPT Entry No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                action("MSPT &Dtld Cust Ledg Entry")
                {
                    Caption = 'MSPT &Dtld Cust Ledg Entry';
                    Image = LedgerEntries;
                    RunObject = Page 60108;
                    RunPageLink = "MSPT Cust. Led. Entry No." = FIELD("MSPT Entry No.");
                    ApplicationArea = All;
                }
            }
        }
    }
}

