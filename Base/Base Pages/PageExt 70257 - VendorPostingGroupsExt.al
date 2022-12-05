pageextension 70257 VendorPostingGroupsExt extends "Vendor Posting Groups"
{
    Editable = true;
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        } */
        modify("Invoice Rounding Account")
        {
            Visible = false;
        }
    }

}

