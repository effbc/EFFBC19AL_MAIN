page 60163 "Cal Proc Subform"
{
    // version Cal1.0

    AutoSplitKey = true;
    Caption = 'Cal Proc Subform';
    PageType = ListPart;
    SourceTable = "Calibration Procedure Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
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
}

