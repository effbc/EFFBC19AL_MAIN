xmlport 80029 "Tax Details"
{
    Format = VariableText;

    schema
    {
        textelement(TaxDetails)
        {
            tableelement("<taxdetail>"; "Tax Detail")
            {
                XmlName = 'TaxDetail';
                fieldelement(TaxJurisdictionCode; "<TaxDetail>"."Tax Jurisdiction Code")
                {
                }
                fieldelement(TaxGroupCode; "<TaxDetail>"."Tax Group Code")
                {
                }
                fieldelement(EffectiveDate; "<TaxDetail>"."Effective Date")
                {
                }
                fieldelement(TaxBelowMaximum; "<TaxDetail>"."Tax Below Maximum")
                {
                }
                /*
                fieldelement(FormsNotApplicable; "<TaxDetail>"."Forms Not Applicable")
                {
                }
                fieldelement(FormCode; "<TaxDetail>"."Form Code")
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

