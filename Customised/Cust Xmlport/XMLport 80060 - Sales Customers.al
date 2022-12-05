xmlport 80060 "Sales Customers"
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
                fieldelement(CreditLimitLCY; Customer."Credit Limit (LCY)")
                {
                }
                fieldelement(CustomerPostingGroup; Customer."Customer Posting Group")
                {
                }
                fieldelement(CurrencyCode; Customer."Currency Code")
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
                fieldelement(CustomerDiscGroup; Customer."Customer Disc. Group")
                {
                }
                fieldelement(CountryRegionCode; Customer."Country/Region Code")
                {
                }
                fieldelement(CollectionMethod; Customer."Collection Method")
                {
                }
                fieldelement(Blocked; Customer.Blocked)
                {
                }
                fieldelement(InvoiceCopies; Customer."Invoice Copies")
                {
                }
                fieldelement(BiltoCustomerNo; Customer."Bill-to Customer No.")
                {
                }
                fieldelement(ApplicationMethod; Customer."Application Method")
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
                fieldelement(EMail; Customer."E-Mail")
                {
                }
                fieldelement(HomePage; Customer."Home Page")
                {
                }
                fieldelement(ReminderTermsCode; Customer."Reminder Terms Code")
                {
                }
                fieldelement(TaxAreaCode; Customer."Tax Area Code")
                {
                }
                fieldelement(TaxLiable; Customer."Tax Liable")
                {
                }
                fieldelement(VATBusinessPostingGroup; Customer."VAT Bus. Posting Group")
                {
                }
                fieldelement(PrimaryContactNo; Customer."Primary Contact No.")
                {
                }
                fieldelement(ShippingAdvice; Customer."Shipping Advice")
                {
                }
                fieldelement(ShippingAgentServiceCode; Customer."Shipping Agent Service Code")
                {
                }
                //EFFUPG<<
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
                //EFFUPG>>
                fieldelement(PANNo; Customer."P.A.N. No.")
                {
                }
                fieldelement(StateCode; Customer."State Code")
                {
                }

                //EFFUPG>>

                /*                fieldelement(ECCNo; Customer."E.C.C. No.")
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
                fieldelement(Reserve; Customer.Reserve)
                {
                }
                fieldelement(PaymentMethodCode; Customer."Payment Method Code")
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

