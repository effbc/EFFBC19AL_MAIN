xmlport 80051 "VAT Product Posting Groups"
{

    schema
    {
        textelement(VATProductPostingGroups)
        {
            tableelement("<vatproductpostinggroup>"; "VAT Product Posting Group")
            {
                XmlName = 'VATProductPostingGroup';
                fieldelement(Code; "<VATProductPostingGroup>".Code)
                {
                }
                fieldelement(Description; "<VATProductPostingGroup>".Description)
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

