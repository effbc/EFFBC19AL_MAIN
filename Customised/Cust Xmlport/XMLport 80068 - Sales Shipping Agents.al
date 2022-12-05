xmlport 80068 "Sales Shipping Agents"
{
    Format = VariableText;

    schema
    {
        textelement(ShippingAgents)
        {
            tableelement("<shippingagent>"; "Shipping Agent")
            {
                XmlName = 'ShippingAgent';
                fieldelement(Code; "<ShippingAgent>".Code)
                {
                }
                fieldelement(Name; "<ShippingAgent>".Name)
                {
                }
                fieldelement(InternetAddress; "<ShippingAgent>"."Internet Address")
                {
                }
                fieldelement(AccountNo; "<ShippingAgent>"."Account No.")
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

