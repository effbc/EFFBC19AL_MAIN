xmlport 90203 "additional vendors"
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
                fieldelement(Name2; Vendor."Name 2")
                {
                }
                fieldelement(GenBusPostingGroup; Vendor."Gen. Bus. Posting Group")
                {
                }
                //EFFUPG>> 
                /*
                fieldelement(ExciseBusPostingGroup; Vendor."Excise Bus. Posting Group")
                {
                }
                */
                //EFFUPG<<
                fieldelement(VendorPostingGroup; Vendor."Vendor Posting Group")
                {
                }
                fieldelement(VATBusPostingGroup; Vendor."VAT Bus. Posting Group")
                {
                }
                fieldelement(TaxLiable; Vendor."Tax Liable")
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

