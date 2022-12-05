xmlport 80202 "Gen Business posting group"
{
    Format = VariableText;

    schema
    {
        textelement(GenBusinessPostingGroups)
        {
            tableelement("<genbusinesspostinggroup>"; "Gen. Business Posting Group")
            {
                XmlName = 'GenBusinessPostingGroup';
                fieldelement(Code; "<GenBusinessPostingGroup>".Code)
                {
                }
                fieldelement(Description; "<GenBusinessPostingGroup>".Description)
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

