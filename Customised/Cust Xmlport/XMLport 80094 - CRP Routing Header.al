xmlport 80094 "CRP Routing Header"
{
    Format = VariableText;

    schema
    {
        textelement(RoutingHeader)
        {
            tableelement("<routingheader>"; "Routing Header")
            {
                XmlName = 'RoutingHeader';
                fieldelement(No; "<RoutingHeader>"."No.")
                {
                }
                fieldelement(Description; "<RoutingHeader>".Description)
                {
                }
                fieldelement(SearchDescription; "<RoutingHeader>"."Search Description")
                {
                }
                fieldelement(Status; "<RoutingHeader>".Status)
                {
                }
                fieldelement(Type; "<RoutingHeader>".Type)
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

