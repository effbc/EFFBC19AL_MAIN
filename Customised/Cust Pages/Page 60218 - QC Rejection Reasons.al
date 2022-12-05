page 60218 "QC Rejection Reasons"
{
    PageType = Worksheet;
    SourceTable = "QC Rejection Master";

    layout
    {
        area(content)
        {
            repeater(Control1102154001)
            {
                ShowCaption = false;
                field("Rejection Reason"; Rec."Rejection Reason")
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

