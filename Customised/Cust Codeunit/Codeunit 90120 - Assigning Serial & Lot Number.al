codeunit 90120 "Assigning Serial & Lot Number"
{

    trigger OnRun();
    begin
    end;

    var
        ReservationEntry: Record "Reservation Entry";
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        ConsumptionJournalLine: Record "Item Journal Line";
        Type: Option Transfer,Consumption;
        Item: Record Item;
        "ILEQty.": Decimal;
        ReclassJournalLine: Record "Item Journal Line";


    procedure "----For Transfer Orders---"();
    begin
    end;


    procedure AssignTracking(var TransferHeader: Record "Transfer Header");
    var
        TransferLine: Record "Transfer Line";
        TrackingAssignment: Record "Item Tracking Assignament";
    begin
        TransferLine.SETRANGE("Document No.", TransferHeader."No.");
        TransferLine.SETFILTER("Qty. to Ship", '<>%1', 0);
        IF TransferLine.FINDFIRST THEN
                REPEAT
                    IF CheckforSerialandLotNumber(TransferLine."Item No.") THEN BEGIN
                        DeleteResevations(TransferLine);
                        CheckInventory(TransferLine);
                        "AssignSerial&Lotnos"(TransferLine);
                    END;
                UNTIL TransferLine.NEXT = 0;

        IF TrackingAssignment.FINDFIRST THEN
            TrackingAssignment.DELETEALL;
    end;


    procedure DeleteResevations(var TransLine: Record "Transfer Line");
    var
        ResEntry: Record "Reservation Entry";
    begin
        ResEntry.SETRANGE("Source Type", DATABASE::"Transfer Line");
        ResEntry.SETRANGE("Source ID", TransLine."Document No.");
        ResEntry.SETRANGE("Source Ref. No.", TransLine."Line No.");
        ResEntry.SETRANGE("Location Code", TransLine."Transfer-from Code");
        IF ResEntry.FINDFIRST THEN
            ResEntry.DELETEALL;
    end;


    procedure CheckInventory(var TransferLine: Record "Transfer Line");
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        "ILEQty.": Decimal;
    begin
        "ILEQty." := 0;
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
        ItemLedgerEntry.SETRANGE("Item No.", TransferLine."Item No.");
        ItemLedgerEntry.SETRANGE(Open, TRUE);
        ItemLedgerEntry.SETRANGE("Location Code", TransferLine."Transfer-from Code");
        IF ItemLedgerEntry.FINDFIRST THEN
                REPEAT
                    "ILEQty." := "ILEQty." + ItemLedgerEntry.Quantity;
                UNTIL ItemLedgerEntry.NEXT = 0;

        IF "ILEQty." < TransferLine."Qty. to Ship" THEN BEGIN
            TransferLine."Qty. to Ship" := "ILEQty.";
            TransferLine.VALIDATE("Qty. to Ship");
            TransferLine.MODIFY;
        END;
    end;


    procedure CheckforSerialandLotNumber("ItemNo.": Code[20]): Boolean;
    var
        Item: Record Item;
    begin
        Item.GET("ItemNo.");
        IF Item."Item Tracking Code" <> '' THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;


    procedure "AssignSerial&Lotnos"(var TransferLine: Record "Transfer Line");
    var
        ReservationEntry: Record "Reservation Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        Window: Dialog;
        "Document Name": Text[50];
        UndifinedQty: Decimal;
        ResEntry: Record "Reservation Entry";
        EntryNo: Integer;
        QtyAssigned: Decimal;
        TempItemLedgEntry: Record "Item Ledger Entry" temporary;
        TrackingAssignment: Record "Item Tracking Assignament";
        TrackingAssignmentOld: Record "Item Tracking Assignament";
        "EntryNo.": Integer;
    begin
        Window.OPEN('Document Name  #1###################\' +
                    'Document No.   #2###################\' +
                    'Line No.       #3###################\' +
                    'Item No.       #4###################\' +
                    'Serial No.     #5###################\' +
                    'Lot No.        #6###################', "Document Name", ReservationEntry."Source ID",
                    ReservationEntry."Source Ref. No.", ReservationEntry."Item No.", ReservationEntry."Serial No.",
                    ReservationEntry."Lot No.");

        UndifinedQty := TransferLine."Qty. to Ship";

        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
        ItemLedgerEntry.SETRANGE("Item No.", TransferLine."Item No.");
        ItemLedgerEntry.SETRANGE("Location Code", TransferLine."Transfer-from Code");
        ItemLedgerEntry.SETRANGE(Open, TRUE);
        IF ItemLedgerEntry.FINDFIRST THEN
                REPEAT
                    TrackingAssignment.SETRANGE("ILE Entry No.", ItemLedgerEntry."Entry No.");
                    IF NOT TrackingAssignment.FINDFIRST THEN BEGIN
                        TrackingAssignment.TRANSFERFIELDS(ItemLedgerEntry);
                        IF TrackingAssignmentOld.FINDLAST THEN
                            "EntryNo." := TrackingAssignmentOld."Entry No."
                        ELSE
                            "EntryNo." := 0;
                        TrackingAssignment."Entry No." := "EntryNo." + 1;
                        TrackingAssignment.INSERT;
                    END;
                UNTIL ItemLedgerEntry.NEXT = 0;

        TrackingAssignment.RESET;
        TrackingAssignment.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
        TrackingAssignment.SETRANGE("Item No.", TransferLine."Item No.");
        TrackingAssignment.SETRANGE("Location Code", TransferLine."Transfer-from Code");
        TrackingAssignment.SETRANGE(Open, TRUE);
        TrackingAssignment.SETFILTER("Remaining Quantity", '<>%1', 0);
        IF TrackingAssignment.FINDFIRST THEN
            REPEAT
                    IF ResEntry.FINDLAST THEN
                        EntryNo := ResEntry."Entry No."
                    ELSE
                        EntryNo := 0;
                ReservationEntry."Entry No." := EntryNo + 1;
                ReservationEntry.Positive := FALSE;
                ReservationEntry."Item No." := TransferLine."Item No.";
                Window.UPDATE(4, ReservationEntry."Item No.");

                ReservationEntry."Location Code" := TransferLine."Transfer-from Code";
                ReservationEntry."Reservation Status" := ReservationEntry."Reservation Status"::Surplus;
                ReservationEntry.Description := TransferLine.Description;
                ReservationEntry."Creation Date" := WORKDATE;
                ReservationEntry."Transferred from Entry No." := 0;
                ReservationEntry."Source Type" := DATABASE::"Transfer Line";
                ReservationEntry."Source Subtype" := 0;
                ReservationEntry."Source ID" := TransferLine."Document No.";
                "Document Name" := 'Transfer Orders';
                Window.UPDATE(1, "Document Name");
                Window.UPDATE(2, ReservationEntry."Source ID");
                ReservationEntry."Source Batch Name" := '';
                ReservationEntry."Source Prod. Order Line" := 0;
                ReservationEntry."Source Ref. No." := TransferLine."Line No.";
                Window.UPDATE(3, ReservationEntry."Source Ref. No.");
                ReservationEntry."Appl.-to Item Entry" := 0;
                ReservationEntry."Expected Receipt Date" := 0D;
                ReservationEntry."Shipment Date" := WORKDATE;
                ReservationEntry."Serial No." := TrackingAssignment."Serial No.";
                Window.UPDATE(5, ReservationEntry."Serial No.");
                ReservationEntry."Created By" := USERID;
                ReservationEntry."Changed By" := '';
                ReservationEntry."Qty. per Unit of Measure" := TransferLine."Qty. per Unit of Measure";
                ReservationEntry.Binding := 0;
                ReservationEntry."Suppressed Action Msg." := FALSE;
                ReservationEntry."Planning Flexibility" := ReservationEntry."Planning Flexibility"::Unlimited;
                ReservationEntry."Warranty Date" := TrackingAssignment."Warranty Date";
                ReservationEntry."Expiration Date" := TrackingAssignment."Expiration Date";
                ReservationEntry."New Serial No." := TrackingAssignment."Serial No.";
                ReservationEntry."Lot No." := TrackingAssignment."Lot No.";
                Window.UPDATE(6, ReservationEntry."Lot No.");
                ReservationEntry."New Lot No." := TrackingAssignment."Lot No.";
                ReservationEntry."Variant Code" := '';
                ReservationEntry.Correction := FALSE;
                ReservationEntry."Action Message Adjustment" := 0;
                IF (ReservationEntry."Serial No." = '') AND (ReservationEntry."Lot No." <> '') THEN BEGIN
                    IF ABS(UndifinedQty) = TrackingAssignment."Remaining Quantity" THEN BEGIN
                        ReservationEntry."Quantity (Base)" := -TrackingAssignment."Remaining Quantity";
                        UndifinedQty := ABS(UndifinedQty) - ABS(ReservationEntry."Quantity (Base)");
                    END ELSE BEGIN
                        IF ABS(UndifinedQty) > TrackingAssignment."Remaining Quantity" THEN BEGIN
                            ReservationEntry."Quantity (Base)" := -TrackingAssignment."Remaining Quantity";
                            UndifinedQty := ABS(UndifinedQty) - ABS(TrackingAssignment."Remaining Quantity");
                        END ELSE BEGIN
                            ReservationEntry."Quantity (Base)" := -UndifinedQty;
                            UndifinedQty := ABS(UndifinedQty) - TrackingAssignment."Remaining Quantity";
                        END;
                    END;
                END ELSE BEGIN
                    ReservationEntry."Quantity (Base)" := -TrackingAssignment."Remaining Quantity";
                END;
                ReservationEntry.VALIDATE(ReservationEntry."Quantity (Base)");
                QtyAssigned := QtyAssigned + ABS(ReservationEntry."Quantity (Base)");
                IF (QtyAssigned <= TransferLine."Qty. to Ship") AND (ReservationEntry."Quantity (Base)" <> 0) THEN BEGIN
                    ReservationEntry.INSERT;
                    TrackingAssignment."Remaining Quantity" := TrackingAssignment."Remaining Quantity" - ABS(ReservationEntry."Quantity (Base)")
              ;
                    TrackingAssignment.MODIFY;
                    IF TrackingAssignment."Remaining Quantity" = 0 THEN
                        TrackingAssignment.DELETE;
                END;
            UNTIL TrackingAssignment.NEXT = 0;
    end;


    procedure "---For Item Reclass Journal---"();
    begin
    end;


    procedure AssignTrackingRCJ(var TemplateName: Code[20]; var BatchName: Code[20]; var DocumentNo: Code[20]);
    var
        TrackingAssignment: Record "Item Tracking Assignament";
    begin
        ReclassJournalLine.SETRANGE("Journal Template Name", TemplateName);
        ReclassJournalLine.SETRANGE("Journal Batch Name", BatchName);
        ReclassJournalLine.SETRANGE("Document No.", DocumentNo);
        IF ReclassJournalLine.FINDFIRST THEN
                REPEAT
                    ReclassJournalLine.TESTFIELD("Item No.");
                    ReclassJournalLine.TESTFIELD(Quantity);
                    ReclassJournalLine.TESTFIELD("Location Code");
                    ReclassJournalLine.TESTFIELD("New Location Code");
                    IF CheckforSerialandLotNumber(ReclassJournalLine."Item No.") THEN BEGIN
                        DeleteResevationsRCJ(ReclassJournalLine);
                        CheckInventoryRCJ(ReclassJournalLine);
                        "AssignSerial&LotnosRCJ"(ReclassJournalLine);
                    END;
                UNTIL ReclassJournalLine.NEXT = 0;

        IF TrackingAssignment.FINDFIRST THEN
            TrackingAssignment.DELETEALL;
    end;


    procedure DeleteResevationsRCJ(var ItemJournalLine: Record "Item Journal Line");
    var
        ResEntry: Record "Reservation Entry";
    begin
        ResEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
        ResEntry.SETRANGE("Source ID", ItemJournalLine."Journal Template Name");
        ResEntry.SETRANGE("Source Batch Name", ItemJournalLine."Journal Batch Name");
        ResEntry.SETRANGE("Source Ref. No.", ItemJournalLine."Line No.");
        ResEntry.SETRANGE("Location Code", ItemJournalLine."Location Code");
        IF ResEntry.FINDFIRST THEN
            ResEntry.DELETEALL;
    end;


    procedure CheckInventoryRCJ(var ItemJournalLine: Record "Item Journal Line");
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        "ILEQty.": Decimal;
    begin
        "ILEQty." := 0;
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
        ItemLedgerEntry.SETRANGE("Item No.", ItemJournalLine."Item No.");
        ItemLedgerEntry.SETRANGE("Location Code", ItemJournalLine."Location Code");
        ItemLedgerEntry.SETRANGE(Open, TRUE);
        IF ItemLedgerEntry.FINDFIRST THEN
                REPEAT
                    "ILEQty." := "ILEQty." + ItemLedgerEntry.Quantity;
                UNTIL ItemLedgerEntry.NEXT = 0;

        IF ("ILEQty." < ItemJournalLine.Quantity) AND ("ILEQty." <> 0) THEN BEGIN
            ItemJournalLine.Quantity := "ILEQty.";
            ItemJournalLine.VALIDATE(ItemJournalLine.Quantity);
            ItemJournalLine.MODIFY;
        END ELSE
            IF "ILEQty." = 0 THEN
                ItemJournalLine.DELETE;
    end;


    procedure "AssignSerial&LotnosRCJ"(var ItemJournalLine: Record "Item Journal Line");
    var
        ReservationEntry: Record "Reservation Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        Window: Dialog;
        "Document Name": Text[50];
        UndifinedQty: Decimal;
        ResEntry: Record "Reservation Entry";
        EntryNo: Integer;
        QtyAssigned: Decimal;
        TempItemLedgEntry: Record "Item Ledger Entry" temporary;
        TrackingAssignment: Record "Item Tracking Assignament";
        TrackingAssignmentOld: Record "Item Tracking Assignament";
        "EntryNo.": Integer;
    begin
        Window.OPEN('Document Name  #1###################\' +
                    'Document No.   #2###################\' +
                    'Line No.       #3###################\' +
                    'Item No.       #4###################\' +
                    'Serial No.     #5###################\' +
                    'Lot No.        #6###################', "Document Name", ReservationEntry."Source ID",
                    ReservationEntry."Source Ref. No.", ReservationEntry."Item No.", ReservationEntry."Serial No.",
                    ReservationEntry."Lot No.");

        UndifinedQty := ItemJournalLine.Quantity;

        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
        ItemLedgerEntry.SETRANGE("Item No.", ItemJournalLine."Item No.");
        ItemLedgerEntry.SETRANGE("Location Code", ItemJournalLine."Location Code");
        ItemLedgerEntry.SETRANGE(Open, TRUE);
        IF ItemLedgerEntry.FINDFIRST THEN
                REPEAT
                    TrackingAssignment.SETRANGE("ILE Entry No.", ItemLedgerEntry."Entry No.");
                    IF NOT TrackingAssignment.FINDFIRST THEN BEGIN
                        TrackingAssignment.TRANSFERFIELDS(ItemLedgerEntry);
                        IF TrackingAssignmentOld.FINDLAST THEN
                            "EntryNo." := TrackingAssignmentOld."Entry No."
                        ELSE
                            "EntryNo." := 0;
                        TrackingAssignment."Entry No." := "EntryNo." + 1;
                        TrackingAssignment.INSERT;
                    END;
                UNTIL ItemLedgerEntry.NEXT = 0;

        TrackingAssignment.RESET;
        TrackingAssignment.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
        TrackingAssignment.SETRANGE("Item No.", ItemJournalLine."Item No.");
        TrackingAssignment.SETRANGE("Location Code", ItemJournalLine."Location Code");
        TrackingAssignment.SETRANGE(Open, TRUE);
        TrackingAssignment.SETFILTER("Remaining Quantity", '<>%1', 0);
        IF TrackingAssignment.FINDFIRST THEN
            REPEAT
                    IF ResEntry.FINDLAST THEN
                        EntryNo := ResEntry."Entry No."
                    ELSE
                        EntryNo := 0;
                ReservationEntry."Entry No." := EntryNo + 1;
                ReservationEntry.Positive := FALSE;
                ReservationEntry."Item No." := ItemJournalLine."Item No.";
                Window.UPDATE(4, ReservationEntry."Item No.");

                ReservationEntry."Location Code" := ItemJournalLine."Location Code";
                ReservationEntry."Reservation Status" := ReservationEntry."Reservation Status"::Prospect;
                ReservationEntry.Description := ItemJournalLine.Description;
                ReservationEntry."Creation Date" := WORKDATE;
                ReservationEntry."Transferred from Entry No." := 0;
                ReservationEntry."Source Type" := 83;
                ReservationEntry."Source Subtype" := 4;
                ReservationEntry."Source ID" := ItemJournalLine."Journal Template Name";
                "Document Name" := 'Reclass Journal';
                Window.UPDATE(1, "Document Name");
                Window.UPDATE(2, ReservationEntry."Source ID");
                ReservationEntry."Source Batch Name" := ItemJournalLine."Journal Batch Name";
                ReservationEntry."Source Prod. Order Line" := 0;
                ReservationEntry."Source Ref. No." := ItemJournalLine."Line No.";
                Window.UPDATE(3, ReservationEntry."Source Ref. No.");
                ReservationEntry."Appl.-to Item Entry" := 0;
                ReservationEntry."Expected Receipt Date" := 0D;
                ReservationEntry."Shipment Date" := 0D;
                ReservationEntry."Serial No." := TrackingAssignment."Serial No.";
                Window.UPDATE(5, ReservationEntry."Serial No.");
                ReservationEntry."Created By" := USERID;
                ReservationEntry."Changed By" := '';
                ReservationEntry."Qty. per Unit of Measure" := ItemJournalLine."Qty. per Unit of Measure";
                ReservationEntry.Binding := 0;
                ReservationEntry."Suppressed Action Msg." := FALSE;
                ReservationEntry."Planning Flexibility" := ReservationEntry."Planning Flexibility"::Unlimited;
                ReservationEntry."Warranty Date" := TrackingAssignment."Warranty Date";
                ReservationEntry."Expiration Date" := TrackingAssignment."Expiration Date";
                ReservationEntry."New Serial No." := TrackingAssignment."Serial No.";
                ReservationEntry."Lot No." := TrackingAssignment."Lot No.";
                Window.UPDATE(6, ReservationEntry."Lot No.");
                ReservationEntry."New Lot No." := TrackingAssignment."Lot No.";
                ReservationEntry."Variant Code" := '';
                ReservationEntry.Correction := FALSE;
                ReservationEntry."Action Message Adjustment" := 0;
                IF (ReservationEntry."Serial No." = '') AND (ReservationEntry."Lot No." <> '') THEN BEGIN
                    IF ABS(UndifinedQty) = TrackingAssignment."Remaining Quantity" THEN BEGIN
                        ReservationEntry."Quantity (Base)" := -TrackingAssignment."Remaining Quantity";
                        UndifinedQty := ABS(UndifinedQty) - ABS(ReservationEntry."Quantity (Base)");
                    END ELSE BEGIN
                        IF ABS(UndifinedQty) > TrackingAssignment."Remaining Quantity" THEN BEGIN
                            ReservationEntry."Quantity (Base)" := -TrackingAssignment."Remaining Quantity";
                            UndifinedQty := ABS(UndifinedQty) - ABS(TrackingAssignment."Remaining Quantity");
                        END ELSE BEGIN
                            ReservationEntry."Quantity (Base)" := -UndifinedQty;
                            UndifinedQty := ABS(UndifinedQty) - TrackingAssignment."Remaining Quantity";
                        END;
                    END;
                END ELSE BEGIN
                    ReservationEntry."Quantity (Base)" := -TrackingAssignment."Remaining Quantity";
                END;
                ReservationEntry.VALIDATE(ReservationEntry."Quantity (Base)");
                QtyAssigned := QtyAssigned + ABS(ReservationEntry."Quantity (Base)");
                IF (QtyAssigned <= ItemJournalLine.Quantity) AND (ReservationEntry."Quantity (Base)" <> 0) THEN BEGIN
                    ReservationEntry.INSERT;
                    TrackingAssignment."Remaining Quantity" := TrackingAssignment."Remaining Quantity" - ABS(ReservationEntry."Quantity (Base)")
              ;
                    TrackingAssignment.MODIFY;
                    IF TrackingAssignment."Remaining Quantity" < 0 THEN
                        TrackingAssignment.DELETE;
                END;
            UNTIL TrackingAssignment.NEXT = 0;
    end;


    procedure CheckforSerialandLotNumberRCJ(var "ItemNo.": Code[20]): Boolean;
    var
        Item: Record Item;
    begin
        Item.GET("ItemNo.");
        IF Item."Item Tracking Code" <> '' THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;


    procedure "---For Consumption Journal---"();
    begin
    end;


    procedure ConsumptionItemTracking(var TemplateName: Code[20]; var BatchName: Code[20]);
    var
        TrackingAssignment: Record "Item Tracking Assignament";
    begin
        ConsumptionJournalLine.SETRANGE("Journal Template Name", TemplateName);
        ConsumptionJournalLine.SETRANGE("Journal Batch Name", BatchName);
        IF ConsumptionJournalLine.FINDFIRST THEN
                REPEAT
                    ConsumptionJournalLine.TESTFIELD("Item No.");
                    ConsumptionJournalLine.TESTFIELD(Quantity);
                    ConsumptionJournalLine.TESTFIELD("Location Code");
                    IF CheckforSerialandLotNumberCon(ConsumptionJournalLine."Item No.") THEN BEGIN
                        "DeleteCons.ItemTrackingLines"(ConsumptionJournalLine);
                        CheckConsumptionInventory(ConsumptionJournalLine);
                        "AssignSerial&LotnosCon"(ConsumptionJournalLine);
                    END;
                UNTIL ConsumptionJournalLine.NEXT = 0;

        IF TrackingAssignment.FINDFIRST THEN
            TrackingAssignment.DELETEALL;
    end;


    procedure "DeleteCons.ItemTrackingLines"(var ItemJournalLine: Record "Item Journal Line");
    var
        ResEntry: Record "Reservation Entry";
    begin
        ResEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
        ResEntry.SETRANGE("Source ID", ItemJournalLine."Journal Template Name");
        ResEntry.SETRANGE("Source Batch Name", ItemJournalLine."Journal Batch Name");
        ResEntry.SETRANGE("Source Ref. No.", ItemJournalLine."Line No.");
        ResEntry.SETRANGE("Location Code", ItemJournalLine."Location Code");
        IF ResEntry.FINDFIRST THEN
            ResEntry.DELETEALL;
    end;


    procedure CheckConsumptionInventory(var ItemJournalLine: Record "Item Journal Line");
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        "ILEQty.": Decimal;
    begin
        "ILEQty." := 0;
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
        ItemLedgerEntry.SETRANGE("Item No.", ItemJournalLine."Item No.");
        ItemLedgerEntry.SETRANGE("Location Code", ItemJournalLine."Location Code");
        ItemLedgerEntry.SETRANGE(Open, TRUE);
        IF ItemLedgerEntry.FINDFIRST THEN
            REPEAT
                    "ILEQty." := "ILEQty." + ItemLedgerEntry.Quantity;
            UNTIL ItemLedgerEntry.NEXT = 0;

        IF ("ILEQty." < ItemJournalLine.Quantity) AND ("ILEQty." <> 0) THEN BEGIN
            ItemJournalLine.Quantity := "ILEQty.";
            ItemJournalLine.VALIDATE(ItemJournalLine.Quantity);
            ItemJournalLine.MODIFY;
        END ELSE
            IF "ILEQty." = 0 THEN
                ItemJournalLine.DELETE;
    end;


    procedure CheckforSerialandLotNumberCon(var "ItemNo.": Code[20]): Boolean;
    var
        Item: Record Item;
    begin
        Item.GET("ItemNo.");
        IF Item."Item Tracking Code" <> '' THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;


    procedure "AssignSerial&LotnosCon"(var ItemJournalLine: Record "Item Journal Line");
    var
        ReservationEntry: Record "Reservation Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        Window: Dialog;
        "Document Name": Text[50];
        UndifinedQty: Decimal;
        ResEntry: Record "Reservation Entry";
        EntryNo: Integer;
        QtyAssigned: Decimal;
        TempItemLedgEntry: Record "Item Ledger Entry" temporary;
        TrackingAssignment: Record "Item Tracking Assignament";
        TrackingAssignmentOld: Record "Item Tracking Assignament";
        "EntryNo.": Integer;
    begin
        Window.OPEN('Document Name  #1###################\' +
                    'Document No.   #2###################\' +
                    'Line No.       #3###################\' +
                    'Item No.       #4###################\' +
                    'Serial No.     #5###################\' +
                    'Lot No.        #6###################', "Document Name", ReservationEntry."Source ID",
                    ReservationEntry."Source Ref. No.", ReservationEntry."Item No.", ReservationEntry."Serial No.",
                    ReservationEntry."Lot No.");

        UndifinedQty := ItemJournalLine.Quantity;

        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
        ItemLedgerEntry.SETRANGE("Item No.", ItemJournalLine."Item No.");
        ItemLedgerEntry.SETRANGE("Location Code", ItemJournalLine."Location Code");
        ItemLedgerEntry.SETRANGE(Open, TRUE);
        ItemLedgerEntry.SETRANGE("ITL Doc No.", ItemJournalLine."Order No.");
        ItemLedgerEntry.SETRANGE("ITL Doc Line No.", ItemJournalLine."Order Line No.");
        ItemLedgerEntry.SETRANGE("ITL Doc Ref Line No.", ItemJournalLine."Prod. Order Comp. Line No.");
        IF ItemLedgerEntry.FINDFIRST THEN
            REPEAT
                    TrackingAssignment.SETRANGE("ILE Entry No.", ItemLedgerEntry."Entry No.");
                IF NOT TrackingAssignment.FINDFIRST THEN BEGIN
                    TrackingAssignment.TRANSFERFIELDS(ItemLedgerEntry);
                    IF TrackingAssignmentOld.FINDLAST THEN
                        "EntryNo." := TrackingAssignmentOld."Entry No."
                    ELSE
                        "EntryNo." := 0;
                    TrackingAssignment."Entry No." := "EntryNo." + 1;
                    TrackingAssignment.INSERT;
                END;
            UNTIL ItemLedgerEntry.NEXT = 0;

        TrackingAssignment.RESET;
        TrackingAssignment.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
        TrackingAssignment.SETRANGE("Item No.", ItemJournalLine."Item No.");
        TrackingAssignment.SETRANGE("Location Code", ItemJournalLine."Location Code");
        TrackingAssignment.SETRANGE(Open, TRUE);
        TrackingAssignment.SETFILTER("Remaining Quantity", '<>%1', 0);
        IF TrackingAssignment.FINDFIRST THEN
                REPEAT
                    IF ResEntry.FINDLAST THEN
                        EntryNo := ResEntry."Entry No."
                    ELSE
                        EntryNo := 0;
                    ReservationEntry."Entry No." := EntryNo + 1;
                    ReservationEntry.Positive := FALSE;
                    ReservationEntry."Item No." := ItemJournalLine."Item No.";
                    Window.UPDATE(4, ReservationEntry."Item No.");

                    ReservationEntry."Location Code" := ItemJournalLine."Location Code";
                    ReservationEntry."Reservation Status" := ReservationEntry."Reservation Status"::Prospect;
                    ReservationEntry.Description := ItemJournalLine.Description;
                    ReservationEntry."Creation Date" := WORKDATE;
                    ReservationEntry."Transferred from Entry No." := 0;
                    ReservationEntry."Source Type" := 83;
                    ReservationEntry."Source Subtype" := 5;
                    ReservationEntry."Source ID" := ItemJournalLine."Journal Template Name";
                    "Document Name" := 'Consumption Journal';
                    Window.UPDATE(1, "Document Name");
                    Window.UPDATE(2, ReservationEntry."Source ID");
                    ReservationEntry."Source Batch Name" := ItemJournalLine."Journal Batch Name";
                    ReservationEntry."Source Prod. Order Line" := 0;
                    ReservationEntry."Source Ref. No." := ItemJournalLine."Line No.";
                    Window.UPDATE(3, ReservationEntry."Source Ref. No.");
                    ReservationEntry."Appl.-to Item Entry" := 0;
                    ReservationEntry."Expected Receipt Date" := 0D;
                    ReservationEntry."Shipment Date" := WORKDATE;
                    ReservationEntry."Serial No." := TrackingAssignment."Serial No.";
                    Window.UPDATE(5, ReservationEntry."Serial No.");
                    ReservationEntry."Created By" := USERID;
                    ReservationEntry."Changed By" := '';
                    ReservationEntry."Qty. per Unit of Measure" := ItemJournalLine."Qty. per Unit of Measure";
                    ReservationEntry.Binding := 0;
                    ReservationEntry."Suppressed Action Msg." := FALSE;
                    ReservationEntry."Planning Flexibility" := ReservationEntry."Planning Flexibility"::Unlimited;
                    ReservationEntry."Warranty Date" := TrackingAssignment."Warranty Date";
                    ReservationEntry."Expiration Date" := TrackingAssignment."Expiration Date";
                    ReservationEntry."New Serial No." := TrackingAssignment."Serial No.";
                    ReservationEntry."Lot No." := TrackingAssignment."Lot No.";
                    Window.UPDATE(6, ReservationEntry."Lot No.");
                    ReservationEntry."New Lot No." := TrackingAssignment."Lot No.";
                    ReservationEntry."Variant Code" := '';
                    ReservationEntry.Correction := FALSE;
                    ReservationEntry."Action Message Adjustment" := 0;
                    IF (ReservationEntry."Serial No." = '') AND (ReservationEntry."Lot No." <> '') THEN BEGIN
                        IF ABS(UndifinedQty) = TrackingAssignment."Remaining Quantity" THEN BEGIN
                            ReservationEntry."Quantity (Base)" := -TrackingAssignment."Remaining Quantity";
                            UndifinedQty := ABS(UndifinedQty) - ABS(ReservationEntry."Quantity (Base)");
                        END ELSE BEGIN
                            IF ABS(UndifinedQty) > TrackingAssignment."Remaining Quantity" THEN BEGIN
                                ReservationEntry."Quantity (Base)" := -TrackingAssignment."Remaining Quantity";
                                UndifinedQty := ABS(UndifinedQty) - ABS(TrackingAssignment."Remaining Quantity");
                            END ELSE BEGIN
                                ReservationEntry."Quantity (Base)" := -UndifinedQty;
                                UndifinedQty := ABS(UndifinedQty) - TrackingAssignment."Remaining Quantity";
                            END;
                        END;
                    END ELSE BEGIN
                        ReservationEntry."Quantity (Base)" := -TrackingAssignment."Remaining Quantity";
                    END;
                    ReservationEntry.VALIDATE(ReservationEntry."Quantity (Base)");
                    QtyAssigned := QtyAssigned + ABS(ReservationEntry."Quantity (Base)");
                    IF (QtyAssigned <= ItemJournalLine.Quantity) AND (ReservationEntry."Quantity (Base)" <> 0) THEN BEGIN
                        ReservationEntry.INSERT;
                        TrackingAssignment."Remaining Quantity" := TrackingAssignment."Remaining Quantity" - ABS(ReservationEntry."Quantity (Base)")
                  ;
                        TrackingAssignment.MODIFY;
                        IF TrackingAssignment."Remaining Quantity" = 0 THEN
                            TrackingAssignment.DELETE;
                    END;
                UNTIL TrackingAssignment.NEXT = 0;
    end;


    procedure "---For Purchase Orders---"();
    begin
    end;


    procedure AssignPurchaseTrackingLines(var Rec: Record "Purchase Header");
    var
        PurchaseLine: Record "Purchase Line";
        PurchaseHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        "LotNo.": Code[10];
        Window: Dialog;
    begin
        Window.OPEN('Enter Lot No. #1#################');
       // Window.INPUT(1, "LotNo.");//EFFUPG  Depreciated input functionality

        PurchaseLine.SETRANGE(Type, PurchLine.Type::Item);
        PurchaseLine.SETRANGE("Document No.", Rec."No.");
        PurchaseLine.SETFILTER("Qty. to Receive", '<>%1', 0);
        IF PurchaseLine.FINDFIRST THEN BEGIN
                                           REPEAT
                                               IF CheckforSerialandLotNumberPur(PurchaseLine."No.", PurchaseLine."Location Code") THEN BEGIN
                                                   DeletePurchaseLines(PurchaseLine);
                                                   "CheckforSerialorLotNo."(PurchaseLine, "LotNo.");
                                               END;
                                           UNTIL PurchaseLine.NEXT = 0
        END;
        MESSAGE('Item Tracking Lines are Assigned');
    end;


    procedure DeletePurchaseLines(var PurchaseLine: Record "Purchase Line");
    var
        ResEntry: Record "Reservation Entry";
    begin
        ResEntry.SETRANGE("Source Type", DATABASE::"Purchase Line");
        ResEntry.SETRANGE("Source ID", PurchaseLine."Document No.");
        ResEntry.SETRANGE("Source Ref. No.", PurchaseLine."Line No.");
        ResEntry.SETRANGE("Location Code", PurchaseLine."Location Code");
        IF ResEntry.FINDFIRST THEN
            ResEntry.DELETEALL;
    end;


    procedure PurchaseTrackingLines(var PurchaseLine: Record "Purchase Line"; var SerialNos: Code[10]; var LotNos: Code[10]);
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ReservationEntry: Record "Reservation Entry";
        "Qty.Assigned": Decimal;
        "RequestedQty.": Decimal;
        "AssignedQty.": Decimal;
        "LotQty.": Decimal;
        Window: Dialog;
        "Document Name": Text[50];
        NoSeriesMgt: Codeunit 396;
        Item: Record Item;
    begin
        Window.OPEN('Document Name  #1####################\' +
                    'Document No.   #2####################\' +
                    'Line No.       #3####################\' +
                    'Item No.       #4####################\' +
                    'Serial No.     #5####################\' +
                    'Lot No.        #6####################', "Document Name", ReservationEntry."Source ID",
                    ReservationEntry."Source Ref. No.", ReservationEntry."Item No.", ReservationEntry."Serial No.",
                    ReservationEntry."Lot No.");
        ReservationEntry.INIT;
        IF ReservationEntry.FINDLAST THEN
            ReservationEntry."Entry No." := ReservationEntry."Entry No." + 1
        ELSE
            ReservationEntry."Entry No." := 1;
        "Document Name" := 'Purchase Order';
        Window.UPDATE(1, "Document Name");
        ReservationEntry.Positive := TRUE;
        ReservationEntry."Item No." := PurchaseLine."No.";
        Window.UPDATE(4, ReservationEntry."Item No.");
        ReservationEntry."Location Code" := PurchaseLine."Location Code";
        ReservationEntry."Serial No." := SerialNos;
        ReservationEntry."Lot No." := LotNos;
        Window.UPDATE(5, ReservationEntry."Serial No.");
        Window.UPDATE(6, ReservationEntry."Lot No.");
        ReservationEntry."Reservation Status" := ReservationEntry."Reservation Status"::Surplus;
        ReservationEntry.Description := PurchaseLine.Description;
        ReservationEntry."Creation Date" := WORKDATE;
        ReservationEntry."Source Type" := DATABASE::"Purchase Line";
        ReservationEntry."Source ID" := PurchaseLine."Document No.";
        Window.UPDATE(2, ReservationEntry."Source ID");
        ReservationEntry."Source Ref. No." := PurchaseLine."Line No.";
        Window.UPDATE(3, ReservationEntry."Source Ref. No.");
        SLEEP(100);
        ReservationEntry."Source Subtype" := 1;
        ReservationEntry."Shipment Date" := WORKDATE;
        ReservationEntry."Source Batch Name" := '';
        ReservationEntry."Created By" := USERID;
        ReservationEntry."Expected Receipt Date" := WORKDATE;
        ReservationEntry."Source Prod. Order Line" := 0;
        ReservationEntry.Binding := ReservationEntry.Binding::" ";
        ReservationEntry."Qty. per Unit of Measure" := PurchaseLine."Qty. per Unit of Measure";
        ReservationEntry."Planning Flexibility" := ReservationEntry."Planning Flexibility"::Unlimited;
        IF ReservationEntry."Serial No." = '' THEN BEGIN
            ReservationEntry."Quantity (Base)" := PurchaseLine.Quantity;
            ReservationEntry.VALIDATE(ReservationEntry."Quantity (Base)");
            ReservationEntry.INSERT;
        END ELSE BEGIN
            "Qty.Assigned" := PurchaseLine."Qty. to Receive";
                     REPEAT
                         Item.GET(ReservationEntry."Item No.");
                         ReservationEntry."Serial No." := NoSeriesMgt.GetNextNo(Item."Serial Nos.", WORKDATE, TRUE);
                         ReservationEntry."Quantity (Base)" := 1;
                         ReservationEntry.VALIDATE(ReservationEntry."Quantity (Base)");
                         "Qty.Assigned" := "Qty.Assigned" - ABS(ReservationEntry."Quantity (Base)");
                     UNTIL "Qty.Assigned" = 0;
        END;

        COMMIT;
    end;


    procedure "CheckforSerialorLotNo."(var PurchaseLine: Record "Purchase Line"; var LotNo: Code[10]);
    var
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        SerialNos: Code[10];
        LotNos: Code[10];
        Window: Dialog;
    begin
        Item.SETRANGE("No.", PurchaseLine."No.");
        IF Item.FINDFIRST THEN
            IF ItemTrackingCode.GET(Item."Item Tracking Code") THEN BEGIN
                IF (ItemTrackingCode."Lot Specific Tracking") THEN BEGIN
                    SerialNos := '';
                    LotNos := LotNo;
                    PurchaseTrackingLines(PurchaseLine, SerialNos, LotNos);
                END ELSE
                    IF (ItemTrackingCode."Lot Specific Tracking") AND (ItemTrackingCode."SN Transfer Tracking") THEN BEGIN
                        SerialNos := '';
                        LotNos := LotNo;
                        PurchaseTrackingLines(PurchaseLine, SerialNos, LotNos);
                    END ELSE
                        IF (ItemTrackingCode."SN Transfer Tracking") THEN BEGIN
                            SerialNos := '';
                            LotNos := '';
                            PurchaseTrackingLines(PurchaseLine, SerialNos, LotNos);
                        END;
            END;
    end;


    procedure CheckforSerialandLotNumberPur(var "ItemNo.": Code[20]; var LocationCode: Code[20]): Boolean;
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemTrackingCode: Record "Item Tracking Code";
    begin
        Item.GET("ItemNo.");
        IF Item."Item Tracking Code" <> '' THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;
}

