pageextension 70061 GeneralJournalBatchesExt extends 251
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
        modify(EditJournal)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("P&ost")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Post and &Print")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Recurring General Journal")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        /* modify("Close Income Statement")
        {
            Promoted = true;
            PromotedIsBig = true;
        } */
        modify("G/L Register")
        {
            Promoted = true;
        }
        modify("Detail Trial Balance")
        {
            Promoted = true;
        }
        modify("Trial Balance")
        {
            Promoted = true;
        }
        modify("Trial Balance by Period")
        {
            Promoted = false;
        }
        modify(Action10)
        {
            Promoted = true;
        }
    }


}

