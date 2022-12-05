xmlport 80208 "O-VENDOR MASTER"
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
                fieldelement(Address; Vendor.Address)
                {
                }
                fieldelement(Address2; Vendor."Address 2")
                {
                }
                fieldelement(PANNo; Vendor."P.A.N. No.")
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

