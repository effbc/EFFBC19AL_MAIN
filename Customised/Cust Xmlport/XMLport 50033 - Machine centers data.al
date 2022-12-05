xmlport 50033 "Machine centers data"
{

    schema
    {
        textelement(Resources)
        {
            tableelement(Resource; Resource)
            {
                XmlName = 'Resource';
                fieldelement(No; Resource."No.")
                {
                }
                fieldelement(Name; Resource.Name)
                {
                }
                fieldelement(Department; Resource.Department)
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

