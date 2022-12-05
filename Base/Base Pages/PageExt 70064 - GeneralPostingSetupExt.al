pageextension 70064 GeneralPostingSetupExt extends "General Posting Setup"
{
    Editable = true;
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        }
        modify("Control 52")
        {
            ShowCaption = false;
        } */
    }
    actions
    {
        modify("&Copy")
        {
            Promoted = true;
        }
    }
}

