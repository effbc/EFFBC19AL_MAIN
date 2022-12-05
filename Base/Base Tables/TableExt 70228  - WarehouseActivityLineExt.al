tableextension 70228 WarehouseActivityLineExt extends "Warehouse Activity Line"
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

