codeunit 60030 "Cash Flow Connection"
{
    // //Dleeted var(SQLConnectionAutomation'Microsoft ActiveX Data Objects 2.8 Library'.Connection,RecordSetAutomation'Microsoft ActiveX Data Objects 2.8 Library'.Recordset)


    trigger OnRun();
    begin
        DEPT_DATA_UPDATION;
    end;

    var
        SQLQuery: Text[1000];
        LineSQLQuery: Text[250];
        HeadID: Text[30];
        UpdateWebHead: Text[250];
        WebRecStatus: Text[30];
        OldWebStatus: Text[30];
        Quotes: Label '''';
        Text50001: Label 'NEW';
        Text50002: Label 'OLD';
        "G|l": Record "General Ledger Setup";
        i: Integer;
        "Purchase Header": Record "Purchase Header";
        "Purch. Rcpt. Header": Record "Purch. Rcpt. Header";
        "Purch. Inv. Header": Record "Purch. Inv. Header";
        "Purchase Line": Record "Purchase Line";
        "Purch. Rcpt. Line": Record "Purch. Rcpt. Line";
        "Purch. Inv. Line": Record "Purch. Inv. Line";
        Order_Digits: array[10] of Char;
        SQLQuery1: Text[1000];
        Item: Record Item;
        TESTDATA: Record "Authorized Shortage Items";
        TESTDATA2: Record "Stock Statement";
        Vendor: Record Vendor;
        DEPT: Code[10];
        ORDER_LINE_NO: Integer;
        PID: Code[10];
        //>> ORACLE UPG
        /* SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
        RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A751 96C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        */
        //<< ORACLE UPG
        Working: Enum WORKINGSTATUS;


    procedure ExecInOracle(Qry: Text);
    begin

        /*  IF NOT ISCLEAR(SQLConnection) THEN
              CLEAR(SQLConnection);

          IF NOT ISCLEAR(RecordSet) THEN
              CLEAR(RecordSet);

          IF ISCLEAR(SQLConnection) THEN
              CREATE(SQLConnection, FALSE, TRUE);

          IF ISCLEAR(RecordSet) THEN
              CREATE(RecordSet, FALSE, TRUE);*/
        //B2B
        //>> ORACLE UPG
        /*
        WebRecStatus := Quotes + Text50001 + Quotes;
        OldWebStatus := Quotes + Text50002 + Quotes;
        "G|l".GET;
        SQLConnection.ConnectionString := "G|l"."Sql Connection String";
        SQLConnection.Open;//B2B
        //MESSAGE('Oracle Connected');
        SQLQuery := Qry;
        //MESSAGE(Qry);
        RecordSet := SQLConnection.Execute(SQLQuery);//B2B


        SQLConnection.Close;//B2B
        */
        //<< ORACLE UPG
    end;


    procedure CommaRemoval(Base: Text[30]) Converted: Text[30];
    var
        i: Integer;
    begin
        FOR i := 1 TO STRLEN(Base) DO BEGIN
            IF (COPYSTR(Base, i, 1) <> ',') AND (COPYSTR(Base, i, 1) <> '''') AND (COPYSTR(Base, i, 1) <> '&') THEN
                Converted += COPYSTR(Base, i, 1);
        END;
        EXIT(Converted);
    end;


    procedure Apos_Removal(Base: Text[30]) Converted: Text[30];
    begin
        FOR i := 1 TO STRLEN(Base) DO BEGIN
            IF COPYSTR(Base, i, 1) <> '''' THEN
                Converted += COPYSTR(Base, i, 1);
        END;
        EXIT(Converted);
    end;


    procedure Item_Availability("Item No.": Code[20]; "Serial No.": Code[20]; "Location Code": Code[10]; "Working Status": Enum WORKINGSTATUS);
    var
        "Item Ledger Entry": Record "Item Ledger Entry";
        SIL: Record "Service Item Line";
    begin

        // VERIFYING THE WHETHER ITEM WAS AVAILABLE OR NOT
        SIL.RESET;
        SIL.SETFILTER(SIL."Item No.", "Item No.");
        SIL.SETFILTER(SIL."Serial No.", "Serial No.");
        SIL.SETFILTER(SIL."Repair Status Code", '<>%1', 'FINISHED');
        IF SIL.FINDFIRST THEN BEGIN
            ERROR('Close the Service order ' + SIL."Document No." + ' Before U perform this Operation');
        END;

        "Item Ledger Entry".SETCURRENTKEY("Item Ledger Entry"."Item No.", "Item Ledger Entry"."Lot No.", "Item Ledger Entry"."Serial No.");
        "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Item No.", "Item No.");
        "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Serial No.", "Serial No.");
        "Item Ledger Entry".SETFILTER("Item Ledger Entry"."Remaining Quantity", '>%1', 0);
        IF "Item Ledger Entry".FIND('-') THEN BEGIN
            IF ("Item Ledger Entry"."Location Code" = 'SITE') THEN BEGIN
                // TRANSFER THE ITEM FROM EXISTED LOCATION TO PRESENT LOCATION
                Material_Transfer("Item No.", "Serial No.", 'SITE', 'DUMMY', "Item Ledger Entry"."Global Dimension 2 Code");
                Material_Transfer("Item No.", "Serial No.", 'DUMMY', 'SITE', "Location Code");

                // UPDATING THE SERVICE ITEM INFORMATION
                "Create (Or) Update Serv_Item"("Item No.", "Serial No.", "Location Code", "Working Status");
            END ELSE BEGIN
                // TRANSFER THE ITEM FROM EXISTED LOCATION TO PRESENT LOCATION
                Material_Transfer("Item No.", "Serial No.", "Item Ledger Entry"."Location Code", 'SITE', "Location Code");

                // UPDATING THE SERVICE ITEM INFORMATION
                "Create (Or) Update Serv_Item"("Item No.", "Serial No.", "Location Code", "Working Status");
            END;





        END ELSE BEGIN
            // POSTIVE THE ITEM TO THE SITE
            Item_Positive_Adjustment("Item No.", "Serial No.", "Location Code");

            // CREATE THE SERVICE ITEM AND UPDATE THE WORKING STATUS INFORMATION
            "Create (Or) Update Serv_Item"("Item No.", "Serial No.", "Location Code", "Working Status");
        END;


        /*
        // VERIFYING THE WHETHER ITEM WAS AVAILABLE OR NOT
        "Item Ledger Entry".SETCURRENTKEY("Item Ledger Entry"."Item No.","Item Ledger Entry"."Lot No.","Item Ledger Entry"."Serial No.");
        "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Item No.","Item No.");
        "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Serial No.","Serial No.");
        "Item Ledger Entry".SETFILTER("Item Ledger Entry"."Remaining Quantity",'>%1',0);
        IF "Item Ledger Entry".FIND('-') THEN
        BEGIN
          IF ("Item Ledger Entry"."Location Code"='CS') THEN
          BEGIN
              "Item Ledger Entry"."Global Dimension 2 Code":='H-OFF';
              "Item Ledger Entry".MODIFY;
        
        
            // UPDATING THE SERVICE ITEM INFORMATION
            "Create (Or) Update Serv_Item"("Item No.","Serial No.","Location Code","Working Status");
          END ELSE
          BEGIN
             // TRANSFER THE ITEM FROM EXISTED LOCATION TO PRESENT LOCATION
               Material_Transfer("Item No.","Serial No.","Item Ledger Entry"."Location Code",'CS',"Location Code");
        
        
            // UPDATING THE SERVICE ITEM INFORMATION
              "Create (Or) Update Serv_Item"("Item No.","Serial No.",'H-OFF',"Working Status");
          END;
        END ELSE
        BEGIN
          // POSTIVE THE ITEM TO THE SITE
            Item_Positive_Adjustment("Item No.","Serial No.","Location Code");
        
          // CREATE THE SERVICE ITEM AND UPDATE THE WORKING STATUS INFORMATION
            "Create (Or) Update Serv_Item"("Item No.","Serial No.","Location Code","Working Status");
        END;
              */

    end;


    procedure Material_Transfer("Item No.": Code[20]; "Serial No.": Code[20]; From_Location: Code[10]; To_Location: Code[10]; Temp: Code[10]);
    var
        "Tracking Specification": Record "Mat.Issue Track. Specification";
        "Material Issues Header": Record "Material Issues Header";
        MaterialIssueLine: Record "Material Issues Line";
        InventorySetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit 396;
        ManufacturingSetup: Record "Manufacturing Setup";
        USER: Record User;
        LineNo: Integer;
        "Item Ledger Entry": Record "Item Ledger Entry";
        "MaterialIssueOrde-Post Receipt": Codeunit "MaterialIssueOrde-Post Receipt";
    begin
        "Material Issues Header".INIT;
        InventorySetup.GET;
        ManufacturingSetup.GET();

        ManufacturingSetup.TESTFIELD("MI Transfer From Code");
        "Material Issues Header".RESET;
        "Material Issues Header".INIT;
        "Material Issues Header"."No." := GetNextNo;
        //  MESSAGE('Material Issue '+"Item No."+'-'+"Serial No.");
        "Material Issues Header"."Receipt Date" := TODAY;
        "Material Issues Header"."Transfer-from Code" := From_Location;
        "Material Issues Header"."Transfer-to Code" := To_Location;
        "Material Issues Header".VALIDATE("Prod. Order No.", 'EFF08CSA01');

        "Material Issues Header"."Shortcut Dimension 2 Code" := Temp;
        "Material Issues Header"."Posting Date" := TODAY;
        "Material Issues Header".VALIDATE("Prod. Order Line No.", 10000);
        "Material Issues Header"."User ID" := USERID;
        USER.GET(USERSECURITYID);
        "Material Issues Header"."Resource Name" := USER."User Name";
        "Material Issues Header"."Creation DateTime" := CURRENTDATETIME;
        "Material Issues Header".INSERT;
        "Material Issues Header".VALIDATE("Material Issues Header"."Shortcut Dimension 2 Code", Temp);
        LineNo := 10000;
        MaterialIssueLine.INIT;
        MaterialIssueLine."Document No." := "Material Issues Header"."No.";
        MaterialIssueLine.VALIDATE("Item No.", "Item No.");
        MaterialIssueLine."Line No." := LineNo;
        //  MaterialIssueLine."Unit of Measure Code" := "Unit of Measure";
        //  MaterialIssueLine.VALIDATE("Unit of Measure");
        MaterialIssueLine.VALIDATE(Quantity, 1);
        MaterialIssueLine.VALIDATE("Qty. to Receive", 1);
        MaterialIssueLine.VALIDATE("Outstanding Quantity", 1);
        MaterialIssueLine."Shortcut Dimension 2 Code" := Temp;

        MaterialIssueLine."Prod. Order No." := 'EFF08CSA01';
        MaterialIssueLine."Prod. Order Line No." := 10000;
        LineNo := LineNo + 10000;
        MaterialIssueLine.INSERT;
        MaterialIssueLine.VALIDATE(MaterialIssueLine."Shortcut Dimension 2 Code", Temp);
        "Tracking Specification".INIT;
        "Tracking Specification"."Order No." := "Material Issues Header"."No.";
        "Tracking Specification"."Order Line No." := 10000;
        "Tracking Specification"."Item No." := "Item No.";
        "Tracking Specification"."Location Code" := From_Location;
        "Tracking Specification".Quantity := 1;
        "Tracking Specification"."Serial No." := "Serial No.";
        "Tracking Specification"."Prod. Order No." := 'EFF08CSA01';
        "Tracking Specification"."Prod. Order Line No." := 10000;
        "Tracking Specification"."Product Group Code" := MaterialIssueLine."Product Group Code";
        "Item Ledger Entry".SETCURRENTKEY("Item Ledger Entry"."Item No.",
                                          "Item Ledger Entry"."Lot No.",
                                          "Item Ledger Entry"."Serial No.");
        "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Item No.", "Item No.");
        "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Serial No.", "Serial No.");
        "Item Ledger Entry".SETFILTER("Item Ledger Entry"."Remaining Quantity", '>%1', 0);
        IF "Item Ledger Entry".FIND('-') THEN BEGIN
            "Tracking Specification"."Lot No." := "Item Ledger Entry"."Lot No.";
            "Tracking Specification"."Appl.-to Item Entry" := "Item Ledger Entry"."Entry No."
        END ELSE
            ERROR('THERE IS NO APPLIED ENTRY FOR THIS SERIAL NO.');
        "Tracking Specification".INSERT;


        "Material Issues Header".VALIDATE("Material Issues Header".Status, "Material Issues Header".Status::Released);
        "Material Issues Header".VALIDATE("Material Issues Header"."Released Date", WORKDATE);
        "Material Issues Header".VALIDATE("Material Issues Header"."Released Time", TIME);
        "Material Issues Header".VALIDATE("Material Issues Header"."Released By", USERID);
        "Material Issues Header".MODIFY;

        "MaterialIssueOrde-Post Receipt".Issues_Post("Material Issues Header");
    end;


    procedure "Create (Or) Update Serv_Item"("Item No.": Code[20]; "Serial No.": Code[20]; "Present Location": Code[10]; "Working Status": Enum WORKINGSTATUS);
    var
        "Service_ Item": Record "Service Item";
        "Item Ledger Entry": Record "Item Ledger Entry";
        NoSeriesMgt: Codeunit 396;
        "Dimension Value": Record "Dimension Value";
    begin
        //   MESSAGE('Service Item Updation'+"Item No.");
        "Service_ Item".RESET;
        "Service_ Item".SETCURRENTKEY("Service_ Item"."Item No.", "Service_ Item"."Serial No.");
        "Service_ Item".SETRANGE("Service_ Item"."Item No.", "Item No.");
        "Service_ Item".SETRANGE("Service_ Item"."Serial No.", "Serial No.");
        IF NOT ("Service_ Item".FIND('-')) THEN BEGIN
            "Service_ Item".INIT;
            "Service_ Item"."No." := NoSeriesMgt.GetNextNo('SI-CSM', TODAY, TRUE);
            "Service_ Item".INSERT;
            "Service_ Item"."Item No." := "Item No.";
            "Service_ Item".VALIDATE("Service_ Item"."Item No.", "Item No.");

            "Service_ Item"."Serial No." := "Serial No.";
            "Service_ Item"."No. Series" := 'SI-CSM';
            "Dimension Value".RESET;
            "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
            "Dimension Value".SETRANGE("Dimension Value".Code, "Present Location");
            IF "Dimension Value".FIND('-') THEN
                "Service_ Item"."Present Location" := "Dimension Value".Name;
            "Service_ Item"."WORKING STATUS" := "Working Status";
            "Item Ledger Entry".RESET;
            "Item Ledger Entry".SETCURRENTKEY("Item Ledger Entry"."Item No.",
                                              "Item Ledger Entry"."Lot No.",
                                              "Item Ledger Entry"."Serial No.");
            "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Item No.", "Item No.");

            "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Serial No.", "Serial No.");
            "Item Ledger Entry".SETFILTER("Item Ledger Entry"."Remaining Quantity", '>%1', 0);
            IF "Item Ledger Entry".FIND('-') THEN BEGIN
                "Service_ Item".ITLSNO := "Item Ledger Entry"."Entry No.";
                "Service_ Item".VALIDATE("Service_ Item".ITLSNO, "Item Ledger Entry"."Entry No.");
            END;
            "Service_ Item".MODIFY;
        END ELSE BEGIN
            "Dimension Value".RESET;
            "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
            "Dimension Value".SETRANGE("Dimension Value".Code, "Present Location");
            IF "Dimension Value".FIND('-') THEN
                "Service_ Item"."Present Location" := "Dimension Value".Name;
            "Service_ Item"."WORKING STATUS" := "Working Status";
            "Item Ledger Entry".RESET;
            "Item Ledger Entry".SETCURRENTKEY("Item Ledger Entry"."Item No.",
                                              "Item Ledger Entry"."Lot No.",
                                              "Item Ledger Entry"."Serial No.");
            "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Item No.", "Item No.");

            "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Serial No.", "Serial No.");
            "Item Ledger Entry".SETFILTER("Item Ledger Entry"."Remaining Quantity", '>%1', 0);
            IF "Item Ledger Entry".FIND('-') THEN BEGIN
                "Service_ Item".ITLSNO := "Item Ledger Entry"."Entry No.";
                "Service_ Item".VALIDATE("Service_ Item".ITLSNO, "Item Ledger Entry"."Entry No.");
            END;

            "Service_ Item".MODIFY;
        END;
    end;


    procedure Item_Positive_Adjustment("Item No.": Code[20]; "Serial No.": Code[20]; "Location Code": Code[10]);
    var
        "Item Journal Line": Record "Item Journal Line";
        "Reservation Entry": Record "Reservation Entry";
        "Reservation Entry1": Record "Reservation Entry";
        NoSeriesMgt: Codeunit 396;
        "Item Ledger Entry": Record "Item Ledger Entry";
    begin
        //Deleted Var (Journal Line DimensionRecordTable356) B2B
        "Item Ledger Entry".RESET;
        "Item Ledger Entry".SETCURRENTKEY("Item Ledger Entry"."Item No.",
                                          "Item Ledger Entry"."Lot No.",
                                          "Item Ledger Entry"."Serial No.");
        "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Item No.", "Item No.");
        "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Serial No.", "Serial No.");
        "Item Ledger Entry".SETFILTER("Item Ledger Entry"."Remaining Quantity", '>%1', 0);
        IF NOT "Item Ledger Entry".FIND('-') THEN BEGIN
            // INSERTING RECORD IN ITEM JOURNAL LINE
            "Item Journal Line".INIT;
            "Item Journal Line"."Journal Template Name" := 'ITEM';
            "Item Journal Line"."Journal Batch Name" := 'POS-CS-SIG';
            "Item Journal Line"."Entry Type" := "Item Journal Line"."Entry Type"::"Positive Adjmt.";
            "Item Journal Line"."Line No." := 10000;
            "Item Journal Line"."Source Code" := 'ITEMJNL';
            //"Item Journal Line"."Serial No.":="Serial No.";
            //"Item Journal Line"."Lot No.":=ICNNO(TODAY)+'SA01';
            "Item Journal Line"."Document No." := NoSeriesMgt.GetNextNo('POS-ADJ-CS', TODAY, FALSE);



            "Item Journal Line".VALIDATE("Item Journal Line"."Item No.", "Item No.");
            "Item Journal Line".VALIDATE(Quantity, 1);
            "Item Journal Line".VALIDATE("Location Code", 'SITE');
            "Item Journal Line".VALIDATE("Shortcut Dimension 2 Code", "Location Code");
            "Item Journal Line"."User ID" := USERID;
            "Item Journal Line"."Document Date" := TODAY;
            "Item Journal Line".INSERT;


            // INSERTING RECORD IN RESERVATION ENTRY
            "Reservation Entry".INIT;
            IF "Reservation Entry1".FIND('+') THEN
                "Reservation Entry"."Entry No." := "Reservation Entry1"."Entry No." + 1;
            "Reservation Entry".VALIDATE("Item No.", "Item No.");
            "Reservation Entry".VALIDATE("Location Code", 'SITE');
            "Reservation Entry".VALIDATE("Quantity (Base)", 1);
            "Reservation Entry"."Reservation Status" := "Reservation Entry"."Reservation Status"::Prospect;
            "Reservation Entry"."Creation Date" := TODAY;
            "Reservation Entry"."Source Type" := 83;
            "Reservation Entry"."Source Subtype" := 2;
            "Reservation Entry"."Source ID" := 'ITEM';
            "Reservation Entry"."Source Batch Name" := 'POS-CS-SIG';
            "Reservation Entry"."Source Ref. No." := 10000;
            "Reservation Entry"."Created By" := 'SUPER';
            "Reservation Entry".Positive := TRUE;
            "Reservation Entry"."Expected Receipt Date" := TODAY;
            "Reservation Entry".VALIDATE("Serial No.", "Serial No.");
            "Reservation Entry"."Lot No." := ICNNO(TODAY) + 'SA01';
            //"Reservation Entry".Quantity:=1;
            "Reservation Entry".INSERT;


            /*  // INSERTING JOURNAL LINE DIMENSION
              "Journal Line Dimension".INIT;
              "Journal Line Dimension"."Table ID":=83;
              "Journal Line Dimension"."Journal Template Name":='ITEM';
              "Journal Line Dimension"."Journal Batch Name":='POS-CS-SIG';
              "Journal Line Dimension"."Journal Line No.":=10000;
              "Journal Line Dimension"."Dimension Code":='LOCATIONS';
              "Journal Line Dimension"."Dimension Value Code":="Location Code";
              "Journal Line Dimension".INSERT;*/
        END ELSE
            ERROR(' ITEM WAS ALLREADY AVAILABLE IN INVENTORY');


        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", "Item Journal Line");

    end;


    procedure GetNextNo() NumberValue: Code[20];
    var
        DateValue: Text[30];
        MonthValue: Text[30];
        YearValue: Text[30];
        MaterialIssuesHeaderLocal: Record "Material Issues Header";
        PostedMatIssHeaderLocal: Record "Posted Material Issues Header";
        LastNumber: Code[20];
    begin
        IF DATE2DMY(WORKDATE, 1) < 10 THEN
            DateValue := '0' + FORMAT(DATE2DMY(WORKDATE, 1))
        ELSE
            DateValue := FORMAT(DATE2DMY(WORKDATE, 1));

        IF DATE2DMY(WORKDATE, 2) < 10 THEN
            MonthValue := '0' + FORMAT(DATE2DMY(WORKDATE, 2))
        ELSE
            MonthValue := FORMAT(DATE2DMY(WORKDATE, 2));

        //IF DATE2DMY(WORKDATE,2) < 10 THEN
        YearValue := COPYSTR(FORMAT(DATE2DMY(WORKDATE, 3)), 3, 2);

        NumberValue := 'R' + YearValue + MonthValue + DateValue;

        LastNumber := NumberValue + '000';
        MaterialIssuesHeaderLocal.RESET;
        MaterialIssuesHeaderLocal.SETFILTER("No.", NumberValue + '*');
        IF MaterialIssuesHeaderLocal.FIND('+') THEN
            LastNumber := MaterialIssuesHeaderLocal."No.";

        PostedMatIssHeaderLocal.RESET;
        PostedMatIssHeaderLocal.SETCURRENTKEY("Material Issue No.");
        PostedMatIssHeaderLocal.SETFILTER("Material Issue No.", NumberValue + '*');
        IF PostedMatIssHeaderLocal.FIND('+') THEN
            IF LastNumber < PostedMatIssHeaderLocal."Material Issue No." THEN
                LastNumber := PostedMatIssHeaderLocal."Material Issue No.";

        NumberValue := INCSTR(LastNumber);
    end;


    procedure Move_Item_To_Old_Stock("Item No.": Code[20]; "Serial No.": Code[20]; Location: Code[10]; "Working Status": Enum WORKINGSTATUS);
    begin
        Material_Transfer("Item No.", "Serial No.", 'SITE', 'OLD STOCK', Location);
        "Create (Or) Update Serv_Item"("Item No.", "Serial No.", Location, "Working Status");
    end;


    procedure Update_SMS_Data();
    var
        "Working Status": Option WORKING,"NON-WORKING";
    begin
        /*IF ISCLEAR(SQLConnection) THEN
          CREATE(SQLConnection);
        
        IF ISCLEAR(RecordSet) THEN
          CREATE(RecordSet);
         *///B2B
        WebRecStatus := Quotes + Text50001 + Quotes;
        OldWebStatus := Quotes + Text50002 + Quotes;
        "G|l".GET;
        /*
        SQLConnection.ConnectionString :='DSN=ERP-SMS;UID=csonline;PASSWORD=adminsms;SERVER=oracle_223;';
        SQLConnection.Open;
        SQLConnection.BeginTrans;
        */
        // CODE FOR UPDATION OF REPLACED ITEM DETAILS

        SQLQuery := 'SELECT TO_CHAR( PLACED_ITEM )  PLACED_ITEM ,' +
                           'TO_CHAR( PLACED_ITEM_SERIAL_NO )  PLACED_ITEM_SERIAL_NO ,' +
                           'TO_CHAR( PLACED_ITEM_LOCATION_CODE )  PLACED_ITEM_LOCATION_CODE ,' +
                           'TO_CHAR( PICKED_ITEM )  PICKED_ITEM ,' +
                           'TO_CHAR( PICKED_ITEM_SERIAL_NO )  PICKED_ITEM_SERIAL_NO ,' +
                           'TO_CHAR( ITEM_STATUS_DESC )  ITEM_STATUS_DESC ,' +
                           'TO_CHAR( REPLACE_ID )  REPLACE_ID ' +
                    '  FROM            SMS_ITEM_REPLACE_DETAILS_VIEW ' +
                    ' WHERE  UPDATED_IN_ERP=0';
        /*RecordSet := SQLConnection.Execute(SQLQuery);//B2B
          IF NOT (RecordSet.EOF OR RecordSet.BOF) THEN
             RecordSet.MoveFirst;
        WHILE NOT RecordSet.EOF DO
        BEGIN
        
          Material_Transfer(FORMAT(RecordSet.Fields.Item('PLACED_ITEM').Value),
                            FORMAT(RecordSet.Fields.Item('PLACED_ITEM_SERIAL_NO').Value),
                            'SITE',
                            'OLD STOCK',
                            FORMAT(RecordSet.Fields.Item('PLACED_ITEM_LOCATION_CODE').Value));
          IF (FORMAT(RecordSet.Fields.Item('ITEM_STATUS_DESC').Value)='NOT WORKING') OR
             (FORMAT(RecordSet.Fields.Item('ITEM_STATUS_DESC').Value)='DAMAGED')     THEN
            "Working Status":="Working Status"::"NON-WORKING"
          ELSE
            "Working Status":="Working Status"::WORKING;
        
          "Create (Or) Update Serv_Item"(FORMAT(RecordSet.Fields.Item('PLACED_ITEM').Value),
                                         FORMAT(RecordSet.Fields.Item('PLACED_ITEM_SERIAL_NO').Value),
                                         'OLD STOCK',"Working Status");
        
          SQLQuery1:='UPDATE SMS_ITEM_REPLACE_DETAILS_VIEW SET UPDATED_IN_ERP=1 WHERE REPLACE_ID='+
                     FORMAT(RecordSet.Fields.Item('REPLACE_ID').Value);
        
           SQLConnection.Execute(SQLQuery1);
          RecordSet.MoveNext;
        END;
        *///B2B
          // CODE FOR UPDATION OF SMS_ITEM_MOVEMENT_DETAILS_VIEW

        SQLQuery := 'SELECT TO_CHAR( SERVICE_ITEM             )  SERVICE_ITEM ,' +
                          'TO_CHAR( SERVICE_ITEM_SERIAL_NO   )  SERVICE_ITEM_SERIAL_NO ,' +
                          'TO_CHAR( FROM_LOCATION_CODE       )  FROM_LOCATION_CODE ,' +
                          'TO_CHAR( TO_LOCATION_CODE         )  TO_LOCATION_CODE ,' +
                          'TO_CHAR( MOVEMENT_ID        )  MOVEMENT_ID  ' +
                    ' FROM   SMS_ITEM_MOVEMENT_DETAILS_VIEW ' +
                    ' WHERE  UPDATED_IN_ERP=0';

        /*
        RecordSet := SQLConnection.Execute(SQLQuery);
        IF NOT (RecordSet.EOF OR RecordSet.BOF) THEN
           RecordSet.MoveFirst;
        WHILE NOT RecordSet.EOF DO
        BEGIN
          Material_Transfer(FORMAT(RecordSet.Fields.Item('SERVICE_ITEM').Value),
                            FORMAT(RecordSet.Fields.Item('SERVICE_ITEM_SERIAL_NO').Value),
                            'SITE','DUMMY',
                            FORMAT(RecordSet.Fields.Item('FROM_LOCATION_CODE').Value));
          Material_Transfer(FORMAT(RecordSet.Fields.Item('SERVICE_ITEM').Value),
                            FORMAT(RecordSet.Fields.Item('SERVICE_ITEM_SERIAL_NO').Value),
                            'DUMMY','SITE',
                            FORMAT(RecordSet.Fields.Item('TO_LOCATION_CODE').Value));
          SQLQuery :='SELECT TO_CHAR( SERVICE_ITEM             )  SERVICE_ITEM ,'+
                          'TO_CHAR( SERVICE_ITEM_SERIAL_NO   )  SERVICE_ITEM_SERIAL_NO ,'+
        
                                           'TO_CHAR( FROM_LOCATION_CODE       )  FROM_LOCATION_CODE ,'+
                          'TO_CHAR( TO_LOCATION_CODE         )  TO_LOCATION_CODE '+
                    ' FROM   SMS_ITEM_MOVEMENT_DETAILS_VIEW '+
                    ' WHERE  UPDATED_IN_ERP=0';
        
          SQLQuery1:='UPDATE SMS_ITEM_MOVEMENT_DETAILS_VIEW SET UPDATED_IN_ERP=1 WHERE MOVEMENT_ID='+
                     FORMAT(RecordSet.Fields.Item('MOVEMENT_ID').Value);
          SQLConnection.Execute(SQLQuery1);
          RecordSet.MoveNext;
        END;
        
        SQLConnection.CommitTrans;
        SQLConnection.Close;
        *///B2B

    end;


    procedure ICNNO(DT: Date) ICN: Code[10];
    var
        Dat: Text[30];
        Mon: Text[30];
        Yer: Text[30];
    begin
        IF DATE2DMY(DT, 1) < 10 THEN
            Dat := '0' + FORMAT(DATE2DMY(DT, 1))
        ELSE
            Dat := FORMAT(DATE2DMY(DT, 1));

        IF DATE2DMY(DT, 2) < 10 THEN
            Mon := '0' + FORMAT(DATE2DMY(DT, 2))
        ELSE
            Mon := FORMAT(DATE2DMY(DT, 2));

        //IF DATE2DMY(DT,2) < 10 THEN
        Yer := COPYSTR(FORMAT(DATE2DMY(DT, 3)), 3, 2);
        ICN := Dat + Mon + Yer;
        EXIT(ICN);
    end;


    procedure DEPT_DATA_UPDATION();
    begin
        /*
        IF ISCLEAR(SQLConnection) THEN
          CREATE(SQLConnection);
        
        IF ISCLEAR(RecordSet) THEN
          CREATE(RecordSet);
        *///B2B
        WebRecStatus := Quotes + Text50001 + Quotes;
        OldWebStatus := Quotes + Text50002 + Quotes;
        "G|l".GET;
        /*
        SQLConnection.ConnectionString :="G|l"."Sql Connection String";
        
        SQLConnection.Open;
        *///B2B
        SQLQuery := 'Select To_Char(ORDERNO) Order_No,' +
                   'To_ChaR(ORDER_LINE_NO) Line_No,' +
                   'To_number(PURCHASE_ID)   PID From Purchase_Line where ACTINACT=1';
        /*
        RecordSet := SQLConnection.Execute(SQLQuery);
        IF NOT((RecordSet.BOF) OR (RecordSet.EOF)) THEN
             RecordSet.MoveFirst;
        
        WHILE NOT RecordSet.EOF DO
        BEGIN
          "Purchase Line".RESET;
          "Purchase Line".SETRANGE("Purchase Line"."Document No.",FORMAT(RecordSet.Fields.Item('Order_No').Value));
          EVALUATE(ORDER_LINE_NO,FORMAT(RecordSet.Fields.Item('Line_No').Value));
          "Purchase Line".SETRANGE("Purchase Line"."Line No.",ORDER_LINE_NO);
          IF "Purchase Line".FINDFIRST THEN
          BEGIN
            IF "Purchase Line"."Location Code"='CS STR' THEN
               DEPT:='CS'
            ELSE
               DEPT:='NORMAL';
            PID:=FORMAT(RecordSet.Fields.Item('PID'));
            SQLQuery:='UPDATE Purchase_Line SET DEPT_WISE='''+DEPT+
                      ''' WHERE ORDERNO='''+FORMAT(RecordSet.Fields.Item('Order_No').Value)+''' and '+
                      ' ORDER_LINE_NO='''+FORMAT(ORDER_LINE_NO)+'''';
        
            SQLConnection.Execute(SQLQuery);
        
          END;
          RecordSet.MoveNext;
        END;
        SQLConnection.Close;
        SQLConnection.Open;
        */

        SQLQuery := 'Select To_Char(ORDERNO) Order_No,' +
                   'To_ChaR(ORDER_LINE_NO) Line_No ' +
                   ' From Receipt_Line ';
        /*
        RecordSet := SQLConnection.Execute(SQLQuery);
        IF NOT((RecordSet.BOF) OR (RecordSet.EOF)) THEN
             RecordSet.MoveFirst;
        
        WHILE NOT RecordSet.EOF DO
        BEGIN
          "Purchase Line".RESET;
          "Purchase Line".SETRANGE("Purchase Line"."Document No.",FORMAT(RecordSet.Fields.Item('Order_No').Value));
          EVALUATE(ORDER_LINE_NO,FORMAT(RecordSet.Fields.Item('Line_No').Value));
          "Purchase Line".SETRANGE("Purchase Line"."Line No.",ORDER_LINE_NO);
          IF "Purchase Line".FINDFIRST THEN
          BEGIN
            IF "Purchase Line"."Location Code"='CS STR' THEN
               DEPT:='CS'
            ELSE
               DEPT:='NORMAL';
        
            SQLQuery:='UPDATE Receipt_Line SET DEPT_WISE='''+DEPT+
                      ''' WHERE ORDERNO='''+FORMAT(RecordSet.Fields.Item('Order_No').Value)+''' and '+
                      ' ORDER_LINE_NO='''+FORMAT(ORDER_LINE_NO)+'''';
        
            SQLConnection.Execute(SQLQuery);
        
          END;
          RecordSet.MoveNext;
        END;
        SQLConnection.Close;
        
        
        
        SQLConnection.Open;
        *///B2B
        SQLQuery := 'Select To_Char(ORDERNO) Order_No,' +
                   'To_ChaR(ORDER_LINE_NO) Line_No ' +
                   ' From Invoice_Line ';
        /*
        RecordSet := SQLConnection.Execute(SQLQuery);
        IF NOT((RecordSet.BOF) OR (RecordSet.EOF)) THEN
             RecordSet.MoveFirst;
        
        WHILE NOT RecordSet.EOF DO
        BEGIN
          "Purchase Line".RESET;
          "Purchase Line".SETRANGE("Purchase Line"."Document No.",FORMAT(RecordSet.Fields.Item('Order_No').Value));
          EVALUATE(ORDER_LINE_NO,FORMAT(RecordSet.Fields.Item('Line_No').Value));
          "Purchase Line".SETRANGE("Purchase Line"."Line No.",ORDER_LINE_NO);
          IF "Purchase Line".FINDFIRST THEN
          BEGIN
            IF "Purchase Line"."Location Code"='CS STR' THEN
               DEPT:='CS'
            ELSE
               DEPT:='NORMAL';
        
            SQLQuery:='UPDATE Invoice_Line SET DEPT_WISE='''+DEPT+
                      ''' WHERE ORDERNO='''+FORMAT(RecordSet.Fields.Item('Order_No').Value)+''' and '+
                      ' ORDER_LINE_NO='''+FORMAT(ORDER_LINE_NO)+'''';
        
            SQLConnection.Execute(SQLQuery);
        
          END;
          RecordSet.MoveNext;
        END;
        SQLConnection.Close;
        *///B2B

    end;


    procedure Item_Removal("Item No.": Code[20]; "Serial No.": Code[20]; "Location Code": Code[10]; "Working Status": Enum WORKINGSTATUS);
    var
        "Item Ledger Entry": Record "Item Ledger Entry";
        SIL: Record "Service Item Line";
    begin
        "Working Status" := "Working Status"::"NON-WORKING";
        "Item Ledger Entry".SETCURRENTKEY("Item Ledger Entry"."Item No.", "Item Ledger Entry"."Lot No.", "Item Ledger Entry"."Serial No.");
        "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Item No.", "Item No.");
        "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Serial No.", "Serial No.");
        "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Global Dimension 2 Code", "Location Code");
        "Item Ledger Entry".SETFILTER("Item Ledger Entry"."Remaining Quantity", '>%1', 0);
        IF "Item Ledger Entry".FIND('-') THEN BEGIN
            Material_Transfer("Item No.", "Serial No.", 'SITE', 'OLD STOCK', "Location Code");

            "Create (Or) Update Serv_Item"("Item No.", "Serial No.", "Location Code", "Working Status");

        END ELSE
            ERROR('The Item is not in Given Location');
    end;


    procedure Move_Item_To_Site_OR_Old_Stock("Item No.": Code[20]; Site: Code[10]; "Old Serial No.": Code[20]; "New Serial No.": Code[20]);
    var
        "Item Ledger Entry": Record "Item Ledger Entry";
        ILE: Record "Item Ledger Entry";
        Is_Clear_OldCard: Boolean;
        Is_Clear_NewCard: Boolean;
    begin
        "Item Ledger Entry".SETCURRENTKEY("Item Ledger Entry"."Item No.", "Item Ledger Entry"."Lot No.", "Item Ledger Entry"."Serial No.");
        "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Item No.", "Item No.");
        "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Serial No.", "New Serial No.");
        "Item Ledger Entry".SETFILTER("Item Ledger Entry"."Remaining Quantity", '>%1', 0);
        "Item Ledger Entry".SETFILTER("Item Ledger Entry"."Location Code", 'SITE');
        "Item Ledger Entry".SETFILTER("Item Ledger Entry"."Global Dimension 2 Code", Site);
        IF "Item Ledger Entry".FIND('-') THEN BEGIN
            Is_Clear_OldCard := FALSE;
            Is_Clear_NewCard := TRUE;
            ILE.SETCURRENTKEY(ILE."Item No.", ILE."Lot No.", ILE."Serial No.");
            ILE.SETRANGE(ILE."Item No.", "Item No.");
            ILE.SETRANGE(ILE."Serial No.", "Old Serial No.");
            ILE.SETFILTER(ILE."Remaining Quantity", '>%1', 0);
            IF ILE.FINDFIRST THEN BEGIN
                IF NOT (ILE."Location Code" = 'OLD STOCK') THEN
                    ERROR('The old card is already in location %1', "Item Ledger Entry"."Location Code")
                ELSE
                    Is_Clear_OldCard := TRUE;
            END;
        END ELSE
            ERROR('The new card is not in Specified Location');

        IF Is_Clear_NewCard THEN BEGIN
            Material_Transfer("Item No.", "New Serial No.", 'SITE', 'OLD STOCK', Site);
            "Create (Or) Update Serv_Item"("Item No.", "New Serial No.", Site, Working::Working);
            IF NOT Is_Clear_OldCard THEN
                Item_Positive_Adjust_OldStock("Item No.", "Old Serial No.", 'OLD STOCK');
            Material_Transfer("Item No.", "Old Serial No.", 'OLD STOCK', 'SITE', Site);
            "Create (Or) Update Serv_Item"("Item No.", "Old Serial No.", Site, Working);
        END;
    end;


    procedure Item_Positive_Adjust_OldStock("Item No.": Code[20]; "Serial No.": Code[20]; "Location Code": Code[10]);
    var
        "Item Journal Line": Record "Item Journal Line";
        "Reservation Entry": Record "Reservation Entry";
        "Reservation Entry1": Record "Reservation Entry";
        NoSeriesMgt: Codeunit 396;
        "Item Ledger Entry": Record "Item Ledger Entry";
    begin
        //Deleted Var (Journal Line DimensionRecordTable356) B2B
        "Item Ledger Entry".RESET;
        "Item Ledger Entry".SETCURRENTKEY("Item Ledger Entry"."Item No.",
                                          "Item Ledger Entry"."Lot No.",
                                          "Item Ledger Entry"."Serial No.");
        "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Item No.", "Item No.");
        "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Serial No.", "Serial No.");
        "Item Ledger Entry".SETFILTER("Item Ledger Entry"."Remaining Quantity", '>%1', 0);
        IF NOT "Item Ledger Entry".FIND('-') THEN BEGIN
            // INSERTING RECORD IN ITEM JOURNAL LINE
            "Item Journal Line".INIT;
            "Item Journal Line"."Journal Template Name" := 'ITEM';
            "Item Journal Line"."Journal Batch Name" := 'POS-CS-SIG';
            "Item Journal Line"."Entry Type" := "Item Journal Line"."Entry Type"::"Positive Adjmt.";
            "Item Journal Line"."Line No." := 10000;
            "Item Journal Line"."Source Code" := 'ITEMJNL';
            //"Item Journal Line"."Serial No.":="Serial No.";
            //"Item Journal Line"."Lot No.":=ICNNO(TODAY)+'SA01';
            "Item Journal Line"."Document No." := NoSeriesMgt.GetNextNo('POS-ADJ-CS', TODAY, FALSE);
            "Item Journal Line".VALIDATE(Quantity, 1);


            "Item Journal Line".VALIDATE("Item Journal Line"."Item No.", "Item No.");
            "Item Journal Line".VALIDATE("Location Code", 'OLD STOCK');
            "Item Journal Line".VALIDATE("Shortcut Dimension 2 Code", "Location Code");
            "Item Journal Line"."User ID" := USERID;
            "Item Journal Line"."Document Date" := TODAY;
            "Item Journal Line".INSERT;


            // INSERTING RECORD IN RESERVATION ENTRY
            "Reservation Entry".INIT;
            IF "Reservation Entry1".FIND('+') THEN
                "Reservation Entry"."Entry No." := "Reservation Entry1"."Entry No." + 1;
            "Reservation Entry".VALIDATE("Item No.", "Item No.");
            "Reservation Entry".VALIDATE("Location Code", 'OLD STOCK');
            "Reservation Entry".VALIDATE("Quantity (Base)", 1);
            "Reservation Entry"."Reservation Status" := "Reservation Entry"."Reservation Status"::Prospect;
            "Reservation Entry"."Creation Date" := TODAY;
            "Reservation Entry"."Source Type" := 83;
            "Reservation Entry"."Source Subtype" := 2;
            "Reservation Entry"."Source ID" := 'ITEM';
            "Reservation Entry"."Source Batch Name" := 'POS-CS-SIG';
            "Reservation Entry"."Source Ref. No." := 10000;
            "Reservation Entry"."Created By" := 'SUPER';
            "Reservation Entry".Positive := TRUE;
            "Reservation Entry"."Expected Receipt Date" := TODAY;
            "Reservation Entry".VALIDATE("Serial No.", "Serial No.");
            "Reservation Entry"."Lot No." := ICNNO(TODAY) + 'SA01';
            //"Reservation Entry".Quantity:=1;
            "Reservation Entry".INSERT;


            /*  // INSERTING JOURNAL LINE DIMENSION
              "Journal Line Dimension".INIT;
              "Journal Line Dimension"."Table ID":=83;
              "Journal Line Dimension"."Journal Template Name":='ITEM';
              "Journal Line Dimension"."Journal Batch Name":='POS-CS-SIG';
              "Journal Line Dimension"."Journal Line No.":=10000;
              "Journal Line Dimension"."Dimension Code":='LOCATIONS';
              "Journal Line Dimension"."Dimension Value Code":="Location Code";
              "Journal Line Dimension".INSERT;*/
        END ELSE
            ERROR(' ITEM WAS ALLREADY AVAILABLE IN INVENTORY');


        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", "Item Journal Line");

    end;

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
}

