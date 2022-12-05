xmlport 90201 Employee
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
                fieldelement(GlobalDimension1Code; Employee."Global Dimension 1 Code")
                {
                }
                fieldelement(EMail; Employee."E-Mail")
                {
                }
                fieldelement(DepartmentCode; Employee."Department Code")
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

