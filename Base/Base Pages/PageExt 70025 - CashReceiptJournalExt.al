pageextension 70025 CashReceiptJournalExt extends 255
{
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        }
        modify(Control24)
        {
            ShowCaption = false;
        }
        modify(Control1903561801)
        {
            ShowCaption = false;
        } */
        addafter("Total Balance")
        {
            group("Work Date")
            {
                Caption = 'Work Date';
                field(WorkDate; WORKDATE)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
        /* addbefore("Campaign No.")
         {
             field("TDS Certificate Receivable"; "TDS Certificate Receivable")
             {
                 Visible = false;
                 ApplicationArea = All;
             }
         }
         */
        movebefore("Campaign No."; "TDS Certificate Receivable")
    }
    actions
    {
        modify(Dimensions)
        {
            Promoted = true;
        }
        modify(IncomingDoc)
        {
            Promoted = true;
        }
        modify("Ledger E&ntries")
        {
            Promoted = false;
        }
        modify("Apply Entries")
        {
            Promoted = true;
        }
        modify(Reconcile)
        {
            Promoted = true;
        }
        modify(Post)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Post and &Print")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Approve)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Reject)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Delegate)
        {
            Promoted = true;
        }
        modify(Comment)
        {
            Promoted = true;
        }
    }
}

