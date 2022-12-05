xmlport 50031 Station
{
    Format = VariableText;

    schema
    {
        textelement(Stations)
        {
            tableelement(Station; Station)
            {
                XmlName = 'Station';
                fieldelement(StationCode; Station."Station Code")
                {
                }
                fieldelement(Divisioncode; Station."Division code")
                {
                }
                fieldelement(StationName; Station."Station Name")
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

