pageextension 70079 ItemJournalBatchesExt extends "Item Journal Batches"
{
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        } */
        addafter("Reason Code")
        {
            field("Material Issues"; Rec."Material Issues")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("Edit Journal")
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
    }
}

