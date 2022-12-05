xmlport 80204 "inv posting group"
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
                fieldelement(Description; Item.Description)
                {
                }
                fieldelement(GenProdPostingGroup; Item."Gen. Prod. Posting Group")
                {
                }
                fieldelement(InventoryPostingGroup; Item."Inventory Posting Group")
                {
                }
                fieldelement(TaxGroupCode; Item."Tax Group Code")
                {
                }
                fieldelement(VATProdPostingGroup; Item."VAT Prod. Posting Group")
                {
                }
                //EFFUPG>>
                /*
                fieldelement(ExciseProdPostingGroup; Item."Excise Prod. Posting Group")
                {
                }
                */
                //EFFUPG<<
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

