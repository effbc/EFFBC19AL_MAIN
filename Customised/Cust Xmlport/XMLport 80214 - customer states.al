xmlport 80214 "customer states"
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
                fieldelement(PostCode; Customer."Post Code")
                {
                }
                fieldelement(StateCode; Customer."State Code")
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

