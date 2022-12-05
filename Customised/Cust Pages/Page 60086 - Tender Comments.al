page 60086 "Tender Comments"
{
    // version B2B1.0

    AutoSplitKey = true;
    PageType = Worksheet;
    SourceTable = "Tender Comment Line";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec.SetUpNewLine;
    end;
}

