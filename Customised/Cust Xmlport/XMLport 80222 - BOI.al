xmlport 80222 BOI
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
                fieldelement(InventoryPostingGroup; Item."Inventory Posting Group")
                {
                }
                fieldelement(UnitPrice; Item."Unit Price")
                {
                }
                fieldelement(ItemCategoryCode; Item."Item Category Code")
                {
                }
                fieldelement(ProductGroupCode; Item."Product Group Code Cust")
                {
                }
                fieldelement(ItemSubGroupCode; Item."Item Sub Group Code")
                {
                }
                fieldelement(ItemSubSubGroupCode; Item."Item Sub Sub Group Code")
                {
                }
                fieldelement(BaseUnitofMeasure; Item."Base Unit of Measure")
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

