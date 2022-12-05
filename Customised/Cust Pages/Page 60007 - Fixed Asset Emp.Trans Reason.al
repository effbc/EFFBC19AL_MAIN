page 60007 "Fixed Asset Emp.Trans Reason"
{
    // version B2B1.0

    PageType = Worksheet;
    SourceTable = "Fixed Asset Transfer";

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
                field("Fixed Asset No."; Rec."Fixed Asset No.")
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
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        IF (Rec."Fixed Asset No." <> '') AND (Rec."Employee Trns. Reason" = '') THEN
            ERROR('Plz Enter the Transfer reason');
    end;
}

