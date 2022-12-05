codeunit 60041 "Schedule Line Reserve"
{

    trigger OnRun();
    begin
    end;

    var
        Location: Record Location;
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        ReservEngineMgt: Codeunit 99000831;
        ReservMgt1: Codeunit "Custom Events";
        ReservMgt: codeunit "Reservation Management";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        CreatePick: Codeunit "Create Pick";
        Blocked: Boolean;
        SetFromType: Option " ",Sales,"Requisition Line",Purchase,"Item Journal","BOM Journal","Item Ledger Entry";
        SetFromSubtype: Integer;
        SetFromID: Code[20];
        SetFromBatchName: Code[10];
        SetFromProdOrderLine: Integer;
        SetFromRefNo: Integer;
        SetFromVariantCode: Code[10];
        SetFromLocationCode: Code[10];
        SetFromSerialNo: Code[20];
        SetFromLotNo: Code[20];
        SetFromQtyPerUOM: Decimal;
        ApplySpecificItemTracking: Boolean;
        OverruleItemTracking: Boolean;
        DeleteItemTracking: Boolean;
        ItemTrkgAlreadyOverruled: Boolean;
        Text000: Label 'Reserved quantity cannot be greater than %1';
        Text002: Label 'must be filled in when a quantity is reserved';
        Text003: Label 'must not be filled in when a quantity is reserved';
        Text004: Label 'must not be changed when a quantity is reserved';
        Text005: Label 'Codeunit is not initialized correctly.';


    procedure VerifyChange(var NewScheduleComp: Record Schedule2; var OldScheduleComp: Record Schedule2);
    var
        ScheduleComp: Record Schedule2;
        TempReservEntry: Record "Reservation Entry";
        ShowError: Boolean;
        HasError: Boolean;
    begin
        IF NewScheduleComp."Line No." = 0 THEN
            IF NOT ScheduleComp.GET(
                     NewScheduleComp."No.", NewScheduleComp."Line No.")
            THEN
                EXIT;

        NewScheduleComp.CALCFIELDS("Reserved Qty. (Base)");
        ShowError := NewScheduleComp."Reserved Qty. (Base)" <> 0;

        IF (NewScheduleComp."No." <> OldScheduleComp."No.") THEN
            IF ShowError THEN
                NewScheduleComp.FIELDERROR("No.", Text004)
            ELSE
                HasError := TRUE;


        IF NewScheduleComp."Line No." <> OldScheduleComp."Line No." THEN
            HasError := TRUE;


        IF HasError THEN
            IF (NewScheduleComp."Line No." <> OldScheduleComp."Line No.") OR
               FindReservEntry(NewScheduleComp, TempReservEntry)
            THEN BEGIN
                IF (NewScheduleComp."Line No." <> OldScheduleComp."Line No.") THEN BEGIN
                    ReservMgt1.SetDelChallanLine(OldScheduleComp);
                    ReservMgt.DeleteReservEntries(TRUE, 0);
                    ReservMgt1.SetDelChallanLine(NewScheduleComp);
                END ELSE BEGIN
                    ReservMgt1.SetDelChallanLine(NewScheduleComp);
                    ReservMgt.DeleteReservEntries(TRUE, 0);
                END;
                //ReservMgt.AutoTrack(NewDelChallanLine."Remaining Quantity (Base)");
                ReservMgt.AutoTrack(NewScheduleComp."Outstanding Qty.(Base)");
            END;
    end;


    procedure FilterReservFor(var FilterReservEntry: Record "Reservation Entry"; ScheduleComp: Record Schedule2);
    begin
        FilterReservEntry.SETRANGE("Source Type", DATABASE::Schedule2);
        FilterReservEntry.SETRANGE("Source Subtype", FilterReservEntry."Source Subtype"::"0");
        FilterReservEntry.SETRANGE("Source ID", ScheduleComp."Document No.");
        FilterReservEntry.SETRANGE("Source Batch Name", '');
        FilterReservEntry.SETRANGE("Source Prod. Order Line", ScheduleComp."Document Line No.");
        FilterReservEntry.SETRANGE("Source Ref. No.", ScheduleComp."Line No.");
    end;


    procedure FindReservEntry(ScheduleComp: Record Schedule2; var ReservEntry: Record "Reservation Entry"): Boolean;
    begin
        ReservEngineMgt.InitFilterAndSortingLookupFor(ReservEntry, FALSE);
        FilterReservFor(ReservEntry, ScheduleComp);
        EXIT(ReservEntry.FINDLAST);
    end;


    procedure ReservEntryExist(ScheduleComp: Record Schedule2): Boolean;
    var
        ReservEntry: Record "Reservation Entry";
    begin
        ReservEngineMgt.InitFilterAndSortingLookupFor(ReservEntry, FALSE);
        FilterReservFor(ReservEntry, ScheduleComp);
        EXIT(NOT ReservEntry.ISEMPTY);
    end;


    procedure TransferDelLineToItemJnlLine(var ScheduleComp: Record Schedule2; var ItemJnlLine: Record "Item Journal Line"; TransferQty: Decimal; var CheckApplFromItemEntry: Boolean): Decimal;
    var
        OldReservEntry: Record "Reservation Entry";
        DelChallanHeadLRec: Record "Sales Header";
    begin
        //DelChallanHeadLRec.TESTFIELD("Location Code");

        IF NOT FindReservEntry(ScheduleComp, OldReservEntry) THEN
            EXIT(TransferQty);
        OldReservEntry.Lock;

        // Handle Item Tracking on drop shipment:
        CLEAR(CreateReservEntry);
        IF ApplySpecificItemTracking AND (ItemJnlLine."Applies-to Entry" <> 0) THEN BEGIN
            CreateReservEntry.SetApplyToEntryNo(ItemJnlLine."Applies-to Entry");
            CheckApplFromItemEntry := FALSE;
        END;

        IF OverruleItemTracking THEN
            IF (ItemJnlLine."Serial No." <> '') OR (ItemJnlLine."Lot No." <> '') THEN BEGIN
                CreateReservEntry.SetNewSerialLotNo(ItemJnlLine."Serial No.", ItemJnlLine."Lot No.");
                CreateReservEntry.SetOverruleItemTracking(NOT ItemTrkgAlreadyOverruled);
                // Try to match against Item Tracking on the sales order line:
                OldReservEntry.SETRANGE("Serial No.", ItemJnlLine."Serial No.");
                OldReservEntry.SETRANGE("Lot No.", ItemJnlLine."Lot No.");
                IF OldReservEntry.ISEMPTY THEN
                    EXIT(TransferQty);
            END;

        ItemJnlLine.TESTFIELD("Item No.", ScheduleComp."No.");
        ItemJnlLine.TESTFIELD("Location Code", ScheduleComp."Location Code");

        IF TransferQty = 0 THEN
            EXIT;

        IF ItemJnlLine."Invoiced Quantity" <> 0 THEN
            CreateReservEntry.SetUseQtyToInvoice(TRUE);

        IF ReservEngineMgt.InitRecordSet(OldReservEntry) THEN BEGIN
            REPEAT
                OldReservEntry.TESTFIELD("Item No.", ScheduleComp."No.");
                OldReservEntry.TESTFIELD("Location Code", ScheduleComp."Location Code");

                IF CheckApplFromItemEntry THEN BEGIN
                    OldReservEntry.TESTFIELD("Appl.-from Item Entry");
                    CreateReservEntry.SetApplyFromEntryNo(OldReservEntry."Appl.-from Item Entry");
                END;

                TransferQty := CreateReservEntry.TransferReservEntry(DATABASE::"Item Journal Line",
                  ItemJnlLine."Entry Type", ItemJnlLine."Journal Template Name",
                  ItemJnlLine."Journal Batch Name", 0, ItemJnlLine."Line No.",
                  ItemJnlLine."Qty. per Unit of Measure", OldReservEntry, TransferQty);

            UNTIL (ReservEngineMgt.NEXTRecord(OldReservEntry) = 0) OR (TransferQty = 0);
            CheckApplFromItemEntry := FALSE;
        END;
        EXIT(TransferQty);
    end;


    procedure CallItemTracking(var ScheduleComp: Record Schedule2);
    var
        TrackingSpecification: Record "Tracking Specification";
        ItemTrackingForm: Page "Item Tracking Lines";
    begin
        InitTrackingSpecification(ScheduleComp, TrackingSpecification);
        ItemTrackingForm.SetSourceSpec(TrackingSpecification, WORKDATE);//EFFUPG
        ItemTrackingForm.RUNMODAL;
    end;


    procedure InitTrackingSpecification(var ScheduleComp: Record Schedule2; var TrackingSpecification: Record "Tracking Specification");
    var
        DelChallanHeadLRec: Record "Sales Header";
    begin

        TrackingSpecification.INIT;
        TrackingSpecification."Source Type" := DATABASE::Schedule2;
        TrackingSpecification."Item No." := ScheduleComp."No.";
        TrackingSpecification."Location Code" := ScheduleComp."Location Code";
        TrackingSpecification.Description := ScheduleComp.Description;

        TrackingSpecification."Source Subtype" := 0;
        TrackingSpecification."Source ID" := ScheduleComp."Document No.";
        TrackingSpecification."Source Batch Name" := '';
        TrackingSpecification."Source Prod. Order Line" := ScheduleComp."Document Line No.";
        TrackingSpecification."Source Ref. No." := ScheduleComp."Line No.";
        TrackingSpecification."Quantity (Base)" := ScheduleComp."Quantity(Base)";
        TrackingSpecification."Qty. per Unit of Measure" := ScheduleComp."Qty. per Unit of Measure";


        TrackingSpecification."Qty. to Handle (Base)" := ScheduleComp."Qty. to ship (Base)";
        TrackingSpecification."Quantity Handled (Base)" := ScheduleComp."Quantity(Base)";
        ;
        TrackingSpecification."Qty. to Handle" := ScheduleComp."Qty. to ship (Base)";
    end;


    procedure RenameLine(var NewSalesLine: Record "Sales Line"; var OldSalesLine: Record "Sales Line");
    begin
        ReservEngineMgt.RenamePointer(DATABASE::"Sales Line",
          OldSalesLine."Document Type",
          OldSalesLine."Document No.",
          '',
          0,
          OldSalesLine."Line No.",
          NewSalesLine."Document Type",
          NewSalesLine."Document No.",
          '',
          0,
          NewSalesLine."Line No.");
    end;


    procedure DeleteLineConfirm(var ScheduleComp: Record Schedule2): Boolean;
    begin
        IF NOT ReservEntryExist(ScheduleComp) THEN
            EXIT(TRUE);

        ReservMgt1.SetDelChallanLine(ScheduleComp);
        IF ReservMgt.DeleteItemTrackingConfirm THEN
            DeleteItemTracking := TRUE;

        EXIT(DeleteItemTracking);
    end;


    procedure DeleteLine(var ScheduleComp: Record Schedule2);
    begin
        ReservMgt1.SetDelChallanLine(ScheduleComp);
        IF DeleteItemTracking THEN
            ReservMgt.SetItemTrackingHandling(1); // Allow Deletion
        ReservMgt.DeleteReservEntries(TRUE, 0);
        ScheduleComp.CALCFIELDS("Reserved Qty. (Base)");
    end;


    procedure VerifyQuantity(var NewScheduleComp: Record Schedule2; var OldScheduleComp: Record Schedule2);
    var
        ScheduleComp: Record Schedule2;
    begin
        IF Blocked THEN
            EXIT;

        IF NewScheduleComp."Line No." = OldScheduleComp."Line No." THEN
            IF NewScheduleComp."Quantity(Base)" = OldScheduleComp."Quantity(Base)" THEN
                EXIT;
        IF NewScheduleComp."Line No." = 0 THEN
            IF NOT ScheduleComp.GET(NewScheduleComp."No.", NewScheduleComp."Line No.") THEN
                EXIT;

        ReservMgt1.SetDelChallanLine(NewScheduleComp);
        IF NewScheduleComp."Qty. per Unit of Measure" <> OldScheduleComp."Qty. per Unit of Measure" THEN
            ReservMgt.ModifyUnitOfMeasure;

        IF NewScheduleComp."Outstanding Qty.(Base)" * OldScheduleComp."Outstanding Qty.(Base)" < 0 THEN
            //IF "Remaining Quantity (Base)" * OldDelChallanLine."Remaining Quantity (Base)" < 0 THEN
            ReservMgt.DeleteReservEntries(TRUE, 0)
        ELSE
            ReservMgt.DeleteReservEntries(FALSE, NewScheduleComp."Outstanding Qty.(Base)");
        ReservMgt.ClearSurplus;
        ReservMgt.AutoTrack(NewScheduleComp."Outstanding Qty.(Base)");
    end;
}

