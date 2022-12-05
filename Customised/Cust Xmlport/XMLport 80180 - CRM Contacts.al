xmlport 80180 "CRM Contacts"
{
    Format = VariableText;

    schema
    {
        textelement(Contacts)
        {
            tableelement(Contact; Contact)
            {
                XmlName = 'Contact';
                fieldelement(No; Contact."No.")
                {
                }
                fieldelement(Name; Contact.Name)
                {
                }
                fieldelement(Type; Contact.Type)
                {
                }
                fieldelement(SearchName; Contact."Search Name")
                {
                }
                fieldelement(InitiatedBy; Contact."Initiated By")
                {
                }
                fieldelement(Address; Contact.Address)
                {
                }
                fieldelement(Address2; Contact."Address 2")
                {
                }
                fieldelement(City; Contact.City)
                {
                }
                fieldelement(PhoneNo; Contact."Phone No.")
                {
                }
                fieldelement(TelexNo; Contact."Telex No.")
                {
                }
                fieldelement(TerritoryCode; Contact."Territory Code")
                {
                }
                fieldelement(CurrencyCode; Contact."Currency Code")
                {
                }
                fieldelement(SalespersonCode; Contact."Salesperson Code")
                {
                }
                fieldelement(CountryRegionCode; Contact."Country/Region Code")
                {
                }
                fieldelement(PostCode; Contact."Post Code")
                {
                }
                fieldelement(CompanyNo; Contact."Company No.")
                {
                }
                fieldelement(CompanyName; Contact."Company Name")
                {
                }
                fieldelement(FirstName; Contact."First Name")
                {
                }
                fieldelement(MiddleName; Contact."Middle Name")
                {
                }
                fieldelement(Surname; Contact.Surname)
                {
                }
                fieldelement(MobilePhoneNo; Contact."Mobile Phone No.")
                {
                }
                fieldelement(SalutationCode; Contact."Salutation Code")
                {
                }
                fieldelement(EnquiryType; Contact."Enquiry Type")
                {
                }
                fieldelement(GovtPrivate; Contact."Govt./Private")
                {
                }
                fieldelement(DomesticForeign; Contact."Domestic/Foreign")
                {
                }
                fieldelement(ProductType; Contact."Product Type")
                {
                }
                fieldelement(InitiatedBy; Contact."Initiated By")
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

