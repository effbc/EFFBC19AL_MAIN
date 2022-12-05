pageextension 70297 RoutingVersionLinesExt extends "Routing Version Lines"
{
    layout
    {
        addafter("Operation No.")
        {
            field("Operation Description"; Rec."Operation Description")
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