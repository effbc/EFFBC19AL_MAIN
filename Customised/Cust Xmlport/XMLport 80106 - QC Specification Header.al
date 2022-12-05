xmlport 80106 "QC Specification Header"
{
    Format = VariableText;

    schema
    {
        textelement(SpecificationHeader)
        {
            tableelement("<specificationheader>"; "Specification Header")
            {
                XmlName = 'SpecificationHeader';
                fieldelement(SpecID; "<SpecificationHeader>"."Spec ID")
                {
                }
                fieldelement(Description; "<SpecificationHeader>".Description)
                {
                }
                fieldelement(SamplingPlan; "<SpecificationHeader>"."Sampling Plan")
                {
                }
                fieldelement(Status; "<SpecificationHeader>".Status)
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

