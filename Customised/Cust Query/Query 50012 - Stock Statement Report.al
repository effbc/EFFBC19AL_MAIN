query 50012 "Stock Statement Report"
{

    elements
    {
        dataitem(Item; Item)
        {
            DataItemTableFilter = "Product Group Code Cust" = FILTER(<> 'FPRODUCT' & <> 'CPCB');
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
                DataItemTableFilter = "Remaining Quantity" = FILTER(> 0), "Location Code" = FILTER('R&D STR' | 'STR' | 'CS STR' | 'PRODSTR');
                column(Remaining_Quantity; "Remaining Quantity")
                {
                }
                dataitem(Item_Ledger_Entry1; "Item Ledger Entry")
                {
                    DataItemLink = "Item No." = Item_Ledger_Entry."Item No.", "Lot No." = Item_Ledger_Entry."Lot No.", "Serial No." = Item_Ledger_Entry."Serial No.";
                    SqlJoinType = LeftOuterJoin;
                    DataItemTableFilter = "Entry Type" = CONST(Purchase);
                    column(Document_No; "Document No.")
                    {
                    }
                    dataitem(Purch_Inv_Line; "Purch. Inv. Line")
                    {
                        DataItemLink = "Receipt No." = Item_Ledger_Entry."Document No.", "Receipt Line No." = Item_Ledger_Entry."Document Line No.";//EFFUPG
                        SqlJoinType = InnerJoin;
                        DataItemTableFilter = Quantity = FILTER(> 0), "Unit Cost" = FILTER(> 0);
                        column(Amount_To_Vendor; "Amount To Vendor")
                        {
                        }
                        column(Unit_Cost_LCY; "Unit Cost (LCY)")
                        {
                        }
                        column(Quantity_Base; "Quantity (Base)")
                        {
                        }
                        column(Unit_Cost; "Unit Cost")
                        {
                        }
                    }
                }
            }
        }
    }
}

