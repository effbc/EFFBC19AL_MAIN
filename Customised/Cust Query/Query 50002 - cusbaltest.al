query 50002 cusbaltest
{

    elements
    {
        dataitem(Customer; Customer)
        {
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Balance_LCY; "Balance (LCY)")
            {
                ColumnFilter = Balance_LCY = FILTER(> 0);
            }
            dataitem(Sales_Header; "Sales Header")
            {
                DataItemLink = "Sell-to Customer No." = Customer."No.";
                column(Bill_to_Name; "Bill-to Name")
                {
                }
            }
        }
    }
}

