pageextension 70019 BankAccountStatementLinesExt extends "Bank Account Statement Lines"
{
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        }
        modify(Control16)
        {
            ShowCaption = false;
        } */
        addafter("Applied Entries")
        {
            field("Bank Acc LE"; Rec."Bank Acc LE")
            {
                ApplicationArea = All;
            }
        }
    }
}

