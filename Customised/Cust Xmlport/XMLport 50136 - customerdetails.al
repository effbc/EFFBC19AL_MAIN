xmlport 50136 customerdetails
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
                fieldelement(TallyRef; Customer."Tally Ref")
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

