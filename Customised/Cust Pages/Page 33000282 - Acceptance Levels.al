page 33000282 "Acceptance Levels"
{
    // version QC1.0

    PageType = Worksheet;
    SourceTable = "Acceptance Level";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
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
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor Rating"; Rec."Vendor Rating")
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

