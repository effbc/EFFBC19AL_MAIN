pageextension 70262 WhsePutawaySubformExt extends "Whse. Put-away Subform"
{


    layout
    {



        /* modify("Control1")
         {


             ShowCaption = false;
         }*/


        addafter(Description)
        {
            field("Quantity Accepted"; Rec."Quantity Accepted")
            {
                ApplicationArea = All;
            }
            field("Quantity Rework"; Rec."Quantity Rework")
            {
                ApplicationArea = All;
            }
            field("Quantity Rejected"; Rec."Quantity Rejected")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {


    }



}

