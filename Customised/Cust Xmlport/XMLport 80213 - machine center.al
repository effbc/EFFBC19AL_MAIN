xmlport 80213 "machine center"
{
    Format = VariableText;

    schema
    {
        textelement(MachineCenters)
        {
            tableelement("<machinecenter>"; "Machine Center")
            {
                XmlName = 'MachineCenter';
                fieldelement(No; "<MachineCenter>"."No.")
                {
                }
                fieldelement(Name; "<MachineCenter>".Name)
                {
                }
                fieldelement(GenProdPostingGroup; "<MachineCenter>"."Gen. Prod. Posting Group")
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

