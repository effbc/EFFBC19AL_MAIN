xmlport 80050 "VAT Bus. Posting Group"
{
    Format = VariableText;

    schema
    {
        textelement(VATBusinessPostingGroups)
        {
            tableelement("<vatbusinesspostinggroup>"; "VAT Business Posting Group")
            {
                XmlName = 'VATBusinessPostingGroup';
                fieldelement(Code; "<VATBusinessPostingGroup>".Code)
                {
                }
                fieldelement(Description; "<VATBusinessPostingGroup>".Description)
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

