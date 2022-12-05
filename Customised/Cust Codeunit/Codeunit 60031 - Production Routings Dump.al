codeunit 60031 "Production Routings Dump"
{

    trigger OnRun();
    begin
        /*IF ISCLEAR(SQLConnection) THEN
          CREATE(SQLConnection);
        
        IF ISCLEAR(RecordSet) THEN
          CREATE(RecordSet);*///B2b1.0


        WebRecStatus := Quotes + Text50001 + Quotes;
        OldWebStatus := Quotes + Text50002 + Quotes;


        /*SQLConnection.ConnectionString :='DSN=salinvoiceuser;UID=salinvoiceuser;PASSWORD=salinvoiceuser;SERVER=oracle_80;';
        SQLConnection.Open;*///B2b1.0
        MESSAGE('Oracle Connected');
        //SQLConnection.BeginTrans;
        SQLQuery1 := 'Delete from PROD_ORD_ROUTINGS';
        //SQLConnection.Execute(SQLQuery1); //B2b1.0
        production_order.SETRANGE(production_order.Status, production_order.Status::Released);
        production_order.SETRANGE(production_order."Prod Start date", TODAY - 10, TODAY + 5);
        //production_order.SETRANGE(production_order."No.",'TEST2');
        IF production_order.FINDSET THEN
            REPEAT
                Item.RESET;
                IF Item.GET(production_order."Source No.") THEN
                    Item_Sub_Grp_Code := Item."Item Sub Group Code";
                "Prod. Order Routing li".SETRANGE("Prod. Order Routing li"."Prod. Order No.", production_order."No.");
                // "Prod. Order Routing li".SETRANGE("Prod. Order Routing li"."Prod. Order No.",'EFF09DLR20');  //EFF09DLR20,EFF09DLR19
                IF "Prod. Order Routing li".FINDSET THEN
                    REPEAT
                        CNT += 1;

                        SQLQuery := 'Insert into PROD_ORD_ROUTINGS(SNO,STATUS,PROD_ORDNO,OPERATION_DESC,ROUTING_REF,DEPARTMENT,' +
                     'BENCH_TIME,ITEM_NO,ITEM_DESC,LAST_DATE_MODIFIED,PROD_START_DATE,QUANTITY,SALEORDERNO,' +
                                                                 'ITEM_SUB_CODE,SOURCENO) VALUES (''' + FORMAT(CNT) + ''',''' +
                                                                   FORMAT("Prod. Order Routing li".Status) + ''',''' +
                                                                   FORMAT("Prod. Order Routing li"."Prod. Order No.") + ''',''' +
                                                     CommaRemoval(FORMAT("Prod. Order Routing li"."Operation Description")) + ''',''' +
                                                                   FORMAT("Prod. Order Routing li"."Item Description") + ''',''' +
                                                                   FORMAT("Prod. Order Routing li"."Work Center No.") + ''',''' +
                                                                   FORMAT("Prod. Order Routing li"."Run Time") + ''',''' +
                                                                   FORMAT(production_order."No.") + ''',''' +
                                                                   FORMAT("Prod. Order Routing li".Description) + ''',''' +
                         FORMAT(production_order."Last Date Modified", 0, '<Day>-<Month Text,3>-<Year4>') + ''',''' +
                         FORMAT(production_order."Prod Start date", 0, '<Day>-<Month Text,3>-<Year4>') + ''',''' +
                         FORMAT("Prod. Order Routing li".Quantity) + ''',''' +
                         FORMAT(production_order."Sales Order No.") + ''',''' +
                         FORMAT(Item_Sub_Grp_Code) + ''',''' +
                         FORMAT(production_order."Source No.") + ''')';


                    /* SQLQuery :='Insert into PROD_ORD_ROUTINGS(SNO,STATUS,PROD_ORDNO,OPERATION_DESC,ROUTING_REF,DEPARTMENT,'+
                                 ' BENCH_TIME,ITEM_NO,ITEM_DESC,LAST_DATE_MODIFIED,PROD_START_DATE,QUANTITY) VALUES ('''+FORMAT(CNT)+''','+
                                 ''''+FORMAT("Prod. Order Routing li".Status)+''','''+FORMAT("Prod. Order Routing li"."Prod. Order No.")+''','''+
                                 //'replace('''+FORMAT("Prod. Order Routing li"."Operation Description")+''','''+','+''','''+''+'''),'+
                                  FORMAT("Prod. Order Routing li"."Operation Description")+''','''+
                                 ''''+FORMAT("Prod. Order Routing li"."Item Description")+''','+
                                 ''''+FORMAT("Prod. Order Routing li"."Work Center No.")+''','+
                                   ''''+FORMAT("Prod. Order Routing li"."Run Time")+''','+
                                 ''''+FORMAT("Prod. Order Routing li"."No.")+''','+
                                 'replace('''+FORMAT("Prod. Order Routing li".Description)+''','''+','+''','''+''+'''),'+
                                 ''''+FORMAT(production_order."Last Date Modified",0,'<Day>-<Month Text,3>-<Year4>')+''','+
                                 ''''+FORMAT(production_order."Prod Start date",0,'<Day>-<Month Text,3>-<Year4>')+''','''+
                                 ''''+FORMAT("Prod. Order Routing li".Quantity)+''')';    */
                    //
                    // MESSAGE(SQLQuery);
                    //SQLConnection.Execute(SQLQuery); //B2b1.0
                    UNTIL "Prod. Order Routing li".NEXT = 0;
            UNTIL production_order.NEXT = 0;

        //SQLConnection.CommitTrans;
        //SQLConnection.Close; //B2b1.0

    end;

    var
        DesignworkSheet: Codeunit "Designwork Sheet";
        "Prod. Order Routing li": Record "Prod. Order Routing Line";
        CNT: Integer;
        SQLQuery: Text[1000];
        LineSQLQuery: Text[250];
        HeadID: Text[30];
        UpdateWebHead: Text[250];
        WebRecStatus: Text[30];
        OldWebStatus: Text[30];
        production_order: Record "Production Order";
        SQLQuery1: Text[250];
        Item: Record Item;
        Item_Sub_Grp_Code: Code[20];
        Quotes: Label '''';
        Text50001: Label 'NEW';
        Text50002: Label 'OLD';
    //  LRecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";


    procedure CommaRemoval(Base: Text[100]) Converted: Text[100];
    var
        i: Integer;
    begin
        FOR i := 1 TO STRLEN(Base) DO BEGIN
            IF COPYSTR(Base, i, 1) <> '''' THEN
                Converted += COPYSTR(Base, i, 1);
        END;
        EXIT(Converted);
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
}

