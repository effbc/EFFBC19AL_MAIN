xmlport 80088 "Item sub Sub groups"
{
    Format = VariableText;

    schema
    {
        textelement(ItemSubSubGroups)
        {
            tableelement("<itemsubsubgroup>"; "Item Sub Sub Group")
            {
                XmlName = 'ItemSubSubGroup';
                fieldelement(ItemSubGroupCode; "<ItemSubSubGroup>"."Item Sub Group Code")
                {
                }
                fieldelement(Code; "<ItemSubSubGroup>".Code)
                {
                }
                fieldelement(Description; "<ItemSubSubGroup>".Description)
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

