xmlport 80001 "G/L COA"
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
                fieldelement(AccountType; "<GLAccount>"."Account Type")
                {
                }
                fieldelement(IncomeBalance; "<GLAccount>"."Income/Balance")
                {
                }
                fieldelement(GenProdPostingGroup; "<GLAccount>"."Gen. Prod. Posting Group")
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

