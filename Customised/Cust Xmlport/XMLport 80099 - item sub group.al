xmlport 80099 "item sub group"
{
    Format = VariableText;

    schema
    {
        textelement(ItemSubGroups)
        {
            tableelement("<itemsubgroup>"; "Item Sub Group")
            {
                XmlName = 'ItemSubGroup';
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

