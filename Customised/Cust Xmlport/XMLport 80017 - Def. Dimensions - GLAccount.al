xmlport 80017 "Def. Dimensions - G/LAccount"
{
    Format = VariableText;

    schema
    {
        textelement(DefaultDimensions)
        {
            tableelement("<defaultdimension>"; "Default Dimension")
            {
                XmlName = 'DefaultDimension';
                fieldelement(TableID; "<DefaultDimension>"."Table ID")
                {
                }
                fieldelement(No; "<DefaultDimension>"."No.")
                {
                }
                fieldelement(DimensionCode; "<DefaultDimension>"."Dimension Code")
                {
                }
                fieldelement(ValuePosting; "<DefaultDimension>"."Value Posting")
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

