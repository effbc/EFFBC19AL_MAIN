pageextension 70074 InventoryPostingGroupsExt extends "Inventory Posting Groups"
{
    Editable = false;
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        } */

    }
    actions
    {
        modify("&Setup")
        {
            Promoted = true;
        }
    }
}

