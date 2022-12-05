xmlport 50013 "Default Dimension"
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
                fieldelement(DimensionValueCode; "<DefaultDimension>"."Dimension Value Code")
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

