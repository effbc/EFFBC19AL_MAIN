xmlport 80707 "Dep & Pro Dimension Values"
{
    Format = VariableText;

    schema
    {
        textelement(DefaultDimensions)
        {
            tableelement("<defaultdimension>"; "Default Dimension")
            {
                XmlName = 'DefaultDimension';
                fieldelement(No; "<DefaultDimension>"."No.")
                {
                }
                fieldelement(DimensionCode; "<DefaultDimension>"."Dimension Code")
                {
                }
                fieldelement(ValuePosting; "<DefaultDimension>"."Value Posting")
                {
                }
                fieldelement(TableID; "<DefaultDimension>"."Table ID")
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

