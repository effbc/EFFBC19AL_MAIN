xmlport 80015 Dimension
{
    Format = VariableText;

    schema
    {
        textelement(Dimensions)
        {
            tableelement(Dimension; Dimension)
            {
                XmlName = 'Dimension';
                fieldelement(Code; Dimension.Code)
                {
                }
                fieldelement(Name; Dimension.Name)
                {
                }
                fieldelement(CodeCaption; Dimension."Code Caption")
                {
                }
                fieldelement(FilterCaption; Dimension."Filter Caption")
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

