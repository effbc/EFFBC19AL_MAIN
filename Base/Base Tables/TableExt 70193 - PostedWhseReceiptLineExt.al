tableextension 70193 PostedWhseReceiptLineExt extends "Posted Whse. Receipt Line"
{
    fields
    {
        field(33000250; "Quantity Accepted"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(33000251; "Quantity Rework"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(33000252; "Quantity Rejected"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

}

