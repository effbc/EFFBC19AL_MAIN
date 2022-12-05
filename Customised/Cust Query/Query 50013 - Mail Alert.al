query 50013 "Mail Alert New"
{

    elements
    {
        dataitem(Posted_Material_Issues_Header; "Posted Material Issues Header")
        {
            SqlJoinType = LeftOuterJoin;
            DataItemTableFilter = "Transfer-to Code" = FILTER(<> 'CSSTR'), "Transfer-to Code" = FILTER(<> 'STR'), "Transfer-to Code" = FILTER(<> 'PROD'), "Transfer-to Code" = FILTER(<> 'PRODSTR'), "Transfer-to Code" = FILTER(<> 'DAMAGE'), "Transfer-to Code" = FILTER(<> 'RDSTR'), "Transfer-to Code" = FILTER(<> 'MCH'), "User ID" = FILTER('EFFTRONICS\KSRIKANTH');
            column(No; "No.")
            {
            }
            column(Day_Posting_Date; "Posting Date")
            {
                Method = Day;
            }
            column(Transfer_from_Code; "Transfer-from Code")
            {
            }
            column(Transfer_to_Code; "Transfer-to Code")
            {
            }
            column(User_ID; "User ID")
            {
            }
            column(Day_Released_Date; "Released Date")
            {
                Method = Day;
            }
            dataitem(Posted_Material_Issues_Line; "Posted Material Issues Line")
            {
                DataItemLink = "Document No." = Posted_Material_Issues_Header."No.";
                SqlJoinType = LeftOuterJoin;
                DataItemTableFilter = Quantity = FILTER(> 0), "Item No." = FILTER(<> ' ');
                column(Item_No; "Item No.")
                {
                }
                column(Document_No; "Document No.")
                {
                }
                column(Description; Description)
                {
                }
                dataitem(Item_Ledger_Entry; "Item Ledger Entry")
                {
                    DataItemLink = "Document No." = Posted_Material_Issues_Line."Document No.", "Item No." = Posted_Material_Issues_Line."Item No.";
                    SqlJoinType = LeftOuterJoin;
                    DataItemTableFilter = "Product Group Code Cust" = CONST('TOOL'), Quantity = FILTER(> 0);
                    column(Entry_No; "Entry No.")
                    {
                    }
                    column(Lot_No; "Lot No.")
                    {
                    }
                    column(Serial_No; "Serial No.")
                    {
                    }
                    column(Order_No; "Order No.")
                    {
                    }
                    column(Product_Group_Code; "Product Group Code Cust")
                    {
                    }
                    column(Quantity; Quantity)
                    {
                    }
                    column(Item_Category_Code; "Item Category Code")
                    {
                    }
                    column(Item_Tracking; "Item Tracking")
                    {
                    }
                    column(Remaining_Quantity; "Remaining Quantity")
                    {
                    }
                    column(ITL_Doc_No; "ITL Doc No.")
                    {
                    }
                    dataitem(Item_Temp; "Item Ledger Entry")
                    {
                        DataItemLink = "Item No." = Item_Ledger_Entry."Item No.", "Serial No." = Item_Ledger_Entry."Serial No.", "Lot No." = Item_Ledger_Entry."Lot No.", "Location Code" = Item_Ledger_Entry."Location Code";
                        SqlJoinType = InnerJoin;
                        DataItemTableFilter = Quantity = FILTER(< 0), "Remaining Quantity" = FILTER(<> 0);
                        column(Entry_noo; "Entry No.")
                        {
                        }
                        column(Qty; Quantity)
                        {
                        }
                        dataitem(Header_temp; "Posted Material Issues Header")
                        {
                            DataItemLink = "No." = Item_Temp."Document No.", "User ID" = Posted_Material_Issues_Header."User ID";
                            SqlJoinType = InnerJoin;
                            column(Noo; "No.")
                            {
                            }
                        }
                    }
                }
            }
        }
    }
}

