xmlport 50070 "Eff Specification Header"
{
    Format = VariableText;

    schema
    {
        textelement(SpecificationLines)
        {
            tableelement("<specificationline>"; "Specification Line")
            {
                XmlName = 'SpecificationLine';
                fieldelement(SpecID; "<SpecificationLine>"."Spec ID")
                {
                }
                fieldelement(LineNo; "<SpecificationLine>"."Line No.")
                {
                }
                fieldelement(CharacterCode; "<SpecificationLine>"."Character Code")
                {
                }
                fieldelement(Description; "<SpecificationLine>".Description)
                {
                }
                fieldelement(SamplingCode; "<SpecificationLine>"."Sampling Code")
                {
                }
                fieldelement(NormalValueNum; "<SpecificationLine>"."Normal Value (Num)")
                {
                }
                fieldelement(MinValueNum; "<SpecificationLine>"."Min. Value (Num)")
                {
                }
                fieldelement(MaxValueNum; "<SpecificationLine>"."Max. Value (Num)")
                {
                }
                fieldelement(NormalValueChar; "<SpecificationLine>"."Normal Value (Char)")
                {
                }
                fieldelement(MinValueChar; "<SpecificationLine>"."Min. Value (Char)")
                {
                }
                fieldelement(MaxValueChar; "<SpecificationLine>"."Max. Value (Char)")
                {
                }
                fieldelement(InspectionGroupCode; "<SpecificationLine>"."Inspection Group Code")
                {
                }
                fieldelement(UnitOfMeasureCode; "<SpecificationLine>"."Unit Of Measure Code")
                {
                }
                fieldelement(Qualitative; "<SpecificationLine>".Qualitative)
                {
                }
                fieldelement(CharacterType; "<SpecificationLine>"."Character Type")
                {
                }
                fieldelement(Indentation; "<SpecificationLine>".Indentation)
                {
                }
                fieldelement(VersionCode; "<SpecificationLine>"."Version Code")
                {
                }
                fieldelement(InspectionTimeInMin; "<SpecificationLine>"."Inspection Time(In Min.)")
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

