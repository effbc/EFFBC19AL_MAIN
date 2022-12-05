xmlport 80500 "Customer Final"
{
    Format = VariableText;

    schema
    {
        textelement(Customers)
        {
            tableelement(Customer; Customer)
            {
                XmlName = 'Customer';
                fieldelement(No; Customer."No.")
                {
                }
                fieldelement(Name; Customer.Name)
                {
                }
                fieldelement(SearchName; Customer."Search Name")
                {
                }
                fieldelement(Name2; Customer."Name 2")
                {
                }
                fieldelement(Address; Customer.Address)
                {
                }
                fieldelement(Address2; Customer."Address 2")
                {
                }
                fieldelement(City; Customer.City)
                {
                }
                fieldelement(Contact; Customer.Contact)
                {
                }
                fieldelement(PhoneNo; Customer."Phone No.")
                {
                }
                fieldelement(TelexNo; Customer."Telex No.")
                {
                }
                fieldelement(OurAccountNo; Customer."Our Account No.")
                {
                }
                fieldelement(TerritoryCode; Customer."Territory Code")
                {
                }
                fieldelement(ChainName; Customer."Chain Name")
                {
                }
                fieldelement(BudgetedAmount; Customer."Budgeted Amount")
                {
                }
                fieldelement(CreditLimitLCY; Customer."Credit Limit (LCY)")
                {
                }
                fieldelement(CustomerPostingGroup; Customer."Customer Posting Group")
                {
                }
                fieldelement(CurrencyCode; Customer."Currency Code")
                {
                }
                fieldelement(CustomerPriceGroup; Customer."Customer Price Group")
                {
                }
                fieldelement(LanguageCode; Customer."Language Code")
                {
                }
                fieldelement(StatisticsGroup; Customer."Statistics Group")
                {
                }
                fieldelement(PaymentTermsCode; Customer."Payment Terms Code")
                {
                }
                fieldelement(FinChargeTermsCode; Customer."Fin. Charge Terms Code")
                {
                }
                fieldelement(SalespersonCode; Customer."Salesperson Code")
                {
                }
                fieldelement(ShipmentMethodCode; Customer."Shipment Method Code")
                {
                }
                fieldelement(ShippingAgentCode; Customer."Shipping Agent Code")
                {
                }
                fieldelement(PlaceofExport; Customer."Place of Export")
                {
                }
                fieldelement(InvoiceDiscCode; Customer."Invoice Disc. Code")
                {
                }
                fieldelement(CustomerDiscGroup; Customer."Customer Disc. Group")
                {
                }
                fieldelement(CountryRegionCode; Customer."Country/Region Code")
                {
                }
                fieldelement(CollectionMethod; Customer."Collection Method")
                {
                }
                fieldelement(Amount; Customer.Amount)
                {
                }
                fieldelement(Comment; Customer.Comment)
                {
                }
                fieldelement(Blocked; Customer.Blocked)
                {
                }
                fieldelement(InvoiceCopies; Customer."Invoice Copies")
                {
                }
                fieldelement(LastStatementNo; Customer."Last Statement No.")
                {
                }
                fieldelement(PrintStatements; Customer."Print Statements")
                {
                }
                fieldelement(BiltoCustomerNo; Customer."Bill-to Customer No.")
                {
                }
                fieldelement(Priority; Customer.Priority)
                {
                }
                fieldelement(PaymentMethodCode; Customer."Payment Method Code")
                {
                }
                fieldelement(LastDateModified; Customer."Last Date Modified")
                {
                }
                fieldelement(ApplicationMethod; Customer."Application Method")
                {
                }
                fieldelement(PricesIncludingVAT; Customer."Prices Including VAT")
                {
                }
                fieldelement(LocationCode; Customer."Location Code")
                {
                }
                fieldelement(FaxNo; Customer."Fax No.")
                {
                }
                fieldelement(TelexAnswerBack; Customer."Telex Answer Back")
                {
                }
                fieldelement(VATRegistrationNo; Customer."VAT Registration No.")
                {
                }
                fieldelement(CombineShipments; Customer."Combine Shipments")
                {
                }
                fieldelement(GenBusPostingGroup; Customer."Gen. Bus. Posting Group")
                {
                }
                fieldelement(PostCode; Customer."Post Code")
                {
                }
                fieldelement(County; Customer.County)
                {
                }
                fieldelement(EMail; Customer."E-Mail")
                {
                }
                fieldelement(HomePage; Customer."Home Page")
                {
                }
                fieldelement(ReminderTermsCode; Customer."Reminder Terms Code")
                {
                }
                fieldelement(TaxLiable; Customer."Tax Liable")
                {
                }
                fieldelement(VATBusinessPostingGroup; Customer."VAT Bus. Posting Group")
                {
                }
                fieldelement(CurrencyFilter; Customer."Currency Filter")
                {
                }
                fieldelement(Reserve; Customer.Reserve)
                {
                }
                fieldelement(BlockPaymentTolerance; Customer."Block Payment Tolerance")
                {
                }
                fieldelement(PrimaryContactNo; Customer."Primary Contact No.")
                {
                }
                fieldelement(ResponsibilityCenter; Customer."Responsibility Center")
                {
                }
                fieldelement(ShippingAdvice; Customer."Shipping Advice")
                {
                }
                fieldelement(ShippingTime; Customer."Shipping Time")
                {
                }
                fieldelement(ShippingAgentServiceCode; Customer."Shipping Agent Service Code")
                {
                }
                fieldelement(ServiceZoneCode; Customer."Service Zone Code")
                {
                }
                fieldelement(ContractGainLossAmount; Customer."Contract Gain/Loss Amount")
                {
                }
                fieldelement(ShiptoFilter; Customer."Ship-to Filter")
                {
                }
                fieldelement(AllowLineDisc; Customer."Allow Line Disc.")
                {
                }
                fieldelement(BaseCalendarCode; Customer."Base Calendar Code")
                {
                }
                //EFFUPG>> 
                /*
                fieldelement(TINNo; Customer."T.I.N. No.")
                {
                }
                fieldelement(TaxExemptionNo; Customer."Tax Exemption No.")
                {
                }
                fieldelement(LSTNo; Customer."L.S.T. No.")
                {
                }
                fieldelement(CSTNo; Customer."C.S.T. No.")
                {
                }
                */
                //EFFUPG<<
                fieldelement(PANNo; Customer."P.A.N. No.")
                {
                }
                //EFFUPG>> 
                /*
                fieldelement(ECCNo; Customer."E.C.C. No.")
                {
                }
                fieldelement(Range; Customer.Range)
                {
                }
                fieldelement(Collectorate; Customer.Collectorate)
                {
                }
                fieldelement(ExciseBusPostingGroup; Customer."Excise Bus. Posting Group")
                {
                }
                fieldelement(Structure; Customer.Structure)
                {
                }
                */
                //EFFUPG<<
                fieldelement(VATBusinessPostingGroup; Customer."VAT Bus. Posting Group")
                {
                }
                fieldelement(MSPTCode; Customer."MSPT Code")
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

