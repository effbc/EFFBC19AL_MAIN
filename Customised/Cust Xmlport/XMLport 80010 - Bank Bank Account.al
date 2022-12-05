xmlport 80010 "Bank Bank Account"
{
    Format = VariableText;

    schema
    {
        textelement(BankAccounts)
        {
            tableelement("<bankaccount>"; "Bank Account")
            {
                XmlName = 'BankAccount';
                fieldelement(No; "<BankAccount>"."No.")
                {
                }
                fieldelement(Name; "<BankAccount>".Name)
                {
                }
                fieldelement(Address; "<BankAccount>".Address)
                {
                }
                fieldelement(Address2; "<BankAccount>"."Address 2")
                {
                }
                fieldelement(City; "<BankAccount>".City)
                {
                }
                fieldelement(BankAccountNo; "<BankAccount>"."Bank Account No.")
                {
                }
                fieldelement(CountryRegionCode; "<BankAccount>"."Country/Region Code")
                {
                }
                fieldelement(PostCode; "<BankAccount>"."Post Code")
                {
                }
                fieldelement(BankAccPostingGroup; "<BankAccount>"."Bank Acc. Posting Group")
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

