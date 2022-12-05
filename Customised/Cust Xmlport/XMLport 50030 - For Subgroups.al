xmlport 50030 "For Subgroups"
{
    Format = VariableText;

    schema
    {
        textelement(AlternateItems)
        {
            tableelement("<alternateitems>"; "Alternate Items")
            {
                XmlName = 'AlternateItems';
                fieldelement(ProudctType; "<AlternateItems>"."Proudct Type")
                {
                }
                fieldelement(AlternativeItemDescription; "<AlternateItems>"."Alternative Item Description")
                {
                }
                fieldelement(Make; "<AlternateItems>".Make)
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

