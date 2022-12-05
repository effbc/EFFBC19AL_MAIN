xmlport 80806 "Temp Serice Item Line"
{
    Format = VariableText;

    schema
    {
        textelement(TempServiceItemLines)
        {
            tableelement("<tempserviceitemline>"; "Temp Service Item Line")
            {
                XmlName = 'TempServiceItemLine';
                fieldelement(DocumentNo; "<TempServiceItemLine>"."Document No.")
                {
                }
                fieldelement(LineNo; "<TempServiceItemLine>"."Line No.")
                {
                }
                fieldelement(ServiceItemNo; "<TempServiceItemLine>"."Service Item No.")
                {
                }
                fieldelement(ServiceItemGroupCode; "<TempServiceItemLine>"."Service Item Group Code")
                {
                }
                fieldelement(ItemNo; "<TempServiceItemLine>"."Item No.")
                {
                }
                fieldelement(SerialNo; "<TempServiceItemLine>"."Serial No.")
                {
                }
                fieldelement(Description; "<TempServiceItemLine>".Description)
                {
                }
                fieldelement(Description2; "<TempServiceItemLine>"."Description 2")
                {
                }
                fieldelement(RepairStatusCode; "<TempServiceItemLine>"."Repair Status Code")
                {
                }
                fieldelement(Priority; "<TempServiceItemLine>".Priority)
                {
                }
                fieldelement(ResponseTimeHours; "<TempServiceItemLine>"."Response Time (Hours)")
                {
                }
                fieldelement(ResponseDate; "<TempServiceItemLine>"."Response Date")
                {
                }
                fieldelement(ResponseTime; "<TempServiceItemLine>"."Response Time")
                {
                }
                fieldelement(StartingDate; "<TempServiceItemLine>"."Starting Date")
                {
                }
                fieldelement(StartingTime; "<TempServiceItemLine>"."Starting Time")
                {
                }
                fieldelement(FinishingDate; "<TempServiceItemLine>"."Finishing Date")
                {
                }
                fieldelement(FinishingTime; "<TempServiceItemLine>"."Finishing Time")
                {
                }
                fieldelement(ServiceShelfNo; "<TempServiceItemLine>"."Service Shelf No.")
                {
                }
                fieldelement(WarrantyStartingDateParts; "<TempServiceItemLine>"."Warranty Starting Date (Parts)")
                {
                }
                fieldelement(WarrantyEndingDateParts; "<TempServiceItemLine>"."Warranty Ending Date (Parts)")
                {
                }
                fieldelement(Warranty; "<TempServiceItemLine>".Warranty)
                {
                }
                fieldelement(WarrantyPerParts; "<TempServiceItemLine>"."Warranty % (Parts)")
                {
                }
                fieldelement(WarrantyPerLabor; "<TempServiceItemLine>"."Warranty % (Labor)")
                {
                }
                fieldelement(WarrantyStartingDateLabor; "<TempServiceItemLine>"."Warranty Starting Date (Labor)")
                {
                }
                fieldelement(WarrantyEndingDateLabor; "<TempServiceItemLine>"."Warranty Ending Date (Labor)")
                {
                }
                fieldelement(ContractNo; "<TempServiceItemLine>"."Contract No.")
                {
                }
                fieldelement(LocationofServiceItem; "<TempServiceItemLine>"."Location of Service Item")
                {
                }
                fieldelement(LoanerNo; "<TempServiceItemLine>"."Loaner No.")
                {
                }
                fieldelement(VendorNo; "<TempServiceItemLine>"."Vendor No.")
                {
                }
                fieldelement(VendorItemNo; "<TempServiceItemLine>"."Vendor Item No.")
                {
                }
                fieldelement(FaultReasonCode; "<TempServiceItemLine>"."Fault Reason Code")
                {
                }
                fieldelement(ServicePriceGroupCode; "<TempServiceItemLine>"."Service Price Group Code")
                {
                }
                fieldelement(FaultAreaCode; "<TempServiceItemLine>"."Fault Area Code")
                {
                }
                fieldelement(SymptomCode; "<TempServiceItemLine>"."Symptom Code")
                {
                }
                fieldelement(FaultCode; "<TempServiceItemLine>"."Fault Code")
                {
                }
                fieldelement(ResolutionCode; "<TempServiceItemLine>"."Resolution Code")
                {
                }
                fieldelement(FaultComment; "<TempServiceItemLine>"."Fault Comment")
                {
                }
                fieldelement(ResolutionComment; "<TempServiceItemLine>"."Resolution Comment")
                {
                }
                fieldelement(VariantCode; "<TempServiceItemLine>"."Variant Code")
                {
                }
                fieldelement(ServiceItemLoanerComment; "<TempServiceItemLine>"."Service Item Loaner Comment")
                {
                }
                fieldelement(ActualResponseTimeHours; "<TempServiceItemLine>"."Actual Response Time (Hours)")
                {
                }
                fieldelement(DocumentType; "<TempServiceItemLine>"."Document Type")
                {
                }
                fieldelement(ServPriceAdjmtGrCode; "<TempServiceItemLine>"."Serv. Price Adjmt. Gr. Code")
                {
                }
                fieldelement(AdjustmentType; "<TempServiceItemLine>"."Adjustment Type")
                {
                }
                fieldelement(BaseAmounttoAdjust; "<TempServiceItemLine>"."Base Amount to Adjust")
                {
                }
                fieldelement(NoofActiveFinishedAllocs; "<TempServiceItemLine>"."No. of Active/Finished Allocs")
                {
                }
                fieldelement(NoofAllocations; "<TempServiceItemLine>"."No. of Allocations")
                {
                }
                fieldelement(NoofPreviousServices; "<TempServiceItemLine>"."No. of Previous Services")
                {
                }
                fieldelement(ContractlineNo; "<TempServiceItemLine>"."Contract line No.")
                {
                }
                fieldelement(ShiptoCode; "<TempServiceItemLine>"."Ship-to Code")
                {
                }
                fieldelement(CustomerNo; "<TempServiceItemLine>"."Customer No.")
                {
                }
                fieldelement(DateFilter; "<TempServiceItemLine>"."Date Filter")
                {
                }
                fieldelement(ResourceFilter; "<TempServiceItemLine>"."Resource Filter")
                {
                }
                fieldelement(AllocationDateFilter; "<TempServiceItemLine>"."Allocation Date Filter")
                {
                }
                fieldelement(RepairStatusCodeFilter; "<TempServiceItemLine>"."Repair Status Code Filter")
                {
                }
                fieldelement(AllocationStatusFilter; "<TempServiceItemLine>"."Allocation Status Filter")
                {
                }
                fieldelement(ResponsibilityCenter; "<TempServiceItemLine>"."Responsibility Center")
                {
                }
                fieldelement(ServiceOrderFilter; "<TempServiceItemLine>"."Service Order Filter")
                {
                }
                fieldelement(ResourceGroupFilter; "<TempServiceItemLine>"."Resource Group Filter")
                {
                }
                fieldelement(ResolutionDescription; "<TempServiceItemLine>"."Resolution Description")
                {
                }
                fieldelement(FaultCodeDescription; "<TempServiceItemLine>"."Fault Code Description")
                {
                }
                fieldelement(FaultAreaDescription; "<TempServiceItemLine>"."Fault Area Description")
                {
                }
                fieldelement(SymptomDescription; "<TempServiceItemLine>"."Symptom Description")
                {
                }
                fieldelement(FromLocation; "<TempServiceItemLine>"."From Location")
                {
                }
                fieldelement(ToLocation; "<TempServiceItemLine>"."To Location")
                {
                }
                fieldelement(Account; "<TempServiceItemLine>".Account)
                {
                }
                fieldelement(CountrolSection; "<TempServiceItemLine>"."Countrol Section")
                {
                }
                fieldelement(NWStandAlone; "<TempServiceItemLine>"."N/W Stand Alone")
                {
                }
                fieldelement(IDNO; "<TempServiceItemLine>".IDNO)
                {
                }
                fieldelement(FWVersion; "<TempServiceItemLine>"."F/W Version")
                {
                }
                fieldelement(SWVersion; "<TempServiceItemLine>"."S/W Version")
                {
                }
                fieldelement(HWProcessType; "<TempServiceItemLine>"."H/W Process Type")
                {
                }
                fieldelement(OperatingVoltage; "<TempServiceItemLine>"."Operating Voltage")
                {
                }
                fieldelement(SupplyGivingFrom; "<TempServiceItemLine>"."Supply Giving From")
                {
                }
                fieldelement(EarthStatus; "<TempServiceItemLine>"."Earth Status")
                {
                }
                fieldelement(CommunicationMedia; "<TempServiceItemLine>"."Communication Media")
                {
                }
                fieldelement(WarrAMCNone; "<TempServiceItemLine>"."Warr/AMC/None")
                {
                }
                fieldelement(Zone; "<TempServiceItemLine>".Zone)
                {
                }
                fieldelement(Division; "<TempServiceItemLine>".Division)
                {
                }
                fieldelement(Station; "<TempServiceItemLine>".Station)
                {
                }
                fieldelement(OrderDate; "<TempServiceItemLine>"."Order Date")
                {
                }
                fieldelement(Sentdatetime; "<TempServiceItemLine>"."Sent date time")
                {
                }
                fieldelement(Unitcost; "<TempServiceItemLine>"."Unit cost")
                {
                }
                fieldelement(AMCOrderNo; "<TempServiceItemLine>"."AMC Order No")
                {
                }
                fieldelement(Tested; "<TempServiceItemLine>".Tested)
                {
                }
                fieldelement(AccountedDate; "<TempServiceItemLine>"."Accounted Date")
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

