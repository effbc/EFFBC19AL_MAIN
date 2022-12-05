pageextension 70285 "DetailedVendorLedg.EntriesExt" extends "Detailed Vendor Ledg. Entries"
{
    Editable = true;
    layout
    {
        addfirst(Control1)
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}