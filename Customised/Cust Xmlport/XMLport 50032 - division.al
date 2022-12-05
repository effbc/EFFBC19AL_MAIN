xmlport 50032 division
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

