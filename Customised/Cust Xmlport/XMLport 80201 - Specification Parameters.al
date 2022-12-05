xmlport 80201 "Specification Parameters"
{
    Format = VariableText;

    schema
    {
        textelement(SpecificationParameters)
        {
            tableelement("<specificationparameters>"; "Specification Parameters")
            {
                XmlName = 'SpecificationParameters';
                fieldelement(Code; "<SpecificationParameters>".Code)
                {
                }
                fieldelement(Description; "<SpecificationParameters>".Description)
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

