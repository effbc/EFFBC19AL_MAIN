codeunit 33000253 "Inspection Jnl.-Post Line"
{
    // version QC1.1,WIP1.1,QCB2B1.2,RQC1.0,Rev01

    Permissions = TableData "Purch. Rcpt. Line" = rimd;
    TableNo = "Inspection Receipt Header";

    trigger OnRun();
    begin
        /*// commented on 140108
        IF "OLD IDS" THEN BEGIN
        InspectReceiptCheckLine.RunCheck(Rec);
        QualityLedgerEntry.RESET;
        QualityLedgerEntry.LOCKTABLE;
        IF QualityLedgerEntry.FINDLAST THEN
          QualityLedgerEntryNo := QualityLedgerEntry."Entry No."
        ELSE
          QualityLedgerEntryNo := 0;
        InitQualityLedger(Rec);
        IF ("Item Tracking Exists") AND ("Source Type" = "Source Type" :: "In Bound")
           AND (NOT "Quality Before Receipt") THEN
          InsertQCItemTrackingLedger(DATABASE::"Purch. Rcpt. Line",0,"Receipt No.",'',0,"Purch Line No",Rec)
        ELSE
          InsertQualityLedgerEntry(Rec);
        IF "Source Type" = "Source Type" :: "In Bound" THEN BEGIN
          IF NOT "Quality Before Receipt" THEN
            UpdatePurchRcptLine(Rec)
          ELSE
            UpdateWhseReceipts(Rec);
          InsertItemVendorRating(Rec);
        END;
        UpdateInspectAcptLevels(Rec);
        "Posted By" := USERID;
        
        //B2B-KNR
        Users.Reset;//Rev01
        Users.Setrange("User Name","Posted By");//Rev01
        //User.GET("Posted By");//Rev01
        "IR Posted By" := User.Name;
        
        "Posted Date" := TODAY;
        "Posted Time" := TIME;
        Status := TRUE;
        MODIFY;
        
        END ELSE BEGIN commented on 140108*/


        InspectReceiptCheckLine.RunCheck(Rec);
        QualityLedgerEntry.RESET;
        QualityLedgerEntry.LOCKTABLE;
        IF QualityLedgerEntry.FINDLAST THEN
            QualityLedgerEntryNo := QualityLedgerEntry."Entry No."
        ELSE
            QualityLedgerEntryNo := 0;
        InitQualityLedger(Rec);
        IF ("Item Tracking Exists") AND ("Source Type" = "Source Type"::"In Bound")
           AND (NOT "Quality Before Receipt") THEN
        //QCP1.0
        BEGIN
            IF Item.GET("Item No.") THEN BEGIN
                IF ItemTrackingCode.GET(Item."Item Tracking Code") THEN BEGIN
                    IF (ItemTrackingCode."SN Specific Tracking") OR (ItemTrackingCode."SN Purchase Inbound Tracking") OR
                       (ItemTrackingCode."SN Purchase Outbound Tracking")
                    THEN BEGIN
                        //11Sep08>>
                        PostInspDataSheetHeader.SETRANGE("No.", "Ids Reference No.");
                        PostInspDataSheetHeader.SETFILTER("Parent IDS No", '<>%1', '');
                        IF PostInspDataSheetHeader.FINDFIRST THEN
                            InsertQCItemTrackingLedger2(DATABASE::"Purch. Rcpt. Line", 0, "Receipt No.", '', 0, "Purch Line No", Rec)
                        ELSE
                            //11Sep08<<
                            InsertQCItemTrackingLedger(DATABASE::"Purch. Rcpt. Line", 0, "Receipt No.", '', 0, "Purch Line No", Rec) //BASE
                                                                                                                                     //commented on 010108 InsertSerialTrackingQLE(Rec)
                    END ELSE
                        IF (ItemTrackingCode."Lot Specific Tracking") OR (ItemTrackingCode."Lot Purchase Inbound Tracking") OR
                       (ItemTrackingCode."Lot Purchase Outbound Tracking")
               THEN
                            InseertLOTItemTrackingQLE(Rec);
                END;
            END;
        END ELSE
            InseertLOTItemTrackingQLE(Rec);
        //QCP1.0
        IF "Source Type" = "Source Type"::"In Bound" THEN BEGIN
            IF NOT "Quality Before Receipt" THEN
                UpdatePurchRcptLine(Rec)
            ELSE
                UpdateWhseReceipts(Rec);
            InsertItemVendorRating(Rec);
        END;
        //QCP1.0
        /*
            UpdateWhseReceipts(Rec);
          InsertItemVendorRating(Rec);
        */
        UpdateInspectAcptLevels(Rec);
        "Posted By" := USERID;

        //B2B-KNR
        User.RESET;//Rev01
        User.SETRANGE("User Name", "Posted By");//Rev01
        //User.GET("Posted By"); //Rev01
        IF User.FINDFIRST THEN
            "IR Posted By" := User."User Name"  //B2B
        ELSE
            MESSAGE('User ID Not found in User table');
        "Posted Date" := TODAY;
        "Posted Time" := TIME;
        Status := TRUE;
        MODIFY;

    end;

    var
        TEXT000: Label 'Total quatity should be equal to Quantity received';
        QualityLedgerEntry: Record "Quality Ledger Entry";
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
        ItemApplnEntry: Record "Item Application Entry";
        DeliveryChalan: Record "Delivery/Receipt Entry";
        ItemJnlLine: Record "Item Journal Line";
        InspectDataSheets: Codeunit "Inspection Data Sheets";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        InspectReceiptCheckLine: Codeunit "Inspection Jnl.-Check Line";
        QualityLedgerEntryNo: Integer;
        Text001: Label 'Output quantity should be less than the quality accepted quantity';
        RemainQty: Decimal;
        QtyToApply: Decimal;
        Text002: Label 'Do you want to send the material back to Vendor/works?';
        Text003: Label 'Do you want to receive the reworked material back?';
        Text004: Label '''Material is transferred to Vendor successfully.''';
        Text005: Label '''Material is received back from Vendor successfully.''';
        TempQLEDoc: Code[20];
        User: Record User;
        "--B2BQCCheck--": Integer;
        ItemLedEntry: Record "Item Ledger Entry";
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        ChildIDS: Code[20];
        PostInspDataSheetHeader: Record "Posted Inspect DatasheetHeader";
        PIL: Record "Purch. Inv. Line";
        Receiptfilter: Text;
        text: Code[20];
        IRH: Record "Inspection Receipt Header";
        Inspection_No: Text;
        c: Integer;

    procedure InsertQualityLedgerEntry(InspectReceipt: Record "Inspection Receipt Header");
    begin
        IF InspectReceipt."Qty. Accepted" <> 0 THEN BEGIN
            IF InspectReceipt."Rework Level" = 0 THEN
                QualityLedgerEntry."In bound Item Ledger Entry No." := InspectReceipt."Item Ledger Entry No."
            ELSE
                QualityLedgerEntry."In bound Item Ledger Entry No." := InspectReceipt."DC Inbound Ledger Entry.";
            QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
            QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
            QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type"::Accepted;
            QualityLedgerEntry.Quantity := InspectReceipt."Qty. Accepted";
            QualityLedgerEntry."Remaining Quantity" := InspectReceipt."Qty. Accepted";
            QualityLedgerEntry."Operation No." := InspectReceipt."Operation No.";
            QualityLedgerEntry.INSERT;
            IF (InspectReceipt."Source Type" = InspectReceipt."Source Type"::"In Bound") AND
            (NOT InspectReceipt."Quality Before Receipt") THEN
                UpdateItemLedgerEntry(QualityLedgerEntry, FALSE);
        END;
        IF InspectReceipt."Qty. Rejected" <> 0 THEN BEGIN
            IF InspectReceipt."Rework Level" = 0 THEN
                QualityLedgerEntry."In bound Item Ledger Entry No." := InspectReceipt."Item Ledger Entry No."
            ELSE
                QualityLedgerEntry."In bound Item Ledger Entry No." := InspectReceipt."DC Inbound Ledger Entry.";
            QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
            QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
            QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type"::Reject;
            QualityLedgerEntry.Quantity := InspectReceipt."Qty. Rejected";
            QualityLedgerEntry."Remaining Quantity" := InspectReceipt."Qty. Rejected";
            QualityLedgerEntry."Operation No." := InspectReceipt."Operation No.";
            QualityLedgerEntry.INSERT;
            IF (InspectReceipt."Source Type" = InspectReceipt."Source Type"::"In Bound") AND
            (NOT InspectReceipt."Quality Before Receipt") THEN
                UpdateItemLedgerEntry(QualityLedgerEntry, FALSE);
        END;
        IF InspectReceipt."Qty. Accepted Under Deviation" <> 0 THEN BEGIN
            IF InspectReceipt."Rework Level" = 0 THEN
                QualityLedgerEntry."In bound Item Ledger Entry No." := InspectReceipt."Item Ledger Entry No."
            ELSE
                QualityLedgerEntry."In bound Item Ledger Entry No." := InspectReceipt."DC Inbound Ledger Entry.";
            QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
            QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
            QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type"::Accepted;
            QualityLedgerEntry.Quantity := InspectReceipt."Qty. Accepted Under Deviation";
            QualityLedgerEntry."Remaining Quantity" := InspectReceipt."Qty. Accepted Under Deviation";
            QualityLedgerEntry."Accepted Under Dev. Reason" := InspectReceipt."Qty. Accepted UD Reason";
            QualityLedgerEntry."Reason Description" := InspectReceipt."Reason Description";
            QualityLedgerEntry."Operation No." := InspectReceipt."Operation No.";
            QualityLedgerEntry.INSERT;
            IF (InspectReceipt."Source Type" = InspectReceipt."Source Type"::"In Bound") AND
            (NOT InspectReceipt."Quality Before Receipt") THEN
                UpdateItemLedgerEntry(QualityLedgerEntry, FALSE);
        END;
        QualityLedgerEntry."In bound Item Ledger Entry No." := InspectReceipt."Item Ledger Entry No.";
        QualityLedgerEntry."Item Ledger Entry No." := InspectReceipt."Item Ledger Entry No.";
        UpdateParentInspectionReceipt(InspectReceipt);
        IF InspectReceipt."Qty. Rework" <> 0 THEN BEGIN
            QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
            QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
            QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type"::Rework;
            QualityLedgerEntry.Open := TRUE;
            QualityLedgerEntry.Quantity := InspectReceipt."Qty. Rework";
            QualityLedgerEntry."Remaining Quantity" := InspectReceipt."Qty. Rework";
            QualityLedgerEntry."Accepted Under Dev. Reason" := '';
            QualityLedgerEntry."Reason Description" := '';
            QualityLedgerEntry."Operation No." := InspectReceipt."Operation No.";
            QualityLedgerEntry.INSERT;
        END;
    end;

    procedure InitQualityLedger(var InspectReceipt: Record "Inspection Receipt Header");
    begin
        QualityLedgerEntry.INIT;
        QualityLedgerEntry."Item No." := InspectReceipt."Item No.";
        QualityLedgerEntry."Sub Assembly Code" := InspectReceipt."Sub Assembly Code";
        QualityLedgerEntry."Posting Date" := InspectReceipt."Posting Date";
        QualityLedgerEntry."Source No." := InspectReceipt."Receipt No.";
        QualityLedgerEntry."Source Type" := InspectReceipt."Source Type";
        QualityLedgerEntry."Unit Of Measure Code" := InspectReceipt."Unit Of Measure Code";
        IF InspectReceipt."Source Type" = InspectReceipt."Source Type"::"In Bound" THEN BEGIN
            QualityLedgerEntry."Order No." := InspectReceipt."Order No.";
            QualityLedgerEntry."Order Line No." := InspectReceipt."Purch Line No"
        END ELSE BEGIN
            QualityLedgerEntry."Order No." := InspectReceipt."Prod. Order No.";
            QualityLedgerEntry."Order Line No." := InspectReceipt."Prod. Order Line";
        END;
        QualityLedgerEntry."Document No." := InspectReceipt."No.";
        QualityLedgerEntry."Location Code" := InspectReceipt."Location Code";
        QualityLedgerEntry."New Location Code" := InspectReceipt."New Location Code";
        QualityLedgerEntry."Lot No." := InspectReceipt."Lot No.";
        QualityLedgerEntry."Item Ledger Entry No." := InspectReceipt."Item Ledger Entry No.";
        QualityLedgerEntry."Vendor No." := InspectReceipt."Vendor No.";
        QualityLedgerEntry."Rework Level" := InspectReceipt."Rework Level";
        QualityLedgerEntry."Rework Reference No." := InspectReceipt."Rework Reference No.";
        QualityLedgerEntry."Unit Of Measure Code" := InspectReceipt."Unit Of Measure Code";
        QualityLedgerEntry."Qty. per Unit of Measure" := InspectReceipt."Qty. per Unit of Measure";
    end;

    procedure UpdateItemLedgerEntry(QualityLedgEntry2: Record "Quality Ledger Entry"; ItemTrackingExists: Boolean);
    var
        ItemApplnEntry: Record "Item Application Entry";
        "-Rev01-": Integer;
        ItemLedgEntryLRec: Record "Item Ledger Entry";
    begin
        ItemJnlLine.SETRANGE(ItemJnlLine."Journal Template Name", 'RECLASS');
        ItemJnlLine.SETRANGE(ItemJnlLine."Journal Batch Name", 'DEFAULT');
        IF ItemJnlLine.FINDFIRST THEN
            ItemJnlLine.DELETEALL;
        ItemJnlLine.RESET;
        ItemJnlLine.INIT;
        ItemJnlLine."Journal Template Name" := 'RECLASS';
        ItemJnlLine."Journal Batch Name" := 'DEFAULT';
        ItemJnlLine."Posting Date" := WORKDATE;
        ItemJnlLine."Document Date" := WORKDATE;
        ItemJnlLine."Document No." := QualityLedgEntry2."Document No.";
        ItemJnlLine."Line No." := ItemReclassLineNo;
        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::Transfer;
        ItemJnlLine.VALIDATE("Item No.", QualityLedgEntry2."Item No.");
        //B2BQC Check start
        IF (QualityLedgEntry2."Entry Type" <> QualityLedgEntry2."Entry Type"::Accepted) THEN
            ItemJnlLine."QC Check" := TRUE;
        //B2BQC Check end;
        IF QualityLedgEntry2."Unit Of Measure Code" <> '' THEN
            ItemJnlLine.VALIDATE("Unit of Measure Code", QualityLedgEntry2."Unit Of Measure Code");
        IF QualityLedgEntry2."Rework Level" = 0 THEN BEGIN
            //QCP1.0
            //CommentedItemJnlLine.VALIDATE(Quantity,QualityLedgEntry2."Remaining Quantity");
            ItemJnlLine.VALIDATE(Quantity, QualityLedgEntry2.Quantity);
            //QCP1.0

            IF QualityLedgEntry2."Location Code" <> '' THEN
                ItemJnlLine.VALIDATE("Location Code", QualityLedgEntry2."Location Code");
            IF QualityLedgEntry2."New Location Code" <> '' THEN
                ItemJnlLine.VALIDATE("New Location Code", QualityLedgEntry2."New Location Code");


            //Rev01 Start
            //Code Commented
            /*
            ItemJnlLine.VALIDATE("Applies-to Entry",QualityLedgerEntry."In bound Item Ledger Entry No.");
            */
            IF NOT ItemTrackingExists THEN
                ItemJnlLine.VALIDATE("Applies-to Entry", QualityLedgerEntry."In bound Item Ledger Entry No.")
            ELSE BEGIN
                IF QualityLedgerEntry."In bound Item Ledger Entry No." <> 0 THEN BEGIN
                    ItemLedgEntryLRec.GET(QualityLedgerEntry."In bound Item Ledger Entry No.");

                    ItemJnlLine."Location Code" := ItemLedgEntryLRec."Location Code";
                    ItemJnlLine."Variant Code" := ItemLedgEntryLRec."Variant Code";
                END;
            END;
            //Rev01 End

            ItemJnlLine."Quality Ledger Entry No." := QualityLedgEntry2."Entry No.";
            //QCP1.0
            ItemJnlLine."Quantity (Base)" := ItemJnlLine.Quantity;
            IF ItemTrackingExists THEN BEGIN
                "UpdateRes.Entry"(ItemJnlLine, QualityLedgEntry2);
            END;
            //QCP1.0

            ItemJnlLine.INSERT;
            ItemJnlPostLine.RUN(ItemJnlLine);
            IF (QualityLedgerEntry."Entry Type" = QualityLedgerEntry."Entry Type"::Accepted) OR
              (QualityLedgerEntry."Entry Type" = QualityLedgerEntry."Entry Type"::Reject) THEN BEGIN
                ItemApplnEntry.SETRANGE("Transferred-from Entry No.", QualityLedgEntry2."In bound Item Ledger Entry No.");
                IF ItemApplnEntry.FINDLAST THEN
                    QualityLedgerEntry."Item Ledger Entry No." := ItemApplnEntry."Inbound Item Entry No.";
            END;
            UpdateQualityItemLedgEntry;
        END ELSE BEGIN
            QualityItemLedgEntry.SETRANGE("Entry No.", QualityLedgEntry2."In bound Item Ledger Entry No.");
            RemainQty := QualityLedgEntry2.Quantity;
            IF QualityItemLedgEntry.FINDSET THEN
                REPEAT
                    IF RemainQty < QualityItemLedgEntry."Remaining Quantity" THEN
                        QtyToApply := RemainQty
                    ELSE
                        QtyToApply := QualityItemLedgEntry."Remaining Quantity";
                    RemainQty := RemainQty - QtyToApply;
                    IF QtyToApply <> 0 THEN BEGIN
                        ItemJnlLine.SETRANGE(ItemJnlLine."Journal Template Name", 'RECLASS');
                        ItemJnlLine.SETRANGE(ItemJnlLine."Journal Batch Name", 'DEFAULT');
                        IF ItemJnlLine.FINDFIRST THEN
                            ItemJnlLine.DELETEALL;
                        ItemJnlLine.RESET;
                        ItemJnlLine.INIT;
                        ItemJnlLine."Journal Template Name" := 'RECLASS';
                        ItemJnlLine."Journal Batch Name" := 'DEFAULT';
                        ItemJnlLine."Posting Date" := WORKDATE;
                        ItemJnlLine."Document Date" := WORKDATE;
                        ItemJnlLine."Document No." := QualityLedgEntry2."Document No.";
                        ItemJnlLine."Line No." := ItemReclassLineNo;
                        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::Transfer;

                        //QCP1.0
                        ItemJnlLine."Transfer Type" := ItemJnlLine."Transfer Type"::" ";
                        //QCP1.0

                        ItemJnlLine.VALIDATE("Item No.", QualityLedgEntry2."Item No.");
                        ItemJnlLine."Applies-to Entry" := QualityItemLedgEntry."Entry No.";
                        ItemJnlLine.VALIDATE(Quantity, QtyToApply);
                        ItemJnlLine.VALIDATE("Location Code", QualityLedgEntry2."Location Code");
                        ItemJnlLine.VALIDATE("New Location Code", QualityLedgEntry2."Location Code");
                        ItemJnlLine.VALIDATE("Applies-to Entry", QualityItemLedgEntry."Entry No.");
                        ItemJnlLine."Quality Ledger Entry No." := QualityLedgEntry2."Entry No.";
                        QualityLedgerEntry."In bound Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                        //B2BQC Check start
                        IF (QualityLedgEntry2."Entry Type" <> QualityLedgEntry2."Entry Type"::Accepted) THEN
                            ItemJnlLine."QC Check" := TRUE;
                        //B2BQC Check end;

                        ItemJnlLine.INSERT;
                        ItemJnlPostLine.RUN(ItemJnlLine);
                        IF (QualityLedgerEntry."Entry Type" = QualityLedgerEntry."Entry Type"::Accepted) OR
                          (QualityLedgerEntry."Entry Type" = QualityLedgerEntry."Entry Type"::Reject) THEN BEGIN
                            ItemApplnEntry.SETRANGE("Transferred-from Entry No.", QualityLedgerEntry."In bound Item Ledger Entry No.");
                            IF ItemApplnEntry.FINDLAST THEN
                                QualityLedgerEntry."Item Ledger Entry No." := ItemApplnEntry."Inbound Item Entry No.";
                        END;
                        UpdateQualityItemLedgEntry;
                    END;
                UNTIL QualityItemLedgEntry.NEXT = 0;
        END;
        QualityLedgerEntry.Open := FALSE;
        QualityLedgerEntry."Remaining Quantity" := 0;
        QualityLedgerEntry.MODIFY;

    end;

    procedure UpdateParentInspectionReceipt(InspectReceipt: Record "Inspection Receipt Header");
    var
        ParentInspectionReceipt: Record "Inspection Receipt Header";
        QualityLedgEntry2: Record "Quality Ledger Entry";
        ProdOrderInspectComp: Record "Prod. Order Inspect Component";
        ProdOrderInspectRtng: Record "Ins Prod. Order Routing Line";
    begin
        IF ParentInspectionReceipt.GET(InspectReceipt."Rework Reference No.") THEN BEGIN
            ParentInspectionReceipt."Rework Completed" := TRUE;
            ParentInspectionReceipt.MODIFY;
            IF InspectReceipt."In Process" THEN BEGIN

                ProdOrderInspectComp.SETRANGE(Status, ProdOrderInspectComp.Status::Released);
                ProdOrderInspectComp.SETRANGE("Prod. Order No.", InspectReceipt."Prod. Order No.");
                ProdOrderInspectComp.SETRANGE("Prod. Order Line No.", InspectReceipt."Prod. Order Line");
                ProdOrderInspectComp.SETRANGE("Inspection Receipt No.", InspectReceipt."Rework Reference No.");
                ProdOrderInspectComp.MODIFYALL("Rework Completed", TRUE);

                ProdOrderInspectRtng.SETRANGE("Routing Status", ProdOrderInspectRtng."Routing Status"::"In Progress");
                ProdOrderInspectRtng.SETRANGE("Prod. Order No.", InspectReceipt."Prod. Order No.");
                ProdOrderInspectRtng.SETRANGE("Routing Reference No.", InspectReceipt."Routing Reference No.");
                ProdOrderInspectRtng.SETRANGE("Routing No.", InspectReceipt."Routing No.");
                ProdOrderInspectRtng.SETRANGE("Inspection Receipt No.", InspectReceipt."Rework Reference No.");
                ProdOrderInspectRtng.MODIFYALL("Routing Status", ProdOrderInspectRtng."Routing Status"::Finished);

            END;
        END;

        IF NOT InspectReceipt."Item Tracking Exists" THEN BEGIN
            QualityLedgEntry2.SETRANGE("Document No.", InspectReceipt."Rework Reference No.");
            QualityLedgEntry2.SETRANGE("Entry Type", QualityLedgEntry2."Entry Type"::Rework);
            QualityLedgEntry2.SETRANGE(Open, TRUE);
            IF QualityLedgEntry2.FINDFIRST THEN BEGIN
                QualityLedgEntry2."Remaining Quantity" := QualityLedgEntry2."Remaining Quantity" - InspectReceipt.Quantity;
                IF QualityLedgEntry2."Remaining Quantity" = 0 THEN
                    QualityLedgEntry2.Open := FALSE;
                IF QualityItemLedgEntry.GET(InspectReceipt."DC Inbound Ledger Entry.") THEN BEGIN
                    QualityItemLedgEntry."Quality Ledger Entry No." := QualityLedgerEntry."Entry No.";
                    QualityItemLedgEntry.Rework := TRUE;
                    QualityItemLedgEntry.Accept := FALSE;
                    QualityItemLedgEntry.MODIFY;
                END;

                //QCP1.0
                IF QualityItemLedgEntry.FINDFIRST THEN
                    IF QualityItemLedgEntry."Remaining Quantity" = 0 THEN
                        QualityItemLedgEntry.DELETE
                    ELSE
                        QualityItemLedgEntry.MODIFY;
                //QCP1.0

                QualityLedgEntry2.MODIFY;
            END;
        END;
    end;

    procedure UpdateParentQualityLedgEntry(RoutingReferenceNo: Code[20]);
    var
        QualityLedgEntry2: Record "Quality Ledger Entry";
    begin
        QualityLedgEntry2.SETRANGE("Item Ledger Entry No.", QualityLedgerEntry."Item Ledger Entry No.");
        QualityLedgEntry2.SETRANGE("Document No.", RoutingReferenceNo);
        IF QualityLedgEntry2.FINDFIRST THEN BEGIN
            QualityLedgEntry2."Remaining Quantity" := 0;
            QualityLedgEntry2.Open := FALSE;
            QualityLedgEntry2.MODIFY;
        END;
    end;

    procedure UpdateInspectRoutingComponents();
    begin
    end;

    procedure UpdateQualityItemLedgEntry();
    var
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        CASE QualityLedgerEntry."Entry Type" OF
            QualityLedgerEntry."Entry Type"::Reject:
                BEGIN
                    ItemLedgEntry.GET(QualityLedgerEntry."Item Ledger Entry No.");
                    QualityItemLedgEntry.TRANSFERFIELDS(ItemLedgEntry);
                    QualityItemLedgEntry."Inspection Status" := QualityItemLedgEntry."Inspection Status"::Rejected;
                    QualityItemLedgEntry."Quality Ledger Entry No." := QualityLedgerEntry."Entry No.";
                    QualityItemLedgEntry.Reject := TRUE;
                    QualityItemLedgEntry.Accept := FALSE;
                    QualityItemLedgEntry.INSERT;
                END;
            QualityLedgerEntry."Entry Type"::Rework, QualityLedgerEntry."Entry Type"::Reworked:
                EXIT;
        END;
        QualityItemLedgEntry."Quality Ledger Entry No." := QualityLedgerEntry."Entry No.";
        QualityItemLedgEntry.GET(QualityLedgerEntry."In bound Item Ledger Entry No.");
        IF QualityLedgerEntry."Rework Reference No." = '' THEN BEGIN
            QualityItemLedgEntry."Remaining Quantity" := QualityItemLedgEntry."Remaining Quantity" - QualityLedgerEntry.Quantity;
            QualityItemLedgEntry.Accept := FALSE;
            QualityItemLedgEntry.Rework := TRUE;
        END ELSE BEGIN
            QualityItemLedgEntry."Remaining Quantity" := QualityItemLedgEntry."Remaining Quantity" - QtyToApply;
            QualityItemLedgEntry.Accept := FALSE;
            QualityItemLedgEntry.Rework := TRUE;
        END;
        IF QualityItemLedgEntry."Remaining Quantity" = 0 THEN
            QualityItemLedgEntry.DELETE
        ELSE
            QualityItemLedgEntry.MODIFY;
    end;

    procedure UpdateWhseReceipts(InspectReceipt2: Record "Inspection Receipt Header");
    var
        WhseReceiptLine: Record "Warehouse Receipt Line";
    begin
        WhseReceiptLine.RESET;
        WhseReceiptLine.SETRANGE("Source Type", 39);
        WhseReceiptLine.SETRANGE("Source Subtype", 1);
        WhseReceiptLine.SETRANGE("Source Document", WhseReceiptLine."Source Document"::"Purchase Order");
        WhseReceiptLine.SETRANGE("Source No.", InspectReceipt2."Order No.");
        WhseReceiptLine.SETRANGE("Source Line No.", InspectReceipt2."Purch Line No");
        IF WhseReceiptLine.FINDFIRST THEN BEGIN
            WhseReceiptLine."Quantity Accepted" := WhseReceiptLine."Quantity Accepted" +
            InspectReceipt2."Qty. Accepted" + InspectReceipt2."Qty. Accepted Under Deviation";
            IF InspectReceipt2."Rework Level" = 0 THEN
                WhseReceiptLine."Quantity Rework" := WhseReceiptLine."Quantity Rework" + InspectReceipt2."Qty. Rework"
            ELSE
                WhseReceiptLine."Quantity Rework" := WhseReceiptLine."Quantity Rework" - InspectReceipt2.Quantity +
                  InspectReceipt2."Qty. Rework";
            WhseReceiptLine."Quantity Rejected" := WhseReceiptLine."Quantity Rejected" + InspectReceipt2."Qty. Rejected";
            WhseReceiptLine.MODIFY;
        END;
    end;

    procedure UpdatePurchRcptLine(InspectReceipt2: Record "Inspection Receipt Header");
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        PurchRcptLine.RESET;
        PurchRcptLine.SETRANGE("Document No.", InspectReceipt2."Receipt No.");
        PurchRcptLine.SETRANGE("Line No.", InspectReceipt2."Purch Line No");
        PurchRcptLine.FINDFIRST;
        PurchRcptLine."Quantity Accepted" += InspectReceipt2."Qty. Accepted" + InspectReceipt2."Qty. Accepted Under Deviation";
        PurchRcptLine."Quantity Rework" := InspectReceipt2."Qty. Rework";
        PurchRcptLine."Quantity Rejected" += InspectReceipt2."Qty. Rejected";
        PurchRcptLine.MODIFY;
        UpdatePostedWhseReceipts(InspectReceipt2);
        UpdateQCPassed(InspectReceipt2); // added by sujani (20Dec18)  for qc passed
    end;

    procedure UpdatePostedWhseReceipts(InspectReceipt2: Record "Inspection Receipt Header");
    var
        PostWReceiptLine: Record "Posted Whse. Receipt Line";
    begin
        PostWReceiptLine.RESET;
        PostWReceiptLine.SETRANGE("Source Document", PostWReceiptLine."Source Document"::"Purchase Order");
        PostWReceiptLine.SETRANGE("Posted Source No.", InspectReceipt2."Receipt No.");
        PostWReceiptLine.SETRANGE("Source Line No.", InspectReceipt2."Purch Line No");
        IF PostWReceiptLine.FINDFIRST THEN BEGIN
            PostWReceiptLine."Quantity Accepted" += InspectReceipt2."Qty. Accepted" + InspectReceipt2."Qty. Accepted Under Deviation";
            PostWReceiptLine."Quantity Rework" := InspectReceipt2."Qty. Rework";
            PostWReceiptLine."Quantity Rejected" += InspectReceipt2."Qty. Rejected";
            PostWReceiptLine.MODIFY;
            UpdateWhsePutaway(PostWReceiptLine);
        END;
    end;

    procedure UpdateWhsePutaway(PostWReceiptLine2: Record "Posted Whse. Receipt Line");
    var
        WhseActivityLIne: Record "Warehouse Activity Line";
        TempWhseActivityLine1: Record "Warehouse Activity Line" temporary;
        TempWhseActivityLine2: Record "Warehouse Activity Line" temporary;
    begin
        WhseActivityLIne.RESET;
        WhseActivityLIne.SETRANGE("Whse. Document Type", WhseActivityLIne."Whse. Document Type"::Receipt);
        WhseActivityLIne.SETRANGE(WhseActivityLIne."Whse. Document No.", PostWReceiptLine2."No.");
        WhseActivityLIne.SETRANGE("Whse. Document Line No.", PostWReceiptLine2."Line No.");
        IF WhseActivityLIne.FINDFIRST THEN BEGIN
            IF WhseActivityLIne.COUNT = 1 THEN BEGIN
                WhseActivityLIne."Quantity Accepted" := WhseActivityLIne."Quantity Accepted" + PostWReceiptLine2."Quantity Accepted";
                WhseActivityLIne."Quantity Rework" := WhseActivityLIne."Quantity Rework" + PostWReceiptLine2."Quantity Rework";
                WhseActivityLIne."Quantity Rejected" := WhseActivityLIne."Quantity Rejected" + PostWReceiptLine2."Quantity Rejected";
                WhseActivityLIne.MODIFY;
                EXIT
            END ELSE BEGIN
                REPEAT
                    IF WhseActivityLIne."Cross-Dock Information" = WhseActivityLIne."Cross-Dock Information"::"Cross-Dock Items" THEN
                        TempWhseActivityLine1 := WhseActivityLIne
                    ELSE
                        TempWhseActivityLine2 := WhseActivityLIne;
                UNTIL WhseActivityLIne.NEXT = 0;

                IF TempWhseActivityLine1.Quantity <= PostWReceiptLine2."Quantity Accepted" THEN BEGIN
                    TempWhseActivityLine1."Quantity Accepted" := TempWhseActivityLine1.Quantity;
                    TempWhseActivityLine2."Quantity Accepted" := PostWReceiptLine2."Quantity Accepted" - TempWhseActivityLine1.Quantity;
                END ELSE
                    TempWhseActivityLine1."Quantity Accepted" := PostWReceiptLine2."Quantity Accepted";

                IF TempWhseActivityLine2.Quantity <= PostWReceiptLine2."Quantity Rejected" THEN BEGIN
                    TempWhseActivityLine2."Quantity Rejected" := TempWhseActivityLine2.Quantity;
                    TempWhseActivityLine1."Quantity Rejected" := PostWReceiptLine2."Quantity Rejected" - TempWhseActivityLine2.Quantity;
                END ELSE
                    TempWhseActivityLine2."Quantity Rejected" := PostWReceiptLine2."Quantity Rejected";

                TempWhseActivityLine1."Quantity Rework" := TempWhseActivityLine1.Quantity - TempWhseActivityLine1."Quantity Accepted"
                  - TempWhseActivityLine1."Quantity Rejected";
                TempWhseActivityLine2."Quantity Rework" := TempWhseActivityLine2.Quantity - TempWhseActivityLine2."Quantity Accepted"
                  - TempWhseActivityLine2."Quantity Rejected";

                WhseActivityLIne := TempWhseActivityLine1;
                WhseActivityLIne.MODIFY;
                WhseActivityLIne := TempWhseActivityLine2;
                WhseActivityLIne.MODIFY;
            END;
        END;
    end;

    procedure CallPostedItemTrackingForm(Type: Integer; Subtype: Integer; ID: Code[20]; BatchName: Code[10]; ProdOrderLine: Integer; RefNo: Integer; var InspectReceipt2: Record "Inspection Receipt Header") OK: Boolean;
    var
        ItemEntryRelation: Record "Item Entry Relation";
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
        TempItemLedgEntry1: Record "Quality Item Ledger Entry" temporary;
        SignFactor: Integer;
    begin
        ItemEntryRelation.SETCURRENTKEY("Source ID", "Source Type");
        ItemEntryRelation.SETRANGE("Source Type", Type);
        MESSAGE('%1\%2\%3\%4\%5\%6\%7', Type, Subtype, ID, BatchName, ProdOrderLine, RefNo, InspectReceipt2."Lot No.");
        ItemEntryRelation.SETRANGE("Source Subtype", Subtype);
        ItemEntryRelation.SETRANGE("Source ID", ID);
        ItemEntryRelation.SETRANGE("Source Batch Name", BatchName);
        ItemEntryRelation.SETRANGE("Source Prod. Order Line", ProdOrderLine);
        ItemEntryRelation.SETRANGE("Source Ref. No.", RefNo);
        ItemEntryRelation.SETRANGE("Lot No.", InspectReceipt2."Lot No.");
        TempItemLedgEntry1.DELETEALL;
        IF ItemEntryRelation.FINDFIRST THEN BEGIN
            SignFactor := TableSignFactor(Type);
            IF NOT InspectReceipt2.Status THEN BEGIN
                IF InspectReceipt2."Rework Level" = 0 THEN BEGIN
                    REPEAT
                        IF QualityItemLedgEntry.GET(ItemEntryRelation."Item Entry No.") THEN BEGIN
                            IF (QualityItemLedgEntry."Inspection Status" = QualityItemLedgEntry."Inspection Status"::"Under Inspection") THEN BEGIN
                                TempItemLedgEntry1 := QualityItemLedgEntry;
                                TempItemLedgEntry1.INSERT;
                            END;
                        END;
                    UNTIL ItemEntryRelation.NEXT = 0;
                    PAGE.RUNMODAL(PAGE::"Inspection Item Tracking Lines", TempItemLedgEntry1)
                END ELSE BEGIN
                    IF InspectReceipt2."Serial No." = '' THEN BEGIN
                        QualityItemLedgEntry.SETRANGE("Lot No.", InspectReceipt2."Lot No.");
                        IF QualityItemLedgEntry.FINDFIRST THEN BEGIN
                            TempItemLedgEntry1 := QualityItemLedgEntry;
                            TempItemLedgEntry1.INSERT;
                        END;
                    END
                    ELSE BEGIN
                        QualityItemLedgEntry.SETRANGE("Serial No.", InspectReceipt2."Serial No.");
                        IF QualityItemLedgEntry.FINDFIRST THEN BEGIN
                            TempItemLedgEntry1 := QualityItemLedgEntry;
                            TempItemLedgEntry1.INSERT;
                        END
                    END;
                    PAGE.RUNMODAL(PAGE::"Inspection Item Tracking Lines", TempItemLedgEntry1);
                END;
                InspectReceipt2."Qty. Accepted" := 0;
                InspectReceipt2."Qty. Rejected" := 0;
                InspectReceipt2."Qty. Rework" := 0;
                InspectReceipt2."Qty. Accepted Under Deviation" := 0;
                IF TempItemLedgEntry1.FINDSET THEN
                    REPEAT
                        IF TempItemLedgEntry1.Accept THEN
                            InspectReceipt2."Qty. Accepted" := InspectReceipt2."Qty. Accepted" + TempItemLedgEntry1.Quantity;
                        IF TempItemLedgEntry1.Reject THEN
                            InspectReceipt2."Qty. Rejected" := InspectReceipt2."Qty. Rejected" + TempItemLedgEntry1.Quantity;
                        IF TempItemLedgEntry1.Rework THEN
                            InspectReceipt2."Qty. Rework" := InspectReceipt2."Qty. Rework" + TempItemLedgEntry1.Quantity;
                        IF TempItemLedgEntry1."Accept Under Deviation" THEN
                            InspectReceipt2."Qty. Accepted Under Deviation" := InspectReceipt2."Qty. Accepted Under Deviation" +
                                                                               TempItemLedgEntry1.Quantity;
                        QualityItemLedgEntry.COPY(TempItemLedgEntry1);
                        QualityItemLedgEntry.MODIFY;
                    UNTIL TempItemLedgEntry1.NEXT = 0;
                InspectReceipt2.MODIFY;
                EXIT(TRUE);
            END ELSE BEGIN
                IF InspectReceipt2."Rework Level" = 0 THEN BEGIN
                    QualityItemLedgEntry.SETRANGE("Document No.", InspectReceipt2."Receipt No.");
                    QualityItemLedgEntry.SETRANGE("Lot No.", InspectReceipt2."Lot No.");
                    IF QualityItemLedgEntry.FINDSET THEN
                        REPEAT
                            IF QualityItemLedgEntry.Rework THEN BEGIN
                                TempItemLedgEntry1 := QualityItemLedgEntry;
                                TempItemLedgEntry1.INSERT;
                            END;
                        UNTIL QualityItemLedgEntry.NEXT = 0;
                    PAGE.RUNMODAL(PAGE::"Inspection Item Tracking Lines", TempItemLedgEntry1);
                END ELSE BEGIN
                    IF InspectReceipt2."Serial No." = '' THEN BEGIN
                        QualityItemLedgEntry.SETRANGE("Lot No.", InspectReceipt2."Lot No.");
                        IF QualityItemLedgEntry.FINDFIRST THEN BEGIN
                            TempItemLedgEntry1 := QualityItemLedgEntry;
                            TempItemLedgEntry1.INSERT;
                        END;
                    END ELSE BEGIN
                        QualityItemLedgEntry.SETRANGE("Serial No.", InspectReceipt2."Serial No.");
                        IF QualityItemLedgEntry.FINDFIRST THEN BEGIN
                            TempItemLedgEntry1 := QualityItemLedgEntry;
                            TempItemLedgEntry1.INSERT;
                        END;
                    END;
                    PAGE.RUNMODAL(PAGE::"Inspection Item Tracking Lines", TempItemLedgEntry1);
                END;
                InspectReceipt2."Qty. To Vendor (Rework)" := 0;
                IF TempItemLedgEntry1.FINDSET THEN
                    REPEAT
                        IF TempItemLedgEntry1."Sending to Rework" THEN
                            InspectReceipt2."Qty. To Vendor (Rework)" := InspectReceipt2."Qty. To Vendor (Rework)" + TempItemLedgEntry1.Quantity;
                        QualityItemLedgEntry.COPY(TempItemLedgEntry1);
                        QualityItemLedgEntry.MODIFY;
                    UNTIL TempItemLedgEntry1.NEXT = 0;
                InspectReceipt2.MODIFY;
            END;
            EXIT(TRUE);
        END ELSE
            EXIT(FALSE);
    end;

    procedure UpdateInspectAcptLevels(InspectRcpt: Record "Inspection Receipt Header");
    var
        InspectRcptLevel: Record "Inspect. Recpt. Accept Level";
    begin
        InspectRcptLevel.SETRANGE("Inspection Receipt No.", InspectRcpt."No.");
        InspectRcptLevel.MODIFYALL(Status, TRUE);
    end;

    procedure InsertQCItemTrackingLedger(Type: Integer; Subtype: Integer; ID: Code[20]; BatchName: Code[10]; ProdOrderLine: Integer; RefNo: Integer; var InspectReceipt2: Record "Inspection Receipt Header");
    var
        ItemEntryRelation: Record "Item Entry Relation";
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
        PostInspDataSheetHeader: Record "Posted Inspect DatasheetHeader";
    begin
        ItemEntryRelation.SETCURRENTKEY("Source ID", "Source Type");
        ItemEntryRelation.SETRANGE("Source Type", Type);
        ItemEntryRelation.SETRANGE("Source Subtype", Subtype);
        ItemEntryRelation.SETRANGE("Source ID", ID);
        ItemEntryRelation.SETRANGE("Source Batch Name", BatchName);
        ItemEntryRelation.SETRANGE("Source Prod. Order Line", ProdOrderLine);
        ItemEntryRelation.SETRANGE("Source Ref. No.", RefNo);
        ItemEntryRelation.SETRANGE("Lot No.", InspectReceipt2."Lot No.");
        IF InspectReceipt2."Rework Level" = 0 THEN BEGIN
            IF ItemEntryRelation.FINDSET THEN BEGIN
                REPEAT
                    IF QualityItemLedgEntry.GET(ItemEntryRelation."Item Entry No.") AND
                      (QualityItemLedgEntry."Inspection Status" = QualityItemLedgEntry."Inspection Status"::"Under Inspection") THEN BEGIN

                        /*
                         //300708 PIDSQC1.0>>
                           //ChildIDS := InspectReceipt2."Ids Reference No.";
                           ChildIDS := QualityItemLedgEntry."Child Ids";

                           QualityItemLedgEntry.SETRANGE("Entry No.",ItemEntryRelation."Item Entry No.");
                           QualityItemLedgEntry.SETRANGE("Child Ids",ChildIDS);
                           QualityItemLedgEntry.SETRANGE(Select,TRUE);
                           IF QualityItemLedgEntry.FINDFIRST THEN BEGIN

                             IF (QualityItemLedgEntry.Accept) OR (QualityItemLedgEntry."Accept Under Deviation") THEN BEGIN
                               QualityLedgerEntry.Quantity := QualityItemLedgEntry."Remaining Quantity";
                               QualityLedgerEntry."Remaining Quantity" := 0;
                               QualityLedgerEntry.Open := FALSE;
                               QualityLedgerEntry."Serial No." := QualityItemLedgEntry."Serial No.";
                               QualityLedgerEntry."Lot No." := QualityItemLedgEntry."Lot No.";
                               QualityLedgerEntry."Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                               IF QualityItemLedgEntry."Accept Under Deviation" THEN BEGIN
                                 QualityLedgerEntry."Accepted Under Dev. Reason" := InspectReceipt2."Qty. Accepted UD Reason";
                                 QualityLedgerEntry."Reason Description" := InspectReceipt2."Reason Description";
                               END;
                               QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
                               QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
                               QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type" :: Accepted;
                               QualityItemLedgEntry."Quality Ledger Entry No." := QualityLedgerEntry."Entry No.";
                               QualityLedgerEntry.INSERT;
                               QualityItemLedgEntry.DELETE;
                              END;
                              //310708>>
                              IF QualityItemLedgEntry.Reject THEN BEGIN
                                QualityLedgerEntry.Quantity := QualityItemLedgEntry."Remaining Quantity";
                                QualityLedgerEntry."Remaining Quantity" := 0;
                                QualityLedgerEntry.Open := FALSE;
                                QualityLedgerEntry."Serial No." := QualityItemLedgEntry."Serial No.";
                                QualityLedgerEntry."Lot No." := QualityItemLedgEntry."Lot No.";
                                QualityLedgerEntry."Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                                QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
                                QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
                                QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type" :: Reject;
                                QualityItemLedgEntry."Inspection Status" := QualityItemLedgEntry."Inspection Status" :: Rejected;
                                QualityItemLedgEntry."Quality Ledger Entry No." := QualityLedgerEntry."Entry No.";
                                QualityLedgerEntry."Accepted Under Dev. Reason" := '';
                                QualityLedgerEntry."Reason Description" := '';

                               //NSS 050108
                               QualityLedgerEntry."In bound Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                               IF QualityLedgerEntry."Entry Type" = QualityLedgerEntry."Entry Type" :: Reject THEN
                                 QualityLedgerEntry."New Location Code" := 'REJ';

                               QualityLedgerEntry.INSERT;
                               QualityItemLedgEntry.MODIFY;
                               UpdateItemLedgerEntryForSerial(QualityLedgerEntry,TRUE);
                              //NSS 050108

                             END;
                             IF QualityItemLedgEntry.Rework THEN BEGIN
                               QualityLedgerEntry.Quantity := QualityItemLedgEntry."Remaining Quantity";
                               QualityLedgerEntry."Remaining Quantity" := QualityItemLedgEntry."Remaining Quantity";
                               QualityLedgerEntry."Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                               QualityLedgerEntry.Open := TRUE;
                               QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
                               QualityLedgerEntry."Serial No." := QualityItemLedgEntry."Serial No.";
                               QualityLedgerEntry."Lot No." := QualityItemLedgEntry."Lot No.";
                               QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
                               QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type" :: Rework;
                               QualityLedgerEntry."Accepted Under Dev. Reason" := '';
                               QualityLedgerEntry."Reason Description" := '';
                               QualityLedgerEntry.INSERT;
                             END;
                             //310708<<


                             //END;
                           //END;
                      //PIDSQC1.0 300708<<
                           END ELSE BEGIN */
                        //Base300708>>
                        IF (QualityItemLedgEntry.Accept) OR (QualityItemLedgEntry."Accept Under Deviation") THEN BEGIN
                            QualityLedgerEntry.Quantity := QualityItemLedgEntry."Remaining Quantity";
                            QualityLedgerEntry."Remaining Quantity" := 0;
                            QualityLedgerEntry.Open := FALSE;
                            QualityLedgerEntry."Serial No." := QualityItemLedgEntry."Serial No.";
                            QualityLedgerEntry."Lot No." := QualityItemLedgEntry."Lot No.";
                            QualityLedgerEntry."Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                            IF QualityItemLedgEntry."Accept Under Deviation" THEN BEGIN
                                QualityLedgerEntry."Accepted Under Dev. Reason" := InspectReceipt2."Qty. Accepted UD Reason";
                                QualityLedgerEntry."Reason Description" := InspectReceipt2."Reason Description";
                            END;
                            QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
                            QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
                            QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type"::Accepted;
                            QualityItemLedgEntry."Quality Ledger Entry No." := QualityLedgerEntry."Entry No.";
                            QualityLedgerEntry.INSERT;

                            QualityItemLedgEntry.DELETE;
                        END;
                        /*//B2BQCCheck Start
                          IF ItemLedEntry.GET(QualityItemLedgEntry."Entry No.") THEN BEGIN
                            ItemLedEntry."QC Check" := FALSE;
                            ItemLedEntry.MODIFY;
                          END;
                        //B2BQCCheck End
                        */
                        IF QualityItemLedgEntry.Reject THEN BEGIN
                            QualityLedgerEntry.Quantity := QualityItemLedgEntry."Remaining Quantity";
                            QualityLedgerEntry."Remaining Quantity" := 0;
                            QualityLedgerEntry.Open := FALSE;
                            QualityLedgerEntry."Serial No." := QualityItemLedgEntry."Serial No.";
                            QualityLedgerEntry."Lot No." := QualityItemLedgEntry."Lot No.";
                            QualityLedgerEntry."Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                            QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
                            QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
                            QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type"::Reject;
                            QualityItemLedgEntry."Inspection Status" := QualityItemLedgEntry."Inspection Status"::Rejected;
                            QualityItemLedgEntry."Quality Ledger Entry No." := QualityLedgerEntry."Entry No.";
                            QualityLedgerEntry."Accepted Under Dev. Reason" := '';
                            QualityLedgerEntry."Reason Description" := '';

                            //NSS 050108
                            QualityLedgerEntry."In bound Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                            IF QualityLedgerEntry."Entry Type" = QualityLedgerEntry."Entry Type"::Reject THEN
                                QualityLedgerEntry."New Location Code" := 'REJ';

                            QualityLedgerEntry.INSERT;
                            QualityItemLedgEntry.MODIFY;
                            UpdateItemLedgerEntryForSerial(QualityLedgerEntry, TRUE);
                            //NSS 050108

                        END;

                        IF QualityItemLedgEntry.Rework THEN BEGIN
                            QualityLedgerEntry.Quantity := QualityItemLedgEntry."Remaining Quantity";
                            QualityLedgerEntry."Remaining Quantity" := QualityItemLedgEntry."Remaining Quantity";
                            QualityLedgerEntry."Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                            QualityLedgerEntry.Open := TRUE;
                            QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
                            QualityLedgerEntry."Serial No." := QualityItemLedgEntry."Serial No.";
                            QualityLedgerEntry."Lot No." := QualityItemLedgEntry."Lot No.";
                            QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
                            QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type"::Rework;
                            QualityLedgerEntry."Accepted Under Dev. Reason" := '';
                            QualityLedgerEntry."Reason Description" := '';
                            QualityLedgerEntry.INSERT;
                        END;
                    END;
                //END;
                //Base 300708<<

                UNTIL ItemEntryRelation.NEXT = 0;
            END;

        END ELSE BEGIN
            IF InspectReceipt2."Serial No." = '' THEN
                QualityItemLedgEntry.SETRANGE("Lot No.", InspectReceipt2."Lot No.")
            ELSE
                QualityItemLedgEntry.SETRANGE("Serial No.", InspectReceipt2."Serial No.");
            IF QualityItemLedgEntry.FINDFIRST THEN BEGIN
                IF (QualityItemLedgEntry.Accept) OR (QualityItemLedgEntry."Accept Under Deviation") THEN BEGIN
                    QualityLedgerEntry.Quantity := QualityItemLedgEntry."Remaining Quantity";
                    QualityLedgerEntry."Remaining Quantity" := 0;
                    QualityLedgerEntry.Open := FALSE;
                    QualityLedgerEntry."Serial No." := QualityItemLedgEntry."Serial No.";
                    QualityLedgerEntry."Lot No." := QualityItemLedgEntry."Lot No.";
                    QualityLedgerEntry."Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                    IF QualityItemLedgEntry."Accept Under Deviation" THEN BEGIN
                        QualityLedgerEntry."Accepted Under Dev. Reason" := InspectReceipt2."Qty. Accepted UD Reason";
                        QualityLedgerEntry."Reason Description" := InspectReceipt2."Reason Description";
                    END;
                    QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
                    QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
                    QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type"::Accepted;
                    QualityItemLedgEntry."Quality Ledger Entry No." := QualityLedgerEntry."Entry No.";
                    QualityLedgerEntry.INSERT;
                    /*          //B2BQCCheck Start
                                IF ItemLedEntry.GET(QualityItemLedgEntry."Entry No.") THEN BEGIN
                                  ItemLedEntry."QC Check" := FALSE;
                                  ItemLedEntry.MODIFY;
                                END;
                              //B2BQCCheck End
                     */
                    QualityItemLedgEntry.DELETE;
                END;
                IF QualityItemLedgEntry.Reject THEN BEGIN
                    QualityLedgerEntry.Quantity := QualityItemLedgEntry."Remaining Quantity";
                    QualityLedgerEntry."Remaining Quantity" := 0;
                    QualityLedgerEntry.Open := FALSE;
                    QualityLedgerEntry."Serial No." := QualityItemLedgEntry."Serial No.";
                    QualityLedgerEntry."Lot No." := QualityItemLedgEntry."Lot No.";
                    QualityLedgerEntry."Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                    QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
                    QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
                    QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type"::Reject;
                    QualityItemLedgEntry."Inspection Status" := QualityItemLedgEntry."Inspection Status"::Rejected;
                    QualityItemLedgEntry."Quality Ledger Entry No." := QualityLedgerEntry."Entry No.";
                    QualityLedgerEntry."Accepted Under Dev. Reason" := '';
                    QualityLedgerEntry."Reason Description" := '';
                    QualityLedgerEntry.INSERT;
                    QualityItemLedgEntry."Document No." := InspectReceipt2."No.";
                    QualityItemLedgEntry.MODIFY;
                END;
                IF QualityItemLedgEntry.Rework THEN BEGIN
                    QualityLedgerEntry.Quantity := QualityItemLedgEntry."Remaining Quantity";
                    QualityLedgerEntry."Remaining Quantity" := QualityItemLedgEntry."Remaining Quantity";
                    QualityLedgerEntry."Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                    QualityLedgerEntry.Open := TRUE;
                    QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
                    QualityLedgerEntry."Serial No." := QualityItemLedgEntry."Serial No.";
                    QualityLedgerEntry."Lot No." := QualityItemLedgEntry."Lot No.";
                    QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
                    QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type"::Rework;
                    QualityLedgerEntry."Accepted Under Dev. Reason" := '';
                    QualityLedgerEntry."Reason Description" := '';
                    QualityLedgerEntry.INSERT;
                    QualityItemLedgEntry."Document No." := InspectReceipt2."No.";
                    QualityItemLedgEntry.MODIFY;
                END;
            END;
            IF InspectReceipt2."Rework Reference No." <> '0' THEN
                UpdateParentQualityLedgEntry(InspectReceipt2."Rework Reference No.");
        END;

    end;

    local procedure AddTempRecordToSet(var TempItemLedgEntry: Record "Item Ledger Entry" temporary; SignFactor: Integer);
    var
        TempItemLedgEntry2: Record "Item Ledger Entry" temporary;
    begin
        IF SignFactor <> 1 THEN BEGIN
            TempItemLedgEntry.Quantity *= SignFactor;
            TempItemLedgEntry."Remaining Quantity" *= SignFactor;
            TempItemLedgEntry."Invoiced Quantity" *= SignFactor;
        END;
        TempItemLedgEntry2 := TempItemLedgEntry;
        TempItemLedgEntry.RESET;
        TempItemLedgEntry.SETRANGE("Serial No.", TempItemLedgEntry2."Serial No.");
        TempItemLedgEntry.SETRANGE("Lot No.", TempItemLedgEntry2."Lot No.");
        TempItemLedgEntry.SETRANGE("Warranty Date", TempItemLedgEntry2."Warranty Date");
        TempItemLedgEntry.SETRANGE("Expiration Date", TempItemLedgEntry2."Expiration Date");
        TempItemLedgEntry.SETRANGE("Lot No.", TempItemLedgEntry2."Lot No.");
        IF TempItemLedgEntry.FINDFIRST THEN BEGIN
            TempItemLedgEntry.Quantity += TempItemLedgEntry2.Quantity;
            TempItemLedgEntry."Remaining Quantity" += TempItemLedgEntry2."Remaining Quantity";
            TempItemLedgEntry."Invoiced Quantity" += TempItemLedgEntry2."Invoiced Quantity";
            TempItemLedgEntry.MODIFY;
        END ELSE BEGIN
            TempItemLedgEntry.INSERT;
        END;
        TempItemLedgEntry.RESET;
    end;

    local procedure TableSignFactor(TableNo: Integer): Integer;
    begin
        IF TableNo IN [
          DATABASE::"Sales Line",
          DATABASE::"Sales Shipment Line",
          DATABASE::"Sales Invoice Line",
          DATABASE::"Purch. Cr. Memo Line",
          DATABASE::"Prod. Order Component",
          DATABASE::"Transfer Shipment Line",
          DATABASE::"Return Shipment Line",
          DATABASE::"Planning Component"]
        //DATABASE::Table5932]
        THEN
            EXIT(-1)
        ELSE
            EXIT(1);
    end;

    procedure CreateReturnOrder(PurchHeader: Record "Purchase Header"; DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order");
    var
        PurchLine: Record "Purchase Line";
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
        QualityLedgEntry3: Record "Quality Ledger Entry";
        LineNo: Integer;
    begin
        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::"Return Order");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        IF PurchLine.FINDLAST THEN
            LineNo := PurchLine."Line No."
        ELSE
            LineNo := 0;
        QualityItemLedgEntry.SETRANGE(Open, TRUE);
        QualityItemLedgEntry.SETRANGE("Inspection Status", QualityItemLedgEntry."Inspection Status"::Rejected);
        IF QualityItemLedgEntry.FINDSET THEN BEGIN
            REPEAT
                LineNo := LineNo + 10000;
                QualityLedgEntry3.GET(QualityItemLedgEntry."Quality Ledger Entry No.");
                IF QualityLedgEntry3."Vendor No." = PurchHeader."Buy-from Vendor No." THEN BEGIN
                    PurchLine.INIT;
                    PurchLine."Document Type" := PurchLine."Document Type"::"Return Order";
                    PurchLine."Document No." := PurchHeader."No.";
                    PurchLine."Line No." := LineNo;
                    PurchLine.VALIDATE(Type, PurchLine.Type::Item);
                    PurchLine.VALIDATE("No.", QualityItemLedgEntry."Item No.");
                    PurchLine.VALIDATE("Location Code", QualityItemLedgEntry."Location Code");
                    PurchLine.VALIDATE(PurchLine.Quantity, QualityItemLedgEntry."Remaining Quantity");
                    PurchLine.VALIDATE("Appl.-to Item Entry", QualityItemLedgEntry."Entry No.");
                    PurchLine.INSERT(TRUE);
                END;
            UNTIL QualityItemLedgEntry.NEXT = 0;
        END;
    end;

    procedure CreateCreditMemo(PurchHeader: Record "Purchase Header"; DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order");
    var
        PurchLine: Record "Purchase Line";
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
        QualityLedgEntry3: Record "Quality Ledger Entry";
        LineNo: Integer;
        PL: Record "Purchase Line";
    begin
        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::"Credit Memo");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        IF PurchLine.FINDLAST THEN
            LineNo := PurchLine."Line No."
        ELSE
            LineNo := 0;
        text := '';
        Receiptfilter := '';
        Inspection_No := '';
        PIL.RESET;
        PIL.SETFILTER(PIL."Document No.", PurchHeader."Applies-to Doc. No.");
        IF PIL.FINDFIRST THEN
            REPEAT
                IF (PIL."Receipt No." <> text) AND (PIL."Receipt No." <> '') THEN BEGIN
                    c := PIL.COUNT;
                    text := PIL."Receipt No.";
                    IF Receiptfilter <> '' THEN
                        Receiptfilter := Receiptfilter + '|' + text
                    ELSE
                        Receiptfilter := text;
                END;
            UNTIL PIL.NEXT = 0;
        IRH.RESET;
        IRH.SETFILTER(IRH."Receipt No.", Receiptfilter);
        IF IRH.FINDFIRST THEN
            REPEAT
                IF Inspection_No <> '' THEN
                    Inspection_No := Inspection_No + '|' + IRH."No."
                ELSE
                    Inspection_No := IRH."No.";
            UNTIL IRH.NEXT = 0;
        QualityItemLedgEntry.RESET;
        QualityItemLedgEntry.SETCURRENTKEY("Document No.", "Posting Date", "Item No.");
        QualityItemLedgEntry.SETRANGE(Open, TRUE);
        QualityItemLedgEntry.SETRANGE("Inspection Status", QualityItemLedgEntry."Inspection Status"::Rejected);
        QualityItemLedgEntry.SETFILTER(QualityItemLedgEntry."Quality Ledger Entry No.", '>%1', 0);
        QualityItemLedgEntry.SETFILTER(QualityItemLedgEntry."Document No.", Inspection_No);
        IF QualityItemLedgEntry.FINDSET THEN BEGIN
            REPEAT
                /*
                PL.RESET;
                PL.SETRANGE(PL."Document Type",PL."Document Type" :: "Credit Memo");
                PL.SETRANGE(PL."Document No.",PurchHeader."No.");
                PL.SETRANGE(PL."No.",QualityItemLedgEntry."Item No.");
                IF PL.FINDFIRST THEN
                BEGIN
                  PL.VALIDATE(PL.Quantity,PL.Quantity+QualityItemLedgEntry."Remaining Quantity");
                  PL.MODIFY(TRUE);
                END
                ELSE BEGIN
                */
                LineNo := LineNo + 10000;
                QualityLedgEntry3.GET(QualityItemLedgEntry."Quality Ledger Entry No.");
                IF QualityLedgEntry3."Vendor No." = PurchHeader."Buy-from Vendor No." THEN BEGIN
                    PurchLine.INIT;
                    PurchLine."Document Type" := PurchLine."Document Type"::"Credit Memo";
                    PurchLine."Document No." := PurchHeader."No.";
                    PurchLine."Line No." := LineNo;
                    PurchLine.VALIDATE(Type, PurchLine.Type::Item);
                    PurchLine.VALIDATE("No.", QualityItemLedgEntry."Item No.");
                    PurchLine.VALIDATE("Location Code", QualityItemLedgEntry."Location Code");
                    PurchLine.VALIDATE(PurchLine.Quantity, QualityItemLedgEntry."Remaining Quantity");
                    if (QualityItemLedgEntry."Lot No." = '') and (QualityItemLedgEntry."Serial No." = '') then //EFFUPG1.8
                        PurchLine.VALIDATE("Appl.-to Item Entry", QualityItemLedgEntry."Entry No.");
                    PurchLine.INSERT(true);
                    if (QualityItemLedgEntry."Lot No." <> '') or (QualityItemLedgEntry."Serial No." <> '') then //EFFUPG1.8
                        UpdateResEntryFortReturnOrder(PurchLine, QualityItemLedgEntry);//EFFUPG1.8


                END;
            //END;
            UNTIL QualityItemLedgEntry.NEXT = 0;
        END;

    end;

    procedure CheckPostProdOrderOutput(ItemJnlLine: Record "Item Journal Line");
    var
        QualityLedgEntry2: Record "Quality Ledger Entry";
        ProdOrderLine2: Record "Prod. Order Line";
        QtyApplied: Decimal;
        PrevQtyApplied: Decimal;
    begin
        IF ProdOrderLine2.GET(ProdOrderLine2.Status::Released, ItemJnlLine."Order No.", ItemJnlLine."Order Line No.") THEN
            IF NOT ProdOrderLine2."WIP QC Enabled" THEN
                EXIT;
        QtyApplied := 0;
        PrevQtyApplied := 0;
        QualityLedgEntry2.SETCURRENTKEY("Order No.", "Order Line No.", "Source Type", "Entry Type", Open);
        QualityLedgEntry2.SETRANGE("Order No.", ItemJnlLine."Order No.");
        QualityLedgEntry2.SETRANGE("Order Line No.", ItemJnlLine."Order Line No.");
        QualityLedgEntry2.SETRANGE("Source Type", QualityLedgEntry2."Source Type"::WIP);
        //QualityLedgEntry2.SETRANGE("Entry Type",QualityLedgEntry2."Entry Type" :: Accepted);
        QualityLedgEntry2.SETFILTER("Entry Type", 'Accepted|Reject');
        QualityLedgEntry2.SETRANGE(Open, TRUE);
        QualityLedgEntry2.CALCSUMS(QualityLedgEntry2."Remaining Quantity");
        ProdOrderLine2.CALCFIELDS("Quantity Accepted", "Quantity Rejected");
        IF ItemJnlLine."Output Quantity" > ((ProdOrderLine2."Quantity Accepted" + ProdOrderLine2."Quantity Rejected")
                                           - ProdOrderLine2."Finished Quantity") THEN
            MESSAGE(FORMAT(ItemJnlLine."Output Quantity"));
        MESSAGE(FORMAT(ProdOrderLine2."Quantity Accepted"));
        MESSAGE(FORMAT(ProdOrderLine2."Quantity Rejected"));
        MESSAGE(FORMAT(ProdOrderLine2."Finished Quantity"));

        ERROR(Text001);
        IF QualityLedgEntry2.FINDSET THEN
            REPEAT
                QtyApplied := QtyApplied + QualityLedgEntry2."Remaining Quantity";
                IF QtyApplied <= ItemJnlLine."Output Quantity" THEN BEGIN
                    QualityLedgEntry2."Remaining Quantity" := 0;
                    QualityLedgEntry2.Open := FALSE;
                    QualityLedgEntry2.MODIFY;
                END ELSE BEGIN
                    QualityLedgEntry2."Remaining Quantity" := QualityLedgEntry2."Remaining Quantity" -
                      (ItemJnlLine."Output Quantity" - PrevQtyApplied);
                    QualityLedgEntry2.MODIFY;
                    QtyApplied := ItemJnlLine."Output Quantity";
                END;
                IF QtyApplied = ItemJnlLine."Output Quantity" THEN
                    EXIT;
                PrevQtyApplied := QtyApplied;
            UNTIL QualityLedgEntry2.NEXT = 0;
    end;

    procedure InsertItemVendorRating(InspectReceipt: Record "Inspection Receipt Header");
    var
        ItemVendorRating: Record "Vendor Rating";
    begin
        IF InspectReceipt."Vendor No." = '' THEN
            EXIT;
        IF NOT ItemVendorRating.GET(InspectReceipt."Item No.", InspectReceipt."Vendor No.") THEN BEGIN

            ItemVendorRating.INIT;
            ItemVendorRating."Item No." := InspectReceipt."Item No.";
            ItemVendorRating."Vendor No." := InspectReceipt."Vendor No.";
            ItemVendorRating.INSERT;
        END;
    end;

    procedure FillReworkItemJnlLineAndPost(var InspectRcpt: Record "Inspection Receipt Header");
    var
        ItemJnlLine: Record "Item Journal Line";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        Vendor: Record Vendor;
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemApplnEntry: Record "Item Application Entry";
        QualityLedgEntry2: Record "Quality Ledger Entry";
        DeliveryChalan: Record "Delivery/Receipt Entry";
        DelryChalanNo: Integer;
        "--RQC1.0---": Integer;
        InsProdOrderRoutingLine: Record "Ins Prod. Order Routing Line";
        Text000: Label 'Enter the Routing';
    begin
        IF NOT CONFIRM(Text002, TRUE) THEN
            EXIT;
        //>>B2B 290508
        /*//RQC1.0
        InsProdOrderRoutingLine.RESET;
        InsProdOrderRoutingLine.SETRANGE("Inspection Receipt No.",InspectRcpt."No.");
        IF NOT InsProdOrderRoutingLine.FINDFIRST THEN
          ERROR(Text000);
        //RQC1.0
        */
        //<<B2B 290508
        IF DeliveryChalan.FINDLAST THEN
            DelryChalanNo := DeliveryChalan."Entry No."
        ELSE
            DelryChalanNo := 0;
        IF InspectRcpt."Source Type" = InspectRcpt."Source Type"::"In Bound" THEN BEGIN
            Vendor.GET(InspectRcpt."Vendor No.");
            Vendor.TESTFIELD(Vendor."Rework Location");
        END;
        IF (InspectRcpt."Source Type" = InspectRcpt."Source Type"::"In Bound") AND (NOT InspectRcpt."Quality Before Receipt") AND
          (InspectRcpt."Qty. To Vendor (Rework)" <> 0) THEN BEGIN
            IF InspectRcpt."Rework Level" = 0 THEN BEGIN
                ItemJnlLine.SETRANGE(ItemJnlLine."Journal Template Name", 'RECLASS');
                ItemJnlLine.SETRANGE(ItemJnlLine."Journal Batch Name", 'DEFAULT');
                IF ItemJnlLine.FINDFIRST THEN
                    ItemJnlLine.DELETEALL;
                ItemJnlLine.RESET;
                ItemJnlLine.INIT;
                ItemJnlLine."Journal Template Name" := 'RECLASS';
                ItemJnlLine."Journal Batch Name" := 'DEFAULT';
                ItemJnlLine."Posting Date" := WORKDATE;
                ItemJnlLine."Document Date" := WORKDATE;
                ItemJnlLine."Document No." := InspectRcpt."No.";
                ItemJnlLine."Line No." := ItemReclassLineNo;
                ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::Transfer;
                ItemJnlLine.VALIDATE("Item No.", InspectRcpt."Item No.");
                ItemJnlLine.VALIDATE(ItemJnlLine."Unit of Measure Code", InspectRcpt."Unit Of Measure Code");
                ItemJnlLine.VALIDATE(Quantity, InspectRcpt."Qty. To Vendor (Rework)");
                IF InspectRcpt."Location Code" <> '' THEN
                    ItemJnlLine.VALIDATE("Location Code", InspectRcpt."Location Code");
                ItemJnlLine.VALIDATE("New Location Code", Vendor."Rework Location");

                ItemJnlLine.VALIDATE("Applies-to Entry", InspectRcpt."Item Ledger Entry No.");
                ItemJnlLine."Quality Ledger Entry No." := InspectRcpt."Item Ledger Entry No.";
                //B2B QC Check Start
                ItemJnlLine."QC Check" := TRUE;
                //B2B QC Check End
                ItemJnlLine.INSERT;
                CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", ItemJnlLine);
                QualityItemLedgEntry.GET(InspectRcpt."Item Ledger Entry No.");
                QualityItemLedgEntry."Remaining Quantity" := QualityItemLedgEntry."Remaining Quantity" - InspectRcpt."Qty. To Vendor (Rework)";
                IF QualityItemLedgEntry."Remaining Quantity" = 0 THEN
                    QualityItemLedgEntry.DELETE
                ELSE
                    QualityItemLedgEntry.MODIFY;
                ItemApplnEntry.SETRANGE("Transferred-from Entry No.", InspectRcpt."Item Ledger Entry No.");
                IF ItemApplnEntry.FINDLAST THEN;
                ItemLedgEntry.GET(ItemApplnEntry."Inbound Item Entry No.");
                QualityItemLedgEntry.TRANSFERFIELDS(ItemLedgEntry);
                QualityItemLedgEntry."Sent for Rework" := TRUE;
                QualityItemLedgEntry.Accept := FALSE;
                QualityItemLedgEntry.INSERT;
            END ELSE BEGIN
                RemainQty := InspectRcpt."Qty. To Vendor (Rework)";
                QualityItemLedgEntry.SETRANGE("Document No.", InspectRcpt."Rework Reference No.");
                QualityItemLedgEntry.SETRANGE("Inspection Status", QualityItemLedgEntry."Inspection Status"::"Under Inspection");
                QualityItemLedgEntry.SETRANGE("Sent for Rework", FALSE);
                IF QualityItemLedgEntry.FINDSET THEN
                    REPEAT
                        IF RemainQty <= QualityItemLedgEntry."Remaining Quantity" THEN
                            QtyToApply := RemainQty
                        ELSE
                            QtyToApply := QualityItemLedgEntry."Remaining Quantity";
                        RemainQty := RemainQty - QtyToApply;
                        IF QtyToApply <> 0 THEN BEGIN
                            ItemJnlLine.SETRANGE(ItemJnlLine."Journal Template Name", 'RECLASS');
                            ItemJnlLine.SETRANGE(ItemJnlLine."Journal Batch Name", 'DEFAULT');
                            IF ItemJnlLine.FINDFIRST THEN
                                ItemJnlLine.DELETEALL;
                            ItemJnlLine.RESET;
                            ItemJnlLine.INIT;
                            ItemJnlLine."Journal Template Name" := 'RECLASS';
                            ItemJnlLine."Journal Batch Name" := 'DEFAULT';
                            ItemJnlLine."Posting Date" := WORKDATE;
                            ItemJnlLine."Document Date" := WORKDATE;
                            ItemJnlLine."Document No." := InspectRcpt."No.";
                            ItemJnlLine."Line No." := ItemReclassLineNo;
                            ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::Transfer;
                            ItemJnlLine.VALIDATE("Item No.", InspectRcpt."Item No.");
                            ItemJnlLine.VALIDATE(Quantity, QtyToApply);
                            ItemJnlLine.VALIDATE("Location Code", InspectRcpt."Location Code");
                            ItemJnlLine.VALIDATE("New Location Code", Vendor."Rework Location");
                            ItemJnlLine.VALIDATE("Applies-to Entry", QualityItemLedgEntry."Entry No.");
                            ItemJnlLine."Quality Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                            //B2B QC Check Start
                            ItemJnlLine."QC Check" := TRUE;
                            //B2B QC Check End

                            ItemJnlLine.INSERT;
                            CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", ItemJnlLine);
                            QualityItemLedgEntry."Remaining Quantity" := QualityItemLedgEntry."Remaining Quantity" - QtyToApply;
                            IF QualityItemLedgEntry."Remaining Quantity" = 0 THEN
                                QualityItemLedgEntry.DELETE
                            ELSE
                                QualityItemLedgEntry.MODIFY;
                            ItemApplnEntry.SETRANGE("Transferred-from Entry No.", QualityItemLedgEntry."Entry No.");
                            IF ItemApplnEntry.FINDLAST THEN;
                            ItemLedgEntry.GET(ItemApplnEntry."Inbound Item Entry No.");
                            QualityItemLedgEntry.TRANSFERFIELDS(ItemLedgEntry);
                            QualityItemLedgEntry."Sent for Rework" := TRUE;

                            QualityItemLedgEntry.Accept := FALSE;
                            QualityItemLedgEntry.INSERT;
                        END;
                    UNTIL QualityItemLedgEntry.NEXT = 0;
            END;
        END;
        IF InspectRcpt."Qty. To Vendor (Rework)" <> 0 THEN BEGIN
            DelryChalanNo := DeliveryChalan."Entry No." + 1;
            QualityLedgEntry2.SETRANGE("Document No.", InspectRcpt."No.");
            QualityLedgEntry2.SETFILTER("Entry Type", '=%1', QualityLedgEntry2."Entry Type"::Rework);
            QualityLedgEntry2.FINDFIRST;
            DeliveryChalan.INIT;
            DeliveryChalan.TRANSFERFIELDS(QualityLedgEntry2);
            DeliveryChalan."Entry No." := DelryChalanNo;
            DeliveryChalan.Quantity := InspectRcpt."Qty. To Vendor (Rework)";
            DeliveryChalan."Remaining Quantity" := InspectRcpt."Qty. To Vendor (Rework)";
            DeliveryChalan."In bound Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";

            DeliveryChalan.INSERT;
        END;
        IF InspectRcpt."Qty. To Vendor (Rejected)" <> 0 THEN BEGIN
            DelryChalanNo := DeliveryChalan."Entry No." + 1;
            QualityLedgEntry2.SETRANGE("Document No.", InspectRcpt."No.");
            QualityLedgEntry2.SETFILTER("Entry Type", '=%1', QualityLedgEntry2."Entry Type"::Reject);
            QualityLedgEntry2.FINDFIRST;
            DeliveryChalan.INIT;
            DeliveryChalan.TRANSFERFIELDS(QualityLedgEntry2);
            DeliveryChalan."Entry No." := DelryChalanNo;
            DeliveryChalan.Quantity := InspectRcpt."Qty. To Vendor (Rejected)";
            DeliveryChalan."Remaining Quantity" := 0;
            DeliveryChalan.Open := FALSE;
            DeliveryChalan.INSERT;
        END;
        InspectRcpt."Qty. Sent To Vendor (Rejected)" := InspectRcpt."Qty. Sent To Vendor (Rejected)" + InspectRcpt."Qty. To Vendor (Rejected)";
        InspectRcpt."Qty. To Vendor (Rejected)" := 0;
        InspectRcpt."Qty. Sent To Vendor (Rework)" := InspectRcpt."Qty. Sent To Vendor (Rework)" + InspectRcpt."Qty. To Vendor (Rework)";
        InspectRcpt."Qty. To Vendor (Rework)" := 0;

    end;


    procedure ReceiveReworkAndPost(var InspectRcpt: Record "Inspection Receipt Header");
    var
        ItemJnlLine: Record "Item Journal Line";
        Vendor: Record Vendor;
        ItemLedgEntry: Record "Item Ledger Entry";
        QualityLedgEntry2: Record "Quality Ledger Entry";
        DeliveryChalan2: Record "Delivery/Receipt Entry";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        DelryChalanNo: Integer;
        DeliveryChalan3: Record "Delivery/Receipt Entry";
    begin
        IF NOT CONFIRM(Text003, TRUE) THEN
            EXIT;

        IF DeliveryChalan.FINDLAST THEN
            DelryChalanNo := DeliveryChalan."Entry No." + 1
        ELSE
            DelryChalanNo := 1;
        InspectRcpt.TESTFIELD("Qty. To Receive(Rework)");
        RemainQty := InspectRcpt."Qty. To Receive(Rework)";
        DeliveryChalan.RESET;
        IF DeliveryChalan.GET(InspectRcpt."Rework Reference Document No.") THEN BEGIN
            DeliveryChalan2.INIT;
            DeliveryChalan2.TRANSFERFIELDS(DeliveryChalan);
            DeliveryChalan2."Entry No." := DelryChalanNo;
            DeliveryChalan2."Applies-to Entry" := InspectRcpt."Rework Reference Document No.";
            DeliveryChalan2."Posting Date" := WORKDATE;
            DeliveryChalan2."Document Type" := DeliveryChalan2."Document Type"::"In Bound";
            DeliveryChalan2.Quantity := RemainQty;
            DeliveryChalan2."Remaining Quantity" := 0;
            DeliveryChalan2.Open := FALSE;
            DeliveryChalan2.Positive := TRUE;
            DeliveryChalan2.INSERT;
            IF RemainQty > 0 THEN BEGIN
                IF RemainQty < DeliveryChalan."Remaining Quantity" THEN BEGIN
                    DeliveryChalan."Remaining Quantity" := DeliveryChalan."Remaining Quantity" - RemainQty;
                    RemainQty := 0
                END ELSE BEGIN
                    RemainQty := RemainQty - DeliveryChalan."Remaining Quantity";
                    DeliveryChalan."Remaining Quantity" := 0;
                    DeliveryChalan.Open := FALSE;
                END;
                DeliveryChalan.MODIFY;
            END;
            IF (InspectRcpt."Source Type" = InspectRcpt."Source Type"::"In Bound") AND (NOT InspectRcpt."Quality Before Receipt") THEN
                ReceiptRework(InspectRcpt);
            IF DeliveryChalan.FINDLAST THEN
                InspectRcpt."DC Inbound Ledger Entry." := DeliveryChalan."In bound Item Ledger Entry No.";
            InspectRcpt.MODIFY;
            InspectDataSheets.CreateReworkInspectDataSheets(InspectRcpt);
            InspectRcpt."Qty. Received(Rework)" := InspectRcpt."Qty. Received(Rework)" + InspectRcpt."Qty. To Receive(Rework)";
            InspectRcpt."Qty. To Receive(Rework)" := 0;
        END;
    end;


    procedure ReceiptRework(InspectRcpt: Record "Inspection Receipt Header");
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        QualityItemLedgEntry2: Record "Quality Item Ledger Entry";
        DeliveryChalan3: Record "Delivery/Receipt Entry";
        DeliveryChalan: Record "Delivery/Receipt Entry";
    begin
        RemainQty := InspectRcpt."Qty. To Receive(Rework)";
        IF DeliveryChalan3.GET(InspectRcpt."Rework Reference Document No.") THEN
            IF QualityItemLedgEntry.GET(DeliveryChalan3."In bound Item Ledger Entry No.") THEN BEGIN
                IF RemainQty <= QualityItemLedgEntry."Remaining Quantity" THEN
                    QtyToApply := RemainQty
                ELSE
                    QtyToApply := QualityItemLedgEntry."Remaining Quantity";
                RemainQty := RemainQty - QtyToApply;
                IF QtyToApply <> 0 THEN BEGIN
                    ItemJnlLine.SETRANGE(ItemJnlLine."Journal Template Name", 'RECLASS');
                    ItemJnlLine.SETRANGE(ItemJnlLine."Journal Batch Name", 'DEFAULT');
                    IF ItemJnlLine.FINDFIRST THEN
                        ItemJnlLine.DELETEALL;
                    ItemJnlLine.RESET;
                    ItemJnlLine.INIT;
                    ItemJnlLine."Journal Template Name" := 'RECLASS';
                    ItemJnlLine."Journal Batch Name" := 'DEFAULT';
                    ItemJnlLine."Posting Date" := WORKDATE;
                    ItemJnlLine."Document Date" := WORKDATE;
                    ItemJnlLine."Document No." := InspectRcpt."No.";
                    ItemJnlLine."Line No." := 10000;
                    ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::Transfer;
                    ItemJnlLine.VALIDATE("Item No.", InspectRcpt."Item No.");
                    ItemJnlLine.VALIDATE(Quantity, QtyToApply);
                    IF DeliveryChalan3."New Location Code" <> '' THEN
                        ItemJnlLine.VALIDATE("Location Code", DeliveryChalan3."New Location Code");
                    IF DeliveryChalan3."Location Code" <> '' THEN
                        ItemJnlLine.VALIDATE("New Location Code", DeliveryChalan3."Location Code");
                    ItemJnlLine.VALIDATE("Applies-to Entry", QualityItemLedgEntry."Entry No.");
                    ItemJnlLine."Quality Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                    ItemJnlLine."External Document No." := InspectRcpt."External Document No.";
                    //B2B QC Check Start
                    ItemJnlLine."QC Check" := TRUE;
                    //B2B QC Check End

                    ItemJnlLine.INSERT;
                    ItemJnlPostLine.RUN(ItemJnlLine);
                    ItemApplnEntry.SETRANGE("Transferred-from Entry No.", QualityItemLedgEntry."Entry No.");
                    IF ItemApplnEntry.FINDLAST THEN;
                    ItemLedgEntry.GET(ItemApplnEntry."Inbound Item Entry No.");
                    QualityItemLedgEntry2.TRANSFERFIELDS(ItemLedgEntry);
                    QualityItemLedgEntry2."Sent for Rework" := FALSE;
                    QualityItemLedgEntry2.INSERT;
                    IF DeliveryChalan.FINDLAST THEN BEGIN
                        DeliveryChalan."In bound Item Ledger Entry No." := ItemApplnEntry."Inbound Item Entry No.";
                        DeliveryChalan.MODIFY;

                    END;
                    QualityItemLedgEntry."Remaining Quantity" := QualityItemLedgEntry."Remaining Quantity" - QtyToApply;
                    IF QualityItemLedgEntry."Remaining Quantity" = 0 THEN
                        QualityItemLedgEntry.DELETE
                    ELSE
                        QualityItemLedgEntry.MODIFY;
                END;
            END;
    end;


    procedure ItemReclassLineNo(): Integer;
    var
        ItemJnlLine2: Record "Item Journal Line";
    begin
        ItemJnlLine2.SETRANGE(ItemJnlLine2."Journal Template Name", 'RECLASS');
        ItemJnlLine2.SETRANGE(ItemJnlLine2."Journal Batch Name", 'DEFAULT');
        IF ItemJnlLine2.FINDLAST THEN
            EXIT(ItemJnlLine2."Line No." + 10000)
        ELSE
            EXIT(10000);
    end;


    procedure UpdateSentBackToVendor(var InspectRcptHeader: Record "Inspection Receipt Header");
    var
        QualityItemLedgerEntry: Record "Quality Item Ledger Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
        Vend: Record Vendor;
        QualityLedgEntry2: Record "Quality Ledger Entry";
        DeliveryChalan: Record "Delivery/Receipt Entry";
        DelryChalanNo: Integer;
        idx: Integer;
    begin
        IF NOT CONFIRM(Text002, TRUE) THEN
            EXIT;
        IF DeliveryChalan.FINDLAST THEN
            DelryChalanNo := DeliveryChalan."Entry No."
        ELSE
            DelryChalanNo := 0;
        IF InspectRcptHeader."Rework Level" = 0 THEN
            QualityItemLedgerEntry.SETRANGE("Document No.", InspectRcptHeader."Receipt No.")
        ELSE
            QualityItemLedgerEntry.SETRANGE("Document No.", InspectRcptHeader."No.");
        QualityItemLedgerEntry.SETRANGE("Sending to Rework", TRUE);
        IF QualityItemLedgerEntry.FINDSET THEN
            REPEAT
                IF Vend.GET(InspectRcptHeader."Vendor No.") THEN BEGIN
                    Vend.TESTFIELD(Vend."Rework Location");
                    QualityItemLedgerEntry."Location Code" := Vend."Rework Location";
                END;
                QualityItemLedgerEntry."Sending to Rework" := FALSE;
                QualityItemLedgerEntry.Rework := FALSE;
                QualityItemLedgerEntry."Sent for Rework" := TRUE;
                QualityItemLedgerEntry.MODIFY;
                IF InspectRcptHeader."Qty. To Vendor (Rework)" <> 0 THEN BEGIN
                    QualityLedgEntry2.SETRANGE("Item Ledger Entry No.", QualityItemLedgerEntry."Entry No.");
                    IF QualityLedgEntry2.FINDFIRST THEN BEGIN
                        DelryChalanNo := DeliveryChalan."Entry No." + 1;
                        DeliveryChalan.INIT;
                        DeliveryChalan.TRANSFERFIELDS(QualityLedgEntry2);
                        DeliveryChalan."Document No." := InspectRcptHeader."No.";
                        DeliveryChalan.Open := TRUE;
                        DeliveryChalan."Entry No." := DelryChalanNo;
                        DelryChalanNo := DelryChalanNo + 1;
                        DeliveryChalan.Quantity := QualityLedgEntry2.Quantity;
                        DeliveryChalan."Remaining Quantity" := QualityLedgEntry2.Quantity;
                        DeliveryChalan."In bound Item Ledger Entry No." := QualityItemLedgerEntry."Entry No.";
                        DeliveryChalan.INSERT;
                    END;
                END;
                IF InspectRcptHeader."Qty. To Vendor (Rejected)" <> 0 THEN BEGIN
                    DelryChalanNo := DeliveryChalan."Entry No." + 1;
                    QualityLedgEntry2.SETRANGE("Document No.", InspectRcptHeader."No.");
                    QualityLedgEntry2.SETFILTER("Entry Type", '=%1', QualityLedgEntry2."Entry Type"::Reject);
                    QualityLedgEntry2.FINDFIRST;
                    DeliveryChalan.INIT;
                    DeliveryChalan.TRANSFERFIELDS(QualityLedgEntry2);
                    DeliveryChalan."Entry No." := DelryChalanNo;
                    DeliveryChalan.Quantity := InspectRcptHeader."Qty. To Vendor (Rejected)";
                    DeliveryChalan."Remaining Quantity" := 0;
                    DeliveryChalan.INSERT;
                END;

            UNTIL QualityItemLedgerEntry.NEXT = 0;
        InspectRcptHeader."Qty. Sent To Vendor (Rework)" := InspectRcptHeader."Qty. Sent To Vendor (Rework)" + InspectRcptHeader."Qty. To Vendor (Rework)";
        InspectRcptHeader."Qty. To Vendor (Rework)" := 0;
        MESSAGE(Text004);
    end;


    procedure UpdateReceiveRework(var InspectRcptHeader: Record "Inspection Receipt Header");
    var
        QualityItemLedgerEntry: Record "Quality Item Ledger Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
        Vend: Record Vendor;
        QualityLedgEntry2: Record "Quality Ledger Entry";
        DeliveryChalan: Record "Delivery/Receipt Entry";
        DeliveryChalan2: Record "Delivery/Receipt Entry";
        DelryChalanNo: Integer;
    begin
        IF NOT CONFIRM(Text003, TRUE) THEN
            EXIT;
        InspectRcptHeader.TESTFIELD("Qty. To Receive(Rework)");
        RemainQty := InspectRcptHeader."Qty. To Receive(Rework)";
        IF DeliveryChalan.FINDLAST THEN
            DelryChalanNo := DeliveryChalan."Entry No." + 1
        ELSE
            DelryChalanNo := 1;
        IF DeliveryChalan.GET(InspectRcptHeader."Rework Reference Document No.") THEN BEGIN
            IF QualityItemLedgerEntry.GET(DeliveryChalan."Item Ledger Entry No.") THEN BEGIN
                IF Vend.GET(InspectRcptHeader."Vendor No.") THEN
                    QualityItemLedgerEntry."Location Code" := InspectRcptHeader."Location Code";
                QualityItemLedgerEntry."Sent for Rework" := FALSE;
                QualityItemLedgerEntry.Accept := TRUE;
                QualityItemLedgerEntry.MODIFY;
            END;
            DeliveryChalan2.INIT;
            DeliveryChalan2.TRANSFERFIELDS(DeliveryChalan);
            DeliveryChalan2."Entry No." := DelryChalanNo;
            DeliveryChalan2."Applies-to Entry" := InspectRcptHeader."Rework Reference Document No.";
            DeliveryChalan2."Posting Date" := WORKDATE;
            DeliveryChalan2."Document Type" := DeliveryChalan2."Document Type"::"In Bound";
            DeliveryChalan2.Quantity := RemainQty;
            DeliveryChalan2."Remaining Quantity" := 0;
            DeliveryChalan2.Open := FALSE;
            DeliveryChalan2.Positive := TRUE;
            DeliveryChalan2.INSERT;
            IF RemainQty > 0 THEN BEGIN
                IF RemainQty < DeliveryChalan."Remaining Quantity" THEN BEGIN
                    DeliveryChalan."Remaining Quantity" := DeliveryChalan."Remaining Quantity" - RemainQty;
                    RemainQty := 0
                END ELSE BEGIN
                    RemainQty := RemainQty - DeliveryChalan."Remaining Quantity";
                    DeliveryChalan."Remaining Quantity" := 0;
                    DeliveryChalan.Open := FALSE;
                END;
                DeliveryChalan.MODIFY;
            END;
            IF (InspectRcptHeader."Source Type" = InspectRcptHeader."Source Type"::"In Bound") AND (NOT InspectRcptHeader."Quality Before Receipt") THEN
                InspectDataSheets.CreateReworkInspectDataSheets(InspectRcptHeader);
            InspectRcptHeader."Qty. Received(Rework)" := InspectRcptHeader."Qty. Received(Rework)" + InspectRcptHeader."Qty. To Receive(Rework)";
            InspectRcptHeader."Qty. To Receive(Rework)" := 0;
        END;
        MESSAGE(Text005);
    end;


    procedure "---B2B ESPL---"();
    begin
    end;


    procedure TransferOrderIRPost(var Rec: Record "Inspection Receipt Header");
    begin
        InspectReceiptCheckLine.TransferOrderRunCheck(Rec);
        QualityLedgerEntry.RESET;
        QualityLedgerEntry.LOCKTABLE;
        IF QualityLedgerEntry.FINDLAST THEN BEGIN
            QualityLedgerEntryNo := QualityLedgerEntry."Entry No.";
            TempQLEDoc := QualityLedgerEntry."Document No.";
        END ELSE
            QualityLedgerEntryNo := 0;

        InitQualityLedgerTransfer(Rec);
        InsertQLETransfer(Rec);

        UpdateInspectAcptLevels(Rec);
        Rec."Posted By" := USERID;
        Rec."Posted Date" := TODAY;
        Rec."Posted Time" := TIME;
        Rec.Status := TRUE;
        Rec.MODIFY;
    end;


    procedure InitQualityLedgerTransfer(var InspectReceipt: Record "Inspection Receipt Header");
    begin
        QualityLedgerEntry.INIT;
        QualityLedgerEntry."Item No." := InspectReceipt."Item No.";
        QualityLedgerEntry."Sub Assembly Code" := InspectReceipt."Sub Assembly Code";
        QualityLedgerEntry."Posting Date" := InspectReceipt."Posting Date";
        QualityLedgerEntry."Source No." := InspectReceipt."Receipt No.";
        QualityLedgerEntry."Source Type" := InspectReceipt."Source Type";
        QualityLedgerEntry."Unit Of Measure Code" := InspectReceipt."Unit Of Measure Code";
        QualityLedgerEntry."Order No." := InspectReceipt."Trans. Order No.";
        QualityLedgerEntry."Order Line No." := InspectReceipt."Trans. Order Line";
        QualityLedgerEntry."Document No." := InspectReceipt."No.";
        QualityLedgerEntry."Location Code" := InspectReceipt."Location Code";
        QualityLedgerEntry."New Location Code" := InspectReceipt."New Location Code";
        QualityLedgerEntry."Lot No." := InspectReceipt."Lot No.";
        QualityLedgerEntry."Item Ledger Entry No." := InspectReceipt."Item Ledger Entry No.";
        QualityLedgerEntry."Vendor No." := InspectReceipt."Vendor No.";
        QualityLedgerEntry."Rework Level" := InspectReceipt."Rework Level";
        QualityLedgerEntry."Rework Reference No." := InspectReceipt."Rework Reference No.";
        QualityLedgerEntry."Unit Of Measure Code" := InspectReceipt."Unit Of Measure Code";
        //QualityLedgerEntry."Qty. per Unit of Measure" := InspectReceipt."Qty. per Unit of Measure";
    end;


    procedure InsertQLETransfer(InspectReceipt: Record "Inspection Receipt Header");
    begin
        IF InspectReceipt."Qty. Accepted" <> 0 THEN BEGIN
            QualityLedgerEntry."In bound Item Ledger Entry No." := InspectReceipt."Item Ledger Entry No.";
            QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
            QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
            QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type"::Accepted;
            QualityLedgerEntry.Quantity := InspectReceipt."Qty. Accepted";
            QualityLedgerEntry."Remaining Quantity" := InspectReceipt."Qty. Accepted";
            QualityLedgerEntry.INSERT;
        END;
        IF InspectReceipt."Qty. Rejected" <> 0 THEN BEGIN
            QualityLedgerEntry."In bound Item Ledger Entry No." := InspectReceipt."Item Ledger Entry No.";
            QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
            QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
            QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type"::Reject;
            QualityLedgerEntry.Quantity := InspectReceipt."Qty. Rejected";
            QualityLedgerEntry."Remaining Quantity" := InspectReceipt."Qty. Rejected";
            QualityLedgerEntry.INSERT;
        END;
        IF InspectReceipt."Qty. Accepted Under Deviation" <> 0 THEN BEGIN
            QualityLedgerEntry."In bound Item Ledger Entry No." := InspectReceipt."Item Ledger Entry No.";
            QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
            QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
            QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type"::Accepted;
            QualityLedgerEntry.Quantity := InspectReceipt."Qty. Accepted Under Deviation";
            QualityLedgerEntry."Remaining Quantity" := InspectReceipt."Qty. Accepted Under Deviation";
            QualityLedgerEntry."Accepted Under Dev. Reason" := InspectReceipt."Qty. Accepted UD Reason";
            QualityLedgerEntry."Reason Description" := InspectReceipt."Reason Description";
            QualityLedgerEntry.INSERT;
        END;
    end;


    procedure "--QCP1.0--"();
    begin
    end;


    procedure InseertLOTItemTrackingQLE(InspectReceipt: Record "Inspection Receipt Header");
    begin
        IF InspectReceipt."Qty. Accepted" <> 0 THEN BEGIN
            IF InspectReceipt."Rework Level" = 0 THEN
                QualityLedgerEntry."In bound Item Ledger Entry No." := InspectReceipt."Item Ledger Entry No."
            ELSE
                QualityLedgerEntry."In bound Item Ledger Entry No." := InspectReceipt."DC Inbound Ledger Entry.";
            QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
            QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
            QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type"::Accepted;
            QualityLedgerEntry.Quantity := InspectReceipt."Qty. Accepted";
            QualityLedgerEntry."Operation No." := InspectReceipt."Operation No.";
            QualityItemLedgEntry.SETRANGE("Entry No.", InspectReceipt."Item Ledger Entry No.");
            IF QualityItemLedgEntry.FINDFIRST THEN BEGIN
                QualityLedgerEntry."Serial No." := QualityItemLedgEntry."Serial No.";
                QualityLedgerEntry."Lot No." := QualityItemLedgEntry."Lot No.";
                QualityLedgerEntry."Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                IF (InspectReceipt."Qty. Rejected" = 0) AND (InspectReceipt."Qty. Accepted Under Deviation" = 0) THEN
                    QualityItemLedgEntry.DELETE;
            END;
            QualityLedgerEntry.INSERT;
        END;
        IF InspectReceipt."Qty. Accepted Under Deviation" <> 0 THEN BEGIN
            IF InspectReceipt."Rework Level" = 0 THEN
                QualityLedgerEntry."In bound Item Ledger Entry No." := InspectReceipt."Item Ledger Entry No."
            ELSE
                QualityLedgerEntry."In bound Item Ledger Entry No." := InspectReceipt."DC Inbound Ledger Entry.";
            QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
            QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
            QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type"::Accepted;
            QualityLedgerEntry.Quantity := InspectReceipt."Qty. Accepted Under Deviation";
            QualityLedgerEntry."Accepted Under Dev. Reason" := InspectReceipt."Qty. Accepted UD Reason";
            QualityLedgerEntry."Reason Description" := InspectReceipt."Reason Description";
            QualityLedgerEntry."Operation No." := InspectReceipt."Operation No.";
            QualityLedgerEntry."Accepted Under Dev. Reason" := InspectReceipt."Qty. Accepted UD Reason";
            QualityLedgerEntry."Reason Description" := InspectReceipt."Reason Description";
            QualityItemLedgEntry.SETRANGE("Entry No.", InspectReceipt."Item Ledger Entry No.");
            IF QualityItemLedgEntry.FINDFIRST THEN BEGIN
                QualityLedgerEntry."Serial No." := QualityItemLedgEntry."Serial No.";
                QualityLedgerEntry."Lot No." := QualityItemLedgEntry."Lot No.";
                QualityLedgerEntry."Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                IF (InspectReceipt."Qty. Rejected" = 0) THEN
                    QualityItemLedgEntry.DELETE;
            END;
            QualityLedgerEntry.INSERT;
        END;
        IF InspectReceipt."Qty. Rejected" <> 0 THEN BEGIN
            IF InspectReceipt."Rework Level" = 0 THEN
                QualityLedgerEntry."In bound Item Ledger Entry No." := InspectReceipt."Item Ledger Entry No."
            ELSE
                QualityLedgerEntry."In bound Item Ledger Entry No." := InspectReceipt."DC Inbound Ledger Entry.";
            QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
            QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
            QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type"::Reject;
            QualityLedgerEntry.Quantity := InspectReceipt."Qty. Rejected";
            //QCP1.0 prasad
            QualityLedgerEntry.VALIDATE("Location Code", 'REJ');
            //QCP1.0
            QualityLedgerEntry."New Location Code" := QualityLedgerEntry."New Location Code";
            QualityLedgerEntry."Accepted Under Dev. Reason" := '';
            QualityLedgerEntry."Reason Description" := '';
            QualityLedgerEntry."Operation No." := InspectReceipt."Operation No.";
            QualityItemLedgEntry.SETRANGE("Entry No.", InspectReceipt."Item Ledger Entry No.");
            IF QualityItemLedgEntry.FINDFIRST THEN BEGIN
                QualityLedgerEntry."Serial No." := QualityItemLedgEntry."Serial No.";
                QualityLedgerEntry."Lot No." := QualityItemLedgEntry."Lot No.";
                QualityLedgerEntry."Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
            END;
            QualityLedgerEntry.INSERT;

            IF (InspectReceipt."Source Type" = InspectReceipt."Source Type"::"In Bound") AND
               (NOT InspectReceipt."Quality Before Receipt") THEN
                UpdateItemLedgerEntry(QualityLedgerEntry, TRUE);
            QualityItemLedgEntry.SETRANGE("Entry No.", InspectReceipt."Item Ledger Entry No.");
            IF QualityItemLedgEntry.FINDFIRST THEN BEGIN
                QualityItemLedgEntry.DELETE;
            END;
        END;
        QualityLedgerEntry."In bound Item Ledger Entry No." := InspectReceipt."Item Ledger Entry No.";
        QualityLedgerEntry."Item Ledger Entry No." := InspectReceipt."Item Ledger Entry No.";
        UpdateParentInspectionReceipt(InspectReceipt);
        IF InspectReceipt."Qty. Rework" <> 0 THEN BEGIN
            QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
            QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
            QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type"::Rework;
            QualityLedgerEntry.Quantity := InspectReceipt."Qty. Rework";
            QualityLedgerEntry."Accepted Under Dev. Reason" := '';
            QualityLedgerEntry."Reason Description" := '';
            QualityLedgerEntry."Operation No." := InspectReceipt."Operation No.";
            QualityLedgerEntry."Serial No." := QualityItemLedgEntry."Serial No.";
            QualityLedgerEntry."Lot No." := QualityItemLedgEntry."Lot No.";
            QualityLedgerEntry.INSERT;
        END;
    end;


    procedure "UpdateRes.Entry"(var ItemJournalLine: Record "Item Journal Line"; var QualityLedgEntry2: Record "Quality Ledger Entry");
    var
        ReservationEntry: Record "Reservation Entry";
        TempReservationEntry: Record "Reservation Entry";
        EntryNo: Integer;
    begin
        IF TempReservationEntry.FINDLAST THEN
            EntryNo := TempReservationEntry."Entry No."
        ELSE
            EntryNo := 0;
        ReservationEntry."Entry No." := EntryNo + 1;
        ReservationEntry.VALIDATE(Positive, FALSE);
        ReservationEntry.VALIDATE("Item No.", ItemJournalLine."Item No.");
        ReservationEntry.VALIDATE("Location Code", ItemJournalLine."Location Code");
        ReservationEntry.VALIDATE("Quantity (Base)", -QualityLedgEntry2.Quantity);
        ReservationEntry.VALIDATE(Quantity, -QualityLedgEntry2.Quantity);
        ReservationEntry.VALIDATE("Reservation Status", ReservationEntry."Reservation Status"::Prospect);
        ReservationEntry.VALIDATE("Creation Date", ItemJournalLine."Posting Date");
        ReservationEntry.VALIDATE("Source Type", DATABASE::"Item Journal Line");
        ReservationEntry.VALIDATE("Source Subtype", 4);
        ReservationEntry.VALIDATE("Source ID", ItemJnlLine."Journal Template Name");
        ReservationEntry.VALIDATE("Source Batch Name", ItemJnlLine."Journal Batch Name");
        ReservationEntry.VALIDATE("Source Ref. No.", ItemJnlLine."Line No.");
        //ReservationEntry.VALIDATE("Appl.-to Item Entry",QualityLedgEntry2."Applies-to Entry");
        ReservationEntry.VALIDATE("Appl.-to Item Entry", QualityLedgerEntry."In bound Item Ledger Entry No."); //Rev01
        ReservationEntry.VALIDATE("Shipment Date", ItemJournalLine."Posting Date");
        ReservationEntry.VALIDATE("Serial No.", QualityLedgEntry2."Serial No.");
        ReservationEntry.VALIDATE("Suppressed Action Msg.", FALSE);
        ReservationEntry.VALIDATE("Planning Flexibility", ReservationEntry."Planning Flexibility"::Unlimited);
        ReservationEntry.VALIDATE("Expiration Date", QualityItemLedgEntry."Expiration Date");
        ReservationEntry.VALIDATE("Lot No.", QualityLedgEntry2."Lot No.");
        ReservationEntry.VALIDATE(ReservationEntry."New Lot No.", QualityLedgEntry2."Lot No.");
        ReservationEntry.VALIDATE(ReservationEntry."New Serial No.", QualityLedgEntry2."Serial No.");
        ReservationEntry.VALIDATE(Correction, FALSE);
        ReservationEntry.INSERT;
    end;


    procedure UpdateItemLedgerEntryForSerial(QualityLedgEntry2: Record "Quality Ledger Entry"; ItemTrackingExists: Boolean);
    var
        "-Rev01-": Integer;
        ItemLedgEntryLRec: Record "Item Ledger Entry";
    begin
        ItemJnlLine.SETRANGE(ItemJnlLine."Journal Template Name", 'RECLASS');
        ItemJnlLine.SETRANGE(ItemJnlLine."Journal Batch Name", 'DEFAULT');
        IF ItemJnlLine.FINDFIRST THEN
            ItemJnlLine.DELETEALL;
        ItemJnlLine.RESET;
        ItemJnlLine.INIT;
        ItemJnlLine."Journal Template Name" := 'RECLASS';
        ItemJnlLine."Journal Batch Name" := 'DEFAULT';
        ItemJnlLine."Posting Date" := WORKDATE;
        ItemJnlLine."Document Date" := WORKDATE;
        ItemJnlLine."Document No." := QualityLedgEntry2."Document No.";
        ItemJnlLine."Line No." := ItemReclassLineNo;
        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::Transfer;
        ItemJnlLine.VALIDATE("Item No.", QualityLedgEntry2."Item No.");
        //B2BQC Check start
        IF (QualityLedgEntry2."Entry Type" <> QualityLedgEntry2."Entry Type"::Accepted) THEN
            ItemJnlLine."QC Check" := TRUE;
        //B2BQC Check end;
        IF QualityLedgEntry2."Unit Of Measure Code" <> '' THEN
            ItemJnlLine.VALIDATE("Unit of Measure Code", QualityLedgEntry2."Unit Of Measure Code");
        //QCP1.0
        //CommentedItemJnlLine.VALIDATE(Quantity,QualityLedgEntry2."Remaining Quantity");
        ItemJnlLine.VALIDATE(Quantity, QualityLedgEntry2.Quantity);
        //QCP1.0
        ItemJnlLine.VALIDATE("Location Code", QualityLedgEntry2."Location Code");
        ItemJnlLine.VALIDATE("New Location Code", QualityLedgEntry2."New Location Code");
        //NSS ItemJnlLine.VALIDATE("Applies-to Entry",QualityLedgEntry2."In bound Item Ledger Entry No.");
        //Rev01 Start
        //Code Commented
        /*
        ItemJnlLine.VALIDATE("Applies-to Entry",QualityLedgerEntry."In bound Item Ledger Entry No.");
        */
        IF NOT ItemTrackingExists THEN
            ItemJnlLine.VALIDATE("Applies-to Entry", QualityLedgerEntry."In bound Item Ledger Entry No.")
        ELSE BEGIN
            IF QualityLedgerEntry."In bound Item Ledger Entry No." <> 0 THEN BEGIN
                ItemLedgEntryLRec.GET(QualityLedgerEntry."In bound Item Ledger Entry No.");

                ItemJnlLine."Location Code" := ItemLedgEntryLRec."Location Code";
                ItemJnlLine."Variant Code" := ItemLedgEntryLRec."Variant Code";
            END;
        END;
        //Rev01 End

        ItemJnlLine."Quality Ledger Entry No." := QualityLedgEntry2."Entry No.";
        //QCP1.0

        ItemJnlLine."Quantity (Base)" := ItemJnlLine.Quantity;
        IF ItemTrackingExists THEN BEGIN
            "UpdateRes.Entry"(ItemJnlLine, QualityLedgEntry2);
        END;
        //B2B1.1

        //QCP1.0
        ItemJnlLine.INSERT;
        ItemJnlPostLine.RUN(ItemJnlLine);
        IF (QualityLedgerEntry."Entry Type" = QualityLedgerEntry."Entry Type"::Accepted) OR
          (QualityLedgerEntry."Entry Type" = QualityLedgerEntry."Entry Type"::Reject) THEN BEGIN
            ItemApplnEntry.SETRANGE("Transferred-from Entry No.", QualityLedgEntry2."In bound Item Ledger Entry No.");
            IF ItemApplnEntry.FINDLAST THEN
                QualityLedgerEntry."Item Ledger Entry No." := ItemApplnEntry."Inbound Item Entry No.";
        END;
        UpdateQualityItemLedgEntry;

        /*
        END ELSE BEGIN
          QualityItemLedgEntry.SETRANGE("Entry No.",QualityLedgEntry2."In bound Item Ledger Entry No.");
          RemainQty := QualityLedgEntry2.Quantity;
          IF QualityItemLedgEntry.FINDSET THEN
            REPEAT
              IF RemainQty < QualityItemLedgEntry."Remaining Quantity" THEN
                QtyToApply := RemainQty
              ELSE
                QtyToApply := QualityItemLedgEntry."Remaining Quantity";
              RemainQty := RemainQty - QtyToApply;
              IF QtyToApply <> 0 THEN BEGIN
                ItemJnlLine.SETRANGE(ItemJnlLine."Journal Template Name" ,'RECLASS');
                ItemJnlLine.SETRANGE(ItemJnlLine."Journal Batch Name" ,'DEFAULT');
                IF ItemJnlLine.FINDFIRST THEN
                   ItemJnlLine.DELETEALL;
                ItemJnlLine.RESET;
                ItemJnlLine.INIT;
                ItemJnlLine."Journal Template Name" := 'RECLASS';
                ItemJnlLine."Journal Batch Name" :='DEFAULT';
                ItemJnlLine."Posting Date" := WORKDATE;
                ItemJnlLine."Document Date" := WORKDATE;
                ItemJnlLine."Document No." := QualityLedgEntry2."Document No.";
                ItemJnlLine."Line No." := ItemReclassLineNo;
                ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type" :: Transfer;
                //QCP1.0
                ItemJnlLine."Transfer Type" := ItemJnlLine."Transfer Type" ::" ";
                //QCP1.0
                ItemJnlLine."Transfer Type" := ItemJnlLine."Transfer Type" ::" ";
                ItemJnlLine.VALIDATE("Item No.",QualityLedgEntry2."Item No.");
                ItemJnlLine."Applies-to Entry" := QualityItemLedgEntry."Entry No.";
                ItemJnlLine.VALIDATE(Quantity,QtyToApply);
                ItemJnlLine.VALIDATE("Location Code",QualityLedgEntry2."Location Code");
                ItemJnlLine.VALIDATE("New Location Code",QualityLedgEntry2."Location Code");
                ItemJnlLine.VALIDATE("Applies-to Entry",QualityItemLedgEntry."Entry No.");
                ItemJnlLine."Quality Ledger Entry No." := QualityLedgEntry2."Entry No.";
                QualityLedgerEntry."In bound Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
        //B2BQC Check start
        IF (QualityLedgEntry2."Entry Type" <> QualityLedgEntry2."Entry Type"::Accepted) THEN
          ItemJnlLine."QC Check" := TRUE;
        //B2BQC Check end;
        
                ItemJnlLine.INSERT;
                ItemJnlPostLine.RUN(ItemJnlLine);
                IF (QualityLedgerEntry."Entry Type" = QualityLedgerEntry."Entry Type" :: Accepted) OR
                  (QualityLedgerEntry."Entry Type" = QualityLedgerEntry."Entry Type" :: Reject) THEN BEGIN
                    ItemApplnEntry.SETRANGE("Transferred-from Entry No.",QualityLedgerEntry."In bound Item Ledger Entry No.");
                    IF ItemApplnEntry.FINDLAST THEN
                     QualityLedgerEntry."Item Ledger Entry No." := ItemApplnEntry."Inbound Item Entry No.";
                END;
                UpdateQualityItemLedgEntry;
              END;
            UNTIL QualityItemLedgEntry.NEXT = 0;
        END; */

        QualityLedgerEntry.Open := FALSE;
        QualityLedgerEntry."Remaining Quantity" := 0;
        QualityLedgerEntry.MODIFY;

    end;


    procedure "-----PIDSQC1.0----"();
    begin
    end;


    procedure CallPostedItemTrackingForm2(Type: Integer; Subtype: Integer; ID: Code[20]; BatchName: Code[10]; ProdOrderLine: Integer; RefNo: Integer; var InspectReceipt2: Record "Inspection Receipt Header"; ChildIDSRefNo: Code[20]) OK: Boolean;
    var
        ItemEntryRelation: Record "Item Entry Relation";
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
        TempItemLedgEntry1: Record "Quality Item Ledger Entry" temporary;
        SignFactor: Integer;
    begin
        //Created for Partial IDS Dispaly

        ItemEntryRelation.SETCURRENTKEY("Source ID", "Source Type");
        ItemEntryRelation.SETRANGE("Source Type", Type);
        ItemEntryRelation.SETRANGE("Source Subtype", Subtype);
        ItemEntryRelation.SETRANGE("Source ID", ID);
        ItemEntryRelation.SETRANGE("Source Batch Name", BatchName);
        ItemEntryRelation.SETRANGE("Source Prod. Order Line", ProdOrderLine);
        ItemEntryRelation.SETRANGE("Source Ref. No.", RefNo);
        ItemEntryRelation.SETRANGE("Lot No.", InspectReceipt2."Lot No.");
        TempItemLedgEntry1.DELETEALL;
        IF ItemEntryRelation.FINDFIRST THEN BEGIN
            SignFactor := TableSignFactor(Type);
            IF NOT InspectReceipt2.Status THEN BEGIN
                IF InspectReceipt2."Rework Level" = 0 THEN BEGIN
                    REPEAT
                        QualityItemLedgEntry.SETRANGE("Child Ids", ChildIDSRefNo); //PIDSQC1.0 30/07/08
                        QualityItemLedgEntry.SETRANGE(Select, TRUE); //PIDSQC1.0 30/07/08
                        QualityItemLedgEntry.SETRANGE("Entry No.", ItemEntryRelation."Item Entry No."); //PIDSQC1.0 30/07/08
                        IF QualityItemLedgEntry.FINDFIRST THEN BEGIN //PIDSQC1.0 30/07/08
                                                                     //IF QualityItemLedgEntry.GET(ItemEntryRelation."Item Entry No.") THEN BEGIN //Base
                            IF (QualityItemLedgEntry."Inspection Status" = QualityItemLedgEntry."Inspection Status"::"Under Inspection") THEN BEGIN
                                TempItemLedgEntry1 := QualityItemLedgEntry;
                                TempItemLedgEntry1.INSERT;
                            END;
                        END;
                    UNTIL ItemEntryRelation.NEXT = 0;
                    PAGE.RUNMODAL(PAGE::"Inspection Item Tracking Lines", TempItemLedgEntry1)
                END ELSE BEGIN
                    IF InspectReceipt2."Serial No." = '' THEN BEGIN
                        QualityItemLedgEntry.SETRANGE("Lot No.", InspectReceipt2."Lot No.");
                        IF QualityItemLedgEntry.FINDFIRST THEN BEGIN
                            TempItemLedgEntry1 := QualityItemLedgEntry;
                            TempItemLedgEntry1.INSERT;
                        END;
                    END
                    ELSE BEGIN
                        QualityItemLedgEntry.SETRANGE("Serial No.", InspectReceipt2."Serial No.");
                        //QualityItemLedgEntry.SETRANGE("Child Ids",ChildIDSRefNo); //PIDSQC1.0 30/07/08
                        QualityItemLedgEntry.SETRANGE(Select, TRUE); //PIDSQc1.0
                        IF QualityItemLedgEntry.FINDFIRST THEN BEGIN
                            TempItemLedgEntry1 := QualityItemLedgEntry;
                            TempItemLedgEntry1.INSERT;
                        END
                    END;
                    PAGE.RUNMODAL(PAGE::"Inspection Item Tracking Lines", TempItemLedgEntry1);
                END;
                InspectReceipt2."Qty. Accepted" := 0;
                InspectReceipt2."Qty. Rejected" := 0;
                InspectReceipt2."Qty. Rework" := 0;
                InspectReceipt2."Qty. Accepted Under Deviation" := 0;
                IF TempItemLedgEntry1.FINDFIRST THEN
                    REPEAT
                        IF TempItemLedgEntry1.Accept THEN
                            InspectReceipt2."Qty. Accepted" := InspectReceipt2."Qty. Accepted" + TempItemLedgEntry1.Quantity;
                        IF TempItemLedgEntry1.Reject THEN
                            InspectReceipt2."Qty. Rejected" := InspectReceipt2."Qty. Rejected" + TempItemLedgEntry1.Quantity;
                        IF TempItemLedgEntry1.Rework THEN
                            InspectReceipt2."Qty. Rework" := InspectReceipt2."Qty. Rework" + TempItemLedgEntry1.Quantity;
                        IF TempItemLedgEntry1."Accept Under Deviation" THEN
                            InspectReceipt2."Qty. Accepted Under Deviation" := InspectReceipt2."Qty. Accepted Under Deviation" +
                                                                               TempItemLedgEntry1.Quantity;
                        QualityItemLedgEntry.COPY(TempItemLedgEntry1);
                        QualityItemLedgEntry.MODIFY;
                    UNTIL TempItemLedgEntry1.NEXT = 0;
                InspectReceipt2.MODIFY;
                EXIT(TRUE);
            END ELSE BEGIN
                IF InspectReceipt2."Rework Level" = 0 THEN BEGIN
                    QualityItemLedgEntry.SETRANGE("Document No.", InspectReceipt2."Receipt No.");
                    QualityItemLedgEntry.SETRANGE("Lot No.", InspectReceipt2."Lot No.");
                    QualityItemLedgEntry.SETRANGE(Select, TRUE); //PIDSQC1.0
                    IF QualityItemLedgEntry.FINDFIRST THEN
                        REPEAT
                            IF QualityItemLedgEntry.Rework THEN BEGIN
                                TempItemLedgEntry1 := QualityItemLedgEntry;
                                TempItemLedgEntry1.INSERT;
                            END;
                        UNTIL QualityItemLedgEntry.NEXT = 0;
                    PAGE.RUNMODAL(PAGE::"Inspection Item Tracking Lines", TempItemLedgEntry1);
                END ELSE BEGIN
                    IF InspectReceipt2."Serial No." = '' THEN BEGIN
                        QualityItemLedgEntry.SETRANGE("Lot No.", InspectReceipt2."Lot No.");
                        QualityItemLedgEntry.SETRANGE(Select, TRUE); //PIDSQC1.0
                        IF QualityItemLedgEntry.FINDFIRST THEN BEGIN
                            TempItemLedgEntry1 := QualityItemLedgEntry;
                            TempItemLedgEntry1.INSERT;
                        END;
                    END ELSE BEGIN
                        QualityItemLedgEntry.SETRANGE("Serial No.", InspectReceipt2."Serial No.");
                        QualityItemLedgEntry.SETRANGE(Select, TRUE); //PIDSQc1.0
                        IF QualityItemLedgEntry.FINDFIRST THEN BEGIN
                            TempItemLedgEntry1 := QualityItemLedgEntry;
                            TempItemLedgEntry1.INSERT;
                        END;
                    END;
                    PAGE.RUNMODAL(PAGE::"Inspection Item Tracking Lines", TempItemLedgEntry1);
                END;
                InspectReceipt2."Qty. To Vendor (Rework)" := 0;
                IF TempItemLedgEntry1.FINDFIRST THEN
                    REPEAT
                        IF TempItemLedgEntry1."Sending to Rework" THEN
                            InspectReceipt2."Qty. To Vendor (Rework)" := InspectReceipt2."Qty. To Vendor (Rework)" + TempItemLedgEntry1.Quantity;
                        QualityItemLedgEntry.COPY(TempItemLedgEntry1);
                        QualityItemLedgEntry.MODIFY;
                    UNTIL TempItemLedgEntry1.NEXT = 0;
                InspectReceipt2.MODIFY;
            END;
            EXIT(TRUE);
        END ELSE
            EXIT(FALSE);
    end;


    procedure "--Test by phani Not Using----"();
    begin
    end;


    procedure InsertQCItemTrackingLedger2(Type: Integer; Subtype: Integer; ID: Code[20]; BatchName: Code[10]; ProdOrderLine: Integer; RefNo: Integer; var InspectReceipt2: Record "Inspection Receipt Header");
    var
        ItemEntryRelation: Record "Item Entry Relation";
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
        PostInspDataSheetHeader: Record "Posted Inspect DatasheetHeader";
    begin
        //New Function Created for LOT Serial Partial Concept.

        ItemEntryRelation.SETCURRENTKEY("Source ID", "Source Type");
        ItemEntryRelation.SETRANGE("Source Type", Type);
        ItemEntryRelation.SETRANGE("Source Subtype", Subtype);
        ItemEntryRelation.SETRANGE("Source ID", ID);
        ItemEntryRelation.SETRANGE("Source Batch Name", BatchName);
        ItemEntryRelation.SETRANGE("Source Prod. Order Line", ProdOrderLine);
        ItemEntryRelation.SETRANGE("Source Ref. No.", RefNo);
        ItemEntryRelation.SETRANGE("Lot No.", InspectReceipt2."Lot No.");
        IF InspectReceipt2."Rework Level" = 0 THEN BEGIN
            IF ItemEntryRelation.FINDFIRST THEN BEGIN
                REPEAT
                    IF QualityItemLedgEntry.GET(ItemEntryRelation."Item Entry No.") AND
                      (QualityItemLedgEntry."Inspection Status" = QualityItemLedgEntry."Inspection Status"::"Under Inspection") THEN BEGIN


                        //300708 PIDSQC1.0>>

                        ChildIDS := InspectReceipt2."Ids Reference No.";
                        //ChildIDS := QualityItemLedgEntry."Child Ids"; //ADSK //Code comented because it is posting the two ID'S serial no. in a single IR entry
                        QualityItemLedgEntry.SETRANGE("Entry No.", ItemEntryRelation."Item Entry No.");
                        QualityItemLedgEntry.SETRANGE("Child Ids", ChildIDS);
                        QualityItemLedgEntry.SETRANGE(Select, TRUE);
                        IF QualityItemLedgEntry.FINDFIRST THEN BEGIN

                            IF (QualityItemLedgEntry.Accept) OR (QualityItemLedgEntry."Accept Under Deviation") THEN BEGIN
                                QualityLedgerEntry.Quantity := QualityItemLedgEntry."Remaining Quantity";
                                QualityLedgerEntry."Remaining Quantity" := 0;
                                QualityLedgerEntry.Open := FALSE;
                                QualityLedgerEntry."Serial No." := QualityItemLedgEntry."Serial No.";
                                QualityLedgerEntry."Lot No." := QualityItemLedgEntry."Lot No.";
                                QualityLedgerEntry."Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                                IF QualityItemLedgEntry."Accept Under Deviation" THEN BEGIN
                                    QualityLedgerEntry."Accepted Under Dev. Reason" := InspectReceipt2."Qty. Accepted UD Reason";
                                    QualityLedgerEntry."Reason Description" := InspectReceipt2."Reason Description";
                                END;
                                QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
                                QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
                                QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type"::Accepted;
                                QualityItemLedgEntry."Quality Ledger Entry No." := QualityLedgerEntry."Entry No.";
                                QualityLedgerEntry.INSERT;
                                QualityItemLedgEntry.DELETE;
                            END;
                            //310708>>
                            IF QualityItemLedgEntry.Reject THEN BEGIN
                                QualityLedgerEntry.Quantity := QualityItemLedgEntry."Remaining Quantity";
                                QualityLedgerEntry."Remaining Quantity" := 0;
                                QualityLedgerEntry.Open := FALSE;
                                QualityLedgerEntry."Serial No." := QualityItemLedgEntry."Serial No.";
                                QualityLedgerEntry."Lot No." := QualityItemLedgEntry."Lot No.";
                                QualityLedgerEntry."Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                                QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
                                QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
                                QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type"::Reject;
                                QualityItemLedgEntry."Inspection Status" := QualityItemLedgEntry."Inspection Status"::Rejected;
                                QualityItemLedgEntry."Quality Ledger Entry No." := QualityLedgerEntry."Entry No.";
                                QualityLedgerEntry."Accepted Under Dev. Reason" := '';
                                QualityLedgerEntry."Reason Description" := '';

                                //NSS 050108
                                QualityLedgerEntry."In bound Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                                IF QualityLedgerEntry."Entry Type" = QualityLedgerEntry."Entry Type"::Reject THEN
                                    QualityLedgerEntry."New Location Code" := 'REJ';

                                QualityLedgerEntry.INSERT;
                                QualityItemLedgEntry.MODIFY;
                                UpdateItemLedgerEntryForSerial(QualityLedgerEntry, TRUE);
                                //NSS 050108

                            END;
                            IF QualityItemLedgEntry.Rework THEN BEGIN
                                QualityLedgerEntry.Quantity := QualityItemLedgEntry."Remaining Quantity";
                                QualityLedgerEntry."Remaining Quantity" := QualityItemLedgEntry."Remaining Quantity";
                                QualityLedgerEntry."Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                                QualityLedgerEntry.Open := TRUE;
                                QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
                                QualityLedgerEntry."Serial No." := QualityItemLedgEntry."Serial No.";
                                QualityLedgerEntry."Lot No." := QualityItemLedgEntry."Lot No.";
                                QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
                                QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type"::Rework;
                                QualityLedgerEntry."Accepted Under Dev. Reason" := '';
                                QualityLedgerEntry."Reason Description" := '';
                                QualityLedgerEntry.INSERT;
                            END;
                            //310708<<


                            //END;
                            //END;
                            //PIDSQC1.0 300708<<

                            //10Sep08
                            /*    END ELSE BEGIN
                             //Base300708>>
                                IF (QualityItemLedgEntry.Accept) OR (QualityItemLedgEntry."Accept Under Deviation") THEN BEGIN
                                  QualityLedgerEntry.Quantity := QualityItemLedgEntry."Remaining Quantity";
                                  QualityLedgerEntry."Remaining Quantity" := 0;
                                  QualityLedgerEntry.Open := FALSE;
                                  QualityLedgerEntry."Serial No." := QualityItemLedgEntry."Serial No.";
                                  QualityLedgerEntry."Lot No." := QualityItemLedgEntry."Lot No.";
                                  QualityLedgerEntry."Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                                  IF QualityItemLedgEntry."Accept Under Deviation" THEN BEGIN
                                    QualityLedgerEntry."Accepted Under Dev. Reason" := InspectReceipt2."Qty. Accepted UD Reason";
                                    QualityLedgerEntry."Reason Description" := InspectReceipt2."Reason Description";
                                  END;
                                  QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
                                  QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
                                  QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type" :: Accepted;
                                  QualityItemLedgEntry."Quality Ledger Entry No." := QualityLedgerEntry."Entry No.";
                                  QualityLedgerEntry.INSERT;

                                  QualityItemLedgEntry.DELETE;
                                  END;
                                  {//B2BQCCheck Start
                                    IF ItemLedEntry.GET(QualityItemLedgEntry."Entry No.") THEN BEGIN
                                      ItemLedEntry."QC Check" := FALSE;
                                      ItemLedEntry.MODIFY;
                                    END;
                                  //B2BQCCheck End
                                  }
                                 IF QualityItemLedgEntry.Reject THEN BEGIN
                                   QualityLedgerEntry.Quantity := QualityItemLedgEntry."Remaining Quantity";
                                  QualityLedgerEntry."Remaining Quantity" := 0;
                                  QualityLedgerEntry.Open := FALSE;
                                  QualityLedgerEntry."Serial No." := QualityItemLedgEntry."Serial No.";
                                  QualityLedgerEntry."Lot No." := QualityItemLedgEntry."Lot No.";
                                  QualityLedgerEntry."Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                                  QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
                                  QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
                                  QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type" :: Reject;
                                  QualityItemLedgEntry."Inspection Status" := QualityItemLedgEntry."Inspection Status" :: Rejected;
                                  QualityItemLedgEntry."Quality Ledger Entry No." := QualityLedgerEntry."Entry No.";
                                  QualityLedgerEntry."Accepted Under Dev. Reason" := '';
                                  QualityLedgerEntry."Reason Description" := '';

                                  //NSS 050108
                                  QualityLedgerEntry."In bound Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                                  IF QualityLedgerEntry."Entry Type" = QualityLedgerEntry."Entry Type" :: Reject THEN
                                    QualityLedgerEntry."New Location Code" := 'REJ';

                                  QualityLedgerEntry.INSERT;
                                  QualityItemLedgEntry.MODIFY;
                                  UpdateItemLedgerEntryForSerial(QualityLedgerEntry,TRUE);
                                 //NSS 050108

                                END;

                                IF QualityItemLedgEntry.Rework THEN BEGIN
                                  QualityLedgerEntry.Quantity := QualityItemLedgEntry."Remaining Quantity";
                                  QualityLedgerEntry."Remaining Quantity" := QualityItemLedgEntry."Remaining Quantity";
                                  QualityLedgerEntry."Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                                  QualityLedgerEntry.Open := TRUE;
                                  QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
                                  QualityLedgerEntry."Serial No." := QualityItemLedgEntry."Serial No.";
                                  QualityLedgerEntry."Lot No." := QualityItemLedgEntry."Lot No.";
                                  QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
                                  QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type" :: Rework;
                                  QualityLedgerEntry."Accepted Under Dev. Reason" := '';
                                  QualityLedgerEntry."Reason Description" := '';
                                  QualityLedgerEntry.INSERT;
                                END; */  //10Sep08
                        END;
                    END;
                //Base 300708<<

                UNTIL ItemEntryRelation.NEXT = 0;
            END;

        END ELSE BEGIN
            IF InspectReceipt2."Serial No." = '' THEN
                QualityItemLedgEntry.SETRANGE("Lot No.", InspectReceipt2."Lot No.")
            ELSE
                QualityItemLedgEntry.SETRANGE("Serial No.", InspectReceipt2."Serial No.");
            IF QualityItemLedgEntry.FINDFIRST THEN BEGIN
                IF (QualityItemLedgEntry.Accept) OR (QualityItemLedgEntry."Accept Under Deviation") THEN BEGIN
                    QualityLedgerEntry.Quantity := QualityItemLedgEntry."Remaining Quantity";
                    QualityLedgerEntry."Remaining Quantity" := 0;
                    QualityLedgerEntry.Open := FALSE;
                    QualityLedgerEntry."Serial No." := QualityItemLedgEntry."Serial No.";
                    QualityLedgerEntry."Lot No." := QualityItemLedgEntry."Lot No.";
                    QualityLedgerEntry."Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                    IF QualityItemLedgEntry."Accept Under Deviation" THEN BEGIN
                        QualityLedgerEntry."Accepted Under Dev. Reason" := InspectReceipt2."Qty. Accepted UD Reason";
                        QualityLedgerEntry."Reason Description" := InspectReceipt2."Reason Description";
                    END;
                    QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
                    QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
                    QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type"::Accepted;
                    QualityItemLedgEntry."Quality Ledger Entry No." := QualityLedgerEntry."Entry No.";
                    QualityLedgerEntry.INSERT;
                    /*          //B2BQCCheck Start
                                IF ItemLedEntry.GET(QualityItemLedgEntry."Entry No.") THEN BEGIN
                                  ItemLedEntry."QC Check" := FALSE;
                                  ItemLedEntry.MODIFY;
                                END;
                              //B2BQCCheck End
                     */
                    QualityItemLedgEntry.DELETE;
                END;
                IF QualityItemLedgEntry.Reject THEN BEGIN
                    QualityLedgerEntry.Quantity := QualityItemLedgEntry."Remaining Quantity";
                    QualityLedgerEntry."Remaining Quantity" := 0;
                    QualityLedgerEntry.Open := FALSE;
                    QualityLedgerEntry."Serial No." := QualityItemLedgEntry."Serial No.";
                    QualityLedgerEntry."Lot No." := QualityItemLedgEntry."Lot No.";
                    QualityLedgerEntry."Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                    QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
                    QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
                    QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type"::Reject;
                    QualityItemLedgEntry."Inspection Status" := QualityItemLedgEntry."Inspection Status"::Rejected;
                    QualityItemLedgEntry."Quality Ledger Entry No." := QualityLedgerEntry."Entry No.";
                    QualityLedgerEntry."Accepted Under Dev. Reason" := '';
                    QualityLedgerEntry."Reason Description" := '';
                    QualityLedgerEntry.INSERT;
                    QualityItemLedgEntry."Document No." := InspectReceipt2."No.";
                    QualityItemLedgEntry.MODIFY;
                END;
                IF QualityItemLedgEntry.Rework THEN BEGIN
                    QualityLedgerEntry.Quantity := QualityItemLedgEntry."Remaining Quantity";
                    QualityLedgerEntry."Remaining Quantity" := QualityItemLedgEntry."Remaining Quantity";
                    QualityLedgerEntry."Item Ledger Entry No." := QualityItemLedgEntry."Entry No.";
                    QualityLedgerEntry.Open := TRUE;
                    QualityLedgerEntryNo := QualityLedgerEntryNo + 1;
                    QualityLedgerEntry."Serial No." := QualityItemLedgEntry."Serial No.";
                    QualityLedgerEntry."Lot No." := QualityItemLedgEntry."Lot No.";
                    QualityLedgerEntry."Entry No." := QualityLedgerEntryNo;
                    QualityLedgerEntry."Entry Type" := QualityLedgerEntry."Entry Type"::Rework;
                    QualityLedgerEntry."Accepted Under Dev. Reason" := '';
                    QualityLedgerEntry."Reason Description" := '';
                    QualityLedgerEntry.INSERT;
                    QualityItemLedgEntry."Document No." := InspectReceipt2."No.";
                    QualityItemLedgEntry.MODIFY;
                END;
            END;
            IF InspectReceipt2."Rework Reference No." <> '0' THEN
                UpdateParentQualityLedgEntry(InspectReceipt2."Rework Reference No.");
        END;

    end;


    local procedure UpdateQCPassed(var InspecRcpt: Record "Inspection Receipt Header");
    var
        PRL: Record "Purch. Rcpt. Line";
    begin
        PRL.RESET;
        PRL.SETFILTER(PRL."Document No.", InspecRcpt."Receipt No.");
        PRL.SETFILTER(PRL."No.", InspecRcpt."Item No.");
        PRL.SETFILTER(PRL."Line No.", FORMAT(InspecRcpt."Purch Line No"));
        //PRL.SETFILTER("Quantity (Base)",'> %1',0);
        IF PRL.FINDSET THEN
            REPEAT
            BEGIN
                IF PRL."Quantity (Base)" = (PRL."Quantity Accepted" + PRL."Quantity Rejected") THEN BEGIN
                    PRL."QC Passed" := TRUE;
                    PRL.MODIFY;
                END;
            END;
            UNTIL PRL.NEXT = 0;
    end;

    PROCEDURE UpdateResEntryFortReturnOrder(VAR PurchaseLine: Record 39; VAR QualityLedgEntry2: Record 33000262);
    VAR
        ReservationEntry: Record 337;
        TempReservationEntry: Record 337;
        EntryNo: Integer;
    BEGIN
        IF TempReservationEntry.FIND('+') THEN
            EntryNo := TempReservationEntry."Entry No."
        ELSE
            EntryNo := 0;
        ReservationEntry.INIT;
        ReservationEntry."Entry No." := EntryNo + 1;
        ReservationEntry.VALIDATE(Positive, FALSE);
        ReservationEntry.VALIDATE("Item No.", QualityLedgEntry2."Item No.");
        ReservationEntry.VALIDATE("Location Code", QualityLedgEntry2."Location Code");
        ReservationEntry.VALIDATE("Quantity (Base)", -QualityLedgEntry2."Remaining Quantity");
        ReservationEntry.VALIDATE(Quantity, -QualityLedgEntry2."Remaining Quantity");
        ReservationEntry.VALIDATE("Reservation Status", ReservationEntry."Reservation Status"::Surplus);
        ReservationEntry.VALIDATE("Creation Date", Today);
        ReservationEntry.VALIDATE("Source Type", DATABASE::"Purchase Line");
        ReservationEntry.VALIDATE("Source Subtype", PurchaseLine."Document Type");
        ReservationEntry.VALIDATE("Source ID", PurchaseLine."Document No.");
        ReservationEntry.VALIDATE("Source Batch Name", '');
        ReservationEntry.VALIDATE("Source Ref. No.", PurchaseLine."Line No.");
        ReservationEntry.VALIDATE("Shipment Date", Today);
        ReservationEntry.VALIDATE("Serial No.", QualityLedgEntry2."Serial No.");
        ReservationEntry.VALIDATE("Suppressed Action Msg.", FALSE);
        ReservationEntry.VALIDATE("Planning Flexibility", ReservationEntry."Planning Flexibility"::Unlimited);
        ReservationEntry.VALIDATE("Expiration Date", QualityLedgEntry2."Expiration Date");
        ReservationEntry.VALIDATE("Lot No.", QualityLedgEntry2."Lot No.");
        ReservationEntry.VALIDATE(ReservationEntry."New Lot No.", QualityLedgEntry2."Lot No.");
        ReservationEntry.VALIDATE(ReservationEntry."New Serial No.", QualityLedgEntry2."Serial No.");
        ReservationEntry.VALIDATE("New Expiration Date", QualityLedgEntry2."Expiration Date"); //SMY 1.1
        ReservationEntry.VALIDATE("Appl.-to Item Entry", QualityLedgEntry2."Entry No.");
        ReservationEntry.VALIDATE(Correction, FALSE);
        ReservationEntry.INSERT;
    END;

}

