xmlport 50191 Trail
{
    Format = VariableText;

    schema
    {
        textelement(Divisions)
        {
            tableelement(Division; "Employee Statistics Group")
            {
                XmlName = 'Division';
                fieldelement(DivisionCode; Division.Code)
                {
                }
                fieldelement(Zonecode; Division.Description)
                {
                }
                fieldelement(DivisionName; Division."Division Name")
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

