codeunit 50035 "Event Handling Cust"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        // Rev01>>
        CustLedgerEntry."DD/FDR No." := GenJournalLine."DD/FDR No.";
        CustLedgerEntry."Payment Through" := GenJournalLine."Payment Through";
        // Rev01<<
        CustLedgerEntry."Customer ord No" := GenJournalLine."Customer Ord no"; //srinivas
        CustLedgerEntry."Sale Order no" := GenJournalLine."Sale Order No";               //srinivas
        CustLedgerEntry."Payment Type" := GenJournalLine."Payment Type";//EFFUPG
        CustLedgerEntry."invoice no" := GenJournalLine."Invoice no";//EFFUPG
    end;



    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyVendLedgerEntryFromGenJnlLine(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        VendorLedgerEntry."Vendor Invoice Date" := GenJournalLine."Vendor Invoice Date";//EFFUPG
                                                                                        // Rev01>>
        VendorLedgerEntry."DD/FDR No." := GenJournalLine."DD/FDR No.";
        VendorLedgerEntry."Payment Through" := VendorLedgerEntry."Payment Through";

        // Rev01<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterAssignItemValues', '', false, false)]
    local procedure OnAfterAssignItemValues(var SalesLine: Record "Sales Line"; Item: Record Item)
    var

        PrepaymentMgt: Codeunit "Prepayment Mgt.";
        ProductionBOMHeader: Record "Production BOM Header";
        VersionMgt: Codeunit VersionManagement;
        SalesHeaderRDSO: Record "Sales Header";
        PrdOrder: Record "Production Order";
        rpoQty: Integer;
    begin
        //B2B
        SalesLine."Production BOM No." := Item."Production BOM No.";
        ProductionBOMHeader.SetRange("No.", SalesLine."Production BOM No.");
        if ProductionBOMHeader.Find('-') then
            SalesLine."Production Bom Version No." := VersionMgt.GetBOMVersion(ProductionBOMHeader."No.", WorkDate, true);
        SalesLine."Spec ID" := Item."Spec ID";
        SalesLine."QC Enabled" := Item."QC Enabled";
        //B2B
        //Added by Pranavi on 05-Dec-2015 for updating schedule item no if item is changed in sales line
        Schedule.Reset;
        Schedule.SetRange("Document Type", Schedule."Document Type"::Order);
        Schedule.SetRange("Document No.", SalesLine."Document No.");
        Schedule.SetRange("Document Line No.", SalesLine."Line No.");
        Schedule.SetRange(Schedule."Line No.", SalesLine."Line No.");
        Schedule.SetRange(Schedule."No.", SalesLine."No.");
        if Schedule.FindFirst then begin
            Schedule."No." := Item."No.";
            Schedule.Validate("No.");
        end;
        //End by Pranavi on 05-Dec-2015
    end;

    /*
        [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterTestStatusOpen', '', false, false)]
        local procedure OnAfterTestStatusOpen()
        begin
            // Added by Pranavi on 22-Jul-2016 for TIN No of vendor checking
            IF "Document Type" = "Document Type"::Order THEN BEGIN
                Vndr.RESET;
                Vndr.SETRANGE(Vndr."No.", PurchHeader."Buy-from Vendor No.");
                IF Vndr.FINDFIRST THEN
                    IF Vndr."Gen. Bus. Posting Group" <> 'FOREIGN' THEN
                        IF (Vndr."T.I.N. No." = '') AND (Vndr."T.I.N Status" IN [Vndr."T.I.N Status"::" ", Vndr."T.I.N Status"::TINAPPLIED]) THEN
                            ERROR('Please enter T.I.N Number in Vendor Card in Tax Information Tab!\IF TIN Not Applicable update TIN Status to TIN Invalid!');
            END;
            // end by pranavi
        end;
        */

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterCheckBuyFromVendor', '', false, false)]
    local procedure OnAfterCheckBuyFromVendor(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor)
    begin
        Vendor.TESTFIELD(Vendor."Updated in Cashflow", TRUE);
        PurchaseHeader."Buy-from Address 3" := Vendor."Address 3";
        //Structure:=Vend."Tax Area Code";
        //Structure := 'PURCH_GST';    //pranavi
        // VALIDATE(Structure, 'PURCH_GST');

        IF Vendor."Gen. Bus. Posting Group" = 'FOREIGN' THEN BEGIN
            PurchaseHeader."Shipment Method Code" := 'EX2';
        END
        ELSE BEGIN
            PurchaseHeader."Shipment Method Code" := 'DOD';
        END;
        // "Tax Area Code" := Vend."Tax Area Code";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidateOrderAddressCodeOnAfterCopyBuyFromVendorAddressFieldsFromVendor', '', false, false)]
    local procedure OnValidateOrderAddressCodeOnAfterCopyBuyFromVendorAddressFieldsFromVendor(var PurchaseHeader: Record "Purchase Header"; Vend: Record Vendor);
    var
        OrderAddr: Record "Order Address";
    begin
        // << Pranavi
        PurchaseHeader.State := OrderAddr.State;
        IF OrderAddr."GST Registration No." <> '' THEN
            IF PurchaseHeader."GST Vendor Type" <> PurchaseHeader."GST Vendor Type"::Registered THEN
                PurchaseHeader."GST Vendor Type" := PurchaseHeader."GST Vendor Type"::Registered;
        // << Pranavi

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnUpdatePurchLinesByFieldNoOnBeforeLineModify', '', false, false)]
    local procedure OnUpdatePurchLinesByFieldNoOnBeforeLineModify(var PurchaseHeader: Record "Purchase Header"; var xPurchaseHeader: Record "Purchase Header"; PurchaseLine: Record "Purchase Line")
    begin
        // EFFUPG>>
        /*
        IF "Form Code" <> 'NONE' THEN
            PurchaseLine."Form Code" := "Form Code" //B2B
        ELSE
            PurchaseLine."Form Code" := '';
            */
        // EFFUPG<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnValidateItemNoOnAfterGetItem', '', false, false)]
    local procedure OnValidateItemNoOnAfterGetItem(var ItemJournalLine: Record "Item Journal Line"; Item: Record Item)
    var
        PostedMatIssHdr: Record "Posted Material Issues Header";
    begin
        // Conditon Added by Pranavi on 11-Jan-2016 for allowing blocked item for site stock updation purpose
        if not ((ItemJournalLine."Journal Batch Name" = 'POS-CS-SIG') and (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Positive Adjmt.")) then
            if PostedMatIssHdr.Get(ItemJournalLine."Document No.") then begin
                if not (((PostedMatIssHdr."Transfer-from Code" = 'SITE') and (PostedMatIssHdr."Transfer-to Code" = 'CS')) or
                        ((PostedMatIssHdr."Transfer-from Code" = 'CS') and (PostedMatIssHdr."Transfer-to Code" = 'SITE'))) then
                    Item.TestField(Blocked, false);
            end
            else
                Item.TestField(Blocked, false);

        Item.TestField(Type, Item.Type::Inventory);
        if ItemJournalLine."Value Entry Type" = ItemJournalLine."Value Entry Type"::Revaluation then
            Item.TestField("Inventory Value Zero", false);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnSetUpNewLineOnAfterFindItemJnlLine', '', false, false)]
    local procedure OnSetUpNewLineOnAfterFindItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; var FirstItemJournalLine: Record "Item Journal Line"; var LastItemJnlLine: Record "Item Journal Line")
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlTemplate: Record "Item Journal Template";
    begin
        //B2B - Con
        //"Document No." := NoSeriesMgt.TryGetNextNo(ItemJnlBatch."No. Series","Posting Date");
        ItemJournalLine."Document No." := NoSeriesMgt.GetNextNo(ItemJnlBatch."No. Series", ItemJournalLine."Posting Date", false);
        //B2B - Con

        if (ItemJnlTemplate.Type in [ItemJnlTemplate.Type::Consumption, ItemJnlTemplate.Type::Output]) and not MfgSetup."Doc. No. Is Prod. Order No."
        then
            if ItemJnlBatch."No. Series" <> '' then begin
                Clear(NoSeriesMgt);
                ItemJournalLine."Document No." := NoSeriesMgt.GetNextNo(ItemJnlBatch."No. Series", ItemJournalLine."Posting Date", false);
            end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Line", 'OnAfterInitFromSalesLine', '', false, false)]
    local procedure OnAfterInitFromSalesLine(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line")
    begin
        SalesInvLine."Schedule Type" := SalesLine."Schedule Type"; //EFFUPG
        SalesInvLine."Order No." := SalesLine."Document No.";//EFFUPG
        SalesInvLine."Order Line No." := SalesLine."Line No.";   // pranavi added on 23-mar-2016
        SalesInvLine."External Document No." := SalesInvHeader."External Document No.";//EFFUPG
        SalesInvLine."Supply Portion" := SalesLine."Supply Portion";//EFFUPG
        SalesInvLine."Retention Portion" := SalesLine."Retention Portion";//EFFUPG
        SalesInvLine."Schedule No" := SalesLine."Schedule No";//EFFUPG
        SalesInvLine."Amount to Customer" := 0;//EFFUPG1.7
        SalesInvLine."GST Amount" := 0;//EFFUPG1.7
    end;

    //>>CU99000773
    [EventSubscriber(ObjectType::Codeunit, 99000773, 'OnAfterTransferRoutingLine', '', false, false)]
    procedure OnTransferRoutingOnBeforeCalcRoutingCostPerUnit(var ProdOrderRoutingLine: Record "Prod. Order Routing Line"; ProdOrderLine: Record "Prod. Order Line"; RoutingLine: Record "Routing Line")
    Var
        RPO: Record 5405;
    begin
        RPO.RESET;
        RPO.SETRANGE("No.", ProdOrderLine."Prod. Order No.");
        RPO.SETFILTER("Prod Start date", '<>%1', 0D);
        IF RPO.FINDSET THEN
            Planned_day := RPO."Prod Start date";

        //B2B
        ProdOrderRoutingLine."Operation Description" := RoutingLine."Operation Description";
        ProdOrderRoutingLine."Item No." := ProdOrderLine."Item No.";
        ProdOrderRoutingLine."Item Description" := ProdOrderLine.Description;
        ProdOrderRoutingLine."QAS/MPR" := RoutingLine."QAS/MPR";
        //B2B

        //B2B
        //QC
        ProdOrderRoutingLine."Sub Assembly" := RoutingLine."Sub Assembly";
        ProdOrderRoutingLine."Sub Assembly Description" := RoutingLine."Sub Assembly Description";
        ProdOrderRoutingLine."QC Enabled" := RoutingLine."QC Enabled";
        ProdOrderRoutingLine."Spec Id" := RoutingLine."Spec Id";
        ProdOrderRoutingLine.Quantity := RoutingLine."Qty. Produced" * ProdOrderLine.Quantity;
        ProdOrderRoutingLine."Qty.To Produce" := RoutingLine."Qty. Produced" * ProdOrderLine.Quantity;
        ProdOrderRoutingLine."Sub Assembly Unit Of Meas.Code" := RoutingLine."Sub Assembly Unit of Meas.Code";
        //QC
        //B2B

        IF ((FORMAT(RoutingLine.Start_Day) <> '0D') AND (Planned_day <> 0D)) THEN
            ProdOrderRoutingLine.PlannedStartDate := CALCDATE(RoutingLine.Start_Day, Planned_day);
        //  ELSE
        // ProdOrderRtngLine.PlannedStartDate := Planned_day;
    end;



    [EventSubscriber(ObjectType::Codeunit, 99000773, 'OnTransferBOMProcessItemOnBeforeGetPlanningParameters', '', false, false)]
    local procedure UpdateOnTransferBOMProcessItemOnBeforeGetPlanningParameters(var ProdOrderComponent: Record "Prod. Order Component"; ProductionBOMLine: Record "Production BOM Line")
    var
        Item: Record 27;
        ComponentSKU: Record 5700;
        Alt: Record 60045;
        Item2: Record 27;
        ProdOrderStDate: Record "Production Order";
    begin
        Item.GET(ProductionBOMLine."No.");
        //code added by vijaya on 22*-08-2018
        //IF (Item."Product Group Code" = 'CPCB') AND (AlternatePCB_BOM = TRUE) THEN BEGIN //B2BUPG
        IF (Item."Product Group Code Cust" = 'CPCB') AND (ProdOrder.AlternatePCB_BOM) THEN BEGIN
            Alt.RESET;
            Alt.SETRANGE("Item No.", Item."No.");
            Alt.SETFILTER("Proudct Type", '%1|%2', 'ALL PRODUCTS', ProdOrder."Item Sub Group Code");
            IF Alt.FINDFIRST THEN BEGIN
                IF Alt."Alternative Item No." <> '' THEN BEGIN
                    Item.GET(Alt."Alternative Item No.");
                    ProdOrderComponent.VALIDATE("Item No.", Item."No.");
                    ProdOrderComponent.Description := Item.Description;
                END ELSE BEGIN
                    ProdOrderComponent.VALIDATE("Item No.", ProductionBOMLine."No.");
                    ProdOrderComponent.Description := ProductionBOMLine.Description;
                END;
            END ELSE BEGIN
                ProdOrderComponent.VALIDATE("Item No.", ProductionBOMLine."No.");
                ProdOrderComponent.Description := ProductionBOMLine.Description;
            END;
        END ELSE
            ProdOrderComponent.VALIDATE("Item No.", ProductionBOMLine."No.");


        ProdOrderComponent."Material Required Day" := ProductionBOMLine."Material Reqired Day";
        // ADDED BY SANTHOSH FOR PROD START DATE UPDATION
        ProdOrderStDate.RESET;
        //IF ProdOrderStDate.GET(ProdOrderStDate.Status::Released, ProdOrderLine."Prod. Order No.") THEN
        IF ProdOrderStDate.GET(ProdOrderStDate.Status::Released, ProdOrderComponent."Prod. Order No.") THEN
            ProdOrderComponent."Production Plan Date" := ProdOrderStDate."Prod Start date";

        //B2B
        ProdOrderComponent."Position 4" := ProductionBOMLine."Position 4";
        ProdOrderComponent."BOM Type" := ProductionBOMLine."BOM Type";
        ProdOrderComponent."Type of Solder" := ProductionBOMLine."Type of Solder";
        IF Item2.GET(ProdOrderComponent."Item No.") THEN BEGIN
            IF Item2."Invert Solder type" = TRUE THEN BEGIN
                IF Item2."Type of Solder" = Item2."Type of Solder"::DIP THEN
                    ProdOrderComponent."Type of Solder2" := 'SMD'
                ELSE
                    IF (Item2."Type of Solder" = Item2."Type of Solder"::SMD) THEN
                        ProdOrderComponent."Type of Solder2" := 'DIP';
            END
            ELSE
                ProdOrderComponent."Type of Solder2" := FORMAT(Item2."Type of Solder");
        END;
        //B2B
    end;

    procedure ALternateBOMReplace(Alternate_BOM: Boolean)

    begin
        AlternatePCB_BOM := Alternate_BOM;
    end;
    //<<CU99000773


    //>> CU99000787
    PROCEDURE SetScheduleLine(ScheduleLine2: Record 60095);
    BEGIN
        ScheduleLine := ScheduleLine2;
        ScheduleLineIsSet := TRUE;
    END;


    PROCEDURE CopySchdl(ProdOrder2: Record 5405; Direction: Option Forward,Backward; VariantCode: Code[10]; LetDueDateDecrease: Boolean): Boolean;
    VAR
        ErrorOccured: Boolean;
    BEGIN
        MfgSetup.GET;

        ProdOrder2.TESTFIELD("Source No.");
        //ProdOrder2.TESTFIELD("Starting Time");
        //ProdOrder2.TESTFIELD("Starting Date");
        ProdOrder2.TESTFIELD("Starting Date-Time");
        //ProdOrder2.TESTFIELD("Ending Time");
        //ProdOrder2.TESTFIELD("Ending Date");
        ProdOrder2.TESTFIELD("Ending Date-Time");
        IF Direction = Direction::Backward THEN
            ProdOrder2.TESTFIELD("Due Date");

        ProdOrder := ProdOrder2;

        ProdOrderLine.LOCKTABLE;
        ProdOrderLine.SETRANGE(Status, ProdOrder.Status);
        ProdOrderLine.SETRANGE("Prod. Order No.", ProdOrder."No.");
        ProdOrderLine.DELETEALL(TRUE);

        NextProdOrderLineNo := 10000;

        InsertNew := FALSE;
        CASE ProdOrder."Source Type" OF
            ProdOrder."Source Type"::Item:
                BEGIN
                    Item.GET(ProdOrder."Source No.");
                    InitProdOrderLine(ProdOrder."Source No.", VariantCode, ProdOrder."Location Code");
                    ProdOrderLine."Variant Code" := VariantCode;
                    ProdOrderLine.Description := ProdOrder.Description;
                    ProdOrderLine."Description 2" := ProdOrder."Description 2";
                    ProdOrderLine.VALIDATE(Quantity, ProdOrder.Quantity);
                    ProdOrderLine.UpdateDatetime;
                    IF ScheduleLineIsSet THEN
                        CopyDimFromScheduleLine(ScheduleLine, ProdOrderLine);
                    ProdOrderLine.INSERT;
                    IF ProdOrderLine.HasErrorOccured THEN
                        ErrorOccured := TRUE;
                END;

            /*             ProdOrder."Source Type"::Family:
                            IF NOT CopyFromFamily THEN
                                ErrorOccured := TRUE; */
            ProdOrder."Source Type"::"Sales Header":
                BEGIN
                    InsertNew := TRUE;
                    IF ProdOrder.Status <> ProdOrder.Status::Simulated THEN
                        SalesHeader.GET(SalesHeader."Document Type"::Order, ProdOrder."Source No.")
                    ELSE
                        SalesHeader.GET(SalesHeader."Document Type"::Quote, ProdOrder."Source No.");
                    IF NOT CopyFromSchdlOrder THEN
                        ErrorOccured := TRUE;
                END;
        END;

        IF NOT ProcessProdOrderLines(Direction, LetDueDateDecrease) THEN
            ErrorOccured := TRUE;
        //CheckMultiLevelStructure(Direction, TRUE, LetDueDateDecrease); //Tempjuly
        EXIT(NOT ErrorOccured);
    END;

    PROCEDURE CopyDimFromScheduleLine(ScheduleLine: Record 60095; VAR ProdOrderLine: Record 5406);
    VAR
        SalesLine: Record 37;
    BEGIN
        IF SalesLine.GET(SalesLine."Document Type"::Order, ScheduleLine."Document No.", ScheduleLine."Document Line No.") THEN BEGIN
            ProdOrderLine."Shortcut Dimension 1 Code" := SalesLine."Shortcut Dimension 1 Code";
            ProdOrderLine."Shortcut Dimension 2 Code" := SalesLine."Shortcut Dimension 2 Code";
            ProdOrderLine."Dimension Set ID" := SalesLine."Dimension Set ID";
        END;
    END;

    LOCAL PROCEDURE CopyFromSchdlOrder(): Boolean;
    VAR
        SalesPlanLine: record 99000800 temporary;
        LeadTimeMgt: Codeunit 5404;
        ItemTrackingMgt: Codeunit 6500;
        ErrorOccured: Boolean;

    BEGIN
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
            ScheduleLine.SETRANGE("Document Type", ScheduleLine."Document Type"::Order)
        else
            if SalesHeader."Document Type" = SalesHeader."Document Type"::"Blanket Order" then
                ScheduleLine.SETRANGE("Document Type", ScheduleLine."Document Type"::"Blanket Order");
        ScheduleLine.SETRANGE("Document No.", SalesHeader."No.");
        IF ScheduleLine.FINDSET THEN
            REPEAT
                ScheduleLine.CALCFIELDS("Reserved Quantity");
                IF (ScheduleLine.Type::Item = SalesLine.Type::Item) AND
                   (ScheduleLine."No." <> '') AND (ScheduleLine."Document Line No." <> ScheduleLine."Line No.") AND
                   ((ScheduleLine."Outstanding Qty." - ScheduleLine."Reserved Quantity") <> 0)
                THEN BEGIN
                    Item.GET(ScheduleLine."No.");
                    IF Item."Replenishment System" = Item."Replenishment System"::"Prod. Order" THEN BEGIN
                        SalesPlanLine.INIT;
                        SalesPlanLine."Sales Order No." := ScheduleLine."Document No.";
                        SalesPlanLine."Sales Order Line No." := ScheduleLine."Document Line No.";
                        SalesPlanLine."Schedule Line No." := ScheduleLine."Line No.";
                        SalesPlanLine."Item No." := ScheduleLine."No.";
                        SalesPlanLine."Low-Level Code" := Item."Low-Level Code";
                        SalesPlanLine.INSERT;
                    END;
                END;
            UNTIL ScheduleLine.NEXT = 0;

        SalesPlanLine.SETCURRENTKEY("Low-Level Code");
        IF SalesPlanLine.FINDSET THEN
            REPEAT
                ScheduleLine.GET(SalesHeader."Document Type",
                  SalesPlanLine."Sales Order No.",
                  SalesPlanLine."Sales Order Line No.", SalesPlanLine."Schedule Line No.");
                SalesLine.GET(
                  SalesHeader."Document Type",
                  SalesPlanLine."Sales Order No.",
                  SalesPlanLine."Sales Order Line No.");
                ScheduleLine.CALCFIELDS("Reserved Quantity");
                Item.GET(ScheduleLine."No.");

                InitProdOrderLine(SalesLine."No.", SalesLine."Variant Code", SalesLine."Location Code");
                ProdOrderLine."Variant Code" := ScheduleLine."Variant Code";
                ProdOrderLine.Description := ScheduleLine.Description;
                // ProdOrderLine."Description 2" := SalesLine."Description 2";
                ScheduleLine.CALCFIELDS("Reserved Qty. (Base)");
                ProdOrderLine.VALIDATE("Quantity (Base)", ScheduleLine."Outstanding Qty.(Base)" - ScheduleLine."Reserved Qty. (Base)");
                ProdOrderLine."Location Code" := ScheduleLine."Location Code";
                ProdOrderLine."Bin Code" := ScheduleLine."Bin Code";
                ProdOrderLine."Due Date" := SalesLine."Shipment Date";
                ProdOrderLine."Ending Date" :=
                  LeadTimeMgt.PlannedEndingDate(
                    ProdOrderLine."Item No.",
                    ProdOrderLine."Location Code",
                    '',
                    ProdOrderLine."Due Date",
                    '',
                    2);
                ProdOrderLine.VALIDATE("Ending Date");

                //  InsertProdOrderLine;
                ProdOrderLine.Insert();
                IF ProdOrderLine.HasErrorOccured THEN
                    ErrorOccured := TRUE;
                ItemTrackingMgt.CopyItemTracking(ScheduleLine.RowID1, ProdOrderLine.RowID1, TRUE, TRUE);

                IF SalesLine."Document Type" = SalesLine."Document Type"::Order THEN BEGIN // Not simulated
                    ReserveSalesLine.SetBinding(ReservEntry.Binding::"Order-to-Order");
                    ProdOrderLine.CALCFIELDS("Reserved Quantity", "Reserved Qty. (Base)");

                    //ReservMgt.CreateTrackingSpecification
                    CallTrackingSpecification.InitTrackingSpecification(DATABASE::"Prod. Order Line",
                      ProdOrderLine.Status, ProdOrderLine."Prod. Order No.", '', ProdOrderLine."Line No.", 0,
                      ProdOrderLine."Variant Code", ProdOrderLine."Location Code", '', '',
                      ProdOrderLine."Qty. per Unit of Measure");

                    ReserveSalesLine.CreateReservationSetFrom(TrackingSpecification);

                    ReserveSalesLine.CreateReservation(
                      SalesLine, ProdOrderLine.Description, ProdOrderLine."Ending Date",
                      ProdOrderLine."Remaining Quantity" - ProdOrderLine."Reserved Quantity",
                      ProdOrderLine."Remaining Qty. (Base)" - ProdOrderLine."Reserved Qty. (Base)", ReservEntry);//Parameterrs changed in BC
                END;
                CopyDimFromScheduleLine(ScheduleLine, ProdOrderLine);
                ProdOrderLine.MODIFY;
            UNTIL (SalesPlanLine.NEXT = 0);
        EXIT(NOT ErrorOccured);
    END;

    //<<cu 99000787

    LOCAL PROCEDURE ProcessProdOrderLines(Direction: Option Forward,Backward; LetDueDateDecrease: Boolean): Boolean;
    VAR
        ErrorOccured: Boolean;
    BEGIN
        ProdOrderLine.SETRANGE(Status, ProdOrder.Status);
        ProdOrderLine.SETRANGE("Prod. Order No.", ProdOrder."No.");

        IF ProdOrderLine.FINDSET(TRUE) THEN
            REPEAT
                //added by Vijaya on 22-08-2018 for PCB Rplace with Alternate
                //CalcProdOrder.ALternateBOMReplace(Alternate_PCB_Replace);//Tempjuly
                CalcProdOrder.SetParameter(TRUE);
                IF NOT CalcProdOrder.Calculate(ProdOrderLine, Direction, TRUE, TRUE, TRUE, LetDueDateDecrease) THEN
                    ErrorOccured := TRUE;
            UNTIL ProdOrderLine.NEXT = 0;
        ProdOrder.AdjustStartEndingDate;
        ProdOrder.MODIFY;

        EXIT(NOT ErrorOccured);
    END;


    local procedure InitProdOrderLine(ItemNo: Code[20]; VariantCode: Code[10]; LocationCode: Code[10])
    var
        Item: Record Item;
        IsHandled: Boolean;
    begin
        ProdOrderLine.Init();
        ProdOrderLine.SetIgnoreErrors;
        ProdOrderLine.Status := ProdOrder.Status;
        ProdOrderLine."Prod. Order No." := ProdOrder."No.";
        ProdOrderLine."Line No." := NextProdOrderLineNo;
        ProdOrderLine."Routing Reference No." := ProdOrderLine."Line No.";
        ProdOrderLine.Validate("Item No.", ItemNo);
        ProdOrderLine."Location Code" := LocationCode;
        ProdOrderLine.Validate("Variant Code", VariantCode);

        if (LocationCode = ProdOrder."Location Code") and (ProdOrder."Bin Code" <> '') then
            ProdOrderLine.Validate("Bin Code", ProdOrder."Bin Code")
        else
            CalcProdOrder.SetProdOrderLineBinCodeFromRoute(ProdOrderLine, ProdOrderLine."Location Code", ProdOrderLine."Routing No.");

        Item.Get(ItemNo);
        ProdOrderLine."Scrap %" := Item."Scrap %";
        ProdOrderLine."Due Date" := ProdOrder."Due Date";
        ProdOrderLine."Starting Date" := ProdOrder."Starting Date";
        ProdOrderLine."Starting Time" := ProdOrder."Starting Time";
        ProdOrderLine."Ending Date" := ProdOrder."Ending Date";
        ProdOrderLine."Ending Time" := ProdOrder."Ending Time";
        ProdOrderLine."Planning Level Code" := 0;
        ProdOrderLine."Inventory Posting Group" := Item."Inventory Posting Group";
        ProdOrderLine.UpdateDatetime;
        ProdOrderLine.Validate("Unit Cost");

        NextProdOrderLineNo := NextProdOrderLineNo + 10000;
    end;







    //>>CU CopyBomVersion
    PROCEDURE CopyBomVersion(BOMHeaderNo: Code[20]; FromVersionCode: Code[10]; CurrentBOMHeader: Record 99000779; ToVersionCode: Code[10]);
    VAR
        FromProdBOMComponent: Record 99000772;
        ToProdBOMComponent: Record 99000772;
        FromProdBOMCompComment: Record 99000776;
        ToProdBOMCompComment: Record 99000776;
        ProdBomVersion: Record 99000779;
        LineNo1: Integer;
        LineNo2: Integer;
        Text000: Label 'The %1 cannot be copied to itself.';
        Text001: Label '%1 on %2 %3 must not be %4';
        Text002: Label '%1 on %2 %3 %4 must not be %5';
    BEGIN
        IF (CurrentBOMHeader."Production BOM No." = BOMHeaderNo) AND
          (FromVersionCode = ToVersionCode)
        THEN
            ERROR(Text000, CurrentBOMHeader.TABLECAPTION);

        IF ToVersionCode = '' THEN BEGIN
            IF CurrentBOMHeader.Status = CurrentBOMHeader.Status::Certified THEN
                ERROR(
                  Text001,
                  CurrentBOMHeader.FIELDCAPTION(Status),
                  CurrentBOMHeader.TABLECAPTION,
                  CurrentBOMHeader."Production BOM No.",
                  CurrentBOMHeader.Status);
        END ELSE BEGIN
            ProdBomVersion.GET(
              CurrentBOMHeader."Production BOM No.", ToVersionCode);
            IF ProdBomVersion.Status = ProdBomVersion.Status::Certified THEN
                ERROR(
                  Text002,
                  ProdBomVersion.FIELDCAPTION(Status),
                  ProdBomVersion.TABLECAPTION,
                  ProdBomVersion."Production BOM No.",
                  ProdBomVersion."Version Code",
                  ProdBomVersion.Status);
        END;

        FromProdBOMComponent.SETRANGE("Production BOM No.", BOMHeaderNo);
        FromProdBOMComponent.SETRANGE("Version Code", FromVersionCode);

        IF FromProdBOMComponent.FINDFIRST THEN
            REPEAT
                ToProdBOMComponent.SETRANGE("Production BOM No.", CurrentBOMHeader."Production BOM No.");
                ToProdBOMComponent.SETRANGE("Version Code", ToVersionCode);
                IF ToProdBOMComponent.FINDLAST THEN
                    LineNo1 := ToProdBOMComponent."Line No."
                ELSE
                    LineNo1 := 0;
                ToProdBOMComponent := FromProdBOMComponent;
                ToProdBOMComponent."Production BOM No." := CurrentBOMHeader."Production BOM No.";
                ToProdBOMComponent."Version Code" := ToVersionCode;
                ToProdBOMComponent."Line No." := LineNo1 + 10000;
                ToProdBOMComponent.INSERT;
            UNTIL FromProdBOMComponent.NEXT = 0;

        FromProdBOMCompComment.SETRANGE("Production BOM No.", BOMHeaderNo);
        FromProdBOMCompComment.SETRANGE("Version Code", FromVersionCode);

        IF FromProdBOMCompComment.FINDFIRST THEN
            REPEAT
                ToProdBOMCompComment.SETRANGE("Production BOM No.", CurrentBOMHeader."Production BOM No.");
                ToProdBOMCompComment.SETRANGE("Version Code", ToVersionCode);
                IF ToProdBOMCompComment.FINDLAST THEN
                    LineNo2 := ToProdBOMCompComment."Line No."
                ELSE
                    LineNo2 := 0;
                ToProdBOMCompComment := FromProdBOMCompComment;
                ToProdBOMCompComment."Production BOM No." := CurrentBOMHeader."Production BOM No.";
                ToProdBOMCompComment."Version Code" := ToVersionCode;
                ToProdBOMCompComment."Line No." := LineNo2 + 10000;
                ToProdBOMCompComment.INSERT;
            UNTIL FromProdBOMCompComment.NEXT = 0;
    END;

    //<<CU CopyBomVersion

    PROCEDURE CreateReservationSchedule(VAR ScheduleLine: Record 60095; Description: Text[50]; ExpectedReceiptDate: Date; Quantity: Decimal; QuantityBase: Decimal; ForSerialNo: Code[20]; ForLotNo: Code[20]);
    VAR
        ShipmentDate: Date;
        SignFactor: Integer;
        SalesLine: Record 37;
        CreateReservEntry: Codeunit 99000830;
        SetFromType: Option " ",Sales,"Requisition Line",Purchase,"Item Journal","BOM Journal","Item Ledger Entry",Service,Job;
        SetFromSubtype: Integer;
        SetFromID: Code[20];
        SetFromBatchName: Code[10];
        SetFromProdOrderLine: Integer;
        SetFromRefNo: Integer;
        SetFromVariantCode: Code[10];
        SetFromLocationCode: Code[10];
        SetFromSerialNo: Code[20];
        SetFromLotNo: Code[20];
        CodeunitInitErr: Label 'Codeunit is not initialized correctly.';
        ReservedQtyTooLargeErr: Label 'Reserved quantity cannot be greater than %1.';
        SetFromQtyPerUOM: Decimal;
    BEGIN
        IF SetFromType = 0 THEN
            ERROR(CodeunitInitErr);
        SalesLine.GET(FORMAT(ScheduleLine."Document Type"), ScheduleLine."Document No.", ScheduleLine."Document Line No.");
        ScheduleLine.TESTFIELD(Type, ScheduleLine.Type::Item);
        ScheduleLine.TESTFIELD("No.");
        //ScheduleLine.TESTFIELD("Shipment Date");
        ScheduleLine.CALCFIELDS("Reserved Qty. (Base)");
        IF ABS(ScheduleLine."Outstanding Qty.(Base)") < ABS(ScheduleLine."Reserved Qty. (Base)") + QuantityBase THEN
            ERROR(
              ReservedQtyTooLargeErr,
              ABS(ScheduleLine."Outstanding Qty.(Base)") - ABS(ScheduleLine."Reserved Qty. (Base)"));

        ScheduleLine.TESTFIELD("Variant Code", SetFromVariantCode);
        ScheduleLine.TESTFIELD("Location Code", SetFromLocationCode);

        /*       IF SalesLine."Document Type" = SalesLine."Document Type"::"Return Order" THEN
                    SignFactor := 1
                ELSE */

        SignFactor := -1;

        IF QuantityBase * SignFactor < 0 THEN
            ShipmentDate := SalesLine."Shipment Date"
        ELSE BEGIN
            ShipmentDate := ExpectedReceiptDate;
            ExpectedReceiptDate := SalesLine."Shipment Date";
        END;
        //parameters changed in higher version
        CreateReservEntry.CreateReservEntryFor(
          DATABASE::Schedule2, SalesLine."Document Type",
          ScheduleLine."Document No.", '', ScheduleLine."Line No.", ScheduleLine."Document Line No.", ScheduleLine."Qty. per Unit of Measure",
          Quantity, QuantityBase, ReservEntry);
        //parameters changed in higher version
        //  CreateReservEntry.CreateReservEntryFrom(ReservEntry);
        CreateReservEntry.CreateReservEntry(
          ScheduleLine."No.", ScheduleLine."Variant Code", ScheduleLine."Location Code",
          Description, ExpectedReceiptDate, ShipmentDate);//EFFUPG -Deleted Parameter(0)

        SetFromType := 0;
    END;

    /*PROCEDURE CreateReservEntryFor(ForType: Option; ForSubtype: Integer; ForID: Code[20]; ForBatchName: Code[10]; ForProdOrderLine: Integer; ForRefNo: Integer; ForQtyPerUOM: Decimal; Quantity: Decimal; QuantityBase: Decimal; ForSerialNo: Code[20]; ForLotNo: Code[20]);
    VAR
        sign: Integer;
        InsertReservEntry: Record 37;
    BEGIN
        InsertReservEntry."Source Type" := ForType;
        InsertReservEntry."Source Subtype" := ForSubtype;
        InsertReservEntry."Source ID" := ForID;
        InsertReservEntry."Source Batch Name" := ForBatchName;
        InsertReservEntry."Source Prod. Order Line" := ForProdOrderLine;
        InsertReservEntry."Source Ref. No." := ForRefNo;
        sign := SignFactor(InsertReservEntry);
        InsertReservEntry.Quantity := sign * Quantity;
        InsertReservEntry."Quantity (Base)" := sign * QuantityBase;
        InsertReservEntry."Qty. per Unit of Measure" := ForQtyPerUOM;
        InsertReservEntry."Serial No." := ForSerialNo;
        InsertReservEntry."Lot No." := ForLotNo;

        InsertReservEntry.TESTFIELD("Qty. per Unit of Measure");
    END;*/
    /* PROCEDURE CreateReservEntryFrom(FromType: Option; FromSubtype: Integer; FromID: Code[20]; FromBatchName: Code[10]; FromProdOrderLine: Integer; FromRefNo: Integer; FromQtyPerUOM: Decimal; FromSerialNo: Code[20]; FromLotNo: Code[20]);
     var
         InsertReservEntry2: Record 37;
     BEGIN
         InsertReservEntry2."Source Type" := FromType;
         InsertReservEntry2."Source Subtype" := FromSubtype;
         InsertReservEntry2."Source ID" := FromID;
         InsertReservEntry2."Source Batch Name" := FromBatchName;
         InsertReservEntry2."Source Prod. Order Line" := FromProdOrderLine;
         InsertReservEntry2."Source Ref. No." := FromRefNo;
         InsertReservEntry2."Qty. per Unit of Measure" := FromQtyPerUOM;
         InsertReservEntry2."Serial No." := FromSerialNo;
         InsertReservEntry2."Lot No." := FromLotNo;

         InsertReservEntry2.TESTFIELD("Qty. per Unit of Measure");
     END;*/


    procedure CreateProdOrder2(SalesLine: Record "Sales Line"; ProdOrderStatus: Option Quote,Planned,"Firm Planned",Released; OrderType: option ItemOrder,ProjectOrder; QtyParam: Decimal);
    var
        ManufSetup: Record "Manufacturing Setup";
        SOProdOrderDetails: Record "SO Prod.Order Details";
        ReservQty: Decimal;
        ProdOrderStatusMgt: Codeunit "Prod. Order Status Management";
        prmRefresh: Codeunit SQLIntegration;
    begin
        ProdOrder.INIT;
        ProdOrder.Status := ProdOrderStatus;
        ProdOrder."No." := '';
        ProdOrder.INSERT(TRUE);

        ProdOrder."Starting Date" := WORKDATE;
        ProdOrder."Creation Date" := WORKDATE;
        ProdOrder."Due Date" := SalesLine."Prod. Due Date";
        //ProdOrder."Ending Date" := SalesLine."Shipment Date"-1;
        ProdOrder."Ending Date" := SalesLine."Prod. Due Date";
        ProdOrder."Low-Level Code" := 1;
        ProdOrder."Gen. Bus. Posting Group" := SalesLine."Gen. Bus. Posting Group";
        IF OrderType = OrderType::ProjectOrder THEN BEGIN
            ProdOrder."Source Type" := ProdOrder."Source Type"::"Sales Header";
            ProdOrder.VALIDATE("Source No.", SalesLine."Document No.");
            ProdOrder.VALIDATE("Sell-to Customer Name", SalesLine."Sell-to Customer Name"); // Added by Suvarchala 
            ProdOrder.VALIDATE("Source No.");
        END ELSE BEGIN
            ProdOrder."Source Type" := ProdOrder."Source Type"::Item;
            ProdOrder.VALIDATE("Source No.", SalesLine."No.");
            ProdOrder.VALIDATE("Source No."); // added by Vishnu Priya on 08-05-2020 for the No.of Units calculation
            Item.RESET;
            Item.SETFILTER(Item."No.", SalesLine."No.");
            IF Item.FINDFIRST THEN          //pranavi on 13-10-2015
                ProdOrder.VALIDATE(Description, Item.Description)
            ELSE
                ProdOrder.VALIDATE(Description, SalesLine.Description);
            ProdOrder."Product Group Code" := Item."Product Group Code Cust";//EFF161122
            ManufSetup.GET;
            ProdOrder."Location Code" := ManufSetup."Production Location";
            ProdOrder."Bin Code" := SalesLine."Bin Code";
            ProdOrder."Sales Order No." := SalesLine."Document No.";
            ProdOrder."Sell-to Customer Name" := SalesLine."Sell-to Customer Name"; //Added by Suvarchala
            ProdOrder."Sales Order Line No." := SalesLine."Line No.";
            SalesLine.CALCFIELDS("Reserved Qty. (Base)");
            //ProdOrder.Quantity :=  SalesLine."Outstanding Qty. (Base)" - SalesLine."Reserved Qty. (Base)";
            ProdOrder.Quantity := QtyParam;
        END;
        //IF DisProductionStartDate THEN BEGIN
        ProdOrder."Prod Start date" := TODAY;
        ProdOrder."Planned Dispatch Date" := CALCDATE('1M', TODAY);
        //END;
        ProdOrder.MODIFY;

        ProdOrder.SETRANGE("No.", ProdOrder."No.");
        CreateProdOrderLines.SetSalesLine(SalesLine);
        CreateProdOrderLines.Copy(ProdOrder, 1, SalesLine."Variant Code", TRUE);//EFFUPG Added "TRUE"
                                                                                //added by vijaya 21-08-2018 for Alternate PCB Replacement

        SOProdOrderDetails.INIT;
        SOProdOrderDetails.Type := SOProdOrderDetails.Type::"Prod. Order";
        SOProdOrderDetails."Sales Order No." := SalesLine."Document No.";
        SOProdOrderDetails."Sales Order Line No." := SalesLine."Line No.";
        SOProdOrderDetails."No." := ProdOrder."No.";
        SOProdOrderDetails.Quantity := 1;
        SOProdOrderDetails.Status := SOProdOrderDetails.Status::Released;
        SOProdOrderDetails.INSERT;

        IF ProdOrder."Source Type" = ProdOrder."Source Type"::Item THEN BEGIN
            ProdOrderLine.SETRANGE(Status, ProdOrder.Status);
            ProdOrderLine.SETRANGE("Prod. Order No.", ProdOrder."No.");

            IF ProdOrderLine.FINDFIRST THEN BEGIN
                CLEAR(ReservMgt);
                SalesLine.CALCFIELDS("Reserved Qty. (Base)");
                IF ProdOrderLine."Remaining Qty. (Base)" > (SalesLine."Outstanding Qty. (Base)" - SalesLine."Reserved Qty. (Base)") THEN
                    ReservQty := (SalesLine."Outstanding Qty. (Base)" - SalesLine."Reserved Qty. (Base)")
                ELSE
                    ReservQty := ProdOrderLine."Remaining Qty. (Base)";
                /*
ReservMgt.SetProdOrderLine(ProdOrderLine);
            ReservEntry."Source Type" :=
              DATABASE::"Sales Line";
            ReserveSalesLine.SetBinding(ReservEntry.Binding::"Order-to-Order");
            ReserveSalesLine.CreateReservationSetFrom(
              DATABASE::"Prod. Order Line",
              ProdOrderLine.Status,
              ProdOrderLine."Prod. Order No.",
              '',
              ProdOrderLine."Line No.", 0,
              ProdOrderLine."Variant Code",
              ProdOrderLine."Location Code", '', '',
              ProdOrderLine."Qty. per Unit of Measure");
            ReserveSalesLine.CreateReservation(
              SalesLine,
              ProdOrderLine.Description,
              ProdOrderLine."Ending Date",
              ReservQty,
              '', '');
            IF SalesLine.Reserve = SalesLine.Reserve::Never THEN
                SalesLine.Reserve := SalesLine.Reserve::Optional;
            SalesLine.MODIFY;
            */
                ProdOrderLine.MODIFY;
                IF OrderType = OrderType::ItemOrder THEN
                    CreateProdOrderLines.CopyDimFromSalesLine(SalesLine, ProdOrderLine);
            END;
        END;

        IF ProdOrder.Status = ProdOrder.Status::Released THEN
            ProdOrderStatusMgt.FlushProdOrder(ProdOrder, ProdOrder.Status, WORKDATE);
        /*//B2BJM Requested by renuka madam
        IF NOT HideValidationDialog THEN
          MESSAGE(
            Text000,
            ProdOrder.Status,ProdOrder."No.");
        *///B2BJM

        //refresh code by pranavi on 27-02-15
        /*
        ProdOrder.TESTFIELD("Location Code");
        ProdOrder.SETRANGE(Status,ProdOrder.Status);
        ProdOrder.SETRANGE("No.",ProdOrder."No.");
        REPORT.RUNMODAL(REPORT::"Refresh Production Order",FALSE,FALSE,ProdOrder);

        //B2B-KNR  BEGIN
        ProdOrderLine.SETRANGE(ProdOrderLine.Status,ProdOrder.Status);
        ProdOrderLine.SETRANGE("Prod. Order No.",ProdOrder."No.");
        IF "Prod.OrdLine".FINDSET THEN
          REPEAT
           RoutingHeader.SETRANGE("No.","Prod.OrdLine"."Routing No.");
           IF RoutingHeader.FINDFIRST THEN BEGIN
             RoutingHeader.Status := RoutingHeader.Status :: "Under Development";
             RoutingHeader.MODIFY;
           END;
            RoutingLine.SETRANGE("Routing No.","Prod.OrdLine"."Routing No.");
            IF RoutingLine.FINDSET THEN
              REPEAT

                        RoutingLine."Lot Size" := 0;
                RoutingLine.MODIFY;
              UNTIL RoutingLine.NEXT = 0;
           RoutingHeader.RESET;
           RoutingHeader.SETRANGE("No.","Prod.OrdLine"."Routing No.");
           IF RoutingHeader.FINDFIRST THEN BEGIN
             RoutingHeader.Status := RoutingHeader.Status :: Certified;
             RoutingHeader.MODIFY;
           END;
          UNTIL "Prod.OrdLine".NEXT = 0;
        //  CODEUNIT.RUN(60024);
        //B2B-KNR  END
        //refreshtime.refresh("No.");

        // PRM integration
         {IF "Location Code"='PROD' THEN
            PRMintegrate.ProdOrdRefresh("No.");}

        // PRM integration

        //refresh end
        */
        IF (ProdOrder.Status = ProdOrder.Status::Released) AND (ProdOrder."Location Code" = 'PROD') THEN BEGIN
            prmRefresh.ProdOrdRefresh(ProdOrder."No.");
        END;

    end;

    procedure CreateProdOrderForSchedule(ScheduleLine: Record Schedule2; ProdOrderStatus: Enum "Production Order Status"; OrderType: option ItemOrder,ProjectOrder)
    var
        ReservEntry: Record 337;
        ProdOrder: Record 5405;
        ProdOrderLine: Record 5406;
        TrackingSpecification: Record 336;
        ReservMgt: Codeunit 99000845;
        ReserveSalesLine: Codeunit 99000832;
        CreateProdOrderLines: Codeunit 99000787;
        ProdOrderStatusMgt: Codeunit 5407;
        LeadTimeMgt: Codeunit 5404;
        ItemTrackingMgt: Codeunit 6500;
        ReservQty: Decimal;
        ReservQtyBase: Decimal;
        ProdOrderRowID: Text[250];
        prmRefresh: Codeunit 60021;
        SalesLine: Record 37;
        HideValidationDialog: Boolean;
        Text000: label '%1 Prod. Order %2 has been created';
    begin
        // Pranavi
        SalesLine.GET(SalesLine."Document Type"::Order, ScheduleLine."Document No.", ScheduleLine."Document Line No.");
        ProdOrder.INIT;
        ProdOrder.Status := ProdOrderStatus;
        ProdOrder."No." := '';
        ProdOrder.INSERT(TRUE);

        ProdOrder."Starting Date" := WORKDATE;
        ProdOrder."Creation Date" := WORKDATE;
        //B2B
        ProdOrder."Due Date" := SalesLine."Shipment Date";
        ProdOrder."Ending Date" := SalesLine."Shipment Date" - 1;
        ProdOrder."Low-Level Code" := 1;
        //B2B
        ProdOrder."Gen. Bus. Posting Group" := SalesLine."Gen. Bus. Posting Group";
        IF OrderType = OrderType::ProjectOrder THEN BEGIN
            ProdOrder."Source Type" := ProdOrder."Source Type"::"Sales Header";
            ProdOrder.VALIDATE("Source No.", ScheduleLine."Document No.");
            ProdOrder.VALIDATE("Sell-to Customer Name", SalesLine."Sell-to Customer Name"); //Added by Suvarchala
            ProdOrder."Due Date" := SalesLine."Shipment Date";
            ProdOrder."Ending Date" :=
              LeadTimeMgt.PlannedEndingDate(
                ScheduleLine."No.",
                ScheduleLine."Location Code",
                '',
                ProdOrder."Due Date",
                '',
                2);
        END ELSE BEGIN
            ProdOrder."Due Date" := SalesLine."Shipment Date";
            ProdOrder."Sell-to Customer Name" := SalesLine."Sell-to Customer Name"; //Added by Suvarchala
            ProdOrder."Source Type" := ProdOrder."Source Type"::Item;
            ProdOrder."Location Code" := ScheduleLine."Location Code";
            ProdOrder."Bin Code" := ScheduleLine."Bin Code";
            ProdOrder.VALIDATE("Source No.", ScheduleLine."No.");
            ProdOrder.VALIDATE("Source No.");
            ProdOrder.VALIDATE(Description, ScheduleLine.Description);
            ScheduleLine.CALCFIELDS(ScheduleLine."Reserved Qty. (Base)");
            ProdOrder.Quantity := ScheduleLine."Outstanding Qty.(Base)" - ScheduleLine."Reserved Qty. (Base)";
        END;
        ProdOrder.MODIFY;

        ProdOrder.SETRANGE("No.", ProdOrder."No.");
        SetScheduleLine(ScheduleLine);
        CopySchdl(ProdOrder, 1, ScheduleLine."Variant Code", FALSE);

        IF ProdOrder."Source Type" = ProdOrder."Source Type"::Item THEN BEGIN
            ProdOrderLine.SETRANGE(Status, ProdOrder.Status);
            ProdOrderLine.SETRANGE("Prod. Order No.", ProdOrder."No.");

            IF ProdOrderLine.FINDFIRST THEN BEGIN
                ProdOrderRowID :=
                  ItemTrackingMgt.ComposeRowID(
                    DATABASE::"Prod. Order Line", ProdOrderLine.Status,
                    ProdOrderLine."Prod. Order No.", '', ProdOrderLine."Line No.", 0);
                ItemTrackingMgt.CopyItemTracking(ScheduleLine.RowID1, ProdOrderRowID, TRUE, TRUE); // *** SE 13910

                ScheduleLine.CALCFIELDS("Reserved Quantity", "Reserved Qty. (Base)");
                IF ProdOrderLine."Remaining Qty. (Base)" > (ScheduleLine."Outstanding Qty.(Base)" - ScheduleLine."Reserved Qty. (Base)")
                THEN BEGIN
                    ReservQty := (ScheduleLine."Outstanding Qty." - ScheduleLine."Reserved Quantity");
                    ReservQtyBase := (ScheduleLine."Outstanding Qty.(Base)" - ScheduleLine."Reserved Qty. (Base)");
                END ELSE BEGIN
                    ReservQty := ProdOrderLine."Remaining Quantity";
                    ReservQtyBase := ProdOrderLine."Remaining Qty. (Base)";
                END;
                ReserveSalesLine.SetBinding(ReservEntry.Binding::"Order-to-Order");

                /*     ReserveSalesLine.CreateReservationSetFrom(
                      DATABASE::"Prod. Order Line",
                      ProdOrderLine.Status,
                      ProdOrderLine."Prod. Order No.",
                      '',
                      ProdOrderLine."Line No.", 0,
                      ProdOrderLine."Variant Code",
                      ProdOrderLine."Location Code", '', '',
                      ProdOrderLine."Qty. per Unit of Measure");
                                ReserveSalesLine.CreateReservation(
                                  SalesLine,
                                  ProdOrderLine.Description,
                                  ProdOrderLine."Ending Date",
                                  ReservQty, ReservQtyBase,
                                  '', ''); */
                //EFFUPG
                CallTrackingSpecification.InitTrackingSpecification(DATABASE::"Prod. Order Line",
                  ProdOrderLine.Status, ProdOrderLine."Prod. Order No.", '', ProdOrderLine."Line No.", 0,
                  ProdOrderLine."Variant Code", ProdOrderLine."Location Code", '', '',
                  ProdOrderLine."Qty. per Unit of Measure");
                ReserveSalesLine.CreateReservationSetFrom(TrackingSpecification);
                ReserveSalesLine.CreateReservation(
                  SalesLine, ProdOrderLine.Description, ProdOrderLine."Ending Date", ReservQty, ReservQtyBase, ReservEntry);

                /*     IF SalesLine.Reserve = SalesLine.Reserve::Never THEN
                      SalesLine.Reserve := SalesLine.Reserve::Optional; */

                SalesLine.MODIFY;
                ProdOrderLine.MODIFY;
                IF OrderType = OrderType::ItemOrder THEN
                    CopyDimFromScheduleLine(ScheduleLine, ProdOrderLine);
            END;
        END;
        IF ProdOrder.Status = ProdOrder.Status::Released THEN
            ProdOrderStatusMgt.FlushProdOrder(ProdOrder, ProdOrder.Status, WORKDATE);

        IF NOT HideValidationDialog THEN
            MESSAGE(
              Text000,
              ProdOrder.Status, ProdOrder."No.");

        IF (ProdOrder.Status = ProdOrder.Status::Released) AND (ProdOrder."Location Code" = 'PROD') THEN BEGIN
            prmRefresh.ProdOrdRefresh(ProdOrder."No.");
        END;
    end;



    procedure CreateProdOrder2ForSchedule(ScheduleLine: Record Schedule2; ProdOrderStatus: Enum "Production Order Status"; OrderType: option ItemOrder,ProjectOrder; QtyParam: Decimal)
    var
        ReservEntry: Record 337;
        ProdOrder: Record 5405;
        ProdOrderLine: Record 5406;
        ReservMgt: Codeunit 99000845;
        ReserveSalesLine: Codeunit 99000832;
        CreateProdOrderLines: Codeunit 99000787;
        ProdOrderStatusMgt: Codeunit 5407;
        ReservQty: Decimal;
        ManufSetup: Record 99000765;
        SOProdOrderDetails: Record 60094;
        prmRefresh: Codeunit 60021;
        SalesLine: Record 37;
        Items: record Item;
        "Prod.OrdLine": record "Prod. Order Line";
        RoutingHeader: record "Routing Header";
        RoutingLine: record "Routing Line";
        ProLine: record 5406;
    begin
        SalesLine.GET(SalesLine."Document Type"::Order, ScheduleLine."Document No.", ScheduleLine."Document Line No.");
        ProdOrder.INIT;
        ProdOrder.Status := ProdOrderStatus;
        ProdOrder."No." := '';
        ProdOrder.INSERT(TRUE);

        ProdOrder."Starting Date" := WORKDATE;
        ProdOrder."Creation Date" := WORKDATE;
        ProdOrder."Due Date" := ScheduleLine."Prod. Due Date";
        //ProdOrder."Ending Date" := SalesLine."Shipment Date"-1;
        ProdOrder."Ending Date" := ScheduleLine."Prod. Due Date";
        ProdOrder."Low-Level Code" := 1;
        ProdOrder."Gen. Bus. Posting Group" := SalesLine."Gen. Bus. Posting Group";
        IF OrderType = OrderType::ProjectOrder THEN BEGIN
            ProdOrder."Source Type" := ProdOrder."Source Type"::"Sales Header";
            ProdOrder.VALIDATE("Source No.", ScheduleLine."Document No.");
            ProdOrder.VALIDATE("Sell-to Customer Name", SalesLine."Sell-to Customer Name"); //Added by Suvarchala
                                                                                            //Added by Vishnu Priya on 23-05-2020
            IF (ProdOrder."Source No." <> '') AND (ProdOrder.Quantity <> 0) THEN BEGIN
                IF Items.GET(ProdOrder."Source No.") THEN BEGIN
                    ProdOrder.Itm_card_No_of_Units := Items."No.of Units";
                    ProdOrder.Itm_Card_ttl_units := ProdOrder.Quantity * Items."No.of Units";
                    //ProdOrder."Benchmarks(in Min)" := Items."Benchmarks(in Min)";
                    //ProdOrder."Total Time" := ProdOrder.Quantity * Items."Benchmarks(in Min)";
                    ProLine."Benchmark(in Min)" := Items."Benchmarks(in Min)";
                    ProLine."Total Benchmarks(in Min)" := ProLine.Quantity * Items."Benchmarks(in Min)";
                END;
            END;
            //Added by Vishnu Priya on 23-05-2020
        END ELSE BEGIN
            ProdOrder."Source Type" := ProdOrder."Source Type"::Item;
            ProdOrder.VALIDATE("Source No.", ScheduleLine."No.");
            Item.RESET;
            Item.SETFILTER(Item."No.", ScheduleLine."No.");
            IF Item.FINDFIRST THEN          //pranavi on 13-10-2015
                ProdOrder.VALIDATE(Description, Item.Description)
            ELSE
                ProdOrder.VALIDATE(Description, ScheduleLine.Description);
            ManufSetup.GET;
            ProdOrder."Location Code" := ManufSetup."Production Location";
            ProdOrder."Bin Code" := ScheduleLine."Bin Code";
            ProdOrder."Sales Order No." := ScheduleLine."Document No.";
            ProdOrder."Sell-to Customer Name" := SalesLine."Sell-to Customer Name"; //Added by Suvarchala
            ProdOrder."Sales Order Line No." := ScheduleLine."Document Line No.";
            ProdOrder."Schedule Line No." := ScheduleLine."Line No.";
            ScheduleLine.CALCFIELDS(ScheduleLine."Reserved Qty. (Base)");
            //ProdOrder.Quantity :=  SalesLine."Outstanding Qty. (Base)" - SalesLine."Reserved Qty. (Base)";
            ProdOrder.Quantity := QtyParam;
            //Added by Vishnu Priya on 23-05-2020
            IF (ProdOrder."Source No." <> '') AND (ProdOrder.Quantity <> 0) THEN BEGIN
                IF Items.GET(ProdOrder."Source No.") THEN BEGIN
                    ProdOrder.Itm_card_No_of_Units := Items."No.of Units";
                    ProdOrder.Itm_Card_ttl_units := ProdOrder.Quantity * Items."No.of Units";
                    // ProdOrder."Benchmarks(in Min)" := Items."Benchmarks(in Min)";
                    //ProdOrder."Total Time" := ProdOrder.Quantity * Items."Benchmarks(in Min)";
                    ProLine."Benchmark(in Min)" := Items."Benchmarks(in Min)";
                    ProLine."Total Benchmarks(in Min)" := ProLine.Quantity * Items."Benchmarks(in Min)";
                END;
            END;
            //Added by Vishnu Priya on 23-05-2020
            //IF DisProductionStartDate THEN BEGIN
            ProdOrder."Prod Start date" := TODAY;
            ProdOrder."Planned Dispatch Date" := CALCDATE('1M', TODAY);
            // END;
        END;
        ProdOrder.Refreshdate := 0D;
        ProdOrder.MODIFY;

        ProdOrder.SETRANGE("No.", ProdOrder."No.");
        SetScheduleLine(ScheduleLine);
        CopySchdl(ProdOrder, 1, ScheduleLine."Variant Code", FALSE);

        SOProdOrderDetails.INIT;
        SOProdOrderDetails.Type := SOProdOrderDetails.Type::"Prod. Order";
        SOProdOrderDetails."Sales Order No." := ScheduleLine."Document No.";
        SOProdOrderDetails."Sales Order Line No." := ScheduleLine."Document Line No.";
        SOProdOrderDetails."Schedule Line No." := ScheduleLine."Line No.";
        SOProdOrderDetails."No." := ProdOrder."No.";
        SOProdOrderDetails.Quantity := 1;
        SOProdOrderDetails.Status := SOProdOrderDetails.Status::Released;
        SOProdOrderDetails.INSERT;

        IF ProdOrder."Source Type" = ProdOrder."Source Type"::Item THEN BEGIN
            ProdOrderLine.SETRANGE(Status, ProdOrder.Status);
            ProdOrderLine.SETRANGE("Prod. Order No.", ProdOrder."No.");

            IF ProdOrderLine.FINDFIRST THEN BEGIN
                CLEAR(ReservMgt);
                ScheduleLine.CALCFIELDS("Reserved Qty. (Base)");
                IF ProdOrderLine."Remaining Qty. (Base)" > (ScheduleLine."Outstanding Qty.(Base)" - ScheduleLine."Reserved Qty. (Base)") THEN
                    ReservQty := (ScheduleLine."Outstanding Qty.(Base)" - ScheduleLine."Reserved Qty. (Base)")
                ELSE
                    ReservQty := ProdOrderLine."Remaining Qty. (Base)";
                /*
                ReservMgt.SetProdOrderLine(ProdOrderLine);
                ReservEntry."Source Type" :=
                  DATABASE::"Sales Line";
                ReserveSalesLine.SetBinding(ReservEntry.Binding::"Order-to-Order");
                ReserveSalesLine.CreateReservationSetFrom(
                  DATABASE::"Prod. Order Line",
                  ProdOrderLine.Status,
                  ProdOrderLine."Prod. Order No.",
                  '',
                  ProdOrderLine."Line No.",0,
                  ProdOrderLine."Variant Code",
                  ProdOrderLine."Location Code",'','',
                  ProdOrderLine."Qty. per Unit of Measure");
                ReserveSalesLine.CreateReservation(
                  SalesLine,
                  ProdOrderLine.Description,
                  ProdOrderLine."Ending Date",
                  ReservQty,
                  '','');
                IF SalesLine.Reserve = SalesLine.Reserve::Never THEN
                  SalesLine.Reserve := SalesLine.Reserve::Optional;
                SalesLine.MODIFY;
                }
                ProdOrderLine.MODIFY;
                IF OrderType = OrderType::ItemOrder THEN
                  CreateProdOrderLines.CopyDimFromScheduleLine(ScheduleLine,ProdOrderLine);
              END;
            END;

            IF ProdOrder.Status = ProdOrder.Status::Released THEN
              ProdOrderStatusMgt.FlushProdOrder(ProdOrder,ProdOrder.Status,WORKDATE);
            {//B2BJM  requested by renuka madam
            IF NOT HideValidationDialog THEN
              MESSAGE(
                Text000,
                ProdOrder.Status,ProdOrder."No.");
            }//B2BJM

            //refresh code by pranavi on 27-02-15
            */
                ProdOrder.TESTFIELD("Location Code");
                ProdOrder.SETRANGE(Status, ProdOrder.Status);
                ProdOrder.SETRANGE("No.", ProdOrder."No.");
                REPORT.RUNMODAL(REPORT::"Refresh Production Order", FALSE, FALSE, ProdOrder);

                //B2B-KNR  BEGIN
                ProdOrderLine.SETRANGE(ProdOrderLine.Status, ProdOrder.Status);
                ProdOrderLine.SETRANGE("Prod. Order No.", ProdOrder."No.");
                IF "Prod.OrdLine".FINDSET THEN
                    REPEAT
                        RoutingHeader.SETRANGE("No.", "Prod.OrdLine"."Routing No.");
                        IF RoutingHeader.FINDFIRST THEN BEGIN
                            RoutingHeader.Status := RoutingHeader.Status::"Under Development";
                            RoutingHeader.MODIFY;
                        END;
                        RoutingLine.SETRANGE("Routing No.", "Prod.OrdLine"."Routing No.");
                        IF RoutingLine.FINDSET THEN
                            REPEAT

                                RoutingLine."Lot Size" := 0;
                                RoutingLine.MODIFY;
                            UNTIL RoutingLine.NEXT = 0;
                        RoutingHeader.RESET;
                        RoutingHeader.SETRANGE("No.", "Prod.OrdLine"."Routing No.");
                        IF RoutingHeader.FINDFIRST THEN BEGIN
                            RoutingHeader.Status := RoutingHeader.Status::Certified;
                            RoutingHeader.MODIFY;
                        END;
                    UNTIL "Prod.OrdLine".NEXT = 0;
                //  CODEUNIT.RUN(60024);
                //B2B-KNR  END
                //refreshtime.refresh("No.");

                /*  // PRM integration
                  IF "Location Code"='PROD' THEN
                     PRMintegrate.ProdOrdRefresh("No.");}

                 // PRM integration

                 //refresh end */

                IF (ProdOrder.Status = ProdOrder.Status::Released) AND (ProdOrder."Location Code" = 'PROD') THEN BEGIN
                    prmRefresh.ProdOrdRefresh(ProdOrder."No.");
                END;
            end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, 99000792, 'OnCreateProdOrderOnAfterProdOrderInsert', '', false, false)]
    local procedure CreatProdorderUpdate(var ProductionOrder: Record "Production Order"; SalesLine: Record "Sales Line")
    begin
        //B2B
        ProductionOrder."Due Date" := SalesLine."Shipment Date";
        ProductionOrder."Ending Date" := SalesLine."Shipment Date" - 1;
        ProductionOrder."Low-Level Code" := 1;
        //B2B
    end;

    //>> For CU231
    [EventSubscriber(ObjectType::Codeunit, 231, 'OnCodeOnAfterCheckTemplate', '', false, false)]
    local procedure CodeUpdate(var GenJnlLine: Record "Gen. Journal Line")
    var
        //NODHeader: Record 13786; //B2BUPG
        Text01: Label 'Vendor is defined in NOD Header. Check for TDS.!';
        VendorLRec: Record 23;
        Text20: Label 'TDS Required to be deducted. Deducted or Not?';
    begin
        // Rev01 >>
        IF ((GenJnlLine."Journal Batch Name" = 'BPV (F&A)') OR (GenJnlLine."Journal Batch Name" = 'BPV (FIN)')) THEN BEGIN
            IF GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor THEN BEGIN
                VendorLRec.RESET;
                VendorLRec.SETRANGE("No.", GenJnlLine."Account No.");
                VendorLRec.SETRANGE("TDS Alert", TRUE);
                IF VendorLRec.FINDFIRST THEN BEGIN
                    IF NOT CONFIRM(Text20, FALSE) THEN
                        EXIT;
                END;
            END;
        END;
        // Rev01 <<
        /* B2BUPG >>
        //B2B
        IF ((GenJnlLine."Journal Batch Name" = 'JV-F&A') OR (GenJnlLine."Journal Batch Name" = 'JV- FIN') OR (GenJnlLine."Journal Batch Name" = 'JV- CUS')) THEN BEGIN
            IF GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor THEN BEGIN
                NODHeader.SETRANGE(NODHeader."No.", GenJnlLine."Account No.");
                IF NODHeader.FINDFIRST THEN BEGIN
                    IF NOT CONFIRM(Text01, FALSE) THEN
                        EXIT;
                END;
            END;
        END;
        //B2B
        */ //B2BUPG <<
    end;

    PROCEDURE ProdStartDate(DisplayDate: Boolean);
    BEGIN
        DisProductionStartDate := DisplayDate;
    END;

    //>>CU 378
    procedure TenderCheckIfAnyExtText(VAR TenderLine: Record "Tender Line"; Unconditionally: Boolean): Boolean
    var
        TenderHeader: Record "Tender Header";
        ExtTextHeader: record "Extended Text Header";
        AutoText: Boolean;
        GLAcc: Record "G/L Account";
        Res: Record Resource;
    begin
        MakeUpdateRequired := FALSE;
        IF TenderLine."Line No." <> 0 THEN
            MakeUpdateRequired := DeleteTenderLines(TenderLine);

        AutoText := FALSE;

        IF Unconditionally THEN
            AutoText := TRUE
        ELSE
            CASE TenderLine.Type OF
                TenderLine.Type::" ":
                    AutoText := TRUE;
                TenderLine.Type::"G/L Account":
                    BEGIN
                        IF GLAcc.GET(TenderLine."No.") THEN
                            AutoText := GLAcc."Automatic Ext. Texts";
                    END;
                TenderLine.Type::Item:
                    BEGIN
                        IF Item.GET(TenderLine."No.") THEN
                            AutoText := Item."Automatic Ext. Texts";
                    END;
                TenderLine.Type::Resource:
                    BEGIN
                        IF Res.GET(TenderLine."No.") THEN
                            AutoText := Res."Automatic Ext. Texts";
                    END;
            END;

        IF AutoText THEN BEGIN
            ExtTextHeader.RESET;
            TenderLine.TESTFIELD("Document No.");
            TenderHeader.GET(TenderLine."Document No.");
            //ExtTextHeader.SETRANGE("Table Name",27);
            ExtTextHeader.SETRANGE("No.", TenderLine."No.");
            ExtTextHeader.SETRANGE(Tender, TRUE);
            //EXIT(ReadLines(ExtTextHeader,TenderHeader."Deposit Payment Date",TenderHeader."Language Code"));
        END;
    end;

    procedure InsertTenderExtText(VAR TenderLine: Record "Tender Line")



    var
        ToTenderLine: Record "Tender Line";
        TmpExtTextLine: record "Extended Text Line";
        NextLineNo: Integer;
        LineSpacing: integer;
        Text000: Label 'There is not enough space to insert extended text lines.';
    begin
        ToTenderLine.RESET;
        ToTenderLine.SETRANGE("Document No.", TenderLine."Document No.");
        ToTenderLine := TenderLine;
        IF ToTenderLine.FIND('>') THEN BEGIN
            LineSpacing :=
              (ToTenderLine."Line No." - TenderLine."Line No.") DIV
              (1 + TmpExtTextLine.COUNT);
            IF LineSpacing = 0 THEN
                ERROR(Text000);
        END ELSE
            LineSpacing := 10000;

        NextLineNo := TenderLine."Line No." + LineSpacing;

        TmpExtTextLine.RESET;
        IF TmpExtTextLine.FINDSET THEN BEGIN
            REPEAT
                ToTenderLine.INIT;
                ToTenderLine."Document No." := TenderLine."Document No.";
                ToTenderLine."Line No." := NextLineNo;
                NextLineNo := NextLineNo + LineSpacing;
                ToTenderLine.Description := TmpExtTextLine.Text;
                //ToTenderLine."Attached to Line No." := TenderLine."Line No.";
                ToTenderLine.INSERT;
            UNTIL TmpExtTextLine.NEXT = 0;
            MakeUpdateRequired := TRUE;
        END;
        TmpExtTextLine.DELETEALL;
    end;

    procedure DeleteTenderLines(VAR TenderLine: Record "Tender Line"): Boolean
    var
        TenderLine2: Record "Tender Line";
    begin
        TenderLine2.SETRANGE("Document No.", TenderLine."Document No.");
        //TenderLine2.SETRANGE("Attached to Line No.",TenderLine."Line No.");
        TenderLine2 := TenderLine;
        IF TenderLine2.FIND('>') THEN BEGIN
            REPEAT
                TenderLine2.DELETE(TRUE);
            UNTIL TenderLine2.NEXT = 0;
            EXIT(TRUE);
        END;
    end;
    //<< CU 378


    //>>CU74
    [EventSubscriber(ObjectType::Table, database::"Purch. Rcpt. Line", 'OnInsertInvLineFromRcptLineOnBeforeCheckPurchLineReceiptNo', '', false, false)]
    local procedure OnInsertInvLineFromRcptLineOnBeforeCheckPurchLineReceiptNo(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchLine: Record "Purchase Line"; var TempPurchLine: Record "Purchase Line"; var NextLineNo: Integer)
    begin
        PurchLine."Purchase_Order No." := PurchRcptLine."Order No.";
    end;
    //<<CU74

    //>>CU231

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", 'OnBeforeGenJnlPostBatchRun', '', false, false)]
    local procedure OnCodeOnAfterCheckTemplate(var GenJnlLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    begin
        charline := 10;
        Mail_Body := '';
        prevno := '';

        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", 'BRV(CUST)');

        IF NOT GenJnlLine.FINDFIRST THEN BEGIN
            //if user1.Get(user."User ID")then
            GJL.RESET; // Rev01
            GJL.SETRANGE(GJL."Posting Date", WORKDATE);
            GJL.SETRANGE(GJL."Journal Batch Name", GenJnlLine."Journal Batch Name");
            GJL.SETFILTER(GJL."Validate Posting", 'YES');
            GJL.SETFILTER(GJL."Account No.", '24000');
            IF GJL.FINDFIRST THEN BEGIN
                //DIM1.0 Start
                //Code Commented
                DimSetEntryGRec.RESET;
                DimSetEntryGRec.SETRANGE("Dimension Set ID", GJL."Dimension Set ID");
                DimSetEntryGRec.SETRANGE("Dimension Code", 'EMPLOYEE CODES');
                IF DimSetEntryGRec.FINDFIRST THEN
                    user.SETRANGE(user."User ID", DimSetEntryGRec."Dimension Value Code");// Rev01
                                                                                          //DIM1.0 End
                IF user.FINDFIRST THEN BEGIN
                    Mail_Subject1 := 'Travelling Advance Transaction';
                    "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);//B2B
                    IF "Mail-Id".FINDFIRST THEN
                        "from Mail1" := "Mail-Id".MailID;
                    /* "to mail1" := user.MailID + ',';
                    "to mail1" += 'anilkumar@efftronics.com'; */
                    //Recipient.Add(user.MailID);
                    //Recipient.Add('anilkumar@efftronics.com');
                    Recipient.Add('erp@efftronics.com');
                    charline := 10;
                    Mail_Body1 := '';
                    Mail_Body1 += 'Employee Name  : ' + user."User ID";//B2B
                    Mail_Body1 += FORMAT(charline);
                    if user1.Get(user."User ID") then
                        Mail_Body1 += 'Employee ID    : ' + user1."Windows Security ID";//B2B
                    Mail_Body1 += FORMAT(charline);
                    Mail_Body1 += 'Department     : ' + user.Dept;
                    Mail_Body1 += FORMAT(charline);
                    Mail_Body1 += FORMAT(charline);
                    IF (GJL.Amount > 0) THEN
                        Mail_Body1 += 'you have taken Travelling advance of Amount ' + FORMAT(ROUND(GJL."Debit Amount", 1))
                    ELSE
                        Mail_Body1 += 'Recovered Against Travelling advance of Amount ' + FORMAT(ROUND(ABS(GJL."Credit Amount"), 1));
                    EmailMessage.Create(Recipient, Mail_Subject1, Mail_Body1, true);

                    //Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

                    //  "to mail1":=user.MailID+','+'anilkumar@efftronics.com';
                END;
            END;
            maxdate := TODAY;
            mindate := DMY2Date(04, 01, 08);
            AVE.SETRANGE(AVE."Dimension 2 Value Code", user."User ID");//Rev01
            AVE.SETRANGE(AVE."Posting Date", mindate, maxdate);
            IF AVE.FINDFIRST THEN BEGIN
                //REPORT.RUN(50173,FALSE,FALSE,AVE);
                REPORT.SAVEASPDF(33000898, '\\erpserver\ErpAttachments\TA Details.Pdf', AVE);
                Attachment2 := '\\erpserver\ErpAttachments\TA Details.Pdf';
            end;
            //>>>B2BUPG  Used for Automation variables and SMTP codeunit which was not possible to handling bc
            /* IF ("from Mail" <> '') AND ("to mail" <> '') THEN
                mail.NewCDOMessage("from Mail", "to mail", Mail_Subject, Mail_Body, Attachment1);
            IF ("from Mail1" <> '') AND ("to mail1" <> '') THEN
                mail.NewCDOMessage("from Mail1", "to mail1", Mail_Subject1, Mail_Body1, Attachment2);
            IF ("from Mail1" <> '') AND ("to mail2" <> '') THEN
                mail.NewCDOMessage("from Mail1", "to mail2", Mail_Subject1, Mail_Body1, Attachment1); */ //<<<B2BUPG

        END


        //For Receipt


        ELSE BEGIN

            GJL.SETRANGE(GJL."Posting Date", WORKDATE);
            GJL.SETRANGE(GJL."Journal Batch Name", GenJnlLine."Journal Batch Name");
            GJL.SETFILTER(GJL."Account Type", 'Bank Account');
            IF GJL.FINDFIRST THEN BEGIN
                BA.SETRANGE(BA."No.", GJL."Account No.");
                IF BA.FINDFIRST THEN
                    bankacc := BA.Name;
            END
            ELSE
                ERROR('Specify Workdate same as Posting Date & Bank Account for this Receipt');
            GJL.RESET;
            GJL.SETRANGE(GJL."Journal Batch Name", GenJnlLine."Journal Batch Name");
            GJL.SETFILTER(GJL."Account Type", 'Customer');
            IF GJL.FINDSET THEN
                REPEAT
                    Mail_Body := '';
                    //   IF GJL."Sale Order No"='' THEN
                    //   ERROR('Please enter Sale Order No.');
                    prevno := GJL."Sale Order No";
                    IF (prevno <> salno) THEN BEGIN
                        INVVAL := 0;
                        RECVAL := 0;
                        salno := FORMAT(GJL."Sale Order No");
                    END;
                    recamt += ABS(GJL.Amount);
                    invno += ', ' + GJL."Invoice no";
                UNTIL GJL.NEXT = 0;
            //END;

            Mail_Body += 'RECEIPT DETAILS  :';
            Mail_Body += FORMAT(charline);
            Mail_Body += FORMAT(charline);

            cust.SETRANGE(cust."No.", GJL."Account No.");
            IF cust.FINDFIRST THEN
                Mail_Subject := 'ERP- Receipt From the Customer ' + cust.Name;

            IF (GJL."Payment Type" = GJL."Payment Type"::Advance) THEN BEGIN
                Mail_Body += 'ADVANCE FROM CUSTOMER';
                Mail_Body += FORMAT(charline);
                Mail_Body += FORMAT(charline);
            END;

            Mail_Body += 'Customer Name                       : ' + FORMAT(cust.Name);
            Mail_Body += FORMAT(charline);
            Mail_Body += 'Customer Type                       : ' + FORMAT(cust."Customer Posting Group");
            Mail_Body += FORMAT(charline);
            Mail_Body += 'Received Amount                     : ' + FORMAT(ROUND(recamt, 1));
            Mail_Body += FORMAT(charline);
            Mail_Body += FORMAT(charline);

            IF (GJL."Payment Type" = GJL."Payment Type"::Advance) THEN BEGIN
                sh.SETRANGE(sh."No.", GJL."Sale Order No");
                IF sh.FINDFIRST THEN
                    orderval := sh."Sale Order Total Amount";
                Mail_Body += 'Sale Order No.                      : ' + FORMAT(salno);
                Mail_Body += FORMAT(charline);
                Mail_Body += 'Sale Order Value                    : ' + FORMAT(ROUND(orderval, 1));
                Mail_Body += FORMAT(charline);
                Mail_Body += 'Bank Account                        : ' + FORMAT(bankacc);
                Mail_Body += FORMAT(charline);

                CLE.RESET;
                CLE.SETRANGE(CLE."Customer No.", GJL."Account No.");
                CLE.SETRANGE(CLE."Sale Order no", GJL."Sale Order No");
                IF CLE.FINDSET THEN
                    REPEAT
                        CLE.CALCFIELDS(CLE.Amount);
                        RECVAL += ABS(CLE.Amount);
                    UNTIL CLE.NEXT = 0;
                Mail_Body += 'Total Received Value for this Order : ' + FORMAT(ROUND(RECVAL + recamt, 1));
                Mail_Body += FORMAT(charline);
                Mail_Body += FORMAT(charline);
                Mail_Body += FORMAT(charline);

            END
            ELSE BEGIN

                SIH.RESET;
                SIH.SETRANGE(SIH."Sell-to Customer No.", GJL."Account No.");
                SIH.SETRANGE(SIH."Order No.", GJL."Sale Order No");
                IF SIH.FINDSET THEN
                    REPEAT
                        SIH.CALCFIELDS(SIH."Total Invoiced Amount");
                        INVVAL += SIH."Total Invoiced Amount";
                        orderval := SIH."Sale Order Total Amount";
                        cusorderno := SIH."Customer OrderNo.";
                    UNTIL SIH.NEXT = 0;


                Mail_Body += 'Sale Order No.                      : ' + FORMAT(salno);
                Mail_Body += FORMAT(charline);
                Mail_Body += 'Sale Order Value                    : ' + FORMAT(orderval);
                Mail_Body += FORMAT(charline);
                Mail_Body += FORMAT(charline);

                Mail_Body += 'Total Invoiced Value                : ' + FORMAT(ROUND(INVVAL, 1));
                Mail_Body += FORMAT(charline);
                Mail_Body += FORMAT(charline);
                Mail_Body += 'Customer Order No.                  : ' + FORMAT(cusorderno);
                Mail_Body += FORMAT(charline);
                Mail_Body += 'Bank Account                        : ' + FORMAT(bankacc);
                Mail_Body += FORMAT(charline);
                Mail_Body += 'Invoice No.                         : ' + FORMAT(COPYSTR(invno, 2, STRLEN(invno) - 1));
                Mail_Body += FORMAT(charline);
                Mail_Body += FORMAT(charline);


                CLE.RESET;
                CLE.SETRANGE(CLE."Customer No.", GJL."Account No.");
                CLE.SETRANGE(CLE."Sale Order no", GJL."Sale Order No");
                IF CLE.FINDSET THEN
                    REPEAT
                        CLE.CALCFIELDS(CLE.Amount);
                        RECVAL += ABS(CLE.Amount);
                    UNTIL CLE.NEXT = 0;
                Mail_Body += 'Total Received Value for this Order : ' + FORMAT(ROUND(RECVAL + recamt, 1));
                Mail_Body += FORMAT(charline);
                per := ((ROUND(RECVAL + recamt, 1)) / ROUND(INVVAL, 1)) * 100;
                IF (per > 101) THEN
                    ERROR('Total received percent is greater than 100 for this sale Order');
                Mail_Body += 'Total Received Percent              : ' + FORMAT(ROUND(per, 0.1, '>')) + ' %';
                Mail_Body += FORMAT(charline);
                Mail_Body += FORMAT(charline);
            END;

            //cust.RESET
            cust.SETRANGE(cust."No.", GJL."Account No.");
            IF cust.FINDFIRST THEN
                cust.CALCFIELDS(cust."Balance (LCY)");
            Mail_Body += 'Previous Customer Balance           : ' + FORMAT(ROUND(cust."Balance (LCY)", 1));
            Mail_Body += FORMAT(charline);
            Mail_Body += 'Total Customer Balance              : ' + FORMAT(ROUND(cust."Balance (LCY)" - recamt, 1));
            Mail_Body += FORMAT(charline);

            //   END;
            // END;
            /*  "Mail-Id".SETRANGE(user1."User Security ID", USERID);//B2B
         IF "Mail-Id".FINDFIRST THEN
             "from Mail" := "Mail-Id".MailID; */
            // "to mail":='erp@efftronics.com';
            /*  "to mail" := 'dir@efftronics.com,cvmohan@efftronics.com,anilkumar@efftronics.com,sitarajyam@efftronics.com,';
             "to mail" += 'renukach@efftronics.com,rajani@efftronics.com';
             "to mail" += 'ravi@efftronics.com,samba@efftronics.com,baji@efftronics.com,prasannat@efftronics.com,';
             "to mail" += 'anuradhag@efftronics.com,chandi@efftronics.com,anulatha@efftronics.com,milind@efftronics.com,srasc@efftronics.com'; */
            /* Recipient.Add('dir@efftronics.com');
             Recipient.Add('cvmohan@efftronics.com');*/
            //Recipient.Add('anilkumar@efftronics.com');
            Recipient.Add('erp@efftronics.com');
            /*Recipient.Add('sitarajyam@efftronics.com'); 11-08-2022
            Recipient.Add('renukach@efftronics.com');
            Recipient.Add('rajani@efftronics.com');
            Recipient.Add('samba@efftronics.com');
            Recipient.Add('baji@efftronics.com');
            Recipient.Add('prasannat@efftronics.com');
            Recipient.Add('anuradhag@efftronics.com');
            Recipient.Add('chandi@efftronics.com');
            Recipient.Add('anulatha@efftronics.com');
            Recipient.Add(',milind@efftronics.com');
            Recipient.Add('srasc@efftronics.com');*/

            //  "to mail"+='sal@efftronics.com';
            // IsHandled :=GenJnlPostBatch.RUN(GenJnlLine);

            CLE.RESET;
            CLE.SETRANGE(CLE."Customer No.", GJL."Account No.");
            IF CLE.FINDFIRST THEN
                REPORT.RUN(50180, FALSE, FALSE, CLE);
            REPORT.SAVEASPDF(50180, '\\erpserver\ErpAttachments\Cust.Pdf', CLE);
            Attachment := '\\erpserver\ErpAttachments\Cust.Pdf';
            EmailMessage.Create(Recipient, Mail_Subject, Mail_Body, true);
            EmailMessage.AddAttachment(Attachment, '', '');
            //Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

            //>>>B2BUPG Used for Automation variables and SMTP codeunit which was not possible to handling bc
            /*  IF ("from Mail" <> '') AND ("to mail" <> '') THEN
                 mail.NewCDOMessage("from Mail", "to mail", Mail_Subject, Mail_Body, Attachment); */ //>>>B2BUPG
        END;

        charline := 10;
        IF (GenJnlLine."Journal Batch Name" = 'BRV(CUST)') THEN BEGIN
            IF ((GenJnlLine."Account Type" = GenJnlLine."Account Type"::"Bank Account") AND
               (GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Customer))
             THEN BEGIN
                cust.SETRANGE(cust."No.", GenJnlLine."Bal. Account No.");
                IF cust.FINDFIRST THEN
                    Mail_Subject := 'ERP- ' + 'Receipt From the Customer ' + cust.Name;
                IF GenJnlLine."Cheque No." = '' THEN
                    ERROR('You Need To Enter Cheque no.');
                IF (GenJnlLine."Payment Type" <> GenJnlLine."Payment Type"::Contra) AND
                   (GenJnlLine."Payment Type" <> GenJnlLine."Payment Type"::Advance) THEN BEGIN
                    IF (GenJnlLine."Sale invoice order no" = '') THEN
                        ERROR('You must Select Sal invoice Order No.')
                    ELSE
                        Mail_Body += 'Sale Order No.          : ' + GenJnlLine."Sale Order No";
                    Mail_Body += FORMAT(charline);
                    Mail_Body += 'Customer Order No.      : ' + GenJnlLine."Customer Ord no";
                    Mail_Body += FORMAT(charline);
                    glentry.SETRANGE(glentry."Debit Amount", 1, 1000000000);
                    glentry.SETRANGE(glentry."Document No.", GenJnlLine."Sale invoice order no");
                    IF glentry.FINDFIRST THEN BEGIN
                        Mail_Body += 'Invoice No.             : ' + FORMAT(glentry."External Document No.");
                        Mail_Body += FORMAT(charline);
                        Mail_Body += 'Invoiced Amount         : ' + FORMAT(glentry."Debit Amount");
                    END;
                    Mail_Body += FORMAT(charline);
                    Mail_Body += 'Received Amount         : ' + FORMAT(GenJnlLine."Debit Amount");
                    Mail_Body += FORMAT(charline);
                    Mail_Body += 'Receipt Date            : ' + FORMAT((TODAY), 0, 4);
                    Mail_Body += FORMAT(charline);
                    Mail_Body += 'Invoiced Date           : ' + FORMAT((glentry."Posting Date"), 0, 4);
                    Mail_Body += FORMAT(charline);
                    Mail_Body += 'Amount Received in Days : ' + FORMAT(TODAY - (glentry."Posting Date"));
                    Mail_Body += FORMAT(charline);
                    //user.SETRANGE(user1."User Security ID", cust."Salesperson Code");//B2B
                    IF user.FINDFIRST THEN
                        Mail_Body += 'Sales Executive         : ' + user."User ID";//B2B
                    Mail_Body += FORMAT(charline);
                    Mail_Body += FORMAT(charline);
                    Mail_Body += '***** Auto Mail Generated From ERP *****';
                END;
                IF (GenJnlLine."Payment Type" = GenJnlLine."Payment Type"::Contra) THEN BEGIN
                    Mail_Body := 'Security Deposit :' + FORMAT(GenJnlLine."Debit Amount");
                END;
                IF (GenJnlLine."Payment Type" = GenJnlLine."Payment Type"::Advance) THEN BEGIN
                    IF (GenJnlLine."Sale Order No" = '') THEN
                        ERROR('You must select the Sale Order No.in Advance field');
                    Mail_Body := 'Advance Amount :' + FORMAT(GenJnlLine."Debit Amount");
                    Mail_Body += FORMAT(charline);
                    Mail_Body += 'Sale Order No. :' + GenJnlLine."Sale Order No";
                    Mail_Body += FORMAT(charline);
                    Mail_Body += '***** Auto Mail Generated From ERP*****';
                END;
                /* "Mail-Id".SETRANGE(user1."User Security ID", USERID);//B2B
                IF "Mail-Id".FINDFIRST THEN
                    "from Mail" := "Mail-Id".MailID; */
                /*  "to mail" += 'dir@efftronics.com,baji@efftronics.com,ravi@efftronics.com,';
                 "to mail" += 'anilkumar@efftronics.com,cvmohan@efftronics.com,rajani@efftronics.com'; */
                /*Recipient.Add('dir@efftronics.com');
                Recipient.Add('baji@efftronics.com');
                Recipient.Add('ravi@efftronics.com');*/
                //Recipient.Add('anilkumar@efftronics.com');
                Recipient.Add('erp@efftronics.com');
                /*Recipient.Add('cvmohan@efftronics.com');
                Recipient.Add('rajani@efftronics.com');*/

                //IsHandled :=GenJnlPostBatch.RUN(GenJnlLine)
            END

            ELSE
                IF ((GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer) AND
           (GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::"Bank Account"))
            THEN BEGIN
                    cust.SETRANGE(cust."No.", GenJnlLine."Account No.");
                    IF cust.FINDFIRST THEN
                        Mail_Subject := '<ERP> ' + 'Receipt From the Customer ' + cust.Name;

                    IF (GenJnlLine."Payment Type" <> GenJnlLine."Payment Type"::Contra) AND
                       (GenJnlLine."Payment Type" <> GenJnlLine."Payment Type"::Advance) THEN BEGIN
                        IF (GenJnlLine."Sale invoice order no" = '') THEN
                            ERROR('You must Select Sal invoice Order No.')
                        ELSE
                            Mail_Body += 'Sale Order No.          : ' + GenJnlLine."Sale Order No";
                        Mail_Body += FORMAT(charline);
                        Mail_Body += 'Customer Order No.      : ' + GenJnlLine."Customer Ord no";
                        Mail_Body += FORMAT(charline);
                        glentry.SETRANGE(glentry."Debit Amount", 1, 1000000000);
                        glentry.SETRANGE(glentry."Document No.", GenJnlLine."Sale invoice order no");
                        IF glentry.FINDFIRST THEN BEGIN
                            Mail_Body += 'Sale Order No.          : ' + GenJnlLine."Customer Ord no";
                            Mail_Body += FORMAT(charline);
                            Mail_Body += 'Invoice No.             : ' + FORMAT(glentry."External Document No.");
                            Mail_Body += FORMAT(charline);
                            Mail_Body += 'Invoiced Amount         : ' + FORMAT(glentry."Debit Amount");
                            Mail_Body += FORMAT(charline);
                        END;
                        Mail_Body += 'Received Amount         : ' + FORMAT(GenJnlLine."Credit Amount");
                        Mail_Body += FORMAT(charline);
                        Mail_Body += 'Receipt Date            : ' + FORMAT((TODAY), 0, 4);
                        Mail_Body += FORMAT(charline);
                        Mail_Body += 'Invoiced Date           : ' + FORMAT(glentry."Posting Date");
                        Mail_Body += FORMAT(charline);
                        Mail_Body += 'Amount Received in Days : ' + FORMAT(TODAY - (glentry."Posting Date"));
                        Mail_Body += FORMAT(charline);
                        //user.SETRANGE(user1."User Security ID", cust."Salesperson Code");//B2B
                        IF user.FINDFIRST THEN
                            Mail_Body += 'Sales Executive         : ' + user."User ID";//B2B
                        Mail_Body += FORMAT(charline);
                        Mail_Body += FORMAT(charline);
                        Mail_Body += '***** Auto Mail Generated From ERP *****';
                    END;
                    IF (GenJnlLine."Payment Type" = GenJnlLine."Payment Type"::Contra) THEN BEGIN
                        Mail_Body := 'Security Deposit :' + FORMAT(GenJnlLine."Debit Amount");
                    END;
                    IF (GenJnlLine."Payment Type" = GenJnlLine."Payment Type"::Advance) THEN BEGIN
                        IF (GenJnlLine."Sale Order No" = '') THEN
                            ERROR('You must select the Sale Order No.in Advance field');
                        Mail_Body := 'Advance Amount :' + FORMAT(GenJnlLine."Credit Amount");
                        Mail_Body += FORMAT(charline);
                        Mail_Body += 'Sale Order No. :' + GenJnlLine."Sale Order No";
                        Mail_Body += FORMAT(charline);
                        Mail_Body += '***** Auto Mail Generated From ERP*****';
                    END;
                    /* "Mail-Id".SETRANGE(user1."User Security ID", USERID);//B2B
                    IF "Mail-Id".FINDFIRST THEN
                        "from Mail" := "Mail-Id".MailID; */
                    /* "to mail" += 'dir@efftronics.com,anuradhag@efftronics.com,baji@efftronics.com,ravi@efftronics.com,';
                    "to mail" += 'anilkumar@efftronics.com,cvmohan@efftronics.com,rajani@efftronics.com'; */
                    /* Recipient.Add('dir@efftronics.com');
                     Recipient.Add('anuradhag@efftronics.com');
                     Recipient.Add('baji@efftronics.com');
                     Recipient.Add('ravi@efftronics.com');*/
                    //Recipient.Add('anilkumar@efftronics.com');
                    Recipient.Add('erp@efftronics.com');
                    /*Recipient.Add('cvmohan@efftronics.com');
                    Recipient.Add('rajani@efftronics.com');*/
                    //IsHandled := GenJnlPostBatch.RUN(GenJnlLine);
                END
                ELSE
                    ERROR('PLEASE CHOOSE ANOTHER BRV');
            EmailMessage.Create(Recipient, Mail_Subject, Mail_Body, true);
            // Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

        END;

        //>>>B2BUPG Used for Automation variables and SMTP codeunit which was not possible to handling bc
        /* IF ("from Mail" <> '') AND ("to mail" <> '') THEN
            mail.NewCDOMessage("from Mail", "to mail", Mail_Subject, Mail_Body, ''); */  //<<<B2BUPG

        IF (GenJnlLine."Journal Batch Name" = 'BRV(EMP)') THEN BEGIN
            IF (GenJnlLine."Account No." = '37200') OR (GenJnlLine."Bal. Account No." = '37200') OR
               (GenJnlLine."Account No." = '24200') OR (GenJnlLine."Bal. Account No." = '24200') then begin
            end
            //IsHandled :=GenJnlPostBatch.RUN(GenJnlLine)
            ELSE
                ERROR('PLEASE CHOOSE ANOTHER BRV');
        END;

        IF (GenJnlLine."Journal Batch Name" = 'BRV(OTH)') THEN BEGIN
            IF (GenJnlLine."Account No." = '37200') OR (GenJnlLine."Bal. Account No." = '37200') OR
               (GenJnlLine."Account No." = '24200') OR (GenJnlLine."Bal. Account No." = '24200') OR
               (GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer) OR
               (GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Customer) THEN
                ERROR('PLEASE CHOOSE ANOTHER BRV')
            // ELSE
            //  IsHandled :=GenJnlPostBatch.RUN(GenJnlLine) 
        END;
        IF (GenJnlLine."Journal Batch Name" <> 'BRV(CUST)') OR (GenJnlLine."Journal Batch Name" <> 'BRV(EMP)') OR
            (GenJnlLine."Journal Batch Name" <> 'BRV(OTH)') THEN begin
        end
        //IsHandled :=  GenJnlPostBatch.RUN(GenJnlLine);
        //BRV SEGRAGATION END

        //  IF "Line No." = 0 THEN
        //    MESSAGE(Text002)
        //  ELSE
    end;
    //<<< CU231

    //>>CU99000792
    [EventSubscriber(ObjectType::Codeunit, 99000792, 'OnAfterCreateProdOrderFromSalesLine', '', false, false)]
    local procedure OnAfterCreateProdOrderFromSalesLine(var ProdOrder: Record "Production Order"; var SalesLine: Record "Sales Line")
    var
        Items: record Item;
        ProLine: Record 5406;
    begin
        //Added by Vishnu Priya on 23-05-2020
        IF (ProdOrder."Source No." <> '') AND (ProdOrder.Quantity <> 0) THEN BEGIN
            IF Items.GET(ProdOrder."Source No.") THEN BEGIN

                ProdOrder.Itm_card_No_of_Units := Items."No.of Units";
                ProdOrder.Itm_Card_ttl_units := ProdOrder.Quantity * Items."No.of Units";
                //ProdOrder."Benchmarks(in Min)" := Items."Benchmarks(in Min)";
                //ProdOrder."Total Time" := ProdOrder.Quantity * Items."Benchmarks(in Min)";
                ProLine."Benchmark(in Min)" := Items."Benchmarks(in Min)";
                ProLine."Total Benchmarks(in Min)" := ProLine.Quantity * Items."Benchmarks(in Min)";


            END;
        END;
        //Added by Vishnu Priya on 23-05-2020
    end;

    [EventSubscriber(ObjectType::Codeunit, 99000792, 'OnAfterCreateProdOrder', '', false, false)]
    local procedure OnAfterCreateProdOrder(var ProdOrder: Record "Production Order"; var SalesLine: Record "Sales Line")
    var
        prmRefresh: Codeunit 60021;
    begin
        prmRefresh.ProdOrdRefresh(ProdOrder."No.");
    end;
    //<<CU99000792

    [EventSubscriber(ObjectType::Codeunit, 99000830, 'OnAfterSignFactor', '', false, false)]
    local procedure OnAfterSignFactor(ReservationEntry: Record "Reservation Entry"; var Sign: Integer)
    begin
        //B2BSP
        if ReservationEntry."Source Type" = DATABASE::Schedule2 then
            Sign := -1;
        //B2BSP
    end;

    var
        MakeUpdateRequired: boolean;
        Schedule: Record Schedule2;
        Planned_day: Date;
        DisProductionStartDate: boolean;

        ScheduleLine: Record Schedule2;
        ScheduleLineIsSet: boolean;

        QualityCtrlSetup: Record "Quality Control Setup";
        QCSetupRead: Boolean;
        text112: label 'ENU=You can''t create more porduction order''s than Qty';
        //Schedule@1000000001 : Record Schedule2;
        SO: Record "Sales Invoice-Dummy";
        SkipOrderVerification: Boolean;
        Vndr: Record Vendor;
        PurchHeader: Record "Purchase Header";
        MfgSetup: record "Manufacturing Setup";
        ProdOrderLine: record "Prod. Order Line";
        ProdOrder: record "Production Order";
        NextProdOrderLineNo: integer;
        Item: record Item;
        InsertNew: boolean;
        SalesHeader: record "sales Header";
        SalesLine: record "sales line";
        CreateProdOrderLines: Codeunit "Create Prod. Order Lines";
        ItemTrackingMgt: Codeunit 6500;

        ReservMgt: Codeunit "Reservation Management";
        ReserveSalesLine: codeunit 99000832;
        TrackingSpecification: Record "Tracking Specification";
        ReservEntry: record "Reservation Entry";

        CalcProdOrder: Codeunit "Calculate Prod. Order";
        CallTrackingSpecification: Record "Tracking Specification";
        AlternatePCB_BOM: Boolean;

        //>>> CU 231
        "Mail-Id": Record "User Setup";
        "from Mail": Text[500];
        "to mail": Text[1000];
        Mail_Subject: Text[1000];
        Mail_Body: Text[1000];
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipient: List of [Text];
        mail: Codeunit 397;
        cust: Record 18;
        glentry: Record 17;
        charline: Char;
        GenJnlPostBatch: Codeunit 13;
        user: Record "User Setup";
        user1: Record User;
        CLE: Record 21;
        amt: Decimal;
        prevamt: Decimal;
        remamt: Decimal;
        finalamount: Decimal;
        Genjournal: Record 81;
        DBAccount: Text[30];
        CTAccount: Text[30];
        SIH: Record 112;
        INVVAL: Decimal;
        RECVAL: Decimal;
        orderval: Decimal;
        salno: Code[30];
        prevno: Code[30];
        amount: Decimal;
        GJL: Record 81;
        amt1: Decimal;
        toberec: Decimal;
        dueamt: Decimal;
        totalamt: Decimal;
        per: Decimal;
        sh: Record 36;
        Attachment1: Text[100];
        "from Mail1": Text[500];
        "to mail1": Text[1000];
        Mail_Subject1: Text[1000];
        Mail_Body1: Text[1000];
        Attachment2: Text[100];
        AVE: Record 365;
        maxdate: Date;
        mindate: Date;
        recamt: Decimal;
        bankacc: Text[1000];
        cusorderno: Code[100];
        BA: Record 270;
        "to mail2": Text[1000];
        invno: Text[50];
        Attachment: Text[1000];
        "-DIM1.0-": Integer;
        DimSetEntryGRec: Record 480;
    //<<< CU 231


}