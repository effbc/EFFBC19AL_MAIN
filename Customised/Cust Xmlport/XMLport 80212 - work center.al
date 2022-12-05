xmlport 80212 "work center"
{
    Format = VariableText;

    schema
    {
        textelement(WorkCenters)
        {
            tableelement("<workcenter>"; "Work Center")
            {
                XmlName = 'WorkCenter';
                fieldelement(No; "<WorkCenter>"."No.")
                {
                }
                fieldelement(Name; "<WorkCenter>".Name)
                {
                }
                fieldelement(GenProdPostingGroup; "<WorkCenter>"."Gen. Prod. Posting Group")
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

