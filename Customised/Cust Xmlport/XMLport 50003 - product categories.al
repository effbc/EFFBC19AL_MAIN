xmlport 50003 "product categories"
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
                fieldelement(Description; Item.Description)
                {
                }
                fieldelement(ItemCategoryCode; Item."Item Category Code")
                {
                }
                fieldelement(ProdGroupCode; Item."Product Group Code Cust")
                {
                }
                fieldelement(ItemSubGroupCode; Item."Item Sub Group Code")
                {
                }
                fieldelement(ItemSubSubGroupCode; Item."Item Sub Sub Group Code")
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

