xmlport 50041 "Dimension Value"
{
    Format = VariableText;

    schema
    {
        textelement(DimensionValues)
        {
            tableelement("<dimensionvalue>"; "Dimension Value")
            {
                XmlName = 'DimensionValue';
                fieldelement(DimensionCode; "<DimensionValue>"."Dimension Code")
                {
                }
                fieldelement(Code; "<DimensionValue>".Code)
                {
                }
                fieldelement(Name; "<DimensionValue>".Name)
                {
                }
                fieldelement(DimensionValueType; "<DimensionValue>"."Dimension Value Type")
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

