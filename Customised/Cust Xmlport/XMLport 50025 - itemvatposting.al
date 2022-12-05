xmlport 50025 itemvatposting
{
    Format = VariableText;

    schema
    {
        textelement(Items)
        {
            tableelement(Item; Item)
            {
                XmlName = 'Item';
                fieldelement(No; Item."No.")
                {
                }
                fieldelement(VATProductPostingGroup; Item."VAT Prod. Posting Group")
                {
                }
                fieldelement(GenProdPostingGroup; Item."Gen. Prod. Posting Group")
                {
                }
                fieldelement(TaxGroupCode; Item."Tax Group Code")
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

