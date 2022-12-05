xmlport 80030 "Tax Areas"
{
    Format = VariableText;

    schema
    {
        textelement(TaxAreas)
        {
            tableelement("<taxarea>"; "Tax Area")
            {
                XmlName = 'TaxArea';
                fieldelement(Code; "<TaxArea>".Code)
                {
                }
                fieldelement(Description; "<TaxArea>".Description)
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

