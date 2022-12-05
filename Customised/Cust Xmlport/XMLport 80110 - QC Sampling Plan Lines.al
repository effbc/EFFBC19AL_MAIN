xmlport 80110 "QC Sampling Plan Lines"
{
    Format = VariableText;

    schema
    {
        textelement(SamplingPlanLines)
        {
            tableelement("<samplingplanline>"; "Sampling Plan Line")
            {
                XmlName = 'SamplingPlanLine';
                fieldelement(SamplingCode; "<SamplingPlanLine>"."Sampling Code")
                {
                }
                fieldelement(LineNo; "<SamplingPlanLine>"."Line No.")
                {
                }
                fieldelement(LotSizeMin; "<SamplingPlanLine>"."Lot Size - Min")
                {
                }
                fieldelement(LotSizeMax; "<SamplingPlanLine>"."Lot Size - Max")
                {
                }
                fieldelement(SamplingSize; "<SamplingPlanLine>"."Sampling Size")
                {
                }
                fieldelement(AllowableDefectsMin; "<SamplingPlanLine>"."Allowable Defects - Min")
                {
                }
                fieldelement(AllowableDefectsMax; "<SamplingPlanLine>"."Allowable Defects - Max")
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

