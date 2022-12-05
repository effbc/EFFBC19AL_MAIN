xmlport 50027 "Eff Routing LIne"
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
                fieldelement(VersionCode; "<RoutingLine>"."Version Code")
                {
                }
                fieldelement(OperationNo; "<RoutingLine>"."Operation No.")
                {
                }
                fieldelement(NextOperationNo; "<RoutingLine>"."Next Operation No.")
                {
                }
                fieldelement(PreviousOperationNo; "<RoutingLine>"."Previous Operation No.")
                {
                }
                fieldelement(Type; "<RoutingLine>".Type)
                {
                }
                fieldelement(No; "<RoutingLine>"."No.")
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
                fieldelement(SetupTime; "<RoutingLine>"."Setup Time")
                {
                }
                fieldelement(RunTime; "<RoutingLine>"."Run Time")
                {
                }
                fieldelement(WaitTime; "<RoutingLine>"."Wait Time")
                {
                }
                fieldelement(MoveTime; "<RoutingLine>"."Move Time")
                {
                }
                fieldelement(FixedScrapQuantity; "<RoutingLine>"."Fixed Scrap Quantity")
                {
                }
                fieldelement(LotSize; "<RoutingLine>"."Lot Size")
                {
                }
                fieldelement(ScrapFactorPer; "<RoutingLine>"."Scrap Factor %")
                {
                }
                fieldelement(SetupTimeUnitofMeasCode; "<RoutingLine>"."Setup Time Unit of Meas. Code")
                {
                }
                fieldelement(RunTimeUnitofMeasCode; "<RoutingLine>"."Run Time Unit of Meas. Code")
                {
                }
                fieldelement(WaitTimeUnitofMeasCode; "<RoutingLine>"."Wait Time Unit of Meas. Code")
                {
                }
                fieldelement(MoveTimeUnitofMeasCode; "<RoutingLine>"."Move Time Unit of Meas. Code")
                {
                }
                fieldelement(MinimumProcessTime; "<RoutingLine>"."Minimum Process Time")
                {
                }
                fieldelement(MaximumProcessTime; "<RoutingLine>"."Maximum Process Time")
                {
                }
                fieldelement(ConcurrentCapacities; "<RoutingLine>"."Concurrent Capacities")
                {
                }
                fieldelement(SendAheadQuantity; "<RoutingLine>"."Send-Ahead Quantity")
                {
                }
                fieldelement(RoutingLinkCode; "<RoutingLine>"."Routing Link Code")
                {
                }
                fieldelement(StandardTaskCode; "<RoutingLine>"."Standard Task Code")
                {
                }
                fieldelement(UnitCostper; "<RoutingLine>"."Unit Cost per")
                {
                }
                fieldelement(Recalculate; "<RoutingLine>".Recalculate)
                {
                }
                fieldelement(Comment; "<RoutingLine>".Comment)
                {
                }
                fieldelement(SequenceNoForward; "<RoutingLine>"."Sequence No. (Forward)")
                {
                }
                fieldelement(SequenceNoBackward; "<RoutingLine>"."Sequence No. (Backward)")
                {
                }
                fieldelement(FixedScrapQtyAccum; "<RoutingLine>"."Fixed Scrap Qty. (Accum.)")
                {
                }
                fieldelement(ScrapFactorAccumulated; "<RoutingLine>"."Scrap Factor % (Accumulated)")
                {
                }
                fieldelement(OperationDescription; "<RoutingLine>"."Operation Description")
                {
                }
                fieldelement(SubAssembly; "<RoutingLine>"."Sub Assembly")
                {
                }
                fieldelement(QtyProduced; "<RoutingLine>"."Qty. Produced")
                {
                }
                fieldelement(SubAssemblyUnitofMeasCode; "<RoutingLine>"."Sub Assembly Unit of Meas.Code")
                {
                }
                fieldelement(SpecId; "<RoutingLine>"."Spec Id")
                {
                }
                fieldelement(QCEnabled; "<RoutingLine>"."QC Enabled")
                {
                }
                fieldelement(SubAssemblyDescription; "<RoutingLine>"."Sub Assembly Description")
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

