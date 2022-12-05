pageextension 70168 ReservationEntriesExt extends 497
{


    layout
    {



        /*modify("Control1")
        {

           

            ShowCaption = false;
        }*/



        addafter("Shipment Date")
        {
            field(Quantity; Rec.Quantity)
            {
                ApplicationArea = All;
            }
        }
        addafter("Quantity (Base)")
        {
            field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
            {
                ApplicationArea = All;
            }
        }
        addafter("Transferred from Entry No.")
        {
            field("Item Ledger Entry No."; Rec."Item Ledger Entry No.")
            {
                Editable = true;
                ApplicationArea = All;
            }
            field("Item Tracking"; Rec."Item Tracking")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {


    }



}

