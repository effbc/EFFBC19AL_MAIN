xmlport 80226 "new items"
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
                fieldelement(CostingMethod; Item."Costing Method")
                {
                }
                fieldelement(GenProdPostingGroup; Item."Gen. Prod. Posting Group")
                {
                }
                fieldelement(PurchUnitofMeasure; Item."Purch. Unit of Measure")
                {
                }
                fieldelement(SalesUnitofMeasure; Item."Sales Unit of Measure")
                {
                }
                fieldelement(ReplenishmentSystem; Item."Replenishment System")
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

