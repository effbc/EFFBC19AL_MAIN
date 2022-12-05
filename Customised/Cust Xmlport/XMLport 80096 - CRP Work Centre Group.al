xmlport 80096 "CRP Work Centre Group"
{
    Format = VariableText;

    schema
    {
        textelement(WorkCenterGroups)
        {
            tableelement("<workcentergroup>"; "Work Center Group")
            {
                XmlName = 'WorkCenterGroup';
                fieldelement(Code; "<WorkCenterGroup>".Code)
                {
                }
                fieldelement(Name; "<WorkCenterGroup>".Name)
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

