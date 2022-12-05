pageextension 70107 PaymentJournalExt extends "Payment Journal"
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
        modify(Control80)
        {
            ShowCaption = false;
        }
        modify(Control82)
        {
            ShowCaption = false;
        }
        modify(Control1903561801)
        {
            ShowCaption = false;
        } */
        addafter(TotalBalance)
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
        modify(SuggestVendorPayments)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(PrintCheck)
        {
            Promoted = true;
        }
        modify("Void Check")
        {
            Promoted = true;
        }
        modify(CreditTransferRegEntries)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(CreditTransferRegisters)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(ApplyEntries)
        {
            Promoted = true;
        }
        modify(ExportPaymentsToFile)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(CalculatePostingDate)
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

