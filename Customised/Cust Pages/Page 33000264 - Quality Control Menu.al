page 33000264 "Quality Control Menu"
{
    // version QC1.1,Cal1.0

    Caption = 'Quality Control Menu';
    PageType = ConfirmationDialog;

    layout
    {
        area(content)
        {
            field(Control38; '')
            {

                ShowCaption = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Setup)
            {
                Caption = 'Setup';
                action("Quality Control Setup")
                {
                    Caption = 'Quality Control Setup';
                    RunObject = Page "Quality Control Setup";
                    ApplicationArea = All;
                }
                separator("----------------")
                {
                    Caption = '----------------';
                }
                action("Inspection Groups")
                {
                    Caption = 'Inspection Groups';
                    RunObject = Page "Inspection Groups";
                    ApplicationArea = All;
                }
                action(Characteristics)
                {
                    Caption = 'Characteristics';
                    RunObject = Page Characteristics;
                    ApplicationArea = All;
                }
                action("Sampling Plan")
                {
                    Caption = 'Sampling Plan';
                    RunObject = Page "Sampling Plan List";
                    ApplicationArea = All;
                }
                separator(Action1000000019)
                {
                }
                action("Quality Reason Codes")
                {
                    Caption = 'Quality Reason Codes';
                    RunObject = Page "Quality Reason Codes";
                    ApplicationArea = All;
                }
                action("Acceptance Levels")
                {
                    Caption = 'Acceptance Levels';
                    RunObject = Page "Acceptance Levels";
                    ApplicationArea = All;
                }
                separator("--")
                {
                    Caption = '--';
                }
                action(Assays)
                {
                    Caption = 'Assays';
                    RunObject = Page "Assay List";
                    ApplicationArea = All;
                }
                separator(Action1102152002)
                {
                }
                action("Defect Master")
                {
                    Caption = 'Defect Master';
                    RunObject = Page "Defect Master";
                    ApplicationArea = All;
                }
                separator(Action1000000020)
                {
                }
                action("Calibration Procedure")
                {
                    Caption = 'Calibration Procedure';
                    RunObject = Page "Calibration Procedure";
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            action(Specifications)
            {
                Caption = 'Specifications';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page Specifications;
                ApplicationArea = All;
            }
            action("Sub Assembly")
            {
                Caption = 'Sub Assembly';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Sub Assembly Card";
                ApplicationArea = All;
            }
            action("Inspection Data Sheet")
            {
                Caption = 'Inspection Data Sheet';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Inspection Data Sheet";
                ApplicationArea = All;
                RunPageView = WHERE("QAS/MPR" = FILTER(<> MPR));
            }
            action("Inspection Receipt")
            {
                Caption = 'Inspection Receipt';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Inspection Receipt";
                RunPageView = WHERE(Status = FILTER(false), "QAS/MPR" = FILTER(<> MPR));
                ApplicationArea = All;
            }
            action("Vendor Rating")
            {
                Caption = 'Vendor Rating';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "Vendor Acceptance Rating";
                ApplicationArea = All;
            }
            action(Calibration)
            {
                Caption = 'Calibration';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page Calibration;
                ApplicationArea = All;
            }
            action("Stores Material Returns")
            {
                Caption = 'Stores Material Returns';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Material Issue-1";
                RunPageView = WHERE("Transfer-to Code" = FILTER('STR'), "Reason Code" = FILTER(<> 'DAMAGE'));
                ApplicationArea = All;
            }
            action("RD Material Returns")
            {
                Caption = 'RD Material Returns';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Material Issue-1";
                RunPageView = WHERE("Transfer-to Code" = FILTER('R&D STR'), "Transfer-from Code" = FILTER(<> 'STR'), "Reason Code" = FILTER(<> 'DAMAGE'));
                ApplicationArea = All;
            }
            action("CS Material Returns")
            {
                Caption = 'CS Material Returns';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Material Issue-1";
                RunPageView = WHERE("Transfer-to Code" = FILTER('CS STR'), "Transfer-from Code" = FILTER(<> 'STR'), "Reason Code" = FILTER(<> 'DAMAGE'));
                ApplicationArea = All;
            }
            action("Posted Inspection Data Sheets")
            {
                Caption = 'Posted Inspection Data Sheets';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Posted Inspection Data Sheet";
                RunPageView = WHERE("QAS/MPR" = FILTER(<> MPR));
                ApplicationArea = All;
            }
            action("Posted Inspected Receipts")
            {
                Caption = 'Posted Inspected Receipts';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Posted Inspection Receipt";
                RunPageView = WHERE(Status = FILTER(true), "QAS/MPR" = FILTER(<> MPR));
                ApplicationArea = All;
            }
            action(Navigate)
            {
                Caption = 'Navigate';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page Navigate;
                ApplicationArea = All;
            }
            action("QC Item Card")
            {
                Caption = 'QC Item Card';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "QC Item Card";
                RunPageView = SORTING("No.") ORDER(Ascending) WHERE("Product Group Code Cust" = FILTER('<> FPRODUCT & <> CPCB'));
                ApplicationArea = All;
            }
            action("QC Item List")
            {
                Caption = 'QC Item List';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                // RunObject = Page 50105;
                //  RunPageView = SORTING(Field1) ORDER(Ascending) WHERE(Field5704=FILTER(<>FPRODUCT&<>CPCB),Field60030=CONST(Yes));
            }
            action("QC Inwards Data Refresh")
            {
                Caption = 'QC Inwards Data Refresh';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    /*IF ISCLEAR(SQLConnection) THEN
                      CREATE(SQLConnection);*/ //B2b1.0

                    /*IF ISCLEAR(RecordSet) THEN
                      CREATE(RecordSet);*///B2b1.0


                    WebRecStatus := Quotes + Text50001 + Quotes;
                    OldWebStatus := Quotes + Text50002 + Quotes;


                    /*SQLConnection.ConnectionString :='DSN=salinvoiceuser;UID=salinvoiceuser;PASSWORD=salinvoiceuser;SERVER=oracle_80;';
                    SQLConnection.Open;*///B2b1.0
                    MESSAGE('Oracle Connected');
                    //SQLConnection.BeginTrans;

                    /*SQLQuery:='Delete From Pending_qc_inwards';
                     SQLConnection.Execute(SQLQuery);*///B2b1.0
                    "Inspection Data Sheet Header".SETRANGE("Inspection Data Sheet Header"."Source Type",
                                                            "Inspection Data Sheet Header"."Source Type"::"In Bound");
                    IF "Inspection Data Sheet Header".FINDSET THEN
                        REPEAT
                            IF Item.GET("Inspection Data Sheet Header"."Item No.") THEN BEGIN
                                // Item.Qc_Item:=TRUE;
                                // Item.MODIFY;
                                //  IF  Item."Inspection Bench Mark(In Min)">0 THEN
                                //  BEGIN
                                Bench_Mark_Time := 0;
                                IF Item."Sampling Count" > 0 THEN BEGIN
                                    Bench_Mark_Time := Item."Sampling Count" * Item."Inspection Bench Mark(In Min)";
                                    IF (Bench_Mark_Time MOD 1 > 0) AND (Bench_Mark_Time MOD 1 < 1) THEN
                                        Bench_Mark_Time := Bench_Mark_Time DIV 1 + 1;

                                END ELSE BEGIN
                                    IF ROUND(("Inspection Data Sheet Header".Quantity * Item."Sampling %") / 100, 1) > 1 THEN BEGIN
                                        Bench_Mark_Time := ROUND(("Inspection Data Sheet Header".Quantity * Item."Sampling %") / 100, 1)
                                                       * Item."Inspection Bench Mark(In Min)";
                                    END ELSE BEGIN
                                        Bench_Mark_Time := Item."Inspection Bench Mark(In Min)";
                                    END;
                                    IF (Bench_Mark_Time MOD 1 > 0) AND (Bench_Mark_Time MOD 1 < 1) THEN
                                        Bench_Mark_Time := Bench_Mark_Time DIV 1 + 1;

                                END;
                                SQLQuery := 'Insert into Pending_Qc_Inwards (ITEM_NO,DESCRIPTION,QUANTITY,BENCH_MARK_TIME,SAMPLING_PERCENT,SAMPLING_COUNT,' +
                                           'TIME_NEEDED,INWARD_DATE,VENDOR_NAME,PURCHASE_ORDER_NO,LOCATION,' +
                                           'IDS_NO) values (''' + FORMAT("Inspection Data Sheet Header"."Item No.") +
                                           ''',''' + FORMAT("Inspection Data Sheet Header"."Item Description") + ''',' +
                                           CommaRemoval(FORMAT("Inspection Data Sheet Header".Quantity)) + ',' +
                                           CommaRemoval(FORMAT(Item."Inspection Bench Mark(In Min)")) + ',' +
                                           CommaRemoval(FORMAT(Item."Sampling %")) + ',' +
                                           CommaRemoval(FORMAT(Item."Sampling Count")) + ',' +
                                           CommaRemoval(FORMAT(Bench_Mark_Time)) + ',' +
                            'to_date(''' + FORMAT("Inspection Data Sheet Header"."Created Date", 0, '<Day>-<Month Text,3>-<Year4>') + ''',''dd-Mon-yyyy'')' +
                                           ',''' + "Inspection Data Sheet Header"."Vendor Name" +
                                           ''',''' + "Inspection Data Sheet Header"."Order No." + ''',''' +
                                           "Inspection Data Sheet Header".Location + ''',''' +
                                           "Inspection Data Sheet Header"."No." + ''')';

                                //SQLConnection.Execute(SQLQuery); //B2b1.0
                                //  END;
                            END;

                        UNTIL "Inspection Data Sheet Header".NEXT = 0;

                    //SQLConnection.CommitTrans;
                    //SQLConnection.Close; //B2b1.0

                end;
            }
        }
    }

    var
        ItemJnlManagement: Codeunit 240;
        "Inspection Data Sheet Header": Record "Inspection Datasheet Header";
        Bench_Mark_Time: Decimal;
        "Prod. Order Routing li": Record "Prod. Order Routing Line";
        CNT: Integer;
        SQLQuery: Text[1000];
        //LRecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        LineSQLQuery: Text[250];
        HeadID: Text[30];
        UpdateWebHead: Text[250];
        WebRecStatus: Text[30];
        OldWebStatus: Text[30];
        Item: Record Item;
        Quotes: Label '''';
        Text50001: Label 'NEW';
        Text50002: Label 'OLD';
        Text19044430: Label 'Quality Control';


    procedure CommaRemoval(Base: Text[100]) Converted: Text[100];
    var
        i: Integer;
    begin
        FOR i := 1 TO STRLEN(Base) DO BEGIN
            IF (COPYSTR(Base, i, 1) <> ',') AND (COPYSTR(Base, i, 1) <> '"') THEN
                Converted += COPYSTR(Base, i, 1);
        END;
        EXIT(Converted);
    end;
}

