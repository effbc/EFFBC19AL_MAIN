xmlport 50026 "Eff Routing Header"
{
    Format = VariableText;

    schema
    {
        textelement(RoutingHeaders)
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
                fieldelement(Description2; "<RoutingHeader>"."Description 2")
                {
                }
                fieldelement(SearchDescription; "<RoutingHeader>"."Search Description")
                {
                }
                fieldelement(LastDateModified; "<RoutingHeader>"."Last Date Modified")
                {
                }
                fieldelement(Comment; "<RoutingHeader>".Comment)
                {
                }
                fieldelement(Status; "<RoutingHeader>".Status)
                {
                }
                fieldelement(Type; "<RoutingHeader>".Type)
                {
                }
                fieldelement(VersionNos; "<RoutingHeader>"."Version Nos.")
                {
                }
                fieldelement(NoSeries; "<RoutingHeader>"."No. Series")
                {
                }
                fieldelement(BenchMarkTimeInHours; "<RoutingHeader>"."Bench Mark Time(In Hours)")
                {
                }
                fieldelement(UserId; "<RoutingHeader>"."User Id")
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

