pageextension 70324 FinishedProductionOrders extends "Finished Production Orders"
{
    // version NAVW19.00.00.45778

    layout
    {
        addbefore(Control1)
        {
            field(xRec_COUNT;
            xRec.COUNT)
            {
                Caption = 'Number of records';
            }
        }
        addafter("Search Description")
        {
            field("Sales Order No."; "Sales Order No.")
            {
            }
            field("Item Sub Group Code"; "Item Sub Group Code")
            {
            }
        }
        addafter("Item Sub Group Code")
        {
            field("Sales Order Line No."; "Sales Order Line No.")
            {
            }
            field("Schedule Line No."; "Schedule Line No.")
            {
            }
            field("Prod Start date"; "Prod Start date")
            {
            }
            field(Itm_card_No_of_Units; Itm_card_No_of_Units)
            {
            }
            field(Itm_Card_ttl_units; Itm_Card_ttl_units)
            {
            }
            field("User Id"; "User Id")
            {
            }
        }
    }
    actions
    {
        addafter(Statistics)
        {
            action("Change &Status")
            {
                Caption = 'Change &Status';
                Ellipsis = true;
                Image = ChangeStatus;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Codeunit 5407;
            }
        }
    }
}

