xmlport 50019 "User ID's Posting"
{

    schema
    {
        textelement(Employees)
        {
            tableelement(Employee; Employee)
            {
                XmlName = 'Employee';
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

