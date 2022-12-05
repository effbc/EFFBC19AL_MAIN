xmlport 80218 "Direct posting"
{
    Format = VariableText;

    schema
    {
        textelement(GLAccounts)
        {
            tableelement("<glaccount>"; "G/L Account")
            {
                XmlName = 'GLAccount';
                fieldelement(No; "<GLAccount>"."No.")
                {
                }
                fieldelement(Name; "<GLAccount>".Name)
                {
                }
                fieldelement(DirectPosting; "<GLAccount>"."Direct Posting")
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

