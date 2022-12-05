page 33000252 "Sampling Plan List"
{
    // version QC1.0

    CardPageID = "Sampling Plan Header";
    Editable = false;
    PageType = List;
    SourceTable = "Sampling Plan Header";
    UsageCategory = Lists;
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
            }
        }
    }

    actions
    {
    }
}

