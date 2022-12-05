xmlport 80026 "Tax States"
{
    Format = VariableText;

    schema
    {
        textelement(States)
        {
            tableelement(State; State)
            {
                XmlName = 'State';
                fieldelement(Code; State.Code)
                {
                }
                fieldelement(Description; State.Description)
                {
                }
                fieldelement(StateCodeforeTDSTCS; State."State Code for eTDS/TCS")
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

