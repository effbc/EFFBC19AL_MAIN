pageextension 70126 PostedTransferRcptSubformExt extends "Posted Transfer Rcpt. Subform"
{


    layout
    {

        /* modify("Control1")
         {



             ShowCaption = false;
         }*/

        addafter("Variant Code")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Reason Code"; Rec."Reason Code")
            {
                ApplicationArea = All;
            }
            field("Position Reference No."; Rec."Position Reference No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Unit of Measure Code")
        {
            field("Allow Excess Qty."; Rec."Allow Excess Qty.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {


    }




    var
    // StrOrderLineDetailsPage: Page "Posted Str Order Line Details";

    /* procedure StrOrderLineDetailsPage();
     begin
     end;*/




}

