xmlport 50177 Vendor
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
                fieldelement(EMail; Vendor."E-Mail")
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

