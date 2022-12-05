pageextension 70300 StopCodesExt extends "Stop Codes"
{
    layout
    {
        addafter(Description)
        {
            field(Department; Rec.Department)
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}