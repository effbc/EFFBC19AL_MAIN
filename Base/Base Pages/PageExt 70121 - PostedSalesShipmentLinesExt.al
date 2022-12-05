pageextension 70121 PostedSalesShipmentLinesExt extends "Posted Sales Shipment Lines"
{
    layout
    {
        addafter("Document No.")
        {
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;

            }
        }
    }
}

