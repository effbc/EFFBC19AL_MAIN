pageextension 70042 DetailedGSTLedgerEntryExt extends "Detailed GST Ledger Entry"
{


    layout
    {


        /*modify("Control 1501037")
        {
            Visible = false;
        }
        modify("Control 1501040")
        {
            Visible = false;
        }
        modify("Control 1501041")
        {
            Visible = false;
        }
        modify("Control 1501042")
        {
            Visible = false;
        }*/
        addafter("Payment Type")
        {
            /*field("Bill of Entry No."; "Bill of Entry No.")
            {
                ApplicationArea = All;
            }
            field("Bill of Entry Date"; "Bill of Entry Date")
            {
                ApplicationArea = All;
            }*/

        }
        addafter("GST Place of Supply")
        {
            /* field("Remaining Base Amount"; "Remaining Base Amount")
            {
                Editable = true;
                ApplicationArea = All;
            } */
            field("Remaining GST Amount"; Rec."Remaining GST Amount")
            {
                Editable = true;
                ApplicationArea = All;
            }
        }
        //  moveafter("Cess Factor Quantity"; "Control 1502003")
    }
    actions
    {



    }



}

