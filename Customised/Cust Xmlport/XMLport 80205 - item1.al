xmlport 80205 item1
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
                fieldelement(VATBusPostingGroup; Customer."VAT Bus. Posting Group")
                {
                }
                /*
                fieldelement(ExciseBusPostingGroup; Customer."Excise Bus. Posting Group")
                {
                }
                */
                fieldelement(CustomerPostingGroup; Customer."Customer Posting Group")
                {
                }
                fieldelement(GenBusPostingGroup; Customer."Gen. Bus. Posting Group")
                {
                }
                fieldelement(VATBusinessPostingGroup; Customer."VAT Bus. Posting Group")
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

