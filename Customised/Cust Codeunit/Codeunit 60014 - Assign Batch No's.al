codeunit 60014 "Assign Batch No's"
{
    // version MI1.0

    TableNo = "Material Issues Header";

    trigger OnRun();
    begin
        Manual := FALSE;
        BatchndSerialNos.DELETEALL;
        Rec.TESTFIELD("No.");
        Rec.TESTFIELD("Transfer-from Code");
        Rec.TESTFIELD("Transfer-to Code");
        Rec.TESTFIELD(Status, Rec.Status::Released);
        Location := Rec."Transfer-from Code";
        MaterialIssueLine.SETRANGE("Document No.", Rec."No.");
        //MaterialIssueLine.SETRANGE(MaterialIssueLine."Item No.",'ECICSDI00438');
        //MaterialIssueLine.SETFILTER(MaterialIssueLine.Quantity,'<>%1',0);
        MaterialIssueLine.SETFILTER(MaterialIssueLine."Outstanding Quantity", '<>%1', 0);
        IF MaterialIssueLine.FINDSET THEN
            REPEAT
                IF CheckSerialndBatchNo(MaterialIssueLine."Item No.") THEN BEGIN
                    DeleteTrackingSpecifications(MaterialIssueLine);
                    CheckInventory(MaterialIssueLine);
                    UpdateBatchndSerialNos(MaterialIssueLine);
                    AssignTrackingSpecifications(MaterialIssueLine);
                END;
            UNTIL MaterialIssueLine.NEXT = 0;
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
        "ILEQty.": Decimal;
        CheckQty: Decimal;
        AssignQty: Decimal;
        RemainingQty: Decimal;
        ActualQty: Decimal;
        QtytoReceive: Decimal;
        "Material Issues Header": Record "Material Issues Header";
        QILE: Record "Quality Item Ledger Entry";
        DUm_Serial: Code[20];
        Dum_Item: Text[50];
        AssignedQty: Decimal;
        "Production Order": Record "Production Order";
        AUTH_SHORT_ITEM: Record "Authorized Shortage Items";
        GL: Record "General Ledger Setup";
        NeededQty: Decimal;
        LotWiseAvail: Record "Lot wise Item Availability";
        Manual: Boolean;
        Location: Code[20];


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


    procedure DeleteTrackingSpecifications(var MaterialIssuesLine: Record "Material Issues Line");
    begin
        TrackingSpecification.RESET;
        TrackingSpecification.SETRANGE("Order No.", MaterialIssuesLine."Document No.");
        TrackingSpecification.SETRANGE("Order Line No.", MaterialIssuesLine."Line No.");
        TrackingSpecification.SETRANGE("Item No.", MaterialIssuesLine."Item No.");
        TrackingSpecification.SETRANGE("Location Code", MaterialIssuesLine."Transfer-from Code");
        IF TrackingSpecification.FINDFIRST THEN
            TrackingSpecification.DELETEALL;
    end;


    procedure CheckInventory(var MaterialIssuesLine: Record "Material Issues Line");
    var
        QualityItemLedgerEntry: Record "Quality Item Ledger Entry";
    begin
        "ILEQty." := 0;

        Item.RESET;
        Item.GET(MaterialIssuesLine."Item No.");

        IF (Item."Product Group Code Cust" <> 'LED') OR (Manual = TRUE) THEN BEGIN
            ItemLedgerEntry.RESET;
            ItemLedgerEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
            ItemLedgerEntry.SETRANGE("Item No.", MaterialIssuesLine."Item No.");
            ItemLedgerEntry.SETRANGE(Open, TRUE);
            ItemLedgerEntry.SETRANGE("Location Code", MaterialIssuesLine."Transfer-from Code");
            ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Remaining Quantity", '>%1', 0);
            IF ItemLedgerEntry.FINDSET THEN
                REPEAT
                    QualityItemLedgerEntry.SETRANGE("Entry No.", ItemLedgerEntry."Entry No.");
                    IF NOT QualityItemLedgerEntry.FINDFIRST THEN BEGIN
                        IF NOT MSLItemExpiryDate(ItemLedgerEntry) THEN
                            "ILEQty." := "ILEQty." + ItemLedgerEntry."Remaining Quantity";
                    END;
                UNTIL ItemLedgerEntry.NEXT = 0;

            IF "ILEQty." < MaterialIssuesLine."Qty. to Receive" THEN BEGIN
                "Production Order".SETRANGE("Production Order"."No.", MaterialIssuesLine."Prod. Order No.");
                IF "Production Order".FINDFIRST THEN BEGIN
                    // (AUTHORIZED_SHORTAGE_ITEM(MaterialIssuesLine."Item No."))
                    //AND (MaterialIssuesLine."Item No."<>'ECICSDI00233')
                    IF ("Production Order"."Product Group Code" = 'FPRODUCT') AND
                       (USERID <> 'EFFTRONICS\MARY') AND
                       (USERID <> 'EFFTRONICS\PADMASRI') AND (USERID <> 'EFFTRONICS\ANANDA') AND (USERID <> 'EFFTRONICS\RENUKACH') AND
                       (USERID <> 'EFFTRONICS\RRAHUL') AND
                       (USERID <> 'SUPER') AND
                       (USERID <> 'EFFTRONICS\SUJANI') AND
                        (USERID <> 'EFFTRONICS\ANILKUMAR') AND
                            (USERID <> 'EFFTRONICS\SPURTHI') AND
                               (USERID <> 'EFFTRONICS\ANVESH') AND (USERID <> 'EFFTRONICS\VARALAKSHMI') AND (USERID <> 'EFFTRONICS\VSNGEETHA') AND
                               (USERID <> 'EFFTRONICS\BSATISH') AND (USERID <> 'EFFTRONICS\SARDHAR') AND (USERID <> 'EFFTRONICS\GRAVI') AND (USERID<>'EFFTRONICS\SUVARCHALADEVI') AND

                       (NOT AUTHORIZED_SHORTAGE_ITEM(MaterialIssuesLine."Item No.")) THEN
                        ERROR('There is No  Suffiecient Material to Reserve ' + MaterialIssuesLine."Item No." + ' for' + MaterialIssuesLine."Document No.");
                END;
            END;

            IF "ILEQty." < MaterialIssuesLine."Qty. to Receive" THEN BEGIN
                MaterialIssuesLine.VALIDATE("Qty. to Receive", "ILEQty.");
                //MaterialIssuesLine.VALIDATE("Qty. to Receive");
                MaterialIssuesLine.MODIFY;
            END ELSE
                IF "ILEQty." = 0 THEN BEGIN
                    MaterialIssuesLine."Qty. to Receive" := 0;
                    MaterialIssuesLine.VALIDATE("Qty. to Receive");
                    MaterialIssuesLine.MODIFY;
                END;
        END
        ELSE            //Lot wise item availability  //mnraju  06-JUN-2014
        BEGIN
            LotWiseAvail.RESET;
            LotWiseAvail.SETCURRENTKEY(LotWiseAvail."Item No", LotWiseAvail."LOT No", LotWiseAvail.Location);
            LotWiseAvail.SETFILTER(LotWiseAvail."Item No", MaterialIssuesLine."Item No.");
            LotWiseAvail.SETRANGE(LotWiseAvail.Location, Location);
            LotWiseAvail.SETFILTER(LotWiseAvail."Allocated Qty", '>=%1', MaterialIssuesLine."Qty. to Receive");
            IF LotWiseAvail.FINDFIRST THEN BEGIN
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
                ItemLedgerEntry.SETRANGE("Item No.", MaterialIssuesLine."Item No.");
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Lot No.", LotWiseAvail."LOT No");
                ItemLedgerEntry.SETRANGE(Open, TRUE);
                ItemLedgerEntry.SETRANGE("Location Code", MaterialIssuesLine."Transfer-from Code");
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Remaining Quantity", '>%1', 0);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        QualityItemLedgerEntry.SETRANGE("Entry No.", ItemLedgerEntry."Entry No.");
                        IF NOT QualityItemLedgerEntry.FINDFIRST THEN BEGIN
                            IF NOT MSLItemExpiryDate(ItemLedgerEntry) THEN
                                "ILEQty." := "ILEQty." + ItemLedgerEntry."Remaining Quantity";
                        END;
                    UNTIL ItemLedgerEntry.NEXT = 0;

                IF "ILEQty." < MaterialIssuesLine."Qty. to Receive" THEN BEGIN

                    "Production Order".SETRANGE("Production Order"."No.", MaterialIssuesLine."Prod. Order No.");
                    IF "Production Order".FINDFIRST THEN BEGIN
                        // (AUTHORIZED_SHORTAGE_ITEM(MaterialIssuesLine."Item No."))
                        //AND (MaterialIssuesLine."Item No."<>'ECICSDI00233')
                        IF ("Production Order"."Product Group Code" = 'FPRODUCT') AND
                           (USERID <> 'EFFTRONICS\ANANDA') AND
                           (USERID <> 'EFFTRONICS\MARY') AND
                           (USERID <> 'EFFTRONICS\PADMA') AND
                           (USERID <> 'EFFTRONICS\DMADHAVI') AND
                           (USERID <> 'SUPER') AND
                           (USERID <> 'EFFTRONICS\PRANAVI') AND
                           (USERID <> 'EFFTRONICS\PADMAJA') AND

                           (NOT AUTHORIZED_SHORTAGE_ITEM(MaterialIssuesLine."Item No.")) THEN
                            ERROR('There is No  Suffiecient Material to Reserve ' + MaterialIssuesLine."Item No." + ' for' + MaterialIssuesLine."Document No.");
                    END;
                END;

                IF "ILEQty." < MaterialIssuesLine."Qty. to Receive" THEN BEGIN
                    MaterialIssuesLine.VALIDATE("Qty. to Receive", "ILEQty.");
                    //MaterialIssuesLine.VALIDATE("Qty. to Receive");
                    MaterialIssuesLine.MODIFY;
                END ELSE
                    IF "ILEQty." = 0 THEN BEGIN
                        MaterialIssuesLine."Qty. to Receive" := 0;
                        MaterialIssuesLine.VALIDATE("Qty. to Receive");
                        MaterialIssuesLine.MODIFY;
                    END;
            END;

        END;
        //Lot wise item availability  //mnraju  06-JUN-2014
    end;


    procedure UpdateBatchndSerialNos(var MaterialIssuesLine: Record "Material Issues Line");
    var
        BatchndSerialNosRec: Record "Batch and Serial No's";
        EntryNo: Integer;
        IsExp: Boolean;
    begin
        IsExp := FALSE;
        NeededQty := MaterialIssuesLine.Quantity;
        ItemLedgerEntry.RESET;
        //ItemLedgerEntry.SETCURRENTKEY("Item No.","Variant Code",Open,Positive,"Location Code","Posting Date");
        //commented by santhosh due to Non-Linearity in Serial No's ( Due to Returns 817m3 pcb) with STORE INCHRGE ASSURANCE
        Item.RESET;
        Item.GET(MaterialIssuesLine."Item No.");
        IF (Item."Product Group Code Cust" <> 'LED') OR (Manual = TRUE) THEN BEGIN
            ItemLedgerEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", "Location Code", "Item Tracking", "Lot No.", "Serial No.");
            ItemLedgerEntry.SETRANGE("Item No.", MaterialIssuesLine."Item No.");
            ItemLedgerEntry.SETRANGE(Open, TRUE);
            ItemLedgerEntry.SETRANGE("Location Code", MaterialIssuesLine."Transfer-from Code");
            ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Remaining Quantity", '>%1', 0);
            IF ItemLedgerEntry.FINDSET THEN
                REPEAT
                    IsExp := FALSE;
                    QILE.SETRANGE("Entry No.", ItemLedgerEntry."Entry No.");
                    IF NOT QILE.FINDFIRST THEN BEGIN
                        IF MSLItemExpiryDate(ItemLedgerEntry) THEN
                            IsExp := TRUE
                        ELSE
                            IsExp := FALSE;

                        IF IsExp = FALSE THEN BEGIN
                            IF BatchndSerialNosRec.FINDLAST THEN
                                EntryNo := BatchndSerialNosRec."Entry No."
                            ELSE
                                EntryNo := 0;

                            BatchndSerialNos."Entry Type" := BatchndSerialNos."Entry Type"::"Material Issues";
                            BatchndSerialNos."Entry No." := EntryNo + 1;
                            BatchndSerialNos."ItemLedg Entry No." := ItemLedgerEntry."Entry No.";
                            BatchndSerialNos."Item No." := ItemLedgerEntry."Item No.";
                            BatchndSerialNos.Description := ItemLedgerEntry.Description;
                            BatchndSerialNos.Quantity := ItemLedgerEntry."Remaining Quantity";
                            BatchndSerialNos."Location Code" := ItemLedgerEntry."Location Code";
                            BatchndSerialNos."Serial No." := ItemLedgerEntry."Serial No.";
                            BatchndSerialNos."Lot No." := ItemLedgerEntry."Lot No.";
                            BatchndSerialNos."Warranty Date" := ItemLedgerEntry."Warranty Date";
                            BatchndSerialNos."Expiration Date" := ItemLedgerEntry."Expiration Date";
                            BatchndSerialNos."Posting Date" := ItemLedgerEntry."Posting Date";
                            BatchndSerialNos."Prod. Order No." := MaterialIssueLine."Prod. Order No.";
                            BatchndSerialNos."Prod. Line No." := MaterialIssueLine."Prod. Order Line No.";
                            BatchndSerialNos."Prod. Comp. Line No." := MaterialIssueLine."Prod. Order Comp. Line No.";
                            BatchndSerialNos."Order No." := MaterialIssuesLine."Document No.";
                            BatchndSerialNos."Order Line No." := MaterialIssuesLine."Line No.";

                            Item.RESET;
                            IF Item.GET(ItemLedgerEntry."Item No.") THEN BEGIN
                                // MESSAGE(FORMAT(Item.Description));
                                // MESSAGE(FORMAT(Item."Item Tracking Code"));

                                IF (Item."Item Tracking Code" = 'LOT') OR (Item."Item Tracking Code"='LOT NO') THEN BEGIN

                                    BatchndSerialNos.CALCFIELDS(BatchndSerialNos."Assigned Qty.");
                                    //  MESSAGE(ItemLedgerEntry."Lot No."+'-'+FORMAT(BatchndSerialNos."Assigned Qty."));
                                    BatchndSerialNos.Quantity := BatchndSerialNos.Quantity - BatchndSerialNos."Assigned Qty.";
                                    BatchndSerialNos.INSERT;
                                    NeededQty := NeededQty - BatchndSerialNos.Quantity;

                                END ELSE BEGIN
                                    DUm_Serial := ItemLedgerEntry."Serial No.";
                                    Dum_Item := Item.Description;
                                    TrackingSpecification.RESET;
                                    TrackingSpecification.SETCURRENTKEY(TrackingSpecification."Item No.",
                                                                        TrackingSpecification."Location Code",
                                                                        TrackingSpecification."Lot No.",
                                                                        TrackingSpecification."Serial No.",
                                                                        TrackingSpecification."Appl.-to Item Entry");
                                    TrackingSpecification.SETRANGE(TrackingSpecification."Item No.", ItemLedgerEntry."Item No.");
                                    TrackingSpecification.SETRANGE(TrackingSpecification."Serial No.", ItemLedgerEntry."Serial No.");
                                    IF NOT TrackingSpecification.FINDFIRST THEN BEGIN
                                        BatchndSerialNos.Quantity := BatchndSerialNos.Quantity;
                                        BatchndSerialNos."Serial No." := ItemLedgerEntry."Serial No.";

                                        BatchndSerialNos.INSERT;
                                        NeededQty := NeededQty - BatchndSerialNos.Quantity;
                                        // EXIT; commented by santhosh for multiple serial no's allocation
                                    END

                                END;
                            END;
                            //BatchndSerialNos.MODIFY;
                        END;
                    END;
                UNTIL (ItemLedgerEntry.NEXT = 0) OR (NeededQty <= 0);
        END
        ELSE                    //Lot wise item availability  //mnraju  06-JUN-2014
        BEGIN
            LotWiseAvail.RESET;
            LotWiseAvail.SETCURRENTKEY(LotWiseAvail."Item No", LotWiseAvail."LOT No", LotWiseAvail.Location);
            LotWiseAvail.SETFILTER(LotWiseAvail."Item No", MaterialIssuesLine."Item No.");
            LotWiseAvail.SETFILTER(LotWiseAvail.Location, Location);
            LotWiseAvail.SETFILTER(LotWiseAvail."Allocated Qty", '>%1', 0);
            IF LotWiseAvail.FINDFIRST THEN
                REPEAT
                    ItemLedgerEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", "Location Code", "Item Tracking", "Lot No.", "Serial No.");
                    ItemLedgerEntry.SETRANGE("Item No.", MaterialIssuesLine."Item No.");
                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Lot No.", LotWiseAvail."LOT No");
                    ItemLedgerEntry.SETRANGE(Open, TRUE);
                    ItemLedgerEntry.SETRANGE("Location Code", MaterialIssuesLine."Transfer-from Code");
                    ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Remaining Quantity", '>%1', 0);

                    IF ItemLedgerEntry.FINDSET THEN
                        REPEAT
                            IsExp := FALSE;
                            QILE.SETRANGE("Entry No.", ItemLedgerEntry."Entry No.");
                            IF NOT QILE.FINDFIRST THEN BEGIN
                                IF MSLItemExpiryDate(ItemLedgerEntry) THEN
                                    IsExp := TRUE
                                ELSE
                                    IsExp := FALSE;

                                IF IsExp = FALSE THEN BEGIN
                                    IF BatchndSerialNosRec.FINDLAST THEN
                                        EntryNo := BatchndSerialNosRec."Entry No."
                                    ELSE
                                        EntryNo := 0;

                                    BatchndSerialNos."Entry Type" := BatchndSerialNos."Entry Type"::"Material Issues";
                                    BatchndSerialNos."Entry No." := EntryNo + 1;
                                    BatchndSerialNos."ItemLedg Entry No." := ItemLedgerEntry."Entry No.";
                                    BatchndSerialNos."Item No." := ItemLedgerEntry."Item No.";
                                    BatchndSerialNos.Description := ItemLedgerEntry.Description;
                                    BatchndSerialNos.Quantity := ItemLedgerEntry."Remaining Quantity";
                                    BatchndSerialNos."Location Code" := ItemLedgerEntry."Location Code";
                                    BatchndSerialNos."Serial No." := ItemLedgerEntry."Serial No.";
                                    BatchndSerialNos."Lot No." := ItemLedgerEntry."Lot No.";
                                    BatchndSerialNos."Warranty Date" := ItemLedgerEntry."Warranty Date";
                                    BatchndSerialNos."Expiration Date" := ItemLedgerEntry."Expiration Date";
                                    BatchndSerialNos."Posting Date" := ItemLedgerEntry."Posting Date";
                                    BatchndSerialNos."Prod. Order No." := MaterialIssueLine."Prod. Order No.";
                                    BatchndSerialNos."Prod. Line No." := MaterialIssueLine."Prod. Order Line No.";
                                    BatchndSerialNos."Prod. Comp. Line No." := MaterialIssueLine."Prod. Order Comp. Line No.";
                                    BatchndSerialNos."Order No." := MaterialIssuesLine."Document No.";
                                    BatchndSerialNos."Order Line No." := MaterialIssuesLine."Line No.";

                                    Item.RESET;
                                    IF Item.GET(ItemLedgerEntry."Item No.") THEN BEGIN
                                        IF Item."Item Tracking Code" = 'LOT' THEN BEGIN
                                            BatchndSerialNos.CALCFIELDS(BatchndSerialNos."Assigned Qty.");
                                            BatchndSerialNos.Quantity := BatchndSerialNos.Quantity - BatchndSerialNos."Assigned Qty.";
                                            BatchndSerialNos.INSERT;
                                            /*   // Commented by Pranavi on 31-may-2016 for leds not posting issues in day wise issue
                                            IF ItemLedgerEntry."Remaining Quantity">=NeededQty THEN
                                              LotWiseAvail."Allocated Qty":=LotWiseAvail."Allocated Qty"-NeededQty
                                            ELSE
                                              LotWiseAvail."Allocated Qty":=LotWiseAvail."Allocated Qty"-ItemLedgerEntry."Remaining Quantity";
                                            LotWiseAvail.MODIFY;

                                            NeededQty:=NeededQty-BatchndSerialNos.Quantity;
                                            */ // Commented by Pranavi on 31-may-2016 for leds not posting issues in day wise issue

                                            //Added by Pranavi on 31-may-2016 for leds not posting issues in day wise issue
                                            IF BatchndSerialNos.Quantity > 0 THEN BEGIN
                                                IF BatchndSerialNos.Quantity >= NeededQty THEN
                                                    LotWiseAvail."Allocated Qty" := LotWiseAvail."Allocated Qty" - NeededQty
                                                ELSE
                                                    LotWiseAvail."Allocated Qty" := LotWiseAvail."Allocated Qty" - BatchndSerialNos.Quantity;
                                                LotWiseAvail.MODIFY;

                                                NeededQty := NeededQty - BatchndSerialNos.Quantity;
                                            END;
                                            // End by Pranavi
                                        END
                                    END;
                                END;
                            END;
                        UNTIL (ItemLedgerEntry.NEXT = 0) OR (NeededQty <= 0);

                // ERROR('DONT CONTINUE');
                UNTIL (LotWiseAvail.NEXT = 0) OR (NeededQty <= 0);

        END;         //Lot wise item availability  //mnraju  06-JUN-2014

    end;


    procedure AssignTrackingSpecifications(var MaterialIssuesLine: Record "Material Issues Line");
    var
        UndifinedQty: Decimal;
        QtyAssigned: Decimal;
        AssayReqQty: Decimal;
        RemQty: Decimal;
        TempBatchndSerialNos: Record "Batch and Serial No's";
    begin
        UndifinedQty := MaterialIssuesLine."Qty. to Receive";
        CheckQty := MaterialIssuesLine."Qty. to Receive";
        RemainingQty := MaterialIssuesLine."Qty. to Receive";
        ActualQty := MaterialIssueLine.Quantity;
        QtytoReceive := MaterialIssuesLine."Qty. to Receive";
        AssignedQty := 0;
        //BatchndSerialNos.SETCURRENTKEY("Expiration Date","Item No.","Location Code","Posting Date"); Commented by sundar due to
        //Non-linearity in serial and lot no due to introduction of PRODSTR
        BatchndSerialNos.SETCURRENTKEY("Expiration Date", "Item No.", "Location Code", "Lot No.", "Serial No.");
        BatchndSerialNos.SETRANGE("Entry Type", BatchndSerialNos."Entry Type"::"Material Issues");
        BatchndSerialNos.SETRANGE("Order No.", MaterialIssuesLine."Document No.");
        BatchndSerialNos.SETRANGE("Order Line No.", MaterialIssuesLine."Line No.");
        BatchndSerialNos.SETFILTER(BatchndSerialNos.Quantity, '>%1', 0);
        IF BatchndSerialNos.FINDSET THEN BEGIN
            REPEAT
                BatchndSerialNos.CALCFIELDS(BatchndSerialNos."Assigned Qty.");
                TrackingSpecification.INIT;
                TrackingSpecification."Order No." := BatchndSerialNos."Order No.";
                TrackingSpecification."Order Line No." := BatchndSerialNos."Order Line No.";
                TrackingSpecification."Item No." := BatchndSerialNos."Item No.";
                TrackingSpecification."Location Code" := BatchndSerialNos."Location Code";
                TrackingSpecification."Lot No." := BatchndSerialNos."Lot No.";
                TrackingSpecification."Serial No." := BatchndSerialNos."Serial No.";
                TrackingSpecification."Actual Quantity" := ActualQty;
                TrackingSpecification."Actual Qty to Receive" := QtytoReceive;
                TrackingSpecification.Description := MaterialIssuesLine.Description;
                TrackingSpecification."Creation Date" := TODAY;
                TrackingSpecification."Appl.-to Item Entry" := BatchndSerialNos."ItemLedg Entry No.";
                TrackingSpecification."Warranty date" := BatchndSerialNos."Warranty Date";
                TrackingSpecification."Expiration Date" := BatchndSerialNos."Expiration Date";
                IF Item.GET(BatchndSerialNos."Item No.") THEN
                    TrackingSpecification."Product Group Code" := Item."Product Group Code Cust";

                IF "Material Issues Header".GET(BatchndSerialNos."Order No.") THEN BEGIN
                    TrackingSpecification."Prod. Order No." := "Material Issues Header"."Prod. Order No.";                       // Added By
                    TrackingSpecification."Prod. Order Line No." := "Material Issues Header"."Prod. Order Line No.";
                    // SANTHOSH KUMAR.K
                END;
                IF (TrackingSpecification."Serial No." = '') AND (TrackingSpecification."Lot No." <> '') THEN BEGIN
                    IF ABS(UndifinedQty) = BatchndSerialNos.Quantity THEN BEGIN
                        TrackingSpecification.Quantity := BatchndSerialNos.Quantity;
                        UndifinedQty := ABS(UndifinedQty) - ABS(TrackingSpecification.Quantity);
                    END ELSE BEGIN
                        IF ABS(UndifinedQty) > BatchndSerialNos.Quantity THEN BEGIN
                            TrackingSpecification.Quantity := BatchndSerialNos.Quantity;
                            UndifinedQty := ABS(UndifinedQty) - ABS(BatchndSerialNos.Quantity);
                        END ELSE BEGIN
                            TrackingSpecification.Quantity := UndifinedQty;
                            UndifinedQty := ABS(UndifinedQty) - BatchndSerialNos.Quantity;
                        END;
                    END;
                END ELSE BEGIN
                    TrackingSpecification.Quantity := BatchndSerialNos.Quantity;
                END;
                TrackingSpecification.VALIDATE(TrackingSpecification.Quantity);
                QtyAssigned := QtyAssigned + ABS(TrackingSpecification.Quantity);
                IF (QtyAssigned <= MaterialIssueLine."Qty. to Receive") AND (TrackingSpecification.Quantity <> 0) THEN BEGIN
                    BEGIN
                        TrackingSpecification.INSERT;
                        AssignedQty += TrackingSpecification.Quantity;
                    END;
                    BatchndSerialNos.Quantity := BatchndSerialNos.Quantity - ABS(TrackingSpecification.Quantity);
                    BatchndSerialNos.MODIFY;
                    IF BatchndSerialNos.Quantity = 0 THEN
                        BatchndSerialNos.DELETE;
                END;
            UNTIL BatchndSerialNos.NEXT = 0;
            IF MaterialIssuesLine.Quantity >= AssignedQty THEN BEGIN
                MaterialIssuesLine.VALIDATE("Qty. to Receive", AssignedQty);
                MaterialIssuesLine.MODIFY;
            END ELSE
                MESSAGE(MaterialIssuesLine.Description + '-' + FORMAT(MaterialIssuesLine.Quantity) + '-' + FORMAT(AssignedQty));

        END ELSE BEGIN
            MaterialIssuesLine."Qty. to Receive" := 0;
            MaterialIssuesLine.VALIDATE("Qty. to Receive");
            MaterialIssuesLine.MODIFY;

        END;
    end;


    procedure "Assgin Qunatity"("Reqest No.": Code[10]);
    var
        "Material Issues Line": Record "Material Issues Line";
    begin
        "Material Issues Line".SETRANGE("Material Issues Line"."Document No.", "Reqest No.");
        IF "Material Issues Line".FINDSET THEN
            REPEAT
                "Material Issues Line"."Qty. to Receive" := "Material Issues Line".Quantity;
                "Material Issues Line".MODIFY;
            UNTIL "Material Issues Line".NEXT = 0;
    end;


    procedure AUTHORIZED_SHORTAGE_ITEM(ITEM: Code[20]) AUTHORIZED: Boolean;
    begin
        AUTHORIZED := FALSE;
        GL.GET;
        IF GL."Production_ Shortage_Status" = GL."Production_ Shortage_Status"::Accepted THEN BEGIN
            AUTH_SHORT_ITEM.SETRANGE(AUTH_SHORT_ITEM."Item No.", ITEM);
            AUTH_SHORT_ITEM.SETRANGE(AUTH_SHORT_ITEM."Production Date", GL."Production Shortage Date");
            IF AUTH_SHORT_ITEM.FINDFIRST THEN
                AUTHORIZED := TRUE;
        END;
        EXIT(AUTHORIZED);
    end;


    procedure AssignBatchManual(var Rec: Record "Material Issues Header");
    begin
        /*
        IF USERID = 'EFFTRONICS\PRANAVI' THEN
        BEGIN
          Manual:=FALSE;
          Location:=Rec."Transfer-from Code";
        END ELSE
        */
        Manual := TRUE;
        BatchndSerialNos.DELETEALL;
        Rec.TESTFIELD("No.");
        Rec.TESTFIELD("Transfer-from Code");
        Rec.TESTFIELD("Transfer-to Code");
        Rec.TESTFIELD(Status, Rec.Status::Released);
        MaterialIssueLine.SETRANGE("Document No.", Rec."No.");
        /*
        IF USERID = 'EFFTRONICS\PRANAVI' THEN
          MaterialIssueLine.SETRANGE(MaterialIssueLine."Item No.",'ECLEDDI00012');
        */
        //MaterialIssueLine.SETFILTER(MaterialIssueLine.Quantity,'<>%1',0);
        MaterialIssueLine.SETFILTER(MaterialIssueLine."Outstanding Quantity", '<>%1', 0);
        IF MaterialIssueLine.FINDSET THEN
            REPEAT
                IF CheckSerialndBatchNo(MaterialIssueLine."Item No.") THEN BEGIN
                    DeleteTrackingSpecifications(MaterialIssueLine);
                    CheckInventory(MaterialIssueLine);
                    UpdateBatchndSerialNos(MaterialIssueLine);
                    AssignTrackingSpecifications(MaterialIssueLine);
                END;
            UNTIL MaterialIssueLine.NEXT = 0;


        Manual := FALSE;

    end;


    procedure MSLItemExpiryDate(ILE: Record "Item Ledger Entry") Expired: Boolean;
    var
        MSL_ILE: Record "Item Ledger Entry";
        Itm: Record Item;
        IsExpired: Boolean;
        //DateAndTime: DotNet "'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.DateAndTime";
      //  DayofWeekInput: DotNet "'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.FirstDayOfWeek";
      //  WeekofYearInput: DotNet "'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.FirstWeekOfYear";
        Itm_floor_life: Decimal;
    begin
        IsExpired := FALSE;
        Itm_floor_life := 0;
        IF Itm.GET(ILE."Item No.") THEN BEGIN
            IF ((Itm.MSL <> 0) AND NOT (Itm."No." IN ['ECTRNPN00003', 'ECICSDI00438', 'ECICSDI00631', 'ECICSAN00091',
              'ECREGPV00029', 'ECICSDI00438', 'ECDIOPN00241', 'ECICSAN00122', 'ECICSAN00095', 'ELWLS00035',
              'ECICSAN00005', 'ECICSDI00067', 'ECVARAX00057', 'ECDIOPN00241', 'ECICSDI00706', 'ECICSDI00476'
              , 'ECICSDI00550', 'ECICSDI00724', 'ECREGNV00006'])) THEN // ADDED BY SUJANI  ON 30-08-19 BY ANIL SIR
            BEGIN
                MSL_ILE.RESET;
                MSL_ILE.SETCURRENTKEY("Item No.", "Entry Type");
                MSL_ILE.SETRANGE("Item No.", ILE."Item No.");
                MSL_ILE.SETRANGE("Entry Type", MSL_ILE."Entry Type"::Purchase);
                MSL_ILE.SETRANGE("Document Type", MSL_ILE."Document Type"::"Purchase Receipt");
                MSL_ILE.SETRANGE("Lot No.", ILE."Lot No.");
                IF MSL_ILE.FINDFIRST THEN BEGIN
                    IF (MSL_ILE."MFD Date" <> 0D) AND (Itm."Component Shelf Life(Years)" > 0) THEN BEGIN
                        IF CALCDATE(FORMAT(Item."Component Shelf Life(Years)") + 'Y', MSL_ILE."MFD Date") < TODAY THEN
                            IsExpired := TRUE;
                    END;
                    IF IsExpired = FALSE THEN BEGIN
                        IF NOT (Itm."Floor Life at 25 C 40% RH" IN ['', ' ', 'INFINITE']) THEN BEGIN
                            EVALUATE(Itm_floor_life, Itm."Floor Life at 25 C 40% RH");
                            IF (MSL_ILE."Floor Life" >= Itm_floor_life) AND (Itm_floor_life > 0) THEN
                                IsExpired := TRUE;
                            IF IsExpired = FALSE THEN
                                IF MSL_ILE."Recharge Cycles" >= 2 THEN
                                    IsExpired := TRUE;
                        END;
                    END;
                END;
            END;
        END;
        EXIT(IsExpired);
    end;


    procedure ManualFieldSetting(BooleanValue: Boolean);
    begin
        Manual := BooleanValue;
    end;


    procedure BulckAssignmnet(MIL: Record "Material Issues Line");
    begin
        Manual := TRUE;
        BatchndSerialNos.DELETEALL;
        MaterialIssueLine.RESET;
        MaterialIssueLine.SETRANGE("Document No.", MIL."Document No.");
        MaterialIssueLine.SETRANGE("Line No.", MIL."Line No.");
        IF MaterialIssueLine.FINDSET THEN
            REPEAT
                IF CheckSerialndBatchNo(MaterialIssueLine."Item No.") THEN BEGIN
                    DeleteTrackingSpecifications(MaterialIssueLine);
                    CheckInventory(MaterialIssueLine);
                    UpdateBatchndSerialNos(MaterialIssueLine);
                    AssignTrackingSpecifications(MaterialIssueLine);
                END;
            UNTIL MaterialIssueLine.NEXT = 0;
        Manual := FALSE;
    end;
}

