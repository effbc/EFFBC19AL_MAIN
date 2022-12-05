xmlport 80093 "CRP Work Centre"
{
    Format = VariableText;

    schema
    {
        textelement(WorkCenters)
        {
            tableelement("<workcenter>"; "Work Center")
            {
                XmlName = 'WorkCenter';
                fieldelement(No; "<WorkCenter>"."No.")
                {
                }
                fieldelement(Name; "<WorkCenter>".Name)
                {
                }
                fieldelement(SearchName; "<WorkCenter>"."Search Name")
                {
                }
                fieldelement(IndirectCostPer; "<WorkCenter>"."Indirect Cost %")
                {
                }
                fieldelement(UnitCost; "<WorkCenter>"."Unit Cost")
                {
                }
                fieldelement(AlternateWorkCenter; "<WorkCenter>"."Alternate Work Center")
                {
                }
                fieldelement(WorkCenterGroupCode; "<WorkCenter>"."Work Center Group Code")
                {
                }
                fieldelement(UnitofMeasureCode; "<WorkCenter>"."Unit of Measure Code")
                {
                }
                fieldelement(SubcontractorNo; "<WorkCenter>"."Subcontractor No.")
                {
                }
                fieldelement(DirectUnitCost; "<WorkCenter>"."Direct Unit Cost")
                {
                }
                fieldelement(Capacity; "<WorkCenter>".Capacity)
                {
                }
                fieldelement(Efficiency; "<WorkCenter>".Efficiency)
                {
                }
                fieldelement(ShopCalendarCode; "<WorkCenter>"."Shop Calendar Code")
                {
                }
                fieldelement(UnitCostCalculation; "<WorkCenter>"."Unit Cost Calculation")
                {
                }
                fieldelement(OverheadRate; "<WorkCenter>"."Overhead Rate")
                {
                }
                fieldelement(GenProdPostingGroup; "<WorkCenter>"."Gen. Prod. Posting Group")
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

