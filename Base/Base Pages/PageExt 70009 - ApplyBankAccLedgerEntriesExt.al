pageextension 70009 ApplyBankAccLedgerEntriesExt extends "Apply Bank Acc. Ledger Entries"
{
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        }
        modify(Control7)
        {
            ShowCaption = false;
        } */
        modify(Control15)
        {
            ShowCaption = false;
        }
        addafter("Global Dimension 2 Code")
        {
            field("Entry No."; Rec."Entry No.")
            {
                ApplicationArea = All;
            }
        }
    }
}

