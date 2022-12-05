xmlport 80092 "CRP Machine Center"
{
    Format = VariableText;

    schema
    {
        textelement(MachineCenters)
        {
            tableelement("<machinecenter>"; "Machine Center")
            {
                XmlName = 'MachineCenter';
                fieldelement(No; "<MachineCenter>"."No.")
                {
                }
                fieldelement(Name; "<MachineCenter>".Name)
                {
                }
                fieldelement(SearchName; "<MachineCenter>"."Search Name")
                {
                }
                fieldelement(WorkCenterNo; "<MachineCenter>"."Work Center No.")
                {
                }
                fieldelement(DirectUnitCost; "<MachineCenter>"."Direct Unit Cost")
                {
                }
                fieldelement(IndirectCostPer; "<MachineCenter>"."Indirect Cost %")
                {
                }
                fieldelement(UnitCost; "<MachineCenter>"."Unit Cost")
                {
                }
                fieldelement(Capacity; "<MachineCenter>".Capacity)
                {
                }
                fieldelement(Efficiency; "<MachineCenter>".Efficiency)
                {
                }
                fieldelement(SetupTime; "<MachineCenter>"."Setup Time")
                {
                }
                fieldelement(SetupTimeUnitofMeasCode; "<MachineCenter>"."Setup Time Unit of Meas. Code")
                {
                }
                fieldelement(ConcurrentCapacities; "<MachineCenter>"."Concurrent Capacities")
                {
                }
                fieldelement(OverheadRate; "<MachineCenter>"."Overhead Rate")
                {
                }
                fieldelement(GenProdPostingGroup; "<MachineCenter>"."Gen. Prod. Posting Group")
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

