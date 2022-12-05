pageextension 70069 GLEntriesPreviewExt extends "G/L Entries Preview"
{
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        } */
        modify("Additional-Currency Amount")
        {
            Visible = false;
        }
        modify("VAT Amount")
        {
            Visible = false;
        }
    }
    actions
    {

    }
}

