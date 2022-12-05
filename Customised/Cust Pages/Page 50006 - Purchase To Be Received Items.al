page 50006 "Purchase To Be Received Items"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    SaveValues = false;
    SourceTable = "Purchase Line";
    SourceTableView = SORTING("No.", "Buy-from Vendor No.") ORDER(Ascending) WHERE("Outstanding Quantity"=FILTER(>0), "Document Type" = CONST(Order));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Columns;
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = coloring;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    Style = Attention;
                    StyleExpr = coloring1;
                    ApplicationArea = All;
                }
                field("Safety Lead Time"; Rec."Safety Lead Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shortage Qty"; "Shortage Qty")
                {
                    Caption = 'Material Requets Pending Qty';
                    ApplicationArea = All;
                }
                field("Qty on Prod order Components"; Rec."Qty on Prod order Components")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }

                field(contact; contact)
                {
                    Caption = 'Contact';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Mobile; Mobile)
                {
                    Caption = 'Mobile No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Order Confimed"; Rec."Order Confimed")
                {
                    ApplicationArea = All;
                }
                field("Scheduled Date"; Rec."Scheduled Date")
                {
                    ApplicationArea = All;
                }
                field("PurchaseHeader.""Sale Order No"""; PurchaseHeader."Sale Order No")
                {
                    Caption = 'Sale Order No';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("PurchaseHeader.""Order Date"""; PurchaseHeader."Order Date")
                {
                    Caption = 'Order Date';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Deviated Receipt Date"; Rec."Deviated Receipt Date")
                {
                    Caption = '" Latest Mat. Expected date"';
                    Editable = true;
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        /*
                            //  IF "Deviated Receipt Date"<"Expected Receipt Date" THEN
                                 //   ERROR('Please Enter the Date Greater than Expected Receipt Date');

                                 // Rev01 >>
                                 IF "Deviated Receipt Date" <> xRec."Deviated Receipt Date" THEN BEGIN
                                   IF Remarks='' THEN
                                     ERROR('Please Enter the Remarks')
                                   ELSE BEGIN
                                     "Excepted Rcpt.Date Tracking".INIT;
                                     "Excepted Rcpt.Date Tracking"."Entry No.":="Excepted Rcpt.Date Tracking".COUNT+1;
                                     "Excepted Rcpt.Date Tracking"."Document No.":="Document No.";
                                     "Excepted Rcpt.Date Tracking"."Document Type":="Document Type";
                                     "Excepted Rcpt.Date Tracking"."Document Line No.":="Line No.";
                                     "Excepted Rcpt.Date Tracking"."Item No.":= "No.";
                                     "Excepted Rcpt.Date Tracking"."Deviated By":="Deviated By";
                                     "Excepted Rcpt.Date Tracking"."User Id":=USERID;
                                     "Excepted Rcpt.Date Tracking"."Modified Date":=TODAY;
                                     IF "Deviated Receipt Date">0D THEN
                                       "Excepted Rcpt.Date Tracking"."Excepted Receipt Old Date":="Deviated Receipt Date"
                                     ELSE
                                       "Excepted Rcpt.Date Tracking"."Excepted Receipt Old Date":="Expected Receipt Date";
                                     "Excepted Rcpt.Date Tracking".Reason:=Remarks;

                                     "Excepted Rcpt.Date Tracking"."Excepted Receipt New Date":="Deviated Receipt Date";
                                     "Excepted Rcpt.Date Tracking".INSERT;

                                   END;
                                 END;

                                 IF FORMAT(xRec."Deviated Receipt Date") <> '' THEN BEGIN
                                   IF FORMAT( "Deviated Receipt Date") = '' THEN
                                     ERROR('You Dont Have to Delete the Deviated Date');
                                 {
                                 IF "Deviated Receipt Date" < "Expected Receipt Date" THEN       // Added by Pranavi on 31-mar-2016
                                   ERROR('Deviated Receipt Date should be greater than or equal Expected Receipt Date!');
                                 }
                                 END;
                                 // Rev01 <<



                                 Period:=Getperiod("Deviated Receipt Date");

                                 "G|l".GET;
                                 IF "G|l"."Active ERP-CF Connection" THEN
                                 BEGIN
                                   CashFlowConnection.ExecInOracle('UPDATE PURCHASE_LINE SET DEVIATED_DATE='''+FORMAT("Deviated Receipt Date",0,
                                                                                                 '<Day>-<Month Text,3>-<Year4>')+
                                                                 ''' WHERE ORDERNO='''+"Document No."+'''  AND ORDER_LINE_NO='''+DELCHR(FORMAT("Line No."),'=',',')+'''');

                                   // Start--Added by Pranavi on 31-Jan-2017 for Advance & COD plan_changes
                                   IF NOT ISCLEAR(SQLConnection) THEN
                                     CLEAR(SQLConnection);

                                   IF NOT  ISCLEAR(RecordSet) THEN
                                     CLEAR(RecordSet);

                                   IF ISCLEAR(SQLConnection) THEN
                                     CREATE(SQLConnection,FALSE,TRUE); //Rev01

                                   IF ISCLEAR(RecordSet) THEN
                                     CREATE(RecordSet,FALSE,TRUE); //Rev01

                                   SQLConnection.ConnectionString :="G|l"."Sql Connection String";
                                   SQLConnection.Open;
                                   SQLConnection.BeginTrans;
                                   SQLQuery:='SELECT * FROM Purchase_Heads_Details WHERE ORDERNO = '''+FORMAT("Document No.")+''' AND LINE_NO = '+DELCHR(FORMAT("Line No."),'=',',')+' AND TYPE NOT LIKE ''%Advance%''';
                                   // MESSAGE(SQLQuery);
                                   RecordSet := SQLConnection.Execute(SQLQuery);
                                   RecCount := 0;
                                   IF NOT( (RecordSet.BOF) OR (RecordSet.EOF) ) THEN
                                      RecordSet.MoveFirst;
                                   WHILE NOT RecordSet.EOF DO
                                   BEGIN
                                     ConsiderTax := FORMAT(RecordSet.Fields.Item('CONSIDER_TAX').Value);
                                     IF FORMAT(RecordSet.Fields.Item('TYPE').Value) = 'Order' THEN
                                       Dev_Rcpt_Date := CALCDATE(FORMAT(RecordSet.Fields.Item('CREDIT').Value)+'D',"Deviated Receipt Date")
                                     ELSE
                                       Dev_Rcpt_Date := "Deviated Receipt Date";
                                     ActPeriodActYearCalc(Dev_Rcpt_Date);
                                     RecCount := 0;
                                     SQLQuery:='SELECT * FROM PURCHASE_ORDER_STATUS WHERE ORDERNO = '''+"Document No."+''' AND ORDER_LINE_NO = '+FORMAT("Line No.")+' AND ITEMNO = '''+FORMAT("No.")+
                                               ''' AND PAYMENT_TYPE = '''+FORMAT(RecordSet.Fields.Item('TYPE').Value)+'''';
                                     RecordSet1 := SQLConnection.Execute(SQLQuery);
                                     RecCount := 0;
                                     IF NOT( (RecordSet1.BOF) OR (RecordSet1.EOF) ) THEN
                                        RecordSet1.MoveFirst;
                                     WHILE NOT RecordSet1.EOF DO
                                     BEGIN
                                       SQLQuery:='UPDATE PURCHASE_ORDER_STATUS SET PAYMENT_REALISATION_DATE = to_date('''+FORMAT(Dev_Rcpt_Date,0,'<Day>-<Month Text,3>-<Year4>')+''',''dd-mon-yyyy''), '+
                                                 'ACCT_YEAR = '+FORMAT(AccountYear)+', ACCTPERIOD = '+FORMAT(PeriodNum)+', REASON = '''+DELCHR(FORMAT(Remarks),'=',',')+''' WHERE ORDERNO = '''+"Document No."+
                                                 ''' AND ORDER_LINE_NO = '+FORMAT("Line No.")+' AND ITEMNO = '''+"No."+''' AND PAYMENT_TYPE = '''+FORMAT(RecordSet.Fields.Item('TYPE').Value)+'''';
                                       SQLConnection.Execute(SQLQuery);
                                       RecordSet1.MoveNext;
                                       RecCount := RecCount+1;
                                     END;
                                     IF RecCount = 0 THEN
                                     BEGIN
                                       SQLQuery:='INSERT INTO PURCHASE_ORDER_STATUS (STATUS_ID,ORDERNO,PAYMENT_TYPE,REASON,ITEMNO,ORDER_LINE_NO,CONSIDER_TAX,PAYMENT_REALISATION_DATE,ACCTPERIOD,ACCT_YEAR,CREATION_DATE) VALUES '+
                                                 ' (Seq_Status_ID.Nextval,'''+"Document No."+''','''+FORMAT(RecordSet.Fields.Item('TYPE').Value)+''','''+DELCHR(FORMAT(Remarks),'=',',')+''','''+
                                                 FORMAT("No.")+''','''+FORMAT("Line No.")+''','+ConsiderTax+',to_date('''+FORMAT(Dev_Rcpt_Date,0,'<Day>-<Month Text,3>-<Year4>')+''',''dd-mon-yyyy''),'+
                                                 FORMAT(PeriodNum)+','+FORMAT(AccountYear)+',sysdate)';
                                       SQLConnection.Execute(SQLQuery);
                                     END;
                                     RecordSet.MoveNext;
                                   END;
                                   SQLConnection.CommitTrans;
                                   RecordSet.Close;
                                   SQLConnection.Close;
                                   // End--Added by Pranavi on 31-Jan-2017 for Advance & COD plan_changes
                                 END;
                               END;
                                }
                                EFFUPG
                        */
                    end;
                }
                field("Vendor Mat. Dispatch Date"; Rec."Vendor Mat. Dispatch Date")
                {
                    ApplicationArea = All;
                }
                field("Mat. Dispatched"; Rec."Mat. Dispatched")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(DevDays; DevDays)
                {
                    Caption = 'Deviated Days';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Caption = 'Location Code';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(City; City)
                {
                    Caption = 'City';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(MailSent; Rec.MailSent)
                {
                    ApplicationArea = All;
                }
                field("PCB Mode"; Rec."PCB Mode")
                {
                    ApplicationArea = All;
                }
                field("Courier Agency"; Rec."Courier Agency")
                {
                    ApplicationArea = All;
                }
                field("Docket No"; Rec."Docket No")
                {
                    ApplicationArea = All;
                }
                field("Tracking Status"; Rec."Tracking Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Tracking Status Last Updated"; Rec."Tracking Status Last Updated")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Tracking URL"; Rec."Tracking URL")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Courier Agency Name"; Rec."Courier Agency Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Courier Dispatch Started On"; Rec."Courier Dispatch Started On")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Itemremarks; Rec.Itemremarks)
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field(Status; Statuss)
                {
                    ApplicationArea = All;
                }
                field("Stock At Stores"; Rec."Stock At Stores")
                {
                    ApplicationArea = All;
                }
                field("Stock At CS Stores"; Rec."Stock At CS Stores")
                {
                    ApplicationArea = All;
                }
                field("Stock At RD Stores"; Rec."Stock At RD Stores")
                {
                    ApplicationArea = All;
                }
                field("Stock At MCH Stores"; Rec."Stock At MCH Stores")
                {
                    ApplicationArea = All;
                }
                field(MatReqDate; MatReqDate)
                {
                    Caption = 'Material Required Date';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(ProdStartDate; ProdStartDate)
                {
                    Caption = 'Prod Start Date';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Indent No."; Rec."Indent No.")
                {
                    ApplicationArea = All;
                }
                field(Indented_user; Indented_user)
                {
                    ApplicationArea = All;
                }
                field("Amount To Vendor"; "Amount To Vendor")
                {
                    ApplicationArea = All;
                }
                field("Part Number";"Part Number")
                {
                    ApplicationArea =All;
                }
                field(Make;Make)
                {
                    ApplicationArea = All;
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    ApplicationArea = All;
                }
            }
            group(Control1102152037)
            {
                ShowCaption = false;
                grid(Control1102152036)
                {
                    ShowCaption = false;
                    group(Control1102152038)
                    {
                        ShowCaption = false;
                        field("COUNT"; Rec.COUNT)
                        {
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152035)
                    {
                        ShowCaption = false;
                        field(Color_Open; Color_Open)
                        {
                            Style = StrongAccent;
                            StyleExpr = true;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152046)
                    {
                        ShowCaption = false;
                        field(Color_Txt_Old_Dev_Rec_Date; Color_Txt_Old_Dev_Rec_Date)
                        {
                            Style = Attention;
                            StyleExpr = true;
                            ApplicationArea = All;
                        }
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action1102152020)
            {
                action("Auto Mail")
                {
                    CaptionML = ENU = 'Auto Mail',
                                ENN = '&Print';
                    Ellipsis = true;
                    Image = MailSetup;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        // Added by Rakesh to send Auto mail for Vendors for Followup on 13-Nov-14

                        /* IF NOT (USERID IN ['EFFTRONICS\CHOWDARY', 'EFFTRONICS\RENUKACH', 'EFFTRONICS\BRAHMAIAH', 'EFFTRONICS\RRAHUL', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SUJANI', 'EFFTRONICS\VISHNUPRIYA']) THEN
                            ERROR('You donot have rights to perform this action');

                        IF CONFIRM('Do want to send Auto mails to all Vendors ') = FALSE THEN
                            EXIT;

                        Mail_From := 'purchase@efftronics.com';
                        first := FALSE;

                        Rec.RESET;
                        Rec.SETCURRENTKEY("Document Type", "Buy-from Vendor No.");
                        Rec.SETFILTER("Document Type", '%1', 1);
                        Rec.SETFILTER("Qty. to Receive", '>%1', 0);
                        //MESSAGE(FORMAT(COUNT));

                        test := 0;
                        mailcount := 0;
                        IF Rec.FINDFIRST THEN BEGIN
                            Ven_name := Rec."Vendor Name";
                            Ven_no := Rec."Buy-from Vendor No.";
                        END;

                        USER.RESET;
                        USER.SETRANGE(USER."User Name", USERID);
                        IF USER.FINDFIRST THEN
                            username := USER."Full Name";

                        IF NOT (username IN ['Chowdary Ch', 'Renuka CH', 'APPANNA PARTHUDU . KOLLI', 'Brahmaiah V', 'RAHUL RAVULA']) THEN
                            username := 'Chowdary Ch';

                        //MESSAGE('Start: '+Ven_name);
                        IF Rec.FINDFIRST THEN
                            REPEAT
                                IF Ven_name = Rec."Vendor Name" THEN BEGIN
                                    IF first = FALSE THEN BEGIN
                                        Vendor.RESET;
                                        Vendor.SETRANGE(Vendor."No.", Rec."Buy-from Vendor No.");
                                        IF Vendor.FINDFIRST THEN
                                            //commented by vishnu
                                            Mail_To := Vendor."E-Mail";//'rakesht@efftronics.com';
                                                                       //Mail_To := 'anilkumar@efftronics.com,vishnupriya@efftronics.com';//'rakesht@efftronics.com';
                                        Mail_Subject := 'Reg: Pending Material Expected dates Required - ' + Rec."Vendor Name";
                                        Mail_Body := '';
                                        SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Mail_Subject, Mail_Body, TRUE);
                                        SMTP_MAIL.AppendBody('Dear Sir/Madam,');
                                        SMTP_MAIL.AppendBody('<br><br>');
                                        SMTP_MAIL.AppendBody('Please provide the material expected date for the below pending material.<br>');
                                        SMTP_MAIL.AppendBody('Please mention the dispatch date in below field and reply through return mail.<br><br>');
                                        SMTP_MAIL.AppendBody('<html><body><table border=1 style="border-collapse: collapse;font-size =8;" ><col width="180">');
                                        SMTP_MAIL.AppendBody('<tr><th>Purchase Order No.</th><th>Order Date</th><th>Description</th><th>Qty. to Receive</th><th>Order Days</th><th>Exp. Dispatch Date</th></tr>');
                                        PurchaseHeader.RESET;
                                        PurchaseHeader.SETRANGE(PurchaseHeader."No.", Rec."Document No.");
                                        IF PurchaseHeader.FINDFIRST THEN BEGIN
                                            Ord_date := PurchaseHeader."Order Date";
                                            Dev_date := CALCDATE(Rec."Safety Lead Time", Ord_date);
                                        END;
                                        //commented by vishnupriya
                                        IF Dev_date < TODAY THEN
                                            font_color := 'red'
                                        ELSE
                                            IF (Dev_date - TODAY) > 10 THEN
                                                font_color := 'green'
                                            ELSE
                                                font_color := 'black';
                                        SMTP_MAIL.AppendBody('<tr style="color:' + font_color + ';"><td>' + Rec."Document No." + '</td><td>' + FORMAT((Ord_date), 0, '<Day,2><Filler Character, >. <Month Text,3> <Year4>') + '</td>');
                                        SMTP_MAIL.AppendBody('<td>' + Rec.Description + '</td><td align=right>' + FORMAT(Rec."Qty. to Receive") + '</td><td align=right>' + FORMAT(TODAY - Dev_date) + '</td><td>-</td></tr>');
                                        first := TRUE;
                                    END
                                    ELSE BEGIN
                                        PurchaseHeader.RESET;
                                        PurchaseHeader.SETRANGE(PurchaseHeader."No.", Rec."Document No.");
                                        IF PurchaseHeader.FINDFIRST THEN BEGIN
                                            Ord_date := PurchaseHeader."Order Date";
                                            Dev_date := CALCDATE(Rec."Safety Lead Time", Ord_date);
                                        END;
                                        //commented by vishnu
                                        IF Dev_date < TODAY THEN
                                            font_color := 'red'
                                        ELSE
                                            IF (Dev_date - TODAY) > 10 THEN
                                                font_color := 'green'
                                            ELSE
                                                font_color := 'black';
                                        SMTP_MAIL.AppendBody('<tr style="color:' + font_color + ';"><td>' + Rec."Document No." + '</td><td>' + FORMAT((Ord_date), 0, '<Day,2><Filler Character, >. <Month Text,3> <Year4>') + '</td>');
                                        SMTP_MAIL.AppendBody('<td>' + Rec.Description + '</td><td align=right>' + FORMAT(Rec."Qty. to Receive") + '</td><td align=right>' + FORMAT(TODAY - Dev_date) + '</td><td>-</td></tr>');
                                    END;
                                END
                                ELSE BEGIN
                                    SMTP_MAIL.AppendBody('</table><br>Regards,<br>');
                                    SMTP_MAIL.AppendBody('<b>' + username + '<br> Purchase Department<BR>' + 'Efftronics Systems Pvt. Ltd.,</b><BR>');
                                    SMTP_MAIL.AppendBody('40-15-9,Brundavan Colony,<br>Vijayawada - 520010,<br>Andhra Pradesh, India.<br>');
                                    SMTP_MAIL.AppendBody('Ph No : 0866-2466679(Direct)/2466699/75<br>');
                                    //commented by vishnupriya
                                    SMTP_MAIL.AppendBody('<br><b>Note:<br>1. This is System generated Automail.<br>2. <font color=red>Color items</font> are deviated.<br>');
                                    SMTP_MAIL.AppendBody('3. Black color items are to be received items less than 10 days<br>4. <font color=green>Color items</font> are yet to receive items greater than 10 days</b></body></html>');
                                    test += 1;
                                    IF (Rec.MailSent <> TODAY) AND (Mail_To <> '') THEN BEGIN
                                        SMTP_MAIL.AddBCC('purchase@efftronics.com,erp@efftronics.com');
                                        //  IF test=2 THEN
                                            //ERROR('Just a Trail');  // To test for 1 vendor
                                        SMTP_MAIL.Send;
                                        mailcount += 1;
                                        PL.RESET;
                                        PL.SETFILTER(PL."Buy-from Vendor No.", Ven_no);
                                        PL.SETFILTER(PL."Document Type", '%1', 1);
                                        PL.SETFILTER(PL."Qty. to Receive", '>%1', 0);

                                        IF PL.FINDSET THEN
                                            PL.MODIFYALL(PL.MailSent, TODAY);
                                        COMMIT;
                                        //      MESSAGE('Mail Sent to '+Ven_name);
                                    END;
                                    Ven_name := Rec."Vendor Name";
                                    Ven_no := Rec."Buy-from Vendor No.";
                                    first := FALSE;
                                    Vendor.RESET;
                                    Vendor.SETRANGE(Vendor."No.", Rec."Buy-from Vendor No.");
                                    IF Vendor.FINDFIRST THEN
                                        Mail_To := Vendor."E-Mail";//'rakesht@efftronics.com';
                                                                   //Mail_To := 'anilkumar@efftronics.com';//'rakesht@efftronics.com';
                                    Mail_Subject := 'Reg: Pending Material Expected dates Required - ' + Rec."Vendor Name";
                                    Mail_Body := '';
                                    SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Mail_Subject, Mail_Body, TRUE);
                                    SMTP_MAIL.AppendBody('Dear Sir/Madam,');
                                    SMTP_MAIL.AppendBody('<br><br>');
                                    SMTP_MAIL.AppendBody('Please provide the material expected date for the below pending material.<br>');
                                    SMTP_MAIL.AppendBody('Please mention the dispatch date in below field and reply through return mail.<br><br>');
                                    PurchaseHeader.RESET;
                                    PurchaseHeader.SETRANGE(PurchaseHeader."No.", Rec."Document No.");
                                    IF PurchaseHeader.FINDFIRST THEN BEGIN
                                        Ord_date := PurchaseHeader."Order Date";
                                        Dev_date := CALCDATE(Rec."Safety Lead Time", Ord_date);
                                    END;

                                    SMTP_MAIL.AppendBody('<html><body><table border=1 style="border-collapse: collapse; font-size =8;" ><col width="180">');
                                    //SMTP_MAIL.AppendBody('<tr><th>Purchase Order No.</th><th>Order Date</th><th>Description</th><th>Qty. to Receive</th><th>Deviated Days</th><th>Exp. Dispatch Date</th></tr>');
                                    SMTP_MAIL.AppendBody('<tr><th>Purchase Order No.</th><th>Order Date</th><th>Description</th><th>Qty. to Receive</th><th>Order Days</th><th>Exp. Dispatch Date</th></tr>');
                                    PurchaseHeader.RESET;
                                    PurchaseHeader.SETRANGE(PurchaseHeader."No.", Rec."Document No.");
                                    IF Dev_date < TODAY THEN
                                        font_color := 'red'
                                    ELSE
                                        IF (Dev_date - TODAY) > 10 THEN
                                            font_color := 'green'
                                        ELSE
                                            font_color := 'black';
                                    SMTP_MAIL.AppendBody('<tr style="color:' + font_color + ';"><td>' + Rec."Document No." + '</td><td>' + FORMAT((Ord_date), 0, '<Day,2><Filler Character, >. <Month Text,3> <Year4>') + '</td>');
                                    SMTP_MAIL.AppendBody('<td>' + Rec.Description + '</td><td align=right>' + FORMAT(Rec."Qty. to Receive") + '</td><td align=right>' + FORMAT(TODAY - Dev_date) + '</td><td>-</td></tr>');
                                    //SMTP_MAIL.AppendBody('<td>'+Description+'</td><td align=right>'+FORMAT("Qty. to Receive")+'</td><td align=right>'+FORMAT(TODAY-Ord_date)+'</td><td>-</td></tr>');
                                    first := TRUE;
                                END
                            UNTIL {(test=1) OR }(Rec.NEXT = 0);


                        Mail_To := 'purchase@efftronics.com,spurthi@efftronics.com,anilkumar@efftronics.com,erp@efftronics.com';
                        //Mail_To:='anilkumar@efftronics.com,erp@efftronics.com';
                        Mail_Subject := 'Reg: Automail for Vendor Followup';
                        Mail_Body := 'Dear Sir/Madam,<br>';
                        Mail_Body += '<br>           Automails for ' + FORMAT(mailcount) + ' vendors have been sent.<br>';
                        Mail_Body += '<br>Regards,<br>ERP Team<br><br><b>Note: Automail generated from ERP</b>';
                        SMTP_MAIL.CreateMessage('ERP', 'erp@efftronics.com', Mail_To, Mail_Subject, Mail_Body, TRUE);
                        SMTP_MAIL.Send;
                        // end by Rakesh */     //B2B UPG

                        IF NOT (USERID IN ['EFFTRONICS\CHOWDARY', 'EFFTRONICS\RENUKACH', 'EFFTRONICS\BRAHMAIAH', 'EFFTRONICS\RRAHUL', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SUJANI', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
                            ERROR('You donot have rights to perform this action');

                        IF CONFIRM('Do want to send Auto mails to all Vendors ') = FALSE THEN
                            EXIT;

                        //Mail_From := 'purchase@efftronics.com';
                        first := FALSE;

                        Rec.RESET;
                        Rec.SETCURRENTKEY("Document Type", "Buy-from Vendor No.");
                        Rec.SETFILTER("Document Type", '%1', 1);
                        Rec.SETFILTER("Qty. to Receive", '>%1', 0);
                        //MESSAGE(FORMAT(COUNT));

                        test := 0;
                        mailcount := 0;
                        IF Rec.FINDFIRST THEN BEGIN
                            Ven_name := Rec."Vendor Name";
                            Ven_no := Rec."Buy-from Vendor No.";
                        END;

                        USER.RESET;
                        USER.SETRANGE(USER."User Name", USERID);
                        IF USER.FINDFIRST THEN
                            username := USER."Full Name";

                        IF NOT (username IN ['Chowdary Ch', 'Renuka CH', 'APPANNA PARTHUDU . KOLLI', 'Brahmaiah V', 'RAHUL RAVULA']) THEN
                            username := 'Chowdary Ch';

                        //MESSAGE('Start: '+Ven_name);
                        IF Rec.FINDFIRST THEN
                            REPEAT
                                IF Ven_name = Rec."Vendor Name" THEN BEGIN
                                    IF first = FALSE THEN BEGIN
                                        Vendor.RESET;
                                        Vendor.SETRANGE(Vendor."No.", Rec."Buy-from Vendor No.");
                                        IF Vendor.FINDFIRST THEN
                                            //commented by vishnu
                                            //Mail_To := Vendor."E-Mail";//'rakesht@efftronics.com';
                                            //Mail_To := 'anilkumar@efftronics.com,vishnupriya@efftronics.com';//'rakesht@efftronics.com';
                                            Mail_Subject := 'Reg: Pending Material Expected dates Required - ' + Rec."Vendor Name";
                                        Mail_Body := '';
                                        EmailMessage.Create(Recipients, Mail_Subject, Body, true);
                                        Body += ('Dear Sir/Madam,');
                                        Body += ('<br><br>');
                                        Body += ('Please provide the material expected date for the below pending material.<br>');
                                        Body += ('Please mention the dispatch date in below field and reply through return mail.<br><br>');
                                        Body += ('<html><body><table border=1 style="border-collapse: collapse;font-size =8;" ><col width="180">');
                                        Body += ('<tr><th>Purchase Order No.</th><th>Order Date</th><th>Description</th><th>Qty. to Receive</th><th>Order Days</th><th>Exp. Dispatch Date</th></tr>');
                                        PurchaseHeader.RESET;
                                        PurchaseHeader.SETRANGE(PurchaseHeader."No.", Rec."Document No.");
                                        IF PurchaseHeader.FINDFIRST THEN BEGIN
                                            Ord_date := PurchaseHeader."Order Date";
                                            Dev_date := CALCDATE(Rec."Safety Lead Time", Ord_date);
                                        END;
                                        //commented by vishnupriya
                                        IF Dev_date < TODAY THEN
                                            font_color := 'red'
                                        ELSE
                                            IF (Dev_date - TODAY) > 10 THEN
                                                font_color := 'green'
                                            ELSE
                                                font_color := 'black';
                                        Body += ('<tr style="color:' + font_color + ';"><td>' + Rec."Document No." + '</td><td>' + FORMAT((Ord_date), 0, '<Day,2><Filler Character, >. <Month Text,3> <Year4>') + '</td>');
                                        Body += ('<td>' + Rec.Description + '</td><td align=right>' + FORMAT(Rec."Qty. to Receive") + '</td><td align=right>' + FORMAT(TODAY - Dev_date) + '</td><td>-</td></tr>');
                                        first := TRUE;
                                    END
                                    ELSE BEGIN
                                        PurchaseHeader.RESET;
                                        PurchaseHeader.SETRANGE(PurchaseHeader."No.", Rec."Document No.");
                                        IF PurchaseHeader.FINDFIRST THEN BEGIN
                                            Ord_date := PurchaseHeader."Order Date";
                                            Dev_date := CALCDATE(Rec."Safety Lead Time", Ord_date);
                                        END;
                                        //commented by vishnu
                                        IF Dev_date < TODAY THEN
                                            font_color := 'red'
                                        ELSE
                                            IF (Dev_date - TODAY) > 10 THEN
                                                font_color := 'green'
                                            ELSE
                                                font_color := 'black';
                                        Body += ('<tr style="color:' + font_color + ';"><td>' + Rec."Document No." + '</td><td>' + FORMAT((Ord_date), 0, '<Day,2><Filler Character, >. <Month Text,3> <Year4>') + '</td>');
                                        Body += ('<td>' + Rec.Description + '</td><td align=right>' + FORMAT(Rec."Qty. to Receive") + '</td><td align=right>' + FORMAT(TODAY - Dev_date) + '</td><td>-</td></tr>');
                                    END;
                                END
                                ELSE BEGIN
                                    Body += ('</table><br>Regards,<br>');
                                    Body += ('<b>' + username + '<br> Purchase Department<BR>' + 'Efftronics Systems Pvt. Ltd.,</b><BR>');
                                    Body += ('40-15-9,Brundavan Colony,<br>Vijayawada - 520010,<br>Andhra Pradesh, India.<br>');
                                    Body += ('Ph No : 0866-2466679(Direct)/2466699/75<br>');
                                    //commented by vishnupriya
                                    Body += ('<br><b>Note:<br>1. This is System generated Automail.<br>2. <font color=red>Color items</font> are deviated.<br>');
                                    Body += ('3. Black color items are to be received items less than 10 days<br>4. <font color=green>Color items</font> are yet to receive items greater than 10 days</b></body></html>');
                                    test += 1;
                                    IF (Rec.MailSent <> TODAY) AND (Mail_To <> '') THEN BEGIN

                                        Recipients.Add('purchase@efftronics.com');
                                        Recipients.Add('erp@efftronics.com');

                                        /*  IF test=2 THEN
                                            ERROR('Just a Trail'); */ // To test for 1 vendor
                                        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                                        mailcount += 1;
                                        PL.RESET;
                                        PL.SETFILTER(PL."Buy-from Vendor No.", Ven_no);
                                        PL.SETFILTER(PL."Document Type", '%1', 1);
                                        PL.SETFILTER(PL."Qty. to Receive", '>%1', 0);

                                        IF PL.FINDSET THEN
                                            PL.MODIFYALL(PL.MailSent, TODAY);
                                        COMMIT;
                                        //      MESSAGE('Mail Sent to '+Ven_name);
                                    END;
                                    Ven_name := Rec."Vendor Name";
                                    Ven_no := Rec."Buy-from Vendor No.";
                                    first := FALSE;
                                    Vendor.RESET;
                                    Vendor.SETRANGE(Vendor."No.", Rec."Buy-from Vendor No.");
                                    IF Vendor.FINDFIRST THEN
                                        Recipients.Add(Vendor."E-Mail");
                                    Mail_Subject := 'Reg: Pending Material Expected dates Required - ' + Rec."Vendor Name";
                                    //Mail_Body := '';
                                    EmailMessage.Create(Recipients, Mail_Subject, Body, true);
                                    Body += ('Dear Sir/Madam,');
                                    Body += ('<br><br>');
                                    Body += ('Please provide the material expected date for the below pending material.<br>');
                                    Body += ('Please mention the dispatch date in below field and reply through return mail.<br><br>');
                                    PurchaseHeader.RESET;
                                    PurchaseHeader.SETRANGE(PurchaseHeader."No.", Rec."Document No.");
                                    IF PurchaseHeader.FINDFIRST THEN BEGIN
                                        Ord_date := PurchaseHeader."Order Date";
                                        Dev_date := CALCDATE(Rec."Safety Lead Time", Ord_date);
                                    END;

                                    Body += ('<html><body><table border=1 style="border-collapse: collapse; font-size =8;" ><col width="180">');
                                    //SMTP_MAIL.AppendBody('<tr><th>Purchase Order No.</th><th>Order Date</th><th>Description</th><th>Qty. to Receive</th><th>Deviated Days</th><th>Exp. Dispatch Date</th></tr>');
                                    Body += ('<tr><th>Purchase Order No.</th><th>Order Date</th><th>Description</th><th>Qty. to Receive</th><th>Order Days</th><th>Exp. Dispatch Date</th></tr>');
                                    PurchaseHeader.RESET;
                                    PurchaseHeader.SETRANGE(PurchaseHeader."No.", Rec."Document No.");
                                    IF Dev_date < TODAY THEN
                                        font_color := 'red'
                                    ELSE
                                        IF (Dev_date - TODAY) > 10 THEN
                                            font_color := 'green'
                                        ELSE
                                            font_color := 'black';
                                    Body += ('<tr style="color:' + font_color + ';"><td>' + Rec."Document No." + '</td><td>' + FORMAT((Ord_date), 0, '<Day,2><Filler Character, >. <Month Text,3> <Year4>') + '</td>');
                                    Body += ('<td>' + Rec.Description + '</td><td align=right>' + FORMAT(Rec."Qty. to Receive") + '</td><td align=right>' + FORMAT(TODAY - Dev_date) + '</td><td>-</td></tr>');
                                    //SMTP_MAIL.AppendBody('<td>'+Description+'</td><td align=right>'+FORMAT("Qty. to Receive")+'</td><td align=right>'+FORMAT(TODAY-Ord_date)+'</td><td>-</td></tr>');
                                    first := TRUE;
                                END
                            UNTIL /*(test=1) OR */(Rec.NEXT = 0);



                        Recipients.Add('purchase@efftronics.com');
                        Recipients.Add('spurthi@efftronics.com');
                        Recipients.Add('anilkumar@efftronics.com');
                        Recipients.Add('erp@efftronics.com');
                        Mail_Subject := 'Reg: Automail for Vendor Followup';
                        Body += 'Dear Sir/Madam,<br>';
                        Body += '<br>           Automails for ' + FORMAT(mailcount) + ' vendors have been sent.<br>';
                        Body += '<br>Regards,<br>ERP Team<br><br><b>Note: Automail generated from ERP</b>';
                        EmailMessage.Create(Recipients, Mail_Subject, Body, true);
                        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                        // end by Rakesh

                    end;
                }
                action("Auto Mail Vendors")
                {
                    Caption = 'Auto Mail Vendors';
                    Image = MailSetup;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin

                        //temporary commented

                        /*Rec.RESET;
                        Rec.SETCURRENTKEY("No.","Buy-from Vendor No.");
                        Rec.SETFILTER("Document Type",'%1',1);
                        Rec.SETFILTER("Qty. to Receive",'>%1',0);
                        IF Rec.FINDSET THEN
                        REPEAT
                          Vendor.RESET;
                          Vendor.SETCURRENTKEY("No.");
                          Vendor.SETRANGE(Vendor."No.",Rec."Buy-from Vendor No.");
                          IF Vendor.FINDFIRST THEN
                          BEGIN
                            Vendor."Mail Required" := FALSE;
                            Vendor.MODIFY;
                          END;
                        UNTIL Rec.NEXT =0;
                        */


                        // Added by Rakesh on 20-Nov-14 for Vendor wise followup mails
                        Vendor.RESET;
                        Vendor.SETCURRENTKEY("No.");
                        IF Vendor.FINDSET THEN BEGIN
                            Vendor.MODIFYALL(Vendor."Mail Required", FALSE);
                            COMMIT;
                        END;



                        Rec.RESET;
                        Rec.SETCURRENTKEY("No.", "Buy-from Vendor No.");
                        Rec.SETFILTER("Document Type", '%1', 1);
                        Rec.SETFILTER("Qty. to Receive", '>%1', 0);
                        IF Rec.FINDSET THEN
                            REPEAT
                                Vendor.RESET;
                                Vendor.SETCURRENTKEY("No.");
                                Vendor.SETRANGE(Vendor."No.", Rec."Buy-from Vendor No.");
                                IF Vendor.FINDFIRST THEN BEGIN
                                    Vendor."Mail Required" := TRUE;
                                    Vendor.MODIFY;
                                END;
                            UNTIL Rec.NEXT = 0;

                        //PAGE.RUN(50009); commented by vijaya on 24-May-2016
                        //Added by vijaya on 24-May-2016 for Differentiate Material Receive and Bill Receive
                        VendorList.MailPusposeAssignment('Material');
                        VendorList.RUN;
                        //end by Vijaya


                        // end by Rakesh on 20-Nov-14

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    var
        Salesperson: Record "Salesperson/Purchaser";
        Purchsercode: Code[10];
        Purchasername: Text;
    begin
        PurchaseHeader.RESET;
        PurchaseHeader.SETFILTER(PurchaseHeader."No.", Rec."Document No.");
        IF PurchaseHeader.FINDFIRST THEN BEGIN
            SaleOrder := PurchaseHeader."Sale Order No";
            IF FORMAT(Rec."Safety Lead Time") <> '' THEN
                DevDays := TODAY - CALCDATE(Rec."Safety Lead Time", PurchaseHeader."Order Date")
            ELSE
                DevDays := TODAY - PurchaseHeader."Order Date";
            //ven:=PurchaseHeader."Buy-from Vendor Name";
            Vendor.RESET;
            Vendor.SETFILTER(Vendor."No.", PurchaseHeader."Buy-from Vendor No.");

            IF Vendor.FINDFIRST THEN BEGIN
                contact := Vendor.Contact;
                Mobile := Vendor."Mobile No.";
                City := Vendor.City;
                Purchsercode := Vendor."Purchaser Code";
            END;
            Salesperson.RESET;
            Salesperson.SETFILTER(Code, Vendor."Purchaser Code");
            IF Salesperson.FINDFIRST THEN BEGIN
                Purchasername := Salesperson.Name;
            END;
            Total := Total + 1;
            Statuss := PurchaseHeader.Status;
            IF (PurchaseHeader.Status = PurchaseHeader.Status::Open) THEN
                coloring := TRUE
            ELSE
                coloring := FALSE;
            IF Rec."Deviated Receipt Date" < TODAY THEN
                coloring1 := TRUE
            ELSE
                coloring1 := FALSE;
            //Added by Vijaya on 23-06-2018
            Indented_user := '';
            IH.RESET;
            IH.SETRANGE("No.", Rec."Indent No.");
            IF IH.FINDFIRST THEN BEGIN
                Indented_user := IH."Indent Reference";
            END;
            // Added by Pranavi on 20-Dec-2016
            MatReqDate := 0D;
            ProdStartDate := 0D;
            IndentLine.RESET;
            IndentLine.SETRANGE(IndentLine."Document No.", Rec."Indent No.");
            IndentLine.SETRANGE(IndentLine."Line No.", Rec."Indent Line No.");
            IndentLine.SETRANGE(IndentLine."No.", Rec."No.");
            IF IndentLine.FINDFIRST THEN BEGIN
                POC.RESET;
                POC.SETRANGE(POC."Prod. Order No.", IndentLine."Production Order");
                POC.SETRANGE(POC."Prod. Order Line No.", IndentLine."Production Order Line No.");
                POC.SETRANGE(POC."Line No.", IndentLine."Production Order Comp Line No.");
                POC.SETRANGE(POC."Item No.", IndentLine."No.");
                IF POC.FINDFIRST THEN BEGIN
                    MatReqDate := POC."Production Plan Date" - 4;
                    ProdStartDate := POC."Production Plan Date";
                END;
            END;
            // End by Pranavi
        END;


        // added by vishnu for the Shortage Qty for the Item on May 10th 2019
        SumofShortage := 0;
        MIL.RESET;
        MIL.SETFILTER("Transfer-from Code", '%1|%2', 'STR', 'MCH');
        //MIL.SETFILTER("Item No.",'BOICOMP00244');
        MIL.SETFILTER("Outstanding Quantity", '>%1', 0);
        MIL.SETFILTER("Item No.", Rec."No.");
        IF MIL.FINDSET THEN
            REPEAT
            BEGIN
                SumofShortage := SumofShortage + MIL."Outstanding Quantity";
            END;
            UNTIL MIL.NEXT = 0;
        "Shortage Qty" := SumofShortage;
        // end by vishnu
    end;

    trigger OnInit();
    begin
        editSet := TRUE;
        Total := 0;
        Color_Open := 'Purchase Order in Open';
        Totalcount := 'Total Items Count ::';
        coloring1 := FALSE;

    end;

    trigger OnOpenPage();
    begin

        Rec.setfilter("Production Plan Date Filter", '>%1', DMY2Date(08, 06, 2019));//EFFUPG1.2
    end;

    PROCEDURE Getperiod(perioddate: Date) periodnumber: Integer;
    VAR
        periodNo1: Integer;
        periodDay: Integer;
        periodMonth: Integer;
        periodYear: Integer;
        acctYearMonth: Integer;
        MonthDays: Integer;
        cDay1: Integer;
        cDay2: Integer;
        cDay3: Integer;
        cDay4: Integer;
        cDay5: Integer;
    BEGIN
        periodDay := DATE2DMY(perioddate, 1);
        periodMonth := DATE2DMY(perioddate, 2);
        periodYear := DATE2DMY(perioddate, 3);
        MonthDays := DATE2DMY(CALCDATE('CM', perioddate), 1);
        cDay1 := 1;
        cDay2 := 8;
        cDay3 := 16;
        cDay4 := 23;
        cDay5 := 24;
        IF periodDay < cDay2 THEN
            periodNo1 := 1
        ELSE
            IF (periodDay >= cDay2) AND (periodDay < cDay3) THEN BEGIN
                periodNo1 := 2
            END ELSE BEGIN
                IF MonthDays = 31 THEN BEGIN
                    IF (periodDay >= cDay3) AND (periodDay < cDay5) THEN
                        periodNo1 := 3
                    ELSE
                        periodNo1 := 4;
                END ELSE BEGIN
                    IF (periodDay >= cDay3) AND (periodDay < cDay4) THEN
                        periodNo1 := 3
                    ELSE
                        periodNo1 := 4;
                END;
            END;
        IF periodMonth < 4 THEN
            acctYearMonth := periodMonth + 9
        ELSE
            acctYearMonth := periodMonth - 3;
        periodnumber := (acctYearMonth * 4) - 4 + periodNo1;
    END;


    PROCEDURE ActPeriodActYearCalc(Req_Date: Date);
    VAR
        cDay: Integer;
        cMonth: Integer;
        cYear: Integer;
        cDay1: Integer;
        cDay2: Integer;
        cDay3: Integer;
        cDay4: Integer;
        cDay5: Integer;
        PeriodNo: Integer;
        AccountYearMonth: Integer;
        ShipmentDate: Text;
    BEGIN
        //MESSAGE('Calculating Act Period and Act Year!');
        cDay1 := 1;
        cDay2 := 8;
        cDay3 := 16;
        cDay4 := 23;
        cDay5 := 24;
        ShipmentDate := '';
        PeriodNum := 0;
        AccountYear := 0;
        ShipmentDate := FORMAT(Req_Date, 0, '<Day>-<Month Text,3>-<Year4>');
        cDay := DATE2DMY(Req_Date, 1);
        cMonth := DATE2DMY(Req_Date, 2);
        cYear := DATE2DMY(Req_Date, 3);
        IF cMonth < 4 THEN BEGIN
            AccountYear := cYear - 1;
            AccountYearMonth := cMonth + 9;
        END
        ELSE BEGIN
            AccountYear := cYear;
            AccountYearMonth := cMonth - 3;
        END;
        IF cDay < cDay2 THEN
            PeriodNo := 1
        ELSE
            IF (cDay >= cDay2) AND (cDay < cDay3) THEN
                PeriodNo := 2
            ELSE BEGIN
                //MESSAGE(FORMAT(DATE2DMY(CALCDATE('CM',DMY2DATE(1,cMonth,cYear)),1)));
                IF DATE2DMY(CALCDATE('CM', DMY2DATE(1, cMonth, cYear)), 1) = 31 THEN BEGIN
                    IF (cDay >= cDay3) AND (cDay < cDay5) THEN
                        PeriodNo := 3
                    ELSE
                        PeriodNo := 4
                END
                ELSE BEGIN
                    IF (cDay >= cDay3) AND (cDay < cDay4) THEN
                        PeriodNo := 3
                    ELSE
                        PeriodNo := 4
                END;
            END;
        IF Req_Date = TODAY() THEN
            PeriodNum := 0
        ELSE
            PeriodNum := (AccountYearMonth * 4) - 4 + PeriodNo;
        // MESSAGE('Act Period: '+FORMAT(PeriodNum)+' Act Year: '+FORMAT(AccountYear));
    END;


    var
        editSet: Boolean;
        PurchaseHeader: Record "Purchase Header";
        SaleOrder: Code[20];
        Vendor: Record Vendor;
        contact: Code[50];
        Mobile: Code[30];
        DevDays: Integer;
        City: Code[30];
        Total: Integer;
        Ven_name: Text;
        Ven_no: Code[30];
        //SMTP_MAIL: Codeunit "SMTP Mail";
        Mail_Subject: Text[1000];
        Mail_Body: Text[1000];
        Mail_To: Text[1000];
        Mail_From: Text[1000];
        first: Boolean;
        test: Integer;
        PL: Record "Purchase Line";
        Ord_date: Date;
        font_color: Text;
        Dev_date: Date;
        USER: Record User;
        username: Text[50];
        mailcount: Integer;
        VendorList: Page "Purchase Automail VendorsList";
        Statuss: Option Open,Released,"Pending Approval","Pending Prepayment";
        coloring: Boolean;
        Color_Open: Text;
        Totalcount: Text;
        MatReqDate: Date;
        ProdStartDate: Date;
        IndentLine: Record "Indent Line";
        POC: Record "Prod. Order Component";
        Color_Txt_Old_Dev_Rec_Date: Label 'Deviated Receipt Date < Today';
        coloring1: Boolean;
        Indented_user: Text;
        IH: Record "Indent Header";
        "Shortage Qty": Decimal;
        Prod_order_Compont_Qty: Decimal;
        SumofShortage: Decimal;
        MIL: Record "Material Issues Line";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Body: Text;
        Purchsercode: Code[10];
        Salesperson: Record 13;
        Purchasername: Text;
        "Excepted Rcpt.Date Tracking": Record 60028;
        "G|l": Record 98;
        CashFlowConnection: Codeunit 60030;
        //SQLConnection@1102152048 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000514-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Connection";
        //RecordSet@1102152049 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000535-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Recordset";
        //  SQLQuery : Text[1000];
        RecCount: Integer;
        ConsiderTax: Code[10];
        Dev_Rcpt_Date: Date;
        PeriodNum: Integer;
        AccountYear: Integer;

}