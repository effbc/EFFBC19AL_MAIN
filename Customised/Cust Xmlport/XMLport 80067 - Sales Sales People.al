xmlport 80067 "Sales Sales People"
{
    Format = VariableText;

    schema
    {
        textelement(SalespersonPurchasers)
        {
            tableelement("<salespersonpurchaser>"; "Salesperson/Purchaser")
            {
                XmlName = 'SalespersonPurchaser';
                fieldelement(Code; "<SalespersonPurchaser>".Code)
                {
                }
                fieldelement(Name; "<SalespersonPurchaser>".Name)
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

