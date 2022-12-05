page 60005 "Fixed Asset Transfer"
{
    // version B2B1.0

    Editable = false;
    PageType = List;
    SourceTable = "Fixed Asset Transfer";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Fixed Asset No."; Rec."Fixed Asset No.")
                {
                    ApplicationArea = All;
                }
                field("FA Location"; Rec."FA Location")
                {
                    ApplicationArea = All;
                }
                field("FA New Location"; Rec."FA New Location")
                {
                    ApplicationArea = All;
                }
                field("Location Trns. Reason"; Rec."Location Trns. Reason")
                {
                    ApplicationArea = All;
                }
                field("Responsible Employee"; Rec."Responsible Employee")
                {
                    ApplicationArea = All;
                }
                field("New Responsible Employee"; Rec."New Responsible Employee")
                {
                    ApplicationArea = All;
                }
                field("Employee Trns. Reason"; Rec."Employee Trns. Reason")
                {
                    ApplicationArea = All;
                }
                field("User id"; Rec."User id")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
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

