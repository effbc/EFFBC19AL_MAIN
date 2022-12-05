xmlport 50023 "Eff Item"
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
                fieldelement(Description2; Item."Description 2")
                {
                }
                fieldelement(NoofFixingHoles; Item."No.of Fixing Holes")
                {
                }
                fieldelement(InventoryatStores; Item."Inventory at Stores")
                {
                }
                fieldelement(TaxGroupCode; Item."Tax Group Code")
                {
                }
                /*
                fieldelement(ExciseProdPostingGroup; Item."Excise Prod. Posting Group")
                {
                }
                *///EFFUPG
                fieldelement(GenProdPostingGroup; Item."Gen. Prod. Posting Group")
                {
                }
                fieldelement(ShelfNo; Item."Shelf No.")
                {
                }
                fieldelement(InventoryPostingGroup; Item."Inventory Posting Group")
                {
                }
                fieldelement(VATProductPostingGroup; Item."VAT Prod. Posting Group")
                {
                }
                fieldelement(QCEnabled; Item."QC Enabled")
                {
                }
                fieldelement(SpecID; Item."Spec ID")
                {
                }
                fieldelement(WIPQCEnabled; Item."WIP QC Enabled")
                {
                }
                fieldelement(WIPSpecID; Item."WIP Spec ID")
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
                fieldelement(ProductionBOMNo; Item."Production BOM No.")
                {
                }
                fieldelement(RoutingNo; Item."Routing No.")
                {
                }
                fieldelement(NoofPins; Item."No. of Pins")
                {
                }
                fieldelement(NoofSolderingPoints; Item."No. of Soldering Points")
                {
                }
                fieldelement(TypeofSolder; Item."Type of Solder")
                {
                }
                fieldelement(NoofOpportunities; Item."No. of Opportunities")
                {
                }
                /*
                fieldelement(CapitalItem; Item."Capital Item")
                {
                }
                *///EFFUPG
                fieldelement(SubstitutesExist; Item."Substitutes Exist")
                {
                }
                fieldelement(BaseUnitofMeasure; Item."Base Unit of Measure")
                {
                }
                fieldelement(UnitCost; Item."Unit Cost")
                {
                }
                fieldelement(UnitPrice; Item."Unit Price")
                {
                }
                fieldelement(ItemTrackingCode; Item."Item Tracking Code")
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

