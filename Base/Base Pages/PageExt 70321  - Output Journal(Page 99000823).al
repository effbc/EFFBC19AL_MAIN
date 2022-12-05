pageextension 70321 pageextension70000001 extends "Output Journal"
{
    // version NAVW19.00.00.50357,QC1.0,B2B1.0,RQC1.0,Rev01,SQL

    layout
    {

        //Unsupported feature: Change Editable on "Control 84". Please convert manually.


        //Unsupported feature: CodeModification on "Control 78.OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        ItemJnlMgt.LookupName(CurrentJnlBatchName,Rec);
        CurrPage.UPDATE(FALSE);
        ItemJnlMgt.CheckName(CurrentJnlBatchName,Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        IF ("Journal Batch Name"='PONE-RE')  OR ("Journal Batch Name"='PTWO-RE')  OR ("Journal Batch Name"='PONE-RE')  OR
           ("Journal Batch Name"='PFOUR-RE') OR ("Journal Batch Name"='MPR-RE')  THEN
         "Reworked User IdVisible" :=TRUE
        ELSE
         "Reworked User IdVisible" :=FALSE;
        */
        //end;
        addafter(CurrentJnlBatchName)
        {
            field("Divide-by-Qty."; "Divide-by-Qty.")
            {
                Caption = 'Divide by Qty.';
                DecimalPlaces = 0 : 5;
            }
        }
        addafter("Posting Date")
        {
            field("Source No."; "Source No.")
            {
                Editable = true;
            }
        }
        addafter("Document No.")
        {
            field("Reworked User Id"; "Reworked User Id")
            {
                Visible = "Reworked User IdVisible";
            }
        }
        addafter("Operation No.")
        {
            field("Work Center No."; "Work Center No.")
            {
            }
            field("QC Check"; "QC Check")
            {
            }
            field("Operation Description"; "Operation Description")
            {
            }
            field("Planed Run Time"; "Planed Run Time")
            {
            }
            field("Reason Code"; "Reason Code")
            {
            }
            field("<Location Code 2>"; "Location Code")
            {
            }
        }
        addafter("Bin Code")
        {
            field("QC Rework"; "QC Rework")
            {
            }
            field("Internal Rework"; "Internal Rework")
            {
            }
        }
        addafter("Document Date")
        {
            field("Output Jr Serial No."; "Output Jr Serial No.")
            {
                Editable = true;
                Enabled = true;

                trigger OnLookup(var Text: Text): Boolean;
                var
                    ILE: Record 32;
                begin
                    ILE.RESET;
                    ILE.SETCURRENTKEY("Item No.", "Order No.", "Order Line No.", "Prod. Order Comp. Line No.", "Entry Type");
                    ILE.SETFILTER(ILE."Entry Type", '%1', ILE."Entry Type"::Consumption);
                    ILE.SETRANGE(ILE."Order No.", "Order No.");
                    ILE.SETRANGE("Order Line No.", "Order Line No.");
                    IF ILE.FINDFIRST THEN
                        IF PAGE.RUNMODAL(0, ILE) = ACTION::LookupOK THEN
                            "Output Jr Serial No." := ILE."Serial No.";
                    IDS.SETRANGE("Prod. Order No.", "Order No.");
                    IDS.SETRANGE("Prod. Order Line", "Order Line No.");
                    IF IDS.FINDFIRST THEN
                        IF "Output Jr Serial No." = IDS."OutPut Jr Serial No." THEN BEGIN
                            "Output Jr Serial No." := '';
                            ERROR(Text041, IDS."No.");
                        END;
                    IR.SETRANGE("Prod. Order No.", "Order No.");
                    IR.SETRANGE("Prod. Order Line", "Order Line No.");
                    IF IR.FINDFIRST THEN
                        IF "Output Jr Serial No." = IR."OutPut Jr Serial No." THEN BEGIN
                            "Output Jr Serial No." := '';
                            ERROR(Text042, IR."No.");
                        END;
                    OutPutJournal.RESET;
                    OutPutJournal.SETRANGE("Entry Type", OutPutJournal."Entry Type"::Output);
                    OutPutJournal.SETRANGE("Order No.", "Order No.");
                    OutPutJournal.SETRANGE("Order Line No.", "Order Line No.");
                    OutPutJournal.SETRANGE("Output Jr Serial No.", "Output Jr Serial No.");
                    IF OutPutJournal.FINDFIRST THEN
                        IF "Output Jr Serial No." = OutPutJournal."Output Jr Serial No." THEN BEGIN
                            "Output Jr Serial No." := '';
                            ERROR(Text043);
                        END;
                end;

                trigger OnValidate();
                begin
                    OutputJrSerialNoOnAfterValidat;
                end;
            }
            field("Finished Product Sr No"; "Finished Product Sr No")
            {
            }
        }
        addafter("External Document No.")
        {
            field("Order Type"; "Order Type")
            {
            }
        }
        addafter(OperationName)
        {
            group("Work Date")
            {
                Caption = 'Work Date';
                field(WorkDate; WORKDATE)
                {
                    Editable = false;
                }
            }

        }
    }
    actions
    {

        //Unsupported feature: Change Level on "Action 31". Please convert manually.



        //Unsupported feature: CodeInsertion on "Post(Action 56).OnAction". Please convert manually.

        //trigger (Variable: ProductionOrderNo)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on "Post(Action 56).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostingItemJnlFromProduction(FALSE);
        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
        CurrPage.UPDATE(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        {
        //B2B
        ProdOrderRoutingLine1.SETRANGE("Prod. Order No.","Prod. Order No.");
        ProdOrderRoutingLine1.SETRANGE("Routing Reference No.","Prod. Order Line No.");
        ProdOrderRoutingLine1.SETRANGE("Operation No.","Operation No.");
        IF ProdOrderRoutingLine1.FINDFIRST THEN BEGIN
          IF ProdOrderRoutingLine1."Previous Operation No." <> ''  THEN BEGIN
            CapacityLedgerEntry.SETRANGE("Prod. Order No.","Prod. Order No.");
            CapacityLedgerEntry.SETRANGE("Routing Reference No.","Prod. Order Line No.");
            CapacityLedgerEntry.SETRANGE("Operation No.","Operation No.");
            IF NOT CapacityLedgerEntry.FINDFIRST THEN
              ERROR('Post the Previous Entry First')
          END;
        END;
        //B2B
        }
        {
        //ADDED by Pranavi on 16-05-2015 to restrict the posting if there are pending material issues
        IF NOT (USERID IN [{'EFFTRONICS\PRANAVI',}'EFFTRONICS\ANILKUMAR'{,'EFFTRONICS\GRAVI'}]) THEN
          BEGIN
          ItmJrnalLine.RESET;
          ItmJrnalLine.COPYFILTERS(Rec);
          ItmJrnalLine.SETRANGE(ItmJrnalLine."Journal Batch Name","Journal Batch Name");
          IF ItmJrnalLine.FINDSET THEN
          REPEAT
            IF (ItmJrnalLine."Order Line No."=10000) AND (ItmJrnalLine."Operation No."='9999') THEN
            BEGIN
              prodOrdrComp.RESET;
              prodOrdrComp.SETFILTER(prodOrdrComp."Prod. Order No.",ItmJrnalLine."Order No.");
              IF prodOrdrComp.FINDSET THEN
              REPEAT
                Itm.RESET;
                Itm.SETFILTER(Itm."No.",prodOrdrComp."Item No.");
                IF Itm.FINDFIRST THEN
                BEGIN
                  IF (NOT (Itm."Product Group Code" IN ['CPCB','FPRODUCT','STATIONARY'])) AND (NOT (Itm."No." IN ['MECLPSS00029','CONADHE00012'])) THEN
                  BEGIN
                    IF Itm."Dispatch Material"<> TRUE THEN
                    BEGIN
                      PostedMatIssLine.RESET;
                      PostedMatIssLine.SETCURRENTKEY("Prod. Order No.","Prod. Order Line No.","Item No.");
                      PostedMatIssLine.SETFILTER(PostedMatIssLine."Item No.",'%1',Itm."No.");
                      PostedMatIssLine.SETFILTER(PostedMatIssLine."Prod. Order No.",'%1',ItmJrnalLine."Order No.");
                      //PostedMatIssLine.SETFILTER(PostedMatIssLine."Prod. Order Line No.",'%1',prodOrdrComp."Prod. Order Line No.");
                      //PostedMatIssLine.SETFILTER(PostedMatIssLine."Prod. Order Comp. Line No.",'%1',prodOrdrComp."Line No.");
                      IF PostedMatIssLine.FINDFIRST THEN
                      BEGIN
                        MatIssLine.RESET;
                        MatIssLine.SETCURRENTKEY("Item No.","Prod. Order No.","Prod. Order Line No.");
                        MatIssLine.SETFILTER(MatIssLine."Item No.",'%1',Itm."No.");
                        MatIssLine.SETFILTER(MatIssLine."Prod. Order No.",'%1',ItmJrnalLine."Order No.");
                        //MatIssLine.SETFILTER(MatIssLine."Prod. Order Line No.",'%1',prodOrdrComp."Prod. Order Line No.");
                        //MatIssLine.SETFILTER(MatIssLine."Prod. Order Comp. Line No.",'%1',prodOrdrComp."Line No.");
                        IF MatIssLine.FINDFIRST THEN
                          ERROR('You Cannot post Order: '+ItmJrnalLine."Order No."+' Becauase there are pending Material issues on item \'+Itm."No."+' of this order!');
                      END
                      ELSE
                      BEGIN
                        MatIssLine.RESET;
                        MatIssLine.SETCURRENTKEY("Item No.","Prod. Order No.","Prod. Order Line No.");
                        MatIssLine.SETFILTER(MatIssLine."Item No.",Itm."No.");
                        MatIssLine.SETFILTER(MatIssLine."Prod. Order No.",ItmJrnalLine."Order No.");
                        //MatIssLine.SETFILTER(MatIssLine."Prod. Order Line No.",'%1',prodOrdrComp."Prod. Order Line No.");
                        //MatIssLine.SETFILTER(MatIssLine."Prod. Order Comp. Line No.",'%1',prodOrdrComp."Line No.");
                        IF MatIssLine.FINDFIRST THEN
                          ERROR('You Cannot post Order: '+ItmJrnalLine."Order No."+' Becauase there are no Material Req Created on item \'+Itm."No."+'--'+Itm.Description+' of this order!')
                        ELSE
                          ERROR('You Cannot post Order: '+ItmJrnalLine."Order No."+' Becauase there are pending issues on item \'+Itm."No."+'--'+Itm.Description+'for this order!');
                      END;
                    END;  //Dispatch Mat check_end
                  END;    //PGC Checking_End
                END;      //Item finding_End
              UNTIL prodOrdrComp.NEXT=0;
              {
              PostedMatIssHdr.RESET;
              PostedMatIssHdr.SETFILTER(PostedMatIssHdr."Prod. Order No.",ItmJrnalLine."Order No.");
              IF PostedMatIssHdr.FINDFIRST THEN
              BEGIN
                MatIssHdr.RESET;
                MatIssHdr.SETFILTER(MatIssHdr."Prod. Order No.",ItmJrnalLine."Order No.");
                IF MatIssHdr.FINDFIRST THEN
                  ERROR('You Cannot post Order: '+ItmJrnalLine."Order No."+' Becauase there are pending issues for this order!');
              END
              ELSE
                ERROR('You Cannot post Order: '+ItmJrnalLine."Order No."+' Becauase there are pending issues for this order!');
              }
            END;    //10000 line number check End
          UNTIL ItmJrnalLine.NEXT=0;
        END;  //UserIDCheck_End
        //End by pranavi
        }
        IF (("Journal Batch Name"='MPROJ') OR ("Journal Batch Name"='MPRTHREEOJ')  OR  ("Journal Batch Name"='MPRTWOOJ'))
           AND ("Order Line No."=10000) THEN
        BEGIN
          ItemJnlLine.SETFILTER(ItemJnlLine."Journal Batch Name",'MPROJ');
          IF ItemJnlLine.FINDSET THEN
          REPEAT
            reservationEntry.RESET;
            reservationEntry.SETCURRENTKEY(reservationEntry."Item No.",reservationEntry."Variant Code",reservationEntry."Location Code",
                                           reservationEntry."Source Type",reservationEntry."Source Subtype",
                                           reservationEntry."Reservation Status",reservationEntry."Expected Receipt Date");
            reservationEntry.SETRANGE(reservationEntry."Item No.",ItemJnlLine."Item No.");
            reservationEntry.SETRANGE(reservationEntry."Location Code",'PROD');
            reservationEntry.SETFILTER(reservationEntry."Source Type",'83');
            reservationEntry.SETRANGE(reservationEntry."Source Ref. No.",ItemJnlLine."Line No.");
            IF reservationEntry.FINDSET THEN
            REPEAT
              IDS.SETRANGE(IDS."Prod. Order No.",ItemJnlLine."Order No.");
              IF IDS.FINDSET THEN
              REPEAT
                IDS."Finished Product Sr No":=reservationEntry."Serial No.";
                IDS.MODIFY;
              UNTIL IDS.NEXT=0;

            UNTIL reservationEntry.NEXT=0;
          UNTIL ItemJnlLine.NEXT=0;
        END;

        {
        // Verification For Consumption Posting for Production Orders

        IF (("Journal Batch Name"='MPROJ') OR ("Journal Batch Name"='MPRTHREEOJ')  OR  ("Journal Batch Name"='MPRTWOOJ') )THEN
        BEGIN
          ItemJnlLine.RESET;
          ItemJnlLine.SETFILTER(ItemJnlLine."Journal Batch Name","Journal Batch Name");
          ItemJnlLine.SETRANGE(ItemJnlLine."Prod. Order Line No.",10000);
          IF ItemJnlLine.FINDSET THEN
          REPEAT
            "Prod. Order Line".RESET;
            "Prod. Order Line".SETRANGE("Prod. Order Line"."Prod. Order No.",ItemJnlLine."Prod. Order No.");
            "Prod. Order Line".SETFILTER("Prod. Order Line"."Line No.",'<>%1',10000);
            IF "Prod. Order Line".FINDSET THEN
            REPEAT
              COnsume_Qty:=0;
              ItemLedgerEntry.RESET;
              ItemLedgerEntry.SETCURRENTKEY(ItemLedgerEntry."Prod. Order No.",ItemLedgerEntry."Prod. Order Line No.",
                                            ItemLedgerEntry."Prod. Order Comp. Line No.",ItemLedgerEntry."Entry Type",
                                            ItemLedgerEntry."Location Code");
              ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Prod. Order No.","Prod. Order Line"."Prod. Order No.");
              ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.","Prod. Order Line"."Item No.");
              ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Entry Type",'Consumption');
              IF ItemLedgerEntry.FINDSET THEN
              REPEAT
                COnsume_Qty-=ItemLedgerEntry.Quantity;
              UNTIL ItemLedgerEntry.NEXT=0;
              IF COnsume_Qty<>"Prod. Order Line".Quantity THEN
              BEGIN
                MESSAGE(FORMAT(COnsume_Qty));
                MESSAGE(FORMAT("Prod. Order Line".Quantity));
                ERROR('PLEASE CONSUME THE '+"Prod. Order Line".Description+ 'CARDS IN '+"Prod. Order Line"."Prod. Order No.");
              END;
            UNTIL "Prod. Order Line".NEXT=0;
          UNTIL ItemJnlLine.NEXT=0;
        END;
            }
        // Reowrk Calculation
        IF (("Journal Batch Name"='PFOUR-RE') OR ("Journal Batch Name"='PONE-RE')  OR  ("Journal Batch Name"='PTHREE-RE')
             OR  ("Journal Batch Name"='PTWO-RE'))  AND ("Order Line No."=10000) THEN
        BEGIN
          ItemJnlLine.SETFILTER(ItemJnlLine."Journal Batch Name","Journal Batch Name");
          IF ItemJnlLine.FINDSET THEN
          REPEAT
             IF ItemJnlLine."Reworked User Id"='' THEN
                ERROR(' THERE IS NO REWORK USER ID FOR LINE NO.' +FORMAT(ItemJnlLine."Line No."));
          UNTIL ItemJnlLine.NEXT=0;
        END;




        //B2B
        {
        ItemJrnlLineRec.RESET;
        ItemJrnlLineRec.SETRANGE("Journal Template Name","Journal Template Name");
        ItemJrnlLineRec.SETRANGE("Journal Batch Name","Journal Batch Name");
        IF ItemJrnlLineRec.FINDFIRST THEN
         IF ItemJrnlLineRec.Quantity > 1 THEN
          ERROR(Text040);
        //B2B
        }
        ProductionOrderNo := Rec."Order No.";
        ItemNo := Rec."Item No.";
        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",Rec);
        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
        reservationEntry.RESET;
        reservationEntry.SETRANGE(reservationEntry."Item No.",ItemNo);
        reservationEntry.SETRANGE(reservationEntry."Source ID",ProductionOrderNo);
        IF reservationEntry.FINDSET THEN
        REPEAT
            ReservEngineMgt.CancelReservation(reservationEntry);
        UNTIL reservationEntry.NEXT = 0;
        reservationEntry.RESET;
        reservationEntry.SETRANGE(reservationEntry."Item No.",ItemNo);
        reservationEntry.SETRANGE(reservationEntry."Source ID",ProductionOrderNo);
        IF reservationEntry.FINDSET THEN
        REPEAT
            reservationEntry.DELETE;
        UNTIL reservationEntry.NEXT = 0;
        CurrPage.UPDATE(FALSE);
        */
        //end;
        addafter("&Line")
        {

            action("&Expode Rework  Routing")
            {
                Caption = '&Expode Rework  Routing';
                Image = ExplodeRouting;
                RunObject = Codeunit 33000256;
            }

            action("Claculate Qty.")
            {
                Caption = 'Claculate Qty.';
                Image = CalculateInventory;

                trigger OnAction();
                begin
                    ItemJrnlLineRec.SETRANGE("Journal Template Name", "Journal Template Name");
                    ItemJrnlLineRec.SETRANGE("Journal Batch Name", "Journal Batch Name");
                    IF ItemJrnlLineRec.FINDSET THEN
                        REPEAT
                            IF (ItemJrnlLineRec.Quantity > 1) AND ("Divide-by-Qty." <> 0) THEN BEGIN
                                ItemJrnlLineRec.VALIDATE("Output Quantity", (ItemJrnlLineRec."Output Quantity" / "Divide-by-Qty."));
                                ItemJrnlLineRec.MODIFY;
                            END;
                        UNTIL ItemJrnlLineRec.NEXT = 0;
                    "Divide-by-Qty." := 0;
                    CurrPage.UPDATE(FALSE);
                end;
            }
            action("Get Rework Data From PRM")
            {
                Caption = 'Get Rework Data From PRM';
                Image = ExplodeRouting;

                trigger OnAction();
                begin
                    TESTFIELD("Journal Batch Name", 'PONE-RE');
                    "Reworked Date" := "Posting Date";
                    MESSAGE(FORMAT("Reworked Date"));




                    WebRecStatus := Quotes + Text50001 + Quotes;
                    OldWebStatus := Quotes + Text50002 + Quotes;


                    //SQLConnection.ConnectionString := 'DSN=PRMUSER;UID=PRMUSER;PASSWORD=mrpffe06;SERVER=oracle_80;';
                    //SQLConnection.Open;
                    MESSAGE('Oracle Connected');

                    //SQLConnection.BeginTrans;
                    /*
                    SQLQuery :='SELECT trans_id,a.pcb_id,DESCRIPTION,SERIALNO,'+
                                      'TO_CHAR( EMP_ID ) REWORK_PERSON,'+
                                      'TO_CHAR( DATALOGGER_ID ) PRODUCTION_ORDER,'+
                                      'TO_CHAR(ITL_DOC_LINE_NO) PRODUCTION_ORDER_LINE_NO '+
                               'FROM   PRM_LOGOFENTRIES a,PRM_PCB_MASTER b, ERP_ITEM_LEDGER_ENTRY1 c '+
                               'WHERE  a.pcb_id =b.pcb_id and STATUS_CODE= 2 and '+
                                      'trunc(SWIPETIME)='''+FORMAT("Reworked Date",0,'<Day>/<Month Text,3>/<Year4>')+''' and '+
                                      'SERIAL_NO=serialno and '+
                                      'ITL_DOC_NO=DATALOGGER_ID and '+
                                      'a.pcb_id in( '+
                               'select distinct PCB_id '+
                               'from PRM_DEFECTENTRIES '+
                               'where DEFECT_NO<>0 and QC_PASSED<>1) '+
                               'minus ';
                    SQLQuery2:='select trans_id,a.pcb_id,EMP_ID offer_Person, DESCRIPTION, DATALOGGER_ID, SERIALNO,'+
                               ' TO_CHAR(ITL_DOC_LINE_NO) PRODUCTION_ORDER_LINE_NO '+
                               'from PRM_LOGOFENTRIES a,PRM_PCB_MASTER b, ERP_ITEM_LEDGER_ENTRY1 c '+
                               'where a.pcb_id =b.pcb_id and '+
                                     'STATUS_CODE= 2 and '+
                                     'trunc(SWIPETIME)='''+FORMAT("Reworked Date",0,'<Day>/<Month Text,3>/<Year4>')+'''  and '+
                                     'SERIAL_NO=serialno and '+
                                     'ITL_DOC_NO=DATALOGGER_ID and '+
                                     'a.pcb_id in( '+
                               'select distinct PCB_id '+
                               'From   PRM_DEFECTENTRIES '+
                               'where  DEFECT_NO<>0 and '+
                                      'QC_PASSED<>1) and '+
                                      'trans_id  in( '+
                               'select Min(Trans_id) '+
                               'from   PRM_LOGOFENTRIES '+
                               'where  trunc(SWIPETIME)='''+FORMAT("Reworked Date",0,'<Day>-<Month Text,3>-<Year4>')+''' and '+
                                      'STATUS_CODE= 2 group by pcb_id) '+
                                      'order by 2,1  ';
                                                                */
                    SQLQuery := 'SELECT trans_id,a.pcb_id,DESCRIPTION,SERIALNO, ' +
                              'TO_CHAR( EMP_ID ) REWORK_PERSON,' +
                              'TO_CHAR( DATALOGGER_ID ) PRODUCTION_ORDER,' +
                              'TO_CHAR(ITL_DOC_LINE_NO) PRODUCTION_ORDER_LINE_NO ' +
                              'FROM  (select * from PRM_LOGOFENTRIES where STATUS_CODE= 2  minus ' +
                              'select * from PRM_LOGOFENTRIES where trans_id in(select Min(TRANS_ID) from   PRM_LOGOFENTRIES WHERE ' +
                              '  STATUS_CODE= 2 group by pcb_id)) a,PRM_PCB_MASTER b, ERP_ITEM_LEDGER_ENTRY1 c where ' +
                    ' a.pcb_id =b.pcb_id and STATUS_CODE= 2 and trunc(SWIPETIME)= ''' + FORMAT("Reworked Date", 0, '<Day>-<Month Text,3>-<Year4>') + '''' +
                      ' and SERIAL_NO=serialno and ' +
                      'ITL_DOC_NO=DATALOGGER_ID and a.pcb_id in( select distinct PCB_id from PRM_DEFECTENTRIES where DEFECT_NO<>0 and QC_PASSED<>1) ';


                    /*RecordSet := SQLConnection.Execute(SQLQuery + SQLQuery2);

                    IF NOT (RecordSet.EOF OR RecordSet.BOF) THEN
                        RecordSet.MoveFirst;
                    I := 1;*/
                    //WHILE NOT RecordSet.EOF DO BEGIN
                    I += 1;
                    // MESSAGE(FORMAT(RecordSet.Fields.Item('PRODUCTION_ORDER_LINE_NO').Value));
                    //   EVALUATE(Prod_Order_Line_No,FORMAT(RecordSet.Fields.Item('PRODUCTION_ORDER_LINE_NO').Value));
                    Machine_Center.RESET;
                    //Machine_Center.SETRANGE(Machine_Center."No.", FORMAT(RecordSet.Fields.Item('REWORK_PERSON').Value));
                    IF Machine_Center.FINDFIRST THEN BEGIN
                        ItemJrnlLineRec.INIT;
                        ItemJrnlLineRec."Journal Template Name" := 'OUTPUT';
                        ItemJrnlLineRec."Journal Batch Name" := 'PONE-RE';
                        ItemJrnlLineRec."Posting Date" := "Reworked Date";
                        ItemJrnlLineRec."Document Date" := "Reworked Date";
                        ItemJrnlLineRec."Line No." := I * 10000;
                        MfgSetup.GET;
                        IF ItemJnlBatch.GET("Journal Template Name", ItemJrnlLineRec."Journal Batch Name") THEN
                            ItemJrnlLineRec."Document No." := NoSeriesMgt.GetNextNo(ItemJnlBatch."No. Series", ItemJrnlLineRec."Posting Date", FALSE);
                        ItemJrnlLineRec."Entry Type" := ItemJrnlLineRec."Entry Type"::Output;
                        ItemJrnlLineRec."Location Code" := 'PROD';
                        //ItemJrnlLineRec."Order No." := FORMAT(RecordSet.Fields.Item('PRODUCTION_ORDER').Value);
                        //ItemJrnlLineRec.VALIDATE(ItemJrnlLineRec."Order No.", FORMAT(RecordSet.Fields.Item('PRODUCTION_ORDER').Value));
                        //EVALUATE(Prod_Order_Line_No, FORMAT(RecordSet.Fields.Item('PRODUCTION_ORDER_LINE_NO').Value));
                        ItemJrnlLineRec."Order Line No." := Prod_Order_Line_No;
                        ItemJrnlLineRec.VALIDATE(ItemJrnlLineRec."Order Line No.", Prod_Order_Line_No);
                        "Prod. Order Line".RESET;
                        "Prod. Order Line".SETRANGE("Prod. Order Line"."Prod. Order No.", ItemJrnlLineRec."Order No.");
                        "Prod. Order Line".SETRANGE("Prod. Order Line"."Line No.", ItemJrnlLineRec."Order Line No.");
                        IF "Prod. Order Line".FINDFIRST THEN BEGIN
                            ItemJrnlLineRec."Source No." := "Prod. Order Line"."Item No.";
                            ItemJrnlLineRec.VALIDATE(ItemJrnlLineRec."Source No.", "Prod. Order Line"."Item No.");
                            ItemJrnlLineRec."Item No." := "Prod. Order Line"."Item No.";
                            ItemJrnlLineRec.VALIDATE(ItemJrnlLineRec."Item No.", "Prod. Order Line"."Item No.");
                            ItemJrnlLineRec."Routing No." := "Prod. Order Line"."Item No.";
                            ItemJrnlLineRec.VALIDATE(ItemJrnlLineRec."Routing No.", "Prod. Order Line"."Item No.");
                            ItemJrnlLineRec."Routing Reference No." := ItemJrnlLineRec."Order Line No.";
                        END;
                        ItemJrnlLineRec."Source Code" := 'POINOUTJNL';
                        ItemJrnlLineRec."Source Type" := ItemJrnlLineRec."Source Type"::Item;
                        ItemJrnlLineRec."Gen. Prod. Posting Group" := 'MANF';
                        ItemJrnlLineRec.Quantity := 1;
                        ItemJrnlLineRec."Quantity (Base)" := 1;
                        ProdOrderRoutingLine1.RESET;
                        ProdOrderRoutingLine1.SETRANGE(ProdOrderRoutingLine1."Prod. Order No.", "Prod. Order Line"."Prod. Order No.");
                        ProdOrderRoutingLine1.SETRANGE(ProdOrderRoutingLine1."Routing Reference No.", "Prod. Order Line"."Line No.");
                        ProdOrderRoutingLine1.SETRANGE(ProdOrderRoutingLine1."Operation Description", 'PCB Soldering');
                        IF ProdOrderRoutingLine1.FINDFIRST THEN BEGIN
                            ItemJrnlLineRec.VALIDATE(ItemJrnlLineRec."Operation No.", ProdOrderRoutingLine1."Operation No.");
                            IF ("Prod. Order Line"."Prod. Order No." = 'USB08DLR04') AND ("Prod. Order Line"."Line No." = 20000) THEN
                                MESSAGE(FORMAT(ProdOrderRoutingLine1."Operation No."));

                        END ELSE
                            ERROR(' THERE IS NO SOLDERING ACTVITY FOR : Production Order:' + "Prod. Order Line"."Prod. Order No." +
                        'Production Order Line No:' +
                                                             FORMAT("Prod. Order Line"."Line No."));
                        ItemJrnlLineRec."Output Quantity" := 1;
                        ItemJrnlLineRec.VALIDATE(ItemJrnlLineRec."Output Quantity", 1);

                        ItemJrnlLineRec.Type := ItemJrnlLineRec.Type::"Machine Center";
                        //ItemJrnlLineRec."No." := FORMAT(RecordSet.Fields.Item('REWORK_PERSON').Value);
                        //ItemJrnlLineRec.VALIDATE(ItemJrnlLineRec."No.", FORMAT(RecordSet.Fields.Item('REWORK_PERSON').Value));
                        ItemJrnlLineRec."Operation No." := ProdOrderRoutingLine1."Operation No.";
                        ItemJrnlLineRec."User ID" := USERID;
                        ItemJrnlLineRec.INSERT;
                    END;
                    //RecordSet.MoveNext;
                    //END;
                    MESSAGE(FORMAT(I));


                    /*SQLConnection.CommitTrans;
                    SQLConnection.Close;*/

                end;
            }
            action("Assign Serial No.'s")
            {
                Caption = 'Assign Serial No.''s';
                Image = CreateSerialNo;
                ToolTip = 'Assign Serial No.''s';

                trigger OnAction();
                var
                    ILE: Record 32;
                    ItemRec: Record 27;
                    PCBItemNo: Code[20];
                    ILE2: Record 32;
                    ReservationEntry: Record 337;
                    ReservationEntryRec: Record 337;
                    EntryNo: Integer;
                begin
                    AgainstOperation;
                    //NSS 030907
                    ILE.SETCURRENTKEY("Order No.", "Order Line No.", "Prod. Order Comp. Line No.", "Entry Type");
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Consumption);
                    ILE.SETRANGE("Order No.", "Order No.");
                    ILE.SETRANGE("Order Line No.", "Routing Reference No.");
                    IF ILE.FINDFIRST THEN
                        REPEAT
                            IF ItemRec.GET(ILE."Item No.") THEN
                                IF ItemRec.PCB = TRUE THEN
                                    PCBItemNo := ILE."Item No."
                                ELSE
                                    PCBItemNo := '';
                        UNTIL (ILE.NEXT = 0) OR (ItemRec.PCB = TRUE);

                    ILE2.SETCURRENTKEY("Item No.", "Order No.", "Order Line No.", "Prod. Order Comp. Line No.", "Entry Type");
                    IF ItemRec.GET(PCBItemNo) THEN BEGIN
                        TempILE2.DELETEALL;
                        TempILE2.RESET;
                        ILE2.SETRANGE(ILE2."Entry Type", ILE2."Entry Type"::Consumption);
                        ILE2.SETRANGE("Order No.", "Order No.");
                        ILE2.SETRANGE("Order Line No.", "Routing Reference No.");
                        ILE2.SETRANGE("Item No.", PCBItemNo);
                        IF ILE2.FINDSET THEN
                            REPEAT
                                TempILE2.INIT;
                                TempILE2.COPY(ILE2);
                                TempILE2.INSERT;
                            UNTIL ILE2.NEXT = 0;
                    END;
                    ItemJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
                    ItemJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
                    ItemJnlLine.SETRANGE("Operation No.", OperationNo);
                    IF ItemJnlLine.FINDFIRST THEN
                        OperationLineNo := ItemJnlLine."Line No.";
                    ReservationEntryRec.RESET;
                    IF ReservationEntryRec.FINDLAST THEN
                        EntryNo := ReservationEntryRec."Entry No." + 1
                    ELSE
                        EntryNo := 1;
                    IF TempILE2.FINDSET THEN
                        REPEAT
                            SerialNo := '';
                            AssignInprocessSerialNo(TempILE2."Serial No.");
                            ReservationEntry.INIT;
                            ReservationEntry."Entry No." := EntryNo;
                            ReservationEntry."Created By" := USERID;
                            ReservationEntry."Creation Date" := WORKDATE;
                            ReservationEntry.VALIDATE(Positive, TRUE);
                            ReservationEntry.VALIDATE("Item No.", "Item No.");
                            ReservationEntry.VALIDATE("Location Code", "Location Code");
                            ReservationEntry.VALIDATE("Reservation Status", ReservationEntry."Reservation Status"::Prospect);
                            ReservationEntry."Creation Date" := WORKDATE;
                            ReservationEntry.VALIDATE("Source Type", 83);
                            ReservationEntry.VALIDATE("Source Subtype", 6);
                            ReservationEntry.VALIDATE("Source ID", "Journal Template Name");
                            ReservationEntry.VALIDATE("Source Batch Name", "Journal Batch Name");
                            ReservationEntry.VALIDATE("Source Ref. No.", OperationLineNo);
                            ReservationEntry.VALIDATE("Expected Receipt Date", WORKDATE);
                            ReservationEntry.VALIDATE("Serial No.", SerialNo);
                            ReservationEntry.VALIDATE("Quantity (Base)", ABS(TempILE2.Quantity));
                            ReservationEntry.VALIDATE("Qty. per Unit of Measure", "Qty. per Unit of Measure");
                            ReservationEntry.VALIDATE("Suppressed Action Msg.", FALSE);
                            ReservationEntry.VALIDATE("Planning Flexibility", ReservationEntry."Planning Flexibility"::Unlimited);
                            ReservationEntry.INSERT;
                            EntryNo := EntryNo + 1;
                        UNTIL TempILE2.NEXT = 0
                    //NSS 030907
                end;
            }
            action("Assign PCB Serial No's")
            {
                Caption = 'Assign PCB Serial No''s';
                Image = SerialNo;
                ShortCutKey = 'Ctrl+s';
                ToolTip = 'Assign PCB Serial No''s';

                trigger OnAction();
                var
                    EntryNo: Integer;
                begin
                    IF ("Journal Batch Name" = 'MPROJ') OR ("Journal Batch Name" = 'MPRTHREEOJ') OR ("Journal Batch Name" = 'MPRTWOOJ')
                    OR ("Journal Batch Name" = 'PONE-OJ') THEN BEGIN
                        ItemJnlLine.SETFILTER(ItemJnlLine."Journal Batch Name", "Journal Batch Name");
                        IF ItemJnlLine.FINDSET THEN
                            REPEAT

                            //IF (ItemJnlLine."Operation No."='9999') AND (ItemJnlLine."Prod. Order Line No."<>10000) THEN
                            BEGIN

                                Prod_Qty := 0;
                                reservationEntry.RESET;
                                IF reservationEntry.FINDLAST THEN
                                    EntryNo := reservationEntry."Entry No." + 1
                                ELSE
                                    EntryNo := 1;

                                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Entry Type", 'Transfer');
                                ItemLedgerEntry.SETCURRENTKEY(ItemLedgerEntry."Item No.",
                                                              ItemLedgerEntry."Lot No.",
                                                              ItemLedgerEntry."ITL Doc No.",
                                                              ItemLedgerEntry."Entry No.");
                                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."ITL Doc No.", ItemJnlLine."Order No.");
                                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."ITL Doc Line No.", ItemJnlLine."Order Line No.");
                                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Remaining Quantity", '>%1', 0);
                                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Product Group Code cust", 'PCB');
                                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Location Code", 'PROD');
                                IF ItemLedgerEntry.FINDSET THEN
                                    REPEAT

                                        //ItemLedgerEntry2.SETCURRENTKEY(ItemLedgerEntry2."Item No.",ItemLedgerEntry2."Order No.",ItemLedgerEntry2."Entry Type"
                                        //);
                                        ItemLedgerEntry2.SETCURRENTKEY(ItemLedgerEntry2."Item No.", ItemLedgerEntry2."Entry Type");

                                        ItemLedgerEntry2.SETRANGE(ItemLedgerEntry2."Item No.", ItemLedgerEntry."Item No.");
                                        ItemLedgerEntry2.SETRANGE(ItemLedgerEntry2."Order No.", ItemLedgerEntry."ITL Doc No.");
                                        ItemLedgerEntry2.SETFILTER(ItemLedgerEntry2."Entry Type", 'Output');
                                        IF NOT (ItemLedgerEntry2.FINDFIRST) THEN BEGIN

                                            Prod_Qty += 1;
                                            IF Prod_Qty <= ItemJnlLine.Quantity THEN BEGIN
                                                EntryNo += 1;
                                                reservationEntry.INIT;
                                                reservationEntry."Entry No." := EntryNo;
                                                reservationEntry."Created By" := USERID;
                                                reservationEntry."Creation Date" := WORKDATE;

                                                reservationEntry.Positive := TRUE;
                                                reservationEntry."Item No." := ItemJnlLine."Item No.";
                                                reservationEntry.VALIDATE(reservationEntry."Item No.", ItemJnlLine."Item No.");
                                                reservationEntry."Location Code" := ItemJnlLine."Location Code";
                                                reservationEntry."Quantity (Base)" := 1;
                                                reservationEntry.VALIDATE("Quantity (Base)", ABS(ItemLedgerEntry.Quantity));
                                                reservationEntry.VALIDATE("Location Code", ItemJnlLine."Location Code");
                                                reservationEntry.VALIDATE("Reservation Status", reservationEntry."Reservation Status"::Prospect);

                                                reservationEntry."Reservation Status" := reservationEntry."Reservation Status"::Prospect;
                                                reservationEntry."Source Type" := 83;
                                                reservationEntry."Source Subtype" := 6;
                                                reservationEntry."Source ID" := 'OUTPUT';
                                                reservationEntry."Source Batch Name" := "Journal Batch Name";
                                                reservationEntry."Source Ref. No." := ItemJnlLine."Line No.";
                                                reservationEntry."Serial No." := ItemLedgerEntry."Serial No.";
                                                reservationEntry.VALIDATE("Expected Receipt Date", WORKDATE);
                                                reservationEntry.VALIDATE("Qty. per Unit of Measure", ItemLedgerEntry."Qty. per Unit of Measure");
                                                reservationEntry.VALIDATE("Suppressed Action Msg.", FALSE);
                                                reservationEntry.VALIDATE("Planning Flexibility", reservationEntry."Planning Flexibility"::Unlimited);

                                                reservationEntry.INSERT;
                                            END;
                                        END;
                                    UNTIL ItemLedgerEntry.NEXT = 0;
                            END;
                            UNTIL ItemJnlLine.NEXT = 0;
                    END;
                end;
            }
            action("Assign Prod Serial No.'s")
            {
                Caption = 'Assign Prod Serial No.''s';
                Image = LotNo;

                trigger OnAction();
                begin
                    XMLPORT.RUN(XMLPORT::OutPutJrnlSerialNoAsign);
                end;
            }
        }
        addfirst("P&osting")
        {
            action(test)
            {

                trigger OnAction();
                begin
                    MESSAGE("Item No.");
                end;
            }
            action("Apply All")
            {
                Image = Copy;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                begin
                    //Added by Pranavi on 13-11-2015 for applying type,no,run time for filtered records
                    ItmJrnalLine.RESET;
                    ItmJrnalLine.COPYFILTERS(Rec);
                    ItmJrnalLine.SETRANGE(ItmJrnalLine."Journal Batch Name", "Journal Batch Name");
                    IF ItmJrnalLine.FINDSET THEN
                        REPEAT
                            ItmJrnalLine."Posting Date" := "Posting Date";
                            ItmJrnalLine.Type := Type;
                            ItmJrnalLine.VALIDATE(Type);
                            ItmJrnalLine."No." := "No.";
                            ItmJrnalLine.VALIDATE("No.");
                            ItmJrnalLine."Run Time" := "Run Time";
                            ItmJrnalLine.VALIDATE("Run Time");
                            ItmJrnalLine.MODIFY(TRUE);
                        UNTIL (ItmJrnalLine.NEXT = 0);
                    //end by pranavi
                end;
            }
            action("Cancel All")
            {
                Image = ClearLog;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                begin
                    //Added by Pranavi on 13-11-2015 for un-applying type,no,run time for filtered records
                    ItmJrnalLine.RESET;
                    ItmJrnalLine.COPYFILTERS(Rec);
                    ItmJrnalLine.SETRANGE(ItmJrnalLine."Journal Batch Name", "Journal Batch Name");
                    IF ItmJrnalLine.FINDSET THEN
                        REPEAT
                            ItmJrnalLine."Posting Date" := TODAY();
                            ItmJrnalLine.Type := ItmJrnalLine.Type::"Work Center";
                            ItmJrnalLine."No." := '';
                            ItmJrnalLine.VALIDATE("No.");
                            ItmJrnalLine."Run Time" := 0;
                            ItmJrnalLine.VALIDATE("Run Time");
                            ItmJrnalLine.MODIFY(TRUE);
                        UNTIL ItmJrnalLine.NEXT = 0;
                    //end by pranavi
                end;
            }
            action("To be Posted Semi product")
            {

                trigger OnAction();
                var
                    CalcConsumption: Codeunit 5406;
                    InputDate: Text;
                begin
                    /*InputDate := InputBox();
                    CalcConsumption.TobePosted_SemiProducts(Rec, InputDate);*/
                end;
            }
            action(TestingAction)
            {
                Caption = 'TestingAction';
            }
        }
    }

    var
        ProductionOrderNo: Text;
        ItemNo: Text;
        ReservEngineMgt: Codeunit 99000831;

    var
        ProdOrderRoutingLine1: Record 5409;
        CapacityLedgerEntry: Record 5832;
        "Divide-by-Qty.": Decimal;
        ItemJrnlLineRec: Record 83;
        SerialNo: Code[20];
        TempILE2: Record 32 temporary;
        Text043: Label 'Output Journal Line %1 Existed against this serial No';
        Text040: Label 'Output Qty should not be >1';
        IDS: Record 33000255;
        IR: Record 33000269;
        Text041: Label 'IDs %1 Existed against this serial No';
        Text042: Label 'IRs %1 Existed against this serial No';
        OutPutJournal: Record 83;
        ItemJnlLine: Record 83;
        OperationNo: Text[30];
        OperationLineNo: Integer;
        reservationEntry: Record 337;
        Prod_Qty: Integer;
        ItemLedgerEntry: Record 32;
        ItemLedgerEntry2: Record 32;
        "Prod. Order Line": Record 5406;
        COnsume_Qty: Integer;
        SQLQuery: Text[1000];
        LineSQLQuery: Text[250];
        HeadID: Text[30];
        UpdateWebHead: Text[250];
        WebRecStatus: Text[30];
        OldWebStatus: Text[30];
        "Reworked Date": Date;
        I: Integer;
        SQLQuery2: Text[1000];
        NoSeriesMgt: Codeunit 396;
        MfgSetup: Record 99000765;
        ItemJnlBatch: Record 233;
        Prod_Order_Line_No: Decimal;
        Machine_Center: Record 99000758;
        Quotes: Label '''';
        Text50001: Label 'NEW';
        Text50002: Label 'OLD';
        [InDataSet]
        "Reworked User IdVisible": Boolean;
        Text19051555: Label 'Prod. Order Name';
        "--Rev01": Integer;
        //SQLConnection: Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000514-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Connection";
        //RecordSet: Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000535-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Recordset";
        PostedMatIssHdr: Record 50003;
        MatIssHdr: Record 50001;
        ItmJrnalLine: Record 83;
        prodOrdrComp: Record 5407;
        PostedMatIssLine: Record 50004;
        Itm: Record 27;
        MatIssLine: Record 50002;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    "Reworked User IdVisible" := TRUE;
    */
    //end;

    //event RecordSet(cFields : Integer;"Fields" : Variant;adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(cFields : Integer;"Fields" : Variant;pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;cRecords : Integer;adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;cRecords : Integer;pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(var fMoreData : Boolean;adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(Progress : Integer;MaxProgress : Integer;adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus : Integer;pConnection : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(TransactionLevel : Integer;pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus : Integer;pConnection : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus : Integer;pConnection : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus : Integer;pConnection : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(var Source : Text;CursorType : Integer;LockType : Integer;var Options : Integer;adStatus : Integer;pCommand : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{B08400BD-F9D1-4D02-B856-71D5DBA123E9}:'Microsoft ActiveX Data Objects 2.8 Library'._Command";pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset";pConnection : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(RecordsAffected : Integer;pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus : Integer;pCommand : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{B08400BD-F9D1-4D02-B856-71D5DBA123E9}:'Microsoft ActiveX Data Objects 2.8 Library'._Command";pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset";pConnection : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(var ConnectionString : Text;var UserID : Text;var Password : Text;var Options : Integer;adStatus : Integer;pConnection : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus : Integer;pConnection : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(adStatus : Integer;pConnection : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
    //begin
    /*
    */
    //end;

    procedure AssignInprocessSerialNo(InprocessSerialNo: Code[20]);
    begin
        //NSS 030907
        SerialNo := InprocessSerialNo;
    end;

    procedure AgainstOperation();
    var
        ProdOrder: Record 5405;
        ProdOrderRoutingLine: Record 5409;
    begin
        ItemJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
        ItemJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
        IF ItemJnlLine.FINDFIRST THEN BEGIN
            ProdOrderRoutingLine.SETRANGE(Status, ProdOrderRoutingLine.Status::Released);
            ProdOrderRoutingLine.SETRANGE("Prod. Order No.", "Order No.");
            ProdOrderRoutingLine.SETRANGE("Routing Reference No.", "Routing Reference No.");
            ProdOrderRoutingLine.SETRANGE("Routing No.", "Routing No.");
            ProdOrderRoutingLine.SETRANGE("Next Operation No.", '');
            IF ProdOrderRoutingLine.FINDFIRST THEN
                OperationNo := ProdOrderRoutingLine."Operation No.";
        END;
    end;

    local procedure OutputJrSerialNoOnAfterValidat();
    begin
        OutPutJournal.RESET;
        OutPutJournal.SETRANGE("Entry Type", OutPutJournal."Entry Type"::Output);
        OutPutJournal.SETRANGE("Order No.", "Order No.");
        OutPutJournal.SETRANGE("Order Line No.", "Order Line No.");
        OutPutJournal.SETRANGE("Output Jr Serial No.", "Output Jr Serial No.");
        IF OutPutJournal.FINDFIRST THEN
            IF "Output Jr Serial No." = OutPutJournal."Output Jr Serial No." THEN BEGIN
                "Output Jr Serial No." := '';
                ERROR(Text043);
            END;
    end;

    procedure DumptoOtherGSTTable(DocNo: Text);
    var
        GLE: Record 17;
        GST_Entry: Boolean;
        "Posting Date": Date;
        "VENDOR NAME": Text;
        "INVOICE NO.": Text;
        "Vendor Invoice Date": Date;
        "Accessable Amt": Decimal;
        IGST: Decimal;
        CGST: Decimal;
        SGST: Decimal;
        DEPARTMENT: Text;
        "GST JURISDICTION TYPE": Text;
        "GST Registration No_": Text;
        "GST Vendor Type": Text;
        "HSN/SAC CODE": Text;
        "HSN/SAC DESCRIPTION": Text;
        "VENDOR STATE": Text;
        "System Date": Date;
        "Document No_": Text;
        "G_L Account No_": Code[10];
        Ven: Record 23;
        State: Record State;
        GLA: Record 15;
        HSNSAC: Record "HSN/SAC";
    begin
        GST_Entry := FALSE;
        GLE.RESET;
        GLE.SETRANGE("Document No.", DocNo);
        GLE.SETFILTER("G/L Account No.", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10', '58001', '58002', '58003', '51101', '51102', '51103', '51104', '51105', '51106', '51107');
        IF GLE.FINDFIRST THEN BEGIN
            GST_Entry := TRUE;
        END;

        "Accessable Amt" := 0;
        IGST := 0;
        SGST := 0;
        CGST := 0;
        IF GST_Entry = FALSE THEN BEGIN
            EXIT;
        END ELSE BEGIN
            MESSAGE('GST Entry');
            GLE.RESET;
            GLE.SETRANGE("Document No.", DocNo);
            IF GLE.FINDFIRST THEN
                REPEAT
                    IF GLE.Amount < 0 THEN BEGIN
                        "Posting Date" := GLE."Posting Date";
                        Ven.RESET;
                        Ven.SETFILTER("No.", GLE."Source No.");
                        IF Ven.FINDFIRST THEN BEGIN
                            "VENDOR NAME" := Ven.Name;
                            "GST Registration No_" := Ven."GST Registration No.";
                            "GST Vendor Type" := FORMAT(Ven."GST Vendor Type");
                            State.RESET;
                            State.SETRANGE(Code, Ven."State Code");
                            IF State.FINDFIRST THEN BEGIN
                                "VENDOR STATE" := FORMAT(State."State Code (GST Reg. No.)") + '-' + State.Description;
                            END;
                        END;
                        "External Document No." := GLE."External Document No.";
                        DEPARTMENT := GLE."Global Dimension 1 Code";
                        "System Date" := GLE."System Date";
                        "Document No_" := GLE."Document No.";
                    END ELSE
                        IF (GLE."G/L Account No." IN ['58001', '58002', '58003', '51101', '51102', '51103', '51104', '51105', '51106', '51107']) THEN BEGIN
                            // GST Details
                            IF (GLE."G/L Account No." IN ['58001', '51101', '51102', '51107']) THEN BEGIN
                                IGST := IGST + GLE.Amount;
                            END ELSE
                                IF (GLE."G/L Account No." IN ['58002', '51103', '51104']) THEN BEGIN
                                    SGST := SGST + GLE.Amount;
                                END ELSE
                                    IF (GLE."G/L Account No." IN ['58003', '51105', '51106']) THEN BEGIN
                                        CGST := CGST + GLE.Amount;
                                    END;
                        END ELSE BEGIN
                            // Cost Details
                            "Accessable Amt" := "Accessable Amt" + GLE.Amount;
                            "G_L Account No_" := GLE."G/L Account No.";
                        END;
                UNTIL GLE.NEXT = 0;
        END;
        IF (IGST > 0) AND (SGST + CGST = 0) THEN BEGIN
            "GST JURISDICTION TYPE" := 'Interstate';
        END ELSE BEGIN
            "GST JURISDICTION TYPE" := 'Intrastate';
        END;
        GLA.RESET;
        GLA.SETFILTER("No.", "G_L Account No_");
        IF GLA.FINDFIRST THEN BEGIN
            "HSN/SAC CODE" := GLA."HSN/SAC Code";
            HSNSAC.RESET;
            HSNSAC.SETFILTER("GST Group Code", GLA."GST Group Code");
            HSNSAC.SETFILTER(Code, GLA."HSN/SAC Code");
            IF HSNSAC.FINDFIRST THEN BEGIN
                "HSN/SAC DESCRIPTION" := HSNSAC.Description;
            END;
        END;
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

