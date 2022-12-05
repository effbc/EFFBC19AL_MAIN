xmlport 80081 "Unit Of Measure"
{
    Format = VariableText;

    schema
    {
        textelement(UnitofMeasures)
        {
            tableelement("<unitofmeasure>"; "Unit of Measure")
            {
                XmlName = 'UnitofMeasure';
                fieldelement(Code; "<UnitofMeasure>".Code)
                {
                }
                fieldelement(Description; "<UnitofMeasure>".Description)
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

