page 33000286 "Sub Assembly Unit of Measure"
{
    // version WIP1.0

    PageType = Worksheet;
    SourceTable = "Sub Assembly Unit of Measure";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Sub Assembly No."; Rec."Sub Assembly No.")
                {
                    Caption = 'Sub Assembly No.';
                    ApplicationArea = All;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Length; Rec.Length)
                {
                    ApplicationArea = All;
                }
                field(Width; Rec.Width)
                {
                    ApplicationArea = All;
                }
                field(Height; Rec.Height)
                {
                    ApplicationArea = All;
                }
                field(Cubage; Rec.Cubage)
                {
                    ApplicationArea = All;
                }
                field(Weight; Rec.Weight)
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

