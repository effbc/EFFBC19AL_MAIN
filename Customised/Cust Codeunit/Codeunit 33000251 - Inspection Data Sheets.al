codeunit 33000251 "Inspection Data Sheets"
{
    // version QC1.1,WIP1.1,QCB2B1.2,B2B1.2-ESPL,Cal1.0,QCP1.0v,Sundar

    // Vendor Quality to be checked for before inspection
    // 
    // B2B 10sep2007
    // added code in InsertInspectionDataHeader()
    // 
    // AR Espl   1.0    06.05.08   Changed the entry type from output to consumption

    TableNo = "Inspection Lot";

    trigger OnRun();
    begin
        TESTFIELD("Lot No.");
        IF "Inspect. Data sheet created" THEN
            IF NOT CONFIRM(Text001, FALSE, "Lot No.") THEN
                EXIT;
        PurchRcptLine.GET("Document No.", "Purch. Line No.");
        PurchRcptHeader.SETRANGE("No.", "Document No.");
        PurchRcptHeader.FINDFIRST;
        InspLot.COPY(Rec);
        InitInspectionHeader(InspectionType::"Purchase Lot");
        InsertInspectionDataHeader;

        IF NOT CheckVendorQualityApproval(PurchRcptLine, TRUE) THEN
            EXIT;
        "Inspect. Data sheet created" := TRUE;
        MODIFY;
        MESSAGE(Text000);
    end;

    var
        QualitySetup: Record "Quality Control Setup";
        SpecLine: Record "Specification Line";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        InspLot: Record "Inspection Lot";
        ProdOrderLine: Record "Prod. Order Line";
        InspectDataHeader: Record "Inspection Datasheet Header";
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        InspectDataLine: Record "Inspection Datasheet Line";
        InspectionReceipt: Record "Inspection Receipt Header";
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemLedgEntry1: Record "Quality Item Ledger Entry";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        SampPlanCode: Code[20];
        Samplesize: Integer;
        InspectLineNo: Integer;
        Text000: Label 'Inspection Data Sheets Created Successfully.';
        Text001: Label 'Inspection Data sheets already exits for the Lot No. %1.\Do you want to create Inpection Data sheets again?';
        InspectionType: Option Purchase,"Purchase Lot",Rework,"Production Order","Purchase Before Inspection",TransferOrder,SalesCrMemo,ReturnOrder,"Repeated Inspection",Calibration;
        QCSetupRead: Boolean;
        Flag: Boolean;
        Text002: Label 'Do you want to create inspection Data Sheets for Rework Quantity %1?';
        LotMin: Decimal;
        LotMax: Decimal;
        AllowableDefects: Decimal;
        SamplingSize: Decimal;
        Text003: Label 'There is nothing to create Inspection Data Sheets.';
        Text004: Label 'Inspection Data Sheets are Created for %1 Purchase Lines.';
        Item: Record Item;
        ProdOrderLine1: Record "Prod. Order Line";
        InspectionItem: Record Item;
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        ValueEntry: Record "Value Entry";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        ReturnReceiptHeader: Record "Return Receipt Header";
        ReturnReceiptLine: Record "Return Receipt Line";
        ItemVendor: Record "Item Vendor";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        DefectTrackingDetails: Record "Defect Tracking Details";
        DefectTrackingDetails2: Record "Defect Tracking Details";
        "----B2B-----": Integer;
        Calibration: Record Calibration;
        PCBItemNo: Code[20];
        TempILE2: Record "Item Ledger Entry" temporary;
        SerialNo: Code[20];
        ResourceCode: Code[20];
        ProdOrderCompResource: Record "Prod. Order Comp Resource";
        IDSHeaderNo: Code[20];
        ReworkRefNo: Code[20];
        TempILENo: Integer;
        ItemJournalLine2: Record "Item Journal Line";
        "----------": Integer;
        "SerialNo.": Code[20];
        output: Text[30];
        TempSerialNo: Code[20];
        Text005: Label 'Inpsection Data Sheet Quantity should not be greater than Parent Inspection Data Sheet.';
        "--KPK--": Integer;
        NewLotNo: Code[50];
        NewSerialNo: Code[50];
        IdsCount: Integer;
        Text006: Label 'Reclassification done successfully.';
        PostCount: Integer;
        TotalCount: Integer;
        New_Line: Char;
        Body: Text[1000];
        Subject: Text[1000];
        Mail_To: Text[1000];
        Mail_From: Text[1000];
        Attachment: Text[1000];
        //Mail: Codeunit Mail;
        vend: Record Vendor;
        "Mail-Id": Record User;
        NoSeriesMgt: Codeunit 396;


    procedure "CreatePur.LineInspectDataSheet"(PurchRcptHeader2: Record "Purch. Rcpt. Header"; PurchRcptLine2: Record "Purch. Rcpt. Line");
    begin
        PurchRcptHeader.COPY(PurchRcptHeader2);
        PurchRcptLine.COPY(PurchRcptLine2);
        IF NOT CheckVendorQualityApproval(PurchRcptLine, TRUE) THEN
            EXIT;
        IF PurchRcptLine."Item Rcpt. Entry No." = 0 THEN
            CreateLotTrackInspectDataSheet(PurchRcptLine2)
        ELSE BEGIN
            InitInspectionHeader(InspectionType::Purchase);
            InsertInspectionDataHeader;
            ItemLedgEntry.GET(PurchRcptLine."Item Rcpt. Entry No.");
            ItemLedgEntry1.INIT;
            ItemLedgEntry1.TRANSFERFIELDS(ItemLedgEntry);
            ItemLedgEntry1.INSERT;
        END;
        /*
        Body:='';
        New_Line:=10;
        Body+='INWARD ITEM DETAILS :';
        Body+=FORMAT(New_Line);
        Body+=FORMAT(New_Line);
        Subject:=PurchRcptLine.Description+' ITEM INWARDED';
        Body+='Item No.         : '+PurchRcptLine."No.";
        Body+=FORMAT(New_Line);
        Body+='Item Description : '+PurchRcptLine.Description;
        Body+=FORMAT(New_Line);
        PurchLine.SETRANGE(PurchLine."Document No.",PurchRcptLine."Order No.");
        PurchLine.SETRANGE(PurchLine."No.",PurchRcptLine."No.");
        IF PurchLine.FINDFIRST THEN
        Body+='Ordered Quantity : '+FORMAT(PurchLine.Quantity);
        Body+=FORMAT(New_Line);
        Body+='Inward Quantity  : '+FORMAT(PurchRcptLine.Quantity);
        Body+=FORMAT(New_Line);
        Body+='Receipt No.      : '+PurchRcptLine."Document No.";
        Body+=FORMAT(New_Line);
        vend.SETRANGE(vend."No.",PurchRcptLine."Buy-from Vendor No.");
        IF vend.FINDFIRST THEN
        Body+='Vendor Name      : '+vend.Name;
        Body+=FORMAT(New_Line);
        Body+=FORMAT(New_Line);
        Body+='*** Auto Mail Generated from ERP ***';
        Mail_To:='dmadhavi@efftronics.net,erp@efftronics.net';
            "Mail-Id".SETRANGE("Mail-Id"."User ID",USERID);
            IF "Mail-Id".FINDFIRST THEN
            Mail_From:="Mail-Id".MailID;
        IF (Mail_From<>'')AND(Mail_To<>'') THEN
        Mail.NewCDOMessage(Mail_From,Mail_To,Subject,Body,'');   */


        MESSAGE(Text000);

    end;


    procedure CreatePurLineInspectDataSheet(PurchHeader2: Record "Purchase Header"; var PurchLine2: Record "Purchase Line");
    begin
        PurchHeader.COPY(PurchHeader2);
        PurchLine.COPY(PurchLine2);
        InitInspectionHeader(InspectionType::"Purchase Before Inspection");
        InsertInspectionDataHeader;
        PurchLine2."Qty. Sent To Quality" := PurchLine2."Qty. Sent To Quality" + PurchLine2."Qty. Sending To Quality";
        PurchLine2."Qty. Sending To Quality" := 0;
        MESSAGE(Text000);
    end;


    procedure CreateLotTrackInspectDataSheet(PurchRcptLine2: Record "Purch. Rcpt. Line");
    var
        InspectLot: Record "Inspection Lot";
    begin
        IF PurchRcptLine."Quality Before Receipt" THEN
            EXIT;
        PurchRcptLine.COPY(PurchRcptLine2);
        PurchRcptHeader.GET(PurchRcptLine2."Document No.");
        CopyItemTrackingLots(PurchRcptLine2);
        InspectLot.SETRANGE("Document No.", PurchRcptLine2."Document No.");
        InspectLot.SETRANGE("Purch. Line No.", PurchRcptLine2."Line No.");
        IF InspectLot.FINDSET THEN
            REPEAT
                InspLot.COPY(InspectLot);
                InitInspectionHeader(InspectionType::"Purchase Lot");
                InsertInspectionDataHeader;
                InspectLot."Inspect. Data sheet created" := TRUE;
                InspectLot.MODIFY;
            UNTIL InspectLot.NEXT = 0;
    end;


    procedure CreateReworkInspectDataSheets(var InspectReceipt: Record "Inspection Receipt Header");
    begin
        InspectReceipt.TESTFIELD("Qty. To Receive(Rework)");
        InspectReceipt."Last Rework Level" := InspectReceipt."Rework Level" - 1;
        IF InspectReceipt."Last Rework Level" < 0 THEN
            InspectReceipt."Last Rework Level" := 0;
        InspectReceipt."Rework Inspect DS Created" := TRUE;
        InspectReceipt.MODIFY;
        IF InspectReceipt."Source Type" = InspectReceipt."Source Type"::"In Bound" THEN BEGIN
            IF InspectReceipt."Quality Before Receipt" THEN BEGIN
                IF NOT PurchLine.GET(PurchLine."Document Type"::Order, InspectReceipt."Order No.", InspectReceipt."Purch Line No") THEN
                    ERROR('Purchase Order Does not exists');
                PurchHeader.GET(PurchHeader."Document Type"::Order, InspectReceipt."Order No.");
            END ELSE BEGIN
                PurchRcptLine.GET(InspectReceipt."Receipt No.", InspectReceipt."Purch Line No");
                PurchRcptHeader.SETRANGE("No.", InspectReceipt."Receipt No.");
                PurchRcptHeader.FINDFIRST
            END;
        END ELSE BEGIN
            IF InspectReceipt."In Process" THEN
                ProdOrderRoutingLine.GET(ProdOrderRoutingLine.Status::Released, InspectReceipt."Prod. Order No.",
                  InspectReceipt."Routing Reference No.", InspectReceipt."Routing No.", InspectReceipt."Operation No.")
            ELSE
                ProdOrderLine.GET(ProdOrderLine.Status::Released, InspectReceipt."Prod. Order No.", InspectReceipt."Prod. Order Line");
        END;
        InspectionReceipt := InspectReceipt;
        InitInspectionHeader(InspectionType::Rework);
        InspectDataHeader."Rework Level" := InspectReceipt."Rework Level" + 1;
        InsertInspectionDataHeader;
        MESSAGE(Text000);
    end;


    procedure CreateProdLineInspectDataSheet(var ProdOrderLine2: Record "Prod. Order Line");
    begin
        ProdOrderLine2.TESTFIELD("WIP QC Enabled", TRUE);
        ProdOrderLine2.TESTFIELD("Quantity Sending To Quality");
        ProdOrderLine := ProdOrderLine2;
        InitInspectionHeader(InspectionType::"Production Order");
        InsertInspectionDataHeader;
        ProdOrderLine2."Quantity Sent To Quality" := ProdOrderLine2."Quantity Sent To Quality" +
        ProdOrderLine2."Quantity Sending To Quality";
        ProdOrderLine2."Quantity Sending To Quality" := 0;
        MESSAGE(Text000);
    end;


    procedure CreateInprocInspectDataSheet(var ProdOrderRoutingLine2: Record "Prod. Order Routing Line");
    var
        ILE: Record "Item Ledger Entry";
        ItemRec: Record Item;
        ILE2: Record "Item Ledger Entry";
    begin
        IF NOT ProdOrderRoutingLine2."QC Enabled" THEN
            EXIT;
        ProdOrderRoutingLine2.TESTFIELD("Sub Assembly");
        ProdOrderRoutingLine2.TESTFIELD("Spec Id");
        ProdOrderRoutingLine2.TESTFIELD("Qty.To Produce");
        ProdOrderRoutingLine := ProdOrderRoutingLine2;

        //NSS 030907
        ILE.SETCURRENTKEY("Order No.", "Order Line No.", "Prod. Order Comp. Line No.", "Entry Type");
        ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Consumption);
        ILE.SETRANGE("Order No.", ProdOrderRoutingLine."Prod. Order No.");
        ILE.SETRANGE("Order Line No.", ProdOrderRoutingLine."Routing Reference No.");
        IF ILE.FINDSET THEN
            REPEAT
                IF ItemRec.GET(ILE."Item No.") THEN
                    IF ItemRec.PCB = TRUE THEN
                        PCBItemNo := ILE."Item No."
                    ELSE
                        PCBItemNo := '';
            UNTIL (ILE.NEXT = 0) OR (ItemRec.PCB = TRUE);

        ILE2.SETCURRENTKEY("Item No.", "Order No.", "Order Line No.", "Prod. Order Comp. Line No.", "Entry Type");
        IF ItemRec.GET(PCBItemNo) THEN BEGIN
            ILE2.SETRANGE(ILE2."Entry Type", ILE2."Entry Type"::Consumption);
            ILE2.SETRANGE("Order No.", ProdOrderRoutingLine."Prod. Order No.");
            ILE2.SETRANGE("Order Line No.", ProdOrderRoutingLine."Routing Reference No.");
            ILE2.SETRANGE("Item No.", PCBItemNo);
            IF ILE2.FINDSET THEN
                REPEAT
                    TempILE2.INIT;
                    TempILE2.COPY(ILE2);
                    TempILE2.INSERT;
                UNTIL ILE2.NEXT = 0;
        END;
        IF TempILE2.FINDSET THEN
            REPEAT
                SerialNo := '';
                AssignInprocessSerialNo(TempILE2."Serial No.");

                InitInspectionHeader(InspectionType::"Production Order");
                InsertInspectionDataHeader;
            UNTIL TempILE2.NEXT = 0
        ELSE BEGIN
            InitInspectionHeader(InspectionType::"Production Order");
            InsertInspectionDataHeader;
        END;
        //NSS 030907
        ProdOrderRoutingLine2."Quantity Produced" := ProdOrderRoutingLine2."Quantity Produced" + ProdOrderRoutingLine2."Qty.To Produce";
        ProdOrderRoutingLine2."Quantity Sent To Quality" := ProdOrderRoutingLine2."Quantity Produced";
        IF ProdOrderRoutingLine2.Quantity - ProdOrderRoutingLine2."Quantity Produced" > 0 THEN
            ProdOrderRoutingLine2."Qty.To Produce" := ProdOrderRoutingLine2.Quantity - ProdOrderRoutingLine2."Quantity Produced"
        ELSE
            ProdOrderRoutingLine2."Qty.To Produce" := 0;
        ProdOrderRoutingLine2.MODIFY;
        MESSAGE(Text000);
    end;


    procedure InitInspectionHeader(InspectionType: Option Purchase,"Purchase Lot",Rework,"Production Order","Purchase Before Inspection",TransferOrder,SalesCrMemo,ReturnOrder,"Repeated Inspection",Calibration);
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        DeliveryReceipt: Record "Delivery/Receipt Entry";
        ItemJnlLine: Record "Item Journal Line";
    begin
        QCSetup;
        QualitySetup.TESTFIELD("Inspection Datasheet Nos.");

        InspectDataHeader.INIT;
        InspectDataHeader."Created By" := USERID;
        InspectDataHeader."Created Date" := VARIANT2DATE(CURRENTDATETIME);
        InspectDataHeader."Created Time" := TIME;
        InspectDataHeader."Creation DateTime" := CURRENTDATETIME;//B2B1.0
        IF InspectionType = InspectionType::Purchase THEN BEGIN
            InspectDataHeader.Description := PurchRcptHeader."Buy-from Vendor No.";
            InspectDataHeader."Receipt No." := PurchRcptHeader."No.";
            InspectDataHeader."Order No." := PurchRcptHeader."Order No.";
            InspectDataHeader."Posting Date" := PurchRcptHeader."Posting Date";
            InspectDataHeader."Document Date" := PurchRcptHeader."Document Date";
            InspectDataHeader."Vendor No." := PurchRcptHeader."Buy-from Vendor No.";
            InspectDataHeader."Vendor Name" := PurchRcptHeader."Buy-from Vendor Name";
            InspectDataHeader."Vendor Name 2" := PurchRcptHeader."Buy-from Vendor Name 2";
            InspectDataHeader."Vendor Address" := PurchRcptHeader."Buy-from Address";
            InspectDataHeader."Vendot Address 2" := PurchRcptHeader."Buy-from Address 2";
            InspectDataHeader."Contact Person" := PurchRcptHeader."Buy-from Contact";
            InspectDataHeader.Location := PurchRcptLine."Location Code";
            InspectDataHeader."Item Ledger Entry No." := PurchRcptLine."Item Rcpt. Entry No.";
            InspectDataHeader."Source Type" := InspectDataHeader."Source Type"::"In Bound";
            IF Item.GET(PurchRcptLine."No.") THEN;
            InspectDataHeader."External Document No." := PurchRcptHeader."Vendor Shipment No.";
            InspectDataHeader."Unit Of Measure Code" := PurchRcptLine."Unit of Measure Code";
            InspectDataHeader."Spec Version" := PurchRcptLine."Spec Version";
            InspectDataHeader."Qty. per Unit of Measure" := PurchRcptLine."Qty. per Unit of Measure";
            InspectDataHeader."Base Unit Of Measure" := Item."Base Unit of Measure";
            InspectDataHeader."Item Category Code" := Item."Item Category Code";
            InspectDataHeader."Product Group Code" := Item."Product Group Code Cust";
            // Need to Add the Item Master sampling details written by Vishnu Priya on 24-06-2020
            // Need to Add the Item Master sampling details written by Vishnu Priya on 24-06-2020
            InspectDataHeader."Item Sub Group Code" := Item."Item Sub Group Code";
            InspectDataHeader."Item Sub Sub Group Code" := Item."Item Sub Sub Group Code";
            InspectDataHeader."No. of Soldering Points" := Item."No. of Soldering Points";
            InspectDataHeader."No. of Pins" := Item."No. of Pins";
            InspectDataHeader."No. of Opportunities" := Item."No. of Opportunities";
            InspectDataHeader."No.of Fixing Holes" := Item."No.of Fixing Holes";
            InspectDataHeader."Quantity(Base)" := PurchRcptLine."Quantity (Base)";
            IF InspectDataHeader."Item Ledger Entry No." = 0 THEN
                InspectDataHeader."Item Tracking Exists" := TRUE;
            InspectDataHeader."Item No." := PurchRcptLine."No.";
            InspectDataHeader."Item Description" := PurchRcptLine.Description;
            InspectDataHeader.Quantity := PurchRcptLine.Quantity;
            CheckSpecCertified(PurchRcptLine."Spec ID");
            InspectDataHeader."Spec ID" := PurchRcptLine."Spec ID";
            InspectDataHeader."Purch Line No" := PurchRcptLine."Line No.";
        END ELSE
            IF InspectionType = InspectionType::"Purchase Before Inspection" THEN BEGIN
                InspectDataHeader.Description := PurchHeader."Buy-from Vendor No.";
                InspectDataHeader."Receipt No." := '';
                InspectDataHeader."Order No." := PurchHeader."No.";
                InspectDataHeader."Posting Date" := PurchHeader."Posting Date";
                InspectDataHeader."Document Date" := PurchHeader."Document Date";
                InspectDataHeader."Vendor No." := PurchHeader."Buy-from Vendor No.";
                InspectDataHeader."Vendor Name" := PurchHeader."Buy-from Vendor Name";
                InspectDataHeader."Vendor Name 2" := PurchHeader."Buy-from Vendor Name 2";
                InspectDataHeader."Vendor Address" := PurchHeader."Buy-from Address";
                InspectDataHeader."Vendot Address 2" := PurchHeader."Buy-from Address 2";
                InspectDataHeader."Contact Person" := PurchHeader."Buy-from Contact";
                InspectDataHeader.Location := PurchLine."Location Code";
                InspectDataHeader."Source Type" := InspectDataHeader."Source Type"::"In Bound";
                InspectDataHeader."Item No." := PurchLine."No.";
                InspectDataHeader."Item Description" := PurchLine.Description;
                InspectDataHeader."External Document No." := PurchHeader."Vendor Shipment No.";
                InspectDataHeader."Unit Of Measure Code" := PurchLine."Unit of Measure Code";
                InspectDataHeader."Spec Version" := PurchLine."Spec Version";
                InspectDataHeader.Quantity := PurchLine."Qty. Sending To Quality";
                CheckSpecCertified(PurchLine."Spec ID");
                InspectDataHeader."Spec ID" := PurchLine."Spec ID";
                InspectDataHeader."Purch Line No" := PurchLine."Line No.";
                InspectDataHeader."Quality Before Receipt" := TRUE;
                InspectDataHeader."Qty. per Unit of Measure" := PurchRcptLine."Qty. per Unit of Measure";
                InspectDataHeader."Base Unit Of Measure" := Item."Base Unit of Measure";
                InspectDataHeader."Quantity(Base)" := PurchRcptLine."Quantity (Base)";
                QualitySetup.TESTFIELD("Purchase Consignment No.");
                InspectDataHeader."Purchase Consignment No." := NoSeriesMgt.GetNextNo(QualitySetup."Purchase Consignment No.", 0D, TRUE);
                //B2B-ESPL-KNR
            END ELSE
                IF InspectionType = InspectionType::"Repeated Inspection" THEN BEGIN
                    InspectDataHeader.Description := InspectionItem.Description;
                    InspectDataHeader."Source Type" := InspectDataHeader."Source Type"::"Periodic Inspection";
                    InspectDataHeader."Item No." := InspectionItem."No.";
                    InspectDataHeader."Item Description" := InspectionItem.Description;
                    InspectDataHeader."Unit Of Measure Code" := InspectionItem."Base Unit of Measure";
                    InspectDataHeader.Quantity := InspectionItem."Quantity Accepted";
                    CheckSpecCertified(InspectionItem."Spec ID");
                    InspectDataHeader."Spec ID" := InspectionItem."Spec ID";
                END ELSE
                    IF InspectionType = InspectionType::SalesCrMemo THEN BEGIN
                        InspectDataHeader.Description := SalesCrMemoHeader."Sell-to Customer No.";
                        InspectDataHeader."Posted Sales Order No." := SalesCrMemoHeader."No.";
                        InspectDataHeader."Sales Order No." := SalesCrMemoHeader."Pre-Assigned No.";
                        InspectDataHeader."Posting Date" := SalesCrMemoHeader."Posting Date";
                        InspectDataHeader."Document Date" := SalesCrMemoHeader."Document Date";
                        InspectDataHeader."Customer No." := SalesCrMemoHeader."Sell-to Customer No.";
                        InspectDataHeader."Customer Name" := SalesCrMemoHeader."Sell-to Customer Name";
                        InspectDataHeader."Customer Name 2" := SalesCrMemoHeader."Sell-to Customer Name 2";
                        InspectDataHeader."Customer Address" := SalesCrMemoHeader."Sell-to Address";
                        InspectDataHeader."Customer Address2" := SalesCrMemoHeader."Sell-to Address 2";
                        InspectDataHeader.Location := SalesCrMemoHeader."Location Code";
                        ValueEntry.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
                        IF ValueEntry.FINDFIRST THEN
                            InspectDataHeader."Item Ledger Entry No." := ValueEntry."Item Ledger Entry No.";
                        InspectDataHeader."Source Type" := InspectDataHeader."Source Type"::"In Bound";
                        IF Item.GET(SalesCrMemoLine."No.") THEN;
                        InspectDataHeader."External Document No." := SalesCrMemoHeader."External Document No.";
                        InspectDataHeader."Unit Of Measure Code" := SalesCrMemoLine."Unit of Measure Code";
                        InspectDataHeader."Spec Version" := SalesCrMemoLine."Spec Version";
                        InspectDataHeader."Item No." := SalesCrMemoLine."No.";
                        InspectDataHeader."Item Description" := SalesCrMemoLine.Description;
                        InspectDataHeader.Quantity := SalesCrMemoLine.Quantity;
                        CheckSpecCertified(SalesCrMemoLine."Spec ID");
                        InspectDataHeader."Spec ID" := SalesCrMemoLine."Spec ID";
                        InspectDataHeader."Sales Line No" := SalesCrMemoLine."Line No.";
                        InspectDataHeader."Document Type" := InspectDataHeader."Document Type"::"Return Orders";
                    END ELSE
                        IF InspectionType = InspectionType::ReturnOrder THEN BEGIN
                            InspectDataHeader.Description := ReturnReceiptHeader."Sell-to Customer No.";
                            InspectDataHeader."Posted Sales Order No." := ReturnReceiptHeader."No.";
                            InspectDataHeader."Sales Order No." := ReturnReceiptHeader."Return Order No.";
                            InspectDataHeader."Posting Date" := ReturnReceiptHeader."Posting Date";
                            InspectDataHeader."Document Date" := ReturnReceiptHeader."Document Date";
                            InspectDataHeader."Customer No." := ReturnReceiptHeader."Sell-to Customer No.";
                            InspectDataHeader."Customer Name" := ReturnReceiptHeader."Sell-to Customer Name";
                            InspectDataHeader."Customer Name 2" := ReturnReceiptHeader."Sell-to Customer Name 2";
                            InspectDataHeader."Customer Address" := ReturnReceiptHeader."Sell-to Address";
                            InspectDataHeader."Customer Address2" := ReturnReceiptHeader."Sell-to Address 2";
                            InspectDataHeader.Location := ReturnReceiptHeader."Location Code";
                            ItemLedgEntry.SETRANGE("Document No.", ReturnReceiptLine."Document No.");
                            IF ItemLedgEntry.FINDFIRST THEN BEGIN
                                InspectDataHeader."Item Ledger Entry No." := ItemLedgEntry."Entry No.";
                            END;
                            InspectDataHeader."Source Type" := InspectDataHeader."Source Type"::"Sales Returns";
                            IF Item.GET(ReturnReceiptLine."No.") THEN;
                            InspectDataHeader."External Document No." := ReturnReceiptHeader."External Document No.";
                            InspectDataHeader."Unit Of Measure Code" := ReturnReceiptLine."Unit of Measure Code";
                            InspectDataHeader."Item No." := ReturnReceiptLine."No.";
                            InspectDataHeader."Item Description" := ReturnReceiptLine.Description;
                            InspectDataHeader.Quantity := ReturnReceiptLine.Quantity;
                            CheckSpecCertified(ReturnReceiptLine."Spec ID");
                            InspectDataHeader."Spec ID" := ReturnReceiptLine."Spec ID";
                            InspectDataHeader."Sales Line No" := ReturnReceiptLine."Line No.";
                            InspectDataHeader."Document Type" := InspectDataHeader."Document Type"::"Return Orders";
                            //B2B-ESPL
                        END ELSE
                            IF InspectionType = InspectionType::"Production Order" THEN BEGIN
                                //NSS 030907
                                InspectDataHeader."Inprocess Serial No." := SerialNo;
                                //MESSAGE('%1 %2 ids',InspectDataHeader."Inprocess Serial No.",SerialNo);
                                //NSS 030907
                                InspectDataHeader."Source Type" := InspectDataHeader."Source Type"::WIP;
                                InspectDataHeader."Posting Date" := WORKDATE;
                                InspectDataHeader."Document Date" := WORKDATE;
                                IF ProdOrderLine."Item No." <> '' THEN BEGIN
                                    InspectDataHeader."Item No." := ProdOrderLine."Item No.";
                                    InspectDataHeader."Item Description" := ProdOrderLine.Description;
                                    //Hot Fix 1.0
                                    InspectDataHeader."Unit Of Measure Code" := ProdOrderLine."Unit of Measure Code";
                                    InspectDataHeader."Spec Version" := ProdOrderLine."Spec Version Code";
                                    //Hot Fix 1.0
                                    InspectDataHeader.Quantity := ProdOrderLine."Quantity Sending To Quality";
                                    CheckSpecCertified(ProdOrderLine."WIP Spec Id");
                                    InspectDataHeader."Spec ID" := ProdOrderLine."WIP Spec Id";
                                    InspectDataHeader."Prod. Order No." := ProdOrderLine."Prod. Order No.";
                                    InspectDataHeader."Prod. Order Line" := ProdOrderLine."Line No.";
                                    //B2Bsankar
                                    InspectDataHeader."Prod. Description" := ProdOrderLine.Description;
                                    //b2bsankar
                                    InspectDataHeader."Routing No." := ProdOrderLine."Routing No.";
                                    InspectDataHeader."Routing Reference No." := ProdOrderLine."Routing Reference No.";
                                    InspectDataHeader.Location := ProdOrderLine."Location Code";
                                    //Hot fix 1.0
                                    InspectDataHeader."Qty. per Unit of Measure" := PurchRcptLine."Qty. per Unit of Measure";
                                    InspectDataHeader."Base Unit Of Measure" := Item."Base Unit of Measure";
                                    InspectDataHeader."Quantity(Base)" := PurchRcptLine."Quantity (Base)";

                                    //Hot fix 1.0
                                END ELSE BEGIN
                                    InspectDataHeader."Sub Assembly Code" := ProdOrderRoutingLine."Sub Assembly";
                                    InspectDataHeader."Sub Assembly Description" := ProdOrderRoutingLine."Sub Assembly Description";
                                    //Hot Fix 1.0
                                    InspectDataHeader."Unit Of Measure Code" := ProdOrderRoutingLine."Sub Assembly Unit Of Meas.Code";
                                    //Hot Fix 1.0
                                    InspectDataHeader.Quantity := ProdOrderRoutingLine."Qty.To Produce";
                                    InspectDataHeader."QAS/MPR" := ProdOrderRoutingLine."QAS/MPR";//b2b
                                    InspectDataHeader."Prod. Order Line" := ProdOrderRoutingLine."Routing Reference No.";
                                    CheckSpecCertified(ProdOrderRoutingLine."Spec Id");
                                    InspectDataHeader."Spec ID" := ProdOrderRoutingLine."Spec Id";
                                    InspectDataHeader."Prod. Order No." := ProdOrderRoutingLine."Prod. Order No.";
                                    //B2B sankar
                                    InspectDataHeader."Prod. Description" := ProdOrderRoutingLine."Item Description";
                                    //B2B sankar
                                    //QCB2B1.2
                                    ProdOrderLine1.INIT;
                                    ProdOrderLine1.SETRANGE("Prod. Order No.", InspectDataHeader."Prod. Order No.");
                                    IF ProdOrderLine1.FINDFIRST THEN BEGIN
                                        InspectDataHeader."Item No." := ProdOrderLine1."Item No.";
                                        InspectDataHeader."Item Description" := ProdOrderLine1.Description;
                                        InspectDataHeader.Location := ProdOrderLine1."Location Code";
                                    END;
                                    //QCB2B1.2
                                    //Comments removed on 031107
                                    //B2B SSR Start

                                    ItemJnlLine.RESET;
                                    ItemJnlLine.SETRANGE("Order No.", ProdOrderRoutingLine."Prod. Order No.");
                                    ItemJnlLine.SETRANGE("Order Line No.", ProdOrderRoutingLine."Routing Reference No.");
                                    ItemJnlLine.SETRANGE("Operation No.", ProdOrderRoutingLine."Operation No.");
                                    IF ItemJnlLine.FINDFIRST THEN BEGIN
                                        InspectDataHeader.Resource := ItemJnlLine."No.";
                                        InspectDataHeader."OutPut Jr Serial No." := ItemJnlLine."Output Jr Serial No.";
                                    END;
                                    InspectDataHeader.Resource := ItemJournalLine2."No.";
                                    InspectDataHeader."OutPut Jr Serial No." := ItemJournalLine2."Output Jr Serial No.";
                                    InspectDataHeader."Finished Product Sr No" := ItemJournalLine2."Finished Product Sr No";
                                    //Commented by sankar
                                    //Comments removed on 031107
                                    /*
                                    //NSS 030907
                                    //ProdOrderCompResource.SETRANGE(ProdOrderCompResource.Status,Status);
                                    ProdOrderCompResource.SETRANGE("Prod. Order No.",ProdOrderRoutingLine."Prod. Order No.");
                                    ProdOrderCompResource.SETRANGE("Prod. Order Line No.",ProdOrderRoutingLine."Routing Reference No.");
                                    ProdOrderCompResource.SETRANGE("Serial No.",SerialNo);
                                    IF ProdOrderCompResource.FINDFIRST THEN BEGIN
                                      ProdOrderCompResource.TESTFIELD(Resource);
                                      //InspectDataHeader.Resource := ProdOrderCompResource.Resource;commented by sankar
                                      ProdOrderCompResource."IDS Generated" := TRUE;
                                      ProdOrderCompResource.MODIFY;
                                    END;
                                    //NSS 030907 */
                                    // InspectDataHeader.Resource := ProdOrderRoutingLine."No.";
                                    //B2B SSR End
                                    InspectDataHeader."Routing No." := ProdOrderRoutingLine."Routing No.";
                                    InspectDataHeader."Routing Reference No." := ProdOrderRoutingLine."Routing Reference No.";
                                    InspectDataHeader."Operation No." := ProdOrderRoutingLine."Operation No.";
                                    InspectDataHeader."Operation Description" := ProdOrderRoutingLine."Operation Description";
                                    InspectDataHeader."Prod. Description" := ProdOrderRoutingLine."Item Description";
                                    InspectDataHeader."In Process" := TRUE;
                                END;
                                QualitySetup.TESTFIELD("Production Batch No.");
                                InspectDataHeader."Production Batch No." := NoSeriesMgt.GetNextNo(QualitySetup."Production Batch No.", 0D, TRUE);
                            END ELSE
                                IF InspectionType = InspectionType::"Purchase Lot" THEN BEGIN
                                    InspectDataHeader.Description := PurchRcptHeader."Buy-from Vendor No.";
                                    InspectDataHeader."Receipt No." := PurchRcptHeader."No.";
                                    InspectDataHeader."Order No." := PurchRcptHeader."Order No.";
                                    InspectDataHeader."Posting Date" := PurchRcptHeader."Posting Date";
                                    InspectDataHeader."Document Date" := PurchRcptHeader."Document Date";
                                    InspectDataHeader."Vendor No." := PurchRcptHeader."Buy-from Vendor No.";
                                    InspectDataHeader."Vendor Name" := PurchRcptHeader."Buy-from Vendor Name";
                                    InspectDataHeader."Vendor Name 2" := PurchRcptHeader."Buy-from Vendor Name 2";
                                    InspectDataHeader."Vendor Address" := PurchRcptHeader."Buy-from Address";
                                    InspectDataHeader."Vendot Address 2" := PurchRcptHeader."Buy-from Address 2";
                                    InspectDataHeader."Contact Person" := PurchRcptHeader."Buy-from Contact";
                                    InspectDataHeader.Location := PurchRcptLine."Location Code";
                                    InspectDataHeader.Make := PurchRcptLine.Make;
                                    InspectDataHeader.Sample := PurchRcptLine.Sample;
                                    InspectDataHeader."Item Ledger Entry No." := PurchRcptLine."Item Rcpt. Entry No.";
                                    InspectDataHeader."Source Type" := InspectDataHeader."Source Type"::"In Bound";
                                    //QCP1.0
                                    InspectDataHeader.VALIDATE("Item Ledger Entry No.", TempILENo);
                                    //QCP1.0
                                    //Hot fix
                                    InspectDataHeader."External Document No." := PurchRcptHeader."Vendor Shipment No.";
                                    InspectDataHeader."Unit Of Measure Code" := PurchRcptLine."Unit of Measure Code";
                                    InspectDataHeader."Spec Version" := PurchRcptLine."Spec Version";
                                    //Hot fix
                                    InspectDataHeader."Item Tracking Exists" := TRUE;
                                    InspectDataHeader."Quality Before Receipt" := FALSE;

                                    InspectDataHeader."Item No." := InspLot."Item No.";
                                    InspectDataHeader."Item Description" := InspLot."Item Description";
                                    InspectDataHeader.Quantity := InspLot.Quantity;
                                    CheckSpecCertified(InspLot."Spec Id");
                                    InspectDataHeader."Spec ID" := InspLot."Spec Id";
                                    InspectDataHeader."Purch Line No" := InspLot."Purch. Line No.";
                                    InspectDataHeader."Lot No." := InspLot."Lot No.";
                                    //Hot fix 1.0
                                    InspectDataHeader."Qty. per Unit of Measure" := PurchRcptLine."Qty. per Unit of Measure";
                                    InspectDataHeader."Base Unit Of Measure" := Item."Base Unit of Measure";
                                    InspectDataHeader."Quantity(Base)" := PurchRcptLine."Quantity (Base)";
                                    //Hot fix 1.0
                                END ELSE
                                    IF InspectionType = InspectionType::Rework THEN BEGIN
                                        InspectDataHeader.Description := InspectionReceipt."Vendor No.";
                                        InspectDataHeader."Receipt No." := InspectionReceipt."Receipt No.";
                                        InspectDataHeader."Order No." := InspectionReceipt."Order No.";
                                        InspectDataHeader."Purch Line No" := InspectionReceipt."Purch Line No";
                                        InspectDataHeader."Lot No." := InspectionReceipt."Lot No.";
                                        InspectDataHeader."Posting Date" := InspectionReceipt."Posting Date";
                                        InspectDataHeader."Document Date" := InspectionReceipt."Document Date";
                                        InspectDataHeader."Vendor No." := InspectionReceipt."Vendor No.";
                                        InspectDataHeader."Vendor Name" := InspectionReceipt."Vendor Name";
                                        InspectDataHeader."Vendor Name 2" := InspectionReceipt."Vendor Name 2";
                                        InspectDataHeader."Vendor Address" := InspectionReceipt.Address;
                                        InspectDataHeader."Vendot Address 2" := InspectionReceipt."Address 2";
                                        InspectDataHeader."Contact Person" := InspectionReceipt."Contact Person";
                                        //to get serial no
                                        IF InspectionReceipt."Item Tracking Exists" THEN
                                            IF DeliveryReceipt.GET(InspectionReceipt."Rework Reference Document No.") THEN
                                                InspectDataHeader."Serial No." := DeliveryReceipt."Serial No.";
                                        InspectDataHeader."Item Tracking Exists" := InspectionReceipt."Item Tracking Exists";
                                        InspectDataHeader."DC Inbound Ledger Entry" := InspectionReceipt."DC Inbound Ledger Entry.";
                                        //to get serial no
                                        //added
                                        InspectDataHeader."Item No." := InspectionReceipt."Item No.";
                                        InspectDataHeader."Item Description" := InspectionReceipt."Item Description";
                                        InspectDataHeader."External Document No." := InspectionReceipt."External Document No.";
                                        InspectDataHeader."Unit Of Measure Code" := InspectionReceipt."Unit Of Measure Code";
                                        InspectDataHeader."Spec Version" := InspectionReceipt."Spec Version";
                                        InspectDataHeader.Quantity := InspectionReceipt."Qty. To Receive(Rework)";
                                        CheckSpecCertified(InspectionReceipt."Spec ID");
                                        InspectDataHeader."Spec ID" := InspectionReceipt."Spec ID";
                                        InspectDataHeader."Rework Level" := InspectionReceipt."Last Rework Level";
                                        InspectDataHeader."Rework Reference No." := InspectionReceipt."No.";
                                        ReworkRefNo := InspectionReceipt."No.";//drk
                                        InspectDataHeader.Location := InspectionReceipt."Location Code";
                                        InspectDataHeader."Item Ledger Entry No." := PurchRcptLine."Item Rcpt. Entry No.";
                                        InspectDataHeader."Quality Before Receipt" := InspectionReceipt."Quality Before Receipt";
                                        InspectDataHeader."Source Type" := InspectionReceipt."Source Type";
                                        //b2b EFF
                                        InspectDataHeader."Reason for Pending" := InspectionReceipt."Reason for Pending";
                                        //b2b EFF
                                        IF InspectionReceipt."Source Type" = InspectionReceipt."Source Type"::"In Bound" THEN
                                            InspectDataHeader."Purchase Consignment No." := NoSeriesMgt.GetNextNo(QualitySetup."Purchase Consignment No.", 0D, TRUE)
                                        ELSE BEGIN
                                            QualitySetup.TESTFIELD("Production Batch No.");
                                            InspectDataHeader."Production Batch No." := NoSeriesMgt.GetNextNo(QualitySetup."Production Batch No.", 0D, TRUE);
                                        END;
                                        InspectDataHeader."Prod. Order No." := InspectionReceipt."Prod. Order No.";
                                        //b2b EFF
                                        InspectDataHeader."Prod. Description" := InspectionReceipt."Prod. Description";
                                        //b2b EFF
                                        InspectDataHeader."Prod. Order Line" := InspectionReceipt."Prod. Order Line";
                                        InspectDataHeader."Routing Reference No." := InspectionReceipt."Routing Reference No.";
                                        InspectDataHeader."Routing No." := InspectionReceipt."Routing No.";
                                        InspectDataHeader."Operation No." := InspectionReceipt."Operation No.";
                                        InspectDataHeader."Operation Description" := InspectionReceipt."Operation Description";
                                        InspectDataHeader."Sub Assembly Code" := InspectionReceipt."Sub Assembly Code";
                                        InspectDataHeader."Sub Assembly Description" := InspectionReceipt."Sub Assembly Description";
                                        InspectDataHeader."In Process" := InspectionReceipt."In Process";
                                        InspectDataHeader."Production Batch No." := InspectionReceipt."Production Batch No.";
                                        //RQC1.0
                                        InspectDataHeader."Rework Posted" := InspectionReceipt."Rework Posted";
                                        InspectDataHeader."Rework User" := InspectionReceipt."Rework User";
                                        InspectDataHeader."OutPut Jr Serial No." := InspectionReceipt."OutPut Jr Serial No.";
                                        InspectDataHeader."Finished Product Sr No" := InspectionReceipt."Finished Product Sr No";
                                        //RQC1.0
                                        //Bhavani
                                    END ELSE
                                        IF InspectionType = InspectionType::Calibration THEN BEGIN
                                            InspectDataHeader.Description := Calibration.Description;
                                            InspectDataHeader."Posting Date" := WORKDATE;
                                            IF Calibration."Calibration Party" = Calibration."Calibration Party"::Calibrated THEN BEGIN
                                                InspectDataHeader."Calibration Party" := Calibration."Calibration Party";
                                                InspectDataHeader."Vendor No." := Calibration."Service Agent";
                                                InspectDataHeader."Vendor Name" := Calibration.Name;
                                                InspectDataHeader."Vendor Address" := Calibration."S Address1";
                                                InspectDataHeader."Vendot Address 2" := Calibration."S Address2";
                                                InspectDataHeader."Contact Person" := Calibration."S Contact Person";
                                            END ELSE
                                                IF Calibration."Calibration Party" = Calibration."Calibration Party"::"External Calibration" THEN BEGIN
                                                    InspectDataHeader."Calibration Party" := Calibration."Calibration Party";
                                                    InspectDataHeader.Resource := Calibration.Resource;
                                                    InspectDataHeader."Std. Reference" := Calibration."Std. Reference";
                                                    InspectDataHeader.Department := Calibration.Department;
                                                END;
                                            InspectDataHeader.Location := Calibration.Location;
                                            InspectDataHeader."Source Type" := InspectDataHeader."Source Type"::Calibration;
                                            InspectDataHeader."Unit Of Measure Code" := Calibration."Unit Of Measure";
                                            //InspectDataHeader."Spec Version" := PurchRcptLine."Spec Version";
                                            InspectDataHeader."Item No." := Calibration."Equipment No";
                                            InspectDataHeader."Item Description" := Calibration.Description;
                                            InspectDataHeader.Quantity := 1;
                                            CheckSpecCertified(Calibration."Spec Id");
                                            InspectDataHeader."Spec ID" := Calibration."Spec Id";
                                            InspectDataHeader."Eqpt. Serial No." := Calibration."Eqpt. Serial No.";
                                            InspectDataHeader."Least Count" := Calibration."Least Count";
                                            InspectDataHeader."Measuring Range" := Calibration."Measuring Range";
                                            InspectDataHeader."Model No." := Calibration."Model No.";
                                            InspectDataHeader.Manufacturer := Calibration.Manufacturer;
                                            InspectDataHeader."MFG. Serial No." := Calibration."MFG. Serial No.";
                                        END;

    end;


    procedure InsertInspectionDataHeader();
    var
        InspectGroup: Code[20];
        QcComments: Record "Quality Comment Line";
        PostComments: Record "Quality Comment Line";
        Attach: Record Attachments;
        PostAttach: Record Attachments;
        InspectionDatasheetLines: Record "Inspection Datasheet Line";
        InspectionDatasheetHead: Record "Inspection Datasheet Header";
        InspectionReceiptLine: Record "Inspection Receipt Line";
    begin
        SpecLine.RESET;
        SpecLine.SETRANGE("Spec ID", InspectDataHeader."Spec ID");
        //Hot Fix 1.0
        SpecLine.SETRANGE("Version Code", InspectDataHeader."Spec Version");
        //Hot Fix 1.0
        SpecLine.SETCURRENTKEY("Inspection Group Code");
        IF SpecLine.FINDFIRST THEN BEGIN
            InspectGroup := SpecLine."Inspection Group Code";
            SpecLine.MARK(TRUE);
        END;
        IF SpecLine.NEXT <> 0 THEN
            REPEAT
                IF InspectGroup <> SpecLine."Inspection Group Code" THEN BEGIN
                    InspectGroup := SpecLine."Inspection Group Code";
                    SpecLine.MARK(TRUE);
                END;
            UNTIL SpecLine.NEXT = 0;
        SpecLine.MARKEDONLY(TRUE);

        IF SpecLine.FINDSET THEN
            REPEAT
                InspectDataHeader."No." := NoSeriesMgt.GetNextNo(QualitySetup."Inspection Datasheet Nos.", 0D, TRUE);
                //DRK <<
                IDSHeaderNo := InspectDataHeader."No.";
                //IF InspectionDatasheetHead.FINDLAST THEN
                //  ReworkRefNo := InspectionDatasheetHead."Rework Reference No.";
                //DRK >>
                InspectDataHeader."Inspection Group Code" := SpecLine."Inspection Group Code";
                //b2b EFF
                IF Item.GET(InspectDataHeader."Item No.") THEN BEGIN
                    InspectDataHeader."Item Category Code" := Item."Item Category Code";
                    InspectDataHeader."Product Group Code" := Item."Product Group Code Cust";
                    // Need to Add the Item Master sampling details written by Vishnu Priya on 24-06-2020
                    // Need to Add the Item Master sampling details written by Vishnu Priya on 24-06-2020
                    InspectDataHeader."Item Sub Group Code" := Item."Item Sub Group Code";
                    InspectDataHeader."Item Sub Sub Group Code" := Item."Item Sub Sub Group Code";
                    InspectDataHeader."No. of Soldering Points" := Item."No. of Soldering Points";
                    InspectDataHeader."No. of Pins" := Item."No. of Pins";
                    InspectDataHeader."No. of Opportunities" := Item."No. of Opportunities";
                    InspectDataHeader."No.of Fixing Holes" := Item."No.of Fixing Holes";
                    //mnraju for LED Details
                    InspectDataHeader."LED Part No." := Item."Part Number";
                    InspectDataHeader."LED Make" := Item.Make;
                    InspectDataHeader."LED Type" := FORMAT(Item."Type of Solder");
                    InspectDataHeader.Color := Item."Item Sub Sub Group Code";
                    //mnraju for LED Details

                END;
                //b2b EFF

                // InsertInspectionDataLine(SpecLine."Inspection Group Code");
                InsertInspectionDataLine(SpecLine."Inspection Group Code", InspectionReceipt."Ids Reference No.");
                IF Flag THEN
                    InspectDataHeader.INSERT(TRUE);
                //DRK <<
                InspectionDatasheetLines.RESET;
                InspectionDatasheetLines.SETRANGE(InspectionDatasheetLines."Document No.", IDSHeaderNo);
                IF InspectionDatasheetLines.FINDSET THEN
                    REPEAT
                        InspectionReceiptLine.RESET;
                        InspectionReceiptLine.SETRANGE("Document No.", ReworkRefNo);
                        InspectionReceiptLine.SETRANGE("Character Code", InspectionDatasheetLines."Character Code");
                        InspectionReceiptLine.SETRANGE("Sampling Plan Code", InspectionDatasheetLines."Sampling Plan Code");
                        IF InspectionReceiptLine.FINDSET THEN
                            REPEAT
                                InspectionDatasheetLines."Rework Reason Code" := InspectionReceiptLine."Reason Code";
                                InspectionDatasheetLines.MODIFY;
                            UNTIL InspectionReceiptLine.NEXT = 0;
                    UNTIL InspectionDatasheetLines.NEXT = 0;
            //DRK >>
            UNTIL SpecLine.NEXT = 0;

        //b2b EFF
        QcComments.RESET;
        QcComments.SETRANGE(Type, QcComments.Type::"Inspection Receipt");
        QcComments.SETRANGE("No.", InspectionReceipt."No.");
        IF QcComments.FINDSET THEN BEGIN
            REPEAT
                PostComments.INIT;
                PostComments.TRANSFERFIELDS(QcComments);
                PostComments.Type := PostComments.Type::"Inspection Data Sheets";
                PostComments."No." := InspectDataHeader."No.";
                PostComments.INSERT;
            UNTIL QcComments.NEXT = 0;
        END;
        //b2b EFF
        IF InspectionReceipt."No." <> '' THEN    //sundar as problem With QC attachments with null document no
        BEGIN
            Attach.RESET;
            Attach.SETRANGE("Table ID", DATABASE::"Inspection Receipt Header");
            //Attach.SETRANGE("Document No.",InspectionReceipt."Ids Reference No.");
            Attach.SETRANGE("Document No.", InspectionReceipt."No.");
            IF Attach.FINDSET THEN
                REPEAT
                    Attach.CALCFIELDS(Attach.FileAttachment);
                    PostAttach.TRANSFERFIELDS(Attach);
                    PostAttach."Table ID" := DATABASE::"Inspection Datasheet Header";
                    PostAttach."Document No." := InspectDataHeader."No.";
                    PostAttach.INSERT;
                UNTIL Attach.NEXT = 0;
        END;
    end;


    procedure InsertInspectionDataLine(InspectCode: Code[20]; "IdsRefNo.": Code[20]);
    var
        SpecLine1: Record "Specification Line";
        CharGroupNo: Integer;
        PostedIDS: Record "Posted Inspect DatasheetHeader";
        PostedIDSLine: Record "Posted Inspect Datasheet Line";
    begin
        /*
        Flag :=FALSE;
        IF InspectDataHeader."Rework Reference No." = '' THEN BEGIN //GGB
          SpecLine1.RESET;
          SpecLine1.SETRANGE("Spec ID",InspectDataHeader."Spec ID");
          SpecLine1.SETCURRENTKEY("Inspection Group Code");
          SpecLine1.SETRANGE("Inspection Group Code",InspectCode);
          InspectLineNo := 1;
          CharGroupNo := 0;
          Samplesize := 0;
          IF SpecLine1.FINDSET THEN BEGIN
            REPEAT
              IF SpecLine1."Character Type" = SpecLine1."Character Type" :: Standard THEN
                Samplesize := Samplesize + FindSamplingSize(InspectDataHeader,SpecLine1)
              ELSE
                Samplesize := Samplesize + 1;
              CharGroupNo := CharGroupNo + 1;
        
              WHILE (InspectLineNo <= Samplesize) DO BEGIN
                InspectDataLine.INIT;
                //Rasool
        
                InspectDataLine."Document No." := InspectDataHeader."No.";
                InspectDataLine."Line No." := InspectLineNo;
                InspectDataLine."Character Type" := SpecLine1."Character Type";
                InspectDataLine.Indentation := SpecLine1.Indentation;
                InspectDataLine."Character Code" := SpecLine1."Character Code";
                InspectDataLine.Description := SpecLine1.Description;
                InspectDataLine."Sampling Plan Code" := SpecLine1."Sampling Code";
                InspectDataLine.Qualitative := SpecLine1.Qualitative;
                InspectDataLine."Item No." := SpecLine1."Item No.";// AR espl
                ItemLedgEntry.RESET;
                ItemLedgEntry.SETCURRENTKEY("Item No.","Prod. Order No.","Entry Type");
                ItemLedgEntry.SETRANGE("Entry Type",Consumption); //AR Espl 1.0
                ItemLedgEntry.SETRANGE("Item No.",InspectDataLine."Item No.");
                ITEMLEDGERENTRY.SETRANGE("Prod. Order No.",InspectDataHeader."Prod. Order No.");
                IF ItemLedgEntry.FINDFIRST THEN
                    InspectDataLine."Serial No." := ItemLedgEntry."Serial No.";
        
        
                //B2B-Knr For Efftronics Quality
                ItemVendor.SETRANGE("Vendor No.",InspectDataHeader."Vendor No.");
                ItemVendor.SETRANGE("Item No.",InspectDataHeader."Item No.");
                IF ItemVendor.FINDFIRST THEN
                  InspectDataLine."Sampling Plan Code" := ItemVendor."Sampling Plan Code"
                ELSE
                  InspectDataLine."Sampling Plan Code" := SpecLine1."Sampling Code";
                //B2B-Knr
                InspectDataLine."Normal Value (Num)" := SpecLine1."Normal Value (Num)";
                InspectDataLine."Min. Value (Num)" := SpecLine1."Min. Value (Num)";
                InspectDataLine."Max. Value (Num)" := SpecLine1."Max. Value (Num)";
                InspectDataLine."Normal Value (Text)" := SpecLine1."Normal Value (Char)";
                InspectDataLine."Min. Value (Text)" := SpecLine1."Min. Value (Char)";
                InspectDataLine."Max. Value (Text)" := SpecLine1."Max. Value (Char)";
                InspectDataLine."Unit Of Measure Code" := SpecLine1."Unit Of Measure Code";
                //B2B
                InspectDataLine."Bench Mark Time(In Min.)" := SpecLine1."Inspection Time(In Min.)";
                //B2B
                InspectDataLine."Character Group No." := CharGroupNo;
                InspectDataLine."Lot Size - Min" := LotMin;
                InspectDataLine."Lot Size - Max" := LotMax;
                InspectDataLine."Sampling Size" :=  SamplingSize;
                InspectDataLine."Allowable Defects - Min" := 0;
                InspectDataLine."Allowable Defects - Max" := AllowableDefects;
                //b2b EFF
                DefectTrackingDetails.RESET;
                DefectTrackingDetails.SETRANGE("IDS No.","IdsRefNo.");
                DefectTrackingDetails.SETRANGE("IDS Line No.",InspectDataLine."Line No.");
                IF DefectTrackingDetails.FINDSET THEN
                  REPEAT
                    DefectTrackingDetails2.INIT;
                    DefectTrackingDetails2.TRANSFERFIELDS( DefectTrackingDetails);
                    DefectTrackingDetails2."IDS No." := InspectDataHeader."No.";
                    DefectTrackingDetails2."IDS Line No." := InspectDataLine."Line No.";
                    DefectTrackingDetails2."Line No." := DefectTrackingDetails."Line No.";
                    DefectTrackingDetails2.Remarks := DefectTrackingDetails.Remarks;
                    DefectTrackingDetails2."Disposition Actions" := DefectTrackingDetails."Disposition Actions";
                    DefectTrackingDetails2.INSERT;
                  UNTIL DefectTrackingDetails.NEXT = 0;
                //b2b EFF
                InspectDataLine.INSERT;
                InspectLineNo := InspectLineNo + 1;
                Flag :=TRUE
              END;
            UNTIL SpecLine1.NEXT =0;
          END;
        //GGB
        END ELSE BEGIN
          IF PostedIDS.GET("IdsRefNo.") THEN BEGIN
            PostedIDSLine.SETRANGE("Document No.",PostedIDS."No.");
              IF PostedIDSLine.FINDSET THEN
                REPEAT
                  InspectDataLine.INIT;
                  InspectDataLine.TRANSFERFIELDS( PostedIDSLine);
                  InspectDataLine."Document No." := InspectDataHeader."No.";
                  InspectDataLine."Line No." := InspectLineNo;
                  InspectDataLine.INSERT;
                  InspectLineNo := InspectLineNo + 1;
                  Flag :=TRUE
                UNTIL PostedIDSLine.NEXT = 0;
          END;
              //b2b EFF
              DefectTrackingDetails.RESET;
              DefectTrackingDetails.SETRANGE("IDS No.","IdsRefNo.");
              DefectTrackingDetails.SETRANGE("IDS Line No.",InspectDataLine."Line No.");
              IF DefectTrackingDetails.FINDSET THEN
                REPEAT
                  DefectTrackingDetails2.INIT;
                  DefectTrackingDetails2.TRANSFERFIELDS( DefectTrackingDetails);
                  DefectTrackingDetails2."IDS No." := InspectDataHeader."No.";
                  DefectTrackingDetails2."IDS Line No." := InspectDataLine."Line No.";
                  DefectTrackingDetails2."Line No." := DefectTrackingDetails."Line No.";
                  DefectTrackingDetails2.INSERT;
                 UNTIL DefectTrackingDetails.NEXT = 0;
             //b2b EFF
        
        END;
        //GGB
        //QCP1.0
        */

        Flag := FALSE;
        SpecLine1.RESET;
        SpecLine1.SETRANGE("Spec ID", InspectDataHeader."Spec ID");
        SpecLine1.SETCURRENTKEY("Inspection Group Code");
        SpecLine1.SETRANGE("Inspection Group Code", InspectCode);
        InspectLineNo := 1;
        CharGroupNo := 0;
        Samplesize := 0;
        IF SpecLine1.FINDSET THEN BEGIN
            REPEAT
                IF SpecLine1."Character Type" = SpecLine1."Character Type"::Standard THEN
                    Samplesize := Samplesize + FindSamplingSize(InspectDataHeader, SpecLine1)
                ELSE
                    Samplesize := Samplesize + 1;
                CharGroupNo := CharGroupNo + 1;
                WHILE (InspectLineNo <= Samplesize) DO BEGIN
                    InspectDataLine.INIT;
                    //Rasool
                    InspectDataLine."Document No." := InspectDataHeader."No.";
                    InspectDataLine."Line No." := InspectLineNo;
                    InspectDataLine."Character Type" := SpecLine1."Character Type";
                    InspectDataLine.Indentation := SpecLine1.Indentation;
                    InspectDataLine."Character Code" := SpecLine1."Character Code";
                    InspectDataLine.Description := SpecLine1.Description;
                    InspectDataLine."Sampling Plan Code" := SpecLine1."Sampling Code";
                    InspectDataLine.Qualitative := SpecLine1.Qualitative;
                    //B2B-Knr For Efftronics Quality
                    ItemVendor.SETRANGE("Vendor No.", InspectDataHeader."Vendor No.");
                    ItemVendor.SETRANGE("Item No.", InspectDataHeader."Item No.");
                    IF ItemVendor.FINDFIRST THEN
                        InspectDataLine."Sampling Plan Code" := ItemVendor."Sampling Plan Code"
                    ELSE
                        InspectDataLine."Sampling Plan Code" := SpecLine1."Sampling Code";
                    //B2B-Knr
                    InspectDataLine."Normal Value (Num)" := SpecLine1."Normal Value (Num)";
                    InspectDataLine."Min. Value (Num)" := SpecLine1."Min. Value (Num)";
                    InspectDataLine."Max. Value (Num)" := SpecLine1."Max. Value (Num)";
                    InspectDataLine."Normal Value (Text)" := SpecLine1."Normal Value (Char)";
                    InspectDataLine."Min. Value (Text)" := SpecLine1."Min. Value (Char)";
                    InspectDataLine."Max. Value (Text)" := SpecLine1."Max. Value (Char)";
                    InspectDataLine."Unit Of Measure Code" := SpecLine1."Unit Of Measure Code";
                    //>>AR 280508
                    InspectDataLine."Item No." := SpecLine1."Item No.";
                    IF InspectDataLine."Item No." <> '' THEN
                        InspectDataLine."Serial No." := GetSerialNum(InspectDataHeader."Prod. Order No.", SpecLine1."Item No.");
                    //<<AR
                    //B2B
                    InspectDataLine."Bench Mark Time(In Min.)" := SpecLine1."Inspection Time(In Min.)";
                    //B2B
                    InspectDataLine."Character Group No." := CharGroupNo;
                    InspectDataLine."Lot Size - Min" := LotMin;
                    InspectDataLine."Lot Size - Max" := LotMax;
                    InspectDataLine."Sampling Size" := SamplingSize;
                    InspectDataLine."Allowable Defects - Min" := 0;
                    InspectDataLine."Allowable Defects - Max" := AllowableDefects;
                    //b2b EFF
                    DefectTrackingDetails.RESET;
                    DefectTrackingDetails.SETRANGE("IDS No.", "IdsRefNo.");
                    DefectTrackingDetails.SETRANGE("IDS Line No.", InspectDataLine."Line No.");
                    IF DefectTrackingDetails.FINDSET THEN
                        REPEAT
                            DefectTrackingDetails2.INIT;
                            DefectTrackingDetails2.TRANSFERFIELDS(DefectTrackingDetails);
                            DefectTrackingDetails2."IDS No." := InspectDataHeader."No.";
                            DefectTrackingDetails2."IDS Line No." := InspectDataLine."Line No.";
                            DefectTrackingDetails2."Line No." := DefectTrackingDetails."Line No.";
                            DefectTrackingDetails2.Remarks := DefectTrackingDetails.Remarks;
                            DefectTrackingDetails2."Disposition Actions" := DefectTrackingDetails."Disposition Actions";
                            DefectTrackingDetails2.INSERT;
                        UNTIL DefectTrackingDetails.NEXT = 0;
                    //b2b EFF
                    InspectDataLine.INSERT;
                    InspectLineNo := InspectLineNo + 1;
                    Flag := TRUE
                END;
            UNTIL SpecLine1.NEXT = 0;
        END;

    end;


    procedure CheckVendorQualityApproval(PurchRcptLine: Record "Purch. Rcpt. Line"; LotNo: Boolean): Boolean;
    var
        VendorItemQA: Record "Vendor Item Quality Approval";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PostingDate: Date;
    begin
        VendorItemQA.SETRANGE("Vendor No.", PurchRcptLine."Buy-from Vendor No.");
        VendorItemQA.SETRANGE("Item No.", PurchRcptLine."No.");
        IF VendorItemQA.FINDSET THEN BEGIN
            PurchRcptHeader.GET(PurchRcptLine."Document No.");
            PostingDate := PurchRcptHeader."Posting Date";
            REPEAT
                IF (PostingDate > VendorItemQA."Starting Date") AND (PostingDate < VendorItemQA."Ending Date") THEN
                    IF CONFIRM('Vendor Quality Approval Exist. Still Do you want to create Inspection lines') THEN
                        EXIT(TRUE)
                    ELSE
                        EXIT(FALSE);
            UNTIL VendorItemQA.NEXT = 0;
        END;
        EXIT(TRUE);
    end;


    procedure FindSamplingSize(InspectDSHeader: Record "Inspection Datasheet Header"; SpecLine3: Record "Specification Line"): Decimal;
    var
        SampPlanHeader: Record "Sampling Plan Header";
        SamplingPlan: Record "Sampling Plan Line";
        CheckSamplePlan: Boolean;
        SampleSizeCalculated: Decimal;
    begin
        LotMin := 0;
        LotMax := 0;
        AllowableDefects := 0;
        SpecLine3.TESTFIELD("Sampling Code");
        /*
        //B2B-Knr
        ItemVendor.SETRANGE("Vendor No.",InspectDSHeader."Vendor No.");
        ItemVendor.SETRANGE("Item No.",InspectDSHeader."Item No.");
        IF ItemVendor.FINDFIRST THEN
          SpecLine3."Sampling Code" := ItemVendor."Sampling Plan Code"
        ELSE
          SpecLine3."Sampling Code" := SpecLine3."Sampling Code";
        //B2B-Knr
        */
        SampPlanHeader.GET(SpecLine3."Sampling Code");
        SampPlanHeader.TESTFIELD(Status, SampPlanHeader.Status::Certified);

        CASE SampPlanHeader."Sampling Type" OF

            SampPlanHeader."Sampling Type"::"Complete Lot":
                SampleSizeCalculated := InspectDSHeader.Quantity;

            SampPlanHeader."Sampling Type"::"Fixed Quantity":
                BEGIN
                    SampPlanHeader.TESTFIELD("Fixed Quantity");
                    SampleSizeCalculated := SampPlanHeader."Fixed Quantity";
                END;

            SampPlanHeader."Sampling Type"::"Percentage Lot":
                BEGIN
                    SampPlanHeader.TESTFIELD("Lot Percentage");
                    SampleSizeCalculated := InspectDSHeader.Quantity * SampPlanHeader."Lot Percentage" / 100;
                    QCSetup;
                    CASE QualitySetup."Sampling Rounding" OF
                        QualitySetup."Sampling Rounding"::Nearest:
                            SampleSizeCalculated := ROUND(SampleSizeCalculated, 1, '=');
                        QualitySetup."Sampling Rounding"::Up:
                            SampleSizeCalculated := ROUND(SampleSizeCalculated, 1, '>');
                        QualitySetup."Sampling Rounding"::Down:
                            SampleSizeCalculated := ROUND(SampleSizeCalculated, 1, '<');
                    END;
                END;

            SampPlanHeader."Sampling Type"::"Variable Quantity":
                BEGIN
                    CheckSamplePlan := FALSE;
                    SamplingPlan.SETRANGE("Sampling Code", SpecLine3."Sampling Code");
                    IF SamplingPlan.FINDSET THEN
                        REPEAT
                            SamplingPlan.TESTFIELD("Sampling Size");
                            IF (InspectDSHeader.Quantity >= SamplingPlan."Lot Size - Min") AND
                              (InspectDSHeader.Quantity <= SamplingPlan."Lot Size - Max") THEN BEGIN
                                SampleSizeCalculated := SamplingPlan."Sampling Size";
                                CheckSamplePlan := TRUE;
                                LotMin := SamplingPlan."Lot Size - Min";
                                LotMax := SamplingPlan."Lot Size - Max";
                                AllowableDefects := SamplingPlan."Allowable Defects - Max";
                                SamplingSize := SamplingPlan."Sampling Size";
                            END;
                        UNTIL SamplingPlan.NEXT = 0;
                    IF NOT CheckSamplePlan THEN
                        ERROR('Sample Plan %1 is out of Range for the lot %2', SpecLine3."Sampling Code", InspectDSHeader."Lot No.")
                END;
        END;

        EXIT(SampleSizeCalculated);

    end;


    procedure CopyItemTrackingLots(PurchRcptLine: Record "Purch. Rcpt. Line");
    var
        ItemEntryRelation: Record "Item Entry Relation";
        InspectLot: Record "Inspection Lot";
        TempItemLedgEntry: Record "Item Ledger Entry" temporary;
        LineNo: Integer;
        LotNo: Code[20];
        LotQuantity: Integer;
    begin
        ItemEntryRelation.SETCURRENTKEY("Source ID", "Source Type");
        ItemEntryRelation.SETRANGE("Source Type", DATABASE::"Purch. Rcpt. Line");
        ItemEntryRelation.SETRANGE("Source Subtype", 0);
        ItemEntryRelation.SETRANGE("Source ID", PurchRcptLine."Document No.");
        ItemEntryRelation.SETRANGE("Source Batch Name", '');
        ItemEntryRelation.SETRANGE("Source Prod. Order Line", 0);
        ItemEntryRelation.SETRANGE("Source Ref. No.", PurchRcptLine."Line No.");
        TempItemLedgEntry.DELETEALL;
        LineNo := 10000;
        IF ItemEntryRelation.FINDSET THEN BEGIN
            REPEAT
                ItemLedgEntry.GET(ItemEntryRelation."Item Entry No.");
                TempItemLedgEntry := ItemLedgEntry;
                ItemLedgEntry1.INIT;
                ItemLedgEntry1.TRANSFERFIELDS(ItemLedgEntry);
                ItemLedgEntry1.INSERT;
                AddTempRecordSet(TempItemLedgEntry);
                //QCP1.0
                TempILENo := ItemLedgEntry."Entry No.";
            //QCP1.0
            UNTIL ItemEntryRelation.NEXT = 0;
        END;
        IF TempItemLedgEntry.FINDSET THEN BEGIN
            InspectLot.SETRANGE("Document No.", PurchRcptLine."Document No.");
            InspectLot.SETRANGE("Purch. Line No.", PurchRcptLine."Line No.");
            IF InspectLot.FINDLAST THEN
                LineNo := InspectLot."Line No.";
            //QCP1.0
            TempILENo := ItemLedgEntry."Entry No.";
            //QCP1.0
            InspectLot.INIT;
            REPEAT
                InspectLot."Document No." := PurchRcptLine."Document No.";
                InspectLot."Purch. Line No." := PurchRcptLine."Line No.";
                InspectLot."Lot No." := TempItemLedgEntry."Lot No.";
                InspectLot."Line No." := LineNo;
                InspectLot.Quantity := TempItemLedgEntry.Quantity;
                InspectLot.INSERT(TRUE);
                LineNo := LineNo + 10000;
            UNTIL TempItemLedgEntry.NEXT = 0;
        END;
    end;


    procedure AddTempRecordSet(var TempItemLedgEntry: Record "Item Ledger Entry");
    var
        TempItemLedgEntry2: Record "Item Ledger Entry";
    begin
        TempItemLedgEntry2 := TempItemLedgEntry;
        TempItemLedgEntry.RESET;
        TempItemLedgEntry.SETRANGE("Lot No.", TempItemLedgEntry2."Lot No.");
        IF TempItemLedgEntry.FINDFIRST THEN BEGIN
            TempItemLedgEntry.Quantity += TempItemLedgEntry2.Quantity;
            TempItemLedgEntry.MODIFY;
        END ELSE BEGIN
            TempItemLedgEntry.INSERT;
        END;
        TempItemLedgEntry.RESET;
    end;


    procedure CheckSpecCertified(Spec: Code[20]);
    var
        SpecHeader: Record "Specification Header";
    begin
        SpecHeader.GET(Spec);
        SpecHeader.TESTFIELD(Status, SpecHeader.Status::Certified);
    end;


    procedure QCSetup();
    begin
        IF NOT QCSetupRead THEN
            QualitySetup.GET;
        QCSetupRead := TRUE;
    end;


    procedure CreatePurchOrderInspectDS(PurchHeader2: Record "Purchase Header");
    var
        PurchLine2: Record "Purchase Line";
        NoOfInspectDS: Integer;
    begin
        PurchHeader.COPY(PurchHeader2);
        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Order);
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        PurchLine.SETRANGE(Type, PurchLine.Type::Item);
        PurchLine.SETRANGE("QC Enabled", TRUE);

        NoOfInspectDS := 0;
        IF PurchLine.FINDSET THEN
            REPEAT
                IF PurchLine."Qty. Sending To Quality" <> 0 THEN BEGIN
                    NoOfInspectDS := NoOfInspectDS + 1;
                    InitInspectionHeader(InspectionType::"Purchase Before Inspection");
                    InsertInspectionDataHeader;
                    PurchLine."Qty. Sent To Quality" := PurchLine."Qty. Sent To Quality" + PurchLine."Qty. Sending To Quality";
                    PurchLine."Qty. Sending To Quality" := 0;
                    PurchLine.MODIFY;
                END;
            UNTIL PurchLine.NEXT = 0;
        IF NoOfInspectDS = 0 THEN
            MESSAGE(Text003)
        ELSE
            MESSAGE(Text004, NoOfInspectDS);
    end;


    procedure "---B2B-ESPL-Quality--"();
    begin
    end;


    procedure CreateSalesCrMemoIDS(SalesCrMemoHeader2: Record "Sales Cr.Memo Header"; SalesCrMemoLine2: Record "Sales Cr.Memo Line");
    begin
        SalesCrMemoHeader.COPY(SalesCrMemoHeader2);
        SalesCrMemoLine.COPY(SalesCrMemoLine2);
        InitInspectionHeader(InspectionType::SalesCrMemo);
        InsertInspectionDataHeader;
        ValueEntry.RESET;
        ValueEntry.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
        IF ValueEntry.FINDFIRST THEN BEGIN
            ItemLedgEntry1.INIT;
            ItemLedgEntry.GET(ValueEntry."Item Ledger Entry No.");
            ItemLedgEntry1.TRANSFERFIELDS(ItemLedgEntry);
            ItemLedgEntry1.INSERT;
        END;
        MESSAGE(Text000);
    end;


    procedure CreateSalesCrMemoIDS1(SalesHeader2: Record "Sales Header"; SalesLine2: Record "Sales Line");
    begin
        SalesHeader.COPY(SalesHeader2);
        SalesLine.COPY(SalesLine2);
        InitInspectionHeader(InspectionType::SalesCrMemo);
        InsertInspectionDataHeader;

        MESSAGE(Text000);
    end;


    procedure CreateTransferInspectDataSheet(TransferHeader2: Record "Transfer Header"; TransferLine2: Record "Transfer Line");
    var
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
    begin
        TransferHeader := TransferHeader2;
        TransferLine := TransferLine2;
        QCSetup;
        QualitySetup.TESTFIELD("Inspection Datasheet Nos.");

        InspectDataHeader.INIT;
        InspectDataHeader."Created By" := USERID;
        InspectDataHeader."Created Date" := WORKDATE;
        InspectDataHeader."Created Time" := TIME;
        InspectDataHeader."Order No." := TransferHeader."No.";
        InspectDataHeader."Posting Date" := TransferHeader."Posting Date";
        InspectDataHeader."Document Date" := TransferHeader."Shipment Date";
        InspectDataHeader."Item No." := TransferLine."Item No.";
        InspectDataHeader."Item Description" := TransferLine.Description;
        InspectDataHeader."Unit Of Measure Code" := TransferLine."Unit of Measure";
        InspectDataHeader."Spec Version" := TransferLine."Spec Version";
        InspectDataHeader.Quantity := TransferLine."Qty. Sending To Quality";
        CheckSpecCertified(TransferLine."Spec ID");
        InspectDataHeader."Spec ID" := TransferLine."Spec ID";

        InspectDataHeader."Trans. Order No." := TransferHeader."No.";
        InspectDataHeader."Trans. Order Line" := TransferLine."Line No.";
        InspectDataHeader."Trans. Description" := TransferHeader."Transfer-from Name";
        InspectDataHeader."Transfer-from Code" := TransferHeader."Transfer-from Code";
        InspectDataHeader."Transfer-to Code" := TransferHeader."Transfer-to Code";
        InspectDataHeader."Source Type" := InspectDataHeader."Source Type"::Transfer;

        InsertInspectionDataHeader;
        TransferLine2."Qty. Sent To Quality" := TransferLine2."Qty. Sent To Quality" + TransferLine2."Qty. Sending To Quality";
        TransferLine2."Qty. Sending To Quality" := 0;
        TransferLine2.MODIFY;
        MESSAGE(Text000);
    end;


    procedure CreateReturnOrderIDS(ReturnReceiptHeader2: Record "Return Receipt Header"; ReturnReceiptLine2: Record "Return Receipt Line");
    begin
        ReturnReceiptHeader.COPY(ReturnReceiptHeader2);
        ReturnReceiptLine.COPY(ReturnReceiptLine2);
        InitInspectionHeader(InspectionType::ReturnOrder);
        InsertInspectionDataHeader;
        ItemLedgEntry.SETRANGE("Document No.", ReturnReceiptHeader2."No.");
        IF ItemLedgEntry.FINDFIRST THEN BEGIN
            ItemLedgEntry1.TRANSFERFIELDS(ItemLedgEntry);
            ItemLedgEntry1.INSERT;
        END;
        MESSAGE(Text000);
    end;


    procedure CreateInprecessInspectionIDS(Item: Record Item);
    var
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        InspectionItem.COPY(Item);
        ItemLedgEntry.RESET;
        ItemLedgEntry.SETRANGE("Item No.", InspectionItem."No.");
        ItemLedgEntry.SETRANGE(Open, TRUE);
        IF ItemLedgEntry.FINDSET THEN BEGIN
            REPEAT
                QualityItemLedgEntry.SETRANGE("Entry No.", ItemLedgEntry."Entry No.");
                IF NOT QualityItemLedgEntry.FINDFIRST THEN BEGIN
                    InitInprecessInspectionIDS(ItemLedgEntry."Entry No.", ItemLedgEntry.Quantity);
                    ItemLedgEntry1.TRANSFERFIELDS(ItemLedgEntry);
                    ItemLedgEntry1.INSERT;
                END;
            UNTIL ItemLedgEntry.NEXT = 0;
        END;
        MESSAGE(Text000);
    end;


    procedure InitInprecessInspectionIDS(EntryNo: Integer; Quantity: Decimal);
    begin
        QCSetup;
        QualitySetup.TESTFIELD("Inspection Datasheet Nos.");

        InspectDataHeader.INIT;
        InspectDataHeader."Created By" := USERID;
        InspectDataHeader."Created Date" := WORKDATE;
        InspectDataHeader."Created Time" := TIME;

        InspectDataHeader.Description := InspectionItem.Description;
        InspectDataHeader."Source Type" := InspectDataHeader."Source Type"::"In Bound";
        InspectDataHeader."Item No." := InspectionItem."No.";
        InspectDataHeader."Item Description" := InspectionItem.Description;
        InspectDataHeader."Unit Of Measure Code" := InspectionItem."Base Unit of Measure";
        InspectDataHeader.Quantity := Quantity;
        InspectDataHeader."Item Ledger Entry No." := EntryNo;
        CheckSpecCertified(InspectionItem."Spec ID");
        InspectDataHeader."Spec ID" := InspectionItem."Spec ID";
        InspectDataHeader."Document Type" := InspectDataHeader."Document Type"::"Item Inspection";
        InsertInspectionDataHeader;
    end;


    procedure CreateSampleLotIDS(Rec: Record "Sample Lot Inspection");
    var
        PurchaseLine: Record "Purchase Line";
    begin
        Rec.TESTFIELD(Rec.Create, FALSE);
        PurchHeader.GET(PurchHeader."Document Type"::Order, Rec."Purchase Order No.");
        PurchHeader.TESTFIELD(Status, PurchHeader.Status::Released);

        PurchaseLine.SETRANGE("Document No.", Rec."Purchase Order No.");
        PurchaseLine.SETRANGE("Line No.", Rec."Purchase Line No.");
        IF PurchaseLine.FINDFIRST THEN;
        QCSetup;
        QualitySetup.TESTFIELD("Inspection Datasheet Nos.");

        InspectDataHeader.INIT;
        InspectDataHeader."Created By" := USERID;
        InspectDataHeader."Created Date" := WORKDATE;
        InspectDataHeader."Created Time" := TIME;

        InspectDataHeader.Description := PurchHeader."Buy-from Vendor No.";
        InspectDataHeader."Receipt No." := '';
        InspectDataHeader."Order No." := PurchHeader."No.";
        InspectDataHeader."Posting Date" := PurchHeader."Posting Date";
        InspectDataHeader."Document Date" := PurchHeader."Document Date";
        InspectDataHeader."Vendor No." := PurchHeader."Buy-from Vendor No.";
        InspectDataHeader."Vendor Name" := PurchHeader."Buy-from Vendor Name";
        InspectDataHeader."Vendor Name 2" := PurchHeader."Buy-from Vendor Name 2";
        InspectDataHeader."Vendor Address" := PurchHeader."Buy-from Address";
        InspectDataHeader."Vendot Address 2" := PurchHeader."Buy-from Address 2";
        InspectDataHeader."Contact Person" := PurchHeader."Buy-from Contact";
        InspectDataHeader.Location := PurchaseLine."Location Code";
        InspectDataHeader."Source Type" := InspectDataHeader."Source Type"::"In Bound";
        InspectDataHeader."Item No." := PurchLine."No.";
        InspectDataHeader."Item Description" := PurchaseLine.Description;
        InspectDataHeader."External Document No." := PurchHeader."Vendor Shipment No.";
        InspectDataHeader."Unit Of Measure Code" := PurchLine."Unit of Measure Code";
        InspectDataHeader.Quantity := Rec."Sample Qty.";
        CheckSpecCertified(PurchaseLine."Spec ID");
        InspectDataHeader."Spec ID" := PurchaseLine."Spec ID";
        InspectDataHeader."Purch Line No" := Rec."Purchase Line No.";
        InspectDataHeader."Quality Before Receipt" := TRUE;
        InspectDataHeader."Sample Inspection Line No." := Rec."Line No.";
        InspectDataHeader."Document Type" := InspectDataHeader."Document Type"::Receipt;
        InspectDataHeader."Sample Inspection" := TRUE;
        QualitySetup.TESTFIELD("Purchase Consignment No.");
        InspectDataHeader."Purchase Consignment No." := NoSeriesMgt.GetNextNo(QualitySetup."Purchase Consignment No.", 0D, TRUE);

        InsertInspectionDataHeader;
        Rec.Create := TRUE;
        Rec.MODIFY;

        MESSAGE(Text000);
    end;


    procedure "-----------B2B-----------"();
    begin
    end;


    procedure CreateCalibrationIDS(Calibration2: Record Calibration);
    begin
        Calibration.COPY(Calibration2);
        InitInspectionHeader(InspectionType::Calibration);
        InsertInspectionDataHeader;
        MESSAGE(Text000);
    end;


    procedure CreateCalibrationIDS2(Calibration2: Record Calibration);
    begin
        Calibration.COPY(Calibration2);
        InitInspectionHeader(InspectionType::Calibration);
        InsertInspectionDataHeader;
    end;


    procedure AssignInprocessSerialNo(InprocessSerialNo: Code[20]);
    begin
        //NSS 030907
        SerialNo := InprocessSerialNo;
    end;


    procedure CreateInprocInspectDataSheet2(var ProdOrderRoutingLine2: Record "Prod. Order Routing Line"; var ItemJournalLine: Record "Item Journal Line");
    var
        ILE: Record "Item Ledger Entry";
        ItemRec: Record Item;
        ILE2: Record "Item Ledger Entry";
    begin
        IF NOT ProdOrderRoutingLine2."QC Enabled" THEN
            EXIT;
        ProdOrderRoutingLine2.TESTFIELD("Sub Assembly");
        ProdOrderRoutingLine2.TESTFIELD("Spec Id");
        ProdOrderRoutingLine2.TESTFIELD("Qty.To Produce");
        ProdOrderRoutingLine := ProdOrderRoutingLine2;

        //NSS 030907
        ILE.SETCURRENTKEY("Order Type", "Order No.", "Order Line No.", "Prod. Order Comp. Line No.", "Entry Type");  //mnraju  -->Order Type included
        ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Consumption);
        ILE.SETRANGE("Order No.", ProdOrderRoutingLine."Prod. Order No.");
        ILE.SETRANGE("Order Line No.", ProdOrderRoutingLine."Routing Reference No.");
        IF ILE.FINDSET THEN
            REPEAT
                IF ItemRec.GET(ILE."Item No.") THEN
                    IF ItemRec.PCB = TRUE THEN
                        PCBItemNo := ILE."Item No."
                    ELSE
                        PCBItemNo := '';
            UNTIL (ILE.NEXT = 0) OR (ItemRec.PCB = TRUE);

        ILE2.SETCURRENTKEY("Entry Type", "Location Code", "External Document No.", "Item No.", "Order Type", "Order No.", "Order Line No."); //Mn Raju
        IF ItemRec.GET(PCBItemNo) THEN BEGIN
            ILE2.SETRANGE(ILE2."Entry Type", ILE2."Entry Type"::Consumption);
            ILE2.SETRANGE("Order No.", ProdOrderRoutingLine."Prod. Order No.");
            ILE2.SETRANGE("Order Line No.", ProdOrderRoutingLine."Routing Reference No.");
            ILE2.SETRANGE("Item No.", PCBItemNo);
            IF ILE2.FINDSET THEN
                REPEAT
                    TempILE2.INIT;
                    TempILE2.COPY(ILE2);
                    TempILE2.INSERT;
                UNTIL ILE2.NEXT = 0;
        END;
        IF TempILE2.FINDSET THEN
            REPEAT
                SerialNo := ItemJournalLine."Output Jr Serial No.";
                ItemJournalLine2 := ItemJournalLine;
                //MESSAGE('%1 begin',ItemJournalLine."Output Jr Serial No.");
                //AssignInprocessSerialNo(TempILE2."Serial No.");
                InitInspectionHeader(InspectionType::"Production Order");
                InsertInspectionDataHeader;
            UNTIL TempILE2.NEXT = 0
        ELSE BEGIN
            //MESSAGE('%1 else begin',ItemJournalLine."Output Jr Serial No.");
            SerialNo := ItemJournalLine."Output Jr Serial No.";
            ItemJournalLine2 := ItemJournalLine;
            InitInspectionHeader(InspectionType::"Production Order");
            InsertInspectionDataHeader;
        END;
        //NSS 030907


        ProdOrderRoutingLine2."Quantity Produced" := ProdOrderRoutingLine2."Quantity Produced" + ProdOrderRoutingLine2."Qty.To Produce";
        ProdOrderRoutingLine2."Quantity Sent To Quality" := ProdOrderRoutingLine2."Quantity Produced";
        IF ProdOrderRoutingLine2.Quantity - ProdOrderRoutingLine2."Quantity Produced" > 0 THEN
            ProdOrderRoutingLine2."Qty.To Produce" := ProdOrderRoutingLine2.Quantity - ProdOrderRoutingLine2."Quantity Produced"
        ELSE
            ProdOrderRoutingLine2."Qty.To Produce" := 0;
        ProdOrderRoutingLine2.MODIFY;
        MESSAGE(Text000);
    end;


    procedure GetSerialNum(ProdOrderNum: Code[20]; ItemNum: Code[20]): Text[250];
    begin
        ItemLedgEntry.SETCURRENTKEY("Item No.", "Order No.", "Entry Type");
        ItemLedgEntry.SETRANGE("Entry Type", ItemLedgEntry."Entry Type"::Output);
        ItemLedgEntry.SETRANGE("Order No.", ProdOrderNum);
        ItemLedgEntry.SETRANGE("Item No.", ItemNum);
        IF ItemLedgEntry.FINDSET THEN BEGIN
            CLEAR(TempSerialNo);
            REPEAT
                IF TempSerialNo <> '' THEN
                    TempSerialNo := TempSerialNo + ',' + ItemLedgEntry."Serial No."
                ELSE
                    TempSerialNo := ItemLedgEntry."Serial No.";
            UNTIL ItemLedgEntry.NEXT = 0;
            EXIT(TempSerialNo);
        END;
    end;


    procedure "---B2BKPK PartialIDSCreatio---"();
    begin
    end;


    procedure InsertPartInspectionDataHeader(InspDataHeaderParam: Record "Inspection Datasheet Header");
    var
        NoSeriesMgt: Codeunit 396;
        InspPartDataSheetHeader: Record "Inspection Datasheet Header";
        InspPartDataSheetHeader2: Record "Inspection Datasheet Header";
        InspPartDataSheetHeader3: Record "Inspection Datasheet Header";
        InspPartDataSheetLine: Record "Inspection Datasheet Line";
        InspPartDataSheetLine2: Record "Inspection Datasheet Line";
        ItemLedEntry2: Record "Item Ledger Entry";
        ILENo: Integer;
        QILEPart: Record "Quality Item Ledger Entry";
        TotalCount: Integer;
        QILE: Record "Quality Item Ledger Entry";
        QILENotforLot: Record "Quality Item Ledger Entry";
        Item: Record Item;
        ItemTracking: Record "Item Tracking Code";
    begin
        //PIDSQC1.0>>
        InspPartDataSheetHeader2.SETRANGE("Parent IDS No", InspDataHeaderParam."No.");
        IF InspPartDataSheetHeader2.FINDFIRST THEN BEGIN
            InspPartDataSheetHeader2.CALCFIELDS("Total Qty in IDS");
            IF (InspPartDataSheetHeader2."Qty in IDS" + InspPartDataSheetHeader2."Total Qty in IDS") > InspDataHeaderParam.Quantity THEN
                ERROR(Text005);
        END;

        InspDataHeaderParam.TESTFIELD("Partial Inspection", TRUE);
        InspPartDataSheetHeader.INIT;
        InspPartDataSheetHeader.TRANSFERFIELDS(InspDataHeaderParam);
        InspPartDataSheetHeader.VALIDATE(Quantity, InspDataHeaderParam."Qty in IDS");
        InspPartDataSheetHeader.VALIDATE("Quantity(Base)", InspDataHeaderParam."Quantity(Base)");
        InspPartDataSheetHeader."Qty in IDS" := 0;
        InspPartDataSheetHeader."Parent IDS No" := InspDataHeaderParam."No.";
        InspPartDataSheetHeader."Partial Inspection" := FALSE;
        InspPartDataSheetHeader."Reclass Entry" := FALSE;
        ItemLedEntry2.SETCURRENTKEY("Applies-to Entry");
        ItemLedEntry2.SETRANGE("Applies-to Entry", InspDataHeaderParam."Item Ledger Entry No.");
        IF ItemLedEntry2.FINDLAST THEN BEGIN
            ILENo := ItemLedEntry2."Entry No.";
            /*REPEAT
              QILE.SETFILTER("Entry No.", '<>%1',ItemLedEntry2."Entry No.");
              IF QILE.FINDFIRST THEN BEGIN
                ILENo := ItemLedEntry2."Entry No.";
                EXIT;
              END;
            UNTIL ItemLedEntry2.NEXT = 0;*/
            InspPartDataSheetHeader."Item Ledger Entry No." := ILENo + 1;
        END;
        IF NewSerialNo <> '' THEN
            InspPartDataSheetHeader."Serial No." := NewSerialNo;
        IF NewLotNo <> '' THEN
            InspPartDataSheetHeader."Lot No." := NewLotNo;
        QualitySetup.GET;
        InspPartDataSheetHeader."No." := NoSeriesMgt.GetNextNo(QualitySetup."Inspection Datasheet Nos.", 0D, TRUE);
        InspPartDataSheetHeader.INSERT;

        InspPartDataSheetLine.SETRANGE("Document No.", InspDataHeaderParam."No.");
        IF InspPartDataSheetLine.FINDSET THEN
            REPEAT
                InspPartDataSheetLine2.INIT;
                InspPartDataSheetLine2.TRANSFERFIELDS(InspPartDataSheetLine);
                InspPartDataSheetLine2."Document No." := InspPartDataSheetHeader."No.";
                InspPartDataSheetLine2.INSERT;
            UNTIL InspPartDataSheetLine.NEXT = 0;


        //300708>>
        Item.GET(InspDataHeaderParam."Item No.");
        IF ItemTracking.GET(Item."Item Tracking Code") THEN BEGIN
            IF (ItemTracking."Lot Specific Tracking") AND (ItemTracking."SN Specific Tracking" = FALSE) THEN
                UpdateQILE(InspPartDataSheetHeader."Item Ledger Entry No.") //Previous
            ELSE BEGIN
                QILENotforLot.SETRANGE("Document No.", InspDataHeaderParam."Receipt No.");
                QILENotforLot.SETRANGE("Item No.", InspDataHeaderParam."Item No.");
                QILENotforLot.SETRANGE(Select, TRUE);
                QILENotforLot.SETRANGE("Child Ids", '');
                IF QILENotforLot.FINDSET THEN BEGIN
                    REPEAT
                        QILENotforLot."Child Ids" := InspPartDataSheetHeader."No.";
                        QILENotforLot.MODIFY;
                    UNTIL QILENotforLot.NEXT = 0;
                END;
            END;
        END;
        //300708<<

        //Previous>>
        //UpdateQILE(InspPartDataSheetHeader."Item Ledger Entry No.");
        //Previous<<
        InspDataHeaderParam."Qty in IDS" := 0;
        InspDataHeaderParam."Reclass Entry" := FALSE;
        InspDataHeaderParam.MODIFY;
        MESSAGE(Text000);
        //PIDSQC1.0<<

    end;


    procedure UpdateItemLedgerEntry(ItemTrackingExists: Boolean; IDSParam: Record "Inspection Datasheet Header");
    var
        ItemApplnEntry: Record "Item Application Entry";
        ItemJnlLine: Record "Item Journal Line";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        "-Rev01-": Integer;
        ItemLedgEntryLRec: Record "Item Ledger Entry";
    begin
        //PIDSQC1.0>>
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
        ItemJnlLine."Document No." := IDSParam."No.";
        ItemJnlLine."Line No." := ItemReclassLineNo;
        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::Transfer;
        ItemJnlLine.VALIDATE("Item No.", IDSParam."Item No.");
        ItemJnlLine.VALIDATE("Unit of Measure Code", IDSParam."Unit Of Measure Code");
        ItemJnlLine.VALIDATE(Quantity, IDSParam."Qty in IDS");
        ItemJnlLine.VALIDATE("Location Code", IDSParam.Location);
        ItemJnlLine.VALIDATE("New Location Code", IDSParam.Location);

        //Rev01 Start
        //Code Commented
        /*
        ItemJnlLine.VALIDATE("Applies-to Entry",IDSParam."Item Ledger Entry No.");
        */
        IF NOT ItemTrackingExists THEN
            ItemJnlLine.VALIDATE("Applies-to Entry", IDSParam."Item Ledger Entry No.")
        ELSE BEGIN
            IF IDSParam."Item Ledger Entry No." <> 0 THEN BEGIN
                ItemLedgEntryLRec.GET(IDSParam."Item Ledger Entry No.");

                ItemJnlLine."Location Code" := ItemLedgEntryLRec."Location Code";
                ItemJnlLine."Variant Code" := ItemLedgEntryLRec."Variant Code";
            END;
        END;
        //Rev01 End

        IF ItemTrackingExists THEN
            "UpdateRes.Entry"(ItemJnlLine, IDSParam);

        ItemJnlLine.INSERT;
        ItemJnlPostLine.RUN(ItemJnlLine);

        UpdateQILE(IDSParam."Item Ledger Entry No.");
        //PIDSQC1.0>>

    end;


    procedure UpdateQILE(ILEEntryNo: Integer);
    var
        QualityItemLedgerEntry: Record "Quality Item Ledger Entry";
        QualityItemLedgerEntry2: Record "Quality Item Ledger Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemLedgerEntry2: Record "Item Ledger Entry";
    begin
        //PIDSQC1.0>>
        ItemLedgerEntry.GET(ILEEntryNo);
        IF ItemLedgerEntry."Remaining Quantity" <> 0 THEN BEGIN
            QualityItemLedgerEntry.INIT;
            QualityItemLedgerEntry.TRANSFERFIELDS(ItemLedgerEntry);
            QualityItemLedgerEntry."Inspection Status" := QualityItemLedgerEntry."Inspection Status"::"Under Inspection";
            QualityItemLedgerEntry."Purch.Rcpt Line" := ItemLedgerEntry2."Purch.Rcpt Line";
            QualityItemLedgerEntry."Global Dimension 1 Code" := ItemLedgerEntry2."Global Dimension 1 Code";
            QualityItemLedgerEntry."Source Type" := ItemLedgerEntry2."Source Type";
            QualityItemLedgerEntry.INSERT;
        END;
        //PIDSQC1.0>>
    end;


    procedure "UpdateRes.Entry"(var ItemJournalLine: Record "Item Journal Line"; IDSParamLoc: Record "Inspection Datasheet Header");
    var
        ReservationEntry: Record "Reservation Entry";
        TempReservationEntry: Record "Reservation Entry";
        EntryNo: Integer;
        ItemLedgerEntryLoc: Record "Item Ledger Entry";
        InspDataSheetHeader2: Record "Inspection Datasheet Header";
        PostInspectDataSheetHeader2: Record "Posted Inspect DatasheetHeader";
    begin
        //PIDSQC1.0>>
        NewLotNo := '';
        NewSerialNo := '';
        //IdsCount := '';
        IF TempReservationEntry.FINDLAST THEN
            EntryNo := TempReservationEntry."Entry No."
        ELSE
            EntryNo := 0;
        ReservationEntry."Entry No." := EntryNo + 1;
        ReservationEntry.VALIDATE(Positive, FALSE);
        ReservationEntry.VALIDATE("Item No.", ItemJournalLine."Item No.");
        ReservationEntry.VALIDATE("Location Code", ItemJournalLine."Location Code");
        ReservationEntry.VALIDATE("Quantity (Base)", -IDSParamLoc."Qty in IDS");
        ReservationEntry.VALIDATE(Quantity, -IDSParamLoc."Qty in IDS");
        ReservationEntry.VALIDATE("Reservation Status", ReservationEntry."Reservation Status"::Prospect);
        ReservationEntry.VALIDATE("Creation Date", ItemJournalLine."Posting Date");
        ReservationEntry.VALIDATE("Source Type", DATABASE::"Item Journal Line");
        ReservationEntry.VALIDATE("Source Subtype", 4);
        ReservationEntry.VALIDATE("Source ID", ItemJournalLine."Journal Template Name");
        ReservationEntry.VALIDATE("Source Batch Name", ItemJournalLine."Journal Batch Name");
        ReservationEntry.VALIDATE("Source Ref. No.", ItemJournalLine."Line No.");
        //ReservationEntry.VALIDATE("Appl.-to Item Entry",QualityLedgEntry2."Applies-to Entry");
        ReservationEntry.VALIDATE("Appl.-to Item Entry", IDSParamLoc."Item Ledger Entry No."); //Rev01
        ReservationEntry.VALIDATE("Shipment Date", ItemJournalLine."Posting Date");
        ItemLedgerEntryLoc.GET(IDSParamLoc."Item Ledger Entry No.");
        ReservationEntry.VALIDATE("Serial No.", ItemLedgerEntryLoc."Serial No.");
        ReservationEntry.VALIDATE("Suppressed Action Msg.", FALSE);
        ReservationEntry.VALIDATE("Planning Flexibility", ReservationEntry."Planning Flexibility"::Unlimited);
        //ReservationEntry.VALIDATE("Expiration Date",QualityItemLedgEntry."Expiration Date");
        InspDataSheetHeader2.SETRANGE("Parent IDS No", IDSParamLoc."No.");
        IdsCount := InspDataSheetHeader2.COUNT + 1;

        PostInspectDataSheetHeader2.SETRANGE("Parent IDS No", IDSParamLoc."No.");
        PostCount := PostInspectDataSheetHeader2.COUNT;
        TotalCount := IdsCount + PostCount;
        NewLotNo := ItemLedgerEntryLoc."Lot No." + '\' + FORMAT(TotalCount);
        NewSerialNo := ItemLedgerEntryLoc."Serial No." + '\' + FORMAT(TotalCount);
        ReservationEntry.VALIDATE("Lot No.", ItemLedgerEntryLoc."Lot No.");
        ReservationEntry.VALIDATE(ReservationEntry."New Lot No.", NewLotNo);
        IF ReservationEntry."Serial No." <> '' THEN
            ReservationEntry.VALIDATE(ReservationEntry."New Serial No.", NewSerialNo);
        ReservationEntry.VALIDATE(Correction, FALSE);
        ReservationEntry.INSERT;
        //PIDSQC1.0>>
    end;


    procedure ItemReclassLineNo(): Integer;
    var
        ItemJnlLine2: Record "Item Journal Line";
    begin
        //PIDSQC1.0>>
        ItemJnlLine2.SETRANGE(ItemJnlLine2."Journal Template Name", 'RECLASS');
        ItemJnlLine2.SETRANGE(ItemJnlLine2."Journal Batch Name", 'DEFAULT');
        IF ItemJnlLine2.FINDLAST THEN
            EXIT(ItemJnlLine2."Line No." + 10000)
        ELSE
            EXIT(10000);
        //PIDSQC1.0>>
    end;


    procedure InsertPartInspectionDataHead2(InspDataHeaderParam: Record "Inspection Datasheet Header");
    var
        NoSeriesMgt: Codeunit 396;
        InspPartDataSheetHeader: Record "Inspection Datasheet Header";
        InspPartDataSheetHeader2: Record "Inspection Datasheet Header";
        InspPartDataSheetHeader3: Record "Inspection Datasheet Header";
        InspPartDataSheetLine: Record "Inspection Datasheet Line";
        InspPartDataSheetLine2: Record "Inspection Datasheet Line";
        ItemLedEntry2: Record "Item Ledger Entry";
        ILENo: Integer;
        QILEPart: Record "Quality Item Ledger Entry";
        TotalCount: Integer;
    begin
        //PIDSQC1.0>>
        QILEPart.GET(InspDataHeaderParam."Item Ledger Entry No.");
        QILEPart.DELETE;

        UpdateItemLedgerEntry(InspDataHeaderParam."Item Tracking Exists", InspDataHeaderParam);

        InspDataHeaderParam."Partial Inspection" := TRUE;
        InspDataHeaderParam."Reclass Entry" := TRUE;
        InspDataHeaderParam.MODIFY;
        MESSAGE(Text006);
        //PIDSQC1.0>>
    end;
}

