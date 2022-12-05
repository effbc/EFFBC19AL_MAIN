xmlport 50034 "Reason code"
{
    Format = VariableText;

    schema
    {
        textelement(ReasonCodes)
        {
            tableelement("<reasoncode>"; "Reason Code")
            {
                XmlName = 'ReasonCode';
                fieldelement(Code; "<ReasonCode>".Code)
                {
                }
                fieldelement(Description; "<ReasonCode>".Description)
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

