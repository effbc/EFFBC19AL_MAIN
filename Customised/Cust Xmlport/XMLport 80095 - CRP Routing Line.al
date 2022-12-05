xmlport 80095 "CRP Routing Line"
{
    Format = VariableText;

    schema
    {
        textelement(RoutingLines)
        {
            tableelement("<routingline>"; "Routing Line")
            {
                XmlName = 'RoutingLine';
                fieldelement(RoutingNo; "<RoutingLine>"."Routing No.")
                {
                }
                fieldelement(PreviousOperationNo; "<RoutingLine>"."Previous Operation No.")
                {
                }
                fieldelement(OperationNo; "<RoutingLine>"."Operation No.")
                {
                }
                fieldelement(NextOperationNo; "<RoutingLine>"."Next Operation No.")
                {
                }
                fieldelement(RoutingLinkCode; "<RoutingLine>"."Routing Link Code")
                {
                }
                fieldelement(Type; "<RoutingLine>".Type)
                {
                }
                fieldelement(WorkCenterNo; "<RoutingLine>"."Work Center No.")
                {
                }
                fieldelement(WorkCenterGroupCode; "<RoutingLine>"."Work Center Group Code")
                {
                }
                fieldelement(Description; "<RoutingLine>".Description)
                {
                }
                fieldelement(OperationDescription; "<RoutingLine>"."Operation Description")
                {
                }
                fieldelement(SubAssembly; "<RoutingLine>"."Sub Assembly")
                {
                }
                fieldelement(QCEnabled; "<RoutingLine>"."QC Enabled")
                {
                }
                fieldelement(SpecId; "<RoutingLine>"."Spec Id")
                {
                }
                fieldelement(RunTime; "<RoutingLine>"."Run Time")
                {
                }
                fieldelement(No; "<RoutingLine>"."No.")
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

