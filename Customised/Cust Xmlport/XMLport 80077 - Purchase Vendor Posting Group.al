xmlport 80077 "Purchase Vendor Posting Group"
{
    Format = VariableText;

    schema
    {
        textelement(VendorPostingGroups)
        {
            tableelement("<vendorpostinggroup>"; "Vendor Posting Group")
            {
                XmlName = 'VendorPostingGroup';
                fieldelement(Code; "<VendorPostingGroup>".Code)
                {
                }
                fieldelement(PayablesAccount; "<VendorPostingGroup>"."Payables Account")
                {
                }
                fieldelement(ServiceChargeAcc; "<VendorPostingGroup>"."Service Charge Acc.")
                {
                }
                fieldelement(PaymentDiscDebitAcc; "<VendorPostingGroup>"."Payment Disc. Debit Acc.")
                {
                }
                fieldelement(InvoiceRoundingAccount; "<VendorPostingGroup>"."Invoice Rounding Account")
                {
                }
                fieldelement(DebitCurrApplnRndgAcc; "<VendorPostingGroup>"."Debit Curr. Appln. Rndg. Acc.")
                {
                }
                fieldelement(CreditCurrApplnRndgAcc; "<VendorPostingGroup>"."Credit Curr. Appln. Rndg. Acc.")
                {
                }
                fieldelement(DebitRoundingAccount; "<VendorPostingGroup>"."Debit Rounding Account")
                {
                }
                fieldelement(CreditRoundingAccount; "<VendorPostingGroup>"."Credit Rounding Account")
                {
                }
                fieldelement(PaymentDiscCreditAcc; "<VendorPostingGroup>"."Payment Disc. Credit Acc.")
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

