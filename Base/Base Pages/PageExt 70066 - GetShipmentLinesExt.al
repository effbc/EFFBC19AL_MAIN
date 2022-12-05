pageextension 70066 GetShipmentLinesExt extends "Get Shipment Lines"
{

    layout
    {


        /* modify("Control1")
         {


             ShowCaption = false;
         }*/



        addafter("Document No.")
        {
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {



    }



}

