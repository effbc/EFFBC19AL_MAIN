xmlport 80206 "VENDOR POSTING GROUP"
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
                //EFFUPG>>
                /*
                fieldelement(ExciseBusPostingGroup; Vendor."Excise Bus. Posting Group")
                {
                }
                */
                //EFFUPG<<
                fieldelement(VATBusinessPostingGroup; Vendor."VAT Bus. Posting Group")
                {
                }
                fieldelement(VendorPostingGroup; Vendor."Vendor Posting Group")
                {
                }
                fieldelement(GenBusPostingGroup; Vendor."Gen. Bus. Posting Group")
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

