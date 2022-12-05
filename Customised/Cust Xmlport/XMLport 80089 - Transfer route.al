xmlport 80089 "Transfer route"
{
    Format = VariableText;

    schema
    {
        textelement(TransferRoutes)
        {
            tableelement("<transferroute>"; "Transfer Route")
            {
                XmlName = 'TransferRoute';
                fieldelement(TransferfromCode; "<TransferRoute>"."Transfer-from Code")
                {
                }
                fieldelement(TransfertoCode; "<TransferRoute>"."Transfer-to Code")
                {
                }
                fieldelement(InTransitCode; "<TransferRoute>"."In-Transit Code")
                {
                }
                fieldelement(ShippingAgentCode; "<TransferRoute>"."Shipping Agent Code")
                {
                }
                fieldelement(ShippingAgentServiceCode; "<TransferRoute>"."Shipping Agent Service Code")
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

