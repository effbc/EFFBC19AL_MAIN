pageextension 70111 PostedItemTrackingLinesExt extends "Posted Item Tracking Lines"
{


    layout
    {



      /*  modify("Control1")
        {


            ShowCaption = false;
        }*/



        addafter(Quantity)
        {
            field("Entry No."; Rec."Entry No.")
            {
                ApplicationArea = All;
            }
        }
    }



}

