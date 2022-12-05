xmlport 80063 "Sales Cust. Posting Group"
{
    Format = VariableText;

    schema
    {
        textelement(CustomerPostingGroups)
        {
            tableelement("<customerpostinggroup>"; "Customer Posting Group")
            {
                XmlName = 'CustomerPostingGroup';
                fieldelement(Code; "<CustomerPostingGroup>".Code)
                {
                }
                fieldelement(ReceivablesAccount; "<CustomerPostingGroup>"."Receivables Account")
                {
                }
                fieldelement(InvoiceRoundingAccount; "<CustomerPostingGroup>"."Invoice Rounding Account")
                {
                }
                fieldelement(DebitRoundingAccount; "<CustomerPostingGroup>"."Debit Rounding Account")
                {
                }
                fieldelement(CreditRoundingAccount; "<CustomerPostingGroup>"."Credit Rounding Account")
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

