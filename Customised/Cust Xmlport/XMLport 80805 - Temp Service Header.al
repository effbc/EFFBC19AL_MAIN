xmlport 80805 "Temp Service Header"
{
    Format = VariableText;

    schema
    {
        textelement(TempServiceHeader)
        {
            tableelement("<tempserviceheader>"; "Temp Service Header")
            {
                XmlName = 'TempServiceHeader';
                fieldelement(No; "<TempServiceHeader>"."No.")
                {
                }
                fieldelement(Description; "<TempServiceHeader>".Description)
                {
                }
                fieldelement(DocumentType; "<TempServiceHeader>"."Document Type")
                {
                }
                fieldelement(ServiceOrderType; "<TempServiceHeader>"."Service Order Type")
                {
                }
                fieldelement(LinkServicetoServiceItem; "<TempServiceHeader>"."Link Service to Service Item")
                {
                }
                fieldelement(Status; "<TempServiceHeader>".Status)
                {
                }
                fieldelement(Priority; "<TempServiceHeader>".Priority)
                {
                }
                fieldelement(CustomerNo; "<TempServiceHeader>"."Customer No.")
                {
                }
                fieldelement(Name; "<TempServiceHeader>".Name)
                {
                }
                fieldelement(Name2; "<TempServiceHeader>"."Name 2")
                {
                }
                fieldelement(Address; "<TempServiceHeader>".Address)
                {
                }
                fieldelement(Address2; "<TempServiceHeader>"."Address 2")
                {
                }
                fieldelement(City; "<TempServiceHeader>".City)
                {
                }
                fieldelement(PostCode; "<TempServiceHeader>"."Post Code")
                {
                }
                fieldelement(PhoneNo; "<TempServiceHeader>"."Phone No.")
                {
                }
                fieldelement(EMail; "<TempServiceHeader>"."E-Mail")
                {
                }
                fieldelement(PhoneNo2; "<TempServiceHeader>"."Phone No. 2")
                {
                }
                fieldelement(FaxNo; "<TempServiceHeader>"."Fax No.")
                {
                }
                fieldelement(YourReference; "<TempServiceHeader>"."Your Reference")
                {
                }
                fieldelement(PostingDate; "<TempServiceHeader>"."Posting Date")
                {
                }
                fieldelement(DocumentDate; "<TempServiceHeader>"."Document Date")
                {
                }
                fieldelement(OrderDate; "<TempServiceHeader>"."Order Date")
                {
                }
                fieldelement(OrderTime; "<TempServiceHeader>"."Order Time")
                {
                }
                fieldelement(DefaultResponseTimeHours; "<TempServiceHeader>"."Default Response Time (Hours)")
                {
                }
                fieldelement(ActualResponseTimeHours; "<TempServiceHeader>"."Actual Response Time (Hours)")
                {
                }
                fieldelement(ServiceTimeHours; "<TempServiceHeader>"."Service Time (Hours)")
                {
                }
                fieldelement(ResponseDate; "<TempServiceHeader>"."Response Date")
                {
                }
                fieldelement(ResponseTime; "<TempServiceHeader>"."Response Time")
                {
                }
                fieldelement(StartingDate; "<TempServiceHeader>"."Starting Date")
                {
                }
                fieldelement(StartingTime; "<TempServiceHeader>"."Starting Time")
                {
                }
                fieldelement(FinishingDate; "<TempServiceHeader>"."Finishing Date")
                {
                }
                fieldelement(FinishingTime; "<TempServiceHeader>"."Finishing Time")
                {
                }
                fieldelement(ContractServHoursExist; "<TempServiceHeader>"."Contract Serv. Hours Exist")
                {
                }
                fieldelement(ShortcutDimension1Code; "<TempServiceHeader>"."Shortcut Dimension 1 Code")
                {
                }
                fieldelement(ShortcutDimension2Code; "<TempServiceHeader>"."Shortcut Dimension 2 Code")
                {
                }
                fieldelement(NotifyCustomer; "<TempServiceHeader>"."Notify Customer")
                {
                }
                fieldelement(MaxLaborUnitPrice; "<TempServiceHeader>"."Max. Labor Unit Price")
                {
                }
                fieldelement(WarningStatus; "<TempServiceHeader>"."Warning Status")
                {
                }
                fieldelement(SalespersonCode; "<TempServiceHeader>"."Salesperson Code")
                {
                }
                fieldelement(ContractNo; "<TempServiceHeader>"."Contract No.")
                {
                }
                fieldelement(ContactName; "<TempServiceHeader>"."Contact Name")
                {
                }
                fieldelement(BiltoCustomerNo; "<TempServiceHeader>"."Bill-to Customer No.")
                {
                }
                fieldelement(BiltoName; "<TempServiceHeader>"."Bill-to Name")
                {
                }
                fieldelement(BilltoAddress; "<TempServiceHeader>"."Bill-to Address")
                {
                }
                fieldelement(BilltoAddress2; "<TempServiceHeader>"."Bill-to Address 2")
                {
                }
                fieldelement(BiltoPostCode; "<TempServiceHeader>"."Bill-to Post Code")
                {
                }
                fieldelement(BilltoCity; "<TempServiceHeader>"."Bill-to City")
                {
                }
                fieldelement(BilltoContact; "<TempServiceHeader>"."Bill-to Contact")
                {
                }
                fieldelement(ShiptoCode; "<TempServiceHeader>"."Ship-to Code")
                {
                }
                fieldelement(ShiptoName; "<TempServiceHeader>"."Ship-to Name")
                {
                }
                fieldelement(ShiptoAddress; "<TempServiceHeader>"."Ship-to Address")
                {
                }
                fieldelement(ShiptoAddress2; "<TempServiceHeader>"."Ship-to Address 2")
                {
                }
                fieldelement(ShiptoPostCode; "<TempServiceHeader>"."Ship-to Post Code")
                {
                }
                fieldelement(ShiptoCity; "<TempServiceHeader>"."Ship-to City")
                {
                }
                fieldelement(ShiptoFaxNo; "<TempServiceHeader>"."Ship-to Fax No.")
                {
                }
                fieldelement(ShiptoEMail; "<TempServiceHeader>"."Ship-to E-Mail")
                {
                }
                fieldelement(ShiptoContact; "<TempServiceHeader>"."Ship-to Contact")
                {
                }
                fieldelement(ShiptoPhone; "<TempServiceHeader>"."Ship-to Phone")
                {
                }
                fieldelement(ShiptoPhone2; "<TempServiceHeader>"."Ship-to Phone 2")
                {
                }
                fieldelement(LanguageCode; "<TempServiceHeader>"."Language Code")
                {
                }
                fieldelement(Comment; "<TempServiceHeader>".Comment)
                {
                }
                fieldelement(NoSeries; "<TempServiceHeader>"."No. Series")
                {
                }
                fieldelement(JobNo; "<TempServiceHeader>"."Job No.")
                {
                }
                fieldelement(GenBusPostingGroup; "<TempServiceHeader>"."Gen. Bus. Posting Group")
                {
                }
                fieldelement(CurrencyCode; "<TempServiceHeader>"."Currency Code")
                {
                }
                fieldelement(CurrencyFactor; "<TempServiceHeader>"."Currency Factor")
                {
                }
                fieldelement(ServiceZoneCode; "<TempServiceHeader>"."Service Zone Code")
                {
                }
                fieldelement(ResponsibilityCenter; "<TempServiceHeader>"."Responsibility Center")
                {
                }
                fieldelement(LocationCode; "<TempServiceHeader>"."Location Code")
                {
                }
                fieldelement(CustomerPriceGroup; "<TempServiceHeader>"."Customer Price Group")
                {
                }
                fieldelement(VATBusPostingGroup; "<TempServiceHeader>"."VAT Bus. Posting Group")
                {
                }
                fieldelement(PriceIncludesVAT; "<TempServiceHeader>"."Price Includes VAT")
                {
                }
                fieldelement(VATRegistrationNo; "<TempServiceHeader>"."VAT Registration No.")
                {
                }
                fieldelement(VATCountryCode; "<TempServiceHeader>"."VAT Country Code")
                {
                }
                fieldelement(VATBaseDiscountPer; "<TempServiceHeader>"."VAT Base Discount %")
                {
                }
                fieldelement(TaxAreaCode; "<TempServiceHeader>"."Tax Area Code")
                {
                }
                fieldelement(TaxLiable; "<TempServiceHeader>"."Tax Liable")
                {
                }
                fieldelement(CustomerDiscGroup; "<TempServiceHeader>"."Customer Disc. Group")
                {
                }
                fieldelement(ExpectedFinishingDate; "<TempServiceHeader>"."Expected Finishing Date")
                {
                }
                fieldelement(Reserve; "<TempServiceHeader>".Reserve)
                {
                }
                fieldelement(BilltoCounty; "<TempServiceHeader>"."Bill-to County")
                {
                }
                fieldelement(County; "<TempServiceHeader>".County)
                {
                }
                fieldelement(ShiptoCounty; "<TempServiceHeader>"."Ship-to County")
                {
                }
                fieldelement(CountryCode; "<TempServiceHeader>"."Country Code")
                {
                }
                fieldelement(BilltoName2; "<TempServiceHeader>"."Bill-to Name 2")
                {
                }
                fieldelement(BilltoCountryCode; "<TempServiceHeader>"."Bill-to Country Code")
                {
                }
                fieldelement(ShiptoName2; "<TempServiceHeader>"."Ship-to Name 2")
                {
                }
                fieldelement(ShiptoCountryCode; "<TempServiceHeader>"."Ship-to Country Code")
                {
                }
                fieldelement(UsageCost; "<TempServiceHeader>"."Usage (Cost)")
                {
                }
                fieldelement(UsageAmount; "<TempServiceHeader>"."Usage (Amount)")
                {
                }
                fieldelement(InvoicedAmount; "<TempServiceHeader>"."Invoiced Amount")
                {
                }
                fieldelement(TotalQuantity; "<TempServiceHeader>"."Total Quantity")
                {
                }
                fieldelement(TotalQtytoInvoice; "<TempServiceHeader>"."Total Qty. to Invoice")
                {
                }
                fieldelement(NoofPostedInvoices; "<TempServiceHeader>"."No. of Posted Invoices")
                {
                }
                fieldelement(NoofUnpostedInvoices; "<TempServiceHeader>"."No. of Unposted Invoices")
                {
                }
                fieldelement(NoofAllocations; "<TempServiceHeader>"."No. of Allocations")
                {
                }
                fieldelement(NoofUnallocatedItems; "<TempServiceHeader>"."No. of Unallocated Items")
                {
                }
                fieldelement(AllocatedHours; "<TempServiceHeader>"."Allocated Hours")
                {
                }
                fieldelement(ReallocationNeeded; "<TempServiceHeader>"."Reallocation Needed")
                {
                }
                fieldelement(TypeFilter; "<TempServiceHeader>"."Type Filter")
                {
                }
                fieldelement(DateFilter; "<TempServiceHeader>"."Date Filter")
                {
                }
                fieldelement(ResourceFilter; "<TempServiceHeader>"."Resource Filter")
                {
                }
                fieldelement(ContractFilter; "<TempServiceHeader>"."Contract Filter")
                {
                }
                fieldelement(CustomerFilter; "<TempServiceHeader>"."Customer Filter")
                {
                }
                fieldelement(ServiceZoneFilter; "<TempServiceHeader>"."Service Zone Filter")
                {
                }
                fieldelement(ResourceGroupFilter; "<TempServiceHeader>"."Resource Group Filter")
                {
                }
                fieldelement(ContactNo; "<TempServiceHeader>"."Contact No.")
                {
                }
                fieldelement(BilltoContactNo; "<TempServiceHeader>"."Bill-to Contact No.")
                {
                }
                fieldelement(AllowLineDisc; "<TempServiceHeader>"."Allow Line Disc.")
                {
                }
                fieldelement(DocNoOccurrence; "<TempServiceHeader>"."Doc. No. Occurrence")
                {
                }
                fieldelement(VersionNo; "<TempServiceHeader>"."Version No.")
                {
                }
                fieldelement(NoofArchivedVersions; "<TempServiceHeader>"."No. of Archived Versions")
                {
                }
                fieldelement(Purpose; "<TempServiceHeader>".Purpose)
                {
                }
                fieldelement(MaterialIssueno; "<TempServiceHeader>"."Material Issue no.")
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

