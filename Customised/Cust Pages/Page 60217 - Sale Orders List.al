page 60217 "Sale Orders List"
{
    PageType = Worksheet;
    SourceTable = "Sales Invoice Header";
    SourceTableView = SORTING("Order No.") ORDER(Ascending) WHERE("Order No." = FILTER(<> ''));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                ShowCaption = false;
                field("Order No."; "Order No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; "Order Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

