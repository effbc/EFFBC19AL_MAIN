table 60054 "Sample Lot Inspection"
{
    DataClassification = CustomerContent;
    // version B2B1.0


    fields
    {
        field(1; "Purchase Order No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(2; "Purchase Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(4; Quantity; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; "Sample Qty."; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Text01: Label 'Sample should be Less than or Equal to the Quantity..!';
            begin
                if (Quantity < "Sample Qty.") then
                    Error(Text01);
                if Create = true then
                    Error(Text002);
            end;
        }
        field(6; "Accepted Qty."; Decimal)
        {
            CalcFormula = Sum("Quality Ledger Entry".Quantity WHERE("Order No." = FIELD("Purchase Order No."),
                                                                     "Order Line No." = FIELD("Purchase Line No."),
                                                                     "Sample Inspection Line No." = FIELD("Line No."),
                                                                     "Entry Type" = CONST(Accepted)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Rejected Qty."; Decimal)
        {
            CalcFormula = Sum("Quality Ledger Entry".Quantity WHERE("Order No." = FIELD("Purchase Order No."),
                                                                     "Order Line No." = FIELD("Purchase Line No."),
                                                                     "Sample Inspection Line No." = FIELD("Line No."),
                                                                     "Entry Type" = CONST(Reject)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Rework Qty."; Decimal)
        {
            CalcFormula = Sum("Quality Ledger Entry"."Remaining Quantity" WHERE("Order No." = FIELD("Purchase Order No."),
                                                                                 "Order Line No." = FIELD("Purchase Line No."),
                                                                                 "Sample Inspection Line No." = FIELD("Line No."),
                                                                                 "Entry Type" = CONST(Rework)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; Accept; Boolean)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(100; Create; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Purchase Order No.", "Purchase Line No.", Quantity, "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        InspectionDataSheetHeader.SetRange("Order No.", "Purchase Order No.");
        InspectionDataSheetHeader.SetRange("Purch Line No", "Purchase Line No.");
        InspectionDataSheetHeader.SetRange("Sample Inspection Line No.", "Line No.");
        if InspectionDataSheetHeader.Find('-') then
            Error(Text001);

        InspectionReceiptHeader.SetRange("Order No.", "Purchase Order No.");
        InspectionReceiptHeader.SetRange("Purch Line No", "Purchase Line No.");
        InspectionReceiptHeader.SetRange("Sample Inspection Line No.", "Line No.");
        InspectionReceiptHeader.SetFilter(Status, 'NO');
        if InspectionReceiptHeader.Find('-') then
            Error(Text001);
    end;

    trigger OnInsert();
    var
        Text001: Label 'Status should be Release for Purchase Order :%1';
    begin
        PurchaseHeader.SetRange(PurchaseHeader."No.", "Purchase Order No.");
        if PurchaseHeader.Find('-') then
            if PurchaseHeader.Status = PurchaseHeader.Status::Open then
                Error(Text001, PurchaseHeader."No.");

        SampleLotInspection.SetRange("Purchase Order No.", "Purchase Order No.");
        SampleLotInspection.SetRange("Purchase Line No.", "Purchase Line No.");
        SampleLotInspection.SetFilter(Accept, 'YES');
        if SampleLotInspection.Find('-') then
            if not Confirm(Text01, false) then
                exit;
    end;

    var
        SampleLotInspection: Record "Sample Lot Inspection";
        Text01: Label 'Sample Lot is already Accepted do you want again inspect the Lot.!';
        InspectionDataSheetHeader: Record "Inspection Datasheet Header";
        InspectionReceiptHeader: Record "Inspection Receipt Header";
        Text001: Label 'You can not Delete the Entries IDS/IR Exists.';
        Text002: Label '"You can not Modify the Quantity "';
        PurchaseHeader: Record "Purchase Header";


    procedure UpdateQualityPurchLines();
    var
        SpecHeader: Record "Specification Header";
        ActiveVersionCode: Code[20];
    begin
        /*
        "Spec ID" := VendorQualityApprovalSpecId;
        //Hot Fix 1.0
        IF "Spec ID" = '' THEN BEGIN
          "Spec ID" := Item."Spec ID";
          IF "Spec ID" <> '' THEN
            "Spec Version" := SpecHeader.GetSpecVersion("Spec ID",WORKDATE,TRUE);
        END;
        //Hot Fix 1.0
        
        "QC Enabled" := Item."QC Enabled";
        GetQCSetup;
        IF (QualityCtrlSetup."Quality Before Receipt") AND (Item."QC Enabled") THEN
          "Quality Before Receipt" := TRUE;
        */

    end;


    procedure CreateInspectionDataSheets();
    var
        InspectDataSheets: Codeunit "Inspection Data Sheets";
        PurchHeader: Record "Purchase Header";
        WhseRcptLine: Record "Warehouse Receipt Line";
    begin
        PurchHeader.Get(PurchHeader."Document Type"::Order, "Purchase Order No.");
        PurchHeader.TestField(Status, PurchHeader.Status::Released);
        //TESTFIELD("Quality Before Receipt",TRUE);
        TestField("Sample Qty.");

        /*
        WhseRcptLine.SETRANGE("Source Type",39);
        WhseRcptLine.SETRANGE("Source Subtype",1);
        WhseRcptLine.SETRANGE("Source Document",WhseRcptLine."Source Document" :: "Purchase Order");
        WhseRcptLine.SETRANGE("Source No.","Document No.");
        WhseRcptLine.SETRANGE("Source Line No.","Line No.");
        IF WhseRcptLine.FIND('-') THEN
          ERROR('You can not create Inspection Data Sheets when Warehouse Receipt lines exists');
        */
        //InspectDataSheets.CreatePurLineInspectDataSheet(PurchHeader,Rec);

    end;


    procedure ShowDataSheets();
    var
        InspectDataSheet: Record "Inspection Datasheet Header";
    begin
        /*
        InspectDataSheet.SETRANGE("Order No.","Document No.");
        InspectDataSheet.SETRANGE("Purch Line No","Line No.");
        InspectDataSheet.SETRANGE("Source Type",InspectDataSheet."Source Type" ::"In Bound");
        PAGE.RUN(PAGE::"Inspection Data Sheet List",InspectDataSheet);
        */

    end;


    procedure ShowPostDataSheets();
    var
        PostInspectDataSheet: Record "Posted Inspect DatasheetHeader";
    begin
        /*
        PostInspectDataSheet.SETRANGE("Order No.","Document No.");
        PostInspectDataSheet.SETRANGE("Purch Line No","Line No.");
        PostInspectDataSheet.SETRANGE("Source Type",PostInspectDataSheet."Source Type" ::"In Bound");
        PAGE.RUN(PAGE::"Posted Inspect Data Sheet List",PostInspectDataSheet);
        */

    end;


    procedure ShowInspectReceipt();
    var
        InspectionReceipt: Record "Inspection Receipt Header";
    begin
        /*
        InspectionReceipt.SETRANGE("Order No.","Document No.");
        InspectionReceipt.SETRANGE("Purch Line No","Line No.");
        InspectionReceipt.SETRANGE("Source Type",InspectionReceipt."Source Type" ::"In Bound");
        InspectionReceipt.SETRANGE(Status,FALSE);
        PAGE.RUN(PAGE::"Inspection Receipt List",InspectionReceipt);
        */

    end;


    procedure ShowPostInspectReceipt();
    var
        InspectionReceipt: Record "Inspection Receipt Header";
    begin
        /*
        InspectionReceipt.SETRANGE("Order No.","Document No.");
        InspectionReceipt.SETRANGE("Purch Line No","Line No.");
        InspectionReceipt.SETRANGE("Source Type",InspectionReceipt."Source Type" ::"In Bound");
        InspectionReceipt.SETRANGE(Status,TRUE);
        PAGE.RUN(PAGE::"Inspection Receipt List",InspectionReceipt);
        */

    end;


    procedure GetQCSetup();
    begin
        /*
        IF NOT QCSetupRead THEN
          QualityCtrlSetup.GET;
        QCSetupRead := TRUE;
        */

    end;


    procedure VendorQualityApprovalSpecId(): Code[20];
    var
        VendorItemQA: Record "Vendor Item Quality Approval";
        PurchHeader: Record "Purchase Header";
        PostingDate: Date;
    begin
        /*
        VendorItemQA.SETRANGE("Vendor No.","Buy-from Vendor No.");
        VendorItemQA.SETRANGE("Item No.","No.");
        IF VendorItemQA.FIND('-') THEN BEGIN
          PurchHeader.GET(PurchHeader."Document Type" :: Order,"Document No.");
          PostingDate := PurchHeader."Posting Date";
          REPEAT
            IF (PostingDate > VendorItemQA."Starting Date") AND (PostingDate < VendorItemQA."Ending Date") THEN
              EXIT(VendorItemQA."Spec Id");
          UNTIL VendorItemQA.NEXT = 0;
        END;
        */

    end;


    procedure CancelInspection(var QualityStatus: Text[50]);
    var
        IDS: Record "Inspection Datasheet Header";
        IDSL: Record "Inspection Datasheet Line";
        QILE: Record "Quality Item Ledger Entry";
        PIDS: Record "Posted Inspect DatasheetHeader";
        PIDSL: Record "Posted Inspect Datasheet Line";
    begin
        /*
        IF "Quality Before Receipt" = TRUE THEN BEGIN
          IDS.SETRANGE("Order No.","Document No.");
          IDS.SETRANGE("Purch Line No","Line No.");
          IF NOT IDS.FIND('-') THEN
            ERROR('You can not Cancel the Quality Bcoz the IDS is Alreadey Posted')
          ELSE BEGIN
            PIDS.TRANSFERFIELDS(IDS);
            PIDS."Quality Status" := PIDS."Quality Status" :: Cancel;
            PIDS.INSERT;
            IDS.DELETE;
            IDSL.SETRANGE("Document No.",IDS."No.");
            IF IDSL.FIND('-') THEN BEGIN
              REPEAT
                PIDSL.TRANSFERFIELDS(IDSL);
                PIDSL.INSERT;
              UNTIL IDSL.NEXT = 0;
              IDSL.DELETEALL;
            END;
            IF QualityStatus = 'Cancel' THEN BEGIN
              //"Quality Status" := "Quality Status" :: Cancel;
              "Quality Before Receipt" := FALSE;
              "Qty. Sending To Quality" := 0;
              "Qty. Sent To Quality" := 0;
              MODIFY;
            END;
          END;
        END ELSE BEGIN
          IDS.SETRANGE("Order No.","Document No.");
          IDS.SETRANGE("Purch Line No","Line No.");
          IF NOT IDS.FIND('-') THEN
            ERROR('You Can not Cancel the Quality Bcoz the IDS is Alreadey Posted')
          ELSE BEGIN
            PIDS.TRANSFERFIELDS(IDS);
            PIDS."Quality Status" := PIDS."Quality Status" :: Cancel;
            PIDS.INSERT;
            IDS.DELETE;
            IDSL.SETRANGE("Document No.",IDS."No.");
            IF IDSL.FIND('-') THEN BEGIN
              REPEAT
                PIDSL.TRANSFERFIELDS(IDSL);
                PIDSL.INSERT;
              UNTIL IDSL.NEXT = 0;
              IDSL.DELETEALL;
            END;
            QILE.SETRANGE("Document No.",IDS."Receipt No.");
            IF QILE.FIND('-') THEN
              QILE.DELETE;
            IF QualityStatus = 'Cancel' THEN BEGIN
              //"Quality Status" := "Quality Status" :: Cancel;
              "Qty. Sending To Quality" := 0;
              "Qty. Sent To Quality" := 0;
              MODIFY;
            END;
          END;
        END;
        */

    end;


    procedure CloseInspection(var QualityStatus: Text[50]);
    var
        IR: Record "Inspection Receipt Header";
        IRL: Record "Inspection Receipt Line";
        QILE: Record "Quality Item Ledger Entry";
    begin
        /*
        IR.SETRANGE("Order No.","Document No.");
        IR.SETRANGE("Purch Line No","Line No.");
        IR.SETFILTER(Status,'NO');
        IF NOT IR.FIND('-')THEN
          ERROR('Inspection Receipt not find')
        ELSE BEGIN
          IR.Status := TRUE;
          IR."Quality Status" := IR."Quality Status" :: Close;
          IR.MODIFY;
        END;
        QILE.SETRANGE("Document No.",IR."Receipt No.");
        IF QILE.FIND('-') THEN
          QILE.DELETE;
        IF QualityStatus = 'Cancel' THEN BEGIN
          //"Quality Status" := "Quality Status" :: "Short Close";
          "Qty. Sending To Quality" := 0;
          "Qty. Sent To Quality" := 0;
          MODIFY;
        END;
        */

    end;
}

