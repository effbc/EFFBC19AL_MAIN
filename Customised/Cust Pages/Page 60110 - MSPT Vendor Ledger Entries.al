page 60110 "MSPT Vendor Ledger Entries"
{
    // version MSPT1.0,Rev01

    // B2B Software Technologies
    // ---------------------------------------------------
    // Project : Mile Stone Payment Terms
    // B2B
    // No. sign   Description
    // ---------------------------------------------------
    // 01  B2B    MSPT Vendor Ledger Entry

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "MSPT Vendor Ledger Entry";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
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
                field("MSPT Due Date"; Rec."MSPT Due Date")
                {
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
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
                action("MSPT &Dtld Vend Ledg Entries")
                {
                    Caption = 'MSPT &Dtld Vend Ledg Entries';
                    Image = LedgerEntries;
                    RunObject = Page "MSPT Dtld.Vendor Ledg. Entries";
                    RunPageLink = "MSPT Vend. Led. Entry No." = FIELD("MSPT Entry No.");
                    ApplicationArea = All;
                }
            }
        }
    }
}

