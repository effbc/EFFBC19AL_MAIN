pageextension 70011 ApplyVendorEntriesExt extends "Apply Vendor Entries"
{
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        }
        modify(Control41)
        {
            ShowCaption = false;
        }
        modify(Control1903222401)
        {
            ShowCaption = false;
        } */
        addafter(Description)
        {
            field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(ActionSetAppliesToID)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(ActionPostApplication)
        {
            Promoted = true;
        }
        modify(Navigate)
        {
            Promoted = true;
        }
    }


}

