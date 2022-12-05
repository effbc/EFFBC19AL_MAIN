xmlport 80027 "Tax Tax Groups"
{
    Format = VariableText;

    schema
    {
        textelement(TaxGroups)
        {
            tableelement("<taxgroup>"; "Tax Group")
            {
                XmlName = 'TaxGroup';
                fieldelement(Code; "<TaxGroup>".Code)
                {
                }
                fieldelement(Description; "<TaxGroup>".Description)
                {
                }
                /*
                fieldelement(VATApplicable; "<TaxGroup>"."VAT Applicable")
                {
                }
                */
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

