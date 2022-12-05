xmlport 80300 "BOI track"
{
    Format = VariableText;

    schema
    {
        textelement(Items)
        {
            tableelement(Item; Item)
            {
                XmlName = 'Item';
                fieldelement(No; Item."No.")
                {
                }
                fieldelement(InventoryPostingGroup; Item."Inventory Posting Group")
                {
                }
                fieldelement(ItemTrackingCode; Item."Item Category Code")
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

