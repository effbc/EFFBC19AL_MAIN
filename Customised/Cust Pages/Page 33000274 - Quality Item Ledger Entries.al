page 33000274 "Quality Item Ledger Entries"
{
    // version QC1.0

    Editable = true;
    PageType = List;
    Permissions = TableData "Quality Item Ledger Entry" = rm;
    SourceTable = "Quality Item Ledger Entry";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            field("COUNT"; Rec.COUNT)
            {
                ApplicationArea = All;
            }
            repeater(Control1000000000)
            {
                Editable = true;
                ShowCaption = false;
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
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
                field("Child Ids"; Rec."Child Ids")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Invoiced Quantity"; Rec."Invoiced Quantity")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Applies-to Entry"; Rec."Applies-to Entry")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Open; Rec.Open)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Originally Ordered No."; Rec."Originally Ordered No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Originally Ordered Var. Code"; Rec."Originally Ordered Var. Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Warranty Date"; Rec."Warranty Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Declared Goods"; Rec."Declared Goods")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Inspection Status"; Rec."Inspection Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quality Ledger Entry No."; Rec."Quality Ledger Entry No.")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Accept; Rec.Accept)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Rework; Rec.Rework)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Reject; Rec.Reject)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Accept Under Deviation"; Rec."Accept Under Deviation")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                }
                field("Purch.Rcpt Line"; Rec."Purch.Rcpt Line")
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

