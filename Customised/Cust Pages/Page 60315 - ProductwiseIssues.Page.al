page 60315 "Product wise Issues"
{
    //             FORMAT(TODAY,0,'<Day>-<Month Text,3>-<Year4>')
    //   //http://localhost:1445/Default.aspx
    //   http://efffax:2107/Authorization.aspx

    PageType = List;
    Permissions = TableData "Production Order" = rm;
    Caption = 'Product wise Issues';
    UsageCategory = Lists;
    ApplicationArea = all;
    SourceTable = "Production Order";
    SourceTableView = SORTING("Prod Start date") ORDER(Ascending) WHERE(Status = CONST(Released), "Prod Start date" = FILTER(<> ''), "Product Group Code" = FILTER('FPRODUCT|CPCB'), "Location Code" = CONST('PROD'));
    CardPageID = "Released Production Order";
    layout
    {
        area(content)
        {
            group("Product Wise Material Issues")
            {
                Caption = 'Product Wise Material Issues';
                field("Date Filter"; Date_Filter)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        DateFilterOnAfterValidate;
                    end;
                }
                field("CHECK ALL"; check)
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec.FINDSET THEN
                            REPEAT
                                IF check = TRUE THEN
                                    Rec."Suppose to Plan" := TRUE
                                ELSE
                                    Rec."Suppose to Plan" := FALSE;
                                MODIFY;
                            UNTIL Rec.NEXT = 0
                        ELSE
                            MESSAGE('please enter records');
                    end;
                }
                field("CONFIRM THE PRODUCTION"; Confirmation)
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Confirmation THEN BEGIN
                            No_of_Units := 0;
                            SETRANGE("Suppose to Plan", TRUE);
                            IF FINDSET THEN
                                REPEAT
                                    IF ITEM.GET("Source No.") THEN BEGIN
                                        ITEM.TESTFIELD(ITEM."No.of Units");
                                        // No_of_Units+=ITEM."No.of Units";
                                        No_of_Units += (ITEM."No.of Units" * Quantity); //above line commented and this line Added by Pranavi on 19-feb-2016 to consider the qty if rpo.
                                    END;
                                    IF PROD_PLAN_DATE = 0D THEN
                                        PROD_PLAN_DATE := "Prod Start date";

                                /*IF (PROD_PLAN_DATE<>"Prod Start date") THEN
                                    ERROR('PRODUCTION START DATES MUST BE SINGLE DATE');*/


                                UNTIL NEXT = 0;
                            BEGIN
                                Manf_Setup.GET;
                                MESSAGE(FORMAT(No_of_Units));
                                IF No_of_Units > Manf_Setup."No. of Units/Day" THEN
                                    ERROR(' WE HAVE TO PLAN ' + FORMAT(Manf_Setup."No. of Units/Day") +
                                          ' UNITS / DAY ONLY , CURRENT DAY YOU PLANNED :' + FORMAT(No_of_Units));

                                GL.GET;
                                GL."Restrict Store Material Issues" := TRUE;
                                GL.MODIFY;
                            END;
                            SETRANGE(Status, PO.Status::Released);
                            SETRANGE("Suppose to Plan", TRUE);
                            IF FIND('-') THEN
                                REPEAT
                                    POC.RESET;
                                    POC.SETFILTER(POC."Prod. Order No.", "No.");
                                    POC.SETRANGE(POC.Status, POC.Status::Released);
                                    POC.SETFILTER(POC."Type of Solder2", '<>%1&<>%2', 'SMD', 'DIP');
                                    POC.SETFILTER(POC."Type of Solder", '%1|%2', POC."Type of Solder"::SMD, POC."Type of Solder"::DIP);
                                /* IF POC.FINDFIRST THEN
                                   ERROR('Production order '+FORMAT("No.") +' Not refreshed Properly');*/
                                UNTIL NEXT = 0;

                        END ELSE BEGIN
                            GL.GET;
                            GL."Restrict Store Material Issues" := FALSE;
                            GL.MODIFY;
                        END;

                    end;
                }
                field("TOTAL PRODUCTS"; xRec.COUNT)
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("INFORMING TO"; REQUESTS_TO)
                {
                    Editable = true;
                    Visible = true;
                    ApplicationArea = All;
                }
                field(ProdStartDateFilter; ProdStartDateFilter)
                {
                    Caption = 'Prod Start Date';
                    Visible = fieldvisible;
                    ApplicationArea = All;
                }
                field(SupToPlan; SupToPlan)
                {
                    Caption = 'Suppose To Plan';
                    Visible = fieldvisible;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Added by Pranavi ON 30-Nov-2015 for auto suppose to plan
                        IF USERID IN ['EFFTRONICS\PRANAVI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SPURTHI', 'EFFTRONICS\ANVESH', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'] THEN BEGIN
                            IF ProdStartDateFilter = '' THEN
                                ERROR('Please enter Prod Start Date!');
                            PO1.RESET;
                            PO1.SETFILTER(PO1.Status, '%1', PO1.Status::Released);
                            PO1.SETFILTER(PO1."Product Group Code", '%1', 'FPRODUCT');
                            PO1.SETFILTER(PO1."Prod Start date", ProdStartDateFilter);
                            IF PO1.FINDSET THEN
                                REPEAT
                                    IF PO1."Prod Start date" <> 0D THEN BEGIN
                                        SH1.RESET;
                                        SH1.SETFILTER(SH1."No.", PO1."Sales Order No.");
                                        IF SH1.FINDFIRST THEN BEGIN
                                            PO1."Suppose to Plan" := SupToPlan;
                                            PO1.VALIDATE("Suppose to Plan");
                                            PO1.MODIFY;
                                        END;
                                    END;
                                UNTIL PO1.NEXT = 0;
                        END;
                        //END by Pranavi ON 30-Nov-2015
                    end;
                }
            }
            repeater(Control1102154000)
            {
                Editable = true;
                ShowCaption = false;
                field("No."; "No.")
                {
                    Editable = false;
                    StyleExpr = StyleTx;
                    ApplicationArea = All;
                }
                field("Item Sub Group Code"; "Item Sub Group Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Source No."; "Source No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sales Order No."; "Sales Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Customer; Customer)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prod Start date"; "Prod Start date")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Suppose to Plan"; "Suppose to Plan")
                {
                    ApplicationArea = All;
                }
                field("Shortage Items"; "Shortage Items")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS."Production Order", "No.");
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;

                    trigger OnDrillDown()
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS."Production Order", "No.");
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("MOVE STOCK TO PRODSTR")
            {
                Caption = 'MOVE STOCK TO PRODSTR';
                Image = MoveToNextPeriod;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    GL.GET;
                    IF NOT GL."Restrict Store Material Issues" THEN
                        ERROR('PLEASE CONFIRM THE PRODUCTION');


                    IF Date_Filter = FORMAT(TODAY) THEN BEGIN
                        DUM.DELETEALL;
                        SETRANGE(Status, Status::Released);
                        SETRANGE("Suppose to Plan", TRUE);
                        IF FIND('-') THEN BEGIN
                            WINDOW.OPEN(T1);
                            WINDOW.UPDATE(1, 'CALCULATING PROD STR SHORTAGE ');
                            REPEAT
                                CALC_REQ_QTY("No.");
                                K := K + 1;
                            UNTIL NEXT = 0;
                            WINDOW.CLOSE;
                        END;
                        DUM.SETFILTER(DUM."Maximum Inventory", '<%1', 0);
                        IF DUM.FINDFIRST THEN BEGIN
                            WINDOW.OPEN(T1);
                            WINDOW.UPDATE(1, 'CREATING MATERIAL REQUESTS ');
                            BEGIN
                                InventorySetup.GET;
                                MaterialIssueHeader.RESET;
                                MaterialIssueHeader.INIT;
                                MaterialIssueHeader."No." := GetNextNo;
                                MaterialIssueHeader."Receipt Date" := TODAY;
                                MaterialIssueHeader."Transfer-from Code" := 'STR';
                                MaterialIssueHeader."Transfer-to Code" := 'PRODSTR';
                                MaterialIssueHeader.VALIDATE("Prod. Order No.", 'EFF11STR01');
                                MaterialIssueHeader.VALIDATE("Prod. Order Line No.", 10000);
                                MaterialIssueHeader."User ID" := USERID;
                                USER.GET(USERSECURITYID);
                                //Rev01 Start
                                //Code Commented
                                /*
                                MaterialIssueHeader."Resource Name":=USER.Name;
                                */
                                MaterialIssueHeader."Resource Name" := USER."Full Name";
                                //Rev01 End
                                MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                                MaterialIssueHeader."Sales Order No." := "Sales Order No.";
                                MaterialIssueHeader.INSERT;
                            END;
                            REPEAT
                                LineNo := LineNo + 10000;
                                IF ITEM.GET(DUM."No.") THEN BEGIN
                                    IF DUM."Stock at Stores" > 0 THEN BEGIN
                                        MaterialIssueLine.INIT;
                                        MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                        MaterialIssueLine.VALIDATE("Item No.", ITEM."No.");
                                        MaterialIssueLine."Line No." := LineNo;
                                        MaterialIssueLine."Unit of Measure Code" := ITEM."Base Unit of Measure";
                                        MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                        MaterialIssueLine.VALIDATE("Unit of Measure");
                                        IF DUM."Stock at Stores" >= (-1 * DUM."Maximum Inventory") THEN
                                            MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, -1 * DUM."Maximum Inventory")
                                        ELSE
                                            MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, DUM."Stock at Stores");
                                        MaterialIssueLine."Prod. Order No." := 'EFF11STR01';
                                        MaterialIssueLine."Prod. Order Line No." := 10000;
                                        MaterialIssueLine."Production BOM No." := MaterialIssueHeader."Prod. BOM No.";
                                        MaterialIssueLine.INSERT;
                                    END;
                                END;
                            UNTIL DUM.NEXT = 0;
                            GL."Restrict Store Material Issues" := FALSE;
                            GL.MODIFY;
                            WINDOW.CLOSE;
                        END
                        ELSE
                            MESSAGE('There is no Shortage in Prod Stores');
                    END;

                end;
            }
            action("&Refresh")
            {
                Caption = '&Refresh';
                Image = RefreshLines;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //EFFUPG1.2>>>
                    /*
                       GL.GET;
                       IF GL."Production_ Shortage_Status"=GL."Production_ Shortage_Status"::Applied THEN
                       BEGIN
                         IF (USERID IN['EFFTRONICS\ANVESH','EFFTRONICS\PADMAJA','EFFTRONICS\SPURTHI','EFFTRONICS\DMADHAVI','EFFTRONICS\PADMASRI',
                                       'EFFTRONICS\ANILKUMAR','EFFTRONICS\PRANAVI','EFFTRONICS\BSATISH','EFFTRONICS\SARDHAR','EFFTRONICS\VSNGEETHA','EFFTRONICS\GRAVI'])   THEN
                         BEGIN
                           //Rev01 start
                           //Code Commented
                           
                           IF ISCLEAR(SQLConnection) THEN
                              CREATE(SQLConnection);
                           IF ISCLEAR(RecordSet) THEN
                              CREATE(RecordSet);
                           
                           //B2BUPG
                            IF ISCLEAR(SQLConnection) THEN
                              CREATE(SQLConnection,FALSE,TRUE);
                           IF ISCLEAR(RecordSet) THEN
                              CREATE(RecordSet,FALSE,TRUE);  //B2BUPG
                           //Rev01 End
                           WebRecStatus := Quotes+Text50001+Quotes;
                           OldWebStatus := Quotes+Text50002+Quotes;
                           SQLConnection.ConnectionString :='DSN=salinvoiceuser;UID=salinvoiceuser;PASSWORD=salinvoiceuser;SERVER=oracle_80;';
                           SQLConnection.Open;
                           SQLQuery:='select TO_CHAR(AUTH_STATUS) STATUS from PROD_WISE_ISS_AUTH where SHORTAGE_DATE='''+
                                     FORMAT(GL."Production Shortage Date",0,'<Day>-<Month Text,3>-<Year4>')+'''';
                           RecordSet := SQLConnection.Execute(SQLQuery);
                           IF NOT (RecordSet.EOF OR RecordSet.BOF) THEN
                           BEGIN
                             IF FORMAT(RecordSet.Fields.Item('STATUS').Value)='1' THEN
                             BEGIN
                               GL.GET;
                               GL."Production_ Shortage_Status":=GL."Production_ Shortage_Status"::Accepted;
                               GL.MODIFY;
                               MESSAGE('Data Refreshed , you can create the Material Requests now');
                             END ELSE
                             BEGIN
                               GL.GET;
                               GL."Production_ Shortage_Status":=GL."Production_ Shortage_Status"::Rejected;
                               GL.MODIFY;
                               MESSAGE('Data Refreshed, There is no Authorisation from Management');
                    
                             END;
                             SQLConnection.Close;
                           END ELSE
                           BEGIN
                             SQLConnection.Close;
                            ERROR('Your Request was not processed by management , wait for management decision');
                           END;
                         END;
                       END ELSE
                         ERROR('Please ask permission to Management');
                  */ //EFFUPG1.2 >>>>
                end;
            }
            action("INFORM SHORTAGE INFO TO MNG")
            {
                Caption = 'INFORM SHORTAGE INFO TO MNG';
                Image = LotInfo;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //EFFUPG1.2>>>

                    //ERROR('REPORT UNDER DEVELOPMENT. PLEASE CONTACT ERP TEAM');

                    ShortageItems.RESET;
                    ShortageItems.SETFILTER(ShortageItems.Remarks, '%1', '');
                    //IF ShortageItems.FINDFIRST THEN
                    //ERROR('ENTER REMARKS FOR ALL SHORTAGE ITEMS');//commented & added by pranavi on 08-Dec-2015
                    IF ShortageItems.FINDSET THEN
                        REPEAT
                            PO1.RESET;
                            PO1.SETFILTER(PO1."No.", ShortageItems."Production Order");
                            IF PO1.FINDFIRST THEN BEGIN
                                IF (COPYSTR(PO1."Sales Order No.", 5, 3) <> 'EXP') THEN
                                    ERROR('ENTER REMARKS FOR ALL SHORTAGE ITEMS');
                            END;
                        UNTIL ShortageItems.NEXT = 0;
                    //end by pranavi

                    No_of_Units := 0;
                    RESET;
                    SETRANGE(Status, PO.Status::Released);
                    SETRANGE("Suppose to Plan", TRUE);
                    IF FINDSET THEN
                        REPEAT
                            IF "Prod Start date" <> TODAY THEN
                                ERROR('PRODUCTION START DATE MUST BE ' + FORMAT(TODAY) + ' IN ORDER ' + FORMAT("No."));
                            IF ITEM.GET("Source No.") THEN BEGIN
                                ITEM.TESTFIELD(ITEM."No.of Units");
                                No_of_Units += ITEM."No.of Units";
                            END;
                        UNTIL NEXT = 0;

                    // IF No_of_Units>12 THEN
                    //   ERROR('NO. OF UNITS PER DAY MUST NOT BE GREATER THAN 12 UNITS');

                    //IF USERID<>'07TE024' THEN
                    //  ERROR(' IT IS UNDER TESITNG PLEASE DONT PRESS IT');
                    CLEAR(Mail_Send_To); //Rev01

                    PO_SHORTAGEITEMS.RESET;
                    IF PO_SHORTAGEITEMS.COUNT > 0 THEN BEGIN

                        GL.GET;
                        IF GL."Production_ Shortage_Status" = GL."Production_ Shortage_Status"::Applied THEN
                            ERROR('YOU ALREADY ASKED PERMISSION FROM MANAGEMENT');

                        IF REQUESTS_TO = REQUESTS_TO::CEO THEN
                            Mail_Send_To := 'erp@efftronics.com,'
                        ELSE
                            IF REQUESTS_TO = REQUESTS_TO::DIR THEN
                                Mail_Send_To := 'erp@effe.com,'
                            ELSE
                                IF REQUESTS_TO = REQUESTS_TO::DIR2 THEN
                                    Mail_Send_To := 'erp@efftronics.com,'
                                ELSE
                                    IF REQUESTS_TO = REQUESTS_TO::ANVESH THEN
                                        Mail_Send_To := 'erp@efftronics.com,'
                                    ELSE
                                        IF REQUESTS_TO = REQUESTS_TO::ANIL THEN
                                            Mail_Send_To := 'erp@efftronics.com';



                        // Mail_Send_To+='anilkumar@efftronics.com,padmaja@efftronics.com,exesec@efftronics.com,dmadhavi@efftronics.com,mnraju@efftronics.com';
                        Mail_Body := '';

                        UserSetup.RESET;
                        UserSetup.SETFILTER(UserSetup."User ID", USERID);
                        IF UserSetup.FINDFIRST THEN BEGIN
                            //Rev01 Start
                            //Code Commented

                            Mail_Subject := USER."Full Name" + '  asking permission TO start "PRODUCTION on' + FORMAT(TODAY + 1, 0, '<Day>-<Month Text,3>-<Year4>')
                                                   + '"  with SHORTAGE ';

                            Mail_Subject := USER."Full Name" + '  asking permission TO start "PRODUCTION on' + FORMAT(TODAY + 1, 0, '<Day>-<Month Text,3>-<Year4>')
                                                   + '"  with SHORTAGE ';
                            //Rev01 End
                            Mail_Subject := 'ERP - PRODUCTION SHORTAGE MATERIAL AUTHORIZATION for ' + FORMAT(TODAY + 1, 0, '<Day>-<Month Text,3>-<Year4>');
                            From_Mail := UserSetup."E-Mail";
                        END;
                        Mail_Body += '<Body><strong><form><table style="WIDTH:500px; HEIGHT: 20px; "border="1" align="center">';
                        // //Mail_Body+='<Tr><Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://efffax/shortage%20auth/';
                        //  Mail_Body+='<Tr> <Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://203.129.197.133:5556/erp_reports';Intrane
                        //Mail_Body+='<Tr> <Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://219.65.70.251:5556/erp_reports';   //pranavi on 16-10-2015
                        Mail_Body += '<Tr> <Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://app.efftronics.org:8567/erp_reports'; // above line commented and added by pranavi on 11-feb-2016
                        //Mail_Body+='<Tr> <Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://115.119.184.72:5556/erp_reports';
                        //Mail_Body+='<Tr> <Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://intranet:8080/erp_mat_auh';
                        Mail_Body += '/Shortage_Auth.aspx?Val1=' + FORMAT(TODAY, 0, '<Day>-<Month Text,3>-<Year4>');
                        Mail_Body += '&val2=1';
                        Mail_Body += '&val3=' + FORMAT(UserSetup."Current UserId");
                        Mail_Body += '&val4=' + Mail_Send_To;
                        //Rev01 Start
                        //Code Commented

                        //USER.SETRANGE(USER."User ID", USERID);

                        UserSetup.RESET;
                        UserSetup.SETFILTER(UserSetup."User ID", USERID);
                        IF UserSetup.FINDFIRST THEN BEGIN

                            USER.SETRANGE(USER."User Name", USERID);
                            //Rev01 End
                            IF USER.FIND('-') THEN BEGIN

                                Mail_Body += '&val5=' + UserSetup."E-Mail";
                                //  Mail_Body+='anilkumar@efftronics.com'
                            END;
                            Mail_Body += '"  target="_blank">Accept</a></b></td>';
                            //Mail_Body+='<Td bgcolor=#FF3300 color=#FFFFFF  align="center" ><b><a href="http://efffax/shortage%20auth/';

                            // Mail_Body+='<Td bgcolor=#FF3300 color=#FFFFFF  align="center" ><b><a href="http://203.129.197.133:5556/erp_reports';connection
                            // Mail_Body+='<Td bgcolor=#FF3300 color=#FFFFFF  align="center" ><b><a href="http://219.65.70.251:5556/erp_reports';     //pranavi on 16-10-2015
                            Mail_Body += '<Tr> <Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://app.efftronics.org:8567/erp_reports'; // above line commented and added by pranavi on 11-feb-2016
                                                                                                                                                           //Mail_Body+='<Td bgcolor=#FF3300 color=#FFFFFF  align="center" ><b><a href="http://115.119.184.72:5556/erp_reports';
                                                                                                                                                           //Mail_Body+='<Td bgcolor=#FF3300 color=#FFFFFF  align="center" ><b><a href="http://intranet:8080/erp_mat_auh';  //connection
                            Mail_Body += '/Shortage_Auth.aspx?Val1=' + FORMAT(TODAY, 0, '<Day>-<Month Text,3>-<Year4>');
                            Mail_Body += '&val2=0';
                            Mail_Body += '&val3=' + FORMAT(USERID);
                            Mail_Body += '&val4=' + Mail_Send_To;
                            //Rev01 Start
                            //CodeCommented

                            //USER.SETRANGE(USER."User ID", USERID);


                            UserSetup.RESET;
                            UserSetup.SETFILTER(UserSetup."User ID", USERID);
                            IF UserSetup.FINDFIRST THEN BEGIN

                                USER.SETRANGE(USER."User Name", USERID);
                                //Rev01 End
                                IF USER.FIND('-') THEN BEGIN

                                    Mail_Body += '&val5=' + UserSetup."E-Mail";
                                    // Mail_Body+='anilkumar@efftronics.com'
                                END;
                                Mail_Body += '"  target="_blank">Reject</b></a></td></tr></table>';
                                Mail_Body += 'Note : Please go though the Attachment for Projects Planned & Shortage </form></font></strong> </body>';
                                //   Mail_Body+='Note : Please go though the Attachment for Projects Planned & Shortage item Details ';

                                //  To_mail:='Santhoshk@efftronics.com';
                                To_mail := Mail_Send_To;
                                //Rev01 Start
                                //Code Commented
                                /*
                                IF ISCLEAR(BullZipPDF) THEN
                                   CREATE(BullZipPDF);

                                //B2BUPG
                                 IF ISCLEAR(BullZipPDF) THEN
                                   CREATE(BullZipPDF,FALSE,TRUE);  //B2BUPG

                               //Rev01 End


                                Mail_Send_To+='erp@efftronics.com,';
                                Mail_Send_To+='renukach@efftronics.com,anilkumar@efftronics.com,vsngeetha@efftronics.com';//Add new Mail ID here for Day wise Issues
                                Mail_Body:='<html><body>';
                                Mail_Body+= 'Shortage approval for TODAY ('+FORMAT(TODAY+1,0,'<Day>-<Month Text,3>-<Year4>')+') Production';
                                // Mail_Body+='<br/><br/><b>URL :</b><a href="http://203.129.197.138:8567/Shortage';
                                Mail_Body+='<br/><br/><b>URL :</b><a href="http://eff-cpu-393:8567/Shortage';  // above line commented and added by pranavi on 11-feb-2016
                                Mail_Body+='/ShortageForm.aspx?Val1='+FORMAT(TODAY,0,'<Day>-<Month Text,3>-<Year4>');
                                Mail_Body+='&val2=1';
                                Mail_Body+='&val3='+FORMAT(UserSetup."Current UserId");
                                Mail_Body+='&val4='+Mail_Send_To;
                                Mail_Body+='&val5='+UserSetup."E-Mail";
                                Mail_Body+='"  target="_blank">Shortage Details</a><br/><br/>';
                                Mail_Body+='<br/><b>Note : Please go through the link for Shortage, Planned Products and Sale order wise details.</b> </body></html>';
                                To_mail:=Mail_Send_To;

                                FileDirectory := '\\ERPSERVER\ErpAttachments\';
                                WINDOW.OPEN('PREPARING THE REPORT');
                                FileName :='Authorisation Material(PWMI)'+FORMAT(TODAY,0,'<Day>-<Month Text,3>-<Year4>')+'.pdf';
                                 BullZipPDF.Init;
                                BullZipPDF.LoadSettings;
                                RunOnceFile := BullZipPDF.GetSettingsFileName(TRUE);
                                BullZipPDF.SetValue('Output',FileDirectory+FileName);
                                BullZipPDF.SetValue('Showsettings', 'never');
                                BullZipPDF.SetValue('ShowPDF', 'no');
                                BullZipPDF.SetValue('ShowProgress', 'no');
                                BullZipPDF.SetValue('ShowProgressFinished', 'no');
                                BullZipPDF.SetValue('SuppressErrors', 'yes');
                                BullZipPDF.SetValue('ConfirmOverwrite', 'no');
                                BullZipPDF.WriteSettings(TRUE);  //B2BUPG
                                REPORT.RUNMODAL(708,FALSE,FALSE);
                                TimeOut := 0;
                                WHILE EXISTS(RunOnceFile) AND (TimeOut < 10) DO
                                BEGIN
                                  SLEEP(2000);
                                  TimeOut := TimeOut + 1;
                                END;
                                WINDOW.CLOSE;
                                Attachment:=FileDirectory+FileName;
                                GL."Production_ Shortage_Status":=GL."Production_ Shortage_Status"::Applied;
                                GL."Production Shortage Date":=TODAY;
                                GL.MODIFY;

                                SMTP_Mail.CreateMessage('ERP','erp@efftronics.com',To_mail,Mail_Subject,Mail_Body,TRUE);
                              //  SMTP_Mail.AddAttachment(Attachment);
                                SMTP_Mail.Send;
                                MESSAGE(' MAIL HAS BEEN SENT TO '+Mail_Send_To);

                              END ELSE
                               ERROR(' THERE IS NO SHORTAGE');
                            *///EFFUPG1.2<<<<
                            end;
                        end;
                    end;
                end;
            }
            action("PLAN FOR NEXT DAY")
            {
                Caption = 'PLAN FOR NEXT DAY';
                Image = Planning;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PO := Rec;
                    PO.SETRANGE(PO."Suppose to Plan", TRUE);
                    IF PO.FINDSET THEN
                        REPEAT
                            PO.VALIDATE("Prod Start date", TODAY + 1);
                            PO.MODIFY;
                        UNTIL PO.NEXT = 0;
                end;
            }
            action("&NULLIFY")
            {
                Caption = '&NULLIFY';
                Image = RemoveLines;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    SETRANGE(Status, Status::Released);
                    SETRANGE("Suppose to Plan", TRUE);
                    IF FIND('-') THEN
                        REPEAT
                            "Shortage Verified" := FALSE;
                            CANCEL_RESERVATION("No.");
                            MODIFY;
                        UNTIL NEXT = 0;
                    PO_SHORTAGEITEMS.DELETEALL;
                    RESET;
                    SETRANGE(Status, Status::Released);
                    SETRANGE("Prod Start date", PLAN_DATE);
                    Date_Filter := FORMAT(TODAY);
                end;
            }
            action("&POST MATERIAL ISSUES")
            {
                Caption = '&POST MATERIAL ISSUES';
                Image = PostInventoryToGL;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Sqlintegration: Codeunit SQLIntegration;
                begin
                    /*
                    IF DATE2DWY(TODAY,1)<>7 THEN
                    BEGIN
                      IF ((CURRENTDATETIME >  CREATEDATETIME(TODAY,090000T)) AND (CURRENTDATETIME <  CREATEDATETIME(TODAY,120000T)))
                      OR ((CURRENTDATETIME >  CREATEDATETIME(TODAY,140000T)) AND (CURRENTDATETIME <  CREATEDATETIME(TODAY,170000T))) THEN
                        ERROR('Postings are not Allowed from 9AM-12PM and 2PM-5PM');
                    END;
                    */

                    WINDOW.OPEN(T1);
                    /* GL.GET;
                     GL."Restrict Store Material Issues":=FALSE;
                     GL.MODIFY;*/// commented by vijaya on 18-01-2018 for Store material Restriction
                                 /*
                                   IF GL."Production_ Shortage_Status"=GL."Production_ Shortage_Status"::nothing THEN
                                   BEGIN
                                   PO.RESET;
                                   PO.SETRANGE(PO.Status,PO.Status::Released);
                                   PO.SETRANGE(PO."Suppose to Plan",TRUE);
                                   PO.SETFILTER(PO."Prod Start date",'>%1',0D);
                                   IF PO.FINDFIRST THEN
                                   REPEAT
                                     Mat_Issue_sLine.RESET;
                                     Mat_Issue_sLine.SETCURRENTKEY("Prod. Order No.","Prod. Order Line No.","Prod. Order Comp. Line No.");
                                     Mat_Issue_sLine.SETRANGE("Prod. Order No.",PO."No.");
                                     Mat_Issue_sLine.SETRANGE("Qty. to Receive",0);
                                     //IF Mat_Issue_sLine.FINDFIRST THEN
                                       //ERROR('MATERIAL IS NOT ASSIGNED PROPERLY :'+PO."No.");
                                   UNTIL PO.NEXT=0;
                                   END;
                                 */
                    POrdersList := '';
                    POrdersList1 := '';
                    No_of_Units := 0;
                    PO.RESET;
                    PO.SETRANGE(PO.Status, PO.Status::Released);
                    PO.SETRANGE(PO."Suppose to Plan", TRUE);
                    PO.SETFILTER(PO."Prod Start date", '>%1', 0D);
                    /*IF PO.FINDFIRST THEN
                    REPEAT
                        RESERVER_MATERIAL("No.");
                    UNTIL PO.NEXT = 0;*/
                    IF PO.FINDFIRST THEN
                        REPEAT
                            IF ITEM.GET(PO."Source No.") THEN BEGIN
                                ITEM.TESTFIELD(ITEM."No.of Units");
                                No_of_Units += ITEM."No.of Units";
                            END;

                            PO.CALCFIELDS(PO."Shortage Items");
                            IF GL."Production_ Shortage_Status" = GL."Production_ Shortage_Status"::Accepted THEN BEGIN
                                IF (PO."Shortage Verified") THEN BEGIN
                                    IF (PO."No." <> 'CSM15SPA0124') THEN BEGIN
                                        WINDOW.UPDATE(1, 'POSTING MATERIAL REQUESTS');
                                        WINDOW.UPDATE(2, PO."No.");
                                        POST_MATERIAL_ISSUES(PO."No.");
                                        PO."Production Order Status" := PO."Production Order Status"::"Under Production";
                                        PO.MODIFY;
                                        POrdersList := POrdersList + PO."No." + '|';
                                    END;
                                END;
                            END ELSE BEGIN
                                IF (PO."Shortage Verified") AND (PO."Shortage Items" = 0) THEN BEGIN
                                    IF (PO."No." <> 'CSM15SPA0124') THEN BEGIN
                                        WINDOW.UPDATE(1, 'POSTING MATERIAL REQUESTS');
                                        WINDOW.UPDATE(2, PO."No.");
                                        POST_MATERIAL_ISSUES(PO."No.");
                                        PO."Production Order Status" := PO."Production Order Status"::"Under Production";
                                        PO.MODIFY;
                                        POrdersList := POrdersList + PO."No." + '|';
                                    END;
                                END;
                            END;

                        UNTIL PO.NEXT = 0;
                    WINDOW.CLOSE;
                    GL.GET;
                    GL."Production_ Shortage_Status" := GL."Production_ Shortage_Status"::nothing;

                    GL."Production Shortage Date" := 0D;
                    GL.MODIFY;
                    IF Day_wise_Details.GET(TODAY) THEN BEGIN
                        Day_wise_Details."PRODUCT WISE ISSUES POSTED" := TRUE;
                        Day_wise_Details.PLANNED_PROD_UNITS += No_of_Units;
                        Day_wise_Details.MODIFY;
                    END ELSE BEGIN
                        Day_wise_Details."POSTING DATE" := TODAY;
                        Day_wise_Details."PRODUCT WISE ISSUES POSTED" := TRUE;
                        Day_wise_Details.PLANNED_PROD_UNITS := No_of_Units;
                        Day_wise_Details.INSERT;
                    END;
                    //Added by Pranavi on 14-09-2015
                    IF POrdersList <> '' THEN BEGIN
                        POrdersList1 := COPYSTR(POrdersList, 1, STRLEN(POrdersList) - 1);
                        Body := '';
                        PrevItem := '';
                        PrevOrder := '';
                        ItemPrdQty := 0;
                        RowCount := 0;
                        //B2BUPG>>>
                        /*From_Mail := 'noreply@efftronics.com';
                        To_mail := 'lmd@efftronics.com,erp@efftronics.com,projectmanagement@efftronics.com';
                        //To_mail:='pranavi@efftronics.com';
                        Subject := 'Reg: Production Details of LED Sale Orders ';
                        SMTP_Mail.CreateMessage('ERP', From_Mail, To_mail, Subject, Body, TRUE);
                        SMTP_Mail.AppendBody('<html><head><style> divone{background-color: white; width: 1100px; padding: 20px; border-style:solid ; border-color:#8EB52B;  margin: 20px;} </style></head>');
                        SMTP_Mail.AppendBody('<body><div style="border-color:#8EB52B;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 1000px;"><label><font size="5">Production Details of LED Sale Orders</font></label>');
                        SMTP_Mail.AppendBody('<hr style=solid; color= #3333CC>');
                        SMTP_Mail.AppendBody('<table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"');
                        SMTP_Mail.AppendBody('border="1" align="Center">');
                        SMTP_Mail.AppendBody('<P> Following are details of LED Sale Orders Production Started Items Details</P>');
                        SMTP_Mail.AppendBody('<br><table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Order No</th><th>Customer Name</th><th>Item No</th><th>Item Desc</th><th>To Be Shipped Qty</th><th>Prod Qty</th>');
                        SMTP_Mail.AppendBody('<th>Order Date</th><th>Prod Start Date</th></tr>');*/ //B2BUPG<<<

                        Recipient.Add('lmd@efftronics.com');
                        Recipient.Add('erp@efftronics.com');
                        Recipient.Add('projectmanagement@efftronics.com');
                        Subject := 'Reg: Production Details of LED Sale Orders ';
                        EmailMessage.Create(Recipient, Subject, Body, true);
                        Body += ('<html><head><style> divone{background-color: white; width: 1100px; padding: 20px; border-style:solid ; border-color:#8EB52B;  margin: 20px;} </style></head>');
                        Body += ('<body><div style="border-color:#8EB52B;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 1000px;"><label><font size="5">Production Details of LED Sale Orders</font></label>');
                        Body += ('<hr style=solid; color= #3333CC>');
                        Body += ('<table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"');
                        Body += ('border="1" align="Center">');
                        Body += ('<P> Following are details of LED Sale Orders Production Started Items Details</P>');
                        Body += ('<br><table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Order No</th><th>Customer Name</th><th>Item No</th><th>Item Desc</th><th>To Be Shipped Qty</th><th>Prod Qty</th>');
                        Body += ('<th>Order Date</th><th>Prod Start Date</th></tr>');

                        PrdOrdr.RESET;
                        PrdOrdr.SETCURRENTKEY("Sales Order No.", "Source No.", "Prod Start date");
                        PrdOrdr.SETFILTER(PrdOrdr.Status, '%1', PrdOrdr.Status::Released);
                        //PrdOrdr.SETFILTER(PrdOrdr."Suppose to Plan",'%1',TRUE);
                        PrdOrdr.SETFILTER(PrdOrdr."No.", POrdersList1);
                        PrdOrdr.SETFILTER(PrdOrdr."Prod Start date", '>%1', 0D);
                        PrdOrdr.SETFILTER(PrdOrdr."Sales Order No.", '%1|%2', '*/L*', '*/T*');
                        PrdOrdr.SETFILTER(PrdOrdr."Item Sub Group Code", 'LED LIGHT');
                        REPEAT
                            pmih.RESET;
                            pmih.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
                            pmih.SETFILTER(pmih."Prod. Order No.", PrdOrdr."No.");
                            IF pmih.FINDFIRST THEN BEGIN
                                IF (PrevOrder <> '') AND (PrevItem <> '') THEN BEGIN
                                    SL.RESET;
                                    SL.SETCURRENTKEY("Document Type", "Document No.", Type, "No.");
                                    SL.SETFILTER(SL."Document No.", PrevOrder);
                                    SL.SETFILTER(SL."No.", PrevItem);
                                    IF SL.FINDFIRST THEN BEGIN
                                        SH.RESET;
                                        SH.SETCURRENTKEY("Document Type", "No.");
                                        SH.SETFILTER(SH."No.", SL."Document No.");
                                        IF SH.FINDFIRST THEN BEGIN
                                            OrderNo := SH."No.";
                                            CustName := SH."Sell-to Customer Name";
                                            No := SL."No.";
                                            ItemDesc := SL.Description;
                                            ToBeshipedQty := SL."Qty. to Ship";
                                            OrderDate := SH."Order Date";
                                            IF (PrevItem <> PrdOrdr."Source No.") AND (PrevItem <> '') THEN BEGIN
                                                IF SH."No." <> 'EFF/08-09/AUG/087' THEN BEGIN
                                                    IF ItemPrdQty > 0 THEN BEGIN
                                                        /*SMTP_Mail.AppendBody('<tr><td>' + SH."No." + '</td><td>' + SH."Sell-to Customer Name" + '</td><td>' + SL."No." + '</td><td>' + SL.Description + '</td><td  align ="right">' + FORMAT(SL."Qty. to Ship") + '</td>');
                                                        SMTP_Mail.AppendBody('<td align ="right">' + FORMAT(ItemPrdQty) + '</td><td>' + FORMAT(SH."Order Date") + '</td><td>' + FORMAT(PrdOrdr."Prod Start date") + '</td></tr>');*/ //B2BUPG
                                                        Body += ('<tr><td>' + SH."No." + '</td><td>' + SH."Sell-to Customer Name" + '</td><td>' + SL."No." + '</td><td>' + SL.Description + '</td><td  align ="right">' + FORMAT(SL."Qty. to Ship") + '</td>');
                                                        Body += ('<td align ="right">' + FORMAT(ItemPrdQty) + '</td><td>' + FORMAT(SH."Order Date") + '</td><td>' + FORMAT(PrdOrdr."Prod Start date") + '</td></tr>');
                                                        ItemPrdQty := 0;
                                                        RowCount := RowCount + 1;
                                                    END;
                                                END;
                                            END
                                            ELSE BEGIN
                                                IF (PrevOrder <> PrdOrdr."Sales Order No.") AND (PrevOrder <> '') THEN BEGIN
                                                    IF SH."No." <> 'EFF/08-09/AUG/087' THEN BEGIN
                                                        IF ItemPrdQty > 0 THEN BEGIN
                                                            /*SMTP_Mail.AppendBody('<tr><td>' + SH."No." + '</td><td>' + SH."Sell-to Customer Name" + '</td><td>' + SL."No." + '</td><td>' + SL.Description + '</td><td  align ="right">' + FORMAT(SL."Qty. to Ship") + '</td>');
                                                            SMTP_Mail.AppendBody('<td align ="right">' + FORMAT(ItemPrdQty) + '</td><td>' + FORMAT(SH."Order Date") + '</td><td>' + FORMAT(PrevPSDate) + '</td></tr>');*/ //B2BUPG
                                                            Body += ('<tr><td>' + SH."No." + '</td><td>' + SH."Sell-to Customer Name" + '</td><td>' + SL."No." + '</td><td>' + SL.Description + '</td><td  align ="right">' + FORMAT(SL."Qty. to Ship") + '</td>');
                                                            Body += ('<td align ="right">' + FORMAT(ItemPrdQty) + '</td><td>' + FORMAT(SH."Order Date") + '</td><td>' + FORMAT(PrevPSDate) + '</td></tr>');
                                                            ItemPrdQty := 0;
                                                            RowCount := RowCount + 1;
                                                        END;
                                                    END;
                                                END
                                                ELSE BEGIN
                                                    ItemPrdQty := ItemPrdQty + PrdOrdr.Quantity;
                                                END;
                                            END;   //else_end
                                        END;    //SH_End
                                    END;     //SL_End
                                END       //NullChecking_End
                                ELSE BEGIN
                                    ItemPrdQty := ItemPrdQty + PrdOrdr.Quantity;
                                END;
                            END;       //PMIH_End
                            PrevOrder := PrdOrdr."Sales Order No.";
                            PrevItem := PrdOrdr."Source No.";
                            PrevPSDate := PrdOrdr."Prod Start date";
                        UNTIL PrdOrdr.NEXT = 0;
                        IF (SH."No." <> 'EFF/08-09/AUG/087') AND (OrderNo <> '') THEN BEGIN
                            IF ItemPrdQty > 0 THEN BEGIN
                                /*SMTP_Mail.AppendBody('<tr><td>' + OrderNo + '</td><td>' + CustName + '</td><td>' + No + '</td><td>' + ItemDesc + '</td><td  align ="right">' + FORMAT(ToBeshipedQty) + '</td>');
                                SMTP_Mail.AppendBody('<td align ="right">' + FORMAT(ItemPrdQty) + '</td><td>' + FORMAT(OrderDate) + '</td><td>' + FORMAT(PrevPSDate) + '</td></tr>');*/ //B2BUPG
                                Body += ('<tr><td>' + OrderNo + '</td><td>' + CustName + '</td><td>' + No + '</td><td>' + ItemDesc + '</td><td  align ="right">' + FORMAT(ToBeshipedQty) + '</td>');
                                Body += ('<td align ="right">' + FORMAT(ItemPrdQty) + '</td><td>' + FORMAT(OrderDate) + '</td><td>' + FORMAT(PrevPSDate) + '</td></tr>');
                                RowCount := RowCount + 1;
                            END;
                        END;
                        /*SMTP_Mail.AppendBody('</table><br><p align ="left"> Regards,<br>ERP Team </p>');
                        SMTP_Mail.AppendBody('<br><p align = "center">:: Note: Auto Generated mail from ERP :: </P></div></body></html>');*/ //B2BUPG
                        Body += ('</table><br><p align ="left"> Regards,<br>ERP Team </p>');
                        Body += ('<br><p align = "center">:: Note: Auto Generated mail from ERP :: </P></div></body></html>');
                        IF RowCount > 0 THEN
                            //SMTP_Mail.Send; //B2BUPG
                          Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                    END;
                    // begin added by vijaya on 19-01-2018
                    GL.GET;
                    GL."Restrict Store Material Issues" := FALSE;
                    GL.MODIFY;
                    // end by vijaya
                    //end by pranavi

                    //Sqlintegration.PRMRefresh;

                end;
            }
            action("CANCEL RESERVATION")
            {
                Caption = 'CANCEL RESERVATION';
                Image = CancelLine;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    CANCEL_RESERVATION("No.");
                    "Shortage Verified" := FALSE;
                    MODIFY;
                end;
            }
            action("&CREATE REQUEST  RELEASE RESERVE")
            {
                Caption = '&CREATE REQUEST  RELEASE RESERVE';
                Image = CreateDocuments;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    // ERROR('REPORT UNDER DEVELOPMENT. PLEASE CONTACT ERP TEAM');

                    GL.GET;
                    IF GL."Production_ Shortage_Status" = GL."Production_ Shortage_Status"::Applied THEN
                        ERROR('YOU ASKED PERMISSION FROM MANAGEMENT, IT MUST BE ACCEPTED TO PROCEED');
                    GL."Restrict Store Material Issues" := TRUE;
                    GL.MODIFY;

                    No_of_Units := 0;
                    RESET;
                    //  SETRANGE("Sales Order No.",'<>%1','*EXP*');      //added by pranavi on 09-04-2015 for excluding expted orders from creating material rqsts
                    SETRANGE(Status, PO.Status::Released);
                    SETRANGE("Suppose to Plan", TRUE);
                    SETFILTER("Sales Order No.", '<>%1', '*EXP*');     //added by pranavi on 09-04-2015 for excluding expted orders from creating material rqsts
                    IF FINDSET THEN
                        REPEAT
                            /*    IF "Prod Start date"<>TODAY THEN
                                  ERROR('PRODUCTION START DATE MUST BE '+FORMAT(TODAY)+' IN ORDER '+FORMAT("No."));
                             */
                            IF "Planned Dispatch Date" = 0D THEN         //Added By Pranavi on 25-04-2015
                                ERROR('Please enter Planned Dispatch Date for :' + "No.");
                            IF ITEM.GET("Source No.") THEN BEGIN
                                ITEM.TESTFIELD(ITEM."No.of Units");
                                No_of_Units += ITEM."No.of Units";
                            END;
                        UNTIL NEXT = 0;

                    //  IF No_of_Units>12 THEN
                    //    ERROR('NO. OF UNITS PER DAY MUST NOT BE GREATER THAN 12 UNITS');


                    LotItemAvail.RESET;
                    LotItemAvail.DELETEALL;
                    VERIFY_BOM;
                    /*
                      IF DATE2DWY(TODAY,1)<>7 THEN
                      BEGIN
                        IF ((CURRENTDATETIME >  CREATEDATETIME(TODAY,090000T)) AND (CURRENTDATETIME <  CREATEDATETIME(TODAY,120000T)))
                            OR ((CURRENTDATETIME >  CREATEDATETIME(TODAY,140000T)) AND (CURRENTDATETIME <  CREATEDATETIME(TODAY,170000T))) THEN
                          ERROR('Postings are not Allowed from 9AM-12PM and 2PM-5PM');
                      END;
                    */

                    /*
                    // SETRANGE("Sales Order No.",'<>%1','*EXP*');     //added by pranavi on 09-04-2015 for excluding expted orders from creating material rqsts
                     SETRANGE(Status,PO.Status::Released);
                     SETRANGE("Suppose to Plan",TRUE);
                     SETFILTER("Sales Order No.",'<>%1','*EXP*');     //added by pranavi on 09-04-2015 for excluding expted orders from creating material rqsts
                     IF FIND('-') THEN
                     REPEAT
                       IF "Prod Start date"<>TODAY THEN
                         ERROR('Prod start date must be today for PO'+"No.");
                     UNTIL NEXT=0;
                    */

                    /*
                    GL.GET;
                    IF GL."Restrict Store Material Issues" THEN
                    BEGIN
                      WINDOW.OPEN(T1);
                      DUM.DELETEALL;
                      RESET;
                      //SETRANGE("Sales Order No.",'<>%1','*EXP*');    //added by pranavi on 09-04-2015 for excluding expted orders from creating material rqsts
                      SETRANGE(Status,PO.Status::Released);
                      SETRANGE("Suppose to Plan",TRUE);
                      SETRANGE("Shortage Verified",FALSE);
                      SETFILTER("Sales Order No.",'<>%1','*EXP*');     //added by pranavi on 09-04-2015 for excluding expted orders from creating material rqsts
                      IF FINDFIRST THEN
                      BEGIN
                        ERROR('Verify Stock for Production Order ',"No.");
                      END;
                    
                      SETRANGE("Shortage Verified",TRUE);
                      IF FINDSET THEN
                      REPEAT
                        CALC_REQ_QTY2("No.");
                      UNTIL NEXT=0;
                      DUM.RESET;
                      DUM.SETFILTER(DUM."Maximum Inventory",'<%1',0);
                      IF DUM.FINDFIRST THEN
                      BEGIN
                        IF GL."Production_ Shortage_Status"=GL."Production_ Shortage_Status"::Accepted THEN
                        BEGIN
                          REPEAT
                            PO_SHORTAGE_ITEMS.RESET;
                            PO_SHORTAGE_ITEMS.SETFILTER(PO_SHORTAGE_ITEMS.Item,DUM."No.");
                            IF NOT PO_SHORTAGE_ITEMS.FINDFIRST  THEN
                               ERROR('There is Some material Shortage in Prod Stores');
                          UNTIL DUM.NEXT=0;
                        END
                        ELSE
                          SETFILTER("Shortage Items",'>%1',0);
                          IF FINDSET THEN
                            ERROR('THERE IS SHORTAGE FOR '+"No."+' PLEASE GET THE APPROVAL FROM MNG')
                          ELSE
                            ERROR('There is Some material Shortage in Prod Stores');
                      END;
                      DUM.RESET;
                      IF DUM.FINDFIRST THEN
                      BEGIN
                        MaterialIssueHeader.RESET;
                        MaterialIssueHeader.INIT;
                        MaterialIssueHeader."No." :=GetNextNo;
                        MaterialIssueHeader."Receipt Date":=TODAY;
                        MaterialIssueHeader."Transfer-from Code" := 'PRODSTR';
                        MaterialIssueHeader."Transfer-to Code":='STR';
                        MaterialIssueHeader.VALIDATE("Prod. Order No.",'EFF11STR01');
                        MaterialIssueHeader.VALIDATE("Prod. Order Line No.",10000);
                        MaterialIssueHeader."User ID" := USERID;
                        USER.GET(USERSECURITYID);
                        MaterialIssueHeader."Resource Name":=USER.Name;
                        MaterialIssueHeader."Creation DateTime":=CURRENTDATETIME;
                        MaterialIssueHeader."Sales Order No.":="Sales Order No.";
                        MaterialIssueHeader.INSERT;
                      END;
                      REPEAT
                        LineNo := LineNo + 10000;
                        IF ITEM.GET(DUM."No.") THEN
                        BEGIN
                          MaterialIssueLine.INIT;
                          MaterialIssueLine."Document No." :=MaterialIssueHeader."No." ;
                          MaterialIssueLine.VALIDATE("Item No.",ITEM."No.");
                          MaterialIssueLine."Line No." := LineNo;
                          MaterialIssueLine."Unit of Measure Code" := ITEM."Base Unit of Measure";
                          MaterialIssueLine.VALIDATE("Unit of Measure Code");
                          MaterialIssueLine.VALIDATE("Unit of Measure");
                          MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity,DUM."Total Inventory");
                          MaterialIssueLine."Prod. Order No." := 'EFF11STR01';
                          MaterialIssueLine."Prod. Order Line No." :=10000;
                          MaterialIssueLine."Production BOM No.":=MaterialIssueHeader."Prod. BOM No.";
                          MaterialIssueLine.INSERT;
                        END;
                      UNTIL DUM.NEXT=0;
                    
                      RELEASE_MATERIAL_REQUEST1("No.");
                      RESERVER_MATERIAL1("No.");
                      POST_MATERIAL_ISSUES1("No.");
                    
                      IF FINDFIRST THEN
                      REPEAT
                        WINDOW.UPDATE(1,'CREATING MATERIAL REQUEST ');
                        WINDOW.UPDATE(2,"No.");
                        PO_FORM.CreateALLMaterialIssues_New("No.");
                        WINDOW.UPDATE(1,'RELEASING MATERIAL REQUEST ');
                        RELEASE_MATERIAL_REQUEST("No.");
                        RESERVER_MATERIAL("No.");
                      UNTIL NEXT=0;
                    
                      WINDOW.CLOSE;
                    END ELSE
                      ERROR('PLEASE CONFIRM THE PRODUCTION');
                    
                    */
                    GL.GET;
                    IF GL."Restrict Store Material Issues" THEN BEGIN
                        IF Date_Filter = FORMAT(TODAY) THEN BEGIN
                            //SETRANGE("Sales Order No.",'<>%1','*EXP*');     //added by pranavi on 09-04-2015 for excluding expted orders from creating material rqsts
                            SETRANGE(Status, PO.Status::Released);
                            SETRANGE("Suppose to Plan", TRUE);
                            SETFILTER("Sales Order No.", '<>%1', '*EXP*');     //added by pranavi on 09-04-2015 for excluding expted orders from creating material rqsts
                            IF FIND('-') THEN
                                REPEAT
                                    WINDOW.OPEN(T1);
                                    CALCFIELDS("Shortage Items");
                                UNTIL NEXT = 0;
                            //  WINDOW.CLOSE;                 //sriram
                            IF GL."Production_ Shortage_Status" = GL."Production_ Shortage_Status"::Accepted THEN BEGIN
                                IF ("Shortage Verified") THEN BEGIN

                                    DUM.DELETEALL;//func
                                                  //  SETRANGE("Sales Order No.",'<>%1','*EXP*');    //added by pranavi on 09-04-2015 for excluding expted orders from creating material rqsts
                                    SETRANGE(Status, PO.Status::Released);
                                    SETRANGE("Suppose to Plan", TRUE);
                                    SETFILTER("Sales Order No.", '<>%1', '*EXP*');     //added by pranavi on 09-04-2015 for excluding expted orders from creating material rqsts
                                    IF FIND('-') THEN
                                        REPEAT
                                            CALC_REQ_QTY("No.");
                                        UNTIL NEXT = 0;

                                    DUM.RESET;
                                    DUM.SETFILTER(DUM."Maximum Inventory", '<%1', 0);
                                    IF DUM.FINDFIRST THEN
                                        REPEAT
                                            PO_SHORTAGE_ITEMS.RESET;
                                            PO_SHORTAGE_ITEMS.SETRANGE(PO_SHORTAGE_ITEMS.Item, DUM."No.");
                                        /*            IF NOT PO_SHORTAGE_ITEMS.FINDFIRST  THEN
                                                       ERROR('There is Some material Shortage in Prod Stores for the item :'+FORMAT(PO_SHORTAGE_ITEMS.Item));
                                        */
                                        UNTIL DUM.NEXT = 0;
                                    //SETRANGE("Sales Order No.",'<>%1','*EXP*');   //added by pranavi on 09-04-2015 for excluding expted orders from creating material rqsts
                                    SETRANGE(Status, PO.Status::Released);
                                    SETRANGE("Suppose to Plan", TRUE);
                                    SETFILTER("Sales Order No.", '<>%1', '*EXP*');     //added by pranavi on 09-04-2015 for excluding expted orders from creating material rqsts
                                    IF FIND('-') THEN
                                        REPEAT
                                            WINDOW.UPDATE(1, 'CREATING MATERIAL REQUEST ');
                                            WINDOW.UPDATE(2, "No.");
                                            PO_FORM.CreateALLMaterialIssues_New("No.");
                                            WINDOW.UPDATE(1, 'RELEASING MATERIAL REQUEST ');
                                            RELEASE_MATERIAL_REQUEST("No.");
                                            RESERVER_MATERIAL("No.");
                                        UNTIL NEXT = 0;
                                END;
                            END ELSE //IF GL."Production_ Shortage_Status"=GL."Production_ Shortage_Status"::Accepted THEN
                            BEGIN
                                IF ("Shortage Verified") THEN BEGIN
                                    DUM.DELETEALL;
                                    //SETRANGE("Sales Order No.",'<>%1','*EXP*');   //added by pranavi on 09-04-2015 for excluding expted orders from creating material rqsts
                                    SETRANGE(Status, PO.Status::Released);
                                    SETRANGE("Suppose to Plan", TRUE);
                                    SETFILTER("Sales Order No.", '<>%1', '*EXP*');     //added by pranavi on 09-04-2015 for excluding expted orders from creating material rqsts
                                    IF FIND('-') THEN   //func
                                        REPEAT
                                            CALC_REQ_QTY("No.");
                                        UNTIL NEXT = 0;
                                    IF FIND('-') THEN
                                        REPEAT
                                            WINDOW.UPDATE(1, 'CREATING MATERIAL REQUEST ');
                                            WINDOW.UPDATE(2, "No.");
                                            PO_FORM.CreateALLMaterialIssues_New("No.");
                                            WINDOW.UPDATE(1, 'RELEASING MATERIAL REQUEST ');
                                            RELEASE_MATERIAL_REQUEST("No.");
                                            RESERVER_MATERIAL("No.");
                                        UNTIL NEXT = 0;
                                END ELSE
                                    ERROR(' THERE IS SHORTAGE FOR ' + "No." + ' PLEASE GET THE APPROVAL FROM MNG');
                            END;
                            //ELSE
                            //  ERROR('GET AUTHORIZATION FROM MANAGEMENT FOR PRODUCTION');
                            WINDOW.CLOSE;                  //sriram
                        END ELSE
                            ERROR(' THIS PROVISION WILL WORK ONLY IN "CURRENT" OPTION ONLY');
                    END ELSE
                        ERROR('PLEASE CONFIRM THE PRODUCTION');
                    //Posting
                    /*
                      WINDOW.OPEN(T1);
                      GL.GET;
                      GL."Restrict Store Material Issues":=FALSE;
                      GL.MODIFY;
                       No_of_Units:=0;
                      PO.RESET;
                      //PO.SETRANGE(PO."Sales Order No.",'<>%1','*EXP*');       //added by pranavi on 09-04-2015 for excluding expted orders from creating material rqsts
                      PO.SETRANGE(PO.Status,PO.Status::Released);
                      PO.SETRANGE(PO."Suppose to Plan",TRUE);
                      PO.SETFILTER(PO."Prod Start date",'>%1',0D);
                      PO.SETFILTER(PO."Sales Order No.",'<>%1','*EXP*');     //added by pranavi on 09-04-2015 for excluding expted orders from creating material rqsts
                      IF PO.FINDFIRST THEN
                      REPEAT
                        IF ITEM.GET(PO."Source No.") THEN
                        BEGIN
                          ITEM.TESTFIELD(ITEM."No.of Units");
                          No_of_Units+=ITEM."No.of Units";
                        END;
                    
                        PO.CALCFIELDS(PO."Shortage Items");
                        IF GL."Production_ Shortage_Status"=GL."Production_ Shortage_Status"::Accepted THEN
                        BEGIN
                          IF (PO."Shortage Verified")  THEN
                          BEGIN
                            WINDOW.UPDATE(1,'POSTING MATERIAL REQUESTS');
                            WINDOW.UPDATE(2,PO."No.");
                            POST_MATERIAL_ISSUES(PO."No.");
                          END;
                        END ELSE
                        BEGIN
                          IF (PO."Shortage Verified") AND (PO."Shortage Items"=0) THEN
                          BEGIN
                            WINDOW.UPDATE(1,'POSTING MATERIAL REQUESTS');
                            WINDOW.UPDATE(2,PO."No.");
                            POST_MATERIAL_ISSUES(PO."No.");
                          END;
                        END;
                      UNTIL PO.NEXT=0;
                      WINDOW.CLOSE;
                      GL.GET;
                      GL."Production_ Shortage_Status":=GL."Production_ Shortage_Status"::nothing;
                      GL."Production Shortage Date":=0D;
                      GL.MODIFY;
                      IF Day_wise_Details.GET(TODAY) THEN
                      BEGIN
                        Day_wise_Details."PRODUCT WISE ISSUES POSTED":=TRUE;
                        Day_wise_Details.PLANNED_PROD_UNITS+=No_of_Units;
                        Day_wise_Details.MODIFY;
                      END ELSE
                      BEGIN
                        Day_wise_Details."POSTING DATE":=TODAY;
                        Day_wise_Details."PRODUCT WISE ISSUES POSTED":=TRUE;
                        Day_wise_Details.PLANNED_PROD_UNITS:=No_of_Units;
                        Day_wise_Details.INSERT;
                      END;
                    */

                end;
            }
            action("&SHOW RESERVED ITEMS")
            {
                Caption = '&SHOW RESERVED ITEMS';
                Image = ItemReservation;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    REPORT.RUN(50113);
                end;
            }
            action("&VERIFY STOCK")
            {
                Caption = '&VERIFY STOCK';
                Image = CheckDuplicates;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ERROR('PLEASE CONTACT ERP TEAM');

                    GL.GET;
                    IF GL."Production_ Shortage_Status" = GL."Production_ Shortage_Status"::Applied THEN
                        ERROR('YOU ASKED PERMISSION FROM MANAGEMENT, VERIFY STOCK NOT ALLOWED');


                    LotItemAvail.RESET;
                    LotItemAvail.DELETEALL;
                    VERIFY_BOM;

                    No_of_Units := 0;
                    PO_SHORTAGEITEMS.RESET;
                    PO_SHORTAGEITEMS.DELETEALL;
                    COMMIT;
                    PROD_PLAN_DATE := 0D;
                    ProdOrder.SETRANGE(Status, ProdOrder.Status::Released);
                    ProdOrder.SETFILTER(ProdOrder."Prod Start date", '<>%1', 0D);
                    ProdOrder.SETFILTER(ProdOrder."Product Group Code", 'FPRODUCT|CPCB');
                    ProdOrder.SETRANGE("Suppose to Plan", TRUE);
                    IF ProdOrder.FINDSET THEN
                        REPEAT
                            VERIFY_MATERIAL_ISSUES(ProdOrder."No.");
                            IF ProdOrder."Prod Start date" <> TODAY THEN      // Added by Pranavi on 23-Feb-2017
                                ERROR('Prod start date must be today for PO ' + ProdOrder."No.");
                        UNTIL ProdOrder.NEXT = 0;
                    BEGIN
                        //Inv_Calc.SetCalcType(FALSE);//B2BUPG
                        //REPORT.RUN(705, FALSE, FALSE, ProdOrder);
                        REPORT.RUN(50181, FALSE, FALSE, ProdOrder);
                    END;
                end;
            }
            action("&Calc Shortage For Planning")
            {
                Caption = '&Calc Shortage For Planning';
                Image = CalculateRegenerativePlan;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    GL.GET;
                    IF GL."Production_ Shortage_Status" = GL."Production_ Shortage_Status"::Applied THEN
                        ERROR('YOU ASKED PERMISSION FROM MANAGEMENT, VERIFY STOCK NOT ALLOWED');


                    LotItemAvail.RESET;
                    LotItemAvail.DELETEALL;

                    VERIFY_BOM;

                    No_of_Units := 0;
                    PO_SHORTAGEITEMS.RESET;
                    PO_SHORTAGEITEMS.DELETEALL;
                    COMMIT;
                    PROD_PLAN_DATE := 0D;
                    ProdOrder.SETCURRENTKEY(Status, "Prod Start date", "No.");
                    ProdOrder.SETRANGE(Status, ProdOrder.Status::Released);
                    ProdOrder.SETFILTER(ProdOrder."Prod Start date", '<>%1', 0D);
                    ProdOrder.SETFILTER(ProdOrder."Product Group Code", 'FPRODUCT|CPCB');
                    ProdOrder.SETRANGE("Suppose to Plan", TRUE);
                    IF ProdOrder.FINDSET THEN
                        REPEAT
                            VERIFY_MATERIAL_ISSUES(ProdOrder."No.");
                        UNTIL ProdOrder.NEXT = 0;
                    BEGIN
                        CLEAR(Inv_Calc);
                        Inv_Calc.SETTABLEVIEW(ProdOrder);
                        //Inv_Calc.SetCalcType(TRUE);//B2BUPG
                        Inv_Calc.RUNMODAL();
                    END;
                end;
            }
            action("Shortage Cumulative")
            {
                Caption = 'Shortage Cumulative';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PAGE.RUN(50007);
                end;
            }
            action(SupposeToPLan)
            {
                Caption = 'Suppose To PLan';
                Visible = fieldvisible;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //Added by Pranavi ON 30-Nov-2015 for auto suppose to plan

                    PO1.RESET;
                    PO1.SETFILTER(PO1.Status, '%1', PO1.Status::Released);
                    PO1.SETFILTER(PO1."Prod Start date", ProdStartDateFilter);
                    IF PO1.FINDSET THEN
                        REPEAT
                            IF PO1."Prod Start date" <> 0D THEN BEGIN
                                PO1."Suppose to Plan" := SupToPlan;
                                PO1.VALIDATE("Suppose to Plan");
                                PO1.MODIFY;
                            END;
                        UNTIL PO1.NEXT = 0;
                    //END by Pranavi ON 30-Nov-2015
                end;
            }
            action("Shortage Cumulative 1")
            {
                Caption = 'Shortage Cumulative 1';
                Image = SuggestLines;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PAGE.RUN(50012);
                end;
            }
            action(Test)
            {
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*
                    MESSAGE('hi');
                    SETRANGE(Status,PO.Status::Released);
                    SETRANGE("Suppose to Plan",TRUE);
                    SETFILTER("Sales Order No.",'<>%1','*EXP*');     //added by pranavi on 09-04-2015 for excluding expted orders from creating material rqsts
                    IF FIND('-') THEN
                    REPEAT
                      WINDOW.OPEN(T1);
                      WINDOW.UPDATE(1,'For PO MATERIAL REQUEST');
                      WINDOW.UPDATE(2,"No.");
                      RESERVER_MATERIAL("No.");
                    UNTIL NEXT=0;
                    */
                    Post_Action_Auto_Scheduled;

                end;
            }
            action(ReserveMaterial)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    WINDOW.OPEN(T1);
                    PO.RESET;
                    PO.SETRANGE(PO.Status, PO.Status::Released);
                    PO.SETRANGE(PO."Suppose to Plan", TRUE);
                    PO.SETFILTER(PO."Prod Start date", '>%1', 0D);
                    IF PO.FINDFIRST THEN
                        REPEAT
                            WINDOW.UPDATE(1, 'RELEASING MATERIAL REQUEST ');
                            RESERVER_MATERIAL(PO."No.");
                        UNTIL PO.NEXT = 0;
                end;
            }
        }
    }

    // Could not resolve the usercontrol owning 'RecordSet@1102154042::WillChangeField@9'
    //trigger WillChangeField(cFields: Integer;"Fields": Variant;adStatus: Integer;pRecordset: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'RecordSet@1102154042::FieldChangeComplete@10'
    //trigger FieldChangeComplete(cFields: Integer;"Fields": Variant;pError: Automation ;adStatus: Integer;pRecordset: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'RecordSet@1102154042::WillChangeRecord@11'
    //trigger WillChangeRecord(adReason: Integer;cRecords: Integer;adStatus: Integer;pRecordset: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'RecordSet@1102154042::RecordChangeComplete@12'
    //trigger RecordChangeComplete(adReason: Integer;cRecords: Integer;pError: Automation ;adStatus: Integer;pRecordset: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'RecordSet@1102154042::WillChangeRecordset@13'
    //trigger WillChangeRecordset(adReason: Integer;adStatus: Integer;pRecordset: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'RecordSet@1102154042::RecordsetChangeComplete@14'
    //trigger RecordsetChangeComplete(adReason: Integer;pError: Automation ;adStatus: Integer;pRecordset: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'RecordSet@1102154042::WillMove@15'
    //trigger WillMove(adReason: Integer;adStatus: Integer;pRecordset: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'RecordSet@1102154042::MoveComplete@16'
    //trigger MoveComplete(adReason: Integer;pError: Automation ;adStatus: Integer;pRecordset: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'RecordSet@1102154042::EndOfRecordset@17'
    //trigger EndOfRecordset(var fMoreData: Boolean;adStatus: Integer;pRecordset: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'RecordSet@1102154042::FetchProgress@18'
    //trigger FetchProgress(Progress: Integer;MaxProgress: Integer;adStatus: Integer;pRecordset: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'RecordSet@1102154042::FetchComplete@19'
    //trigger FetchComplete(pError: Automation ;adStatus: Integer;pRecordset: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'SQLConnection@1102154043::InfoMessage@0'
    //trigger InfoMessage(pError: Automation ;adStatus: Integer;pConnection: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'SQLConnection@1102154043::BeginTransComplete@1'
    //trigger BeginTransComplete(TransactionLevel: Integer;pError: Automation ;adStatus: Integer;pConnection: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'SQLConnection@1102154043::CommitTransComplete@3'
    //trigger CommitTransComplete(pError: Automation ;adStatus: Integer;pConnection: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'SQLConnection@1102154043::RollbackTransComplete@2'
    //trigger RollbackTransComplete(pError: Automation ;adStatus: Integer;pConnection: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'SQLConnection@1102154043::WillExecute@4'
    //trigger WillExecute(var Source: Text[1024];CursorType: Integer;LockType: Integer;var Options: Integer;adStatus: Integer;pCommand: Automation ;pRecordset: Automation ;pConnection: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'SQLConnection@1102154043::ExecuteComplete@5'
    //trigger ExecuteComplete(RecordsAffected: Integer;pError: Automation ;adStatus: Integer;pCommand: Automation ;pRecordset: Automation ;pConnection: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'SQLConnection@1102154043::WillConnect@6'
    //trigger WillConnect(var ConnectionString: Text[1024];var UserID: Text[1024];var Password: Text[1024];var Options: Integer;adStatus: Integer;pConnection: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'SQLConnection@1102154043::ConnectComplete@7'
    //trigger ConnectComplete(pError: Automation ;adStatus: Integer;pConnection: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'SQLConnection@1102154043::Disconnect@8'
    //trigger Disconnect(adStatus: Integer;pConnection: Automation )
    //begin
    /*
    */
    //end;

    trigger OnAfterGetRecord()
    begin
        NoOnFormat;
    end;

    trigger OnInit()
    begin
        IF USERID IN ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SPURTHI', 'EFFTRONICS\ANVESH', 'EFFTRONICS\VSNGEETHA', 'EFFTRONICS\GRAVI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'] THEN
            fieldvisible := TRUE
        ELSE
            fieldvisible := FALSE;
    end;

    trigger OnOpenPage()
    begin

        SETRANGE(Status, Status::Released);

        Date_Filter := FORMAT(TODAY);
        //SETFILTER("Prod Start date",Date_Filter);
        SETRANGE("Suppose to Plan", TRUE);
        GL.GET;
        IF GL."Restrict Store Material Issues" THEN
            Confirmation := TRUE;
    end;

    var
        PO: Record "Production Order";
        PO_SHORTAGEITEMS: Record "Production Order Shortage Item";
        PO_FORM: Page "Released Production Order";
        MATERIAL_ISSUES_HEAER: Record "Material Issues Header";
        "Release MaterialIssue Document": Codeunit "Release MaterialIssue Document";
        T1: Label '#1##################  FOR #2#############################';
        WINDOW: Dialog;
        CHOICE: Option CURRENT,NEXT;
        Issue_Post: Codeunit "MaterialIssueOrde-Post Receipt";
        "Tracking Specification": Record "Mat.Issue Track. Specification";
        "Material Issues Line": Record "Material Issues Line";
        GL: Record "General Ledger Setup";
        POSTED_MATERIAL_ISSUES_HEADER: Record "Posted Material Issues Header";
        Date_Filter: Text[30];
        MATERIAL_ISSUES_HEADER: Record "Material Issues Header";
        check: Boolean;
        Confirmation: Boolean;
        Mat_Issue_sLine: Record "Material Issues Line";
        REQUESTS_TO: Option CEO,DIR,DIR2,ANVESH,ANIL;
        USER: Record User;
        Mail_Body: Text[1000];
        Mail_Subject: Text[100];
        Mail_Send_To: Text[250];
        From_Mail: Text[30];
        To_mail: Text[250];
        FileDirectory: Text[100];
        FileName: Text[100];
        RunOnceFile: Text[1000];
        TimeOut: Integer;
        Attachment: Text[100];
        //SMTP_Mail: Codeunit "SMTP Mail";
        No_of_Units: Decimal;
        ITEM: Record Item;
        Manf_Setup: Record "Manufacturing Setup";
        //BullZipPDF: Automation ;
        PROD_PLAN_DATE: Date;
        //SQLConnection: Automation ;
        //RecordSet: Automation ;
        SQLQuery: Text[1000];
        LineSQLQuery: Text[250];
        HeadID: Text[30];
        UpdateWebHead: Text[250];
        WebRecStatus: Text[30];
        OldWebStatus: Text[30];
        Quotes: Label '''';
        Text50001: Label 'NEW';
        Text50002: Label 'OLD';
        Day_wise_Details: Record "DAY WISE DETAILS";
        DUM: Record Item temporary;
        InventorySetup: Record "Inventory Setup";
        MaterialIssueHeader: Record "Material Issues Header";
        MaterialIssueLine: Record "Material Issues Line";
        LineNo: Integer;
        K: Integer;
        ProdOrder: Record "Production Order";
        PO_SHORTAGE_ITEMS: Record "Production Order Shortage Item";
        Item2: Record Item;
        POC: Record "Prod. Order Component";
        BI: Boolean;
        "No.Emphasize": Boolean;
        Text19014658: Label 'Date Filter';
        Text19011164: Label 'TOTAL PRODUCTS';
        Text19035356: Label 'INFORMING TO';
        Text19050541: Label 'Day Wise Shortage';
        StyleTx: Text;
        UserSetup: Record "User Setup";
        PcbGRec: Record PCB;
        LotItemAvail: Record "Lot wise Item Availability";
        "PO-LINE": Record "Prod. Order Line";
        loopVar: Integer;
        SHORT: Boolean;
        SHORTAGE_QTY: Decimal;
        ShortageItems: Record "Production Order Shortage Item";
        SalesHeader: Record "Sales Header";
        PrdOrdr: Record "Production Order";
        Subject: Text;
        Body: Text;
        PrevItem: Code[50];
        PrevOrder: Code[50];
        ItemPrdQty: Decimal;
        SL: Record "Sales Line";
        SH: Record "Sales Header";
        pmih: Record "Posted Material Issues Header";
        POrdr: Record "Production Order";
        PrevPSDate: Date;
        POrdersList: Text;
        POrdersList1: Text;
        OrderNo: Text;
        CustName: Text;
        No: Text;
        ItemDesc: Text;
        ToBeshipedQty: Decimal;
        OrderDate: Date;
        RowCount: Integer;
        ProdStartDateFilter: Text;
        SupToPlan: Boolean;
        fieldvisible: Boolean;
        PO1: Record "Production Order";
        SH1: Record "Sales Header";
        //Inv_Calc: Report "Inventory Availability";
        Inv_Calc: Report 50181;//EFFUPG
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipient: List of [Text];


    procedure RELEASE_MATERIAL_REQUEST("PROD. ORDER": Code[20])
    begin
        MATERIAL_ISSUES_HEAER.RESET;
        MATERIAL_ISSUES_HEAER.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
        MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER."Prod. Order No.", "PROD. ORDER");
        MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER.Status, MATERIAL_ISSUES_HEAER.Status::Open);
        IF MATERIAL_ISSUES_HEAER.FINDSET THEN
            REPEAT
                "Release MaterialIssue Document".Release_Request(MATERIAL_ISSUES_HEAER);
            UNTIL MATERIAL_ISSUES_HEAER.NEXT = 0;
    end;


    procedure RESERVER_MATERIAL("Prod. Order": Code[20])
    begin
        MATERIAL_ISSUES_HEAER.RESET;
        MATERIAL_ISSUES_HEAER.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
        MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER."Prod. Order No.", "Prod. Order");
        MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER."Transfer-to Code", 'PROD');
        MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER.Status, MATERIAL_ISSUES_HEAER.Status::Released);
        IF MATERIAL_ISSUES_HEAER.FINDSET THEN
            REPEAT
                WINDOW.UPDATE(1, 'RESERVING THE MATERIAL ');
                CODEUNIT.RUN(60014, MATERIAL_ISSUES_HEAER);
            UNTIL MATERIAL_ISSUES_HEAER.NEXT = 0;
    end;


    procedure POST_MATERIAL_ISSUES("PROD. ORDER": Code[20])
    begin
        MATERIAL_ISSUES_HEAER.RESET;
        MATERIAL_ISSUES_HEAER.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
        MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER."Prod. Order No.", "PROD. ORDER");
        MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER."Transfer-to Code", 'PROD');
        MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER.Status, MATERIAL_ISSUES_HEAER.Status::Released);
        IF MATERIAL_ISSUES_HEAER.FINDSET THEN
            REPEAT
                MATERIAL_ISSUES_HEAER."Posting Date" := TODAY;
                Issue_Post.Issues_Post(MATERIAL_ISSUES_HEAER);
            /* Mat_Issue_sLine.RESET;
             Mat_Issue_sLine.SETRANGE(Mat_Issue_sLine."Document No.",MATERIAL_ISSUES_HEAER."No.");
             IF Mat_Issue_sLine.FINDSET THEN
             REPEAT
               Mat_Issue_sLine."Qty. to Receive":=Mat_Issue_sLine.Quantity-Mat_Issue_sLine."Quantity Received";
               Mat_Issue_sLine.MODIFY;
             UNTIL Mat_Issue_sLine.NEXT=0;*/
            //COMMIT; // pranavi on 31-01-2017
            UNTIL MATERIAL_ISSUES_HEAER.NEXT = 0;

    end;


    procedure CANCEL_RESERVATION(Production_Order: Code[20])
    begin
        MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER.Status, MATERIAL_ISSUES_HEAER.Status::Released);
        MATERIAL_ISSUES_HEAER.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
        MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER."Prod. Order No.", Production_Order);
        IF MATERIAL_ISSUES_HEAER.FINDSET THEN
            REPEAT
                "Material Issues Line".RESET;
                "Material Issues Line".SETRANGE("Material Issues Line"."Document No.", MATERIAL_ISSUES_HEAER."No.");
                IF "Material Issues Line".FINDSET THEN
                    REPEAT
                        "Material Issues Line".DELETE;
                    UNTIL "Material Issues Line".NEXT = 0;
                MATERIAL_ISSUES_HEAER.DELETE;
                "Tracking Specification".RESET;
                "Tracking Specification".SETRANGE("Tracking Specification"."Order No.", MATERIAL_ISSUES_HEAER."No.");
                IF "Tracking Specification".FINDSET THEN
                    REPEAT
                        "Tracking Specification".DELETE;
                    UNTIL "Tracking Specification".NEXT = 0;
            UNTIL MATERIAL_ISSUES_HEAER.NEXT = 0;
    end;


    procedure PLAN_DATE() PROD_PLAN_DATE: Date
    begin
        IF NOT ((DATE2DWY(TODAY, 1) = 5) OR (DATE2DWY(TODAY, 1) = 6)) THEN
            PROD_PLAN_DATE := TODAY + 2
        ELSE
            PROD_PLAN_DATE := TODAY + 3;
        EXIT(PROD_PLAN_DATE);
    end;


    procedure VERIFY_MATERIAL_ISSUES(PROD_ORDER: Code[20])
    begin
        MATERIAL_ISSUES_HEAER.RESET;
        MATERIAL_ISSUES_HEAER.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
        MATERIAL_ISSUES_HEAER.SETRANGE("Prod. Order No.", PROD_ORDER);
        IF MATERIAL_ISSUES_HEAER.FINDFIRST THEN
            ERROR('MATERAIL REQUESTS ALL READY THERE FOR ' + PROD_ORDER);
        POSTED_MATERIAL_ISSUES_HEADER.RESET;
        POSTED_MATERIAL_ISSUES_HEADER.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
        POSTED_MATERIAL_ISSUES_HEADER.SETRANGE("Prod. Order No.", PROD_ORDER);
        IF POSTED_MATERIAL_ISSUES_HEADER.FINDFIRST THEN
            ERROR('MATERAIL ISSUES ALL READY THERE FOR ' + PROD_ORDER);
    end;


    procedure RELEASE_MATERIAL_REQUEST1("PROD. ORDER": Code[20])
    begin
        MATERIAL_ISSUES_HEAER.RESET;
        MATERIAL_ISSUES_HEAER.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
        MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER."Prod. Order No.", 'EFF11STR01');
        MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER."Transfer-to Code", 'STR');
        MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER.Status, MATERIAL_ISSUES_HEAER.Status::Open);
        IF MATERIAL_ISSUES_HEAER.FINDSET THEN
            REPEAT
                "Release MaterialIssue Document".Release_Request(MATERIAL_ISSUES_HEAER);
            UNTIL MATERIAL_ISSUES_HEAER.NEXT = 0;
    end;


    procedure RESERVER_MATERIAL1("Prod. Order": Code[20])
    begin
        MATERIAL_ISSUES_HEAER.RESET;
        MATERIAL_ISSUES_HEAER.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
        MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER."Prod. Order No.", 'EFF11STR01');
        MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER."Transfer-to Code", 'STR');
        MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER.Status, MATERIAL_ISSUES_HEAER.Status::Released);
        IF MATERIAL_ISSUES_HEAER.FINDSET THEN
            REPEAT
                WINDOW.UPDATE(1, 'RESERVING THE MATERIAL ');
                CODEUNIT.RUN(60014, MATERIAL_ISSUES_HEAER);
            UNTIL MATERIAL_ISSUES_HEAER.NEXT = 0;
    end;


    procedure POST_MATERIAL_ISSUES1("PROD. ORDER": Code[20])
    begin
        MATERIAL_ISSUES_HEAER.RESET;
        MATERIAL_ISSUES_HEAER.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
        MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER."Prod. Order No.", 'EFF11STR01');
        MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER."Transfer-to Code", 'STR');
        MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER.Status, MATERIAL_ISSUES_HEAER.Status::Released);
        IF MATERIAL_ISSUES_HEAER.FINDSET THEN
            REPEAT
                MATERIAL_ISSUES_HEAER."Posting Date" := TODAY;
                Issue_Post.Issues_Post(MATERIAL_ISSUES_HEAER);
                Mat_Issue_sLine.RESET;
                Mat_Issue_sLine.SETRANGE(Mat_Issue_sLine."Document No.", MATERIAL_ISSUES_HEAER."No.");
                IF Mat_Issue_sLine.FINDSET THEN
                    REPEAT
                        Mat_Issue_sLine."Qty. to Receive" := Mat_Issue_sLine.Quantity - Mat_Issue_sLine."Quantity Received";
                        Mat_Issue_sLine.MODIFY;
                    UNTIL Mat_Issue_sLine.NEXT = 0;

            UNTIL MATERIAL_ISSUES_HEAER.NEXT = 0;
    end;


    procedure CALC_REQ_QTY("PROD. Order": Code[20])
    var
        LineNo: Integer;
        ProdOrderComp: Record "Prod. Order Component";
        MaterialIssueHeader: Record "Material Issues Header";
        MaterialIssueLine: Record "Material Issues Line";
        PostedMaterialIssueHeader: Record "Posted Material Issues Header";
        Text0003: Label 'Material Issue already existed against this Prod. Order %1';
        ProdOrderLine: Record "Prod. Order Line";
        i: Integer;
        Prod_Order: Record "Production Order";
        ProdCompLine: Record "Prod. Order Component";
    begin
        MaterialIssueHeader.SETRANGE("Prod. Order No.", "PROD. Order");
        IF MaterialIssueHeader.FINDFIRST THEN
            ERROR(Text0003, "PROD. Order");
        PostedMaterialIssueHeader.SETRANGE("Prod. Order No.", "PROD. Order");
        IF PostedMaterialIssueHeader.FINDFIRST THEN
            ERROR(Text0003, "PROD. Order");

        PO.RESET;
        PO.SETRANGE(PO."No.", "PROD. Order");
        IF PO.FINDFIRST THEN BEGIN
            IF PO."Source No." = 'BISMR0001' THEN
                BI := TRUE;
        END;

        ProdOrderLine.RESET;

        ProdOrderLine.SETRANGE("Prod. Order No.", "PROD. Order");
        IF ProdOrderLine.FINDSET THEN
            REPEAT
                Item2.RESET;
                Item2.SETFILTER(Item2."No.", ProdOrderLine."Item No.");
                IF Item2.FINDFIRST THEN BEGIN
                    IF (ProdOrderLine."Line No." <> 10000) OR ((ProdOrderLine."Line No." = 10000) AND (Item2."Product Group Code cust" <> 'FPRODUCT')) THEN BEGIN
                        ProdCompLine.RESET;
                        ProdCompLine.SETFILTER(ProdCompLine."Prod. Order No.", "PROD. Order");
                        ProdCompLine.SETFILTER(ProdCompLine."Prod. Order Line No.", FORMAT(ProdOrderLine."Line No."));
                        ProdCompLine.SETFILTER(ProdCompLine."Product Group Code", 'PCB');
                        IF ProdCompLine.FINDFIRST THEN BEGIN
                            PcbGRec.RESET;
                            PcbGRec.SETRANGE(PcbGRec."PCB No.", ProdCompLine."Item No.");
                            PcbGRec.SETFILTER(PcbGRec.Stencil, '<>%1', '');
                            IF PcbGRec.FINDFIRST THEN


                            //Added by swathi on 24-10-13 for stencil process
                            /*PcbGRec.RESET;
                            PcbGRec.SETRANGE(PcbGRec."PCB No.",ProdOrderLine."Item No.");
                            PcbGRec.SETFILTER(PcbGRec.Stencil,'<>%1','');
                            IF PcbGRec. FINDFIRST THEN      //Added by swathi on 24-10-13 for stencil process
                            */
                            /*
                            IF ProdOrderLine."Item No."IN ['ECPBPCB00431','ECPBPCB00434','ECPBPCB00549','ECPBPCB00553',
                                                           'ECPBPCB00882','ECPBPCB00554','ECPBPCB00566','ECPBPCB00856',
                                                           'ECPBPCB00936','ECPBPCB00934','ECPBPCB01049','ECPBPCB01038',
                                                           'ECPBPCB00534','ECPBPCB01058','ECPBPCB01063','ECPBPCB00908',
                                                           'ECPBPCB01070','ECPBPCB01072','ECPBPCB01111','ECPBPCB00864',
                                                           'ECPBPCB01231','ECPBPCB00906','ECPBPCB01145','ECPBPCB01146',
                                                           'ECPBPCB00933','ECPBPCB00935','ECPBPCB00937','ECPBPCB01073',
                                                           'ECPCBDS00878','ECPCBDS01137','ECPBPCB01000','ECPBPCB01270',
                                                           'ECPBPCB00582','ECPBPCB00889','ECPBPCB01306','ECPBPCB01258',
                                                           'ECPCBDS01123','ECPBPCB01344','ECPBPCB01343','ECPCBDS01230',
                                                           'ECPCBDS01228','ECPCBDS01229','ECPCBDS01243','ECPCBDS01257',
                                                           'ECPCBDS01256','ECPCBDS01258','ECPCBSS00447','ECPBPCB01351',
                                                           'ECPBPCB01348','ECPBPCB01347','ECPBPCB01300','ECPBPCB01381',
                                                           'ECPBPCB01109','ECPBPCB01436','ECPBPCB01437','ECPBPCB01461'{,
                                                           'ECPCBSS00497','ECPCBDS01390','ECPCBSS00499','ECPCBSS00496',
                                                           'ECPCBSS00480'},'ECPBPCB01486','ECPBPCB01487','ECPBPCB01528',
                                                           'ECPBPCB01529','ECPBPCB01193','ECPBPCB01591','ECPBPCB00172',
                                                           'ECPBPCB00173','ECPBPCB00015','ECPBPCB00016','ECPBPCB00029',
                                                           'ECPBPCB01289','ECPBPCB00418','ECPBPCB00481',{'ECPBPCB00873',}
                                                           'ECPBPCB00869','ECPBPCB01026','ECPBPCB00400','ECPBPCB00890',
                                                           'ECPBPCB00487','ECPBPCB00559','ECPBPCB00802','ECPBPCB00813',
                                                           'ECPBPCB00938','ECPBPCB00971','ECPBPCB01016','ECPBPCB01075',
                                                           'ECPBPCB01311','ECPBPCB01077','ECPBPCB01076','ECPBPCB01078',
                                                           'ECPBPCB01092','ECPBPCB01224','ECPBPCB01205','ECPBPCB01155',
                                                           'ECPBPCB01185','ECPBPCB01228','ECPBPCB01225','ECPBPCB01226',
                                                           'ECPBPCB01227','ECPBPCB01230','ECPBPCB01263','ECPBPCB01257',
                                                           'ECPBPCB01385','ECPBPCB01384','ECPBPCB01373',{'ECPBPCB01396',}
                                                           {'ECPBPCB01398',}'ECPBPCB01394','ECPBPCB01443','ECPBPCB01442',
                                                           'ECPBPCB01516','ECPBPCB01269','ECPBPCB01282','ECPBPCB01399',
                                                           'ECPBPCB01452','ECPBPCB01455','ECPBPCB01451','ECPBPCB01567',
                                                           'ECPBPCB01566','ECPBPCB01345','ECPBPCB01571','ECPBPCB01545',
                                                           'ECPBPCB01205','ECPBPCB01439','ECPBPCB00400','ECPBPCB01544',
                                                           'ECPBPCB01476','ECPBPCB01469','ECPBPCB01472','ECPBPCB01481',
                                                           'ECPBPCB01260','ECPBPCB01312','ECPBPCB01525','ECPBPCB01533',
                                                           'ECPBPCB01532','ECPBPCB01572','ECPBPCB01573','ECPBPCB01508',
                                                           'ECPBPCB01321','ECPBPCB01488','ECPBPCB01468','ECPBPCB01596',
                                                           'ECPBPCB01572','ECPBPCB01573','ECPBPCB01508','ECPBPCB01321',
                                                           'ECPBPCB01600','ECPBPCB01602','ECPBPCB01603','ECPBPCB01617',
                                                           'ECPBPCB01644','ECPBPCB01650','ECPBPCB01649'] THEN
                             */
                            BEGIN
                                ProdOrderComp.RESET;
                                ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                                ProdOrderComp.SETRANGE("Prod. Order No.", "PROD. Order");
                                ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                                ProdOrderComp.SETFILTER(ProdOrderComp."Type of Solder2", '<>%1', 'SMD');
                                ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
                                IF BI THEN BEGIN
                                    IF ProdOrderLine."Line No." IN [20000, 30000, 40000, 80000] THEN
                                        ProdOrderComp.SETFILTER(ProdOrderComp."BOM Type", '<>%1&<>%2', ProdOrderComp."BOM Type"::Mechanical,
                                                                                                     ProdOrderComp."BOM Type"::Wiring);
                                END;
                                IF ProdOrderComp.FINDSET THEN
                                    REPEAT
                                        ITEM.GET(ProdOrderComp."Item No.");
                                        IF (NOT ITEM."Dispatch Material") AND (ITEM."Product Group Code Cust" <> 'CPCB') AND (ITEM."Product Group Code Cust" <> 'FPRODUCT')
                                            AND (ITEM."Product Group Code Cust" <> 'PCB') THEN BEGIN
                                            DUM.RESET;

                                            IF NOT (DUM.GET(ProdOrderComp."Item No.")) THEN
                                                Include_Item(ProdOrderComp."Item No.", TRUE);

                                            IF DUM.GET(ProdOrderComp."Item No.") THEN BEGIN           //Lot wise item availability  //mnraju  06-JUN-2014
                                                IF DUM."Product Group Code Cust" = 'LED' THEN BEGIN

                                                    "PO-LINE".RESET;
                                                    "PO-LINE".SETFILTER("PO-LINE"."Prod. Order No.", "PROD. Order");
                                                    "PO-LINE".SETFILTER("PO-LINE"."Line No.", '%1', ProdOrderComp."Prod. Order Line No.");
                                                    IF "PO-LINE".FINDFIRST THEN BEGIN
                                                        loopVar := 0;
                                                        REPEAT
                                                            loopVar := loopVar + 1;
                                                            LotItemAvail.RESET;
                                                            LotItemAvail.SETCURRENTKEY(LotItemAvail."Item No", LotItemAvail."LOT No", LotItemAvail.Location);
                                                            LotItemAvail.SETRANGE(LotItemAvail."Item No", ProdOrderComp."Item No.");
                                                            LotItemAvail.SETRANGE(LotItemAvail.Location, 'STR');
                                                            SHORT := TRUE;
                                                            IF LotItemAvail.FINDSET THEN
                                                                REPEAT
                                                                    IF ((LotItemAvail."Total Qty" - LotItemAvail."Allocated Qty") >= ProdOrderComp."Quantity per") THEN BEGIN
                                                                        LotItemAvail."Allocated Qty" := LotItemAvail."Allocated Qty" + ProdOrderComp."Quantity per";
                                                                        LotItemAvail.MODIFY;
                                                                        SHORT := FALSE;
                                                                    END
                                                                UNTIL (LotItemAvail.NEXT = 0) OR (SHORT = FALSE);
                                                        UNTIL ((loopVar = "PO-LINE".Quantity) OR (SHORT = TRUE));
                                                        IF SHORT THEN BEGIN
                                                            DUM."Maximum Inventory" := -("PO-LINE".Quantity - (loopVar - 1)) * ProdOrderComp."Quantity per";
                                                            //DUM."Maximum Inventory"-=(loopVar-1)*ProdOrderComp."Quantity per";
                                                            DUM."Total Inventory" += (ProdOrderComp."Expected Quantity");
                                                            DUM.MODIFY;
                                                        END;
                                                    END;
                                                END
                                                ELSE BEGIN
                                                    DUM."Maximum Inventory" -= (ProdOrderComp."Expected Quantity");
                                                    DUM."Total Inventory" += (ProdOrderComp."Expected Quantity");
                                                    DUM.MODIFY;
                                                END;
                                            END;
                                            //end Lot wise item availability  //mnraju  06-JUN-2014
                                        END;
                                    UNTIL ProdOrderComp.NEXT = 0;

                                // FOR SMD ITEMS

                                ProdOrderComp.RESET;
                                ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                                ProdOrderComp.SETRANGE("Prod. Order No.", "PROD. Order");
                                ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                                ProdOrderComp.SETFILTER(ProdOrderComp."Type of Solder2", 'SMD');
                                ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
                                IF BI THEN BEGIN
                                    IF ProdOrderLine."Line No." IN [20000, 30000, 40000, 80000] THEN
                                        ProdOrderComp.SETFILTER(ProdOrderComp."BOM Type", '<>%1&<>%2', ProdOrderComp."BOM Type"::Mechanical,
                                                                                                     ProdOrderComp."BOM Type"::Wiring);
                                END;
                                IF ProdOrderComp.FINDSET THEN
                                    REPEAT
                                        ITEM.GET(ProdOrderComp."Item No.");
                                        IF (NOT ITEM."Dispatch Material") AND (ITEM."Product Group Code Cust" <> 'CPCB') AND (ITEM."Product Group Code Cust" <> 'FPRODUCT')
                                            AND (ITEM."Product Group Code Cust" <> 'PCB') THEN BEGIN

                                            DUM.RESET;
                                            IF NOT (DUM.GET(ProdOrderComp."Item No.")) THEN
                                                Include_Item(ProdOrderComp."Item No.", TRUE);

                                            IF DUM.GET(ProdOrderComp."Item No.") THEN BEGIN           //Lot wise item availability  //mnraju  06-JUN-2014
                                                IF DUM."Product Group Code Cust" = 'LED' THEN BEGIN

                                                    "PO-LINE".RESET;
                                                    "PO-LINE".SETFILTER("PO-LINE"."Prod. Order No.", "PROD. Order");
                                                    "PO-LINE".SETFILTER("PO-LINE"."Line No.", '%1', ProdOrderComp."Prod. Order Line No.");
                                                    IF "PO-LINE".FINDFIRST THEN BEGIN
                                                        loopVar := 0;
                                                        REPEAT
                                                            loopVar := loopVar + 1;
                                                            LotItemAvail.RESET;
                                                            LotItemAvail.SETCURRENTKEY(LotItemAvail."Item No", LotItemAvail."LOT No", LotItemAvail.Location);
                                                            LotItemAvail.SETRANGE(LotItemAvail."Item No", ProdOrderComp."Item No.");
                                                            LotItemAvail.SETRANGE(LotItemAvail.Location, 'MCH');
                                                            SHORT := TRUE;
                                                            IF LotItemAvail.FINDSET THEN
                                                                REPEAT
                                                                    IF ((LotItemAvail."Total Qty" - LotItemAvail."Allocated Qty") >= ProdOrderComp."Quantity per") THEN BEGIN
                                                                        LotItemAvail."Allocated Qty" := LotItemAvail."Allocated Qty" + ProdOrderComp."Quantity per";
                                                                        LotItemAvail.MODIFY;
                                                                        SHORT := FALSE;
                                                                    END
                                                                UNTIL (LotItemAvail.NEXT = 0) OR (SHORT = FALSE);
                                                        UNTIL ((loopVar = "PO-LINE".Quantity) OR (SHORT = TRUE));
                                                        IF SHORT THEN BEGIN
                                                            //  DUM."Maximum Inventory":=-("PO-LINE".Quantity-(loopVar-1))*ProdOrderComp."Quantity per";
                                                            DUM."Total Inventory" += (ProdOrderComp."Expected Quantity");
                                                            DUM.MODIFY;
                                                        END;
                                                    END;
                                                END
                                                ELSE BEGIN
                                                    // DUM."Maximum Inventory"-= (ProdOrderComp."Expected Quantity");
                                                    DUM."Total Inventory" += (ProdOrderComp."Expected Quantity");
                                                    DUM.MODIFY;
                                                END;
                                            END;
                                            //end Lot wise item availability  //mnraju  06-JUN-2014
                                        END;
                                    UNTIL ProdOrderComp.NEXT = 0;

                            END
                            ELSE BEGIN
                                ProdOrderComp.RESET;
                                ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                                ProdOrderComp.SETRANGE("Prod. Order No.", "PROD. Order");
                                ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                                ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
                                IF BI THEN BEGIN
                                    IF ProdOrderLine."Line No." IN [20000, 30000, 40000, 80000] THEN
                                        ProdOrderComp.SETFILTER(ProdOrderComp."BOM Type", '<>%1&<>%2', ProdOrderComp."BOM Type"::Mechanical,
                                                                                                     ProdOrderComp."BOM Type"::Wiring);
                                END;

                                IF ProdOrderComp.FINDSET THEN
                                    REPEAT
                                        ITEM.GET(ProdOrderComp."Item No.");
                                        IF (NOT ITEM."Dispatch Material") AND (ITEM."Product Group Code Cust" <> 'CPCB') AND (ITEM."Product Group Code Cust" <> 'FPRODUCT')
                                            AND (ITEM."Product Group Code Cust" <> 'PCB') THEN BEGIN

                                            DUM.RESET;
                                            IF NOT (DUM.GET(ProdOrderComp."Item No.")) THEN
                                                Include_Item(ProdOrderComp."Item No.", TRUE);

                                            IF DUM.GET(ProdOrderComp."Item No.") THEN BEGIN
                                                IF DUM."Product Group Code Cust" = 'LED' THEN BEGIN

                                                    "PO-LINE".RESET;
                                                    "PO-LINE".SETFILTER("PO-LINE"."Prod. Order No.", "PROD. Order");
                                                    "PO-LINE".SETFILTER("PO-LINE"."Line No.", '%1', ProdOrderComp."Prod. Order Line No.");
                                                    IF "PO-LINE".FINDFIRST THEN BEGIN
                                                        loopVar := 0;
                                                        REPEAT
                                                            loopVar := loopVar + 1;
                                                            LotItemAvail.RESET;
                                                            LotItemAvail.SETCURRENTKEY(LotItemAvail."Item No", LotItemAvail."LOT No", LotItemAvail.Location);
                                                            LotItemAvail.SETRANGE(LotItemAvail."Item No", ProdOrderComp."Item No.");
                                                            LotItemAvail.SETRANGE(LotItemAvail.Location, 'STR');
                                                            SHORT := TRUE;
                                                            IF LotItemAvail.FINDSET THEN
                                                                REPEAT
                                                                    IF ((LotItemAvail."Total Qty" - LotItemAvail."Allocated Qty") >= ProdOrderComp."Quantity per") THEN BEGIN
                                                                        LotItemAvail."Allocated Qty" := LotItemAvail."Allocated Qty" + ProdOrderComp."Quantity per";
                                                                        LotItemAvail.MODIFY;
                                                                        SHORT := FALSE;
                                                                    END
                                                                UNTIL (LotItemAvail.NEXT = 0) OR (SHORT = FALSE);
                                                        UNTIL ((loopVar = "PO-LINE".Quantity) OR (SHORT = TRUE));
                                                        IF SHORT THEN BEGIN
                                                            DUM."Maximum Inventory" := -("PO-LINE".Quantity - (loopVar - 1)) * ProdOrderComp."Quantity per";
                                                            DUM."Total Inventory" += (ProdOrderComp."Expected Quantity");
                                                            DUM.MODIFY;
                                                        END;
                                                    END;
                                                END
                                                ELSE BEGIN
                                                    DUM."Maximum Inventory" -= (ProdOrderComp."Expected Quantity");
                                                    DUM."Total Inventory" += (ProdOrderComp."Expected Quantity");
                                                    DUM.MODIFY;
                                                END;
                                            END;
                                            //end Lot wise item availability  //mnraju  06-JUN-2014
                                        END;
                                    UNTIL ProdOrderComp.NEXT = 0;

                            END;
                        END
                        ELSE BEGIN
                            ProdOrderComp.RESET;
                            ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                            ProdOrderComp.SETRANGE("Prod. Order No.", "PROD. Order");
                            ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                            ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
                            IF BI THEN BEGIN
                                IF ProdOrderLine."Line No." IN [20000, 30000, 40000, 80000] THEN
                                    ProdOrderComp.SETFILTER(ProdOrderComp."BOM Type", '<>%1&<>%2', ProdOrderComp."BOM Type"::Mechanical,
                                                                                                 ProdOrderComp."BOM Type"::Wiring);
                            END;

                            IF ProdOrderComp.FINDSET THEN
                                REPEAT
                                    ITEM.GET(ProdOrderComp."Item No.");
                                    IF (NOT ITEM."Dispatch Material") AND (ITEM."Product Group Code Cust" <> 'CPCB') AND (ITEM."Product Group Code Cust" <> 'FPRODUCT')
                                        AND (ITEM."Product Group Code Cust" <> 'PCB') THEN BEGIN
                                        DUM.RESET;
                                        IF NOT (DUM.GET(ProdOrderComp."Item No.")) THEN
                                            Include_Item(ProdOrderComp."Item No.", TRUE);

                                        IF DUM.GET(ProdOrderComp."Item No.") THEN BEGIN
                                            IF DUM."Product Group Code Cust" = 'LED' THEN BEGIN

                                                "PO-LINE".RESET;
                                                "PO-LINE".SETFILTER("PO-LINE"."Prod. Order No.", "PROD. Order");
                                                "PO-LINE".SETFILTER("PO-LINE"."Line No.", '%1', ProdOrderComp."Prod. Order Line No.");
                                                IF "PO-LINE".FINDFIRST THEN BEGIN
                                                    loopVar := 0;
                                                    REPEAT
                                                        loopVar := loopVar + 1;
                                                        LotItemAvail.RESET;
                                                        LotItemAvail.SETCURRENTKEY(LotItemAvail."Item No", LotItemAvail."LOT No", LotItemAvail.Location);
                                                        LotItemAvail.SETRANGE(LotItemAvail."Item No", ProdOrderComp."Item No.");
                                                        LotItemAvail.SETRANGE(LotItemAvail.Location, 'STR');
                                                        SHORT := TRUE;
                                                        IF LotItemAvail.FINDSET THEN
                                                            REPEAT
                                                                IF ((LotItemAvail."Total Qty" - LotItemAvail."Allocated Qty") >= ProdOrderComp."Quantity per") THEN BEGIN
                                                                    LotItemAvail."Allocated Qty" := LotItemAvail."Allocated Qty" + ProdOrderComp."Quantity per";
                                                                    LotItemAvail.MODIFY;
                                                                    SHORT := FALSE;
                                                                END
                                                            UNTIL (LotItemAvail.NEXT = 0) OR (SHORT = FALSE);
                                                    UNTIL ((loopVar = "PO-LINE".Quantity) OR (SHORT = TRUE));
                                                    IF SHORT THEN BEGIN
                                                        DUM."Maximum Inventory" := -("PO-LINE".Quantity - (loopVar - 1)) * ProdOrderComp."Quantity per";
                                                        DUM."Total Inventory" += (ProdOrderComp."Expected Quantity");
                                                        DUM.MODIFY;
                                                    END;
                                                END;
                                            END
                                            ELSE BEGIN
                                                DUM."Maximum Inventory" -= (ProdOrderComp."Expected Quantity");
                                                DUM."Total Inventory" += (ProdOrderComp."Expected Quantity");
                                                DUM.MODIFY;
                                            END;
                                        END;
                                        //end Lot wise item availability  //mnraju  06-JUN-2014
                                    END;
                                UNTIL ProdOrderComp.NEXT = 0;
                        END;
                    END;

                    /* IF ProdOrderLine."Line No."=10000 THEN
                     BEGIN
                       FOR i:=1 TO ProdOrderLine.Quantity DO
                       BEGIN
                         ProdOrderComp.RESET;
                         ProdOrderComp.SETRANGE(Status,ProdOrderComp.Status :: Released);
                         ProdOrderComp.SETRANGE("Prod. Order No.", "PROD. Order");
                         ProdOrderComp.SETRANGE("Prod. Order Line No.",ProdOrderLine."Line No.");
                         ProdOrderComp.SETFILTER("Remaining Quantity",'<>0');
                         IF ProdOrderComp.FINDSET THEN
                         REPEAT
                           ITEM.GET(ProdOrderComp."Item No.");
                           IF  (NOT ITEM."Dispatch Material") AND (ITEM."Product Group Code"<>'CPCB') AND (ITEM."Product Group Code"<>'FPRODUCT')THEN
                           BEGIN
                             DUM.RESET;
                             IF NOT( DUM.GET(ProdOrderComp."Item No.") ) THEN
                               Include_Item(ProdOrderComp."Item No.",TRUE);

                             IF  DUM.GET(ProdOrderComp."Item No.") THEN
                             BEGIN
                               DUM."Maximum Inventory"-=ProdOrderComp.Quantity;
                               DUM.MODIFY;
                             END;
                           END;
                         UNTIL ProdOrderComp.NEXT = 0;
                       END;
                       FOR i:=1 TO ProdOrderLine.Quantity DO
                       BEGIN
                         IF ProdOrderLine."Item No." IN ['RLYMNGL001','RLYMNRL001','RLYMNYL001','RLYSHT001','RLYRTS001','RLYCLU001'] THEN
                         BEGIN
                           ProdOrderComp.RESET;
                           ProdOrderComp.SETRANGE(Status,ProdOrderComp.Status :: Released);
                           ProdOrderComp.SETRANGE("Prod. Order No.","PROD. Order");
                           ProdOrderComp.SETRANGE("Prod. Order Line No.",ProdOrderLine."Line No.");
                           ProdOrderComp.SETFILTER("Remaining Quantity",'<>0');
                           IF ProdOrderComp.FINDSET THEN
                           BEGIN
                             REPEAT
                               ITEM.GET(ProdOrderComp."Item No.");
                               IF ITEM."Product Group Code"='PCB' THEN
                               BEGIN
                                 DUM.RESET;
                                 IF NOT( DUM.GET(ProdOrderComp."Item No.") ) THEN
                                   Include_Item(ProdOrderComp."Item No.",TRUE);

                                 IF  DUM.GET(ProdOrderComp."Item No.") THEN
                                 BEGIN
                                   DUM."Maximum Inventory"-= ProdOrderComp.Quantity;
                                   DUM."Total Inventory"+=( ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity);
                                   DUM.MODIFY;
                                 END;
                               END;
                             UNTIL ProdOrderComp.NEXT = 0;
                           END;
                         END;
                       END;
                     END;*/
                END;
            UNTIL ProdOrderLine.NEXT = 0;

    end;


    procedure Include_Item(item1: Code[20]; Verify: Boolean)
    var
        STOCK: Decimal;
        ItemLedgEntry: Record "Item Ledger Entry";
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
        "MAT. ISSUES TRACKING SPEC": Record "Mat.Issue Track. Specification";
    begin
        ITEM.RESET;
        IF ITEM.GET(item1) THEN BEGIN
            IF (ITEM."Product Group Code Cust" <> 'CPCB') AND (ITEM."Product Group Code Cust" <> 'FPRODUCT') AND (NOT ITEM."Dispatch Material") THEN BEGIN
                ITEM.CALCFIELDS(ITEM."Inventory at Stores", ITEM."Qty. on Purch. Order",
                                ITEM."Quantity Under Inspection", ITEM."Stock At MCH Location");
                DUM.INIT;
                DUM."No." := ITEM."No.";
                DUM.Description := ITEM.Description;
                DUM."Standard Cost" := ITEM."Qty. on Purch. Order";
                DUM."Unit Cost" := ITEM."Quantity Under Inspection";
                STOCK := 0;
                ITEM.CALCFIELDS(ITEM."Quantity Under Inspection", ITEM."Quantity Rejected", ITEM."Quantity Rework",
                ITEM."Quantity Sent for Rework", ITEM."Inventory at Stores");
                IF ITEM."QC Enabled" = TRUE THEN BEGIN
                    IF (ITEM."Quantity Under Inspection" = 0) AND (ITEM."Quantity Rejected" = 0) AND
                       (ITEM."Quantity Rework" = 0) AND (ITEM."Quantity Sent for Rework" = 0) THEN BEGIN
                        ItemLedgEntry.RESET;
                        ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                        "Expiration Date", "Lot No.", "Serial No.");
                        ItemLedgEntry.SETRANGE("Item No.", ITEM."No.");
                        ItemLedgEntry.SETRANGE(Open, TRUE);
                        ItemLedgEntry.SETFILTER("Location Code", 'STR|MCH');
                        IF ItemLedgEntry.FIND('-') THEN
                            REPEAT
                                IF ItemLedgEntry."Location Code" = 'STR' THEN
                                    STOCK += ItemLedgEntry."Remaining Quantity";
                                //Lot wise item availability  //mnraju  06-JUN-2014
                                IF ITEM."Product Group Code Cust" = 'LED' THEN BEGIN
                                    LotItemAvail.RESET;
                                    LotItemAvail.SETRANGE(LotItemAvail."Item No", ItemLedgEntry."Item No.");
                                    LotItemAvail.SETRANGE(LotItemAvail."LOT No", ItemLedgEntry."Lot No.");
                                    LotItemAvail.SETRANGE(LotItemAvail.Location, ItemLedgEntry."Location Code");
                                    IF LotItemAvail.FINDFIRST THEN BEGIN
                                        LotItemAvail."Total Qty" := LotItemAvail."Total Qty" + ItemLedgEntry."Remaining Quantity";
                                        LotItemAvail.MODIFY;
                                    END
                                    ELSE BEGIN
                                        LotItemAvail.INIT;
                                        LotItemAvail."Item No" := ItemLedgEntry."Item No.";
                                        LotItemAvail."LOT No" := ItemLedgEntry."Lot No.";
                                        LotItemAvail."Total Qty" := ItemLedgEntry."Remaining Quantity";
                                        LotItemAvail."Allocated Qty" := 0;
                                        LotItemAvail.Location := ItemLedgEntry."Location Code";
                                        LotItemAvail.INSERT;
                                    END;
                                END;
                            //END Lot wise item availability  //mnraju  06-JUN-2014

                            UNTIL ItemLedgEntry.NEXT = 0;
                    END ELSE BEGIN
                        STOCK := 0;
                        ItemLedgEntry.RESET;
                        ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                                                    "Expiration Date", "Lot No.", "Serial No.");
                        ItemLedgEntry.SETRANGE("Item No.", ITEM."No.");
                        ItemLedgEntry.SETRANGE(Open, TRUE);
                        ItemLedgEntry.SETFILTER("Location Code", 'STR|MCH');
                        IF ItemLedgEntry.FIND('-') THEN
                            REPEAT
                                ItemLedgEntry.MARK(TRUE);
                                IF (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") AND (QualityItemLedgEntry."Inspection Status" =
                                    QualityItemLedgEntry."Inspection Status"::"Under Inspection")) OR
                                    (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.")
                                    AND (QualityItemLedgEntry."Inspection Status" = QualityItemLedgEntry."Inspection Status"::Rejected)) THEN
                                    ItemLedgEntry.MARK(FALSE);

                            UNTIL ItemLedgEntry.NEXT = 0;
                    END;
                END;
                ItemLedgEntry.MARKEDONLY(TRUE);
                IF ItemLedgEntry.FIND('-') THEN
                    REPEAT
                        IF ItemLedgEntry."Location Code" = 'STR' THEN
                            STOCK := STOCK + ItemLedgEntry."Remaining Quantity";
                        //Lot wise item availability  //mnraju  06-JUN-2014
                        IF ITEM."Product Group Code Cust" = 'LED' THEN BEGIN
                            LotItemAvail.RESET;
                            LotItemAvail.SETRANGE(LotItemAvail."Item No", ItemLedgEntry."Item No.");
                            LotItemAvail.SETRANGE(LotItemAvail."LOT No", ItemLedgEntry."Lot No.");
                            LotItemAvail.SETRANGE(LotItemAvail.Location, ItemLedgEntry."Location Code");

                            IF LotItemAvail.FINDFIRST THEN BEGIN
                                LotItemAvail."Total Qty" := LotItemAvail."Total Qty" + ItemLedgEntry."Remaining Quantity";
                                LotItemAvail.MODIFY;
                            END
                            ELSE BEGIN
                                LotItemAvail.INIT;
                                LotItemAvail."Item No" := ItemLedgEntry."Item No.";
                                LotItemAvail."LOT No" := ItemLedgEntry."Lot No.";
                                LotItemAvail."Total Qty" := ItemLedgEntry."Remaining Quantity";
                                LotItemAvail."Allocated Qty" := 0;
                                LotItemAvail.Location := ItemLedgEntry."Location Code";
                                LotItemAvail.INSERT;
                            END;
                        END;
                    //END Lot wise item availability  //mnraju  06-JUN-2014

                    UNTIL ItemLedgEntry.NEXT = 0;
                "MAT. ISSUES TRACKING SPEC".RESET;
                "MAT. ISSUES TRACKING SPEC".SETRANGE("MAT. ISSUES TRACKING SPEC"."Item No.", DUM."No.");
                "MAT. ISSUES TRACKING SPEC".SETFILTER("MAT. ISSUES TRACKING SPEC"."Location Code", 'STR|MCH');
                "MAT. ISSUES TRACKING SPEC".SETFILTER("MAT. ISSUES TRACKING SPEC".Quantity, '>%1', 0);
                IF "MAT. ISSUES TRACKING SPEC".FIND('-') THEN
                    REPEAT
                        IF STOCK > "MAT. ISSUES TRACKING SPEC".Quantity THEN BEGIN
                            IF "MAT. ISSUES TRACKING SPEC"."Location Code" = 'STR' THEN
                                STOCK := STOCK - "MAT. ISSUES TRACKING SPEC".Quantity;
                            // Lot wise item availability  //mnraju  06-JUN-2014
                            LotItemAvail.RESET;
                            LotItemAvail.SETRANGE(LotItemAvail."Item No", "MAT. ISSUES TRACKING SPEC"."Item No.");
                            LotItemAvail.SETRANGE(LotItemAvail."LOT No", "MAT. ISSUES TRACKING SPEC"."Lot No.");
                            LotItemAvail.SETRANGE(LotItemAvail.Location, "MAT. ISSUES TRACKING SPEC"."Location Code");
                            IF LotItemAvail.FINDFIRST THEN BEGIN
                                LotItemAvail."Total Qty" := LotItemAvail."Total Qty" - "MAT. ISSUES TRACKING SPEC".Quantity;
                                LotItemAvail.MODIFY;
                            END  // Lot wise item availability  //mnraju  06-JUN-2014


                        END;
                    UNTIL "MAT. ISSUES TRACKING SPEC".NEXT = 0;
                ITEM.CALCFIELDS(ITEM."Stock at PROD Stores");

                //DUM."Maximum Inventory":=ITEM."Stock at PROD Stores";
                DUM."Maximum Inventory" := STOCK;
                DUM."Base Unit of Measure" := ITEM."Base Unit of Measure";
                DUM."Stock at Stores" := STOCK;
                DUM."Safety Stock Qty (CS)" := ITEM."Stock At MCH Location";
                DUM."Product Group Code Cust" := ITEM."Product Group Code Cust";
                DUM."Safety Lead Time" := ITEM."Safety Lead Time";

                DUM.INSERT;
            END;
        END;
    end;


    procedure GetNextNo() NumberValue: Code[20]
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

        IF DATE2DMY(WORKDATE, 2) <= 12 THEN
            YearValue := COPYSTR(FORMAT(DATE2DMY(WORKDATE, 3)), 3, 2);
        //IF ((TODAY=010810D) OR (TODAY=010910D) OR (TODAY=011010D))THEN
        //  NumberValue := 'V'+YearValue+MonthValue+DateValue
        //ELSE
        NumberValue := 'R' + YearValue + MonthValue + DateValue;

        LastNumber := NumberValue + '0000';
        MaterialIssuesHeaderLocal.RESET;
        MaterialIssuesHeaderLocal.SETFILTER("No.", NumberValue + '*');
        IF MaterialIssuesHeaderLocal.FINDLAST THEN
            LastNumber := MaterialIssuesHeaderLocal."No.";

        PostedMatIssHeaderLocal.RESET;
        PostedMatIssHeaderLocal.SETCURRENTKEY("Material Issue No.");
        PostedMatIssHeaderLocal.SETFILTER("Material Issue No.", NumberValue + '*');
        IF PostedMatIssHeaderLocal.FINDLAST THEN
            IF LastNumber < PostedMatIssHeaderLocal."Material Issue No." THEN
                LastNumber := PostedMatIssHeaderLocal."Material Issue No.";

        NumberValue := INCSTR(LastNumber);
    end;


    procedure Include_Item1(item1: Code[20]; Verify: Boolean)
    var
        STOCK: Decimal;
        ItemLedgEntry: Record "Item Ledger Entry";
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
        "MAT. ISSUES TRACKING SPEC": Record "Mat.Issue Track. Specification";
    begin
        ITEM.RESET;
        IF ITEM.GET(item1) THEN BEGIN
            IF (ITEM."Product Group Code Cust" <> 'CPCB') AND (ITEM."Product Group Code Cust" <> 'FPRODUCT') AND (NOT ITEM."Dispatch Material") THEN BEGIN
                /*ITEM.CALCFIELDS(ITEM."Inventory at Stores",ITEM."Qty. on Purch. Order",
                                ITEM."Quantity Under Inspection",ITEM."Stock At MCH Location");*/
                DUM.INIT;
                DUM."No." := ITEM."No.";
                DUM.Description := ITEM.Description;
                /* DUM."Standard Cost":=ITEM."Qty. on Purch. Order";
                 DUM."Unit Cost":=ITEM."Quantity Under Inspection";
                 STOCK:=0;
                 ITEM.CALCFIELDS(ITEM."Quantity Under Inspection",ITEM."Quantity Rejected",ITEM."Quantity Rework",
                 ITEM."Quantity Sent for Rework",ITEM."Inventory at Stores");
                 IF ITEM."QC Enabled" = TRUE THEN
                 BEGIN
                   IF (ITEM."Quantity Under Inspection"=0)AND (ITEM."Quantity Rejected"=0) AND
                      (ITEM."Quantity Rework"=0) AND (ITEM."Quantity Sent for Rework"=0) THEN
                   BEGIN
                     ItemLedgEntry.RESET;
                     ItemLedgEntry.SETCURRENTKEY("Item No.","Variant Code",Open,Positive,"Location Code","Posting Date",
                     "Expiration Date","Lot No.","Serial No.");
                     ItemLedgEntry.SETRANGE("Item No.",ITEM."No.");
                     ItemLedgEntry.SETRANGE(Open,TRUE);
                     ItemLedgEntry.SETRANGE("Location Code",'STR');
                     IF ItemLedgEntry.FIND('-') THEN
                     REPEAT
                       STOCK+=ItemLedgEntry."Remaining Quantity";
                     UNTIL ItemLedgEntry.NEXT=0;
                   END ELSE
                     BEGIN
                       STOCK:=0 ;
                       ItemLedgEntry.RESET;
                       ItemLedgEntry.SETCURRENTKEY("Item No.","Variant Code",Open,Positive,"Location Code","Posting Date",
                                                   "Expiration Date","Lot No.","Serial No.");
                       ItemLedgEntry.SETRANGE("Item No.",ITEM."No.");
                       ItemLedgEntry.SETRANGE(Open,TRUE);
                       ItemLedgEntry.SETRANGE("Location Code",'STR');
                       IF ItemLedgEntry.FIND('-')THEN
                       REPEAT
                         ItemLedgEntry.MARK(TRUE);
                         IF (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") AND (QualityItemLedgEntry."Inspection Status"=
                             QualityItemLedgEntry."Inspection Status"::"Under Inspection")) OR
                             (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.")
                             AND (QualityItemLedgEntry."Inspection Status"=QualityItemLedgEntry."Inspection Status"::Rejected)) THEN
                          ItemLedgEntry.MARK(FALSE);

                       UNTIL ItemLedgEntry.NEXT=0;
                     END;
                   END;
                   ItemLedgEntry.MARKEDONLY(TRUE);
                   IF ItemLedgEntry.FIND('-')THEN
                   REPEAT
                     STOCK:=STOCK+ItemLedgEntry."Remaining Quantity";
                   UNTIL ItemLedgEntry.NEXT=0;
                 "MAT. ISSUES TRACKING SPEC".RESET;
                 "MAT. ISSUES TRACKING SPEC".SETRANGE("MAT. ISSUES TRACKING SPEC"."Item No.",DUM."No.");
                 "MAT. ISSUES TRACKING SPEC".SETRANGE("MAT. ISSUES TRACKING SPEC"."Location Code",'STR');
                 "MAT. ISSUES TRACKING SPEC".SETFILTER("MAT. ISSUES TRACKING SPEC".Quantity,'>%1',0);
                 IF "MAT. ISSUES TRACKING SPEC".FIND('-') THEN
                 REPEAT
                   IF STOCK>"MAT. ISSUES TRACKING SPEC".Quantity THEN
                   STOCK:=STOCK-"MAT. ISSUES TRACKING SPEC".Quantity;
                 UNTIL "MAT. ISSUES TRACKING SPEC".NEXT=0;  */
                ITEM.CALCFIELDS(ITEM."Stock at PROD Stores");

                DUM."Maximum Inventory" := ITEM."Stock at PROD Stores";
                DUM."Base Unit of Measure" := ITEM."Base Unit of Measure";
                /* DUM."Stock at Stores":=STOCK;
                 DUM."Safety Stock Qty (CS)":=ITEM."Stock At MCH Location";*/
                DUM."Product Group Code Cust" := ITEM."Product Group Code Cust";
                DUM."Safety Lead Time" := ITEM."Safety Lead Time";

                DUM.INSERT;
            END;
        END;

    end;


    procedure CALC_REQ_QTY2("PROD. Order": Code[20])
    var
        LineNo: Integer;
        ProdOrderComp: Record "Prod. Order Component";
        MaterialIssueHeader: Record "Material Issues Header";
        MaterialIssueLine: Record "Material Issues Line";
        PostedMaterialIssueHeader: Record "Posted Material Issues Header";
        Text0003: Label 'Material Issue already existed against this Prod. Order %1';
        ProdOrderLine: Record "Prod. Order Line";
        i: Integer;
        Prod_Order: Record "Production Order";
    begin
        MaterialIssueHeader.SETRANGE("Prod. Order No.", "PROD. Order");
        IF MaterialIssueHeader.FINDFIRST THEN
            ERROR(Text0003, "PROD. Order");
        PostedMaterialIssueHeader.SETRANGE("Prod. Order No.", "PROD. Order");
        IF PostedMaterialIssueHeader.FINDFIRST THEN
            ERROR(Text0003, "PROD. Order");

        ProdOrderLine.RESET;

        ProdOrderLine.SETRANGE("Prod. Order No.", "PROD. Order");
        IF ProdOrderLine.FINDSET THEN
            REPEAT
                Item2.RESET;
                Item2.SETFILTER(Item2."No.", ProdOrderLine."Item No.");
                IF Item2.FINDFIRST THEN BEGIN
                    IF (ProdOrderLine."Line No." <> 10000) OR ((ProdOrderLine."Line No." = 10000) AND (Item2."Product Group Code Cust" <> 'FPRODUCT')) THEN BEGIN
                        ProdOrderComp.RESET;
                        ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                        ProdOrderComp.SETRANGE("Prod. Order No.", "PROD. Order");
                        ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                        IF ProdOrderLine."Item No." IN ['ECPBPCB00431', 'ECPBPCB00434', 'ECPBPCB00549', 'ECPBPCB00553',
                                                       'ECPBPCB00882', 'ECPBPCB00554', 'ECPBPCB00566', 'ECPBPCB00856',
                                                       'ECPBPCB00936', 'ECPBPCB00934', 'ECPBPCB01049', 'ECPBPCB01038',
                                                       'ECPBPCB00534', 'ECPBPCB01058', 'ECPBPCB01063', 'ECPBPCB00908',
                                                       'ECPBPCB01070', 'ECPBPCB01072', 'ECPBPCB01111', 'ECPBPCB00864',
                                                       'ECPBPCB01231', 'ECPBPCB00906', 'ECPBPCB01145', 'ECPBPCB01146',
                                                       'ECPBPCB00933', 'ECPBPCB00935', 'ECPBPCB00937', 'ECPBPCB01073',
                                                       'ECPCBDS00878', 'ECPCBDS01137', 'ECPBPCB01000', 'ECPBPCB01270',
                                                       'ECPBPCB00582', 'ECPBPCB00889', 'ECPBPCB01306', 'ECPBPCB01258',
                                                       'ECPCBDS01123', 'ECPBPCB01344', 'ECPBPCB01343', 'ECPCBDS01230',
                                                       'ECPCBDS01228', 'ECPCBDS01229', 'ECPCBDS01243', 'ECPCBDS01257',
                                                       'ECPCBDS01256', 'ECPCBDS01258', 'ECPCBSS00447', 'ECPBPCB01351',
                                                       'ECPBPCB01348', 'ECPBPCB01347', 'ECPBPCB01300', 'ECPBPCB01381',
                                                       'ECPBPCB01109', 'ECPBPCB01436', 'ECPBPCB01437', 'ECPBPCB01461'/*,
                                           'ECPCBSS00497','ECPCBDS01390','ECPCBSS00499','ECPCBSS00496',
                                           'ECPCBSS00480'*/, 'ECPBPCB01486', 'ECPBPCB01487', 'ECPBPCB01528',
                                                       'ECPBPCB01529', 'ECPBPCB01193', 'ECPBPCB01591', 'ECPBPCB00172',
                                                       'ECPBPCB00173', 'ECPBPCB00015', 'ECPBPCB00016', 'ECPBPCB00029',
                                                       'ECPBPCB01289', 'ECPBPCB00418', 'ECPBPCB00481',/*'ECPBPCB00873',*/
                                                       'ECPBPCB00869', 'ECPBPCB01026', 'ECPBPCB00400', 'ECPBPCB00890',
                                                       'ECPBPCB00487', 'ECPBPCB00559', 'ECPBPCB00802', 'ECPBPCB00813',
                                                       'ECPBPCB00938', 'ECPBPCB00971', 'ECPBPCB01016', 'ECPBPCB01075',
                                                       'ECPBPCB01311', 'ECPBPCB01077', 'ECPBPCB01076', 'ECPBPCB01078',
                                                       'ECPBPCB01092', 'ECPBPCB01224', 'ECPBPCB01205', 'ECPBPCB01155',
                                                       'ECPBPCB01185', 'ECPBPCB01228', 'ECPBPCB01225', 'ECPBPCB01226',
                                                       'ECPBPCB01227', 'ECPBPCB01230', 'ECPBPCB01263', 'ECPBPCB01257',
                                                       'ECPBPCB01385', 'ECPBPCB01384', 'ECPBPCB01373',/*'ECPBPCB01396',*/
                                                                                                      /*'ECPBPCB01398',*/'ECPBPCB01394', 'ECPBPCB01443', 'ECPBPCB01442',
                                                       'ECPBPCB01516', 'ECPBPCB01269', 'ECPBPCB01282', 'ECPBPCB01399',
                                                       'ECPBPCB01452', 'ECPBPCB01455', 'ECPBPCB01451', 'ECPBPCB01567',
                                                       'ECPBPCB01566', 'ECPBPCB01345', 'ECPBPCB01571', 'ECPBPCB01545',
                                                       'ECPBPCB01205', 'ECPBPCB01439', 'ECPBPCB00400', 'ECPBPCB01544',
                                                       'ECPBPCB01476', 'ECPBPCB01469', 'ECPBPCB01472', 'ECPBPCB01481',
                                                       'ECPBPCB01260', 'ECPBPCB01312', 'ECPBPCB01525', 'ECPBPCB01533',
                                                       'ECPBPCB01532', 'ECPBPCB01572', 'ECPBPCB01573', 'ECPBPCB01508',
                                                       'ECPBPCB01321', 'ECPBPCB01488', 'ECPBPCB01468', 'ECPBPCB01596',
                                                       'ECPBPCB01572', 'ECPBPCB01573', 'ECPBPCB01508', 'ECPBPCB01321',
                                                       'ECPBPCB01600', 'ECPBPCB01602', 'ECPBPCB01603', 'ECPBPCB01617'] THEN
                            ProdOrderComp.SETFILTER(ProdOrderComp."Type of Solder2", '<>%1', 'SMD');
                        ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
                        IF ProdOrderComp.FINDSET THEN
                            REPEAT
                                ITEM.GET(ProdOrderComp."Item No.");
                                IF (NOT ITEM."Dispatch Material") AND (ITEM."Product Group Code Cust" <> 'CPCB') AND (ITEM."Product Group Code Cust" <> 'FPRODUCT') THEN BEGIN
                                    DUM.RESET;
                                    IF NOT (DUM.GET(ProdOrderComp."Item No.")) THEN
                                        Include_Item1(ProdOrderComp."Item No.", TRUE);

                                    IF DUM.GET(ProdOrderComp."Item No.") THEN BEGIN
                                        DUM."Maximum Inventory" -= (ProdOrderComp."Expected Quantity");
                                        DUM."Total Inventory" += (ProdOrderComp."Expected Quantity");
                                        DUM.MODIFY;
                                    END;
                                END;
                            UNTIL ProdOrderComp.NEXT = 0;
                    END;

                END;
            UNTIL ProdOrderLine.NEXT = 0;

    end;

    local procedure DateFilterOnAfterValidate()
    begin
        RESET;
        SETRANGE(Status, Status::Released);
        IF FORMAT(TODAY) = Date_Filter THEN
            SETFILTER("Prod Start date", FORMAT(TODAY + 2))
        ELSE
            SETFILTER("Prod Start date", Date_Filter);
    end;

    local procedure NoOnFormat()
    begin
        // Rev01>>
        StyleTx := 'None';
        IF "Shortage Verified" THEN BEGIN
            IF "Shortage Items" > 0 THEN BEGIN
                //"No.Emphasize" :=TRUE;
                StyleTx := 'Attention';
            END ELSE BEGIN
                StyleTx := 'Favorable';
                //"No.Emphasize" :=TRUE;
            END;
        END;
        // Rev01<<
    end;


    procedure VERIFY_BOM()
    var
        SalesHeader: Record "Sales Header";
        PBH: Record "Production BOM Header";
        PBL: Record "Production BOM Line";
        ProdOrderLine: Record "Prod. Order Line";
        Item: Record Item;
        SalesLine: Record "Sales Line";
        PrdOrder: Record "Production Order";
        ScheduleLine: Record Schedule2;
    begin
        //MNRAJU ADDED ON 05-SEP-2014 FOR CARD WISE PRODUCTION RESTRICTION

        PrdOrder.RESET;
        PrdOrder.SETRANGE(Status, PrdOrder.Status::Released);
        PrdOrder.SETFILTER(PrdOrder."Prod Start date", '<>%1', 0D);
        //PrdOrder.SETFILTER(PrdOrder."Product Group Code",'FPRODUCT|CPCB');
        PrdOrder.SETRANGE("Suppose to Plan", TRUE);


        IF PrdOrder.FINDSET THEN
            REPEAT
                // Added by Rakesh to verify BOM is certified on 18-Sep-14
                "PO-LINE".RESET;
                "PO-LINE".SETRANGE("PO-LINE"."Prod. Order No.", PrdOrder."No.");
                IF "PO-LINE".FINDFIRST THEN
                    REPEAT
                        PBH.RESET;
                        PBH.SETRANGE(PBH."No.", "PO-LINE"."Item No.");
                        IF PBH.FINDFIRST THEN
                            IF PBH.Status <> 1 THEN
                                ERROR(PBH."No." + ' BOM is not certified in RPO ' + PrdOrder."No." + '. Certify the BOM before production');
                    UNTIL "PO-LINE".NEXT = 0;
                // end by Rakesh


                IF PrdOrder."Sales Order No." = '' THEN
                    ERROR('Enter Sale order number for the RPO :' + FORMAT(PrdOrder."No."))
                ELSE BEGIN
                    SalesHeader.RESET;
                    SalesHeader.SETFILTER(SalesHeader."No.", PrdOrder."Sales Order No.");
                    SalesHeader.SETFILTER(SalesHeader."Document Type", '%1|%2', SalesHeader."Document Type"::Order, SalesHeader."Document Type"::"Blanket Order");
                    IF NOT SalesHeader.FINDFIRST THEN
                        ERROR('Sale Order No.(' + PrdOrder."Sales Order No." + ') not available in Sale Orders in RPO:' + PrdOrder."No.");
                END;

                IF PrdOrder."Sales Order Line No." = 0 THEN
                    ERROR('Enter Sale Order Line No for the RPO :' + FORMAT(PrdOrder."No."));
                SalesHeader.RESET;
                SalesHeader.SETFILTER(SalesHeader."No.", PrdOrder."Sales Order No.");
                IF SalesHeader.FINDFIRST THEN BEGIN
                    IF COPYSTR(SalesHeader."No.", 1, 7) = 'EFF/INT' THEN BEGIN
                        IF PrdOrder."Schedule Line No." = 0 THEN BEGIN
                            SalesLine.RESET;
                            SalesLine.SETFILTER(SalesLine."Document No.", PrdOrder."Sales Order No.");
                            SalesLine.SETFILTER(SalesLine."Line No.", '%1', PrdOrder."Sales Order Line No.");
                            IF SalesLine.FINDFIRST THEN BEGIN
                                Item.GET(SalesLine."No.");
                                IF (Item."Product Group Code Cust" <> 'FPRODUCT') THEN BEGIN
                                    ERROR('Cards wise production was not allowed.\Production Order: ' + PrdOrder."No.");
                                END;
                            END;
                        END
                        ELSE BEGIN
                            ScheduleLine.RESET;
                            ScheduleLine.SETFILTER(ScheduleLine."Document No.", PrdOrder."Sales Order No.");
                            ScheduleLine.SETFILTER(ScheduleLine."Document Line No.", '%1', PrdOrder."Sales Order Line No.");
                            ScheduleLine.SETFILTER(ScheduleLine."Line No.", '%1', PrdOrder."Schedule Line No.");
                            IF ScheduleLine.FINDFIRST THEN BEGIN
                                Item.GET(ScheduleLine."No.");
                                IF (Item."Product Group Code Cust" <> 'FPRODUCT') THEN BEGIN
                                    ERROR('Cards wise production was not allowed.\Production Order: ' + PrdOrder."No.");
                                END;
                            END;
                        END;
                    END
                    ELSE
                        IF NOT ((COPYSTR(SalesHeader."No.", 11, 3) = 'CUS') OR (COPYSTR(SalesHeader."No.", 1, 7) = 'EFF/SAL') OR (COPYSTR(SalesHeader."No.", 1, 7) = 'EFF/EXP')) THEN
                            ERROR('Cannot process the RPO :' + FORMAT(PrdOrder."No.") + ' with the Sale Order No : ' + FORMAT(PrdOrder."Sales Order No."));


                END;
            UNTIL PrdOrder.NEXT = 0;
        //MNRAJU ADDED ON 05-SEP-2014 FOR CARD WISE PRODUCTION RESTRICTION
    end;


    procedure POST_MATERIAL_ISSUES_Auto_Scheduled("PROD. ORDER": Code[20])
    begin
        MATERIAL_ISSUES_HEAER.RESET;
        MATERIAL_ISSUES_HEAER.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
        MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER."Prod. Order No.", "PROD. ORDER");
        MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER."Transfer-to Code", 'PROD');
        MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER.Status, MATERIAL_ISSUES_HEAER.Status::Released);
        IF MATERIAL_ISSUES_HEAER.FINDSET THEN
            REPEAT
                MATERIAL_ISSUES_HEAER."Posting Date" := TODAY;
                Issue_Post.Issues_Post_Auto_Scheduled(MATERIAL_ISSUES_HEAER);
                Mat_Issue_sLine.RESET;
                Mat_Issue_sLine.SETRANGE(Mat_Issue_sLine."Document No.", MATERIAL_ISSUES_HEAER."No.");
                IF Mat_Issue_sLine.FINDSET THEN
                    REPEAT
                        Mat_Issue_sLine."Qty. to Receive" := Mat_Issue_sLine.Quantity - Mat_Issue_sLine."Quantity Received";
                        Mat_Issue_sLine.MODIFY;
                    UNTIL Mat_Issue_sLine.NEXT = 0;
                COMMIT; // pranavi on 31-01-2017
            UNTIL MATERIAL_ISSUES_HEAER.NEXT = 0;
    end;


    procedure Post_Action_Auto_Scheduled()
    begin
        //WINDOW.OPEN(T1);
        GL.GET;
        GL."Restrict Store Material Issues" := FALSE;
        GL.MODIFY;
        /*
          IF GL."Production_ Shortage_Status"=GL."Production_ Shortage_Status"::nothing THEN
          BEGIN
          PO.RESET;
          PO.SETRANGE(PO.Status,PO.Status::Released);
          PO.SETRANGE(PO."Suppose to Plan",TRUE);
          PO.SETFILTER(PO."Prod Start date",'>%1',0D);
          IF PO.FINDFIRST THEN
          REPEAT
            Mat_Issue_sLine.RESET;
            Mat_Issue_sLine.SETCURRENTKEY("Prod. Order No.","Prod. Order Line No.","Prod. Order Comp. Line No.");
            Mat_Issue_sLine.SETRANGE("Prod. Order No.",PO."No.");
            Mat_Issue_sLine.SETRANGE("Qty. to Receive",0);
            //IF Mat_Issue_sLine.FINDFIRST THEN
              //ERROR('MATERIAL IS NOT ASSIGNED PROPERLY :'+PO."No.");
          UNTIL PO.NEXT=0;
          END;
        */
        POrdersList := '';
        POrdersList1 := '';
        No_of_Units := 0;
        PO.RESET;
        PO.SETRANGE(PO.Status, PO.Status::Released);
        PO.SETRANGE(PO."Suppose to Plan", TRUE);
        PO.SETFILTER(PO."Prod Start date", '>%1', 0D);
        IF PO.FINDFIRST THEN
            REPEAT
                IF ITEM.GET(PO."Source No.") THEN BEGIN
                    ITEM.TESTFIELD(ITEM."No.of Units");
                    No_of_Units += ITEM."No.of Units";
                END;

                PO.CALCFIELDS(PO."Shortage Items");
                IF GL."Production_ Shortage_Status" = GL."Production_ Shortage_Status"::Accepted THEN BEGIN
                    IF (PO."Shortage Verified") THEN BEGIN
                        IF (PO."No." <> 'CSM15SPA0124') THEN BEGIN
                            //WINDOW.UPDATE(1,'POSTING MATERIAL REQUESTS');
                            //WINDOW.UPDATE(2,PO."No.");
                            POST_MATERIAL_ISSUES_Auto_Scheduled(PO."No.");
                            POrdersList := POrdersList + PO."No." + '|';
                        END;
                    END;
                END ELSE BEGIN
                    IF (PO."Shortage Verified") AND (PO."Shortage Items" = 0) THEN BEGIN
                        IF (PO."No." <> 'CSM15SPA0124') THEN BEGIN
                            //WINDOW.UPDATE(1,'POSTING MATERIAL REQUESTS');
                            //WINDOW.UPDATE(2,PO."No.");
                            POST_MATERIAL_ISSUES_Auto_Scheduled(PO."No.");
                            POrdersList := POrdersList + PO."No." + '|';
                        END;
                    END;
                END;
            UNTIL PO.NEXT = 0;
        //WINDOW.CLOSE;
        /*
          GL.GET;
          GL."Production_ Shortage_Status":=GL."Production_ Shortage_Status"::nothing;
          GL."Production Shortage Date":=0D;
          GL.MODIFY;
        */
        IF Day_wise_Details.GET(TODAY) THEN BEGIN
            Day_wise_Details."PRODUCT WISE ISSUES POSTED" := TRUE;
            Day_wise_Details.PLANNED_PROD_UNITS += No_of_Units;
            Day_wise_Details.MODIFY;
        END ELSE BEGIN
            Day_wise_Details."POSTING DATE" := TODAY;
            Day_wise_Details."PRODUCT WISE ISSUES POSTED" := TRUE;
            Day_wise_Details.PLANNED_PROD_UNITS := No_of_Units;
            Day_wise_Details.INSERT;
        END;
        //Added by Pranavi on 14-09-2015
        IF POrdersList <> '' THEN BEGIN
            POrdersList1 := COPYSTR(POrdersList, 1, STRLEN(POrdersList) - 1);
            //B2BUPG>>>
            /*Body := '';
            PrevItem := '';
            PrevOrder := '';
            ItemPrdQty := 0;
            RowCount := 0;
            From_Mail := 'noreply@efftronics.com';
            To_mail := 'lmd@efftronics.com,erp@efftronics.com,projectmanagement@efftronics.com';
            //To_mail:='pranavi@efftronics.com';
            Subject := 'Reg: Production Details of LED Sale Orders ';
            SMTP_Mail.CreateMessage('ERP', From_Mail, To_mail, Subject, Body, TRUE);
            SMTP_Mail.AppendBody('<html><head><style> divone{background-color: white; width: 1100px; padding: 20px; border-style:solid ; border-color:#8EB52B;  margin: 20px;} </style></head>');
            SMTP_Mail.AppendBody('<body><div style="border-color:#8EB52B;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 1000px;"><label><font size="5">Production Details of LED Sale Orders</font></label>');
            SMTP_Mail.AppendBody('<hr style=solid; color= #3333CC>');
            SMTP_Mail.AppendBody('<table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"');
            SMTP_Mail.AppendBody('border="1" align="Center">');
            SMTP_Mail.AppendBody('<P> Following are details of LED Sale Orders Production Started Items Details</P>');
            SMTP_Mail.AppendBody('<br><table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Order No</th><th>Customer Name</th><th>Item No</th><th>Item Desc</th><th>To Be Shipped Qty</th><th>Prod Qty</th>');
            SMTP_Mail.AppendBody('<th>Order Date</th><th>Prod Start Date</th></tr>');*/ //B2BUPG<<<

            Body := '';
            PrevItem := '';
            PrevOrder := '';
            ItemPrdQty := 0;
            RowCount := 0;
            //From_Mail := 'noreply@efftronics.com';

            Recipient.Add('lmd@efftronics.com');
            Recipient.Add('erp@efftronics.com');
            Recipient.Add('projectmanagement@efftronics.com');

            Subject := 'Reg: Production Details of LED Sale Orders ';
            EmailMessage.Create(Recipient, Subject, Body, true);
            Body += ('<html><head><style> divone{background-color: white; width: 1100px; padding: 20px; border-style:solid ; border-color:#8EB52B;  margin: 20px;} </style></head>');
            Body += ('<body><div style="border-color:#8EB52B;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 1000px;"><label><font size="5">Production Details of LED Sale Orders</font></label>');
            Body += ('<hr style=solid; color= #3333CC>');
            Body += ('<table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"');
            Body += ('border="1" align="Center">');
            Body += ('<P> Following are details of LED Sale Orders Production Started Items Details</P>');
            Body += ('<br><table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Order No</th><th>Customer Name</th><th>Item No</th><th>Item Desc</th><th>To Be Shipped Qty</th><th>Prod Qty</th>');
            Body += ('<th>Order Date</th><th>Prod Start Date</th></tr>');
            PrdOrdr.RESET;
            PrdOrdr.SETCURRENTKEY("Sales Order No.", "Source No.", "Prod Start date");
            PrdOrdr.SETFILTER(PrdOrdr.Status, '%1', PrdOrdr.Status::Released);
            //PrdOrdr.SETFILTER(PrdOrdr."Suppose to Plan",'%1',TRUE);
            PrdOrdr.SETFILTER(PrdOrdr."No.", POrdersList1);
            PrdOrdr.SETFILTER(PrdOrdr."Prod Start date", '>%1', 0D);
            PrdOrdr.SETFILTER(PrdOrdr."Sales Order No.", '%1|%2', '*/L*', '*/T*');
            PrdOrdr.SETFILTER(PrdOrdr."Item Sub Group Code", 'LED LIGHT');
            REPEAT
                pmih.RESET;
                pmih.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
                pmih.SETFILTER(pmih."Prod. Order No.", PrdOrdr."No.");
                IF pmih.FINDFIRST THEN BEGIN
                    IF (PrevOrder <> '') AND (PrevItem <> '') THEN BEGIN
                        SL.RESET;
                        SL.SETCURRENTKEY("Document Type", "Document No.", Type, "No.");
                        SL.SETFILTER(SL."Document No.", PrevOrder);
                        SL.SETFILTER(SL."No.", PrevItem);
                        IF SL.FINDFIRST THEN BEGIN
                            SH.RESET;
                            SH.SETCURRENTKEY("Document Type", "No.");
                            SH.SETFILTER(SH."No.", SL."Document No.");
                            IF SH.FINDFIRST THEN BEGIN
                                OrderNo := SH."No.";
                                CustName := SH."Sell-to Customer Name";
                                No := SL."No.";
                                ItemDesc := SL.Description;
                                ToBeshipedQty := SL."Qty. to Ship";
                                OrderDate := SH."Order Date";
                                IF (PrevItem <> PrdOrdr."Source No.") AND (PrevItem <> '') THEN BEGIN
                                    IF SH."No." <> 'EFF/08-09/AUG/087' THEN BEGIN
                                        IF ItemPrdQty > 0 THEN BEGIN
                                            /*SMTP_Mail.AppendBody('<tr><td>' + SH."No." + '</td><td>' + SH."Sell-to Customer Name" + '</td><td>' + SL."No." + '</td><td>' + SL.Description + '</td><td  align ="right">' + FORMAT(SL."Qty. to Ship") + '</td>');
                                            SMTP_Mail.AppendBody('<td align ="right">' + FORMAT(ItemPrdQty) + '</td><td>' + FORMAT(SH."Order Date") + '</td><td>' + FORMAT(PrdOrdr."Prod Start date") + '</td></tr>');*///B2BUPG
                                            Body += ('<tr><td>' + SH."No." + '</td><td>' + SH."Sell-to Customer Name" + '</td><td>' + SL."No." + '</td><td>' + SL.Description + '</td><td  align ="right">' + FORMAT(SL."Qty. to Ship") + '</td>');
                                            Body += ('<td align ="right">' + FORMAT(ItemPrdQty) + '</td><td>' + FORMAT(SH."Order Date") + '</td><td>' + FORMAT(PrdOrdr."Prod Start date") + '</td></tr>');
                                            ItemPrdQty := 0;
                                            RowCount := RowCount + 1;
                                        END;
                                    END;
                                END
                                ELSE BEGIN
                                    IF (PrevOrder <> PrdOrdr."Sales Order No.") AND (PrevOrder <> '') THEN BEGIN
                                        IF SH."No." <> 'EFF/08-09/AUG/087' THEN BEGIN
                                            IF ItemPrdQty > 0 THEN BEGIN
                                                /*SMTP_Mail.AppendBody('<tr><td>' + SH."No." + '</td><td>' + SH."Sell-to Customer Name" + '</td><td>' + SL."No." + '</td><td>' + SL.Description + '</td><td  align ="right">' + FORMAT(SL."Qty. to Ship") + '</td>');
                                                SMTP_Mail.AppendBody('<td align ="right">' + FORMAT(ItemPrdQty) + '</td><td>' + FORMAT(SH."Order Date") + '</td><td>' + FORMAT(PrevPSDate) + '</td></tr>');*///B2BUPG
                                                Body += ('<tr><td>' + SH."No." + '</td><td>' + SH."Sell-to Customer Name" + '</td><td>' + SL."No." + '</td><td>' + SL.Description + '</td><td  align ="right">' + FORMAT(SL."Qty. to Ship") + '</td>');
                                                Body += ('<td align ="right">' + FORMAT(ItemPrdQty) + '</td><td>' + FORMAT(SH."Order Date") + '</td><td>' + FORMAT(PrevPSDate) + '</td></tr>');
                                                ItemPrdQty := 0;
                                                RowCount := RowCount + 1;
                                            END;
                                        END;
                                    END
                                    ELSE BEGIN
                                        ItemPrdQty := ItemPrdQty + PrdOrdr.Quantity;
                                    END;
                                END;   //else_end
                            END;    //SH_End
                        END;     //SL_End
                    END       //NullChecking_End
                    ELSE BEGIN
                        ItemPrdQty := ItemPrdQty + PrdOrdr.Quantity;
                    END;
                END;       //PMIH_End
                PrevOrder := PrdOrdr."Sales Order No.";
                PrevItem := PrdOrdr."Source No.";
                PrevPSDate := PrdOrdr."Prod Start date";
            UNTIL PrdOrdr.NEXT = 0;
            IF (SH."No." <> 'EFF/08-09/AUG/087') AND (OrderNo <> '') THEN BEGIN
                IF ItemPrdQty > 0 THEN BEGIN
                    /*SMTP_Mail.AppendBody('<tr><td>' + OrderNo + '</td><td>' + CustName + '</td><td>' + No + '</td><td>' + ItemDesc + '</td><td  align ="right">' + FORMAT(ToBeshipedQty) + '</td>');
                    SMTP_Mail.AppendBody('<td align ="right">' + FORMAT(ItemPrdQty) + '</td><td>' + FORMAT(OrderDate) + '</td><td>' + FORMAT(PrevPSDate) + '</td></tr>');*///B2BUPG
                    Body += ('<tr><td>' + OrderNo + '</td><td>' + CustName + '</td><td>' + No + '</td><td>' + ItemDesc + '</td><td  align ="right">' + FORMAT(ToBeshipedQty) + '</td>');
                    Body += ('<td align ="right">' + FORMAT(ItemPrdQty) + '</td><td>' + FORMAT(OrderDate) + '</td><td>' + FORMAT(PrevPSDate) + '</td></tr>');
                    RowCount := RowCount + 1;
                END;
            END;
            /*SMTP_Mail.AppendBody('</table><br><p align ="left"> Regards,<br>ERP Team </p>');
            SMTP_Mail.AppendBody('<br><p align = "center">:: Note: Auto Generated mail from ERP :: </P></div></body></html>');*///B2BUPG
            Body += ('</table><br><p align ="left"> Regards,<br>ERP Team </p>');
            Body += ('<br><p align = "center">:: Note: Auto Generated mail from ERP :: </P></div></body></html>');
            IF RowCount > 0 THEN
                //SMTP_Mail.Send; //B2BUPG
              Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

        END;
        //end by pranavi

    end;
}

