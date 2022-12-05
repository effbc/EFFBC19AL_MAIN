pageextension 70007 AppliedItemEntriesExt extends "Applied Item Entries"
{
    // version NAVW19.00.00.45778

    layout
    {



        /* modify(Control1)
         {



             ShowCaption = false;
         }*/


        addafter("Variant Code")
        {
            field("Serial No."; Rec."Serial No.")
            {
                ApplicationArea = All;
            }
            field("Lot No."; Rec."Lot No.")
            {
                ApplicationArea = All;
            }
            field("Prod. Order Comp. Line No."; Rec."Prod. Order Comp. Line No.")
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

    var
        TrackingPage: Page 99000822;



}

