page 60132 "ICN Numbers"
{
    // version POAU

    PageType = Worksheet;
    SourceTable = "ICN Numbers";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("ICN No."; Rec."ICN No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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

