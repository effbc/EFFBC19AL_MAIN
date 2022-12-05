page 60052 "Specification Parameters"
{
    // version B2B1.0

    PageType = Worksheet;
    SourceTable = "Specification Parameters";

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
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        Rec."User Id" := USERID;
    end;
}

