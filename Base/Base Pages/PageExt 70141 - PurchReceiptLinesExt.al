pageextension 70141 PurchReceiptLinesExt extends "Purch. Receipt Lines"
{



    layout
    {


        /*modify("Control1")
        {

         

            ShowCaption = false;
        }*/

    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.SETFILTER(Type, '<>%1&<>%2', Rec.Type::" ", Rec.Type::"Charge (Item)");    // Added by Pranavi on 25-Oct-2017 for allowing

    end;




}


