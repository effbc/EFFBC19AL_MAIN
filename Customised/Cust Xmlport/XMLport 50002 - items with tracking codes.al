xmlport 50002 "items with tracking codes"
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
                fieldelement(ItemCategoryCode; Item."Item Category Code")
                {
                }
                fieldelement(SerialNos; Item."Serial Nos.")
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

