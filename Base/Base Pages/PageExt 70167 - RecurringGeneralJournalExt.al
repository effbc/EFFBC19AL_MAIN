pageextension 70167 RecurringGeneralJournalExt extends "Recurring General Journal"
{
    layout
    {
        /* modify("Control1")
        {
            ShowCaption = false;
        }
        modify(Control28)
        {
            ShowCaption = false;
        }
        modify(Control1902205001)
        {
            ShowCaption = false;
        } */
        addafter("Account Type")
        {
            field("Payment Type"; Rec."Payment Type")
            {
                ApplicationArea = All;
            }
        }
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
        modify(Allocations)
        {
            Promoted = true;
        }
        modify("Ledger E&ntries")
        {
            Promoted = false;
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
        /* modify(Approve)
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
        } */
    }
}

