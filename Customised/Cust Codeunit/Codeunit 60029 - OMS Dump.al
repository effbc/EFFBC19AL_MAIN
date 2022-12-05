codeunit 60029 "OMS Dump"
{


    trigger OnRun();
    begin

        // OPENING,COMMITING AND CLOSING CONNECTIONS FOR EACH TRASACTION ADDED BY VISHNU PRIYA ON 26-11-2019
        /*  IF ISCLEAR(SQLConnection) THEN
              CREATE(SQLConnection, FALSE, TRUE); //Rev01

          IF ISCLEAR(RecordSet) THEN
              CREATE(RecordSet, FALSE, TRUE); //Rev01*/


        WebRecStatus := Quotes + Text50001 + Quotes;
        OldWebStatus := Quotes + Text50002 + Quotes;
        //>> ORACLE UPG

        /*         SQLConnection.ConnectionString := 'DSN=omserp;UID=OMSUSER;PASSWORD=management;SERVER=oracle_80;';
                SQLConnection.Open;
                SQLConnection.BeginTrans; */
        //<< ORACLE UPG

        //************* UPDATION OF ITEM DETAILS ******************
        //ITEM.RESET;
        //ITEM.SETFILTER("No.", 'BOIANTEN0020');
        SQLQuery := 'DELETE FROM ERP_ITEM';
        //SQLConnection.Execute(SQLQuery);
        WINDOW.OPEN(s1);
        IF ITEM.FIND('-') THEN
                REPEAT
                    WINDOW.UPDATE(1, ITEM."No.");
                    ITEM.CALCFIELDS(ITEM."Quantity Under Inspection", ITEM."Stock At MCH Location");
                    SQLQuery := 'INSERT INTO ERP_ITEM (ITEM_NO,INVENTORY_AT_STORE,SAFETY_LEAD_TIME,AVERAGE_UNIT_COST,QUANTITY_UNDER_INSPECTION,' +
                              'PRODUCT_GROUP_CODE,MOQ,PRODUCTION_BOM_NO,DESCRIPTION,UNIT_OF_MEASURE,DESCRIPTION2,ITEM_SUB_GROUP_CODE,DEADSTOCK,' +
                              'USED_IN_DL,USED_IN_FEP,USED_IN_RTU,MIN_MUL_QTY,DUMPDATE)' +
                              ' VALUES (''' + ITEM."No." + ''',''' +
                                CommaRemoval(FORMAT(ROUND(STOCK.ITEM_STOCK(ITEM."No.") + ITEM."Stock At MCH Location", 0.01))) + ''',''' +
                                FORMAT(ITEM."Safety Lead Time") + ''',''' + CommaRemoval(FORMAT(ROUND(ITEM."Avg Unit Cost", 0.01))) + ''',''' +
                                CommaRemoval(FORMAT(ROUND(ITEM."Quantity Under Inspection", 0.01))) + ''',''' + ITEM."Product Group Code Cust" + ''',''' +
                                CommaRemoval(FORMAT(ROUND(ITEM."Minimum Order Quantity", 0.01))) + ''',''' + ITEM."Production BOM No." + ''',''' +
                                CommaRemoval(ITEM.Description) + ''',''' + ITEM."Base Unit of Measure" + ''',''' +
                                CommaRemoval(ITEM."Description 2") + ''',''' + ITEM."Item Sub Group Code" +
                                ''',''' + FORMAT(ITEM.PROD_USED) + ''',''' + FORMAT(ITEM."Used In DL") + ''',''' + FORMAT(ITEM."Used In MFEP") + ''',''' +
                                FORMAT(ITEM."Used In RTU") + ''',''' +
                                CommaRemoval(FORMAT(ROUND(ITEM."Order Multiple", 0.01))) + ''',SYSDATE)';
                //>> ORACLE UPG
                /*  IF ITEM."No." <> '' THEN
                     SQLConnection.Execute(SQLQuery); */
                //<< ORACLE UPG

                UNTIL ITEM.NEXT = 0;
        WINDOW.CLOSE;
        //************** UPDATION OF ITEM DETAILS ********************
        /* SQLConnection.CommitTrans;
         SQLConnection.Close;*/
        /* IF ISCLEAR(SQLConnection) THEN
             CREATE(SQLConnection, FALSE, TRUE); //Rev01

         IF ISCLEAR(RecordSet) THEN
             CREATE(RecordSet, FALSE, TRUE); //Rev01*/
        WebRecStatus := Quotes + Text50001 + Quotes;
        OldWebStatus := Quotes + Text50002 + Quotes;

        /* SQLConnection.ConnectionString := 'DSN=omserp;UID=OMSUSER;PASSWORD=management;SERVER=oracle_80;';
         SQLConnection.Open;
         SQLConnection.BeginTrans;*/

        //************** UPDATION OF PURCHASE ORDER DETAILS ********
        WINDOW.OPEN(S2);
        SQLQuery := 'DELETE FROM ERP_PURCHASE_LINE';
        //SQLConnection.Execute(SQLQuery);

        PURCHASE_LINE.SETRANGE(PURCHASE_LINE."Document Type", PURCHASE_LINE."Document Type"::Order);
        PURCHASE_LINE.SETFILTER(PURCHASE_LINE."Qty. to Receive", '>%1', 0);
        IF PURCHASE_LINE.FIND('-') THEN
            REPEAT
                    WINDOW.UPDATE(1, PURCHASE_LINE."Document No.");
                VNAME := '';
                REL_DATE := 0D;
                PURCHASE_HEADER.RESET;
                PURCHASE_HEADER.SETFILTER(PURCHASE_HEADER."No.", PURCHASE_LINE."Document No.");
                IF PURCHASE_HEADER.FINDFIRST THEN BEGIN
                    VNAME := PURCHASE_HEADER."Buy-from Vendor Name";
                    REL_DATE := DT2DATE(PURCHASE_HEADER."Release Date Time");
                END;
                // PURCHASE_RELEASED_DATE,SUPPLIER_NAME,SUPPLIER_ID Added by Sundar,Vijay Kumar on 05-mar-2012 for OMS shortage Report enhancements

                SQLQuery := ' INSERT INTO ERP_PURCHASE_LINE (ITEM_NO,QUANTITY,UNIT_OF_MEASURE,EXPECTED_INVOICE_DATE,PURCHASE_ORDER_NO,' +
                          'DEVIATED_EXPECTEDDATE,OUTSTANDING_QUANTITY,UNIT_COST,REMARKS,DUMPDATE,SUPPLIER_ID,SUPPLIER_NAME,' +
                          'PURCHASE_RELEASED_DATE) ' +
                          ' VALUES (''' + PURCHASE_LINE."No." + ''',''' +
                          CommaRemoval(FORMAT(ROUND(PURCHASE_LINE.Quantity, 0.01))) + ''',''' + PURCHASE_LINE."Unit of Measure Code" + ''',''' +
                          FORMAT(PURCHASE_LINE."Expected Receipt Date", 0, '<Day>-<Month Text,3>-<Year4>') + ''',''' +
                          FORMAT(PURCHASE_LINE."Document No.") + ''',''' +
                          FORMAT(PURCHASE_LINE."Deviated Receipt Date", 0, '<Day>-<Month Text,3>-<Year4>') + ''',''' +
                          CommaRemoval(FORMAT(ROUND(PURCHASE_LINE."Outstanding Quantity", 0.01))) + ''',''' +
                          CommaRemoval(FORMAT(ROUND(PURCHASE_LINE."Unit Cost (LCY)", 0.01))) + ''',''' +
                          CommaRemoval(PURCHASE_LINE.Remarks) + ''',SYSDATE,''' + PURCHASE_LINE."Buy-from Vendor No." + ''',''' + VNAME + ''',''' +
                          FORMAT(REL_DATE, 0, '<Day>-<Month Text,3>-<Year4>') + ''')';
            // SQLConnection.Execute(SQLQuery);
            UNTIL PURCHASE_LINE.NEXT = 0;
        WINDOW.CLOSE;

        //************** UPDATION OF PURCHASE ORDER DETAILS ********
        /* SQLConnection.CommitTrans;
         SQLConnection.Close;*/  //B2BUPG
                                 /* IF ISCLEAR(SQLConnection) THEN
                                      CREATE(SQLConnection, FALSE, TRUE); //Rev01

                                  IF ISCLEAR(RecordSet) THEN
                                      CREATE(RecordSet, FALSE, TRUE); //Rev01*/


        WebRecStatus := Quotes + Text50001 + Quotes;
        OldWebStatus := Quotes + Text50002 + Quotes;

        /*SQLConnection.ConnectionString := 'DSN=omserp;UID=OMSUSER;PASSWORD=management;SERVER=oracle_80;';
        SQLConnection.Open;
        SQLConnection.BeginTrans;*/  //B2BUPG

        //**************** UPDATING QC ITEM DETAILS ****************

        WINDOW.OPEN(S3);
        SQLQuery := 'DELETE FROM ERP_UNDER_QC';
        // SQLConnection.Execute(SQLQuery);
        INSPECTION_DATA_SHEET_HEADER.SETRANGE(INSPECTION_DATA_SHEET_HEADER."Source Type",
                                              INSPECTION_DATA_SHEET_HEADER."Source Type"::"In Bound");
        INSPECTION_DATA_SHEET_HEADER.SETRANGE(INSPECTION_DATA_SHEET_HEADER.Location, 'STR');
        IF INSPECTION_DATA_SHEET_HEADER.FIND('-') THEN
            REPEAT
                    WINDOW.UPDATE(1, INSPECTION_DATA_SHEET_HEADER."Item No.");
                SQLQuery := 'INSERT INTO ERP_UNDER_QC (ITEM_NO,QUANTITY,DUMPDATE) VALUES (''' + INSPECTION_DATA_SHEET_HEADER."Item No." + ''',''' +
                          CommaRemoval(FORMAT(ROUND(INSPECTION_DATA_SHEET_HEADER.Quantity, 0.01))) + ''',SYSDATE)';
            //          SQLConnection.Execute(SQLQuery);
            UNTIL INSPECTION_DATA_SHEET_HEADER.NEXT = 0;


        INSPECTION_RECEIPT_HEADER.RESET;
        INSPECTION_RECEIPT_HEADER.SETRANGE(Status, FALSE);
        INSPECTION_RECEIPT_HEADER.SETRANGE("Source Type", 0);
        IF INSPECTION_RECEIPT_HEADER.FINDSET THEN
            REPEAT
                    WINDOW.UPDATE(1, INSPECTION_DATA_SHEET_HEADER."Item No.");
                SQLQuery := 'INSERT INTO ERP_UNDER_QC (ITEM_NO,QUANTITY,DUMPDATE) VALUES (''' + INSPECTION_RECEIPT_HEADER."Item No." + ''',''' +
                          CommaRemoval(FORMAT(ROUND(INSPECTION_RECEIPT_HEADER.Quantity, 0.01))) + ''',SYSDATE)';
            // SQLConnection.Execute(SQLQuery);
            UNTIL INSPECTION_RECEIPT_HEADER.NEXT = 0;
        WINDOW.CLOSE;
        //**************** UPDATING QC ITEM DETAILS ****************
        /* SQLConnection.CommitTrans;
         SQLConnection.Close;*/  //B2BUPG
                                 /* IF ISCLEAR(SQLConnection) THEN
                                      CREATE(SQLConnection, FALSE, TRUE); //Rev01

                                  IF ISCLEAR(RecordSet) THEN
                                      CREATE(RecordSet, FALSE, TRUE); //Rev01*/


        WebRecStatus := Quotes + Text50001 + Quotes;
        OldWebStatus := Quotes + Text50002 + Quotes;

        /* SQLConnection.ConnectionString := 'DSN=omserp;UID=OMSUSER;PASSWORD=management;SERVER=oracle_80;';
         SQLConnection.Open;
         SQLConnection.BeginTrans;*/ //B2BUPG

        //*************** UPDATING MATERIAL ISSUES INFORMATION****************************
        WINDOW.OPEN(S4);
        SQLQuery := 'DELETE FROM ERP_MATERIAL_ISSUES_LINE';
        //  SQLConnection.Execute(SQLQuery);
        MATERIAL_ISSUES_LINE.SETRANGE(MATERIAL_ISSUES_LINE."Transfer-from Code", 'STR');
        MATERIAL_ISSUES_LINE.SETFILTER(MATERIAL_ISSUES_LINE."Qty. to Receive", '>%1', 0);
        MATERIAL_ISSUES_LINE.SETRANGE(MATERIAL_ISSUES_LINE.Status, MATERIAL_ISSUES_LINE.Status::Released);
        MATERIAL_ISSUES_LINE.SETFILTER(MATERIAL_ISSUES_LINE."Prod. Order No.", '<>%1', 'SBI17SPA2074');
        IF MATERIAL_ISSUES_LINE.FIND('-') THEN
            REPEAT
                    WINDOW.UPDATE(1, MATERIAL_ISSUES_LINE."Document No.");
                MATERIAL_ISSUES_HEADER.RESET;
                MATERIAL_ISSUES_HEADER.SETRANGE(MATERIAL_ISSUES_HEADER."No.", MATERIAL_ISSUES_LINE."Document No.");
                IF MATERIAL_ISSUES_HEADER.FIND('-') THEN BEGIN
                    SQLQuery := 'INSERT INTO ERP_MATERIAL_ISSUES_LINE (ITEM_NO,QUANTITY,QUANTITY_TO_RECEIVE,RELEASED_DATE,PROD_BOM_NO,' +
                              'SALE_DESC,PROD_ORD_NO,DUMPDATE) ' +
                              ' VALUES (''' + MATERIAL_ISSUES_LINE."Item No." + ''',''' +
                              CommaRemoval(FORMAT(ROUND(MATERIAL_ISSUES_LINE.Quantity, 0.01))) + ''',''' +
                              CommaRemoval(FORMAT(ROUND(MATERIAL_ISSUES_LINE."Qty. to Receive", 0.01))) + ''',''' +
                              FORMAT(MATERIAL_ISSUES_HEADER."Released Date", 0, '<Day>-<Month Text,3>-<Year4>') + ''',''' +
                              MATERIAL_ISSUES_HEADER."Prod. BOM No." + ''',''' + MATERIAL_ISSUES_HEADER."Sales Order No." + ''',''' +
                              MATERIAL_ISSUES_HEADER."Prod. Order No." + ''',SYSDATE)';

                    //SQLConnection.Execute(SQLQuery);
                END;
            UNTIL MATERIAL_ISSUES_LINE.NEXT = 0;
        WINDOW.CLOSE;

        //***************************mATERIAL ISSUES***************************************
        /* SQLConnection.CommitTrans;
         SQLConnection.Close;*/
        /*  IF ISCLEAR(SQLConnection) THEN
              CREATE(SQLConnection, FALSE, TRUE); //Rev01

          IF ISCLEAR(RecordSet) THEN
              CREATE(RecordSet, FALSE, TRUE); //Rev01*/


        WebRecStatus := Quotes + Text50001 + Quotes;
        OldWebStatus := Quotes + Text50002 + Quotes;

        /* SQLConnection.ConnectionString := 'DSN=omserp;UID=OMSUSER;PASSWORD=management;SERVER=oracle_80;';
         SQLConnection.Open;
         SQLConnection.BeginTrans;*/  //B2BUPG

        //*************** UPDATING ALTERNATIVE ITEMS INFORMATION****************************
        WINDOW.OPEN(S9);
        SQLQuery := 'DELETE FROM ERP_ALTERNATIVE_ITEMS';
        //  SQLConnection.Execute(SQLQuery);

        ALTERNATIVE_ITEMS.SETCURRENTKEY("Item No.");
        //ALTERNATIVE_ITEMS.SETFILTER("Proudct Type",'<>%1','');
        ALTERNATIVE_ITEMS.SETFILTER("Item No.", '<>%1', '');
        ALTERNATIVE_ITEMS.SETFILTER("Alternative Item No.", '<>%1', '');
        //ALTERNATIVE_ITEMS.SETRANGE(ALTERNATIVE_ITEMS."Item No.",'ECCAPEL00128');
        IF ALTERNATIVE_ITEMS.FIND('-') THEN
                REPEAT
                    IF (ALTERNATIVE_ITEMS."Item No." <> ALTERNATIVE_ITEMS."Alternative Item No.") THEN BEGIN
                        IF PREV_ITEM <> ALTERNATIVE_ITEMS."Item No." THEN BEGIN
                            FOR I := 1 TO 10 DO
                                ALTERNATE_ITEMS[I] := '';
                            ALTERNATE_ITEMS[1] := ALTERNATIVE_ITEMS."Alternative Item No.";
                            ALTERNATE_ITEM_CNT := 1;
                            WINDOW.UPDATE(1, ALTERNATIVE_ITEMS."Item No.");
                            SQLQuery := 'INSERT INTO ERP_ALTERNATIVE_ITEMS VALUES (''' + ALTERNATIVE_ITEMS."Item No." + ''',''' +
                                      ALTERNATIVE_ITEMS."Alternative Item No." + ''','' '')';
                            // SQLConnection.Execute(SQLQuery);
                            PREV_ITEM := ALTERNATIVE_ITEMS."Item No.";
                        END ELSE BEGIN
                            REPEATED := FALSE;
                            FOR I := 1 TO ALTERNATE_ITEM_CNT DO
                                IF (ALTERNATE_ITEMS[I] = ALTERNATIVE_ITEMS."Alternative Item No.") THEN
                                    REPEATED := TRUE;
                            IF NOT REPEATED THEN BEGIN
                                ALTERNATE_ITEM_CNT += 1;
                                ALTERNATE_ITEMS[ALTERNATE_ITEM_CNT] := ALTERNATIVE_ITEMS."Alternative Item No.";
                                WINDOW.UPDATE(1, ALTERNATIVE_ITEMS."Item No.");
                                SQLQuery := 'INSERT INTO ERP_ALTERNATIVE_ITEMS VALUES (''' + ALTERNATIVE_ITEMS."Item No." + ''',''' +
                                          ALTERNATIVE_ITEMS."Alternative Item No." + ''','' '')';
                                // SQLConnection.Execute(SQLQuery);
                            END;
                        END;
                    END;
                UNTIL ALTERNATIVE_ITEMS.NEXT = 0;
        WINDOW.CLOSE;

        // *******************************ALTERNATIVE ITEMS********************************

        /*SQLConnection.CommitTrans;
        SQLConnection.Close;*/
        /* IF ISCLEAR(SQLConnection) THEN
             CREATE(SQLConnection, FALSE, TRUE); //Rev01

         IF ISCLEAR(RecordSet) THEN
             CREATE(RecordSet, FALSE, TRUE); //Rev01*/


        WebRecStatus := Quotes + Text50001 + Quotes;
        OldWebStatus := Quotes + Text50002 + Quotes;

        /* SQLConnection.ConnectionString := 'DSN=omserp;UID=OMSUSER;PASSWORD=management;SERVER=oracle_80;';
         SQLConnection.Open;
         SQLConnection.BeginTrans;*/ // //B2BUPG



        IF (DATE2DWY(TODAY, 1) = 3) OR (DATE2DWY(TODAY, 1) = 6) OR (DATE2DWY(TODAY, 1) = 2) THEN  // Day is Wednesday or Saturday
        BEGIN
            //Commented by Pranavi on 29-Dec-2015 for dumping BOMs data


            //*************** UPDATING SALES SCHEDULE INFORMATION****************************
            WINDOW.OPEN(S5);
            SQLQuery := 'DELETE FROM ERP_SALES_SCHEDULE';
            //  SQLConnection.Execute(SQLQuery);
            SCHEDULE.SETRANGE(SCHEDULE."Document Type", SCHEDULE."Document Type"::Order);
            SCHEDULE.SETFILTER(SCHEDULE."No.", '<>%1', '');
            SCHEDULE.SETFILTER(SCHEDULE.Quantity, '>%1', 0);
            IF SCHEDULE.FIND('-') THEN
                REPEAT
                        WINDOW.UPDATE(1, SCHEDULE."Document No.");
                    SQLQuery := 'INSERT INTO ERP_SALES_SCHEDULE VALUES (''' + SCHEDULE."Document No." + ''',''' +
                               FORMAT(SCHEDULE."Document Line No.") + ''',''' + FORMAT(SCHEDULE."Line No.") + ''',''' +
                               FORMAT(SCHEDULE.Type) + ''',''' + SCHEDULE."No." + ''',''' +
                               CommaRemoval(FORMAT(ROUND(SCHEDULE.Quantity, 0.01))) + ''')';
                //SQLConnection.Execute(SQLQuery);

                UNTIL SCHEDULE.NEXT = 0;
            WINDOW.CLOSE;

            //*************** UPDATING SALES SCHEDULE INFORMATION****************************
            /* SQLConnection.CommitTrans;
             SQLConnection.Close;*/
            /*IF ISCLEAR(SQLConnection) THEN
                CREATE(SQLConnection, FALSE, TRUE); //Rev01

            IF ISCLEAR(RecordSet) THEN
                CREATE(RecordSet, FALSE, TRUE); //Rev01*/


            WebRecStatus := Quotes + Text50001 + Quotes;
            OldWebStatus := Quotes + Text50002 + Quotes;

            /*  SQLConnection.ConnectionString := 'DSN=omserp;UID=OMSUSER;PASSWORD=management;SERVER=oracle_80;';
              SQLConnection.Open;
              SQLConnection.BeginTrans;*/
            //*************** UPDATING SALES LINE INFORMATION****************************
            WINDOW.OPEN(S6);
            SQLQuery := 'DELETE FROM ERP_SALES_LINE';
            // SQLConnection.Execute(SQLQuery);
            SALES_LINE.SETFILTER(SALES_LINE."Document Type", '%1|%2', SALES_LINE."Document Type"::Order,
                                                                    SALES_LINE."Document Type"::"Blanket Order");

            SALES_LINE.SETFILTER(SALES_LINE."No.", '<>%1', '');
            SALES_LINE.SETFILTER(SALES_LINE.Quantity, '>%1', 0);
            IF SALES_LINE.FIND('-') THEN
                REPEAT
                        WINDOW.UPDATE(1, SALES_LINE."Document No.");
                    SQLQuery := ' INSERT INTO ERP_SALES_LINE VALUES (''' + SALES_LINE."Document No." + ''',''' +
                              SALES_LINE."No." + ''',''' + FORMAT(SALES_LINE.Type) + ''',''' + SALES_LINE."Product Group Code Cust" + ''',''' +
                              CommaRemoval(SALES_LINE.Description) + ''',''' + SALES_LINE."Unit of Measure" + ''',''' +
                              CommaRemoval(FORMAT(ROUND(SALES_LINE.Quantity, 0.01))) + ''',''' + FORMAT(SALES_LINE."RDSO Inspection By") + ''',''' +
                              CommaRemoval(FORMAT(ROUND(SALES_LINE."Qty. to Ship", 0.01))) + ''',''' + FORMAT(SALES_LINE."Line No.") + ''')';
                //  SQLConnection.Execute(SQLQuery);

                UNTIL SALES_LINE.NEXT = 0;
            WINDOW.CLOSE;
            //*************** UPDATING SALES LINE INFORMATION****************************
            /*SQLConnection.CommitTrans;
            SQLConnection.Close;*/
            /*  IF ISCLEAR(SQLConnection) THEN
                  CREATE(SQLConnection, FALSE, TRUE); //Rev01

              IF ISCLEAR(RecordSet) THEN
                  CREATE(RecordSet, FALSE, TRUE); //Rev01*/


            WebRecStatus := Quotes + Text50001 + Quotes;
            OldWebStatus := Quotes + Text50002 + Quotes;

            /*  SQLConnection.ConnectionString := 'DSN=omserp;UID=OMSUSER;PASSWORD=management;SERVER=oracle_80;';
              SQLConnection.Open;
              SQLConnection.BeginTrans;*/  //B2BUPG
                                           //*************** UPDATING PRODUCTION BOM  HEADER INFORMATION****************************
            WINDOW.OPEN(S7);
            SQLQuery := 'DELETE FROM ERP_PRODUCTION_BOM_HEADER';
            //  SQLConnection.Execute(SQLQuery);
            IF "PRODUCTION BOM HEADER".FIND('-') THEN
                REPEAT
                        WINDOW.UPDATE(1, "PRODUCTION BOM HEADER"."No.");
                    SQLQuery := ' INSERT INTO ERP_PRODUCTION_BOM_HEADER  VALUES (''' + "PRODUCTION BOM HEADER"."No." + ''',''' +
                               FORMAT("PRODUCTION BOM HEADER".Status) + ''',''' + CommaRemoval("PRODUCTION BOM HEADER".Description) + ''')';
                //  SQLConnection.Execute(SQLQuery);
                UNTIL "PRODUCTION BOM HEADER".NEXT = 0;
            WINDOW.CLOSE;
            //*************** UPDATING PRODUCTION BOM  HEADER INFORMATION****************************
            /* SQLConnection.CommitTrans;
             SQLConnection.Close;*/  //B2BUPG
                                     /*IF ISCLEAR(SQLConnection) THEN
                                         CREATE(SQLConnection, FALSE, TRUE); //Rev01

                                     IF ISCLEAR(RecordSet) THEN
                                         CREATE(RecordSet, FALSE, TRUE); //Rev01*/


            WebRecStatus := Quotes + Text50001 + Quotes;
            OldWebStatus := Quotes + Text50002 + Quotes;

            /*   SQLConnection.ConnectionString := 'DSN=omserp;UID=OMSUSER;PASSWORD=management;SERVER=oracle_80;';
               SQLConnection.Open;
               SQLConnection.BeginTrans;*/ //B2BUPG

            //*************** UPDATING PRODUCTION BOM LINE INFORMATION****************************
            WINDOW.OPEN(S8);
            "PRODUCTION BOM LINE".RESET;
            SQLQuery := 'DELETE  FROM ERP_PRODUCTION_BOM_LINE3';
            //  SQLConnection.Execute(SQLQuery);
            //"PRODUCTION BOM LINE".SETFILTER("PRODUCTION BOM LINE"."No.",'<>%1','');
            "PRODUCTION BOM LINE".SETFILTER("PRODUCTION BOM LINE"."Production BOM No.", '%1', 'ECMPBPCB0000*');
            IF "PRODUCTION BOM LINE".FIND('-') THEN
                REPEAT
                        WINDOW.UPDATE(1, "PRODUCTION BOM LINE"."Production BOM No.");

                    SQLQuery := ' INSERT INTO ERP_PRODUCTION_BOM_LINE3 VALUES (''' + "PRODUCTION BOM LINE"."Production BOM No." + ''',''' +
                              "PRODUCTION BOM LINE"."No." + ''',''' + CommaRemoval("PRODUCTION BOM LINE".Description) + ''',''' +
                              "PRODUCTION BOM LINE"."Unit of Measure Code" + ''',''' +
                              CommaRemoval(FORMAT(ROUND("PRODUCTION BOM LINE"."Quantity per", 0.01))) + ''',''' +
                              FORMAT("PRODUCTION BOM LINE".Type) + ''',''' + FORMAT("PRODUCTION BOM LINE"."Material Reqired Day") + ''',''' +
                              "PRODUCTION BOM LINE"."Version Code" + ''')';
                //  SQLConnection.Execute(SQLQuery);
                //MESSAGE('Dumping of :: '+ "PRODUCTION BOM LINE"."Production BOM No." +'  ' +SQLQuery );
                UNTIL "PRODUCTION BOM LINE".NEXT = 0;
            WINDOW.CLOSE;
            //*************** UPDATING PRODUCTION BOM LINE INFORMATION****************************
            /*SQLConnection.CommitTrans;
            SQLConnection.Close;*/  //B2BUPG
                                    /*   IF ISCLEAR(SQLConnection) THEN
                                           CREATE(SQLConnection, FALSE, TRUE); //Rev01

                                       IF ISCLEAR(RecordSet) THEN
                                           CREATE(RecordSet, FALSE, TRUE); //Rev01*/


            WebRecStatus := Quotes + Text50001 + Quotes;
            OldWebStatus := Quotes + Text50002 + Quotes;

            /* SQLConnection.ConnectionString := 'DSN=omserp;UID=OMSUSER;PASSWORD=management;SERVER=oracle_80;';
             SQLConnection.Open;
             SQLConnection.BeginTrans;*/

            //*************** UPDATING PRODUCTION BOM VERSION INFORMATION****************************
            WINDOW.OPEN(S9);
            SQLQuery := 'DELETE FROM PRODUCTION_BOM_VERSION';
            //   SQLConnection.Execute(SQLQuery);
            IF "PRODUCTION BOM VERSION".FIND('-') THEN
                REPEAT
                        WINDOW.UPDATE(1, "PRODUCTION BOM VERSION"."Production BOM No.");
                    SQLQuery := 'INSERT INTO PRODUCTION_BOM_VERSION VALUES (''' + "PRODUCTION BOM VERSION"."Production BOM No." + ''',''' +
                              "PRODUCTION BOM VERSION"."Version Code" + ''',''' + FORMAT("PRODUCTION BOM VERSION".Status) + ''')';
                //  SQLConnection.Execute(SQLQuery);
                UNTIL "PRODUCTION BOM VERSION".NEXT = 0;
            WINDOW.CLOSE;
            /*  SQLConnection.CommitTrans;
              SQLConnection.Close;*/  //B2BUPG
        END;

        /*SQLConnection.CommitTrans;
        SQLConnection.Close;*/

    end;

    var
        ItemJnlManagement: Codeunit 240;
        PURCHASE_LINE: Record "Purchase Line";
        INSPECTION_DATA_SHEET_HEADER: Record "Inspection Datasheet Header";
        MATERIAL_ISSUES_LINE: Record "Material Issues Line";
        MATERIAL_ISSUES_HEADER: Record "Material Issues Header";
        SCHEDULE: Record Schedule2;
        SALES_LINE: Record "Sales Line";
        "PRODUCTION BOM HEADER": Record "Production BOM Header";
        "PRODUCTION BOM LINE": Record "Production BOM Line";
        "PRODUCTION BOM VERSION": Record "Production BOM Version";
        SQLQuery: Text[1000];
        //LRecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        LineSQLQuery: Text[250];
        HeadID: Text[30];
        UpdateWebHead: Text[250];
        WebRecStatus: Text[30];
        OldWebStatus: Text[30];
        WINDOW: Dialog;
        ITEM: Record Item;
        s1: Label 'UPDATING STOCK #1#############';
        S2: Label 'UPDATING PURCHASE ORdER #1################';
        S3: Label 'UPDATING QC DETAILS #1############';
        S4: Label 'UPDATING MATERIAL ISSUES INFORMATION #1###########';
        S5: Label 'UPDATING SALES SCHEDULE INFORMATION #1###########';
        S6: Label 'UPDATIN SALES LINE INFORMATION #1##############';
        S7: Label 'UPDATING PRODUCTION BOM HEADERS #1############';
        S8: Label 'UPDATING PRODUCTION BOM LINE #1#############';
        S9: Label 'UPDATING PRODUCTION BOM VERSION #1#########';
        Quotes: Label '''';
        Text50001: Label 'NEW';
        Text50002: Label 'OLD';
        ALTERNATIVE_ITEMS: Record "Alternate Items";
        PREV_ITEM: Code[20];
        ALTERNATE_ITEMS: array[10] of Code[20];
        ALTERNATE_ITEM_CNT: Integer;
        REPEATED: Boolean;
        I: Integer;
        STOCK: Codeunit "item stock at stores1";
        INSPECTION_RECEIPT_HEADER: Record "Inspection Receipt Header";
        VNAME: Text[50];
        PURCHASE_HEADER: Record "Purchase Header";
        REL_DATE: Date;
        "--Rev01--": Integer;
    //>> ORACLE UPG
    /*  SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
     RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
*/
    //<< ORACLE UPG
    procedure CommaRemoval(Base: Text[250]) Converted: Text[250];
    var
        i: Integer;
    begin
        FOR i := 1 TO STRLEN(Base) DO BEGIN
            IF (COPYSTR(Base, i, 1) <> ',') AND (COPYSTR(Base, i, 1) <> '''') AND (COPYSTR(Base, i, 1) <> '&') THEN
                Converted += COPYSTR(Base, i, 1);
        END;
        EXIT(Converted);
    end;


    procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text;
    begin
        // Added by Pranavi on 17-Jan-2017
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
        // End by Pranavi
    end;

    //event LRecordSet(cFields : Integer;"Fields" : Variant;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event LRecordSet(cFields : Integer;"Fields" : Variant;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event LRecordSet(adReason : Integer;cRecords : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event LRecordSet(adReason : Integer;cRecords : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event LRecordSet(adReason : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event LRecordSet(adReason : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event LRecordSet(adReason : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event LRecordSet(adReason : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event LRecordSet(var fMoreData : Boolean;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event LRecordSet(Progress : Integer;MaxProgress : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event LRecordSet(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(cFields : Integer;"Fields" : Variant;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(cFields : Integer;"Fields" : Variant;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;cRecords : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;cRecords : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(var fMoreData : Boolean;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(Progress : Integer;MaxProgress : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(TransactionLevel : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(var Source : Text;CursorType : Integer;LockType : Integer;var Options : Integer;adStatus : Integer;pCommand : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{B08400BD-F9D1-4D02-B856-71D5DBA123E9}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Command";pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset";pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(RecordsAffected : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pCommand : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{B08400BD-F9D1-4D02-B856-71D5DBA123E9}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Command";pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset";pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(var ConnectionString : Text;var UserID : Text;var Password : Text;var Options : Integer;adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;
}

