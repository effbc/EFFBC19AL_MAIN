xmlport 50018 "Resource Unit of Measure"
{

    schema
    {
        textelement(ResourceUnitofMeasures)
        {
            tableelement("<resourceunitofmeasure>"; "Resource Unit of Measure")
            {
                XmlName = 'ResourceUnitofMeasure';
                fieldelement(ResourceNo; "<ResourceUnitofMeasure>"."Resource No.")
                {
                }
                fieldelement(Code; "<ResourceUnitofMeasure>".Code)
                {
                }
                fieldelement(QtyperUnitofMeasure; "<ResourceUnitofMeasure>"."Qty. per Unit of Measure")
                {
                }
                fieldelement(RelatedtoBaseUnitofMeas; "<ResourceUnitofMeasure>"."Related to Base Unit of Meas.")
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

