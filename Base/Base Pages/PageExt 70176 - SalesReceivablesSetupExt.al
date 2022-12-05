pageextension 70176 SalesReceivablesSetupExt extends "Sales & Receivables Setup"
{


    layout
    {



        addafter("Posted Credit Memo Nos.")
        {
            field("Tender Nos."; Rec."Tender Nos.")
            {
                ApplicationArea = All;
            }
            field("Tender Posting Nos."; Rec."Tender Posting Nos.")
            {
                ApplicationArea = All;
            }
            field(SingleQuoteValue; Rec.SingleQuoteValue)
            {
                ApplicationArea = ALL;
            }
            field("Third Party Nos."; Rec."Third Party Nos.")
            {
                ApplicationArea = ALL;
            }
        }
    }


}

