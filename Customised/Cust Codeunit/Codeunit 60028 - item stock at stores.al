codeunit 60028 "item stock at stores"
{

    trigger OnRun();
    begin
        /*IF item.FINDSET THEN
        REPEAT
        item."Stock at Stores":=0;
        iitem.modify;
        UNTIL item.NEXT=0;     */
        /*
        //item.SETRANGE(item."No.",'BOICOMP00072');
        IF item.FINDSET THEN
        REPEAT
        item.CALCFIELDS("Inventory at Stores");
        item.CALCFIELDS("Quantity Rejected");
        item.CALCFIELDS("Quantity Under Inspection");
        //"Inventory at STR" := item."Inventory at Stores" - (item."Quantity Under Inspection"+item."Quantity Rejected");
        //item."Stock at Stores":= item."Inventory at Stores"- (item."Quantity Under Inspection"+item."Quantity Rejected");
        //Dum_Count:=item."Inventory at Stores"- (item."Quantity Under Inspection"+item."Quantity Rejected");
        // IF item."Stock at Stores"<0 THEN
         item."Stock at Stores":=0;//a190808
        
        
        //anil
         ItemLedgEntry.RESET;
        item.CALCFIELDS("Quantity Under Inspection","Quantity Rejected","Quantity Rework","Quantity Sent for Rework");
        IF item."QC Enabled" = TRUE THEN BEGIN
         IF (item."Quantity Under Inspection"=0)AND (item."Quantity Rejected"=0)
         AND(item."Quantity Rework"=0) AND (item."Quantity Sent for Rework"=0) THEN
          BEGIN
          // "Stock at Stores":=0 ;
        
          ItemLedgEntry.SETCURRENTKEY("Item No.","Variant Code",Open,Positive,"Location Code","Posting Date",
          "Expiration Date","Lot No.","Serial No.");
          ItemLedgEntry.SETRANGE("Item No.",item."No.");
          ItemLedgEntry.SETRANGE(Open,TRUE);
          ItemLedgEntry.SETRANGE("Location Code",'STR');
          ItemLedgEntry.SETFILTER(ItemLedgEntry."Remaining Quantity",'>%1',0);
          REPEAT
             ItemLedgEntry.MARK(TRUE);
          UNTIL ItemLedgEntry.NEXT=0;
        
         // PAGE.RUNMODAL(38,ItemLedgEntry);
         END ELSE BEGIN
          item."Stock at Stores":=0 ;
          ItemLedgEntry.RESET;
          ItemLedgEntry.SETCURRENTKEY("Item No.","Variant Code",Open,Positive,"Location Code","Posting Date",
          "Expiration Date","Lot No.","Serial No.");
          ItemLedgEntry.SETRANGE("Item No.",item."No.");
          ItemLedgEntry.SETRANGE(Open,TRUE);
          ItemLedgEntry.SETRANGE("Location Code",'STR');
          ItemLedgEntry.SETFILTER(ItemLedgEntry."Remaining Quantity",'>%1',0);
          IF ItemLedgEntry.findsEt then
          REPEAT
           ItemLedgEntry.MARK(TRUE);
           IF (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") AND (QualityItemLedgEntry."Inspection Status"=
           QualityItemLedgEntry."Inspection Status"::"Under Inspection")) OR
           (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.")
           AND (QualityItemLedgEntry."Inspection Status"=QualityItemLedgEntry."Inspection Status"::Rejected)) THEN
            ItemLedgEntry.MARK(FALSE);
          //  "Stock at Stores":="Stock at Stores"+ItemLedgEntry."Remaining Quantity";
          UNTIL ItemLedgEntry.NEXT=0;
          //PAGE.RUNMODAL(38,ItemLedgEntry);
          END;
        END;
          ItemLedgEntry.MARKEDONLY(TRUE);
          IF ItemLedgEntry.findsEt then
          REPEAT
            item."Stock at Stores":=item."Stock at Stores"+ItemLedgEntry."Remaining Quantity";
        
          UNTIL ItemLedgEntry.NEXT=0;
                item."Stock At MCH Location":=0;
                ItemLedgEntry2.SETCURRENTKEY(ItemLedgEntry2."Item No.",ItemLedgEntry2."Variant Code",ItemLedgEntry2."Drop Shipment",
                                            ItemLedgEntry2."Location Code",ItemLedgEntry2."Posting Date");
                ItemLedgEntry2.SETRANGE(ItemLedgEntry2."Item No.",item."No.");
                ItemLedgEntry2.SETFILTER(ItemLedgEntry2."Location Code",'MCH');
                ItemLedgEntry2.SETFILTER(ItemLedgEntry2."Remaining Quantity",'>%1',0);
                IF ItemLedgEntry2.FINDSET THEN
                REPEAT
                  item."Stock At MCH Location"+=ItemLedgEntry2."Remaining Quantity";
                UNTIL ItemLedgEntry2.NEXT=0;
            item."Item Stock Value":=(item."Stock at Stores"*item."Avg Unit Cost");
        
        item.MODIFY;
        
        UNTIL item.NEXT=0;
         */
        MIH.SETFILTER(MIH."No.", 'C*');
        IF MIH.FINDSET THEN
            REPEAT
                MIL.RESET;
                MIL.SETFILTER(MIL."Document No.", MIH."No.");
                IF MIL.FINDSET THEN
                    REPEAT
                        MIL.DELETE;
                    UNTIL MIL.NEXT = 0;
                MIH.DELETE;
            UNTIL MIH.NEXT = 0;

    end;

    var
        TroubleshHeader: Record "Troubleshooting Header";
        //  SkilledResourceList: Page "Skilled Resource List";
        //  ItemCostMgt: Codeunit ItemCostManagement;
        // CalculateStdCost: Codeunit "Calculate Standard Cost";
        AverageCostLCY: Decimal;
        AverageCostACY: Decimal;
        "Inventory at STR": Decimal;
        "--B2B--": Integer;
        PurchaseInvLine: Record "Purch. Inv. Line";
        TotVendorAmt: Decimal;
        TotQty: Decimal;
        ItemCostUpdation: Codeunit "Item Cost Updation";
        atta: Boolean;
        attachments: Record Attachments;
        ItemLedgEntry: Record "Item Ledger Entry";
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
        item: Record Item;
        ItemLedgEntry2: Record "Item Ledger Entry";
        Dum_Count: Decimal;
        "Stock at Stores": Decimal;
        "Excepted Receipt Date Tracking": Record "Excepted Rcpt.Date Tracking";
        "Purchase Line": Record "Purchase Line";
        MIH: Record "Material Issues Header";
        MIL: Record "Material Issues Line";
}

