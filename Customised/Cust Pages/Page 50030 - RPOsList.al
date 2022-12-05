page 50030 "RPOs List"
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
                field("No."; "No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Source No."; "Source No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sales Order No."; "Sales Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sales Order Line No."; "Sales Order Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                    Editable = false;
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
                field("Planned Dispatch Date"; "Planned Dispatch Date")
                {
                    ApplicationArea = All;
                }
                field("Item Sub Group Code"; "Item Sub Group Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Itm_Card_ttl_units; Itm_Card_ttl_units)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

