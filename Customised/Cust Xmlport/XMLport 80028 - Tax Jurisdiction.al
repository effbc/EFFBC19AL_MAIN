xmlport 80028 "Tax Jurisdiction"
{
    Format = VariableText;

    schema
    {
        textelement(TaxJurisdiction)
        {
            tableelement("<taxjurisdiction>"; "Tax Jurisdiction")
            {
                XmlName = 'TaxJurisdiction';
                fieldelement(Code; "<TaxJurisdiction>".Code)
                {
                }
                fieldelement(Description; "<TaxJurisdiction>".Description)
                {
                }
                fieldelement(TaxAccountSales; "<TaxJurisdiction>"."Tax Account (Sales)")
                {
                }
                fieldelement(TaxAccountPurchases; "<TaxJurisdiction>"."Tax Account (Purchases)")
                {
                }
                fieldelement(CalculateTaxonTax; "<TaxJurisdiction>"."Calculate Tax on Tax")
                {
                }
                fieldelement(AdjustforPaymentDiscount; "<TaxJurisdiction>"."Adjust for Payment Discount")
                {
                }
                /*
                fieldelement(FormsNotApplicable; "<TaxJurisdiction>"."Forms Not Applicable")
                {
                }
                fieldelement(TaxType; "<TaxJurisdiction>"."Tax Type")
                {
                }
                */
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

