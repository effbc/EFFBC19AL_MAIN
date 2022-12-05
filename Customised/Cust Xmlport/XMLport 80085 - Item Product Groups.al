xmlport 80085 "Item Product Groups"
{
    Format = VariableText;

    schema
    {
        textelement(ProductGroups)
        {
            tableelement("<productgroup>"; "Product Group Cust")
            {
                XmlName = 'ProductGroup';
                fieldelement(ItemCategoryCode; "<ProductGroup>"."Item Category Code")
                {
                }
                fieldelement(Code; "<ProductGroup>".Code)
                {
                }
                fieldelement(Description; "<ProductGroup>".Description)
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

