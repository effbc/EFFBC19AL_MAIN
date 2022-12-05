xmlport 80046 "TDS Parties"
{
    Format = VariableText;

    schema
    {
        textelement(Parties)
        {
            tableelement(Party; Party)
            {
                XmlName = 'Party';
                fieldelement(Code; Party.Code)
                {
                }
                fieldelement(Name; Party.Name)
                {
                }
                fieldelement(Address; Party.Address)
                {
                }
                fieldelement(Address2; Party."Address 2")
                {
                }
                fieldelement(PANNo; Party."P.A.N. No.")
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

