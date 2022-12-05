report 50023 "AMC Order Dump"
{
    DefaultLayout = RDLC;
    RDLCLayout = './AMCOrderDump.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") ORDER(Ascending) WHERE(SaleDocType = CONST(Amc), "Sell-to Customer No." = FILTER(<> ''));//EFFUPG1.5
            RequestFilterFields = "No.";
            column(Sales_Header__No__; "No.")
            {
            }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") ORDER(Ascending) WHERE("Qty. to Ship" = FILTER(> 0));

                trigger OnAfterGetRecord()
                begin
                    /* "Sales Line".RESET;
                     "Sales Line".SETRANGE("Sales Line"."Document No.",'*16-17*');
                     IF "Sales Line".FINDSET THEN
                       REPEAT*/
                    /* IF NOT (COPYSTR("Sales Line"."Document No.",9,5)= '10-11') THEN
                    CurrReport.SKIP;*/

                    SQLQuery1 := 'insert into SMS_AMC_PERIODS1(INTERNAL_ORDER_NO,LINE_SNO' +
                    ') values(''' + FORMAT("Sales Line"."Document No.") + ''',' +
                    '''' + FORMAT("Sales Line"."Line No.") + ''')';
                    //>> ORACLE UPG

                    /*                     //MESSAGE(SQLQuery);
                                        SQLConnection.Execute(SQLQuery1);
                                        SQLConnection.CommitTrans;
                                        SQLConnection.BeginTrans;
                                        //UNTIL "Sales Line".ne */
                    //<< ORACLE UPG

                end;
            }

            trigger OnAfterGetRecord()
            var
                Testing: Text[20];
            begin
                // Added by Pranavi on 19-May-2016 for not dumping new orders
                /*Testing := COPYSTR("Sales Header"."No.",9,5);
                IF NOT (COPYSTR("Sales Header"."No.",9,5)= '10-11') THEN
                  CurrReport.SKIP;*/
                IF NOT ("Sales Header".Status = "Sales Header".Status::Released) THEN BEGIN
                    SHA.RESET;
                    SHA.SETRANGE(SHA."No.", "Sales Header"."No.");




                    IF NOT SHA.FINDFIRST THEN
                        CurrReport.SKIP;
                END;

                // added by vishnu

                IF ("Sales Header"."No." IN ['EFF/AMC/19-20/040']) THEN BEGIN
                    //SHA.RESET;
                    //SHA.SETRANGE(SHA."No.","Sales Header"."No.");
                    //IF NOT SHA.FINDFIRST THEN
                    CurrReport.SKIP;
                END;


                // end by vishnu


                // end by pranavi

                cus.SETRANGE(cus."No.", "Sales Header"."Sell-to Customer No.");
                IF cus.FIND('-') THEN BEGIN
                    divisoncode := cus."Service Zone Code";
                END;
                IF "Sales Header"."Payment Terms Code" = 'QUARTER' THEN
                    Paymentcode := '3';
                IF "Sales Header"."Payment Terms Code" = 'QUART' THEN
                    Paymentcode := '3';
                IF "Sales Header"."Payment Terms Code" = 'HALFYEARLY' THEN
                    Paymentcode := '6';
                IF "Sales Header"."Payment Terms Code" = 'YEAR' THEN
                    Paymentcode := '12';
                IF "Sales Header"."Payment Terms Code" = 'Monthly' THEN
                    Paymentcode := '1';
                IF "Sales Header"."Payment Terms Code" = 'NINE MONTH' THEN
                    Paymentcode := '9';
                //IF   NOT("Sales Header"."No."='EFF/AMC/14-15/051') THEN        BEGIN

                SQLQuery := 'insert into SMS_AMC_ORDERS1(INTERNAL_ORDER_NO,DIVISION_ID,CUSTOMER_ORDER_NO,' +
               'CUSTOMER_ORDER_DATE,ORDER_ENTRY_DATE,FROMDATE,TODATE,PAYMENT_MONTHS,VISIT_MONTHS,AMOUNT) values(' +
               '''' + FORMAT("Sales Header"."No.") + ''',''' + FORMAT(divisoncode) + ''',' +
               'NVL(''' + FORMAT("Sales Header"."Customer OrderNo.") + ''',0),' +
               'NVL(''' + FORMAT("Sales Header"."Customer Order Date", 0, '<Day>-<Month Text,3>-<Year4>') + ''',' + '''' + FORMAT("Sales Header"."Order Date", 0, '<Day>-<Month Text,3>-<Year4>') + '''' + '),' +
               '''' + FORMAT("Sales Header"."Order Date", 0, '<Day>-<Month Text,3>-<Year4>') + ''',' +
               '''' + FORMAT("Sales Header"."Requested Delivery Date", 0, '<Day>-<Month Text,3>-<Year4>') + ''',' +
               '''' + FORMAT("Sales Header"."Promised Delivery Date", 0, '<Day>-<Month Text,3>-<Year4>') + ''',' +
               '''' + FORMAT(Paymentcode) + ''',''' + FORMAT("Sales Header"."Posting from Whse. Ref.") + ''',' +
               //  ''''+"Sales Header"."Sale Order Total Amount"+''')';
               'NVL(to_number(replace(''' + FORMAT(ROUND("Sales Header"."Sale Order Total Amount", 1)) + ''',''' + ',' + ''',''' + '' + ''')),0))';
                //>> ORACLE UPG

                /*                 // MESSAGE(SQLQuery);
                                SQLConnection.Execute(SQLQuery);
                                //  MESSAGE(SQLQuery);
                                SQLConnection.CommitTrans;
                                SQLConnection.BeginTrans;
                                // END; */
                //<< ORACLE UPG

            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('Data Posted to AMC_Order1 Tables in oracle');
            end;

            trigger OnPreDataItem()
            begin
                //>> ORACLE UPG
                /*
                //IF datadump THEN
                //BEGIN      // commented by rakesh to ensure auto posting.
                sqlconnection1;
                //deletequery:='DELETE FROM  SMS_AMC_ORDERS1  where INTERNAL_ORDER_NO=''EFF/AMC/14-15/051''' ;
                deletequery := 'DELETE FROM  SMS_AMC_ORDERS1';

                SQLConnection.Execute(deletequery);
                //deletequery:='DELETE FROM SMS_AMC_PERIODS1 where INTERNAL_ORDER_NO=''EFF/AMC/14-15/051''' ;
                deletequery := 'DELETE FROM SMS_AMC_PERIODS1';

                SQLConnection.Execute(deletequery);
                updateqry := 'Update SMS_AMC_LAST_UPDATE SET UPDATE_TIME=SYSDATE';
                //MESSAGE(updateqry);
                SQLConnection.Execute(updateqry);
                */
                //<< ORACLE UPG

                //END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(General)
                {
                    field(datadump; datadump)
                    {
                        Caption = 'Data Dump';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SIH: Record "Sales Invoice Header";
        SIL: Record "Sales Invoice Line";
        InvoicedQty: Decimal;
        InvoicedAmt: Decimal;
        CLE: Record "Cust. Ledger Entry";
        RECEVIEDAMT: array[10] of Decimal;
        I: Integer;
        TOTINVAMT: Decimal;
        TOTVALUE: Decimal;
        TOTQTY: Decimal;
        PENDINGQTY: Decimal;
        pendingamt: Decimal;
        invoicedate: Text[1000];
        InvoicedNos: Text[1000];
        No: Text[10];
        SQLQuery: Text[1000];
        connectionopen: Integer;
        deletequery: Text[1000];
        SH: Record "Sales Header";
        datadump: Boolean;
        SL: Record "Sales Line";
        P_BOI_AMT: Decimal;
        P_SOFT_AMT: Decimal;
        P_INS_AMT: Decimal;
        P_MANU_AMT: Decimal;
        D_INS_AMU: Decimal;
        D_BOI_AMU: Decimal;
        D_SOFT_AMU: Decimal;
        D_MANU_AMU: Decimal;
        Man_amount: Decimal;
        SQLQuery1: Text[1000];
        TOT_Invoiced: Decimal;
        ordreldate: Date;
        PT: Record "Payment Terms";
        PTcode: Text[30];
        cus: Record Customer;
        divisoncode: Text[30];
        Paymentcode: Text[2];
        updateqry: Text[100];
        "--Rev01": Integer;
        //>> ORACLE UPG
        /* SQLConnection: Automation;
        RecordSet: Automation; */
        //<< ORACLE UPG
        SHA: Record "Sales Header Archive";


    procedure sqlconnection1()
    begin
        //>> ORACLE UPG
        /* IF ISCLEAR(SQLConnection) THEN
            CREATE(SQLConnection, FALSE, TRUE);//Rev01

        IF ISCLEAR(RecordSet) THEN
            CREATE(RecordSet, FALSE, TRUE);//Rev01

        IF connectionopen <> 1 THEN BEGIN
            SQLConnection.ConnectionString := 'DSN=csonline;UID=csonline;PASSWORD=adminsms;SERVER=oracle_80;';  //Rev01
            SQLConnection.Open;
            SQLConnection.BeginTrans;
            connectionopen := 1;
            //  MESSAGE('OMS Connected'); 
        END;
        */
        //<< ORACLE UPG
    end;

    procedure commaeli(Base: Text[30]) converted: Text[30]
    var
        i: Integer;
    begin
        FOR i := 1 TO STRLEN(Base) DO BEGIN
            IF COPYSTR(Base, i, 1) <> ',' THEN
                converted += COPYSTR(Base, i, 1);
        END;
        EXIT(converted);
    end;
}

