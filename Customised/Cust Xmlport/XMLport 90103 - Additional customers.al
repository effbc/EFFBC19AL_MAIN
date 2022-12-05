xmlport 90103 "Additional customers"
{
    Format = VariableText;

    schema
    {
        textelement(Customers)
        {
            tableelement(Customer; Customer)
            {
                XmlName = 'Customer';
                fieldelement(No; Customer."No.")
                {
                }
                fieldelement(Name; Customer.Name)
                {
                }
                fieldelement(Name2; Customer."Name 2")
                {
                }
                fieldelement(GenBusPostingGroup; Customer."Gen. Bus. Posting Group")
                {
                }
                //EFFUPG>> 
                /*
                fieldelement(ExciseBusPostingGroup; Customer."Excise Bus. Posting Group")
                {
                }
                */
                //EFFUPG<<
                fieldelement(CustomerPostingGroup; Customer."Customer Posting Group")
                {
                }
                fieldelement(VATBusPostingGroup; Customer."VAT Bus. Posting Group")
                {
                }
                fieldelement(TaxLiable; Customer."Tax Liable")
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

