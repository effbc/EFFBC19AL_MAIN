xmlport 50915 "Recoved Value Entries"
{

    schema
    {
        textelement(ValueEntries)
        {
            tableelement("<valueentry>"; "Value Entry")
            {
                XmlName = 'ValueEntry';
                fieldelement(EntryNo; "<ValueEntry>"."Entry No.")
                {
                }
                fieldelement(ItemNo; "<ValueEntry>"."Item No.")
                {
                }
                fieldelement(PostingDate; "<ValueEntry>"."Posting Date")
                {
                }
                fieldelement(ItemLedgerEntryType; "<ValueEntry>"."Item Ledger Entry Type")
                {
                }
                fieldelement(SourceNo; "<ValueEntry>"."Source No.")
                {
                }
                fieldelement(DocumentNo; "<ValueEntry>"."Document No.")
                {
                }
                fieldelement(Description; "<ValueEntry>".Description)
                {
                }
                fieldelement(LocationCode; "<ValueEntry>"."Location Code")
                {
                }
                fieldelement(InventoryPostingGroup; "<ValueEntry>"."Inventory Posting Group")
                {
                }
                fieldelement(SourcePostingGroup; "<ValueEntry>"."Source Posting Group")
                {
                }
                fieldelement(ItemLedgerEntryNo; "<ValueEntry>"."Item Ledger Entry No.")
                {
                }
                fieldelement(ValuedQuantity; "<ValueEntry>"."Valued Quantity")
                {
                }
                fieldelement(InvoicedQuantity; "<ValueEntry>"."Invoiced Quantity")
                {
                }
                fieldelement(CostperUnit; "<ValueEntry>"."Cost per Unit")
                {
                }
                fieldelement(SalesAmountActual; "<ValueEntry>"."Sales Amount (Actual)")
                {
                }
                fieldelement(SalespersPurchCode; "<ValueEntry>"."Salespers./Purch. Code")
                {
                }
                fieldelement(DiscountAmount; "<ValueEntry>"."Discount Amount")
                {
                }
                fieldelement(UserID; "<ValueEntry>"."User ID")
                {
                }
                fieldelement(SourceCode; "<ValueEntry>"."Source Code")
                {
                }
                fieldelement(AppliestoEntry; "<ValueEntry>"."Applies-to Entry")
                {
                }
                fieldelement(GlobalDimension1Code; "<ValueEntry>"."Global Dimension 1 Code")
                {
                }
                fieldelement(GlobalDimension2Code; "<ValueEntry>"."Global Dimension 2 Code")
                {
                }
                fieldelement(SourceType; "<ValueEntry>"."Source Type")
                {
                }
                fieldelement(CostAmountActual; "<ValueEntry>"."Cost Amount (Actual)")
                {
                }
                fieldelement(CostPostedtoGL; "<ValueEntry>"."Cost Posted to G/L")
                {
                }
                fieldelement(ReasonCode; "<ValueEntry>"."Reason Code")
                {
                }
                fieldelement(DropShipment; "<ValueEntry>"."Drop Shipment")
                {
                }
                fieldelement(JournalBatchName; "<ValueEntry>"."Journal Batch Name")
                {
                }
                fieldelement(GenBusPostingGroup; "<ValueEntry>"."Gen. Bus. Posting Group")
                {
                }
                fieldelement(GenProdPostingGroup; "<ValueEntry>"."Gen. Prod. Posting Group")
                {
                }
                fieldelement(DocumentDate; "<ValueEntry>"."Document Date")
                {
                }
                fieldelement(ExternalDocumentNo; "<ValueEntry>"."External Document No.")
                {
                }
                fieldelement(CostAmountActualACY; "<ValueEntry>"."Cost Amount (Actual) (ACY)")
                {
                }
                fieldelement(CostPostedtoGLACY; "<ValueEntry>"."Cost Posted to G/L (ACY)")
                {
                }
                fieldelement(CostperUnitACY; "<ValueEntry>"."Cost per Unit (ACY)")
                {
                }
                fieldelement(ExpectedCost; "<ValueEntry>"."Expected Cost")
                {
                }
                fieldelement(ItemChargeNo; "<ValueEntry>"."Item Charge No.")
                {
                }
                fieldelement(ValuedByAverageCost; "<ValueEntry>"."Valued By Average Cost")
                {
                }
                fieldelement(PartialRevaluation; "<ValueEntry>"."Partial Revaluation")
                {
                }
                fieldelement(Inventoriable; "<ValueEntry>".Inventoriable)
                {
                }
                fieldelement(ValuationDate; "<ValueEntry>"."Valuation Date")
                {
                }
                fieldelement(EntryType; "<ValueEntry>"."Entry Type")
                {
                }
                fieldelement(VarianceType; "<ValueEntry>"."Variance Type")
                {
                }
                fieldelement(PurchaseAmountActual; "<ValueEntry>"."Purchase Amount (Actual)")
                {
                }
                fieldelement(PurchaseAmountExpected; "<ValueEntry>"."Purchase Amount (Expected)")
                {
                }
                fieldelement(SalesAmountExpected; "<ValueEntry>"."Sales Amount (Expected)")
                {
                }
                fieldelement(CostAmountExpected; "<ValueEntry>"."Cost Amount (Expected)")
                {
                }
                fieldelement(CostAmountNonInvtbl; "<ValueEntry>"."Cost Amount (Non-Invtbl.)")
                {
                }
                fieldelement(CostAmountExpectedACY; "<ValueEntry>"."Cost Amount (Expected) (ACY)")
                {
                }
                fieldelement(CostAmountNonInvtblACY; "<ValueEntry>"."Cost Amount (Non-Invtbl.)(ACY)")
                {
                }
                fieldelement(OrderNo; "<ValueEntry>"."Order No.")
                {
                }
                fieldelement(VariantCode; "<ValueEntry>"."Variant Code")
                {
                }
                fieldelement(Adjustment; "<ValueEntry>".Adjustment)
                {
                }
                fieldelement(CapacityLedgerEntryNo; "<ValueEntry>"."Capacity Ledger Entry No.")
                {
                }
                fieldelement(Type; "<ValueEntry>".Type)
                {
                }
                fieldelement(No; "<ValueEntry>"."No.")
                {
                }
                fieldelement(OrderLineNo; "<ValueEntry>"."Order Line No.")
                {
                }
                fieldelement(ReturnReasonCode; "<ValueEntry>"."Return Reason Code")
                {
                }
                //EFFUPG>>
                /*
                fieldelement(BEDPer; "<ValueEntry>"."BED %")
                {
                }
                fieldelement(BEDAmount; "<ValueEntry>"."BED Amount")
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

