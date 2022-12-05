page 60054 "Item Sub Group"
{
    // version B2B1.0

    PageType = Worksheet;
    SourceTable = "Item Sub Group";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                }
                field("Cycle Time";"Cycle Time")
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

