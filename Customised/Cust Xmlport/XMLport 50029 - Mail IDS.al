xmlport 50029 "Mail IDS"
{
    Format = VariableText;

    schema
    {
        textelement(UserSetup)
        {
            tableelement("<usersetup>"; "User Setup")
            {
                XmlName = 'UserSetup';
                fieldelement(UserID; "<UserSetup>"."User ID")
                {
                }
                fieldelement(EMail; "<UserSetup>"."E-Mail")
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

