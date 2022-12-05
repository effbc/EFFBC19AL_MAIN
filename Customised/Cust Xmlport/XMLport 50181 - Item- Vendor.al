xmlport 50181 "Item- Vendor"
{
    Format = VariableText;

    schema
    {
        textelement(ItemVendors)
        {
            tableelement("<itemvendor>"; "Item Vendor")
            {
                XmlName = 'ItemVendor';
                fieldelement(ItemNo; "<ItemVendor>"."Item No.")
                {
                }
                fieldelement(VendorNo; "<ItemVendor>"."Vendor No.")
                {
                }
                fieldelement(LeadTimeCalculation; "<ItemVendor>"."Lead Time Calculation")
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

