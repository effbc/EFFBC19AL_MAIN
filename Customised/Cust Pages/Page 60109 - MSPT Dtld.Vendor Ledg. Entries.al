page 60109 "MSPT Dtld.Vendor Ledg. Entries"
{
    // version MSPT1.0

    // B2B Software Technologies
    // ---------------------------------------------------
    // Project : Mile Stone Payment Terms
    // B2B
    // No. sign   Description
    // ---------------------------------------------------
    // 01  B2B    MSPT Detailed Vendor Ledger Entry

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "MSPT Dtld. Vendor Ledg. Entry";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Ledger Entry No."; Rec."Vendor Ledger Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("MSPT Header Code"; Rec."MSPT Header Code")
                {
                    ApplicationArea = All;
                }
                field("MSPT Line Code"; Rec."MSPT Line Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("MSPT Amount"; Rec."MSPT Amount")
                {
                    ApplicationArea = All;
                }
                field("MSPT Due Date"; Rec."MSPT Due Date")
                {
                    ApplicationArea = All;
                }
                field("MSPT Vend. Led. Entry No."; Rec."MSPT Vend. Led. Entry No.")
                {
                    ApplicationArea = All;
                }
                field("MSPT Dtld. Entry No."; Rec."MSPT Dtld. Entry No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

