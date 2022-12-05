xmlport 80008 "G/L No. Series Relationship"
{
    Format = VariableText;

    schema
    {
        textelement(NoSeriesRelationships)
        {
            tableelement("<noseriesrelationship>"; "No. Series Relationship")
            {
                XmlName = 'NoSeriesRelationship';
                fieldelement(Code; "<NoSeriesRelationship>".Code)
                {
                }
                fieldelement(SeriesCode; "<NoSeriesRelationship>"."Series Code")
                {
                }
                fieldelement(SeriesDescription; "<NoSeriesRelationship>"."Series Description")
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

