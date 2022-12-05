query 50010 "Post Material issues New"
{
    OrderBy = Ascending(Material_Requisition_Date1), Ascending(Dept1);

    elements
    {
        dataitem(Posted_Material_Issues_Header; "Posted Material Issues Header")
        {
            DataItemTableFilter = "Transfer-from Code" = FILTER('STR');
            column(No; "No.")
            {
            }
            filter(Prod_Order_No; "Prod. Order No.")
            {
            }
            filter(Prod_Order_Line_No; "Prod. Order Line No.")
            {
            }
            filter(Prod_BOM_No; "Prod. BOM No.")
            {
            }
            dataitem(Item_Ledger_Entry; "Item Ledger Entry")
            {
                DataItemLink = "Document No." = Posted_Material_Issues_Header."No.", "Location Code" = Posted_Material_Issues_Header."Transfer-to Code";
                column(Item_No; "Item No.")
                {
                }
                column(Serial_No; "Serial No.")
                {
                }
                column(Lot_No; "Lot No.")
                {
                }
                column(Sum_Quantity; Quantity)
                {
                    Method = Sum;
                }
                dataitem(Prod_Order_Component; "Prod. Order Component")
                {
                    DataItemLink = "Prod. Order No." = Posted_Material_Issues_Header."Prod. Order No.", "Prod. Order Line No." = Posted_Material_Issues_Header."Prod. Order Line No.", "Item No." = Item_Ledger_Entry."Item No.";
                    filter(Material_Required_Day; "Material Required Day")
                    {
                    }
                    column(Material_Required_Day1; "Material Required Day")
                    {
                    }
                    filter(Material_Requisition_Date; "Material Requisition Date")
                    {
                    }
                    filter(Dept; Dept)
                    {
                    }
                    column(Dept1; Dept)
                    {
                    }
                    column(Material_Requisition_Date1; "Material Requisition Date")
                    {
                    }
                }
            }
        }
    }
}

