tableextension 70206 SalesCueExt extends "Sales Cue"
{
    fields
    {
        field(50000; SaleInvoiceToday; Integer)
        {
            TableRelation = "Sales Invoice Header"."No." WHERE("Posting Date" = FILTER(>= 20190401D));
            DataClassification = CustomerContent;
        }
    }



}

