xmlport 80064 "Sales Item Charges"
{
    Format = VariableText;

    schema
    {
        textelement(ItemCharges)
        {
            tableelement("<itemcharge>"; "Item Charge")
            {
                XmlName = 'ItemCharge';
                fieldelement(No; "<ItemCharge>"."No.")
                {
                }
                fieldelement(Description; "<ItemCharge>".Description)
                {
                }
                fieldelement(GenProdPostingGroup; "<ItemCharge>"."Gen. Prod. Posting Group")
                {
                }
                fieldelement(TaxGroupCode; "<ItemCharge>"."Tax Group Code")
                {
                }
                fieldelement(VATProdPostingGroup; "<ItemCharge>"."VAT Prod. Posting Group")
                {
                }
                fieldelement(SearchDescription; "<ItemCharge>"."Search Description")
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

