xmlport 80203 "Gen Product posting group"
{
    Format = VariableText;

    schema
    {
        textelement(GenProductPostingGroups)
        {
            tableelement("<genproductpostinggroup>"; "Gen. Product Posting Group")
            {
                XmlName = 'GenProductPostingGroup';
                fieldelement(Code; "<GenProductPostingGroup>".Code)
                {
                }
                fieldelement(Description; "<GenProductPostingGroup>".Description)
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

