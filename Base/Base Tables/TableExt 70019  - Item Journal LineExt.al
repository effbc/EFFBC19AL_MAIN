tableextension 70019 ItemJournalLineExt extends "Item Journal Line"
{


    fields
    {
        modify("Item No.")
        {
            trigger OnBeforeValidate()
            var
                myInt: Integer;
            begin

                /*  IF Item.GET("Item No.") THEN BEGIN
                      IF (Item.Item_verified) THEN
                          ERROR('Item Should Not Be Adjusted');
                  END;*/

            end;
        }


            field(90002; "Description1"; Text[150])
            {
                DataClassification = CustomerContent;
            }
            field(90003; "Transport Method1"; Code[20])
            {
                DataClassification = CustomerContent;
            }
            field(90004; "Variant Code1"; Text[30])
            {
                DataClassification = CustomerContent;
            }
            field(90005; "Stop Code1"; Code[30])
            {
                DataClassification = CustomerContent;
            }
        field(60001; "Operation Description"; Text[50])
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60002; "Planed Setup Time"; Decimal)
        {
            Caption = 'Planed Setup Time';
            DecimalPlaces = 0 : 5;
            Description = 'B2B';
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(60003; "Planed Run Time"; Decimal)
        {
            Caption = 'Planed Run Time';
            DecimalPlaces = 0 : 5;
            Description = 'B2B';
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(60004; "Planed Wait Time"; Decimal)
        {
            Caption = 'Planed Wait Time';
            DecimalPlaces = 0 : 5;
            Description = 'B2B';
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(60005; "Planed Move Time"; Decimal)
        {
            Caption = 'Planed Move Time';
            DecimalPlaces = 0 : 5;
            Description = 'B2B';
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(60006; "Internal Rework"; Boolean)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60007; "QC Rework"; Boolean)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60008; "Quantity."; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60009; "Qty. Received"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Material Issue Line"."Received Quantity" WHERE("Material Issue Doc No" = FIELD("Document No."),
                                                                               "Line No." = FIELD("Line No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(60010; "Transfer Type"; Enum "Item Journal Line Enum")
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60011; "Shelf No."; Code[50])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60012; "Job No.2"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60013; "Job Budget Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60014; "Serial No. EFF"; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Prod. Order Comp Resource"."Serial No." WHERE("Prod. Order No." = FIELD("Order No."),
                                                                            "Prod. Order Line No." = FIELD("Order Line No."));
            DataClassification = CustomerContent;
        }
        field(60100; "ITL Doc No."; Code[20])
        {
            Caption = 'Prod. Ord No.';
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60101; "ITL Doc Line No."; Integer)
        {
            Caption = 'Prod. Ord Line No.';
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60103; "ITL Doc Ref Line No."; Integer)
        {
            Caption = 'Prod.Ord Comp. Line No.';
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60104; "Qty. At Location Code"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
            DataClassification = CustomerContent;
        }
        field(60105; "User ID"; Code[50])
        {
            Description = 'B2B,Rev01';
            Editable = false;
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(60106; Remarks; Text[250])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60107; "Output Jr Serial No."; Code[20])
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60108; "Finished Product Sr No"; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60109; "Issued Date Time"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(60110; "Reworked User Id"; Code[15])
        {
            TableRelation = IF (Type = CONST("Machine Center")) "Machine Center"
            ELSE
            IF (Type = CONST("Work Center")) "Work Center";
            DataClassification = CustomerContent;
        }
        field(60116; "Sales Order No"; Code[20])
        {
            Description = 'SH1.0';
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order));
            DataClassification = CustomerContent;
        }
        field(60117; "Sales Order Line No"; Integer)
        {
            Description = 'SH1.0';
            TableRelation = "Sales Line"."Line No." WHERE("Document No." = FIELD("Sales Order No"));
            DataClassification = CustomerContent;
        }
        field(60118; "Schedule Line No"; Integer)
        {
            Description = 'SH1.0';
            TableRelation = Schedule2."Line No." WHERE("Document No." = FIELD("Sales Order No"),
                                                        "Document Line No." = FIELD("Sales Order Line No"));
            DataClassification = CustomerContent;
        }
        field(80100; Assigned; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(90000; Level2; Integer)
        {
            Description = 'AJAY';
            DataClassification = CustomerContent;
        }
        field(90001; "Changed by User2"; Boolean)
        {
            Description = 'AJAY';
            DataClassification = CustomerContent;
        }
        field(33000251; "Quality Ledger Entry No."; Integer)
        {
            Description = 'QC1.2';
            TableRelation = "Quality Ledger Entry";
            DataClassification = CustomerContent;
        }
        field(33000252; "After Inspection"; Boolean)
        {
            Description = 'QC1.2';
            DataClassification = CustomerContent;
        }
        field(33000253; "Inspectin Receipt No."; Code[20])
        {
            Description = 'QC1.2';
            TableRelation = "Inspection Receipt Header"."No.";
            DataClassification = CustomerContent;
        }
        field(33000260; "Purch.Rcpt Line"; Integer)
        {
            Description = 'QC1.2';
            DataClassification = CustomerContent;
        }
        field(33000261; "QC Check"; Boolean)
        {
            Description = 'B2BQCCheck';
            DataClassification = CustomerContent;
        }
        field(50054; "Product Group Code Cust"; Code[20])
        {

            Caption = 'Product Group Code';
            DataClassification = CustomerContent;
        }
    }
    trigger OnAfterInsert()
    var
        myInt: Integer;
    begin
        if "Journal Batch Name" = 'MPR' then
            "Location Code" := 'MPR'
        else
            if "Journal Batch Name" = 'STR' then
                "Location Code" := 'STR'
            else
                if "Journal Batch Name" = 'SHF' then
                    "Location Code" := 'SHF';

    end;

    trigger OnBeforeModify()
    var
        myInt: Integer;
    begin
        //NSS 02 >>Begin
        "User ID" := UserId;
        //NSS 02 <<End
    end;






    PROCEDURE CreateInspectionDataSheets();
    VAR
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        InspectionDataSheets: Codeunit "Inspection Data Sheets";
    BEGIN
        if ProdOrderRoutingLine.Get(ProdOrderRoutingLine.Status::Released, "Order No.", "Routing Reference No.", "Routing No.",
          "Operation No.") then begin
            ProdOrderRoutingLine."Qty.To Produce" := "Output Quantity";
            //B2B 1.1
            if ProdOrderRoutingLine."Qty.To Produce" <> 0 then
                //B2B 1.1
                InspectionDataSheets.CreateInprocInspectDataSheet2(ProdOrderRoutingLine, Rec);//B2B sgs 040108
        end;
    END;




    PROCEDURE CopyScheduleItems();
    VAR
        Schedule: Record Schedule2;
        ProdOrder2: Record "Production Order";
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalLine2: Record "Item Journal Line";
        LineNo: Integer;
        Item: Record Item;
    BEGIN
        /*{
        IF (ItemJnlLine."Item No." = "Prod. Order Component"."Item No.") AND
           (LocationCode = ItemJnlLine."Location Code") AND
           (BinCode = ItemJnlLine."Bin Code")
        THEN BEGIN
          IF Item."Rounding Precision" > 0 THEN
            ItemJnlLine.VALIDATE(Quantity,ItemJnlLine.Quantity + ROUND(QtyToPost,Item."Rounding Precision",'>'))
          ELSE
            ItemJnlLine.VALIDATE(Quantity,ItemJnlLine.Quantity + ROUND(QtyToPost,0.00001));
          ItemJnlLine.MODIFY;
        END ELSE BEGIN
          ItemJnlLine.INIT;
          ItemJnlLine."Journal Template Name" := ToTemplateName;
          ItemJnlLine."Journal Batch Name" := ToBatchName;
          ItemJnlLine.SetUpNewLine(LastItemJnlLine);
          ItemJnlLine."Line No." := NextConsumpJnlLineNo;

          ItemJnlLine.VALIDATE("Entry Type",ItemJnlLine."Entry Type"::Consumption);
          ItemJnlLine.VALIDATE("Prod. Order No.","Prod. Order Component"."Prod. Order No.");
          ItemJnlLine.VALIDATE("Source No.",ProdOrderLine."Item No.");
          ItemJnlLine.VALIDATE("Posting Date",PostingDate);
          ItemJnlLine.VALIDATE("Item No.","Prod. Order Component"."Item No.");
          ItemJnlLine.VALIDATE("Unit of Measure Code","Prod. Order Component"."Unit of Measure Code");
          ItemJnlLine.Description := "Prod. Order Component".Description;
          IF Item."Rounding Precision" > 0 THEN
            ItemJnlLine.VALIDATE(Quantity,ROUND(QtyToPost,Item."Rounding Precision",'>'))
          ELSE
            ItemJnlLine.VALIDATE(Quantity,ROUND(QtyToPost,0.00001));
          ItemJnlLine.VALIDATE("Location Code",LocationCode);
          IF BinCode <> '' THEN
            ItemJnlLine.VALIDATE("Bin Code",BinCode);
          ItemJnlLine."Variant Code" := "Prod. Order Component"."Variant Code";
          ItemJnlLine."Prod. Order Line No." :=
            "Prod. Order Component"."Prod. Order Line No.";
          ItemJnlLine.VALIDATE("Prod. Order Comp. Line No.","Prod. Order Component"."Line No.");

          ItemJnlLine.INSERT;
          IF Item."Item Tracking Code" <> '' THEN
            ItemTrackingMgt.CopyItemTracking("Prod. Order Component".RowID1,ItemJnlLine.RowID1,FALSE);
        END;

        NextConsumpJnlLineNo := NextConsumpJnlLineNo + 10000;
        }*/
        ItemJournalLine2.Reset;
        ItemJournalLine2.SetRange("Journal Template Name", "Journal Template Name");
        ItemJournalLine2.SetRange("Journal Batch Name", "Journal Batch Name");
        if ItemJournalLine2.Find('+') then
            LineNo := ItemJournalLine2."Line No." + 10000
        else
            LineNo := 0;

        ProdOrder2.Reset;
        //EFFUPG Start
        //ProdOrder2.SETRANGE(Status,ProdOrder.Status::Released);
        ProdOrder2.SetRange(Status, ProdOrder2.Status::Released);
        //EFFUPG End
        ProdOrder2.SetRange("Sales Order No.", "Sales Order No");
        ProdOrder2.SetRange("Sales Order Line No.", "Sales Order Line No");
        ProdOrder2.SetRange(ProdOrder2."No.", "Order No.");
        if ProdOrder2.Find('-') then;

        Schedule.Reset;
        Schedule.SetRange("Document Type", Schedule."Document Type"::Order);
        Schedule.SetRange("Document No.", "Sales Order No");
        Schedule.SetRange("Document Line No.", "Sales Order Line No");
        if Schedule.Find('-') then begin
            Schedule.Next;
            repeat
                ItemJournalLine.Init;
                ItemJournalLine."Journal Template Name" := "Journal Template Name";
                ItemJournalLine."Journal Batch Name" := "Journal Batch Name";
                ItemJournalLine."Line No." := LineNo;
                //ItemJournalLine."Entry Type":=ItemJournalLine."Entry Type"::Consumption;
                ItemJournalLine.Validate("Entry Type", ItemJournalLine."Entry Type"::Consumption);
                ItemJournalLine.Validate("Order No.", ProdOrder2."No.");
                ItemJournalLine.Validate("Source No.", ProdOrder2."Source No.");
                ItemJournalLine.Validate("Posting Date", WorkDate);
                ItemJournalLine.Validate("Item No.", Schedule."No.");
                //EFFUPG Start
                //IF Item.GET(ProdOrder."Source No.") THEN;
                if Item.Get(ProdOrder2."Source No.") then;
                //EFFUPG End
                ItemJournalLine."Unit Cost" := Item."Avg Unit Cost";
                ItemJournalLine.Validate("Unit of Measure Code", Item."Base Unit of Measure");
                //ItemJournalLine.Description := Schedule.Description;
                ItemJournalLine."Posting Date" := WorkDate;
                ItemJournalLine."Location Code" := ProdOrder2."Location Code";
                ItemJournalLine."Document No." := ItemJournalLine2."Document No.";
                ItemJournalLine.Validate(Quantity, Schedule.Quantity);
                ItemJournalLine."Sales Order No" := Schedule."Document No.";
                ItemJournalLine."Sales Order Line No" := Schedule."Document Line No.";
                ItemJournalLine."Schedule Line No" := Schedule."Line No.";
                LineNo += 10000;
                ItemJournalLine.Insert;
            until Schedule.Next = 0;
        end;
    end;



    var
        CapacityLedgerEntry: Record "Capacity Ledger Entry";
        ProdOrderRoutingLine1: Record "Prod. Order Routing Line";



        CLE: Record "Capacity Ledger Entry";
        PostedMatIssHdr: Record "Posted Material Issues Header";
}

