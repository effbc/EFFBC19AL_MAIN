codeunit 60015 "Assign Batch No's for Consume"
{



    trigger OnRun();
    begin
    end;

    var
        Item: Record Item;
        InvSetup: Record "Inventory Setup";
        ItemLedgerEntry: Record "Item Ledger Entry";
        MaterialIssueLine: Record "Material Issues Line";
        TrackingSpecification: Record "Mat.Issue Track. Specification";
        TrackingSpecification2: Record "Mat.Issue Track. Specification";
        TempTrackingSpecification: Record "Mat.Issue Track. Specification";
        BatchndSerialNos: Record "Batch and Serial No's";
        CheckQty: Decimal;
        AssignQty: Decimal;
        RemainingQty: Decimal;
        ActualQty: Decimal;
        QtytoReceive: Decimal;
        ConsumptionJournalLine: Record "Item Journal Line";

    procedure ConsumptionItemTracking(var TemplateName: Code[20]; var BatchName: Code[20]);
    var
        TrackingAssignment: Record "Item Tracking Assignament";
    begin
        ConsumptionJournalLine.SETRANGE("Journal Template Name", TemplateName);
        ConsumptionJournalLine.SETRANGE("Journal Batch Name", BatchName);
        IF ConsumptionJournalLine.FINDSET THEN
            REPEAT
                ConsumptionJournalLine.TESTFIELD("Item No.");
                ConsumptionJournalLine.TESTFIELD(Quantity);
                ConsumptionJournalLine.TESTFIELD("Location Code");
                IF CheckSerialndBatchNo(ConsumptionJournalLine."Item No.") THEN BEGIN
                    DeleteTrackingSpecifications(ConsumptionJournalLine);
                    CheckInventory(ConsumptionJournalLine);
                    AssignTrackingSpecifications(ConsumptionJournalLine);
                END;
            UNTIL ConsumptionJournalLine.NEXT = 0;

        IF TrackingAssignment.FINDFIRST THEN
            TrackingAssignment.DELETEALL;
    end;


    procedure CheckSerialndBatchNo(var "ItemNo.": Code[20]): Boolean;
    var
        Item: Record Item;
    begin
        Item.GET("ItemNo.");
        IF Item."Item Tracking Code" <> '' THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;


    procedure DeleteTrackingSpecifications(var ItemJournalLine: Record "Item Journal Line");
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

    procedure CheckInventory(var ItemJournalLine: Record "Item Journal Line");
    var
        QualityItemLedgerEntry: Record "Quality Item Ledger Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        "ILEQty.": Decimal;
    begin
        "ILEQty." := 0;
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
        ItemLedgerEntry.SETRANGE("Item No.", ItemJournalLine."Item No.");
        ItemLedgerEntry.SETRANGE("Location Code", ItemJournalLine."Location Code");
        ItemLedgerEntry.SETRANGE("ITL Doc No.", ItemJournalLine."Order No.");
        ItemLedgerEntry.SETRANGE("ITL Doc Line No.", ItemJournalLine."Order Line No.");
        ItemLedgerEntry.SETRANGE("ITL Doc Ref Line No.", ItemJournalLine."Prod. Order Comp. Line No.");
        ItemLedgerEntry.SETRANGE(Open, TRUE);
        IF ItemLedgerEntry.FINDSET THEN
            REPEAT
                QualityItemLedgerEntry.SETRANGE("Entry No.", ItemLedgerEntry."Entry No.");
                IF NOT QualityItemLedgerEntry.FINDFIRST THEN
                    "ILEQty." := "ILEQty." + ItemLedgerEntry.Quantity;
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


    procedure AssignTrackingSpecifications(var ItemJournalLine: Record "Item Journal Line");
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
        ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Location Code",
                       Open, "Lot No.", "Serial No.", "ITL Doc No.", "ITL Doc Line No.", "ITL Doc Ref Line No.");
        ItemLedgerEntry.SETRANGE("Item No.", ItemJournalLine."Item No.");
        ItemLedgerEntry.SETRANGE("Location Code", ItemJournalLine."Location Code");
        ItemLedgerEntry.SETRANGE(Open, TRUE);
        ItemLedgerEntry.SETRANGE("ITL Doc No.", ItemJournalLine."Order No.");
        ItemLedgerEntry.SETRANGE("ITL Doc Line No.", ItemJournalLine."Order Line No.");
        ItemLedgerEntry.SETRANGE("ITL Doc Ref Line No.", ItemJournalLine."Prod. Order Comp. Line No.");
        ItemLedgerEntry.SETFILTER("Remaining Quantity", '>%1', 0); //b2bssr

        IF ItemLedgerEntry.FINDSET THEN
            REPEAT
                TrackingAssignment.RESET;
                IF TrackingAssignment.FINDLAST THEN
                    "EntryNo." := TrackingAssignment."Entry No."
                ELSE
                    "EntryNo." := 0;
                TrackingAssignment."Entry No." := "EntryNo." + 1;
                TrackingAssignment.TRANSFERFIELDS(ItemLedgerEntry);
                TrackingAssignment.INSERT;
            UNTIL ItemLedgerEntry.NEXT = 0;

        TrackingAssignment.RESET;
        TrackingAssignment.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
        TrackingAssignment.SETRANGE("Item No.", ItemJournalLine."Item No.");
        TrackingAssignment.SETRANGE("Location Code", ItemJournalLine."Location Code");
        TrackingAssignment.SETRANGE(Open, TRUE);
        TrackingAssignment.SETFILTER("Remaining Quantity", '<>%1', 0);
        IF TrackingAssignment.FINDSET THEN
            REPEAT
                ReservationEntry.RESET;
                IF ReservationEntry.FINDLAST THEN
                    EntryNo := ReservationEntry."Entry No."
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
                ReservationEntry."Appl.-to Item Entry" := TrackingAssignment."ILE Entry No.";
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
                    TrackingAssignment."Remaining Quantity" :=
                       TrackingAssignment."Remaining Quantity" - ABS(ReservationEntry."Quantity (Base)");
                    TrackingAssignment.MODIFY;
                    IF TrackingAssignment."Remaining Quantity" = 0 THEN
                        TrackingAssignment.DELETE;
                END;
            UNTIL TrackingAssignment.NEXT = 0;
    end;
}

