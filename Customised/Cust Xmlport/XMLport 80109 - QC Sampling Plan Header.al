xmlport 80109 "QC Sampling Plan Header"
{
    Format = VariableText;

    schema
    {
        textelement(SamplingPlanHeader)
        {
            tableelement("<samplingplanheader>"; "Sampling Plan Header")
            {
                XmlName = 'SamplingPlanHeader';
                fieldelement(Code; "<SamplingPlanHeader>".Code)
                {
                }
                fieldelement(Description; "<SamplingPlanHeader>".Description)
                {
                }
                fieldelement(StandardReference; "<SamplingPlanHeader>"."Standard Reference")
                {
                }
                fieldelement(AQLPercentage; "<SamplingPlanHeader>"."AQL Percentage")
                {
                }
                fieldelement(Status; "<SamplingPlanHeader>".Status)
                {
                }
                fieldelement(FixedQuantity; "<SamplingPlanHeader>"."Fixed Quantity")
                {
                }
                fieldelement(LotPercentage; "<SamplingPlanHeader>"."Lot Percentage")
                {
                }
                fieldelement(SamplingType; "<SamplingPlanHeader>"."Sampling Type")
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

