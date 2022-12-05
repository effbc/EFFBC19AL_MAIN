xmlport 80184 "CRM Teams"
{
    Format = VariableText;

    schema
    {
        textelement(Teams)
        {
            tableelement(Team; Team)
            {
                XmlName = 'Team';
                fieldelement(Code; Team.Code)
                {
                }
                fieldelement(Name; Team.Name)
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

