xmlport 80105 "QC Assay Lines"
{
    Format = VariableText;

    schema
    {
        textelement(AssayLines)
        {
            tableelement("<assayline>"; "Assay Line")
            {
                XmlName = 'AssayLine';
                fieldelement(AssayNo; "<AssayLine>"."Assay No.")
                {
                }
                fieldelement(LineNo; "<AssayLine>"."Line No.")
                {
                }
                fieldelement(CharacterCode; "<AssayLine>"."Character Code")
                {
                }
                fieldelement(Description; "<AssayLine>".Description)
                {
                }
                fieldelement(NormalValueNum; "<AssayLine>"."Normal Value (Num)")
                {
                }
                fieldelement(MinValueNum; "<AssayLine>"."Min. Value (Num)")
                {
                }
                fieldelement(MaxValueNum; "<AssayLine>"."Max. Value (Num)")
                {
                }
                fieldelement(NormalValueChar; "<AssayLine>"."Normal Value (Char)")
                {
                }
                fieldelement(MinValueChar; "<AssayLine>"."Min. Value (Char)")
                {
                }
                fieldelement(MaxValueChar; "<AssayLine>"."Max. Value (Char)")
                {
                }
                fieldelement(UnitOfMeasureCode; "<AssayLine>"."Unit Of Measure Code")
                {
                }
                fieldelement(Qualitative; "<AssayLine>".Qualitative)
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

