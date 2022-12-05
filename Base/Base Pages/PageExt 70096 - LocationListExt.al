pageextension 70096 LocationListExt extends "Location List"
{
    layout
    {

    }
    actions
    {
        modify("Transfer Order")
        {
            Promoted = true;
        }
        modify("Create Warehouse location")
        {
            Promoted = true;
        }
        modify("Inventory - Inbound Transfer")
        {
            Promoted = true;
        }
        modify(Action1907283206)
        {
            Promoted = true;
        }
        modify("Transfer Shipment")
        {
            Promoted = false;
        }
        modify("Transfer Receipt")
        {
            Promoted = false;
        }
    }
}

