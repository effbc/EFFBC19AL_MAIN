xmlport 80016 "Dimension Values"
{
    Format = VariableText;

    schema
    {
        textelement(DimensionValues)
        {
            tableelement("Dimension Value"; "Dimension Value")
            {
                XmlName = 'DimensionValue';
                fieldelement(DimensionCode; "Dimension Value"."Dimension Code")
                {
                }
                fieldelement(Code; "Dimension Value".Code)
                {
                }
                fieldelement(Name; "Dimension Value".Name)
                {
                }
                fieldelement(DimensionValueType; "Dimension Value"."Dimension Value Type")
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

