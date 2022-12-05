pageextension 70319 MachineCenterTaskListExt extends "Machine Center Task List"
{
    layout
    {
        addafter("Operation No.")
        {
            field("Operation Description"; Rec."Operation Description")
            {
                ApplicationArea = All;

            }
            field("Qty.To Produce"; Rec."Qty.To Produce")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("Item No."; Rec."Item No.")
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
            field(Quantity; Rec.Quantity)
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        addafter("Move Time Unit of Meas. Code")
        {
            field("Total Time"; Rec."Total Time")
            {
                Visible = false;
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