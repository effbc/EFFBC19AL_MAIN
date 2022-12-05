query 50016 "TO BE EXECUTED ORDERS FILLING"
{

    elements
    {
        dataitem(Sales_Header; "Sales Header")
        {
            column(No; "No.")
            {
                ColumnFilter = No = FILTER(<> ' *AMC*');
            }
            column(Status; Status)
            {
                ColumnFilter = Status = FILTER(Released);
            }
            column(Order_Released_Date; "Order Released Date")
            {
            }
            dataitem(Sales_Line; "Sales Line")
            {
                DataItemLink = "Document No." = Sales_Header."No.";
                column(Document_No; "Document No.")
                {
                }
                column(Type; Type)
                {
                }
                column(Item_No; "No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Outstanding_Quantity; "Outstanding Quantity")
                {
                    ColumnFilter = Outstanding_Quantity = FILTER(> 0);
                }
                column(Spec_Version; "Spec Version")
                {
                }
            }
        }
    }
}

