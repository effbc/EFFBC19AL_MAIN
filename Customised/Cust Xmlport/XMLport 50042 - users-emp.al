xmlport 50042 "users-emp"
{
    Format = VariableText;

    schema
    {
        textelement(Employees)
        {
            tableelement(Employee; Employee)
            {
                XmlName = 'Employee';
                fieldelement(No; Employee."No.")
                {
                }
                fieldelement(FirstName; Employee."First Name")
                {
                }
                fieldelement(JobTitle; Employee."Job Title")
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

