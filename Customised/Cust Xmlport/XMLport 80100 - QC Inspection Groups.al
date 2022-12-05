xmlport 80100 "QC Inspection Groups"
{
    Format = VariableText;

    schema
    {
        textelement(InspectionGroups)
        {
            tableelement("<inspectiongroup>"; "Inspection Group")
            {
                XmlName = 'InspectionGroup';
                fieldelement(Code; "<InspectionGroup>".Code)
                {
                }
                fieldelement(Description; "<InspectionGroup>".Description)
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

