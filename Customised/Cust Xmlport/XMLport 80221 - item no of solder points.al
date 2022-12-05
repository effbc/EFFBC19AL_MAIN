xmlport 80221 "item no of solder points"
{
    Format = VariableText;

    schema
    {
        textelement(Items)
        {
            tableelement(Item; Item)
            {
                XmlName = 'Item';
                fieldelement(No; Item."No.")
                {
                }
                fieldelement(NoofSolderingPoints; Item."No. of Soldering Points")
                {
                }
                fieldelement(BaseUnitofMeasure; Item."Base Unit of Measure")
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

