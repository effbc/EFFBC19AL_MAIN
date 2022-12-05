pageextension 70085 ItemTrackingEntriesExt extends "Item Tracking Entries"
{
    // version NAVW17.00

    layout
    {



        /*modify(Control1)
        {

           

            ShowCaption = false;
        }*/


        addafter("Item No.")
        {
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {



        modify("&Navigate")
        {
            Promoted = true;



        }
    }




}

