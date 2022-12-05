query 50011 "Stock Statement"
{
    elements
    {
        dataitem(Item; Item)
        {
            column(No; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Avg_Unit_Cost; "Avg Unit Cost")
            {
            }
            dataitem(Item_Ledger_Entry; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = Item."No.";
                SqlJoinType = InnerJoin;
                DataItemTableFilter = "Remaining Quantity" = FILTER(> 0), "Global Dimension 1 Code" = FILTER('STR' | 'PRODSTR');
                column(Remaining_Quantity; "Remaining Quantity")
                {
                }
                dataitem(ILE; "Item Ledger Entry")
                {
                    DataItemLink = "Item No." = Item_Ledger_Entry."Item No.", "Serial No." = Item_Ledger_Entry."Serial No.", "Lot No." = Item_Ledger_Entry."Lot No.";
                    DataItemTableFilter = "Entry Type" = FILTER(Purchase);
                    column(Document_No; "Document No.")
                    {
                    }
                    dataitem(Purch_Inv_Line; "Purch. Inv. Line")
                    {
                        DataItemLink = "No." = Item."No.", "Receipt No." = ILE."Document No.";//EFFUPG
                    }
                }
            }
        }
    }
}

