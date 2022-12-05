xmlport 80080 "Inventory Item"
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
                fieldelement(SearchDescription; Item."Search Description")
                {
                }
                fieldelement(BaseUnitofMeasure; Item."Base Unit of Measure")
                {
                }
                fieldelement(InventoryPostingGroup; Item."Inventory Posting Group")
                {
                }
                fieldelement(ShelfNo; Item."Shelf No.")
                {
                }
                fieldelement(CostingMethod; Item."Costing Method")
                {
                }
                fieldelement(UnitCost; Item."Unit Cost")
                {
                }
                fieldelement(GenProdPostingGroup; Item."Gen. Prod. Posting Group")
                {
                }
                fieldelement(NoSeries; Item."No. Series")
                {
                }
                fieldelement(TaxGroupCode; Item."Tax Group Code")
                {
                }
                fieldelement(Reserve; Item.Reserve)
                {
                }
                fieldelement(SerialNos; Item."Serial Nos.")
                {
                }
                fieldelement(ReplenishmentSystem; Item."Replenishment System")
                {
                }
                fieldelement(ManufacturingPolicy; Item."Manufacturing Policy")
                {
                }
                fieldelement(ItemCategoryCode; Item."Item Category Code")
                {
                }
                fieldelement(ProductGroupCode; Item."Product Group Code Cust")
                {
                }
                fieldelement(ItemTrackingCode; Item."Item Tracking Code")
                {
                }
                //EFFUPG<<
                /*
                fieldelement(ExciseProdPostingGroup;Item."Excise Prod. Posting Group")
                {
                }
                fieldelement(ExciseAccountingType;Item."Excise Accounting Type")
                {
                }
                */
                //EFFUPG>>
                fieldelement(VATProductPostingGroup; Item."VAT Prod. Posting Group")
                {
                }
                fieldelement(NoofPins; Item."No. of Pins")
                {
                }
                fieldelement(NoofSolderingPoints; Item."No. of Soldering Points")
                {
                }
                fieldelement(NoofOpportunities; Item."No. of Opportunities")
                {
                }
                fieldelement(ItemSubGroupCode; Item."Item Sub Group Code")
                {
                }
                fieldelement(ItemSubSubGroupCode; Item."Item Sub Sub Group Code")
                {
                }
                fieldelement(TypeofSolder; Item."Type of Solder")
                {
                }
                fieldelement(NoofFixingHoles; Item."No.of Fixing Holes")
                {
                }
                fieldelement(SpecID; Item."Spec ID")
                {
                }
                fieldelement(QCEnabled; Item."QC Enabled")
                {
                }
                fieldelement(WIPSpecID; Item."WIP Spec ID")
                {
                }
                fieldelement(ProductionBOMNo; Item."Production BOM No.")
                {
                }
                fieldelement(RoutingNo; Item."Routing No.")
                {
                }
                fieldelement(WIPQCEnabled; Item."WIP QC Enabled")
                {
                }
                fieldelement(SalesUnitofMeasure; Item."Sales Unit of Measure")
                {
                }
                fieldelement(PurchUnitofMeasure; Item."Purch. Unit of Measure")
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

