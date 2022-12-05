page 90013 "RPO List"
{
    PageType = List;
    SourceTable = "Production Order";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; "Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Source No."; "Source No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Item Sub Group Code"; "Item Sub Group Code")
                {
                    ApplicationArea = All;
                }
                field("Product Group Code"; "Product Group Code")
                {
                    ApplicationArea = All;
                }
                field("Sales Order No."; "Sales Order No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Order Line No."; "Sales Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Planned Dispatch Date"; "Planned Dispatch Date")
                {
                    ApplicationArea = All;
                }
                field("Total Unts"; "Total Unts")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }
                field(Itm_card_No_of_Units; Itm_card_No_of_Units)
                {
                    ApplicationArea = All;
                }
                field(Itm_Card_ttl_units; Itm_Card_ttl_units)
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Prod Start date"; "Prod Start date")
                {
                    ApplicationArea = All;
                }
                field("Suppose to Plan"; "Suppose to Plan")
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

