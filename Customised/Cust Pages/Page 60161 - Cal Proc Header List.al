page 60161 "Cal Proc Header List"
{
    // version Cal1.0

    Caption = 'Cal Proc Header List';
    CardPageID = "Calibration Procedure";
    Editable = false;
    PageType = List;
    SourceTable = "Calibration Procedure Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
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

    var
        CalProcSetup: Record "Calibration Setup";
}

