page 60094 "Design Check List"
{
    // version B2B1.0

    AutoSplitKey = true;
    PageType = Worksheet;
    SourceTable = "Design Check List";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Tender No."; Rec."Tender No.")
                {
                    ApplicationArea = All;
                }
                field(Description1; Rec.Description1)
                {
                    ApplicationArea = All;
                }
                field("QTY."; Rec."QTY.")
                {
                    ApplicationArea = All;
                }
                field(Description2; Rec.Description2)
                {
                    ApplicationArea = All;
                }
                field(Description3; Rec.Description3)
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
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

