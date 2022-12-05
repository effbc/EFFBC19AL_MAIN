xmlport 80005 "G/L Post Codes"
{
    Format = VariableText;

    schema
    {
        textelement(PostCodes)
        {
            tableelement("<postcode>"; "Post Code")
            {
                XmlName = 'PostCode';
                fieldelement(Code; "<PostCode>".Code)
                {
                }
                fieldelement(City; "<PostCode>".City)
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

