pageextension 70041 DetailedCustLedgEntriesExt extends "Detailed Cust. Ledg. Entries"
{


    layout
    {



        /* modify("Control1")
         {


             ShowCaption = false;
         }*/

        modify("Posting Date")
        {
            Editable = true;
        }
        addafter("Customer No.")
        {
            field("Payment Type"; Rec."Payment Type")
            {
                ApplicationArea = All;
            }
        }

        addafter("Entry No.")
        {
            field("Applied Cust. Ledger Entry No."; Rec."Applied Cust. Ledger Entry No.")
            {
                ApplicationArea = All;
            }
            field("Application No."; Rec."Application No.")
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

