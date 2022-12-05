page 60068 "cform master"
{
    PageType = List;
    SourceTable = CFormlist;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                ShowCaption = false;
                field(vendor; Rec.vendor)
                {
                    ApplicationArea = All;
                }
                field("Vendor name"; Rec."Vendor name")
                {
                    ApplicationArea = All;
                }
                field("C FORM"; Rec."C FORM")
                {
                    ApplicationArea = All;
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field("C_FORM DATE"; Rec."C_FORM DATE")
                {
                    ApplicationArea = All;
                }
                field("C_FORM NO"; Rec."C_FORM NO")
                {
                    ApplicationArea = All;
                }
                field("creationdate time"; Rec."creationdate time")
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

