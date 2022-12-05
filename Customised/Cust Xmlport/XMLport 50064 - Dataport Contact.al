xmlport 50064 "Dataport Contact"
{
    Format = VariableText;

    schema
    {
        textelement(Makes)
        {
            tableelement("<maket>"; Make)
            {
                XmlName = 'MakeT';
                fieldelement(Make; "<MakeT>".Make)
                {
                }
                fieldelement(CreatedBy; "<MakeT>"."Created By")
                {
                }
                fieldelement(EntryDateTime; "<MakeT>"."Entry Date Time")
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

