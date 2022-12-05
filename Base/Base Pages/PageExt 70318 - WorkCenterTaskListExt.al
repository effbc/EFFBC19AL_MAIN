pageextension 70318 WorkCenterTaskListExt extends "Work Center Task List"
{
    layout
    {
        addafter("Prod. Order No.")
        {
            field("Item No."; Rec."Item No.")
            {
                ApplicationArea = All;

            }
            field("Item Description"; Rec."Item Description")
            {
                ApplicationArea = All;

            }
            field("Routing Reference No."; Rec."Routing Reference No.")
            {
                ApplicationArea = All;

            }
        }
        addafter("Operation No.")
        {
            field("Operation Description"; Rec."Operation Description")
            {
                ApplicationArea = All;

            }
        }
        addafter(Description)
        {
            field("Starting Date-Time"; Rec."Starting Date-Time")
            {
                ApplicationArea = All;

            }
            field("Ending Date-Time"; Rec."Ending Date-Time")
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