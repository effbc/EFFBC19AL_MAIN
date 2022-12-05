xmlport 80501 "Final Vendords dp"
{
    Format = VariableText;

    schema
    {
        textelement(Vendors)
        {
            tableelement(Vendor; Vendor)
            {
                XmlName = 'Vendor';
                fieldelement(No; Vendor."No.")
                {
                }
                fieldelement(Name; Vendor.Name)
                {
                }
                fieldelement(SearchName; Vendor."Search Name")
                {
                }
                fieldelement(Name2; Vendor."Name 2")
                {
                }
                fieldelement(Address; Vendor.Address)
                {
                }
                fieldelement(Address2; Vendor."Address 2")
                {
                }
                fieldelement(City; Vendor.City)
                {
                }
                fieldelement(Contact; Vendor.Contact)
                {
                }
                fieldelement(PhoneNo; Vendor."Phone No.")
                {
                }
                fieldelement(TelexNo; Vendor."Telex No.")
                {
                }
                fieldelement(OurAccountNo; Vendor."Our Account No.")
                {
                }
                fieldelement(TerittoryCode; Vendor."Territory Code")
                {
                }
                fieldelement(BudgetedAmount; Vendor."Budgeted Amount")
                {
                }
                fieldelement(VendorPostingGroup; Vendor."Vendor Posting Group")
                {
                }
                fieldelement(CurrencyCode; Vendor."Currency Code")
                {
                }
                fieldelement(LanguageCode; Vendor."Language Code")
                {
                }
                fieldelement(StatistisCode; Vendor."Statistics Group")
                {
                }
                fieldelement(PaymentTermCode; Vendor."Payment Terms Code")
                {
                }
                fieldelement(FinChargeTermCode; Vendor."Fin. Charge Terms Code")
                {
                }
                fieldelement(PurchaserCode; Vendor."Purchaser Code")
                {
                }
                fieldelement(ShipmentMethodCode; Vendor."Shipment Method Code")
                {
                }
                fieldelement(ShippingAgentCode; Vendor."Shipping Agent Code")
                {
                }
                fieldelement(InvoiceDiscCode; Vendor."Invoice Disc. Code")
                {
                }
                fieldelement(CountryRegionCode; Vendor."Country/Region Code")
                {
                }
                fieldelement(Comment; Vendor.Comment)
                {
                }
                fieldelement(Blocked; Vendor.Blocked)
                {
                }
                fieldelement(PaytoVendorNo; Vendor."Pay-to Vendor No.")
                {
                }
                fieldelement(Priority; Vendor.Priority)
                {
                }
                fieldelement(PaymentMethodCode; Vendor."Payment Method Code")
                {
                }
                fieldelement(ApplicationMethod; Vendor."Application Method")
                {
                }
                fieldelement(PricesIncludingVat; Vendor."Prices Including VAT")
                {
                }
                fieldelement(FaxNo; Vendor."Fax No.")
                {
                }
                fieldelement(TelexAnserBack; Vendor."Telex Answer Back")
                {
                }
                fieldelement(VATRegistrationNo; Vendor."VAT Registration No.")
                {
                }
                fieldelement(GenBusPostingGroup; Vendor."Gen. Bus. Posting Group")
                {
                }
                fieldelement(PostCode; Vendor."Post Code")
                {
                }
                fieldelement(County; Vendor.County)
                {
                }
                fieldelement(EMail; Vendor."E-Mail")
                {
                }
                fieldelement(HomePage; Vendor."Home Page")
                {
                }
                fieldelement(TaxLiable; Vendor."Tax Liable")
                {
                }
                fieldelement(VatBusPostingGroup; Vendor."VAT Bus. Posting Group")
                {
                }
                fieldelement(CurrencyFilter; Vendor."Currency Filter")
                {
                }
                fieldelement(PrimaryContactNo; Vendor."Primary Contact No.")
                {
                }
                fieldelement(ResponsibiltyCenter; Vendor."Responsibility Center")
                {
                }
                fieldelement(LocationCode; Vendor."Location Code")
                {
                }
                fieldelement(LeadTimeCalc; Vendor."Lead Time Calculation")
                {
                }
                fieldelement(baseCalendercode; Vendor."Base Calendar Code")
                {
                }
                //EFFUPG>> 
                /*
                fieldelement(TINNO; Vendor."T.I.N. No.")
                {
                }
                fieldelement(LSTNo; Vendor."L.S.T. No.")
                {
                }
                fieldelement(CSTNo; Vendor."C.S.T. No.")
                {
                }
                */
                //EFFUPG<<
                fieldelement(PANNO; Vendor."P.A.N. No.")
                {
                }
                //EFFUPG>> 
                /*
                fieldelement(ECCNo; Vendor."E.C.C. No.")
                {
                }
                fieldelement(Range; Vendor.Range)
                {
                }
                fieldelement(Collectorate; Vendor.Collectorate)
                {
                }
                */
                //EFFUPG<<
                fieldelement(StateCode; Vendor."State Code")
                {
                }
                //EFFUPG>>
                /*
                fieldelement(ExciseBusPostingGroup; Vendor."Excise Bus. Posting Group")
                {
                }
                fieldelement(SSI; Vendor.SSI)
                {
                }
                fieldelement(SSIValiidtyDate; Vendor."SSI Validity Date")
                {
                }
                fieldelement(Structure; Vendor.Structure)
                {
                }
                fieldelement(VendorType; Vendor."Vendor Type")
                {
                }
                */
                //EFFUPG<<
                fieldelement(VATBusPostingGroup; Vendor."VAT Bus. Posting Group")
                {
                }
                fieldelement(SubContrator; Vendor.Subcontractor)
                {
                }
                fieldelement(VendorLocation; Vendor."Vendor Location")
                {
                }
                fieldelement(CommissionersPermissions; Vendor."Commissioner's Permission No.")
                {
                }
                //EFFUPG>>
                /*
                fieldelement(ServiceTaxRegistration; Vendor."Service Tax Registration No.")
                {
                }
                */
                //EFFUPG<<
                fieldelement(MSPTCode; Vendor."MSPT Code")
                {
                }
                fieldelement(ReworkLocation; Vendor."Rework Location")
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

