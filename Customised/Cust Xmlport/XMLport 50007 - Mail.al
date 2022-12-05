xmlport 50007 Mail
{
    Format = VariableText;

    schema
    {
        textelement(Mails)
        {
            tableelement("<mail>"; "MAILID LIST")
            {
                XmlName = 'Mail';
                fieldelement(USERID; "<Mail>".USERID)
                {
                }
                fieldelement(USERNAME; "<Mail>"."USER NAME")
                {
                }
                fieldelement(DEPT; "<Mail>".DEPT)
                {
                }
                fieldelement(MAILID; "<Mail>"."MAIL ID")
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

