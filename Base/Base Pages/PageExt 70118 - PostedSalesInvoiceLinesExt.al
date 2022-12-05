pageextension 70118 PostedSalesInvoiceLinesExt extends "Posted Sales Invoice Lines"
{
    layout
    {
        addafter("Document No.")
        {
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;

            }
            field("Line Amount";"Line Amount")
            {
                ApplicationArea =All;
            }
            field("Amount to Customer";"Amount to Customer")
            {
                ApplicationArea =All;
            }
        }
    }
}

