tableextension 70087 TransferLineExt extends "Transfer Line"
{
    fields
    {
        field(60113; "Variant Code1"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(60000; "Position Reference No."; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60001; "Prod. Order No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Production Order"."No." WHERE(Status = CONST(Released));
            DataClassification = CustomerContent;
        }
        field(60002; "Prod. Order Line No."; Integer)
        {
            Description = 'B2B';
            TableRelation = "Prod. Order Line"."Line No." WHERE("Prod. Order No." = FIELD("Prod. Order No."),
                                                                 Status = CONST(Released));
            DataClassification = CustomerContent;
        }
        field(60003; "Allow Excess Qty."; Boolean)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60004; "Shelf No."; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60005; "Production BOM No."; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                ProductionOrderLine: Record "Prod. Order Line";
                ProductionBOMHeader: Record "Production BOM Header";
            begin
            end;

            trigger OnValidate();
            begin
                /*
                ProductionOrderLine.SETRANGE("Prod. Order No.","Prod. Order No.");
                ProductionOrderLine.SETRANGE("Line No.","Prod. Order Line No.");
                IF ProductionOrderLine.FIND('-') THEN BEGIN
                  MESSAGE('%1',ProductionOrderLine.COUNT);
                  ProductionBOMHeader.SETRANGE("No.",ProductionOrderLine."Production BOM No.");
                  IF ProductionBOMHeader.FIND('-') THEN BEGIN
                    PAGE.RUN(99000787,ProductionBOMHeader);
                  END;
                END;
                */

            end;
        }
        field(60006; "Type of Material"; Enum TypeofMaterial)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60007; "Reason Code"; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Reason Code".Code;
            DataClassification = CustomerContent;
        }
        field(60008; "Prod. Order Comp. Line No."; Integer)
        {
            Caption = 'Prod. Order Comp. Line No.';
            Description = 'B2B';
            TableRelation = "Prod. Order Component"."Line No." WHERE(Status = CONST(Released),
                                                                      "Prod. Order No." = FIELD("Prod. Order No."),
                                                                      "Prod. Order Line No." = FIELD("Prod. Order Line No."));
            DataClassification = CustomerContent;
        }
        field(60009; Inventory; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                  Open = CONST(true),
                                                                  "Location Code" = FIELD("Transfer-from Code")));
            Description = 'B2B';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60090; "Dimension Corrected"; Boolean)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60091; "OLD Dim Set ID"; Integer)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            TableRelation = "Dimension Set Entry Backup2"."Dimension Set ID" WHERE("Dimension Set ID" = FIELD("OLD Dim Set ID"));
            DataClassification = CustomerContent;


        }
        field(60100; Copy; Boolean)
        {
            Description = 'B2B-Internal field used for Allow excess Qty. field Validations';
            DataClassification = CustomerContent;
        }
        field(60101; Reason; Text[150])
        {
            DataClassification = CustomerContent;
        }
        field(60102; Priority; Enum Prority)
        {
            DataClassification = CustomerContent;

        }
        field(60103; "Status."; Enum Status1)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Updation Date Time" := CurrentDateTime
            end;
        }
        field(60104; "Updation Date Time"; DateTime)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60105; Station; Code[10])
        {
            TableRelation = Station;
            DataClassification = CustomerContent;
        }
        field(60106; "Required Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60107; "DL Model"; Code[20])
        {
            TableRelation = "Service Price Group";
            DataClassification = CustomerContent;
        }
        field(60108; Type; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(60109; "Station Name"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60110; "Promised Receipt Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60111; "Requirement Reason"; Enum "Requirement Reason")
        {
            DataClassification = CustomerContent;

        }
        field(60112; Remarks; Text[150])
        {
            DataClassification = CustomerContent;
        }
        field(33000250; "Spec ID"; Code[20])
        {
            Description = 'QC1.0';
            TableRelation = "Specification Header";
            DataClassification = CustomerContent;
        }
        field(33000251; "Quantity Accepted"; Decimal)
        {
            CalcFormula = Sum("Quality Ledger Entry".Quantity WHERE("Order No." = FIELD("Document No."),
                                                                     "Order Line No." = FIELD("Line No."),
                                                                     "Entry Type" = FILTER(Accepted)));
            Description = 'QC1.0';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33000252; "Quantity Rejected"; Decimal)
        {
            CalcFormula = Sum("Quality Ledger Entry".Quantity WHERE("Order No." = FIELD("Document No."),
                                                                     "Order Line No." = FIELD("Line No."),
                                                                     "Entry Type" = CONST(Reject)));
            Description = 'QC1.0';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33000253; "QC Enabled"; Boolean)
        {
            Description = 'QC1.0';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*
                TestStatusOpen;
                TESTFIELD(Type,Type :: Item);
                IF "QC Enabled" THEN
                  TESTFIELD("Spec ID");
                IF NOT "QC Enabled" THEN
                  IF "Quality Before Receipt" THEN
                    VALIDATE("Quality Before Receipt",FALSE);
                */

            end;
        }
        field(33000256; "Qty. Sending To Quality"; Decimal)
        {
            Description = 'QC1.0';
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Quantity < ("Qty. Sending To Quality" + "Qty. Sent To Quality") then
                    Error('"Quantity Sending to Quality" should not be more than the Quantity');
            end;
        }
        field(33000257; "Qty. Sent To Quality"; Decimal)
        {
            Description = 'QC1.0';
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(33000258; "Qty. Sending To Quality(R)"; Decimal)
        {
            Description = 'QC1.0';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(33000259; "Spec Version"; Code[20])
        {
            TableRelation = "Specification Version"."Version Code" WHERE("Specification No." = FIELD("Spec ID"));
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key7; "Prod. Order No.", "Prod. Order Line No.", "Prod. Order Comp. Line No.")
        {
            //SumIndexFields = Quantity;
        }
    }



    var
        "----B2B----": Integer;
        TransferHeader: Record "Transfer Header";
        ProdOrderComp: Record "Prod. Order Component";
        Location: Record Location;



    PROCEDURE "--B2B--"();
    BEGIN
    END;


    PROCEDURE CreateInspectionDataSheets();
    VAR
        InspectDataSheets: Codeunit "Inspection Data Sheets";
        TrnsHeader: Record "Transfer Header";
        WhseRcptLine: Record "Warehouse Receipt Line";
        TransferHeader: Record "Transfer Header";
        Location: Record Location;
        ILE: Record "Item Ledger Entry";
        "LocationQty.": Decimal;
        Text001: Label 'Item %1 is not in Inventory.';
        Text002: Label '%1 is not a QC Enabled Location';
    BEGIN
        Location.Get("Transfer-to Code");
        if not (Location."QC Enabled Location") then
            Error(Text002, "Transfer-to Code");
        //B2B
        TransferHeader.SetRange("No.", "Document No.");
        if TransferHeader.Find('-') then begin
            Location.Get(TransferHeader."Transfer-to Code");
            if Location."QC Enabled Location" then begin
                if "QC Enabled" = true then begin
                    ILE.SetRange("Item No.", "Item No.");
                    ILE.SetRange(Open, true);
                    ILE.SetRange(ILE."Location Code", TransferHeader."Transfer-from Code");
                    if ILE.Find('-') then begin
                        repeat
                            "LocationQty." := "LocationQty." + ILE.Quantity;
                        until ILE.Next = 0;
                    end;
                end;
            end;
            if "LocationQty." < Quantity then
                Error(Text001, "Item No.");
        end;
        //B2B

        TrnsHeader.Get("Document No.");
        TrnsHeader.TestField(Status, TrnsHeader.Status::Released);
        TestField("Qty. Sending To Quality");
        InspectDataSheets.CreateTransferInspectDataSheet(TrnsHeader, Rec);
    END;


    PROCEDURE ShowDataSheets();
    VAR
        InspectDataSheet: Record "Inspection Datasheet Header";
    BEGIN
        InspectDataSheet.SetRange("Trans. Order No.", "Document No.");
        InspectDataSheet.SetRange("Trans. Order Line", "Line No.");
        InspectDataSheet.SetRange("Source Type", InspectDataSheet."Source Type"::Transfer);
        PAGE.Run(PAGE::"Inspection Data Sheet List", InspectDataSheet);
    END;


    PROCEDURE ShowPostDataSheets();
    VAR
        PostInspectDataSheet: Record "Posted Inspect DatasheetHeader";
    BEGIN
        PostInspectDataSheet.SetRange("Trans. Order No.", "Document No.");
        PostInspectDataSheet.SetRange("Trans. Order Line", "Line No.");
        //PostInspectDataSheet.SETRANGE("Source Type",PostInspectDataSheet."Source Type" ::t);
        PAGE.Run(PAGE::"Posted Inspect Data Sheet List", PostInspectDataSheet);
    END;


    PROCEDURE ShowInspectReceipt();
    VAR
        InspectionReceipt: Record "Inspection Receipt Header";
    BEGIN
        InspectionReceipt.SetRange("Trans. Order No.", "Document No.");
        InspectionReceipt.SetRange("Trans. Order Line", "Line No.");
        InspectionReceipt.SetRange("Source Type", InspectionReceipt."Source Type"::Transfer);
        InspectionReceipt.SetRange(Status, false);
        PAGE.Run(PAGE::"Inspection Receipt List", InspectionReceipt);
    END;


    PROCEDURE ShowPostInspectReceipt();
    VAR
        InspectionReceipt: Record "Inspection Receipt Header";
    BEGIN
        InspectionReceipt.SetRange("Trans. Order No.", "Document No.");
        InspectionReceipt.SetRange("Trans. Order Line", "Line No.");
        InspectionReceipt.SetRange("Source Type", InspectionReceipt."Source Type"::Transfer);
        InspectionReceipt.SetRange(Status, true);
        PAGE.Run(PAGE::"Inspection Receipt List", InspectionReceipt);
    END;


    PROCEDURE "Cancel Inspection"(VAR QualityStatus: Text[50]);
    VAR
        IDS: Record "Inspection Datasheet Header";
        IDSL: Record "Inspection Datasheet Line";
        PIDS: Record "Posted Inspect DatasheetHeader";
        PIDSL: Record "Posted Inspect Datasheet Line";
    BEGIN
        IDS.SetRange(IDS."Trans. Order No.", "Document No.");
        IDS.SetRange(IDS."Trans. Order Line", "Line No.");
        if not IDS.Find('-') then
            Error('You can not Cancel the Quality Bcoz the IDS is Alreadey Posted')
        else begin
            PIDS.TransferFields(IDS);
            PIDS."Quality Status" := PIDS."Quality Status"::Cancel;
            PIDS.Insert;
            IDS.Delete;
            IDSL.SetRange("Document No.", IDS."No.");
            if IDSL.Find('-') then begin
                repeat
                    PIDSL.TransferFields(IDSL);
                    PIDSL.Insert;
                until IDSL.Next = 0;
                IDSL.DeleteAll;
            end;
        end;
        "QC Enabled" := false;
        "Qty. Sending To Quality" := 0;
        "Qty. Sent To Quality" := 0;
        Modify;
    END;


    PROCEDURE "Close Inspection"(VAR QualityStatus: Text[50]);
    VAR
        IR: Record "Inspection Receipt Header";
        IRL: Record "Inspection Receipt Line";
    BEGIN
        IR.SetRange("Trans. Order No.", "Document No.");
        IR.SetRange("Trans. Order Line", "Line No.");
        IR.SetFilter(Status, 'NO');
        if not IR.Find('-') then
            Error('Inspection Receipt not find')
        else begin
            IR.Status := true;
            IR."Quality Status" := IR."Quality Status"::Close;
            IR.Modify;
        end;
        "QC Enabled" := false;
        "Qty. Sending To Quality" := 0;
        "Qty. Sent To Quality" := 0;
        Modify;
    END;


    PROCEDURE AssignSerialNo();
    VAR
        ItemLedgerEntry: Record "Item Ledger Entry";
        ReservationEntry: Record "Reservation Entry";
        TempReservationEntry: Record "Reservation Entry";
        "Qty.Assigned": Decimal;
        "RequestedQty.": Decimal;
        "AssignedQty.": Decimal;
        "LotQty.": Decimal;
        "UndefinedQty.": Decimal;
        DeleteEntry: Record "Reservation Entry";
    BEGIN

        /* TESTFIELD("Qty. to Ship");
        "UndefinedQty." := "Qty. to Ship";
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.","Variant Code",Open,Positive,"Location Code","Posting Date");
        ItemLedgerEntry.SETRANGE("Item No.","Item No.");
        ItemLedgerEntry.SETRANGE("Variant Code","Variant Code");
        ItemLedgerEntry.SETRANGE(Open,TRUE);
        ItemLedgerEntry.SETRANGE("Location Code","Transfer-from Code");
        IF ItemLedgerEntry.FIND('-') THEN
          REPEAT
            ReservationEntry.INIT;
            IF ReservationEntry.FIND('+') THEN
              ReservationEntry."Entry No." := ReservationEntry."Entry No." + 1
            ELSE
              ReservationEntry."Entry No." := 1;
            ReservationEntry.Positive := FALSE;
            ReservationEntry."Item No." := ItemLedgerEntry."Item No.";
            ReservationEntry."Location Code" := ItemLedgerEntry."Location Code";
            ReservationEntry."Serial No." := ItemLedgerEntry."Serial No.";
            ReservationEntry."Lot No." := ItemLedgerEntry."Lot No.";
            ReservationEntry."Reservation Status" := ReservationEntry."Reservation Status" :: Surplus;
            ReservationEntry.Description := ItemLedgerEntry.Description;
            ReservationEntry."Creation Date" := WORKDATE;
            ReservationEntry."Source Type" := DATABASE :: "Transfer Line";
            ReservationEntry."Source ID" := "Document No.";
            ReservationEntry."Source Ref. No." := "Line No.";
            ReservationEntry."Shipment Date" := WORKDATE;
            ReservationEntry."Created By" := USERID;
            ReservationEntry."Qty. per Unit of Measure" := ItemLedgerEntry."Qty. per Unit of Measure";
            ReservationEntry."Planning Flexibility" := ReservationEntry."Planning Flexibility" :: Unlimited;
            IF (ReservationEntry."Serial No." = '') AND (ReservationEntry."Lot No." <> '') THEN BEGIN
              IF ABS("UndefinedQty.") = ItemLedgerEntry."Remaining Quantity" THEN BEGIN
                ReservationEntry."Quantity (Base)" := -ItemLedgerEntry."Remaining Quantity";
                "UndefinedQty." := ABS("UndefinedQty.") - ABS(ReservationEntry."Quantity (Base)");
              END ELSE BEGIN
                IF ABS("UndefinedQty.") > ItemLedgerEntry."Remaining Quantity" THEN BEGIN
                  ReservationEntry."Quantity (Base)" := -ItemLedgerEntry."Remaining Quantity";
                  "UndefinedQty." := ABS("UndefinedQty.") - ABS(ItemLedgerEntry."Remaining Quantity");
                END ELSE BEGIN
                      ReservationEntry."Quantity (Base)" := -"UndefinedQty.";
                      "UndefinedQty." := ABS("UndefinedQty.") - ItemLedgerEntry."Remaining Quantity";
                    END;
              END;
            END ELSE BEGIN
              ReservationEntry."Quantity (Base)" := -ItemLedgerEntry."Remaining Quantity";
            END;
            ReservationEntry.VALIDATE(ReservationEntry."Quantity (Base)");
            TempReservationEntry.SETRANGE(TempReservationEntry."Item No.",ItemLedgerEntry."Item No.");
            TempReservationEntry.SETRANGE(TempReservationEntry."Location Code",ItemLedgerEntry."Location Code");
            TempReservationEntry.SETRANGE(TempReservationEntry."Serial No.",ItemLedgerEntry."Serial No.");
            TempReservationEntry.SETRANGE(TempReservationEntry."Lot No.",ItemLedgerEntry."Lot No.");
            TempReservationEntry.SETRANGE(TempReservationEntry."Source ID","Document No.");
            IF NOT TempReservationEntry.FIND('-') THEN BEGIN
               "Qty.Assigned" := "Qty.Assigned" + ABS(ReservationEntry."Quantity (Base)");
               IF ("Qty.Assigned" <= Quantity) AND (ReservationEntry."Quantity (Base)" <> 0) THEN
                 ReservationEntry.INSERT;
            END;
            COMMIT;
          UNTIL ItemLedgerEntry.NEXT = 0; */

        //DELETING THE ENTRY
        DeleteEntry.SetRange("Source Type", DATABASE::"Transfer Line");
        DeleteEntry.SetRange("Source ID", "Document No.");
        DeleteEntry.SetRange("Source Ref. No.", "Line No.");
        if DeleteEntry.Find('-') then
            DeleteEntry.DeleteAll;

        TestField("Qty. to Ship");
        "UndefinedQty." := "Qty. to Ship";
        ItemLedgerEntry.Reset;
        ItemLedgerEntry.SetCurrentKey("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
        ItemLedgerEntry.SetRange("Item No.", "Item No.");
        ItemLedgerEntry.SetRange("Variant Code", "Variant Code");
        ItemLedgerEntry.SetRange(Open, true);
        ItemLedgerEntry.SetRange("Location Code", "Transfer-from Code");
        if ItemLedgerEntry.Find('-') then
            repeat
                ReservationEntry.Init;
                if ReservationEntry.Find('+') then
                    ReservationEntry."Entry No." := ReservationEntry."Entry No." + 1
                else
                    ReservationEntry."Entry No." := 1;
                ReservationEntry.Positive := false;
                ReservationEntry."Item No." := ItemLedgerEntry."Item No.";
                ReservationEntry."Location Code" := ItemLedgerEntry."Location Code";
                ReservationEntry."Serial No." := ItemLedgerEntry."Serial No.";
                ReservationEntry."Lot No." := ItemLedgerEntry."Lot No.";
                ReservationEntry."Reservation Status" := ReservationEntry."Reservation Status"::Surplus;
                ReservationEntry.Description := ItemLedgerEntry.Description;
                ReservationEntry."Creation Date" := WorkDate;
                ReservationEntry."Source Type" := DATABASE::"Transfer Line";
                ReservationEntry."Source ID" := "Document No.";
                ReservationEntry."Source Ref. No." := "Line No.";
                ReservationEntry."Shipment Date" := WorkDate;
                ReservationEntry."Created By" := UserId;
                ReservationEntry."Qty. per Unit of Measure" := ItemLedgerEntry."Qty. per Unit of Measure";
                ReservationEntry."Planning Flexibility" := ReservationEntry."Planning Flexibility"::Unlimited;
                if (ReservationEntry."Serial No." = '') and (ReservationEntry."Lot No." <> '') then begin
                    if Abs("UndefinedQty.") = ItemLedgerEntry."Remaining Quantity" then begin
                        ReservationEntry."Quantity (Base)" := -ItemLedgerEntry."Remaining Quantity";
                        "UndefinedQty." := Abs("UndefinedQty.") - Abs(ReservationEntry."Quantity (Base)");
                    end else begin
                        if Abs("UndefinedQty.") > ItemLedgerEntry."Remaining Quantity" then begin
                            ReservationEntry."Quantity (Base)" := -ItemLedgerEntry."Remaining Quantity";
                            "UndefinedQty." := Abs("UndefinedQty.") - Abs(ItemLedgerEntry."Remaining Quantity");
                        end else begin
                            ReservationEntry."Quantity (Base)" := -"UndefinedQty.";
                            "UndefinedQty." := Abs("UndefinedQty.") - ItemLedgerEntry."Remaining Quantity";
                        end;
                    end;
                end else begin
                    ReservationEntry."Quantity (Base)" := -ItemLedgerEntry."Remaining Quantity";
                end;
                ReservationEntry.Validate(ReservationEntry."Quantity (Base)");

                /* TempReservationEntry.SETRANGE(TempReservationEntry."Item No.",ItemLedgerEntry."Item No.");
                TempReservationEntry.SETRANGE(TempReservationEntry."Serial No.",ItemLedgerEntry."Serial No.");
                TempReservationEntry.SETRANGE(TempReservationEntry."Lot No.",ItemLedgerEntry."Lot No.");
                TempReservationEntry.SETRANGE(TempReservationEntry."Source ID","Document No."); */

                TempReservationEntry.SetRange(TempReservationEntry."Item No.", ReservationEntry."Item No.");
                TempReservationEntry.SetRange(TempReservationEntry."Serial No.", ReservationEntry."Serial No.");
                TempReservationEntry.SetRange(TempReservationEntry."Lot No.", ReservationEntry."Lot No.");
                //TempReservationEntry.SETRANGE(TempReservationEntry."Source ID","Document No.");
                if not TempReservationEntry.Find('-') then begin
                    "Qty.Assigned" := "Qty.Assigned" + Abs(ReservationEntry."Quantity (Base)");
                    if ("Qty.Assigned" <= Quantity) and (ReservationEntry."Quantity (Base)" <> 0) then
                        ReservationEntry.Insert;
                end;
                Commit;
            until ItemLedgerEntry.Next = 0;
    END;


    PROCEDURE QCOverride();
    BEGIN
        if UserId = 'SUPER' then
            if "QC Enabled" = true then begin
                "QC Enabled" := false;
                Modify;
            end
            else
                Message('You Do not have permissions to run this functions');
    END;
}

