xmlport 80086 "Item Locations"
{
    Format = VariableText;

    schema
    {
        textelement(Locations)
        {
            tableelement(Location; Location)
            {
                XmlName = 'Location';
                fieldelement(Code; Location.Code)
                {
                }
                fieldelement(Name; Location.Name)
                {
                }
                fieldelement(UseAsInTransit; Location."Use As In-Transit")
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

