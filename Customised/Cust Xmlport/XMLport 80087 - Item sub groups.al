xmlport 80087 "Item sub groups"
{
    Format = VariableText;

    schema
    {
        textelement(ItemSubGroups)
        {
            tableelement("<itemsubgroup>"; "Item Sub Group")
            {
                XmlName = 'ItemSubGroup';
                fieldelement(ProductGroupCode; "<ItemSubGroup>"."Product Group Code")
                {
                }
                fieldelement(Code; "<ItemSubGroup>".Code)
                {
                }
                fieldelement(Description; "<ItemSubGroup>".Description)
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

