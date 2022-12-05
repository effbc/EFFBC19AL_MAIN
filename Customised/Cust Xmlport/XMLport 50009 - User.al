xmlport 50009 User
{
    Format = VariableText;

    schema
    {
        textelement(Users)
        {
            tableelement(User; User)
            {
                XmlName = 'User';
                fieldelement(UserSecurityID; User."User Security ID")
                {
                }
                fieldelement(UserName; User."User Name")
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

