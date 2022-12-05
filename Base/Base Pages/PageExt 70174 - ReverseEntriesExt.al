pageextension 70174 ReverseEntriesExt extends "Reverse Entries"
{
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        } */


    }
    actions
    {


        modify(Reverse)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Reverse and &Print")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
    }


}

