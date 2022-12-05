query 50014 "posted material issues"
{

    elements
    {
        dataitem(Posted_Material_Issues_Header; "Posted Material Issues Header")
        {
            DataItemTableFilter = "Posting Date" = FILTER(> 20160401D), "Posting Date" = FILTER(< 20170331D);
            dataitem(Posted_Material_Issues_Line; "Posted Material Issues Line")
            {
                DataItemLink = "Document No." = Posted_Material_Issues_Header."No.";
                column(Item_No; "Item No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Sum_Quantity; Quantity)
                {
                    Method = Sum;
                }
                dataitem(Item; Item)
                {
                    DataItemLink = "No." = Posted_Material_Issues_Line."Item No.";
                    column(BIN_Address; "BIN Address")
                    {
                    }
                }
            }
        }
    }
}

