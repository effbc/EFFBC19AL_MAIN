page 60006 "Fixed Assert Location Transfer"
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
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        IF (Rec."Location Trns. Reason" = '') AND (Rec."Fixed Asset No." <> '') THEN
            ERROR('Plz Enter the Transfer reason');
    end;
}

