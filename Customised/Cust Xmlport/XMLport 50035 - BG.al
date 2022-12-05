xmlport 50035 BG
{
    Format = VariableText;

    schema
    {
        textelement(BankGuarantees)
        {
            tableelement("<bankguarantee>"; "Bank Guarantee")
            {
                XmlName = 'BankGuarantee';
                fieldelement(BGNo; "<BankGuarantee>"."BG No.")
                {
                }
                fieldelement(Description; "<BankGuarantee>".Description)
                {
                }
                fieldelement(IssuingBank; "<BankGuarantee>"."Issuing Bank")
                {
                }
                fieldelement(Branch; "<BankGuarantee>".Branch)
                {
                }
                fieldelement(PostCode; "<BankGuarantee>"."Post Code")
                {
                }
                fieldelement(City; "<BankGuarantee>".City)
                {
                }
                fieldelement(State; "<BankGuarantee>".State)
                {
                }
                fieldelement(TransactionType; "<BankGuarantee>"."Transaction Type")
                {
                }
                fieldelement(ExpiryDate; "<BankGuarantee>"."Expiry Date")
                {
                }
                fieldelement(TypeofBG; "<BankGuarantee>"."Type of BG")
                {
                }
                fieldelement(BGValue; "<BankGuarantee>"."BG Value")
                {
                }
                fieldelement(BGMarginAmount; "<BankGuarantee>"."BG Margin Amount")
                {
                }
                fieldelement(AccountNo; "<BankGuarantee>"."Account No.")
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

