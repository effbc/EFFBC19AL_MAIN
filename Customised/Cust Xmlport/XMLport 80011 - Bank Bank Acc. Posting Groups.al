xmlport 80011 "Bank Bank Acc. Posting Groups"
{
    Format = VariableText;

    schema
    {
        textelement(BankAccountPostingGroups)
        {
            tableelement("<bankaccountpostinggroup>"; "Bank Account Posting Group")
            {
                XmlName = 'BankAccountPostingGroup';
                fieldelement(Code; "<BankAccountPostingGroup>".Code)
                {
                }
                fieldelement(GLBankAccountNo; "<BankAccountPostingGroup>"."G/L Account No.")
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

