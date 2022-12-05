xmlport 80006 "G/L Countries"
{
    Format = VariableText;

    schema
    {
        textelement(CountryRegion)
        {
            tableelement("<countryregion>"; "Country/Region")
            {
                XmlName = 'CountryRegion';
                fieldelement(Code; "<CountryRegion>".Code)
                {
                }
                fieldelement(Name; "<CountryRegion>".Name)
                {
                }
                fieldelement(AddressFormat; "<CountryRegion>"."Address Format")
                {
                }
                fieldelement(ContactAddressFormat; "<CountryRegion>"."Contact Address Format")
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

