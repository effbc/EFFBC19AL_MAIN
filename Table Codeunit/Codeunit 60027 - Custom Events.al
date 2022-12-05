codeunit 60027 "Custom Events"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Line", 'OnValidateItemNoOnAfterAssignItemValues', '', false, false)]
    local procedure OnValidateItemNoOnAfterAssignItemValues(var ProdOrderLine: Record "Prod. Order Line"; Item: Record Item)
    begin
        ProdOrderLine."Benchmark(in Min)" := Item."Benchmarks(in Min)";
        ProdOrderLine."Total Benchmarks(in Min)" := ProdOrderLine.Quantity * Item."Benchmarks(in Min)";
        ProdOrderLine."Soldering Time(in Min)" := ProdOrderLine.Quantity * Item."PROD Soldering Time(in Min)";
        //QC 1.0
        ProdOrderLine."WIP QC Enabled" := Item."WIP QC Enabled";
        ProdOrderLine."WIP Spec Id" := Item."WIP Spec ID";
        if ProdOrderLine."WIP Spec Id" <> '' then
            ProdOrderLine."Spec Version Code" := ProdOrderLine.GetSpecVersion;
        //QC 1.0
    end;


    [EventSubscriber(ObjectType::table, Database::"Prod. Order Component", 'OnBeforeUpdateUnitCost', '', false, false)]
    local procedure OnBeforeUpdateUnitCost(var ProdOrderComponent: Record "Prod. Order Component"; GLSetup: Record "General Ledger Setup"; var IsHandled: Boolean)
    var
        Item: Record Item;
    begin
        ProdOrderComponent."AVG Unit cost" := Item."Avg Unit Cost";
    end;

    [EventSubscriber(ObjectType::table, Database::"Prod. Order Component", 'OnValidateExpectedQuantityOnAfterCalcActConsumptionQty', '', false, false)]
    local procedure OnValidateExpectedQuantityOnAfterCalcActConsumptionQty(var ProdOrderComp: Record "Prod. Order Component"; xProdOrderComp: Record "Prod. Order Component")
    begin
        if (ProdOrderComp."Act. Consumption (Qty)" <> 0) or (ProdOrderComp."Qty. per Unit of Measure" <> 0) then
            ProdOrderComp."Remaining Quantity" := ProdOrderComp."Expected Quantity" - ProdOrderComp."Act. Consumption (Qty)" / ProdOrderComp."Qty. per Unit of Measure"
        else
            ProdOrderComp."Remaining Quantity" := ProdOrderComp."Expected Quantity";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Line", 'OnAfterAssignItemValues', '', false, false)]
    local procedure OnAfterAssignItemValues(var TransferLine: Record "Transfer Line"; Item: Record Item)
    var
        TransferHeader: Record "Transfer Header";
        Location: Record Location;
    begin
        //B2B-ESPL
        TransferHeader.SetRange("No.", TransferLine."Document No.");
        if TransferHeader.Find('-') then begin
            Location.Get(TransferHeader."Transfer-to Code");
            if Location."QC Enabled Location" then begin
                TransferLine.Validate("Spec ID", Item."Spec ID");
                TransferLine.Validate("QC Enabled", Item."QC Enabled");
            end;
        end;
        //B2B
    end;

    [EventSubscriber(ObjectType::Table, Database::"Service Item Line", 'OnValidateServiceItemNoOnBeforeValidateServicePeriod', '', false, false)]
    local procedure OnValidateServiceItemNoOnBeforeValidateServicePeriod(var ServiceItemLine: Record "Service Item Line"; xServiceItemLine: Record "Service Item Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    var
        Item: Record Item;
    begin
        Item.SetFilter(Item."No.", ServiceItemLine."Item No.");
        if Item.Find('-') then begin
            ServiceItemLine."Unit cost" := Item."Avg Unit Cost";
            ServiceItemLine.Description := Item.Description;
        end;
        //b2b-eff
    end;

    [EventSubscriber(ObjectType::Table, Database::"Service Line", 'OnValidateServiceItemLineNoOnBeforeValidateContractNo', '', false, false)]
    local procedure OnValidateServiceItemLineNoOnBeforeValidateContractNo(var ServiceLine: Record "Service Line"; ServItemLine: Record "Service Item Line")
    begin
        ServiceLine."Fault Area Description" := ServItemLine."Fault Area Description";
        ServiceLine."Sub Module Code" := ServItemLine."Sub Module Code";
        ServiceLine."Sub Module Descrption" := ServItemLine."Sub Module Descrption";
    end;


    //Table - 7317 Warehouse Receipt Line

    [EventSubscriber(ObjectType::Table, Database::"Warehouse Receipt Line", 'OnBeforeInitOutstandingQtys', '', false, false)]
    local procedure OnBeforeInitOutstandingQtys(var WarehouseReceiptLine: Record "Warehouse Receipt Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
        //QC
        WarehouseReceiptLine."Qty. Sending To Quality" := WarehouseReceiptLine.Quantity;
        //QC
    end;


    //Table - 99000764 Routing Line

    [EventSubscriber(ObjectType::Table, Database::"Routing Line", 'OnAfterMachineCtrTransferFields', '', false, false)]
    local procedure OnAfterMachineCtrTransferFields(var RoutingLine: Record "Routing Line"; WorkCenter: Record "Work Center"; MachineCenter: Record "Machine Center")
    begin
        //Cost1.0
        RoutingLine."Man Cost" := RoutingLine."Run Time" * MachineCenter."Unit Cost";
        //Cost1.0
    end;

    [EventSubscriber(ObjectType::Table, Database::"Routing Line", 'OnAfterWorkCenterTransferFields', '', false, false)]
    local procedure OnAfterWorkCenterTransferFields(var RoutingLine: Record "Routing Line"; WorkCenter: Record "Work Center")
    begin
        //Cost1.0
        RoutingLine."Man Cost" := RoutingLine."Run Time" * WorkCenter."Unit Cost";
        //Cost1.0
    end;

    //Table - 99000772 Production BOM Line

    [EventSubscriber(ObjectType::Table, Database::"Production BOM Line", 'OnBeforeTestStatus', '', false, false)]
    local procedure OnBeforeTestStatus(var ProductionBOMLine: Record "Production BOM Line"; var IsHandled: Boolean)
    begin
        if not ((UserId = 'SUPER') or (UserId = '10RD010')) then
            IsHandled := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production BOM Line", 'OnAfterTestStatus', '', false, false)]
    local procedure OnAfterTestStatus(ProductionBOMLine: Record "Production BOM Line"; ProductionBOMHeader: Record "Production BOM Header"; ProductionBOMVersion: Record "Production BOM Version")
    var
        Item: Record Item;
    begin
        //>> Added by vishnu on 05-12-2018 to prevent the BOM Picking for PCB abd Fproducts
        if ProductionBOMLine.Type = ProductionBOMLine.Type::"Production BOM" then begin
            if Item.Get(Item."No.") then
                Error('Type Should be Item for %1', Item."No.");
        end;
        //>> Ended by vishnu on 05-12-2018
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production BOM Line", 'OnValidateNoOnAfterAssignItemFields', '', false, false)]
    local procedure OnValidateNoOnAfterAssignItemFields(var ProductionBOMLine: Record "Production BOM Line"; Item: Record Item; var xProductionBOMLine: Record "Production BOM Line"; CallingFieldNo: Integer)
    var
        ProdBOMHeader: Record "Production BOM Header";
    begin
        ProductionBOMLine."Description 2" := Item."Description 2";
        //NSS 030907
        ProductionBOMLine.PCB := Item.PCB;
        //NSS 030907
        Item.TestField("Base Unit of Measure");
        Item.TestField("Item Tracking Code");     //added by pranavi on 08-09-2015
        ProductionBOMLine."Unit of Measure Code" := Item."Base Unit of Measure";
        ProductionBOMLine."Type of Solder" := Item."Type of Solder";
        //"Shelf No." := Item."Shelf No.";
        ProductionBOMLine."No. of Pins" := Item."No. of Pins" * ProductionBOMLine."Quantity per";
        ProductionBOMLine."No. of Soldering Points" := Item."No. of Soldering Points" * (ProductionBOMLine."Quantity per" - ProductionBOMLine."Scrap Quantity");
        ProductionBOMLine."No. of Opportunities" := Item."No. of Opportunities" * ProductionBOMLine."Quantity per";
        ProductionBOMLine.Make := Item.Make;
        ProductionBOMLine."Part number" := Item."Part Number";
        ProductionBOMLine."Storage Temperature" := Item."Storage Temperature";
        ProductionBOMLine.Package := Item.Package;


        //cost1.0
        if Item."Production BOM No." = '' then begin
            ProductionBOMLine."Avg Cost" := Item."Avg Unit Cost";
            ProductionBOMLine."Tot Avg Cost" := ProductionBOMLine."Avg Cost" * ProductionBOMLine."Quantity per";
        end else begin
            ProdBOMHeader.Get(ProdBOMHeader."No.");
            ProdBOMHeader.TestField("Unit of Measure Code");
            ProdBOMHeader.CalcFields(ProdBOMHeader."BOM Cost", ProdBOMHeader."BOM Manufacturing Cost");
            ProductionBOMLine."No. of Soldering Points" := ProdBOMHeader."Total Soldering Points" * ProductionBOMLine."Quantity per";
            ProductionBOMLine."No. of SMD Points" := ProdBOMHeader."Total Soldering Points SMD" * ProductionBOMLine."Quantity per";
            ProductionBOMLine."No. of DIP Point" := ProdBOMHeader."Total Soldering Points DIP" * ProductionBOMLine."Quantity per";

            ProductionBOMLine."Avg Cost" := ProdBOMHeader."BOM Cost";
            ProductionBOMLine."Tot Avg Cost" := ProductionBOMLine."Avg Cost" * ProductionBOMLine."Quantity per";
            if ProductionBOMLine.Type = ProductionBOMLine.Type::"Production BOM" then begin
                ProductionBOMLine."Manufacturing Cost" := ProdBOMHeader."BOM Manufacturing Cost";
                ProductionBOMLine."Tot Avg Cost" := ProductionBOMLine."Avg Cost" * ProductionBOMLine."Quantity per";
            end;
        end;
        if Item."Routing No." <> '' then
            ProductionBOMLine."Manufacturing Cost" := Item."Manufacturing Cost";
        //Cost1.0
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production BOM Line", 'OnValidateNoOnAfterAssignProdBOMFields', '', false, false)]
    local procedure OnValidateNoOnAfterAssignProdBOMFields(var ProductionBOMLine: Record "Production BOM Line"; ProductionBOMHeader: Record "Production BOM Header"; var xProductionBOMLine: Record "Production BOM Line"; CallingFieldNo: Integer)
    var
        ProdBOMHeader: Record "Production BOM Header";
    begin
        //Cost1.0
        ProdBOMHeader.CalcFields(ProdBOMHeader."BOM Cost");
        ProductionBOMLine."Avg Cost" := ProdBOMHeader."BOM Cost";
        ProductionBOMLine."Tot Avg Cost" := ProductionBOMLine."Avg Cost" * ProductionBOMLine."Quantity per";
        ProductionBOMLine."Manufacturing Cost" := ProdBOMHeader."BOM Manufacturing Cost";
        //Cost1.0
    end;

    procedure Permission_Checking(UserName: Text[50]; "Action ID": Text[100]) Status: Boolean
    var
        AcessControl: Record "Access Control";
    begin
        AcessControl.RESET;
        AcessControl.SETFILTER("User Name", UserName);
        IF "Action ID" <> 'ERP-ADMIN' THEN BEGIN
            AcessControl.SETFILTER("Role ID", '%1|%2', "Action ID", 'ERP-ADMIN');
        END ELSE BEGIN
            AcessControl.SETFILTER("Role ID", "Action ID");
        END;
        IF AcessControl.FINDSET THEN BEGIN
            EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;

    procedure MatchManuallyREverse(VAR SelectedBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line"; VAR SelectedBankAccountLedgerEntry: Record "Bank Account Ledger Entry")
    var
        BankAccReconciliationLine: Record 274;
        BankAccountLedgerEntry: Record 271;
        BankAccEntrySetReconNo: Codeunit 375;
        Relation: option "One-to-One","One-to-Many";
        Test: Codeunit 8;
    begin
        IF SelectedBankAccReconciliationLine.FINDFIRST THEN BEGIN
            BankAccReconciliationLine.GET(
              SelectedBankAccReconciliationLine."Statement Type",
              SelectedBankAccReconciliationLine."Bank Account No.",
              SelectedBankAccReconciliationLine."Statement No.",
              SelectedBankAccReconciliationLine."Statement Line No.");
            IF BankAccReconciliationLine.Type <> BankAccReconciliationLine.Type::"Bank Account Ledger Entry" THEN
                EXIT;

            IF SelectedBankAccountLedgerEntry.FINDSET THEN BEGIN
                REPEAT
                    BankAccountLedgerEntry.GET(SelectedBankAccountLedgerEntry."Entry No.");
                    //BankAccEntrySetReconNo.RemoveApplication(BankAccountLedgerEntry);
                    //BankAccEntrySetReconNo.ApplyEntriesReverse(BankAccReconciliationLine, BankAccountLedgerEntry, Relation::"One-to-Many");
                    ApplyEntriesReverse(BankAccReconciliationLine, BankAccountLedgerEntry, Relation::"One-to-Many");
                UNTIL SelectedBankAccountLedgerEntry.NEXT = 0;
            END;
        END;
    end;

    procedure ApplyEntriesReverse(VAR BankAccReconLine: Record "Bank Acc. Reconciliation Line"; VAR BankAccLedgEntry: Record "Bank Account Ledger Entry"; Relation: Option "One-to-One","One-to-Many"): Boolean
    var
        CheckLedgEntry: Record 272;
        BankAccReconLine2: Record 274;
        AmtExceedsErr: Label 'You cannot apply more than %1, current value is %2.';
    begin
        BankAccLedgEntry.LOCKTABLE;
        CheckLedgEntry.LOCKTABLE;
        BankAccReconLine.LOCKTABLE;
        BankAccReconLine.FIND;

        /*
        IF BankAccLedgEntry.IsApplied THEN
                    EXIT(FALSE);

                IF (Relation = Relation::"One-to-One") AND (BankAccReconLine."Applied Entries" > 0) THEN
                    EXIT(FALSE);
        */
        BankAccReconLine.TESTFIELD(BankAccReconLine."Bank Acc LE", 0);
        BankAccReconLine.TESTFIELD(Type, BankAccReconLine.Type::"Bank Account Ledger Entry");
        //>>B2BN1.0 11Jan2019
        BankAccReconLine2.RESET;
        BankAccReconLine2.SETCURRENTKEY("Bank Acc LE");
        BankAccReconLine2.SETRANGE("Bank Acc LE", BankAccLedgEntry."Entry No.");
        BankAccReconLine2.SETRANGE("Statement No.", BankAccReconLine."Statement No.");
        BankAccReconLine2.CALCSUMS("Applied Amount");
        IF ABS((BankAccReconLine2."Applied Amount" + BankAccReconLine."Statement Amount")) > ABS(BankAccLedgEntry."Remaining Amount") THEN
            ERROR(AmtExceedsErr,
              (ABS(BankAccLedgEntry."Remaining Amount") - ABS(BankAccReconLine2."Applied Amount")),
              (ABS(BankAccReconLine2."Applied Amount") + ABS(BankAccReconLine."Statement Amount")));
        //<<B2BN1.0 11Jan2019
        BankAccReconLine."Ready for Application" := TRUE;
        SetReconNoReverse(BankAccLedgEntry, BankAccReconLine);
        BankAccReconLine."Applied Amount" := BankAccReconLine."Statement Amount";
        //BankAccLedgEntry."Remaining Amount";
        BankAccReconLine."Applied Entries" := BankAccReconLine."Applied Entries" + 1;
        BankAccReconLine."Bank Acc LE" := BankAccLedgEntry."Entry No.";
        BankAccReconLine.VALIDATE("Statement Amount");
        BankAccReconLine.MODIFY;
        EXIT(TRUE);
    end;

    procedure SetReconNoReverse(VAR BankAccLedgEntry: Record "Bank Account Ledger Entry"; VAR BankAccReconLine: Record "Bank Acc. Reconciliation Line")
    var
        CheckLedgEntry: Record 272;
    begin
        BankAccLedgEntry.TESTFIELD(Open, TRUE);
        //BankAccLedgEntry.TESTFIELD("Statement Status",BankAccLedgEntry."Statement Status"::Open);
        //BankAccLedgEntry.TESTFIELD("Statement No.",'');
        //BankAccLedgEntry.TESTFIELD("Statement Line No.",0);
        BankAccLedgEntry.TESTFIELD("Bank Account No.", BankAccReconLine."Bank Account No.");
        BankAccLedgEntry."Statement Status" :=
          BankAccLedgEntry."Statement Status"::"Bank Acc. Entry Applied";
        BankAccLedgEntry."Statement No." := BankAccReconLine."Statement No.";
        //BankAccLedgEntry."Statement Line No." := BankAccReconLine."Statement Line No.";
        BankAccLedgEntry.MODIFY;

        CheckLedgEntry.RESET;
        CheckLedgEntry.SETCURRENTKEY("Bank Account Ledger Entry No.");
        CheckLedgEntry.SETRANGE("Bank Account Ledger Entry No.", BankAccLedgEntry."Entry No.");
        CheckLedgEntry.SETRANGE(Open, TRUE);
        IF CheckLedgEntry.FIND('-') THEN
            REPEAT
                CheckLedgEntry.TESTFIELD("Statement Status", CheckLedgEntry."Statement Status"::Open);
                CheckLedgEntry.TESTFIELD("Statement No.", '');
                CheckLedgEntry.TESTFIELD("Statement Line No.", 0);
                CheckLedgEntry."Statement Status" :=
                  CheckLedgEntry."Statement Status"::"Bank Acc. Entry Applied";
                CheckLedgEntry."Statement No." := '';
                CheckLedgEntry."Statement Line No." := 0;
                CheckLedgEntry.MODIFY;
            UNTIL CheckLedgEntry.NEXT = 0;
    end;

    procedure RemoveMatchReverse(VAR SelectedBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line"; VAR SelectedBankAccountLedgerEntry: Record "Bank Account Ledger Entry")
    var
        BankAccountLedgerEntry: Record 271;
    begin
        /*{
        IF SelectedBankAccReconciliationLine.FINDSET THEN
          REPEAT
            BankAccReconciliationLine.GET(
              SelectedBankAccReconciliationLine."Statement Type",
              SelectedBankAccReconciliationLine."Bank Account No.",
              SelectedBankAccReconciliationLine."Statement No.",
              SelectedBankAccReconciliationLine."Statement Line No.");
            BankAccountLedgerEntry.SETRANGE("Bank Account No.",BankAccReconciliationLine."Bank Account No.");
            BankAccountLedgerEntry.SETRANGE("Statement No.",BankAccReconciliationLine."Statement No.");
            BankAccountLedgerEntry.SETRANGE("Statement Line No.",BankAccReconciliationLine."Statement Line No.");
            BankAccountLedgerEntry.SETRANGE(Open,TRUE);
            BankAccountLedgerEntry.SETRANGE("Statement Status",BankAccountLedgerEntry."Statement Status"::"Bank Acc. Entry Applied");
            IF BankAccountLedgerEntry.FINDSET THEN
              REPEAT
                BankAccEntrySetReconNo.RemoveApplicationReverse(BankAccountLedgerEntry);
              UNTIL BankAccountLedgerEntry.NEXT = 0;
          UNTIL SelectedBankAccReconciliationLine.NEXT = 0;
        }*/
        IF SelectedBankAccountLedgerEntry.FINDSET THEN
            REPEAT
                BankAccountLedgerEntry.GET(SelectedBankAccountLedgerEntry."Entry No.");
                //BankAccEntrySetReconNo.RemoveApplicationReverse(BankAccountLedgerEntry);
                RemoveApplicationReverse(BankAccountLedgerEntry);
            UNTIL SelectedBankAccountLedgerEntry.NEXT = 0;
    end;

    procedure RemoveApplicationReverse(VAR BankAccLedgEntry: Record "Bank Account Ledger Entry")
    var
        //BankAccLedgEntry : Record 271;
        CheckLedgEntry: Record 272;
        BankAccReconLine: Record 274;
    begin
        BankAccLedgEntry.LOCKTABLE;
        CheckLedgEntry.LOCKTABLE;
        BankAccReconLine.LOCKTABLE;
        /*{
        IF NOT BankAccReconLine.GET(
             BankAccReconLine."Statement Type"::"Bank Reconciliation",
             BankAccLedgEntry."Bank Account No.",
             BankAccLedgEntry."Statement No.",BankAccLedgEntry."Statement Line No.")
        THEN
          EXIT;
        }*/
        BankAccReconLine.RESET;
        BankAccReconLine.SETRANGE("Bank Acc LE", BankAccLedgEntry."Entry No.");
        BankAccReconLine.SETRANGE("Statement No.", BankAccLedgEntry."Statement No.");
        IF BankAccReconLine.FINDSET THEN BEGIN
            REPEAT
                BankAccReconLine."Applied Amount" -= BankAccReconLine."Statement Amount";//reverse
                BankAccReconLine."Applied Entries" := 0;//BankAccReconLine."Applied Entries" - 1;
                BankAccReconLine."Bank Acc LE" := 0;
                BankAccReconLine.VALIDATE("Statement Amount");
                BankAccReconLine.MODIFY;
            UNTIL BankAccReconLine.NEXT = 0;
            RemoveReconNoReverse(BankAccLedgEntry, BankAccReconLine, TRUE);
        END;
        //BankAccReconLine.TESTFIELD("Statement Type",BankAccReconLine."Statement Type"::"Bank Reconciliation");
        //BankAccReconLine.TESTFIELD(Type,BankAccReconLine.Type::"Bank Account Ledger Entry");
        //RemoveReconNoReverse(BankAccLedgEntry,BankAccReconLine,TRUE);
    end;

    procedure RemoveReconNoReverse(VAR BankAccLedgEntry: Record "Bank Account Ledger Entry"; VAR BankAccReconLine: Record "Bank Acc. Reconciliation Line"; Test: Boolean)
    var
        CheckLedgEntry: Record 272;
    begin
        BankAccLedgEntry.TESTFIELD(Open, TRUE);
        IF Test THEN BEGIN
            BankAccLedgEntry.TESTFIELD(
              "Statement Status", BankAccLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
            BankAccLedgEntry.TESTFIELD("Statement No.", BankAccReconLine."Statement No.");
            //BankAccLedgEntry.TESTFIELD("Statement Line No.",BankAccReconLine."Statement Line No.");
        END;
        BankAccLedgEntry.TESTFIELD("Bank Account No.", BankAccReconLine."Bank Account No.");
        BankAccLedgEntry."Statement Status" := BankAccLedgEntry."Statement Status"::Open;
        BankAccLedgEntry."Statement No." := '';
        BankAccLedgEntry."Statement Line No." := 0;
        BankAccLedgEntry.MODIFY;

        CheckLedgEntry.RESET;
        CheckLedgEntry.SETCURRENTKEY("Bank Account Ledger Entry No.");
        CheckLedgEntry.SETRANGE("Bank Account Ledger Entry No.", BankAccLedgEntry."Entry No.");
        CheckLedgEntry.SETRANGE(Open, TRUE);
        IF CheckLedgEntry.FIND('-') THEN
            REPEAT
                IF Test THEN BEGIN
                    CheckLedgEntry.TESTFIELD(
                      "Statement Status", CheckLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
                    CheckLedgEntry.TESTFIELD("Statement No.", '');
                    CheckLedgEntry.TESTFIELD("Statement Line No.", 0);
                END;
                CheckLedgEntry."Statement Status" := CheckLedgEntry."Statement Status"::Open;
                CheckLedgEntry."Statement No." := '';
                CheckLedgEntry."Statement Line No." := 0;
                CheckLedgEntry.MODIFY;
            UNTIL CheckLedgEntry.NEXT = 0;
    end;

    procedure RemoveMatchReverseSingle(VAR SelectedBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line"; VAR SelectedBankAccountLedgerEntry: Record "Bank Account Ledger Entry")
    var
        BankAccReconciliationLine: Record 274;
        BankAccountLedgerEntry: Record 271;
    begin
        IF SelectedBankAccReconciliationLine.FINDFIRST THEN
            //REPEAT
            BankAccReconciliationLine.GET(
      SelectedBankAccReconciliationLine."Statement Type",
      SelectedBankAccReconciliationLine."Bank Account No.",
      SelectedBankAccReconciliationLine."Statement No.",
      SelectedBankAccReconciliationLine."Statement Line No.");
        BankAccountLedgerEntry.SETRANGE("Bank Account No.", BankAccReconciliationLine."Bank Account No.");
        BankAccountLedgerEntry.SETRANGE("Statement No.", BankAccReconciliationLine."Statement No.");
        BankAccountLedgerEntry.SETRANGE("Entry No.", SelectedBankAccReconciliationLine."Bank Acc LE");
        //BankAccountLedgerEntry.SETRANGE("Statement Line No.",BankAccReconciliationLine."Statement Line No.");
        BankAccountLedgerEntry.SETRANGE(Open, TRUE);
        BankAccountLedgerEntry.SETRANGE("Statement Status", BankAccountLedgerEntry."Statement Status"::"Bank Acc. Entry Applied");
        IF BankAccountLedgerEntry.FINDFIRST THEN
            //BankAccEntrySetReconNo.RemoveApplicationReverseSingle(BankAccountLedgerEntry, BankAccReconciliationLine);
            RemoveApplicationReverseSingle(BankAccountLedgerEntry, BankAccReconciliationLine);
        // UNTIL SelectedBankAccReconciliationLine.NEXT = 0;

        /*{
        IF SelectedBankAccountLedgerEntry.FINDSET THEN
          REPEAT
            BankAccountLedgerEntry.GET(SelectedBankAccountLedgerEntry."Entry No.");
            BankAccEntrySetReconNo.RemoveApplication(BankAccountLedgerEntry);
          UNTIL SelectedBankAccountLedgerEntry.NEXT = 0;
        }*/
    end;

    procedure RemoveApplicationReverseSingle(VAR BankAccLedgEntry: Record "Bank Account Ledger Entry"; BankAccReconLine2: Record "Bank Acc. Reconciliation Line")
    var
        CheckLedgEntry: Record 272;
        BankAccReconLine3: Record 274;
    begin
        BankAccLedgEntry.LOCKTABLE;
        CheckLedgEntry.LOCKTABLE;


        BankAccReconLine2.TESTFIELD("Statement Type", BankAccReconLine2."Statement Type"::"Bank Reconciliation");
        BankAccReconLine2.TESTFIELD(Type, BankAccReconLine2.Type::"Bank Account Ledger Entry");

        // verify bank account Ledger entry applied more than one entry or not >>
        BankAccReconLine3.RESET;

        BankAccReconLine3.SETRANGE("Bank Account No.", BankAccReconLine2."Bank Account No.");
        BankAccReconLine3.SETRANGE("Statement No.", BankAccReconLine2."Statement No.");
        BankAccReconLine3.SETFILTER("Statement Line No.", '<>%1', BankAccReconLine2."Statement Line No.");
        BankAccReconLine3.SETRANGE("Bank Acc LE", BankAccLedgEntry."Entry No.");
        IF NOT BankAccReconLine3.FINDFIRST THEN
            RemoveReconNoReverseSingle(BankAccLedgEntry, BankAccReconLine2, TRUE);
        // verify bank account Ledger entry applied more than one entry or not <<

        BankAccReconLine2."Applied Amount" := 0;//BankAccLedgEntry."Remaining Amount";
        BankAccReconLine2."Applied Entries" := 0;//BankAccReconLine."Applied Entries" - 1;
        BankAccReconLine2."Bank Acc LE" := 0;
        BankAccReconLine2.VALIDATE("Statement Amount");
        BankAccReconLine2.MODIFY;
    end;

    procedure RemoveReconNoReverseSingle(VAR BankAccLedgEntry: Record "Bank Account Ledger Entry"; VAR BankAccReconLine: Record "Bank Acc. Reconciliation Line"; Test: Boolean)
    var
        CheckLedgEntry: Record 272;
    begin
        BankAccLedgEntry.TESTFIELD(Open, TRUE);
        IF Test THEN BEGIN
            BankAccLedgEntry.TESTFIELD(
              "Statement Status", BankAccLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
            BankAccLedgEntry.TESTFIELD("Statement No.", BankAccReconLine."Statement No.");
            //BankAccLedgEntry.TESTFIELD("Statement Line No.",BankAccReconLine."Statement Line No.");
        END;
        BankAccLedgEntry.TESTFIELD("Bank Account No.", BankAccReconLine."Bank Account No.");
        BankAccLedgEntry."Statement Status" := BankAccLedgEntry."Statement Status"::Open;
        BankAccLedgEntry."Statement No." := '';
        BankAccLedgEntry."Statement Line No." := 0;
        BankAccLedgEntry.MODIFY;

        CheckLedgEntry.RESET;
        CheckLedgEntry.SETCURRENTKEY("Bank Account Ledger Entry No.");
        CheckLedgEntry.SETRANGE("Bank Account Ledger Entry No.", BankAccLedgEntry."Entry No.");
        CheckLedgEntry.SETRANGE(Open, TRUE);
        IF CheckLedgEntry.FIND('-') THEN
            REPEAT
                IF Test THEN BEGIN
                    CheckLedgEntry.TESTFIELD(
                      "Statement Status", CheckLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
                    CheckLedgEntry.TESTFIELD("Statement No.", '');
                    CheckLedgEntry.TESTFIELD("Statement Line No.", 0);
                END;
                CheckLedgEntry."Statement Status" := CheckLedgEntry."Statement Status"::Open;
                CheckLedgEntry."Statement No." := '';
                CheckLedgEntry."Statement Line No." := 0;
                CheckLedgEntry.MODIFY;
            UNTIL CheckLedgEntry.NEXT = 0;
    end;



    PROCEDURE PrintRecords1(ShowRequestForm: Boolean; Var SalesInvHeaderpar: record "Sales Invoice Header");
    VAR
        ReportSelection: Record 77;
        SalesInvHeader: record "Sales Invoice Header";

    BEGIN
        WITH SalesInvHeader DO BEGIN
            COPY(SalesInvHeaderpar);
            FIND('-');
            ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"S.Invoice");
            ReportSelection.SETRANGE(ReportSelection.Sequence, '2');
            ReportSelection.SETFILTER("Report ID", '<>0');
            ReportSelection.FIND('-');
            REPEAT
                REPORT.RUNMODAL(ReportSelection."Report ID", ShowRequestForm, FALSE, SalesInvHeader);
            UNTIL ReportSelection.NEXT = 0;
        END;
    END;

    procedure SDStatusUpdate(SaleOrderNo: Code[20]; PostingDateVar: Date)
    var
        SIH: Record "Sales Invoice Header";
        Warranty: Code[10];
        SIDummy: Record "Sales Invoice-Dummy";
    begin
        IF (SaleOrderNo <> '') THEN BEGIN
            SIH.RESET;
            SIH.SETRANGE(SIH."Order No.", SaleOrderNo);
            IF SIH.FINDSET THEN
                REPEAT
                    SIH.VALIDATE(SIH."Final Railway Bill Date", PostingDateVar);
                    IF COPYSTR(SIH."Order No.", 5, 3) = 'AMC' THEN
                        SIH.SecDepStatus := SIH.SecDepStatus::Due
                    ELSE BEGIN
                        IF (FORMAT(SIH."Warranty Period") <> '') THEN BEGIN
                            IF CALCDATE('+' + FORMAT(SIH."Warranty Period"), SIH."Final Railway Bill Date") <= TODAY() THEN
                                SIH.SecDepStatus := SIH.SecDepStatus::Due
                            ELSE
                                SIH.SecDepStatus := SIH.SecDepStatus::Warranty;
                        END;
                    END;
                    Warranty := FORMAT(SIH."Warranty Period");
                    SIH.MODIFY;
                UNTIL SIH.NEXT = 0;
            SIDummy.RESET;
            SIDummy.SETRANGE(SIDummy."No.", SaleOrderNo);
            IF SIDummy.FINDFIRST THEN BEGIN
                SIDummy.VALIDATE(SIDummy."Final Railway Bill Date", PostingDateVar);
                IF COPYSTR(SIDummy."No.", 5, 3) = 'AMC' THEN
                    SIDummy.SecDepStatus := SIDummy.SecDepStatus::Due
                ELSE BEGIN
                    IF (FORMAT(SIDummy."Warranty Period") <> '') THEN BEGIN
                        IF CALCDATE('+' + FORMAT(SIDummy."Warranty Period"), SIDummy."Final Railway Bill Date") <= TODAY() THEN
                            SIDummy.SecDepStatus := SIDummy.SecDepStatus::Due
                        ELSE
                            SIDummy.SecDepStatus := SIDummy.SecDepStatus::Warranty;
                    END;
                END;
                SIDummy.MODIFY;
            END;
        END;
    end;

    /* procedure ArchiveServiceDocument(VAR ServiceHeader: Record "Service Header")
    var
        Text007: Label 'Archive %1 no.: %2?';
        Text001: Label 'Document %1 has been archived.';
    begin
        IF CONFIRM(Text007, TRUE, ServiceHeader."Document Type", ServiceHeader."No.") THEN BEGIN
            StoreServiceDocument(ServiceHeader, FALSE);
            MESSAGE(Text001, ServiceHeader."No.");
        END;
    end;

    procedure StoreServiceDocument(VAR ServiceHeader: Record "Service Header"; InteractionExist: Boolean)
    var
        ServiceHeaderArchive: Record "Service Header Archive";
        ServiceItemLine: Record "Service Item Line";
        ServiceItemLineArchive: Record "Service Item Line Archive";
        ServiceInvoiceLine: Record "Service Invoice Line";
        ServiceInvoiceLineArchive: Record "Service Invoice Line Archive";
    begin
        ServiceHeaderArchive.INIT;
        ServiceHeaderArchive.TRANSFERFIELDS(ServiceHeader);
        ServiceHeaderArchive."Archived by" := USERID;
        ServiceHeaderArchive."Date Archived" := WORKDATE;
        ServiceHeaderArchive."Time Archived" := TIME;
        ServiceHeaderArchive."Version No." := GetNextVersionNo(DATABASE::"Service Header", ServiceHeader."Document Type", ServiceHeader."No.", ServiceHeader."Doc. No. Occurrence");

        ServiceHeaderArchive."Interaction Exist" := InteractionExist;
        ServiceHeaderArchive.INSERT;
        // B2B
        StoreServiceESPLAttachments(ServiceHeader, DATABASE::"Service Header");
        // B2B

        ServiceItemLine.SETRANGE("Document Type", ServiceHeader."Document Type");
        ServiceItemLine.SETRANGE("Document No.", ServiceHeader."No.");
        IF ServiceItemLine.FINDSET THEN
                REPEAT
                    WITH ServiceItemLineArchive DO BEGIN
                        INIT;
                        TRANSFERFIELDS(ServiceItemLine);
                        "Doc. No. Occurrence" := ServiceHeader."Doc. No. Occurrence";
                        "Version No." := ServiceHeaderArchive."Version No.";
                        INSERT;
                    END
                UNTIL ServiceItemLine.NEXT = 0;


        ServiceInvoiceLine.SETRANGE("Document Type", ServiceHeader."Document Type");
        ServiceInvoiceLine.SETRANGE("Document No.", ServiceHeader."No.");
        IF ServiceInvoiceLine.FINDSET THEN BEGIN
                                               REPEAT
                                                   WITH ServiceInvoiceLineArchive DO BEGIN
                                                       INIT;
                                                       TRANSFERFIELDS(ServiceInvoiceLine);
                                                       "Doc. No. Occurrence" := ServiceHeader."Doc. No. Occurrence";
                                                       "Version No." := ServiceHeaderArchive."Version No.";
                                                       INSERT;
                                                   END
                                               UNTIL ServiceInvoiceLine.NEXT = 0;
        END;
    end;

    procedure StoreServiceESPLAttachments(VAR ServiceHeader: Record "Service Header"; TableId: Option)
    var
    Attachment:Record Attachment;
    AttachmentArchive:Record "Attachments Archive";
    ServiceHeader1:Record "Service Header";
    begin
        Attachment.RESET;
        Attachment.SETRANGE("Table ID", TableId);
        Attachment.SETRANGE("Document No.", ServiceHeader."No.");
        Attachment.SETRANGE("Document Type", ServiceHeader."Document Type");
        IF Attachment.FINDSET THEN
            REPEAT
                    Attachment.CALCFIELDS(FileAttachment);
                AttachmentArchive.TRANSFERFIELDS(Attachment);
                ServiceHeader1 := ServiceHeader;
                AttachmentArchive."Document Version No." := ServiceHeader1."Doc. No. Occurrence" + 1;
                AttachmentArchive.INSERT;
            UNTIL Attachment.NEXT = 0;
    end; */

    //>> CU99000845
    procedure SetDelChallanLine(NewScheduleComp: Record Schedule2)
    var
        CalcReservEntry: Record "Reservation Entry";
        CalcReservEntry2: Record "Reservation Entry";
        Positive: Boolean;
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        ForDelChallanLine: Record Schedule2;
        DelChallanHeadLRec: Record "Sales Header";

        ResrMgmt: Codeunit "Reservation Management";
        TempTrackingSpecification: Record "Tracking Specification";
    begin
        DelChallanHeadLRec.GET(NewScheduleComp."Document No.");

        CLEARALL;
        TempTrackingSpecification.DELETEALL;

        ForDelChallanLine := NewScheduleComp;

        CalcReservEntry."Source Type" := DATABASE::Schedule2;
        CalcReservEntry."Source Subtype" := 0;
        CalcReservEntry."Source ID" := NewScheduleComp."Document No.";
        CalcReservEntry."Source Ref. No." := NewScheduleComp."Line No.";
        CalcReservEntry."Source Prod. Order Line" := NewScheduleComp."Document Line No.";
        CalcReservEntry."Item No." := NewScheduleComp."No.";

        CalcReservEntry."Location Code" := DelChallanHeadLRec."Location Code";
        CalcReservEntry."Serial No." := '';
        CalcReservEntry."Lot No." := '';
        CalcReservEntry."Qty. per Unit of Measure" := NewScheduleComp."Qty. per Unit of Measure";
        CalcReservEntry.Description := NewScheduleComp.Description;
        CalcReservEntry2 := CalcReservEntry;
        GetItemSetup(CalcReservEntry);


        Positive :=
          ((CreateReservEntry.SignFactor(CalcReservEntry) * ForDelChallanLine."Outstanding Qty.(Base)") <= 0);

        SetPointerFilter(CalcReservEntry2);
    end;

    local procedure SetPointerFilter(VAR ReservEntry: Record "Reservation Entry")
    var
        myInt: Integer;
    begin
        ReservEntry.SETCURRENTKEY(
  "Source ID", "Source Ref. No.", "Source Type", "Source Subtype",
  "Source Batch Name", "Source Prod. Order Line", "Reservation Status",
  "Shipment Date", "Expected Receipt Date");
        ReservEntry.SETRANGE("Source ID", ReservEntry."Source ID");
        ReservEntry.SETRANGE("Source Ref. No.", ReservEntry."Source Ref. No.");
        ReservEntry.SETRANGE("Source Type", ReservEntry."Source Type");
        ReservEntry.SETRANGE("Source Subtype", ReservEntry."Source Subtype");
        ReservEntry.SETRANGE("Source Batch Name", ReservEntry."Source Batch Name");
        ReservEntry.SETRANGE("Source Prod. Order Line", ReservEntry."Source Prod. Order Line");
    end;
    //B2BUPG

    local procedure GetItemSetup(VAR ReservEntry: Record "Reservation Entry")
    var
        myInt: Integer;
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        MfgSetup: Record "Manufacturing Setup";
        GetPlanningParameters: Codeunit "Planning-Get Parameters";
        SKU: record "Stockkeeping Unit";
    begin
        IF ReservEntry."Item No." <> Item."No." THEN BEGIN
            Item.GET(ReservEntry."Item No.");
            IF Item."Item Tracking Code" <> '' THEN
                ItemTrackingCode.GET(Item."Item Tracking Code")
            ELSE
                ItemTrackingCode.INIT;
            GetPlanningParameters.AtSKU(SKU, ReservEntry."Item No.",
              ReservEntry."Variant Code", ReservEntry."Location Code");
            MfgSetup.GET;
        END;

    end;
    //B2BUPG
    //>> CU99000845

    //ARCHIVEMANAGEMENT <<B2BUPG>>
    PROCEDURE StoreSalesESPLAttachments(VAR SalesHeader: Record 36; TableID: Option);
    VAR
        Attachment: Record 60098;
        TableName: Text[100];
        AttachmentArchive: Record 60099;
        SalesHeader1: Record 36;
    BEGIN
        Attachment.RESET;
        Attachment.SETRANGE("Table ID", TableID);
        Attachment.SETRANGE("Document No.", SalesHeader."No.");
        Attachment.SETRANGE("Document Type", SalesHeader."Document Type");
        /* {IF Attachment.FINDSET THEN
           REPEAT
             Attachment.CALCFIELDS(FileAttachment);
             AttachmentArchive.TRANSFERFIELDS(Attachment);
             SalesHeader1:=SalesHeader;
             AttachmentArchive."Document Version No.":=SalesHeader1."No. of Archived Versions"+1;
             AttachmentArchive.INSERT;
           UNTIL Attachment.NEXT=0;
          anil comented310312 }*/
    END;

    PROCEDURE StorePurchaseESPLAttachments(VAR PurchHeader: Record 38; TableId: Option);
    VAR
        Attachment: Record 60098;
        TableName: Text[100];
        AttachmentArchive: Record 60099;
        PurchHeader1: Record 38;
    BEGIN
        Attachment.RESET;
        Attachment.SETRANGE("Table ID", TableId);
        Attachment.SETRANGE("Document No.", PurchHeader."No.");
        Attachment.SETRANGE("Document Type", PurchHeader."Document Type");
        IF Attachment.FINDSET THEN
            REPEAT
                Attachment.CALCFIELDS(FileAttachment);
                AttachmentArchive.TRANSFERFIELDS(Attachment);
                PurchHeader1 := PurchHeader;
                AttachmentArchive."Document Version No." := PurchHeader1."No. of Archived Versions" + 1;
                AttachmentArchive.INSERT;
            UNTIL Attachment.NEXT = 0;
    END;

    PROCEDURE StoreServiceESPLAttachments(VAR ServiceHeader: Record 5900; TableId: Option);
    VAR
        Attachment: Record 60098;
        TableName: Text[100];
        AttachmentArchive: Record 60099;
        ServiceHeader1: Record 5900;
    BEGIN
        Attachment.RESET;
        Attachment.SETRANGE("Table ID", TableId);
        Attachment.SETRANGE("Document No.", ServiceHeader."No.");
        Attachment.SETRANGE("Document Type", ServiceHeader."Document Type");
        IF Attachment.FINDSET THEN
            REPEAT
                Attachment.CALCFIELDS(FileAttachment);
                AttachmentArchive.TRANSFERFIELDS(Attachment);
                ServiceHeader1 := ServiceHeader;
                AttachmentArchive."Document Version No." := ServiceHeader1."Doc. No. Occurrence" + 1;
                AttachmentArchive.INSERT;
            UNTIL Attachment.NEXT = 0;
    END;

    PROCEDURE ArchiveServiceDocument(VAR ServiceHeader: Record 5900);
    BEGIN
        IF CONFIRM(Text007, TRUE, ServiceHeader."Document Type", ServiceHeader."No.") THEN BEGIN
            StoreServiceDocument(ServiceHeader, FALSE);
            MESSAGE(Text001, ServiceHeader."No.");
        END;
    END;

    PROCEDURE StoreServiceDocument(VAR ServiceHeader: Record 5900; InteractionExist: Boolean);
    VAR
        ServiceHeaderArchive: Record 60015;
        ServiceItemLine: Record 5901;
        ServiceItemLineArchive: Record 60016;
        ServiceInvoiceLine: Record 5902;
        ServiceInvoiceLineArchive: Record 60017;
        ArchMgmt: Codeunit ArchiveManagement;
    BEGIN
        ServiceHeaderArchive.INIT;
        ServiceHeaderArchive.TRANSFERFIELDS(ServiceHeader);
        ServiceHeaderArchive."Archived by" := USERID;
        ServiceHeaderArchive."Date Archived" := WORKDATE;
        ServiceHeaderArchive."Time Archived" := TIME;
        ServiceHeaderArchive."Version No." := ArchMgmt.GetNextVersionNo(
            DATABASE::"Service Header",
            ServiceHeader."Document Type",
            ServiceHeader."No.",
            ServiceHeader."Doc. No. Occurrence");

        ServiceHeaderArchive."Interaction Exist" := InteractionExist;
        ServiceHeaderArchive.INSERT;
        // B2B
        StoreServiceESPLAttachments(ServiceHeader, DATABASE::"Service Header");
        // B2B

        ServiceItemLine.SETRANGE("Document Type", ServiceHeader."Document Type");
        ServiceItemLine.SETRANGE("Document No.", ServiceHeader."No.");
        IF ServiceItemLine.FINDSET THEN
            REPEAT
                WITH ServiceItemLineArchive DO BEGIN
                    INIT;
                    TRANSFERFIELDS(ServiceItemLine);
                    "Doc. No. Occurrence" := ServiceHeader."Doc. No. Occurrence";
                    "Version No." := ServiceHeaderArchive."Version No.";
                    INSERT;
                END
            UNTIL ServiceItemLine.NEXT = 0;


        ServiceInvoiceLine.SETRANGE("Document Type", ServiceHeader."Document Type");
        ServiceInvoiceLine.SETRANGE("Document No.", ServiceHeader."No.");
        IF ServiceInvoiceLine.FINDSET THEN BEGIN
            REPEAT
                WITH ServiceInvoiceLineArchive DO BEGIN
                    INIT;
                    TRANSFERFIELDS(ServiceInvoiceLine);
                    "Doc. No. Occurrence" := ServiceHeader."Doc. No. Occurrence";
                    "Version No." := ServiceHeaderArchive."Version No.";
                    INSERT;
                END
            UNTIL ServiceInvoiceLine.NEXT = 0;
        END;
    END;

    PROCEDURE RestoreServiceDocument(VAR ServiceHeaderArchive: Record 60015);
    VAR
        RestoreDocument: Boolean;
        NextLine: Integer;
        ServiceHeader: Record 5900;
        ServiceCommentLine: Record 5906;
        TmpServiceCommentLine: Record 5906 TEMPORARY;
        ServiceItemLineArchive: Record 60016;
        ServiceItemLine: Record 5901;
        ServInvLineArchive: Record 60016;
        ServiceInvoiceLine: Record 5902;
    BEGIN
        ServiceHeader.GET(ServiceHeaderArchive."Document Type", ServiceHeaderArchive."No.");
        ServiceHeader.TESTFIELD(Status, ServiceHeader.Status::Pending);

        RestoreDocument := TRUE;
        // ... depending on further checks it might be set false later

        IF RestoreDocument THEN BEGIN
            // Prevent commentlines from being deleted:
            ServiceCommentLine.RESET;
            ServiceCommentLine.SETRANGE("Table Name", ServiceCommentLine."Table Name"::"Service Header");
            ServiceCommentLine.SETRANGE("Table Subtype", 0);
            ServiceCommentLine.SETRANGE("No.", ServiceHeaderArchive."No.");
            ServiceCommentLine.SETRANGE(Type, ServiceCommentLine.Type::General);
            ServiceCommentLine.SETRANGE("Table Line No.", 0);
            IF ServiceCommentLine.FINDSET THEN BEGIN
                REPEAT
                    TmpServiceCommentLine.INIT;
                    TmpServiceCommentLine.TRANSFERFIELDS(ServiceCommentLine);
                    TmpServiceCommentLine.INSERT;
                UNTIL ServiceCommentLine.NEXT = 0;
            END;

            // Must be the same ...
            ServiceHeader.TESTFIELD("Doc. No. Occurrence", ServiceHeaderArchive."Doc. No. Occurrence");

            // Delete old service quote
            ServiceHeader.DELETE(TRUE);


            ServiceHeader.INIT;

            // Prevent Confirms to appear
            ServiceHeader.SetHideValidationDialog(TRUE);

            ServiceHeader."Document Type" := ServiceHeaderArchive."Document Type";
            ServiceHeader."No." := ServiceHeaderArchive."No.";
            ServiceHeader.INSERT(TRUE);
            ServiceHeader.TRANSFERFIELDS(ServiceHeaderArchive);
            ServiceHeader.Status := ServiceHeader.Status::Pending;

            IF ServiceHeaderArchive."Contact No." <> '' THEN
                ServiceHeader.VALIDATE("Contact No.", ServiceHeaderArchive."Contact No.")
            ELSE
                ServiceHeader.VALIDATE("Customer No.", ServiceHeaderArchive."Customer No.");

            IF ServiceHeaderArchive."Bill-to Contact No." <> '' THEN
                ServiceHeader.VALIDATE("Bill-to Contact No.", ServiceHeaderArchive."Bill-to Contact No.")
            ELSE
                ServiceHeader.VALIDATE("Bill-to Customer No.", ServiceHeaderArchive."Bill-to Customer No.");

            ServiceHeader.VALIDATE("Salesperson Code", ServiceHeaderArchive."Salesperson Code");
            ServiceHeader.MODIFY(TRUE);

            IF TmpServiceCommentLine.FINDSET THEN
                REPEAT
                    ServiceCommentLine.INIT;
                    ServiceCommentLine.TRANSFERFIELDS(TmpServiceCommentLine);
                    ServiceCommentLine.INSERT;
                UNTIL TmpServiceCommentLine.NEXT = 0;


            // Find new lineno. for comment line
            ServiceCommentLine.RESET;
            ServiceCommentLine.SETRANGE("Table Name", ServiceCommentLine."Table Name"::"Service Header");
            ServiceCommentLine.SETRANGE("Table Subtype", 0);
            ServiceCommentLine.SETRANGE("No.", ServiceHeader."No.");
            ServiceCommentLine.SETRANGE(Type, ServiceCommentLine.Type::General);
            ServiceCommentLine.SETRANGE("Table Line No.", 0);
            IF ServiceCommentLine.FINDLAST THEN
                NextLine := ServiceCommentLine."Line No.";
            NextLine += 10000;

            // Create comment line: "Document restored from Version ..."
            ServiceCommentLine.INIT;
            ServiceCommentLine."Table Name" := ServiceCommentLine."Table Name"::"Service Header";
            ServiceCommentLine."Table Subtype" := "Service Comment Table Subtype".FromInteger(0);
            ServiceCommentLine."No." := ServiceHeader."No.";
            ServiceCommentLine.Type := ServiceCommentLine.Type::General;
            ServiceCommentLine."Table Line No." := 0;
            ServiceCommentLine."Line No." := NextLine;
            ServiceCommentLine.Date := WORKDATE;
            ServiceCommentLine.Comment := STRSUBSTNO(Text004, FORMAT(ServiceHeaderArchive."Version No."));
            ServiceCommentLine.INSERT;

            // Service Item Lines
            ServiceItemLineArchive.SETRANGE("Document Type", ServiceHeaderArchive."Document Type");
            ServiceItemLineArchive.SETRANGE("Document No.", ServiceHeaderArchive."No.");
            ServiceItemLineArchive.SETRANGE("Doc. No. Occurrence", ServiceHeaderArchive."Doc. No. Occurrence");
            ServiceItemLineArchive.SETRANGE("Version No.", ServiceHeaderArchive."Version No.");

            IF ServiceItemLineArchive.FINDSET THEN BEGIN
                REPEAT
                    WITH ServiceItemLine DO BEGIN
                        INIT;
                        TRANSFERFIELDS(ServiceItemLineArchive);
                        INSERT(TRUE);

                        IF "Item No." <> '' THEN BEGIN
                            VALIDATE("Item No.");
                            IF ServiceItemLineArchive."Variant Code" <> '' THEN
                                VALIDATE("Variant Code", ServiceItemLineArchive."Variant Code");
                            VALIDATE(Description, ServiceItemLineArchive.Description);
                        END;
                        MODIFY(TRUE);

                    END;
                UNTIL ServiceItemLineArchive.NEXT = 0;
            END;


            // Service Invoice Lines
            ServInvLineArchive.SETRANGE("Document Type", ServiceHeaderArchive."Document Type");
            ServInvLineArchive.SETRANGE("Document No.", ServiceHeaderArchive."No.");
            ServInvLineArchive.SETRANGE("Doc. No. Occurrence", ServiceHeaderArchive."Doc. No. Occurrence");
            ServInvLineArchive.SETRANGE("Version No.", ServiceHeaderArchive."Version No.");
            IF ServInvLineArchive.FINDSET THEN BEGIN
                REPEAT
                    WITH ServiceInvoiceLine DO BEGIN
                        INIT;
                        TRANSFERFIELDS(ServInvLineArchive);
                        INSERT(TRUE);
                    END;
                UNTIL ServInvLineArchive.NEXT = 0;
            END;



            //SalesHeader.Status := SalesHeader.Status::Released;
            //ReleaseSalesDoc.Reopen(SalesHeader);

            MESSAGE(Text003, ServiceHeader."Document Type", ServiceHeader."No.");
        END;
    END;

    PROCEDURE "Store Design Document"(DesignWorksheetHeader: Record 60006; "VersionNo.": Integer);
    VAR
        DWSHeader: Record 60006;
        ArchivedDesignWorkSheetHeader: Record 60009;
        ArchivedDesignWorkSheetLine: Record 60010;
        DWSLine: Record 60007;
    BEGIN
        DWSHeader.SETRANGE("Document Type", DesignWorksheetHeader."Document Type");
        DWSHeader.SETRANGE("Document No.", DesignWorksheetHeader."Document No.");
        DWSHeader.SETRANGE("Document Line No.", DesignWorksheetHeader."Document Line No.");
        IF DWSHeader.FINDFIRST THEN BEGIN
            ArchivedDesignWorkSheetHeader.INIT;
            ArchivedDesignWorkSheetHeader.TRANSFERFIELDS(DWSHeader);
            ArchivedDesignWorkSheetHeader.SETRANGE("Document Type", ArchivedDesignWorkSheetHeader."Document Type");
            ArchivedDesignWorkSheetHeader.SETRANGE("Document No.", ArchivedDesignWorkSheetHeader."Document No.");
            ArchivedDesignWorkSheetHeader.SETRANGE("Document Line No.", ArchivedDesignWorkSheetHeader."Document Line No.");
            IF ArchivedDesignWorkSheetHeader.FINDLAST THEN
                ArchivedDesignWorkSheetHeader."Version No." := ArchivedDesignWorkSheetHeader."Version No." + 1
            ELSE
                ArchivedDesignWorkSheetHeader."Version No." := 1;
            //  ArchivedDesignWorkSheetHeader."Main Item Manu Cost" := USERID;
            //  ArchivedDesignWorkSheetHeader."Total Manu Cost" := WORKDATE;
            ArchivedDesignWorkSheetHeader."Archived By." := USERID;
            ArchivedDesignWorkSheetHeader.INSERT;
            DWSLine.SETRANGE("Document Type", DWSHeader."Document Type"::Tender);
            DWSLine.SETRANGE("Document No.", DWSHeader."Document No.");
            DWSLine.SETRANGE("Document Line No.", DWSHeader."Document Line No.");
            IF DWSLine.FINDSET THEN BEGIN
                REPEAT
                    WITH ArchivedDesignWorkSheetLine DO BEGIN
                        INIT;
                        TRANSFERFIELDS(DWSLine);
                        "Version No." := ArchivedDesignWorkSheetHeader."Version No.";
                        INSERT;
                    END;
                UNTIL DWSLine.NEXT = 0;
            END;
        END;
    END;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::AccSchedManagement, 'OnBeforeCalcGLAcc', '', false, false)]
    local procedure OnBeforeCalcGLAcc(var GLAcc: Record "G/L Account"; var AccSchedLine: Record "Acc. Schedule Line"; var ColumnLayout: Record "Column Layout"; CalcAddCurr: Boolean; var ColValue: Decimal; var IsHandled: Boolean)
    var
    begin
        // NaV 2009 code copied by sundar
        CASE AccSchedLine."Amount Type" OF
            AccSchedLine."Amount Type"::"Debit Amount":
                CASE AmountType OF
                    AmountType::"Net Amount":
                        AmountType := AmountType::"Debit Amount";
                    AmountType::"Credit Amount":
                        //EXIT(0);
                        //B2BESGOn01Jul2022++
                        begin
                            ColValue := 0;
                            IsHandled := TRUE;
                        end;
                //B2BESGOn01Jul2022--
                END;
            AccSchedLine."Amount Type"::"Credit Amount":
                CASE AmountType OF
                    AmountType::"Net Amount":
                        AmountType := AmountType::"Credit Amount";
                    AmountType::"Debit Amount":
                        //EXIT(0)
                        //B2BESGOn01Jul2022++
                        begin
                            ColValue := 0;
                            IsHandled := TRUE;
                        end;
                //B2BESGOn01Jul2022--
                END;
        // NaV 2009 code copied by sundar
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", 'OnBeforeCode', '', false, false)]
    local procedure OnBeforeCode(var GenJournalLine: Record "Gen. Journal Line"; PreviewMode: Boolean; CommitIsSuppressed: Boolean)
    begin
        //Added By Pranavi on 04-08-2015 for restricting the postin if not chosen vendor
        Genjournal.RESET;
        Genjournal.SETRANGE(Genjournal."Journal Batch Name", GenJournalLine."Journal Batch Name");
        Genjournal.SETRANGE(Genjournal."Posting Date", WORKDATE);
        Genjournal.SETRANGE(Genjournal."Document No.", GenJournalLine."Document No.");
        IF Genjournal.FINDSET THEN
            REPEAT
                IF (Genjournal."Account Type" = Genjournal."Account Type"::"G/L Account")
                AND (Genjournal."Account No." IN ['51400', '53100', '53400', '58100', '58300', '58500', '58800', '59100', '59101', '59900',
                                                  '60200', '60300', '61905', '61911', '61919',
                                                  '61925', '62000', '62100', '65300', '67300']) THEN BEGIN
                    IF Genjournal."Payment Through" <> Genjournal."Payment Through"::"Credit-Card" THEN   // Added by Pranavi on 20-Jul-2016 for exception of vendor no for some foreign vendors
                    BEGIN
                        IF Genjournal.Amount > 500 THEN             //added by pranavi on 14-08-2015 for vendor no needed if amount > 500
                        BEGIN
                            VendrCount := 0;
                            GenJournl.RESET;
                            GenJournl.SETFILTER(GenJournl."Document No.", Genjournal."Document No.");
                            IF GenJournl.FINDSET THEN
                                REPEAT
                                    IF (GenJournl."Account Type" = GenJournl."Account Type"::Vendor) THEN BEGIN
                                        VendrCount := VendrCount + 1;
                                        IF GenJournl."Account No." = '' THEN
                                            ERROR('Vendor Account No. Must be Specified for The Document No: ' + GenJournl."Document No." + ' in Line No.: ' + FORMAT(GenJournl."Line No."));
                                    END
                                    ELSE
                                        IF (GenJournl."Account Type" = GenJournl."Account Type"::"G/L Account") AND
                                           (COPYSTR(GenJournl."Shortcut Dimension 1 Code", 1, 3) = 'CUS') AND (GenJournl."Account No." = '40808') THEN BEGIN
                                            VendrCount := VendrCount + 1;
                                        END;
                                UNTIL GenJournl.NEXT = 0;
                            // IF USERID <> 'EFFTRONICS\DURGAMAHESWARI' THEN
                            IF VendrCount = 0 THEN
                                ERROR('Vendor/HO Account Cash Entry must be specified against the Doc No.: ' + GenJournl."Document No.");
                        END;
                    END;
                END;
            UNTIL Genjournal.NEXT = 0;
        //End By Pranavi on 04-08-2015
    end;

    [EventSubscriber(ObjectType::Table, Database::"Interaction Log Entry", 'OnAfterCopyFromSegment', '', false, false)]
    local procedure OnAfterCopyFromSegment(var InteractionLogEntry: Record "Interaction Log Entry"; SegmentLine: Record "Segment Line")
    begin
        InteractionLogEntry."OutWard No." := SegmentLine."OutWard No.";
        InteractionLogEntry."InWard No." := SegmentLine."InWard No.";
        InteractionLogEntry."OutWard Ref No." := SegmentLine."OutWard Ref No.";
        InteractionLogEntry."InWard Ref No." := SegmentLine."InWard Ref No.";
    end;





    var
        //Test: Codeunit 7010;
        Genjournal: Record 81;
        VendrCount: Decimal;
        textcnt: Decimal;
        GenJournl: Record 81;
        AmountType: Option "Net Amount","Debit Amount","Credit Amount";
        Text001: Label 'ENU=Document %1 has been archived.;ENN=Document %1 has been archived.';
        Text002: Label 'ENU=Do you want to Restore %1 %2 Version %3?;ENN=Do you want to Restore %1 %2 Version %3?';
        Text003: Label 'ENU=%1 %2 has been restored.;ENN=%1 %2 has been restored.';
        Text004: Label 'ENU=Document restored from Version %1.;ENN=Document restored from Version %1.';
        Text005: Label 'ENU=%1 %2 has been partly posted.\Restore not possible.;ENN=%1 %2 has been partly posted.\Restore not possible.';
        Text006: Label 'ENU=Entries exist for on or more of the following:\  - %1\  - %2\  - %3.\Restoration of document will delete these entries.\Continue with restore?;ENN=Entries exist for on or more of the following:\  - %1\  - %2\  - %3.\Restoration of document will delete these entries.\Continue with restore?';
        Text007: Label 'ENU=Archive %1 no.: %2?;ENN=Archive %1 no.: %2?';
        Text008: Label 'ENU=Item Tracking Line;ENN=Item Tracking Line';
        ReleaseSalesDoc: Codeunit 414;
        Text009: Label 'ENU=Unposted %1 %2 does not exist anymore.\It is not possible to restore the %1.;ENN=Unposted %1 %2 does not exist anymore.\It is not possible to restore the %1.';
        DeferralUtilities: Codeunit 1720;
        tempvar: Text;
        BG: Record 60061;
        TH: Record 60062;
        CustomerContactData: Record 14125605;
        CustomerContactDataArchive: Record 14125606;

}