xmlport 80101 "QC Assay Header"
{
    Format = VariableText;

    schema
    {
        textelement(AssayHeader)
        {
            tableelement("<assayheader>"; "Assay Header")
            {
                XmlName = 'AssayHeader';
                fieldelement(No; "<AssayHeader>"."No.")
                {
                }
                fieldelement(Description; "<AssayHeader>".Description)
                {
                }
                fieldelement(SamplingPlanCode; "<AssayHeader>"."Sampling Plan Code")
                {
                }
                fieldelement(InspectionGroupCode; "<AssayHeader>"."Inspection Group Code")
                {
                }
                fieldelement(Status; "<AssayHeader>".Status)
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

