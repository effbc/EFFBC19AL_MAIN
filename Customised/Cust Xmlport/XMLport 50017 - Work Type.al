xmlport 50017 "Work Type"
{
    Format = VariableText;

    schema
    {
        textelement(WorkTypes)
        {
            tableelement("<worktype>"; "Work Type")
            {
                XmlName = 'WorkType';
                fieldelement(Code; "<WorkType>".Code)
                {
                }
                fieldelement(Description; "<WorkType>".Description)
                {
                }
                fieldelement(UnitofMeasureCode; "<WorkType>"."Unit of Measure Code")
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

