pageextension 70256 VendorItemCatlogExt extends "Vendor Item Catalog"
{
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        } */
        addafter("Item No.")
        {
            field(Description; Rec.Description)
            {
                ApplicationArea = All;
            }
            field(Approved; Rec.Approved)
            {
                ApplicationArea = All;
            }
        }
        addafter("Vendor Item No.")
        {
            field("Sampling Plan Code"; Rec."Sampling Plan Code")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {

    }

}

