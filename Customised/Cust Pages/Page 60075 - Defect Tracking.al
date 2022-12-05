page 60075 "Defect Tracking"
{
    // version B2B1.0

    AutoSplitKey = true;
    PageType = Worksheet;
    SourceTable = "Defect Tracking Details";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Component No."; Rec."Component No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                }
                field("Position 2"; Rec."Position 2")
                {
                    ApplicationArea = All;
                }
                field("Position 3"; Rec."Position 3")
                {
                    ApplicationArea = All;
                }
                field("Defect Code"; Rec."Defect Code")
                {
                    ApplicationArea = All;
                }
                field(Qty; Rec.Qty)
                {
                    Caption = 'Defect Quantity';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Disposition Actions"; Rec."Disposition Actions")
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

