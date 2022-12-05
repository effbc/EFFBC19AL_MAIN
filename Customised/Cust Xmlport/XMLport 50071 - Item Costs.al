xmlport 50071 "Item Costs"
{
    Format = VariableText;

    schema
    {
        textelement(Testing)
        {
            tableelement("<testingdummytable>"; "Item Op Balance")
            {
                XmlName = 'TestingDummyTable';
                fieldelement(Name; "<TestingDummyTable>"."Entry No.")
                {
                }
                fieldelement(ID; "<TestingDummyTable>"."No.")
                {
                }
                fieldelement(Dept; "<TestingDummyTable>".Location)
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

