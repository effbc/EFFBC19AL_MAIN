page 33000265 "Posted Inspect Data Sheet List"
{
    // version QC1.0

    CardPageID = "Posted Inspection Data Sheet";
    Editable = false;
    PageType = List;
    SourceTable = "Posted Inspect DatasheetHeader";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("OutPut Jr Serial No."; Rec."OutPut Jr Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Reason for Pending"; Rec."Reason for Pending")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                }
                field("Item Sub Group Code"; Rec."Item Sub Group Code")
                {
                    ApplicationArea = All;
                }
                field("Item Sub Sub Group Code"; Rec."Item Sub Sub Group Code")
                {
                    ApplicationArea = All;
                }
                field("Prod. Description"; Rec."Prod. Description")
                {
                    ApplicationArea = All;
                }
                field("Operation Description"; Rec."Operation Description")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order Line"; Rec."Prod. Order Line")
                {
                    ApplicationArea = All;
                }
                field("Rework Level"; Rec."Rework Level")
                {
                    ApplicationArea = All;
                }
                field("Rework Reference No."; Rec."Rework Reference No.")
                {
                    ApplicationArea = All;
                }
                field("Item Ledger Entry No."; Rec."Item Ledger Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Spec ID"; Rec."Spec ID")
                {
                    ApplicationArea = All;
                }
                field("Inspection Group Code"; Rec."Inspection Group Code")
                {
                    ApplicationArea = All;
                }
                field("Issues For Pending"; Rec."Issues For Pending")
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

