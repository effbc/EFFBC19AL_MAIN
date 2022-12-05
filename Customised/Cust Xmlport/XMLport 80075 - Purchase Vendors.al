xmlport 80075 "Purchase Vendors"
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
                fieldelement(VendorPostingGroup; Vendor."Vendor Posting Group")
                {
                }
                fieldelement(CurrencyCode; Vendor."Currency Code")
                {
                }
                fieldelement(PaymentTermsCode; Vendor."Payment Terms Code")
                {
                }
                fieldelement(FinChargeTermsCode; Vendor."Fin. Charge Terms Code")
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
                fieldelement(CountryRegionCode; Vendor."Country/Region Code")
                {
                }
                fieldelement(PaytoVendorNo; Vendor."Pay-to Vendor No.")
                {
                }
                fieldelement(PaymentMethodCode; Vendor."Payment Method Code")
                {
                }
                fieldelement(ApplicationMethod; Vendor."Application Method")
                {
                }
                fieldelement(FaxNo; Vendor."Fax No.")
                {
                }
                fieldelement(TelexAnswerBack; Vendor."Telex Answer Back")
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
                fieldelement(EMail; Vendor."E-Mail")
                {
                }
                fieldelement(HomePage; Vendor."Home Page")
                {
                }
                fieldelement(TaxAreaCode; Vendor."Tax Area Code")
                {
                }
                fieldelement(TaxLiable; Vendor."Tax Liable")
                {
                }
                fieldelement(VATBusinessPostingGroup; Vendor."VAT Bus. Posting Group")
                {
                }
                fieldelement(PrimaryContactNo; Vendor."Primary Contact No.")
                {
                }
                fieldelement(ResponsibilityCenter; Vendor."Responsibility Center")
                {
                }
                fieldelement(LocationCode; Vendor."Location Code")
                {
                }
                //EFFUPG>>
                /*
                fieldelement(TINNo; Vendor."T.I.N. No.")
                {
                }
                fieldelement(LSTNo; Vendor."L.S.T. No.")
                {
                }
                fieldelement(CSTNo; Vendor."C.S.T. No.")
                {
                }
                fieldelement(PANNo; Vendor."P.A.N. No.")
                {
                }
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
                */
                //EFFUPG<<
                fieldelement(ExciseRegistrationNo; Vendor."Excise Registration No.2")
                {
                }
                //EFFUPG>>
                /*
                fieldelement(SSI; Vendor.SSI)
                {
                }
                fieldelement(SSIValidityDate; Vendor."SSI Validity Date")
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
                fieldelement(Subcontractor; Vendor.Subcontractor)
                {
                }
                fieldelement(VendorLocation; Vendor."Vendor Location")
                {
                }
                fieldelement(CommissionersPermissionNo; Vendor."Commissioner's Permission No.")
                {
                }
                /*
                //EFFUPG<<
                fieldelement(ServiceTaxRegistrationNo; Vendor."Service Tax Registration No.")
                {
                }
                 */
                //EFFUPG<<
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

