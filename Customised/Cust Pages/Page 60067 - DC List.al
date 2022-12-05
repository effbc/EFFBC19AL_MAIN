page 60067 "DC List"
{
    // version B2B1.0,Rev01

    CardPageID = "DC Header";
    Editable = false;
    PageType = List;
    SourceTable = "DC Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(Control1102152036)
            {
                ShowCaption = false;
                field("xRec.COUNT"; xRec.COUNT)
                {
                    ApplicationArea = All;
                }
            }
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                }
                field("L.R Number"; Rec."L.R Number")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Number"; Rec."Vehicle Number")
                {
                    ApplicationArea = All;
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                }
                field(NonReturnable; Rec.NonReturnable)
                {
                    ApplicationArea = All;
                }
                field(Returned; Rec.Returned)
                {
                    ApplicationArea = All;
                }
                field("Posted Shipment No."; Rec."Posted Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Received By"; Rec."Received By")
                {
                    ApplicationArea = All;
                }
                field("Checked By"; Rec."Checked By")
                {
                    ApplicationArea = All;
                }
                field("Prepared By"; Rec."Prepared By")
                {
                    ApplicationArea = All;
                }
                field("Mode Of Transport"; Rec."Mode Of Transport")
                {
                    ApplicationArea = All;
                }
                field("Docket No"; Rec."Docket No")
                {
                    ApplicationArea = All;
                }
                field("Courier Agency Name"; Rec."Courier Agency Name")
                {
                    ApplicationArea = All;
                }
                field("Tracking Status"; Rec."Tracking Status")
                {
                    ApplicationArea = All;
                }
                field("Tracking Status Last Updated"; Rec."Tracking Status Last Updated")
                {
                    ApplicationArea = All;
                }
                field("Tracking URL"; Rec."Tracking URL")
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Name 2"; Rec."Ship-to Name 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Customer P. O. No."; Rec."Customer P. O. No.")
                {
                    ApplicationArea = All;
                }
                field("Customer P. O. Date"; Rec."Customer P. O. Date")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name 2"; Rec."Sell-to Customer Name 2")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Country Code"; Rec."Sell-to Country Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Country Code"; Rec."Ship-to Country Code")
                {
                    ApplicationArea = All;
                }
                field("No.of Packages"; Rec."No.of Packages")
                {
                    ApplicationArea = All;
                }
                field("Package No's"; Rec."Package No's")
                {
                    ApplicationArea = All;
                }
                field("Service Order No."; Rec."Service Order No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action(Release)
                {
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.TESTFIELD(Status, Rec.Status::Open);
                        //TESTFIELD("Posted Shipment No.");
                        USER.RESET;
                        USER.SETFILTER(USER."User ID", USERID);//B2BUpg
                        USER.SETFILTER(USER.levels, '%1', TRUE);//B2BUpg
                        IF NOT USER.FINDFIRST THEN
                            ERROR('U Dont Have Rights to Authorize');
                        IF NOT CONFIRM('Do you want to release the DC') THEN
                            EXIT;
                        Rec.Status := Rec.Status::Released;
                        Rec.Authorized := USERID;
                        Rec.MODIFY;
                        CurrPage.UPDATE;
                    end;
                }
                action("Report")
                {
                    Caption = 'Report';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+p';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        /*InspectDataSheet.SETRANGE("No.","No.");
                        REPORT.RUN(33000250,TRUE,FALSE,InspectDataSheet);*/
                        dcheader.SETRANGE(dcheader."No.", Rec."No.");
                        REPORT.RUN(33000895, TRUE, FALSE, dcheader);

                    end;
                }
                action("Request For Authorization")
                {
                    Caption = 'Request For Authorization';
                    Image = SendApprovalRequest;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //B2B UPG >>>
                        /* IF Rec.Status = Rec.Status::Released THEN
                            ERROR('Request Already in Released Mode');
                        Body := '';
                        "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                        IF "Mail-Id".FINDFIRST THEN
                            "from Mail" := "Mail-Id".MailID
                        ELSE
                            ERROR('You do not Have Mail id in ERP & Please Tell the ERP Administrator to Create your Mail id');

                        IF Rec.SessionCode = '' THEN
                            ERROR('Enter Session Code');
                        IF Rec."Mode Of Transport" = '' THEN
                            ERROR('Enter the Mode Of Transport');
                        IF Rec."Location Name" = '' THEN
                            ERROR('DC location not Specified');
                        IF Rec."Customer No." = '' THEN
                            ERROR('Enter the Person to whom the DC');
                        IF Rec.Indented = '' THEN
                            ERROR('Enter the Authorized Person Information');

                        DCL.RESET;
                        DCL.SETFILTER(DCL."Document No.", Rec."No.");
                        DCL.SETFILTER(DCL.Description, '<>%1', '');
                        DCL.SETFILTER(DCL.Quantity, '%1', 0);
                        IF DCL.FINDFIRST THEN
                            ERROR('There is no quantity to Request for Authorization');

                        DCL.RESET;
                        DCL.SETFILTER(DCL."Document No.", Rec."No.");
                        DCL.SETFILTER(DCL.Description, '<>%1', '');
                        DCL.SETFILTER(DCL.Quantity, '%1', 0);
                        IF DCL.FINDFIRST THEN
                            ERROR('Enter Quantity in Line no %1', DCL."Line No.");

                        "Mail-Id".RESET;
                        "Mail-Id".SETRANGE("Mail-Id"."User ID", Rec.Indented);
                        IF "Mail-Id".FINDFIRST THEN BEGIN
                            IF "Mail-Id".levels = TRUE THEN
                                Mail_to := "Mail-Id".MailID;
                            ELSE
                            ERROR('You are Specified UnAuthorized person & If any Modification Please Contact ERP Administrtor');
                        END;

                        IF Rec.Remarks = '' THEN
                            ERROR('Please Enter DC purpose in Remarks column');

                        Subject := 'DC Request for Authorisation' + FORMAT(Rec."No.");
                        Body += '<body><strong><form><table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
                        Body += 'border="1" align="center">';
                        Body += '<tr><td>Requested No</td><td>' + Rec."No." + '</td></tr><br>';
                        Body += '<tr><td>Requested User</td><td>' + Rec."User Id" + ':  ' + Rec."Reciver Name" + '</td></tr><br>';
                        //Body+='<tr><td>Project Name</td><td>'+"Proj Description"+'</td></tr>';
                        Body += '<tr><td bgcolor="green">'; //#009900
                        Body += '<a Href="http://192.168.0.155:5556/erp_reports/Mat_Auth.aspx?val1=' + FORMAT(Rec."No.") + '&val2=' + FORMAT(Rec."User Id");
                        Body += '&val3=' + FORMAT(Rec.Indented);
                        Body += '&val4=1';
                        Body += '&val5=' + Mail_to;
                        Body += '&val6=' + "from Mail";
                        Body += '&val7=Accepted"target="_blank">';
                        Body += '<font face="arial" color="#ffffff">ACCEPT</font></a>';
                        Body += '</td><td bgcolor="red">';
                        Body += '<a Href="http://192.168.0.155:5556/erp_reports/Mat_Auth.aspx?val1=' + FORMAT(Rec."No.");
                        Body += '&val2=' + FORMAT(Rec."User Id");
                        Body += '&val3=' + FORMAT(Rec.Indented);
                        Body += '&val4=0';
                        Body += '&val5=' + "Mail_to";
                        Body += '&val6=' + "from Mail";
                        Body += '&val7=Rejected';
                        Body += '"target="_blank">';
                        Body += '<font face="arial" color="#ffffff">REJECT</font></a></td></tr>';
                        Body += '</table></form></font></strong></body>';
                        dcheader.SETRANGE(dcheader."No.", Rec."No.");
                        IF dcheader.FINDFIRST THEN
                            REPORT.RUN(50193, FALSE, FALSE, dcheader);
                        //REPORT.SAVEASHTML(50193, '\\erpserver\ErpAttachments\ErpAttachments1\' + CONVERT(Rec."No.") + '.htm', FALSE, dcheader);
                        Attachment := '\\erpserver\ErpAttachments\ErpAttachments1\' + CONVERT(Rec."No.") + '.htm';
                        // SMTP_MAIL.CreateMessage("Mail-Id"."User Name", "from Mail", Mail_to, Subject, Body, TRUE);
                        //EmailMessage.create(Mail_to, Subject, Body, TRUE);
                        //EmailMessage.a

                        //SMTP_MAIL.AddAttachment(Attachment, '');//EFFUPG Added ('')
                        //SMTP_MAIL.Send;


                        MESSAGE('Mail Has been Sent'); */
                        //B2B UPG <<<

                        IF Rec.Status = Rec.Status::Released THEN
                            ERROR('Request Already in Released Mode');
                        Body := '';
                        "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                        /* IF "Mail-Id".FINDFIRST THEN
                            "from Mail" := "Mail-Id".MailID
                        ELSE
                            ERROR('You do not Have Mail id in ERP & Please Tell the ERP Administrator to Create your Mail id'); */

                        IF Rec.SessionCode = '' THEN
                            ERROR('Enter Session Code');
                        IF Rec."Mode Of Transport" = '' THEN
                            ERROR('Enter the Mode Of Transport');
                        IF Rec."Location Name" = '' THEN
                            ERROR('DC location not Specified');
                        IF Rec."Customer No." = '' THEN
                            ERROR('Enter the Person to whom the DC');
                        IF Rec.Indented = '' THEN
                            ERROR('Enter the Authorized Person Information');

                        DCL.RESET;
                        DCL.SETFILTER(DCL."Document No.", Rec."No.");
                        DCL.SETFILTER(DCL.Description, '<>%1', '');
                        DCL.SETFILTER(DCL.Quantity, '%1', 0);
                        IF DCL.FINDFIRST THEN
                            ERROR('There is no quantity to Request for Authorization');

                        DCL.RESET;
                        DCL.SETFILTER(DCL."Document No.", Rec."No.");
                        DCL.SETFILTER(DCL.Description, '<>%1', '');
                        DCL.SETFILTER(DCL.Quantity, '%1', 0);
                        IF DCL.FINDFIRST THEN
                            ERROR('Enter Quantity in Line no %1', DCL."Line No.");

                        "Mail-Id".RESET;
                        "Mail-Id".SETRANGE("Mail-Id"."User ID", Rec.Indented);
                        IF "Mail-Id".FINDFIRST THEN BEGIN
                            IF "Mail-Id".levels = TRUE THEN begin
                                //Mail_to := "Mail-Id".MailID;
                                Recipients.Add("Mail-Id".MailID);
                            end
                            ELSE
                                ERROR('You are Specified UnAuthorized person & If any Modification Please Contact ERP Administrtor');
                        END;

                        IF Rec.Remarks = '' THEN
                            ERROR('Please Enter DC purpose in Remarks column');

                        Subject := 'DC Request for Authorisation' + FORMAT(Rec."No.");
                        Body += '<body><strong><form><table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
                        Body += 'border="1" align="center">';
                        Body += '<tr><td>Requested No</td><td>' + Rec."No." + '</td></tr><br>';
                        Body += '<tr><td>Requested User</td><td>' + Rec."User Id" + ':  ' + Rec."Reciver Name" + '</td></tr><br>';

                        Body += '<tr><td bgcolor="green">';
                        Body += '<a Href="http://192.168.0.155:5556/erp_reports/Mat_Auth.aspx?val1=' + FORMAT(Rec."No.") + '&val2=' + FORMAT(Rec."User Id");
                        Body += '&val3=' + FORMAT(Rec.Indented);
                        Body += '&val4=1';
                        Body += '&val5=';
                        Body += '&val6=';
                        Body += '&val7=Accepted"target="_blank">';
                        Body += '<font face="arial" color="#ffffff">ACCEPT</font></a>';
                        Body += '</td><td bgcolor="red">';
                        Body += '<a Href="http://192.168.0.155:5556/erp_reports/Mat_Auth.aspx?val1=' + FORMAT(Rec."No.");
                        Body += '&val2=' + FORMAT(Rec."User Id");
                        Body += '&val3=' + FORMAT(Rec.Indented);
                        Body += '&val4=0';
                        Body += '&val5=';
                        Body += '&val6=';
                        Body += '&val7=Rejected';
                        Body += '"target="_blank">';
                        Body += '<font face="arial" color="#ffffff">REJECT</font></a></td></tr>';
                        Body += '</table></form></font></strong></body>';
                        dcheader.SETRANGE(dcheader."No.", Rec."No.");
                        IF dcheader.FINDFIRST THEN
                            REPORT.RUN(50193, FALSE, FALSE, dcheader);

                        Attachment := '\\erpserver\ErpAttachments\ErpAttachments1\' + CONVERT(Rec."No.") + '.htm';
                        EmailMessage.create(Recipients, Subject, Body, true);
                        EmailMessage.AddAttachment(Attachment, '', '');
                        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                        MESSAGE('Mail Has been Sent');
                    end;
                }
            }
            action(Refresh)
            {
                Caption = 'Refresh';
                Image = RefreshLines;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //>> ORACLE UPG
                    /* 
                    IF Rec.Status <> Rec.Status::Released THEN BEGIN
                        //   IF ISCLEAR(SQLConnection) THEN
                        //       CREATE(SQLConnection, FALSE, TRUE);// Rev01

                        //   IF ISCLEAR(RecordSet) THEN
                        //       CREATE(RecordSet, FALSE, TRUE);// Rev01

                        IF ConnectionOpen <> 1 THEN BEGIN
                            SQLConnection.ConnectionString := 'DSN=salinvoiceuser;UID=salinvoiceuser;PASSWORD=salinvoiceuser;SERVER=oracle_80;';
                            SQLConnection.Open;
                            SQLConnection.BeginTrans;
                            ConnectionOpen := 1;
                        END;
                        SQLQuery := 'select requestid,status from materialauthor where (status=1) and materialauthor.requestid=''' + FORMAT(Rec."No.") + '''';
                        //MESSAGE(SQLQuery);
                        RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
                        //MESSAGE(FORMAT(RowCount));
                        IF RowCount < -1 THEN
                            ERROR('Request not yet authorized to Refresh the data')
                        ELSE BEGIN
                            IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                                RecordSet.MoveFirst;

                            WHILE NOT RecordSet.EOF DO BEGIN

                                IF (Rec."No." = FORMAT(RecordSet.Fields.Item('requestid').Value)) THEN BEGIN
                                    Rec.VALIDATE(Status, Rec.Status::Released);
                                    Rec.VALIDATE(Authorized, Rec.Indented);
                                    Rec.VALIDATE("Authorized name", Rec."Indented Name");
                                    // VALIDATE("Released By","Request for Authorization");
                                    //  "Posting Date":=TODAY;
                                    //  IF "Authorized Date"=0D THEN
                                    //    "Authorized Date":=TODAY;
                                       
                                    Rec.MODIFY;
                                    MESSAGE('Data Refreshed');
                                END;
                                RecordSet.MoveNext;
                            END;
                        END;
                    END ELSE
                        ERROR('The Request has Already in the Released Mode');
                end;
                */
                    //<< ORACLE UPG
                end;
            }
            action("Send DC Mail")
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    MailDC();
                end;
            }
        }
    }

    var
        Recipients: List of [Text];
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        dcheader: Record "DC Header";
        "Mail-Id": Record "User Setup";
        "from Mail": Text[150];
        "to mail": List of [Text];
        Mail_Subject: Text[1000];
        Mail_Body: Text[1000];
        // mail: Codeunit Mail;
        newline: Char;
        // SMTP_MAIL: Codeunit "SMTP Mail";
        Attachment1: Text[1000];
        Body: Text[1000];
        Mail_to: List of [Text];
        Subject: Text[1000];
        SQLQuery: Text[1000];
        ConnectionOpen: Integer;
        RowCount: Integer;
        DCL: Record "DC Line";
        Attachment: Text[1000];
        Cust: Record Customer;
        Vend: Record Vendor;
        EMP: Record Employee;
        USER: Record "User Setup";
        Fname: Text[100];

        sendmailVisible: Boolean;
        ".......Rev01........": Integer;
        //>> ORACLE UPG
        //  SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
        //  RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        //<< ORACLE UPG
        Dchdr: Record "DC Header";
        //DCMail: Codeunit "SMTP Mail";
        dcLine: Integer;
        dcnum: Code[20];
        docnum: Code[30];
        Courier: Code[30];
        DIMENSIONS: Record "Dimension Value";


    procedure CONVERT(No: Code[20]) NEW_NO: Code[20];
    var
        i: Integer;
    begin
        NEW_NO := '';
        FOR i := 1 TO STRLEN(No) DO BEGIN
            IF COPYSTR(No, i, 1) <> '/' THEN
                NEW_NO := NEW_NO + COPYSTR(No, i, 1)
            ELSE
                NEW_NO := NEW_NO + '_';
        END;
    end;


    local procedure sendmailOnPush();
    begin
        IF Rec.sendmail THEN BEGIN
            newline := 10;
            Mail_Subject := 'DC Information  ' + Rec."No.";
            Mail_Body := 'DC Information     : ' + Rec."No.";
            Mail_Body += FORMAT(newline);
            Mail_Body += FORMAT(newline);
            Mail_Body += FORMAT(newline);
            Mail_Body += '***** Auto Mail Generated From ERP *****';
            "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
            IF "Mail-Id".FINDFIRST THEN
                "from Mail" := "Mail-Id".MailID;

            dcheader.RESET;
            dcheader.SETFILTER(dcheader."No.", Rec."No.");
            IF dcheader.FINDFIRST THEN BEGIN
                Fname := '\\erpserver\ErpAttachments\dcdetails' + COPYSTR(Rec."No.", 15, 3) + '.html';
                REPORT.SAVEASHTML(50193, Fname, dcheader);
                Attachment1 := Fname;
            END;
            "Mail-Id".RESET;
            "Mail-Id".GET(Rec.Indented);
            // "to mail" := 'nayomi@efftronics.com,sundar@efftronics.com,' + "Mail-Id".MailID;//B2B UPG
            Recipients.Add('nayomi@efftronics.com');
            Recipients.Add('sundar@efftronics.com');
            Recipients.Add('"Mail-Id".MailID');

            EMP.RESET;
            EMP.SETFILTER(EMP."No.", Rec.Reciver);
            EMP.SETFILTER(EMP."E-Mail", '<>%1', '');
            IF EMP.FINDFIRST THEN BEGIN
                //"to mail" += ',' + EMP."E-Mail"; //B2B UPG
                Recipients.Add(EMP."E-Mail");
            END;
            //B2B UPG
            /* IF ("from Mail" <> '') AND ("to mail" <> '') THEN BEGIN
                "from Mail" := 'erp@efftronics.com';
                SMTP_MAIL.CreateMessage('EFF', "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);
                SMTP_MAIL.AddAttachment(Attachment1, '');//EFFUPG Added ('')
                SMTP_MAIL.Send;
            END; */  //B2B UPG
            EmailMessage.Create(Recipients, Mail_Subject, Mail_Body, FALSE);
            EmailMessage.AddAttachment(Attachment1, '', '');
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        END;
    end;


    procedure MailDC();
    var
        Custmr: Record Customer;
        Cust_Name: Text[50];
    begin
       /*Dchdr.RESET;
        Dchdr.SETFILTER(Dchdr."Created Date", '>01-12-2014');
        Dchdr.SETFILTER(Dchdr.sendmail, '%1', FALSE);
        //Dchdr.SETFILTER(Dchdr.Status,'%1',Dchdr.Status:: Released);

        IF Dchdr.FINDFIRST THEN
            REPEAT
                IF COPYSTR(Dchdr."No.", 1, 3) = 'CUS' THEN BEGIN
                    "from Mail" := 'erp@efftronics.com';
                    "Mail-Id".RESET;
                    "Mail-Id".SETFILTER("Mail-Id"."User ID", Dchdr.Indented);
                    IF "Mail-Id".FINDFIRST THEN
                        // "to mail" := "Mail-Id".MailID;//B2B UPG
                        Recipients.Add('"Mail-Id".MailID');

                    USER.RESET;
                    USER.SETFILTER(USER."User ID", Dchdr.Reciver);
                    IF USER.FINDFIRST THEN BEGIN
                        IF (USER.EmployeeID <> '') AND (USER.MailID <> '') THEN BEGIN
                            /* IF "to mail" <> '' THEN
                                 "to mail" += ',' + USER.e
                             ELSE*/
                            //"to mail" := USER.MailID;
                           // Recipients.Add('USER.MailID');//B2B UPG
                        //END;
                        /*
                         IF USER.EmployeeID<>''  THEN
                          BEGIN
                          EMP.RESET;
                          EMP.SETFILTER(EMP."No.",USER.EmployeeID);
                          EMP.SETFILTER(EMP."E-Mail",'<>%1','');
                          IF EMP.FINDFIRST THEN
                          BEGIN
                            IF   "to mail" <> '' THEN
                            "to mail"+=','+EMP."E-Mail"
                            ELSE
                               "to mail" :=EMP."E-Mail";
                          END;
                        END;
                        */
                   // END;
                    // "to mail" :='rakesht@efftronics.com';
                    //dcheader.RESET;
                    //dcheader.SETFILTER(dcheader."No.",Dchdr."No.");
                    //IF dcheader.FINDFIRST THEN
                    //BEGIN
                    // Fname:='\\erpserver\ErpAttachments\dcdetails'+COPYSTR(dcheader."No.",15,3)+'.pdf';
                    //  REPORT.SAVEASPDF(33000896,Fname,dcheader);
                    //  Attachment1:=Fname;
                    //END;
                    //  "to mail":='mnraju@efftronics.com';

                    //  IF ("from Mail" <> '') AND ("to mail" <> '') THEN BEGIN
                    // "from Mail":='erp@efftronics.com';
                    // "to mail" += ',erp@efftronics.com,nagalakshmi@efftronics.com,srivalli@efftronics.com';//B2B UPG
                  /*  Recipients.Add('erp@efftronics.com');
                    Recipients.Add('nagalakshmi@efftronics.com');
                    Recipients.Add('srivalli@efftronics.com');


                    Mail_Subject := 'ERP - DC Information ' + Dchdr."No.";
                    //DCMail.CreateMessage('ERP', "from Mail", "to mail", Mail_Subject, Mail_Body, TRUE); //B2B UPG
                    EmailMessage.Create(Recipients, Mail_Subject, Mail_Body, true);
                    Body += ('<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>');
                    Body += ('<body><div style="border-color:#025E4D;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;"><label><font size="6"> DC Information</font></label>');
                    Body += ('<hr style=solid; color= #3333CC>');
                    Body += ('<h>Dear Sir/Madam,</h><br>');
                    Body += ('<P>DC Information details</P>');

                    //Added by Rakesh on 01-Jan-15
                    dcnum := '';
                    docnum := '';
                    Courier := '';
                    SQLQuery := '';
                    /*IF ISCLEAR(SQLConnection) THEN
                        CREATE(SQLConnection, FALSE, TRUE);
                    IF ISCLEAR(RecordSet) THEN
                        CREATE(RecordSet, FALSE, TRUE);*/
                    //>> ORACLE UPG
                    /*  SQLConnection.ConnectionString := 'DSN=intranet;UID=sa;PASSWORD=admin@123;SERVER:=intranet;providerName=System.Data.SqlClient;';
                     SQLConnection.Open;
                     SQLQuery := ' SELECT  nvarchar4 AS CITY, nvarchar6 AS MODE, nvarchar7 AS DOCNUM, nvarchar1 AS DC FROM  [WSS_Content].[dbo].[AllUserData] ' +
                                  ' WHERE (tp_ListId = ' + '''D9CE8F4F-70CA-45C8-BD9D-67AC0531848C'')' + ' and (nvarchar1 like ''%' + FORMAT(Dchdr."No.") + '%'') ' +
                                  ' ORDER BY [tp_Created] DESC';
                     RecordSet := SQLConnection.Execute(SQLQuery);
                     IF NOT (RecordSet.EOF OR RecordSet.BOF) THEN BEGIN */
                    //<< ORACLE UPG

                    /*
                     IF NOT ISNULL(RecordSet.Fields.Item('DC').Value) THEN
                       dcnum  := FORMAT(RecordSet.Fields.Item('DC').Value);
                    */// Commented by Pranavi on 19-Jul-2016

                    //>> ORACLE UPG
                    /*  IF NOT ISNULL(RecordSet.Fields.Item('DOCNUM').Value) THEN
                         docnum := FORMAT(RecordSet.Fields.Item('DOCNUM').Value);
                     IF NOT ISNULL(RecordSet.Fields.Item('MODE').Value) THEN
                         Courier := FORMAT(RecordSet.Fields.Item('MODE').Value);
                 END;
                 SQLConnection.Close; */
                    //<< ORACLE UPG

                    // end by Rakesh
                    // Added by Pranavi on 30-Jan-2016 to include cust name if led cards dc
                   /* Cust_Name := '';
                    IF Dchdr."Location Code" = 'LED-GEN' THEN BEGIN
                        Custmr.RESET;
                        Custmr.SETRANGE(Custmr."No.", Dchdr."Customer No.");
                        IF Custmr.FINDFIRST THEN BEGIN
                            Cust_Name := Custmr.Name;
                        END;
                    END;

                    Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><td width="40%"><b> DC No. </b> </td><td>' + Dchdr."No." + '</td></tr>');
                    Body += ('<tr><td><b> Location name </b> </td><td>' + Dchdr."Location Name" + '</td></tr>');
                    IF (Dchdr."Location Code" = 'LED-GEN') AND (Cust_Name <> '') THEN
                        Body += ('<tr><td><b> Customer </b> </td><td>' + Cust_Name + '</td></tr>');  // Added by Pranavi on 30-Jan-2016 to include cust name if led cards dc
                    IF Dchdr."Indented Name" <> '' THEN
                        Body += ('<tr><td><b>Manager</b>  </td><td>' + Dchdr."Indented Name" + '</td></tr>')
                    ELSE
                        Body += ('<tr><td><b>Manager</b>  </td><td>' + dcheader.Indented + '</td></tr>');

                    Body += ('<tr><td><b>Receiver</b>  </td><td>' + Dchdr."Reciver Name" + '</td></tr>');
                    Body += ('<tr><td><b>  LR Number </b>  </td><td>' + Dchdr."L.R Number" + '</td></tr>');
                    Body += ('<tr><td><b> Mode of transport   </b> </td><td>' + Dchdr."Mode Of Transport" + '</td></tr>');
                    Body += ('<tr><td><b> Courier agent </b> </td><td>' + Courier + '</td></tr>');
                    Body += ('<tr><td><b> Courier Doc no.   </b> </td><td>' + docnum + '</td></tr>');
                    Body += ('<tr><td><b> DC generated date </b></td><td>' + FORMAT(Dchdr."Created Date") + '</td></tr>');


                    Body += ('<tr><td><b> Authorized by  </b> </td><td>' + Dchdr."StoreIncharge Name" + '</td></tr>');
                    Body += ('<tr><td><b> Remarks </b></td><td>' + Dchdr.Remarks + '</td></tr></table><br>');
                    Body += ('<br>');
                    Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th><b>Item no.</b> </th><th>Item Description </th> <th>Quantity</th><TH>Non-Returnable</TH></tr>');
                    DCL.RESET;
                    DCL.SETFILTER(DCL."Document No.", Dchdr."No.");
                    IF DCL.FINDSET THEN
                        REPEAT
                            Body += ('<tr><td>' + DCL."No." + '</td><td>' + DCL.Description + '</td><TD>' + FORMAT(DCL.Quantity) + '</TD><TD>' + FORMAT(DCL."Non-Returnable") + '</TD></tr>');

                        UNTIL DCL.NEXT = 0;
                    Body += ('</TABLE>');

                    Body += ('<BR><p align ="left"> Regards,<br>ERP Team </p>');
                    Body += ('<br><p align = "center">::::Note: Auto Generated mail from ERP:::: </b></P></div></body></html>');


                    /* DCMail.AddAttachment(Attachment1, '');//EFFUPG Added ('')
                    DCMail.Send; */ //B2B UPG
                   /* EmailMessage.AddAttachment(Attachment1, '', '');
                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                    IF docnum <> '' THEN
                        Dchdr."Docket No" := docnum
                    ELSE
                        Dchdr."Docket No" := 'NOT AVAILABLE';
                    Dchdr."Courier Agency Name" := Courier;
                    Dchdr.sendmail := TRUE;
                    Dchdr.MODIFY(TRUE);
                    // END;
                END;
            //END;
            UNTIL Dchdr.NEXT = 0;
        MESSAGE('DC MAILS SUCCESSFULLY SENT');
*/
    end;


    procedure MailDC_NEW();
    var
        Custmr: Record Customer;
        Cust_Name: Text[50];
    begin
        Dchdr.RESET;
        Dchdr.SETFILTER(Dchdr."Created Date", '>%1&<=%2', DMY2Date(12, 01, 14), TODAY() - 1);
        Dchdr.SETFILTER(Dchdr.sendmail, '%1', FALSE);
        //Dchdr.SETFILTER(Dchdr.Status,'%1',Dchdr.Status:: Released);

        IF Dchdr.FINDFIRST THEN
            REPEAT
                IF COPYSTR(Dchdr."No.", 1, 3) = 'CUS' THEN BEGIN
                    "from Mail" := 'erp@efftronics.com';
                    "Mail-Id".RESET;
                    "Mail-Id".SETFILTER("Mail-Id"."User ID", Dchdr.Indented);
                    IF "Mail-Id".FINDFIRST THEN
                        //"to mail" := "Mail-Id".MailID;    //B2B UPG
                        Recipients.Add("Mail-Id".MailID);

                   /* USER.RESET;
                    USER.SETFILTER(USER."User ID", Dchdr.Reciver);
                    IF USER.FINDFIRST THEN BEGIN
                        
                        IF (USER.EmployeeID <> '') AND (USER.MailID <> '') THEN BEGIN
                            /*  IF "to mail" <> '' THEN begin
                                  //"to mail" += ',' + USER.MailID //B2B UPG
                                  Recipients.Add(USER.MailID);
                              end*/
                            //ELSE
                            //"to mail" := USER.MailID; // B2B UPG
                          //  Recipients.Add(USER.MailID);
                        //END;
                        
                        /*
                         IF USER.EmployeeID<>''  THEN
                          BEGIN
                          EMP.RESET;
                          EMP.SETFILTER(EMP."No.",USER.EmployeeID);
                          EMP.SETFILTER(EMP."E-Mail",'<>%1','');
                          IF EMP.FINDFIRST THEN
                          BEGIN
                            IF   "to mail" <> '' THEN
                            "to mail"+=','+EMP."E-Mail"
                            ELSE
                               "to mail" :=EMP."E-Mail";
                          END;
                        END;
                        */
                    //END;*/
                    
                    // "to mail" :='rakesht@efftronics.com';
                    //dcheader.RESET;
                    //dcheader.SETFILTER(dcheader."No.",Dchdr."No.");
                    //IF dcheader.FINDFIRST THEN
                    //BEGIN
                    // Fname:='\\erpserver\ErpAttachments\dcdetails'+COPYSTR(dcheader."No.",15,3)+'.pdf';
                    //  REPORT.SAVEASPDF(33000896,Fname,dcheader);
                    //  Attachment1:=Fname;
                    //END;
                    //  "to mail":='mnraju@efftronics.com';

                    //IF ("from Mail" <> '') AND ("to mail" <> '') THEN BEGIN
                    // "from Mail":='erp@efftronics.com';
                    //"to mail" += 'erp@efftronics.com,nagalakshmi@efftronics.com,srivalli@efftronics.com';//B2B UPG
                    Recipients.Add('erp@efftronics.com');
                    Recipients.Add('nagalakshmi@efftronics.com');
                    Recipients.Add('srivalli@efftronics.com');

                    IF (Dchdr."Mode Of Transport" = 'Courier') AND (Dchdr."Doc Number entered" <> '') THEN  //Required by rama gopal sir to restrict the no of mails to logistics
                                                                                                            //"to mail" += 'logistics@efftronics.com';//B2B UPG
                        Recipients.Add('logistics@efftronics.com');
                    Mail_Subject := 'ERP - DC Information ' + Dchdr."No.";
                    //DCMail.CreateMessage('ERP', "from Mail", "to mail", Mail_Subject, Mail_Body, TRUE);//B2B UPG
                    EmailMessage.Create(Recipients, Mail_Subject, Mail_Body, true);

                    Body += ('<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>');
                    Body += ('<body><div style="border-color:#025E4D;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;"><label><font size="6"> DC Information</font></label>');
                    Body += ('<hr style=solid; color= #3333CC>');
                    Body += ('<h>Dear Sir/Madam,</h><br>');
                    Body += ('<P>DC Information details</P>');

                    //Added by Rakesh on 01-Jan-15
                    dcnum := '';
                    docnum := '';
                    Courier := '';
                    //**********************************************************************************************************************
                    /* SQLQuery := '';
                     IF ISCLEAR(SQLConnection) THEN
                       CREATE(SQLConnection,FALSE,TRUE);
                     IF ISCLEAR(RecordSet) THEN
                       CREATE(RecordSet,FALSE,TRUE);
                     SQLConnection.ConnectionString := 'DSN=intranet;UID=sa;PASSWORD=admin@123;SERVER:=intranet;providerName=System.Data.SqlClient;';
                     SQLConnection.Open;
                     SQLQuery :=  ' SELECT  nvarchar4 AS CITY, nvarchar6 AS MODE, nvarchar7 AS DOCNUM, nvarchar1 AS DC FROM  [WSS_Content].[dbo].[AllUserData] '+
                                  ' WHERE (tp_ListId = '+'''D9CE8F4F-70CA-45C8-BD9D-67AC0531848C'')'+' and (nvarchar1 like ''%'+FORMAT(Dchdr."No.")+'%'') '+
                                  ' ORDER BY [tp_Created] DESC';
                     RecordSet :=SQLConnection.Execute(SQLQuery);
                     IF NOT (RecordSet.EOF OR RecordSet.BOF) THEN
                     BEGIN
                      {
                       IF NOT ISNULL(RecordSet.Fields.Item('DC').Value) THEN
                         dcnum  := FORMAT(RecordSet.Fields.Item('DC').Value);
                      }// Commented by Pranavi on 19-Jul-2016
                        IF NOT ISNULL(RecordSet.Fields.Item('DOCNUM').Value) THEN
                         docnum := FORMAT(RecordSet.Fields.Item('DOCNUM').Value);
                       IF NOT ISNULL(RecordSet.Fields.Item('MODE').Value) THEN
                         Courier := FORMAT(RecordSet.Fields.Item('MODE').Value);
                     END;
                     SQLConnection.Close;
                     */
                    //**********************************************************************************************************************
                    docnum := Dchdr."Doc Number entered";
                    Courier := Dchdr."Mode Entered";


                    // end by Rakesh
                    // Added by Pranavi on 30-Jan-2016 to include cust name if led cards dc
                    Cust_Name := '';
                    IF Dchdr."Location Code" = 'LED-GEN' THEN BEGIN
                        Custmr.RESET;
                        Custmr.SETRANGE(Custmr."No.", Dchdr."Customer No.");
                        IF Custmr.FINDFIRST THEN BEGIN
                            Cust_Name := Custmr.Name;
                        END;
                    END;

                    Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><td width="40%"><b> DC No. </b> </td><td>' + Dchdr."No." + '</td></tr>');
                    Body += ('<tr><td><b> Location name </b> </td><td>' + Dchdr."Location Name" + '</td></tr>');
                    IF (Dchdr."Location Code" = 'LED-GEN') AND (Cust_Name <> '') THEN
                        Body += ('<tr><td><b> Customer </b> </td><td>' + Cust_Name + '</td></tr>');  // Added by Pranavi on 30-Jan-2016 to include cust name if led cards dc
                    IF Dchdr."Indented Name" <> '' THEN
                        Body += ('<tr><td><b>Manager</b>  </td><td>' + Dchdr."Indented Name" + '</td></tr>')
                    ELSE
                        Body += ('<tr><td><b>Manager</b>  </td><td>' + dcheader.Indented + '</td></tr>');

                    Body += ('<tr><td><b>Receiver</b>  </td><td>' + Dchdr."Reciver Name" + '</td></tr>');
                    Body += ('<tr><td><b>  LR Number </b>  </td><td>' + Dchdr."L.R Number" + '</td></tr>');
                    Body += ('<tr><td><b> Mode of transport   </b> </td><td>' + Dchdr."Mode Of Transport" + '</td></tr>');
                    Body += ('<tr><td><b> Courier agent </b> </td><td>' + Courier + '</td></tr>');
                    Body += ('<tr><td><b> Courier Doc no.   </b> </td><td>' + docnum + '</td></tr>');
                    Body += ('<tr><td><b> DC generated date </b></td><td>' + FORMAT(Dchdr."Created Date") + '</td></tr>');
                    Body += ('<tr><td><b> Authorized by  </b> </td><td>' + Dchdr."StoreIncharge Name" + '</td></tr>');
                    Body += ('<tr><td><b> Remarks </b></td><td>' + Dchdr.Remarks + '</td></tr>');
                    //Added by Vishnu Priya to include the address also in DC Mails on 04-02-2020
                    DIMENSIONS.RESET;
                    DIMENSIONS.SETFILTER("Dimension Code", 'LOCATIONS');
                    DIMENSIONS.SETFILTER(Blocked, 'No');
                    DIMENSIONS.SETFILTER(Code, Dchdr."Location Code");
                    IF DIMENSIONS.FINDFIRST THEN
                        Body += ('<tr><td><b> Address </b></td><td>' + FORMAT(DIMENSIONS.Address1) + '</td></tr>')
                    ELSE
                        Body += ('<tr><td><b> Address </b></td><td>' + ' ' + '</td></tr>');
                    //Added by Vishnu Priya to include the address also in DC Mails on 04-02-2020
                    Body += ('</table><br>');
                    Body += ('<br>');
                    Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th><b>Item no.</b> </th><th>Item Description </th> <th>Quantity</th><TH>Non-Returnable</TH></tr>');
                    DCL.RESET;
                    DCL.SETFILTER(DCL."Document No.", Dchdr."No.");
                    IF DCL.FINDSET THEN
                        REPEAT
                            Body += ('<tr><td>' + DCL."No." + '</td><td>' + DCL.Description + '</td><TD>' + FORMAT(DCL.Quantity) + '</TD><TD>' + FORMAT(DCL."Non-Returnable") + '</TD></tr>');
                        UNTIL DCL.NEXT = 0;
                    Body += ('</TABLE>');

                    Body += ('<BR><p align ="left"> Regards,<br>ERP Team </p>');
                    Body += ('<br><p align = "center">::::Note: Auto Generated mail from ERP:::: </b></P></div></body></html>');


                    /* DCMail.AddAttachment(Attachment1, '');//EFFUPG Added ('')
                    DCMail.Send; */ //B2B UPG
                    EmailMessage.AddAttachment(Attachment1, '', '');
                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                    IF docnum <> '' THEN
                        Dchdr."Docket No" := docnum
                    ELSE
                        Dchdr."Docket No" := 'NOT AVAILABLE';
                    Dchdr."Courier Agency Name" := Courier;
                    Dchdr.sendmail := TRUE;
                    Dchdr.MODIFY(TRUE);
                    //END;
                END;
            //END;
            UNTIL Dchdr.NEXT = 0;
        MESSAGE('DC MAILS SUCCESSFULLY SENT');

    end;



}

