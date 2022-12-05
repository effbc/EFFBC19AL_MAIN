pageextension 70036 CustomerCardExtcust extends 21
{
    layout
    {
        addfirst(General)
        {

            /* field("State Code"; "State Code")
            {
                CaptionML = ENU = 'State Code *',
                            ENN = 'State Code';
                ApplicationArea = All;
            } */  //B2BUPG
            field("Tally Ref"; Rec."Tally Ref")
            {
                ApplicationArea = All;
            }

            field(SalBalance; Rec.SalBalance)
            {
                Editable = false;
                ApplicationArea = All;

                trigger OnDrillDown();
                begin
                    DtldCustLedgEntry.SETRANGE("Customer No.", Rec."No.");
                    Rec.COPYFILTER("Global Dimension 1 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 1");
                    Rec.COPYFILTER("Global Dimension 2 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 2");
                    Rec.COPYFILTER("Currency Filter", DtldCustLedgEntry."Currency Code");
                    //CustLedgEntry.DrillDownOnEntries(DtldCustLedgEntry);
                    CustLedgEntry.RESET;
                    DtldCustLedgEntry.COPYFILTER("Customer No.", CustLedgEntry."Customer No.");
                    DtldCustLedgEntry.COPYFILTER("Currency Code", CustLedgEntry."Currency Code");
                    DtldCustLedgEntry.COPYFILTER("Initial Entry Global Dim. 1", CustLedgEntry."Global Dimension 1 Code");
                    DtldCustLedgEntry.COPYFILTER("Initial Entry Global Dim. 2", CustLedgEntry."Global Dimension 2 Code");
                    CustLedgEntry.SETRANGE(CustLedgEntry."Posting Date", DMY2Date(04, 01, 08), TODAY);
                    //sreenivas for 08-09 year onwards entries need to consider
                    CustLedgEntry.SETFILTER(CustLedgEntry."Global Dimension 1 Code", 'PRD-001..PRD-999');
                    CustLedgEntry.SETCURRENTKEY("Customer No.", "Posting Date");
                    PAGE.RUN(0, CustLedgEntry);
                end;
            }
            field(CSBalance; Rec.CSBalance)
            {
                Editable = false;
                ApplicationArea = All;

                trigger OnDrillDown();
                begin
                    DtldCustLedgEntry.SETRANGE("Customer No.", Rec."No.");
                    Rec.COPYFILTER("Global Dimension 1 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 1");
                    Rec.COPYFILTER("Global Dimension 2 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 2");
                    Rec.COPYFILTER("Currency Filter", DtldCustLedgEntry."Currency Code");
                    //CustLedgEntry.DrillDownOnEntries(DtldCustLedgEntry);
                    CustLedgEntry.RESET;
                    DtldCustLedgEntry.COPYFILTER("Customer No.", CustLedgEntry."Customer No.");
                    DtldCustLedgEntry.COPYFILTER("Currency Code", CustLedgEntry."Currency Code");
                    DtldCustLedgEntry.COPYFILTER("Initial Entry Global Dim. 1", CustLedgEntry."Global Dimension 1 Code");
                    DtldCustLedgEntry.COPYFILTER("Initial Entry Global Dim. 2", CustLedgEntry."Global Dimension 2 Code");
                    CustLedgEntry.SETRANGE(CustLedgEntry."Posting Date", DMY2Date(04, 01, 08), TODAY);
                    //sreenivas for 08-09 year onwards entries need to consider
                    CustLedgEntry.SETFILTER(CustLedgEntry."Global Dimension 1 Code", 'CUS*');
                    CustLedgEntry.SETCURRENTKEY("Customer No.", "Posting Date");
                    PAGE.RUN(0, CustLedgEntry);
                end;
            }

            field("User Id"; Rec."User Id")
            {
                ApplicationArea = All;
            }
            field("Territory Code"; Rec."Territory Code")
            {
                CaptionML = ENU = 'Territory Code *',
                            ENN = 'Territory Code';
                ApplicationArea = All;
            }
        }
        //moveafter(General)
        // movebefore(Contact; "State Code")



        addbefore("Gen. Bus. Posting Group")
        {
            field("MSPT Code"; Rec."MSPT Code")
            {
                ApplicationArea = All;
            }
        }
        modify("Payment Terms Code")
        {
            trigger OnBeforeValidate()
            begin
                // added by Pranavi on 01-Oct-2016 for payment terms process
                IF (Rec."Payment Terms Code" <> xRec."Payment Terms Code") AND (xRec."Payment Terms Code" <> '') THEN BEGIN
                    SH.RESET;
                    SH.Setfilter(SH."Sell-to Customer No.", rec."No.");



                    SH.SETRANGE(SH."Payment Terms Code", Rec."Payment Terms Code");
                    SH.SETRANGE(SH."Document Type", SH."Document Type"::Order);
                    IF SH.FINDSET THEN
                        ERROR('You cannot change the payment terms code as there are ' + FORMAT(SH.COUNT) + 'sale orders with the customer presently!');
                END;
                // end by pranavi
            end;
        }
        addafter("Allow Line Disc.")
        {
            field("Payment Term Auth"; Rec."Payment Term Auth")
            {
                ApplicationArea = All;
            }
        }
        addafter("Block Payment Tolerance")
        {
            field("Payment Realization Period"; Rec."Payment Realization Period")
            {
                ApplicationArea = All;
            }
        }
        addafter("Customized Calendar")
        {
            field("GST TDS Number"; Rec."GST TDS Number")
            {
                ApplicationArea = All;
            }
            field("TAN Number"; Rec."TAN Number")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("Ledger E&ntries")
        {
            Promoted = false;
        }
        modify(Action76)
        {
            Promoted = true;
        }
        modify(NewBlanketSalesOrder)
        {
            Promoted = false;
        }
        modify(NewSalesQuote)
        {
            Promoted = false;
        }
        modify(NewSalesInvoice)
        {
            Promoted = true;
        }
        modify(NewSalesOrder)
        {
            Promoted = true;
        }
        modify(NewSalesCreditMemo)
        {
            Promoted = false;
        }
        modify(NewSalesReturnOrder)
        {
            Promoted = false;
        }
        modify(NewServiceQuote)
        {
            Promoted = false;
        }
        modify(NewServiceInvoice)
        {
            Promoted = false;
        }
        modify(NewServiceCreditMemo)
        {
            Promoted = false;
        }
        modify(NewReminder)
        {
            Promoted = true;
        }
        modify(NewFinanceChargeMemo)
        {
            Promoted = false;
        }
        modify(Approve)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Reject)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Delegate)
        {
            Promoted = true;
        }
        modify(SendApprovalRequest)
        {
            Promoted = true;
        }
        modify(CancelApprovalRequest)
        {
            Promoted = true;
        }
        modify(ApplyTemplate)
        {
            Promoted = true;
        }
        modify("Post Cash Receipts")
        {
            Promoted = true;
        }
        modify("Sales Journal")
        {
            Promoted = true;
        }
        modify("Report Customer Detailed Aging")
        {
            Promoted = false;
        }
        modify("Report Customer - Labels")
        {
            Promoted = false;
        }
        modify("Report Customer - Balance to Date")
        {
            Promoted = true;
        }
        addfirst("&Customer")
        {
            group("Sales &History")
            {
                Caption = 'Sales &History';
            }
        }
        addafter(CustomerReportSelections)
        {
            action(CustomerSpecification)
            {
                Caption = 'CustomerSpecification';
                Image = Vendor;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Customer Specification";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageView = SORTING("No.");
                ApplicationArea = All;
            }
        }
        addafter("S&ales")
        {
            action("&MSPT Receivables")
            {
                Caption = '&MSPT Receivables';
                RunObject = Page "MSPT Customer Sales";
                RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                ApplicationArea = All;
            }
        }
        addafter("Report Customer - Balance to Date")
        {
            action("GST Details")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    HYPERLINK('http://app.efftronics.org:8567/GSTRegInternal/GSTRegistrationDetails.aspx?V_C_Num=' + Rec."No.");
                end;
            }
            action("Send GST Mail")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    GSTMails;
                end;
            }
            action("gst no updt")
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    CLE.RESET;
                    CLE.SETFILTER(CLE."Posting Date", '>%1', DMY2Date(06, 30, 17));
                    //CLE.SETFILTER(CLE."Customer No.",'%1|%2|%3','CUST01587','CUST01259','CUST01529');
                    CLE.SETRANGE(CLE."Customer No.", Rec."No.");

                    CLE.SETRANGE(CLE."Seller GST Reg. No.", '');
                    IF CLE.FINDSET THEN BEGIN
                        REPEAT
                            CLE."Seller GST Reg. No." := Rec."GST Registration No.";
                            CLE.MODIFY;

                        UNTIL CLE.NEXT = 0;
                    END;

                    DGSTLE.RESET;
                    DGSTLE.SETFILTER(DGSTLE."Posting Date", '>%1', DMY2Date(06, 30, 17));
                    DGSTLE.SETFILTER(DGSTLE."Source No.", Rec."No.");
                    DGSTLE.SETFILTER(DGSTLE."Buyer/Seller Reg. No.", '');
                    IF DGSTLE.FINDSET THEN BEGIN
                        REPEAT
                            DGSTLE."Buyer/Seller Reg. No." := Rec."GST Registration No.";
                            DGSTLE.MODIFY;
                        UNTIL DGSTLE.NEXT = 0;
                    END;
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."User Id" := USERID;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        // Added by Pranavi on 23-feb-2016 for T.I.N number validation


        /*  IF (USERID = Rec."User Id") AND (NOT (USERID IN ['EFFTRONICS\SUJANI'])) THEN
             IF Rec."Copy Sell-to Addr. to Qte From" = Rec."Copy Sell-to Addr. to Qte From"::Company THEN
                 IF ("T.I.N. No." = '') AND (NOT (Rec."Customer Posting Group" IN ['RAILWAYS', 'EXPORT'])) THEN
                     ERROR('Please enter the T.I.N Number in Taxes Information Tab!');
  */ //B2BUPG
     // End by Pranavi

        //added by pranavi on 15-05-2015 for cashflow integration
        SqlQuery := '';
        /* IF ISCLEAR(SQLConnection) THEN
             CREATE(SQLConnection, FALSE, TRUE);
         IF ISCLEAR(RecordSet) THEN
             CREATE(RecordSet, FALSE, TRUE);*/
        /* //>> ORACLE UPG
                IF ConnectionOpen <> 1 THEN BEGIN
                    SQLConnection.ConnectionString := 'DSN=CASHFLOW;UID=cashflowuser;PASSWORD=firewall123;SERVER=oracle_80;';
                    SQLConnection.Open;
                    ConnectionOpen := 1;
                END;
                SqlQuery := 'SELECT NVL(MAX(AR_CUSTOMER_ID)+1,1) AS LASTNUM FROM MRP_AR_CUSTOMER';
                RecordSet := SQLConnection.Execute(SqlQuery);
                IF NOT (RecordSet.EOF OR RecordSet.BOF) THEN BEGIN
                    EVALUATE(LASTREC, DELCHR(FORMAT(RecordSet.Fields.Item('LASTNUM').Value), '=', ','));
                    SQLConnection.Close;
                    ConnectionOpen := 0;
                END ELSE BEGIN
                    SQLConnection.Close;
                    ConnectionOpen := 0;
                END;
                SQLConnection.Open;
                ConnectionOpen := 1;
                SqlQuery := 'SELECT ERP_CUSID,AR_CUSTOMER_ID FROM MRP_AR_CUSTOMER WHERE (ERP_CUSID = ''' + Rec."No." + ''')';
                RecordSet := SQLConnection.Execute(SqlQuery);
                IF NOT (RecordSet.EOF OR RecordSet.BOF) THEN BEGIN
                    CheckCust := FORMAT(RecordSet.Fields.Item('ERP_CUSID').Value);
                    CF_Cust_ID := RecordSet.Fields.Item('AR_CUSTOMER_ID').Value;
                    SQLConnection.Close;
                    ConnectionOpen := 0;
                END ELSE BEGIN
                    SQLConnection.Close;
                    ConnectionOpen := 0;
                END;
                */ //<< ORACLE UPG
                   //TESTFIELD(Rec.Name);
        IF Rec.Name = '' THEN BEGIN
            ERROR('Please fill Name!');
            EXIT(FALSE);
        END;
        IF Rec.Address = '' THEN BEGIN
            ERROR('Please fill Address!');
            EXIT(FALSE);
        END;
        IF Rec.City = '' THEN BEGIN
            ERROR('Please fill City!');
            EXIT(FALSE);
        END;
        IF (Rec."Country/Region Code" IN [' ', '']) THEN BEGIN
            ERROR('Please fill Country/Region Code!');
            EXIT(FALSE);
        END;
        IF (Rec."Country/Region Code" IN ['IN', '']) AND (Rec."State Code" = '') THEN BEGIN
            ERROR('Please fill State Code!');
            EXIT(FALSE);
        END;
        IF Rec."Salesperson Code" = '' THEN BEGIN
            ERROR('Please fill Salesperson Code!');
            EXIT(FALSE);
        END;

        IF Rec."Customer Posting Group" = '' THEN BEGIN
            ERROR('Please Fill Customer Posting Group in Invoicing Tab!');
            EXIT(FALSE);
        END;
        IF (Rec."Customer Posting Group" IN ['RAILWAYS', 'OTHERS']) AND (USERID IN ['EFFTRONICS\YESU', 'EFFTRONICS\SUSMITHAL']) THEN
            IF FORMAT(Rec."Payment Realization Period") IN ['', ' '] THEN BEGIN
                ERROR('Please enter Payment Realization Period in Payments Tab\If not applicable update it as 0D!');
                EXIT(FALSE);
            END;
        // Added by Pranavi on 26-Jul-2016 As part of Payment Terms Process
        IF (Rec."Customer Posting Group" IN ['PRIVATE', 'OTHERS']) AND NOT (Rec."No." IN ['CUST00536', 'CUST01164']) THEN
            IF Rec."Payment Terms Code" = '' THEN BEGIN
                ERROR('Please Fill Payment Terms Code in Invoicing Tab!');
                EXIT(FALSE);
            END;
        /* //>> ORACLE UPG    
        IF Rec."Payment Terms Code" <> '' THEN BEGIN
            PT.RESET;
            PT.SETRANGE(PT.Code, Rec."Payment Terms Code");
            IF PT.FINDFIRST THEN BEGIN
                IF PT."Update In Cashflow" = TRUE THEN BEGIN
                    SQLConnection.Open;
                    ConnectionOpen := 1;
                    SqlQuery := 'SELECT * FROM PAYMENT_TERMS WHERE (ACTINACT = 1) AND (PAYMENT_TERM_CODE = ''' + PT.Code + ''')';
                    RecordSet := SQLConnection.Execute(SqlQuery);
                    IF NOT (RecordSet.EOF OR RecordSet.BOF) THEN BEGIN
                        EVALUATE(PT_CF_Id, FORMAT(RecordSet.Fields.Item('TERM_ID').Value));
                        SQLConnection.Close;
                        ConnectionOpen := 0;
                    END ELSE BEGIN
                        SQLConnection.Close;
                        ConnectionOpen := 0;
                        PT.UpdateInCashFlow(PT);
                    END;
                END
                ELSE BEGIN
                    PT."Update In Cashflow" := TRUE;
                    PT.MODIFY;
                    PT.UpdateInCashFlow(PT);
                    SQLConnection.Open;
                    ConnectionOpen := 1;
                    SqlQuery := 'SELECT * FROM PAYMENT_TERMS WHERE (ACTINACT = 1) AND (PAYMENT_TERM_CODE = ''' + PT.Code + ''')';
                    RecordSet := SQLConnection.Execute(SqlQuery);
                    IF NOT (RecordSet.EOF OR RecordSet.BOF) THEN BEGIN
                        EVALUATE(PT_CF_Id, FORMAT(RecordSet.Fields.Item('TERM_ID').Value));
                        SQLConnection.Close;
                        ConnectionOpen := 0;
                    END;
                END;
                IF Rec."Payment Term Auth" = Rec."Payment Term Auth"::Rejected THEN BEGIN
                    ERROR('Please change Payment Terms Code as it is rejected by Management for this customer!');
                    EXIT(FALSE);
                END
                ELSE
                    IF Rec."Payment Term Auth" = Rec."Payment Term Auth"::" " THEN
                        IF (PT."Stage 1" = PT."Stage 1"::Credit) OR (PT."Stage 2" = PT."Stage 2"::Credit) OR (PT."Stage 3" = PT."Stage 3"::Credit) THEN BEGIN
                            IF CONFIRM('As Payment Terms includes credit, You have to take Authorization!\Do you want to Send for Authorization? ') THEN
                                SendForAuth;
                        END;
            END ELSE
                ERROR('Payment term code: ' + Rec."Payment Terms Code" + ' does not exist in Payment Terms table!');
        END;
        // End by Pranavi
        */ //<< ORACLE UPG

        Country.SETFILTER(Country.Code, Rec."Country/Region Code");
        IF Country.FINDFIRST THEN
            cntry := Country.Name;
        state.SETFILTER(state.Code, Rec."State Code");
        IF state.FINDFIRST THEN
            statename := state.Description;
        addrs2 := Rec."Address 2";
        IF addrs2 = '' THEN
            addrs2 := '-';
        user.SETFILTER(user."User ID", USERID);
        IF user.FINDFIRST THEN
            username := user.EmployeeID;
        CusPstgGrp := UPPERCASE(COPYSTR(Rec."Customer Posting Group", 1, 1)) + LOWERCASE(COPYSTR(Rec."Customer Posting Group", 2, STRLEN(Rec."Customer Posting Group") - 1));
        IF CusPstgGrp IN ['Others', 'OTHERS', 'EXPORT', 'Export'] THEN         //added by Pranavi on 06-07-2015 to send Others as Private
            CusPstgGrp := 'Private'
        ELSE
            IF CusPstgGrp = 'Railways' THEN
                CusPstgGrp := COPYSTR(CusPstgGrp, 1, STRLEN(CusPstgGrp) - 1);

        IF CheckCust <> Rec."No." THEN BEGIN

            /* MESSAGE('INSERT INTO MRP_AR_CUSTOMER(AR_CUSTOMER_ID, AR_CUSTOMER_TYPE, NAME, ADDRESSLINE1, ADDRESSLINE2, CITY, STATE, ERP_CUSID, ' +
            'PHONE_NO, MOBILE_NO, EMAIL_ID, ZIP, COUNTRY, USERID) VALUES' +
                '(' + FORMAT(LASTREC) + ', ''' + CusPstgGrp + ''', ''' + Name + ''', ''' + Address + ''', ''' + addrs2 + ''', ''' + City + ''', ''' + statename +
               ''',''' + "No." + ''', ''' + "Telex No." + ''', ''' + "Phone No." + ''', ''' + "E-Mail" + ''', ''' + "Post Code" + ''', ''' + cntry + ''', ''' + username + ''')'); */

            CASHFLOWCONNECTION.ExecInOracle('INSERT INTO MRP_AR_CUSTOMER(AR_CUSTOMER_ID, AR_CUSTOMER_TYPE, NAME, ADDRESSLINE1, ADDRESSLINE2, CITY, STATE, ERP_CUSID, ' +
            'PHONE_NO, MOBILE_NO, EMAIL_ID, ZIP, COUNTRY, USERID) VALUES' +
                '(' + FORMAT(LASTREC) + ', ''' + CusPstgGrp + ''', ''' + Rec.Name + ''', ''' + Rec.Address + ''', ''' + addrs2 + ''', ''' + Rec.City + ''', ''' + statename +
               ''',''' + Rec."No." + ''', ''' + Rec."Telex No." + ''', ''' + Rec."Phone No." + ''', ''' + Rec."E-Mail" + ''', ''' + Rec."Post Code" + ''', ''' + cntry + ''', ''' + username + ''')');
        END
        ELSE BEGIN

            /* MESSAGE('UPDATE MRP_AR_CUSTOMER SET AR_CUSTOMER_TYPE = '''+CusPstgGrp+''', NAME = '''+Name+
            ''', ADDRESSLINE1 = '''+Address+''', ADDRESSLINE2 = '''+addrs2+''', CITY = '''+City+''', STATE = '''+statename+''', PHONE_NO = '''+"Telex No."+
            ''', MOBILE_NO = '''+"Phone No."+''', EMAIL_ID = '''+"E-Mail"+''', ZIP = '''+"Post Code"+''', COUNTRY = '''+cntry+''' , MODIFIED_USER_ID = '''+username+''', MODIFIED_DATE = sysdate '+
            'WHERE (AR_CUSTOMER_ID = '+FORMAT(CF_Cust_ID)+') AND (ERP_CUSID = '''+"No."+''')'); */

            CASHFLOWCONNECTION.ExecInOracle('UPDATE MRP_AR_CUSTOMER SET AR_CUSTOMER_TYPE = ''' + CusPstgGrp + ''', NAME = ''' + Rec.Name +
            ''', ADDRESSLINE1 = ''' + Rec.Address + ''', ADDRESSLINE2 = ''' + addrs2 + ''', CITY = ''' + Rec.City + ''', STATE = ''' + statename + ''', PHONE_NO = ''' + Rec."Telex No." +
            ''', MOBILE_NO = ''' + Rec."Phone No." + ''', EMAIL_ID = ''' + Rec."E-Mail" + ''', ZIP = ''' + Rec."Post Code" + ''', COUNTRY = ''' + cntry + ''' , MODIFIED_USER_ID = ''' + username + ''', MODIFIED_DATE = sysdate ' +
            'WHERE (AR_CUSTOMER_ID = ' + FORMAT(CF_Cust_ID) + ') AND (ERP_CUSID = ''' + Rec."No." + ''')');

        END;
        //end by pranavi
    end;

    /*trigger OnOpenPage()
    begin
        ContactEditable := true;
    end;*/


    var
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";
        CASHFLOWCONNECTION: Codeunit "Cash Flow Connection";
        LASTREC: BigInteger;
        //SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
        // RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        //Fieldvalue: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000569-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Field";
        //"Record": Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000560-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Record";
        SqlQuery: Text;
        LastrecInc: Text;
        CheckCust: Text;
        Num: Text;
        Country: Record "Country/Region";
        cntry: Text;
        state: Record State;
        statename: Text;
        addrs2: Text;
        addrs1: Text;
        user: Record "User Setup";
        username: Text;
        CusPstgGrp: Text;
        CF_Cust_ID: Integer;
        PT: Record "Payment Terms";
        PT_CF_Id: Integer;
        CF_ActInact: Integer;
        SH: Record "Sales Header";
        ConnectionOpen: Integer;
        SIH: Integer;
        CLE: Record "Cust. Ledger Entry";
        DGSTLE: Record "Detailed GST Ledger Entry";
        ContactEditable: Boolean;



    procedure SendForAuth();
    var
        Body: Text;
        Mail_From: Text[250];
        Mail_To: Text[250];
        //Mail: Codeunit Mail;
        Subject: Text[250];
        //SMTP_MAIL: Codeunit "SMTP Mail";
        AuthorizedID: Text[50];
        ReqUserGRec: Record "User Setup";
        AuthUserGRec: Record "User Setup";
        PT: Record "Payment Terms";
        PT_Name: Text[100];
        Auth_User: Text[50];
        Req_User: Text[50];
        SP: Record "Salesperson/Purchaser";
        Req_Person_Id: Code[10];
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        User1: Record User;

    begin
        /* Body := '';
        Mail_From := '';
        Mail_To := '';
        Req_Person_Id := '';
        ReqUserGRec.RESET;
        ReqUserGRec.SETRANGE(ReqUserGRec."User Name", USERID);
        IF ReqUserGRec.FINDFIRST THEN BEGIN
            Req_User := ReqUserGRec."User Name";
            Req_Person_Id := ReqUserGRec.EmployeeID;
            IF ReqUserGRec.MailID <> '' THEN
                Mail_From := ReqUserGRec.MailID
            ELSE
                Mail_From := 'erp@efftronics.com';
        END ELSE
            Mail_From := 'erp@efftronics.com';
        Req_User := COPYSTR(USERID, 12, STRLEN(USERID));
        AuthUserGRec.RESET;
        AuthUserGRec.SETRANGE(AuthUserGRec.EmployeeID, Rec."Salesperson Code");
        IF AuthUserGRec.FINDFIRST THEN BEGIN
            Auth_User := AuthUserGRec."Full Name";
            IF AuthUserGRec.MailID <> '' THEN BEGIN
                Mail_To := AuthUserGRec.MailID + ',erp@efftronics.com';
            END ELSE
                Mail_To := 'erp@efftronics.com';
        END ELSE
            Mail_To := 'erp@efftronics.com';
        PT.RESET;
        PT.SETRANGE(PT.Code, Rec."Payment Terms Code");
        IF PT.FINDFIRST THEN
            PT_Name := PT.Description;
        Subject := 'ERP-Request for Authorisation of Customer Payment Terms for ' + FORMAT(Rec.Name);
        Body := '<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>';
        Body += '<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;"><label><font size="6">Customer Details</font></label>';
        Body += '<hr style=solid; color= #3333CC>';
        Body += '<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;">';
        Body += '<tr><td>Customer</td><td>' + Rec.Name + '</td></tr><br>';
        Body += '<tr><td>Payment Term</td><td>' + Rec."Payment Terms Code" + ':- ' + PT_Name + '</td></tr><br>';
        SP.RESET;
        SP.SETRANGE(SP.Code, Rec."Salesperson Code");
        IF SP.FINDFIRST THEN
            Body += '<tr><td>Sales Executive</td><td>' + SP.Name + '</td></tr>'
        ELSE
            Body += '<tr><td>Sales Executive</td><td>' + Rec."Salesperson Code" + '</td></tr>';
        Body += '<tr><td>Customer Type</td><td>' + Rec."Customer Posting Group" + '</td></tr>';

        Body += '<tr><td bgcolor="green">';
        Body += '<a Href="http://app.efftronics.org:8567/erp_reports/PaymentTermsAuthorisations.aspx?CUSTNO=' + FORMAT(Rec."No.") + '&CUSTNAME=' + FORMAT(Rec.Name);
        Body += '&PT=' + FORMAT(Rec."Payment Terms Code");
        Body += '&PTDESC=' + FORMAT(PT_Name);
        Body += '&AUTHPERSON=' + FORMAT(Auth_User);
        Body += '&REQPERSON=' + FORMAT(Req_User);
        Body += '&REQPERSONMAIL=' + Mail_From;
        Body += '&REQID=' + Req_Person_Id;
        Body += '&AUTHSTATUS=1"target="_blank">';
        Body += '<font face="arial" color="#ffffff">ACCEPT</font></a>';

        Body += '</td><td bgcolor="red">';
        Body += '<a Href="http://app.efftronics.org:8567/erp_reports/PaymentTermsAuthorisations.aspx?CUSTNO=' + FORMAT(Rec."No.") + '&CUSTNAME=' + FORMAT(Rec.Name);
        Body += '&PT=' + FORMAT(Rec."Payment Terms Code");
        Body += '&PTDESC=' + FORMAT(PT_Name);
        Body += '&AUTHPERSON=' + FORMAT(Auth_User);
        Body += '&REQPERSON=' + FORMAT(Req_User);
        Body += '&REQPERSONMAIL=' + Mail_From;
        Body += '&REQID=' + Req_Person_Id;
        Body += '&AUTHSTATUS=0';
        Body += '"target="_blank">';
        Body += '<font face="arial" color="#ffffff">REJECT</font></a></td></tr>';

        Body += '</table><br>';
        Body += '<br><p align = "center">:: Note: Auto Generated mail from ERP</b> :: </b></P></div></body></html>';
        //Mail_From:='pranavi@efftronics.com';
        //Mail_To:='pranavi@efftronics.com';
        SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
        SMTP_MAIL.Send;

        Rec."Payment Term Auth" := Rec."Payment Term Auth"::"Sent For Authorization";
        Rec.MODIFY;

        MESSAGE('Authorization Mail Has been Sent!'); */        //B2BUPG

        Body := '';
        Req_Person_Id := '';
        ReqUserGRec.RESET;
        ReqUserGRec.SETRANGE(ReqUserGRec."User ID", USERID);
        IF ReqUserGRec.FINDFIRST THEN BEGIN
            Req_User := ReqUserGRec."User ID";
            Req_Person_Id := ReqUserGRec.EmployeeID;
            Req_User := COPYSTR(USERID, 12, STRLEN(USERID));
            AuthUserGRec.RESET;
            AuthUserGRec.SETRANGE(AuthUserGRec.EmployeeID, Rec."Salesperson Code");
            IF AuthUserGRec.FINDFIRST THEN BEGIN
                if User1.Get(AuthUserGRec."User ID") then
                    Auth_User := user1."Full Name";
                IF AuthUserGRec.MailID <> '' THEN BEGIN
                    Recipients.Add(AuthUserGRec.MailID);
                    Recipients.Add('erp@efftronics.com');
                END ELSE
                    Recipients.Add('erp@efftronics.com');
            END ELSE
                Recipients.Add('erp@efftronics.com');
            PT.RESET;
            PT.SETRANGE(PT.Code, Rec."Payment Terms Code");
            IF PT.FINDFIRST THEN
                PT_Name := PT.Description;
            Subject := 'ERP-Request for Authorisation of Customer Payment Terms for ' + FORMAT(Rec.Name);
            Body := '<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>';
            Body += '<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;"><label><font size="6">Customer Details</font></label>';
            Body += '<hr style=solid; color= #3333CC>';
            Body += '<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;">';
            Body += '<tr><td>Customer</td><td>' + Rec.Name + '</td></tr><br>';
            Body += '<tr><td>Payment Term</td><td>' + Rec."Payment Terms Code" + ':- ' + PT_Name + '</td></tr><br>';
            SP.RESET;
            SP.SETRANGE(SP.Code, Rec."Salesperson Code");
            IF SP.FINDFIRST THEN
                Body += '<tr><td>Sales Executive</td><td>' + SP.Name + '</td></tr>'
            ELSE
                Body += '<tr><td>Sales Executive</td><td>' + Rec."Salesperson Code" + '</td></tr>';
            Body += '<tr><td>Customer Type</td><td>' + Rec."Customer Posting Group" + '</td></tr>';

            Body += '<tr><td bgcolor="green">';
            Body += '<a Href="http://app.efftronics.org:8567/erp_reports/PaymentTermsAuthorisations.aspx?CUSTNO=' + FORMAT(Rec."No.") + '&CUSTNAME=' + FORMAT(Rec.Name);
            Body += '&PT=' + FORMAT(Rec."Payment Terms Code");
            Body += '&PTDESC=' + FORMAT(PT_Name);
            Body += '&AUTHPERSON=' + FORMAT(Auth_User);
            Body += '&REQPERSON=' + FORMAT(Req_User);
            Body += '&REQPERSONMAIL=' + Mail_From;
            Body += '&REQID=' + Req_Person_Id;
            Body += '&AUTHSTATUS=1"target="_blank">';
            Body += '<font face="arial" color="#ffffff">ACCEPT</font></a>';

            Body += '</td><td bgcolor="red">';
            Body += '<a Href="http://app.efftronics.org:8567/erp_reports/PaymentTermsAuthorisations.aspx?CUSTNO=' + FORMAT(Rec."No.") + '&CUSTNAME=' + FORMAT(Rec.Name);
            Body += '&PT=' + FORMAT(Rec."Payment Terms Code");
            Body += '&PTDESC=' + FORMAT(PT_Name);
            Body += '&AUTHPERSON=' + FORMAT(Auth_User);
            Body += '&REQPERSON=' + FORMAT(Req_User);
            Body += '&REQPERSONMAIL=' + Mail_From;
            Body += '&REQID=' + Req_Person_Id;
            Body += '&AUTHSTATUS=0';
            Body += '"target="_blank">';
            Body += '<font face="arial" color="#ffffff">REJECT</font></a></td></tr>';

            Body += '</table><br>';
            Body += '<br><p align = "center">:: Note: Auto Generated mail from ERP</b> :: </b></P></div></body></html>';

            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

            Rec."Payment Term Auth" := Rec."Payment Term Auth"::"Sent For Authorization";
            Rec.MODIFY;

            MESSAGE('Authorization Mail Has been Sent!');
        end;
    end;


    procedure GSTMails();
    var
        Type: Code[2];
        No: Code[20];
        Subject: Text[1000];
        Mail_To: Text[1000];
        Mail_From: Text[1000];
        //SMTP_MAIL: Codeunit "SMTP Mail";
        SQLQuery: Text[1024];
        RowCount: Integer;
        //SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
        //RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        TempText: Text;
        ConnectionOpen: Integer;
        Body: Text;
        Attachment: Text;
        // EmailMessage: Codeunit 8904;
        //Email: Codeunit 8901;
        Recipients: List of [Text];
    begin
        /* IF ISCLEAR(SQLConnection) THEN
            CREATE(SQLConnection, FALSE, TRUE);

        IF ISCLEAR(RecordSet) THEN
            CREATE(RecordSet, FALSE, TRUE);
        ConnectionOpen := 0;
        IF ConnectionOpen <> 1 THEN BEGIN
            SQLConnection.ConnectionString := 'DSN=salinvoiceuser;UID=salinvoiceuser;PASSWORD=salinvoiceuser;SERVER=oracle_80;';
            SQLConnection.Open;
            //SQLConnection.BeginTrans;
            ConnectionOpen := 1;
        END;
        //SQLQuery := 'select * from Vendor_Cust_List where NO in(''CUST00971'',''CUST00972'') and (MAIL_SEND_COUNT <=0 or MAIL_SEND_COUNT is null) order by type,no;';
        SQLQuery := 'select * from Vendor_Cust_List where (GST_REG_NO is null) and NO = ''' + Rec."No." + ''' order by type,no;';
        //MESSAGE(SQLQuery);
        RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
        IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
            RecordSet.MoveFirst;
        WHILE NOT RecordSet.EOF DO BEGIN
            Type := FORMAT(RecordSet.Fields.Item('TYPE').Value);
            No := FORMAT(RecordSet.Fields.Item('NO').Value);
            IF Type = 'V' THEN BEGIN
                Mail_From := 'purchase@efftronics.com';
                Mail_To := FORMAT(RecordSet.Fields.Item('EMAIL').Value);
            END
            ELSE BEGIN
                Mail_From := 'sales@efftronics.com';
                Mail_To := Rec."E-Mail";
            END;
            //Mail_To := 'pranavi@efftronics.com';

            Subject := 'Reg : GST Information Requirements from Efftronics System Pvt Ltd.,!';
            Body := '<html><head><style> divone{background-color: white; width: 1210px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>';
            Body := Body + '<body><div style="border-color:#666699; margin: 20px; border-width:15px; border-style:solid; padding: 20px; width: 1110px;"><label><font size="6">GST Information Requirements from Efftronics System Pvt Ltd.,!</font></label>';
            Body := Body + '<hr style=solid; color= #3333CC>';
            Body := Body + '<h>Dear Sir/Madam,</h><br><br>';
            Body := Body + '<P> As you are aware, GST Roll out is likely to be from 01st July 2017. </P>';
            Body := Body + '<P> We need to update our records with the Provisional GSTIN Registration Numbers of all our Vendors/Customers. ';
            Body := Body + '<b>Request you to kindly update PAN & GST registration provisional ID in <u>below link</u> immediately.</b></P><br/>';
            //Body := Body+'<b>URL :</b><a href="http://localhost:51203/GSTRegistrationDetails.aspx?&V_C_Num=';
            Body := Body + '<font size="8"><b>URL :</b><a href="http://app.efftronics.org:8567/GST_Registration/GSTRegistrationDetails.aspx?V_C_Num=';
            Body := Body + No + '" target="_blank">GST Registration Details</a></font><br/><br/>';
            Body := Body + 'Please note that this is required to have smooth business transaction after GST implementation effective July 1, 2017.<br/><br/>';
            Body := Body + 'Our Company GST Registration details are also attached for your information.<br/><br/>';
            Body := Body + 'In case you have any queries please contact undersigned.<br/><br/>';
            Body := Body + 'Best Regards,<br/>';
            IF Type = 'V' THEN BEGIN
                Body := Body + 'Renuka CH<br/>';
                Body := Body + 'Purchase Department<br/>';
                Body := Body + 'Efftronics Systems Pvt. Ltd.,<br/>';
                Body := Body + '40-15-9,Brundavan Colony,<br/>';
                Body := Body + 'Vijayawada - 520010,<br/>';
                Body := Body + 'Andhra Pradesh, India.<br/>';
                Body := Body + 'Ph No : 0866-2466679(Direct)/2466699/75<br/>';
            END ELSE BEGIN
                Body := Body + 'S.Ganesh<br/>';
                Body := Body + 'Finance Department<br/>';
                Body := Body + 'Efftronics Systems Pvt. Ltd.,<br/>';
                Body := Body + '40-15-9,Brundavan Colony,<br/>';
                Body := Body + 'Vijayawada - 520010,<br/>';
                Body := Body + 'Andhra Pradesh, India.<br/>';
                Body := Body + 'Mobile : 9394654999<br/>';
                Body := Body + 'Ph No : 0866-2466675(Direct)/2466699/75<br/>';
            END;
            SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
            Attachment := '\\erpserver\ErpAttachments\Efftronics_GST_Details.pdf';
            SMTP_MAIL.AddAttachment(Attachment, '');
            SMTP_MAIL.AddCC('erp@efftronics.com');
            SMTP_MAIL.Send;
            SQLQuery := 'update Vendor_Cust_List set MAIL_SEND_COUNT = nvl(MAIL_SEND_COUNT,0)+1 where NO = ''' + No + '''';
            //MESSAGE(SQLQuery);
            SQLConnection.BeginTrans;
            SQLConnection.Execute(SQLQuery);
            SQLConnection.CommitTrans;
            TempText := TempText + No + ',';
            RowCount := RowCount + 1;
            RecordSet.MoveNext; */      //B2BUPG

        /* IF ISCLEAR(SQLConnection) THEN
             CREATE(SQLConnection, FALSE, TRUE);

         IF ISCLEAR(RecordSet) THEN
             CREATE(RecordSet, FALSE, TRUE);*/
        //B2BUPG

        /* //>> ORACLE UPG
        ConnectionOpen := 0;
        IF ConnectionOpen <> 1 THEN BEGIN
            SQLConnection.ConnectionString := 'DSN=salinvoiceuser;UID=salinvoiceuser;PASSWORD=salinvoiceuser;SERVER=oracle_80;';
            SQLConnection.Open;
            ConnectionOpen := 1;
        END;

        SQLQuery := 'select * from Vendor_Cust_List where (GST_REG_NO is null) and NO = ''' + Rec."No." + ''' order by type,no;';

        RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
        IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
            RecordSet.MoveFirst;
        WHILE NOT RecordSet.EOF DO BEGIN
            Type := FORMAT(RecordSet.Fields.Item('TYPE').Value);
            No := FORMAT(RecordSet.Fields.Item('NO').Value);
            IF Type = 'V' THEN BEGIN
                Mail_From := 'purchase@efftronics.com';
                Mail_To := FORMAT(RecordSet.Fields.Item('EMAIL').Value);
            END
            ELSE BEGIN
                Recipients.Add(Rec."E-Mail");
            END;


            Subject := 'Reg : GST Information Requirements from Efftronics System Pvt Ltd.,!';
            Body := '<html><head><style> divone{background-color: white; width: 1210px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>';
            Body := Body + '<body><div style="border-color:#666699; margin: 20px; border-width:15px; border-style:solid; padding: 20px; width: 1110px;"><label><font size="6">GST Information Requirements from Efftronics System Pvt Ltd.,!</font></label>';
            Body := Body + '<hr style=solid; color= #3333CC>';
            Body := Body + '<h>Dear Sir/Madam,</h><br><br>';
            Body := Body + '<P> As you are aware, GST Roll out is likely to be from 01st July 2017. </P>';
            Body := Body + '<P> We need to update our records with the Provisional GSTIN Registration Numbers of all our Vendors/Customers. ';
            Body := Body + '<b>Request you to kindly update PAN & GST registration provisional ID in <u>below link</u> immediately.</b></P><br/>';
            //Body := Body+'<b>URL :</b><a href="http://localhost:51203/GSTRegistrationDetails.aspx?&V_C_Num=';
            Body := Body + '<font size="8"><b>URL :</b><a href="http://app.efftronics.org:8567/GST_Registration/GSTRegistrationDetails.aspx?V_C_Num=';
            Body := Body + No + '" target="_blank">GST Registration Details</a></font><br/><br/>';
            Body := Body + 'Please note that this is required to have smooth business transaction after GST implementation effective July 1, 2017.<br/><br/>';
            Body := Body + 'Our Company GST Registration details are also attached for your information.<br/><br/>';
            Body := Body + 'In case you have any queries please contact undersigned.<br/><br/>';
            Body := Body + 'Best Regards,<br/>';
            IF Type = 'V' THEN BEGIN
                Body := Body + 'Renuka CH<br/>';
                Body := Body + 'Purchase Department<br/>';
                Body := Body + 'Efftronics Systems Pvt. Ltd.,<br/>';
                Body := Body + '40-15-9,Brundavan Colony,<br/>';
                Body := Body + 'Vijayawada - 520010,<br/>';
                Body := Body + 'Andhra Pradesh, India.<br/>';
                Body := Body + 'Ph No : 0866-2466679(Direct)/2466699/75<br/>';
            END ELSE BEGIN
                Body := Body + 'S.Ganesh<br/>';
                Body := Body + 'Finance Department<br/>';
                Body := Body + 'Efftronics Systems Pvt. Ltd.,<br/>';
                Body := Body + '40-15-9,Brundavan Colony,<br/>';
                Body := Body + 'Vijayawada - 520010,<br/>';
                Body := Body + 'Andhra Pradesh, India.<br/>';
                Body := Body + 'Mobile : 9394654999<br/>';
                Body := Body + 'Ph No : 0866-2466675(Direct)/2466699/75<br/>';
            END;
            EmailMessage.Create(Recipients, Subject, Body, true);
            Attachment := '\\erpserver\ErpAttachments\Efftronics_GST_Details.pdf';
            EmailMessage.AddAttachment(Attachment, '', '');
            Recipients.Add('erp@efftronics.com');
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
            SQLQuery := 'update Vendor_Cust_List set MAIL_SEND_COUNT = nvl(MAIL_SEND_COUNT,0)+1 where NO = ''' + No + '''';
            //MESSAGE(SQLQuery);
            SQLConnection.BeginTrans;
            SQLConnection.Execute(SQLQuery);
            SQLConnection.CommitTrans;
            TempText := TempText + No + ',';
            RowCount := RowCount + 1;
            RecordSet.MoveNext;
        END;
        //RecordSet.Close;
        //SQLConnection.CommitTrans;
        SQLConnection.Close;
        ConnectionOpen := 0;
        IF STRLEN(TempText) > 1 THEN
            MESSAGE('Mail Has been send to ' + COPYSTR(TempText, 1, STRLEN(TempText) - 1) + ' - ' + Rec.Name + ' at ' + Mail_To);
            */ //<< ORACLE UPG
    end;

}

