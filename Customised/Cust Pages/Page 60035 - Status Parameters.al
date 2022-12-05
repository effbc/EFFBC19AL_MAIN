page 60035 "Status Parameters"
{
    // version B2B1.0

    PageType = Worksheet;
    SourceTable = "Status Parameters";

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
                field("Status Sequence"; Rec."Status Sequence")
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

