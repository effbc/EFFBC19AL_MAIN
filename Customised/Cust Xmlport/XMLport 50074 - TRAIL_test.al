xmlport 50074 TRAIL_test
{

    schema
    {
        textelement(TEST)
        {
            tableelement(PCB; PCB)
            {
                XmlName = 'PCB';
                fieldelement(No; PCB."PCB No.")
                {
                }
                fieldelement(Desc; PCB.Description)
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

