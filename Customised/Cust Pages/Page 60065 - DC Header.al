page 60065 "DC Header"
{
    // version B2B1.0,Rev01

    PageType = Document;
    SourceTable = "DC Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    Description = '<> ';
                    ApplicationArea = All;
                }
                field("From Date"; Rec."From Date")
                {
                    Caption = 'From Date *';
                    ApplicationArea = All;
                }
                field(Reciver; Rec.Reciver)
                {
                    Caption = 'Receiver';
                    //LookupPageID = 59;        //Removed in Nav
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    var
                        User1: Record "User Setup";
                    begin
                        User1.RESET;
                        //User1.Setfilter(User1."User Name",Reciver);
                        IF PAGE.RUNMODAL(9800, User1) = ACTION::LookupOK THEN BEGIN
                            Rec.Reciver := User1."User ID";
                            Rec."Reciver Name" := User1."User ID";
                        END;
                    end;
                }
                field(Receptionist; Rec.Receptionist)
                {
                    ApplicationArea = All;
                }
                field(Indented; Rec.Indented)
                {
                    //LookupPageID = 59;  //Removed in Nav
                    ApplicationArea = All;
                }
                field(StoreIncharge; Rec.StoreIncharge)
                {
                    ApplicationArea = All;
                }
                field("L.R Number"; Rec."L.R Number")
                {
                    ApplicationArea = All;
                }
                field(ModOfTrnsprt; Rec.ModOfTrnsprt)
                {
                    Caption = 'Mode Of Transport *';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Rec."Mode Of Transport" := FORMAT(Rec.ModOfTrnsprt);
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'Customer No. *';
                    ApplicationArea = All;

                    trigger OnValidate();
                    var
                        Cust: Record Customer;
                        Vend: Record Vendor;
                        EMP: Record Employee;
                    begin
                        CASE FORMAT(Rec.Type) OF
                            '0':
                                BEGIN
                                    Cust.RESET;
                                    Cust.SETFILTER(Cust."No.", Rec."Customer No.");
                                    IF Cust.FINDFIRST THEN BEGIN
                                        Rec."Sell-to Customer Name" := Cust.Name;
                                        Rec.MODIFY;
                                    END;
                                END;

                            '1':
                                BEGIN
                                    Vend.RESET;
                                    Vend.SETFILTER(Vend."No.", Rec."Customer No.");
                                    IF Vend.FINDFIRST THEN BEGIN
                                        Rec."Sell-to Customer Name" := Vend.Name;
                                        Rec.MODIFY;
                                    END;
                                END;

                            '2':
                                BEGIN
                                    EMP.RESET;
                                    EMP.SETFILTER(EMP."No.", Rec."Customer No.");
                                    IF EMP.FINDFIRST THEN BEGIN
                                        Rec."Sell-to Customer Name" := EMP."Job Title";
                                        Rec.MODIFY;
                                    END;
                                END;
                            'Customer':
                                BEGIN
                                    Cust.RESET;
                                    Cust.SETFILTER(Cust."No.", Rec."Customer No.");
                                    IF Cust.FINDFIRST THEN BEGIN
                                        Rec."Sell-to Customer Name" := Cust.Name;
                                        Rec.MODIFY;
                                    END;
                                END;

                            'Vendor':
                                BEGIN
                                    Vend.RESET;
                                    Vend.SETFILTER(Vend."No.", Rec."Customer No.");
                                    IF Vend.FINDFIRST THEN BEGIN
                                        Rec."Sell-to Customer Name" := Vend.Name;
                                        Rec.MODIFY;
                                    END;
                                END;

                            'Site':
                                BEGIN
                                    EMP.RESET;
                                    EMP.SETFILTER(EMP."No.", Rec."Customer No.");
                                    IF EMP.FINDFIRST THEN BEGIN
                                        Rec."Sell-to Customer Name" := EMP."Job Title";
                                        Rec.MODIFY;
                                    END;
                                END;

                        END;
                    end;
                }
                field(sendmail; Rec.sendmail)
                {
                    Editable = false;
                    Visible = sendmailVisible;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        sendmailOnPush;
                    end;
                }
                field(SessionCode; Rec.SessionCode)
                {
                    ApplicationArea = All;
                }
                field("To Date"; Rec."To Date")
                {
                    Caption = 'To Date *';
                    ApplicationArea = All;
                }
                field(NonReturnable; Rec.NonReturnable)
                {
                    Caption = 'NonReturnable *';
                    ApplicationArea = All;
                }
                field("Reciver Name"; Rec."Reciver Name")
                {
                    ApplicationArea = All;
                }
                field("Receptionist Name"; Rec."Receptionist Name")
                {
                    ApplicationArea = All;
                }
                field("Indented Name"; Rec."Indented Name")
                {
                    ApplicationArea = All;
                }
                field("StoreIncharge Name"; Rec."StoreIncharge Name")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field(Returned; Rec.Returned)
                {
                    Caption = 'Returned *';
                    ApplicationArea = All;

                    trigger OnValidate();
                    VAR
                        DCL1: Record "DC Line";
                    begin
                        // Added by Pranavi on 15-11-2016
                        IF Rec.Returned = TRUE THEN BEGIN
                            DCL1.RESET;
                            DCL1.SETRANGE(DCL1."Document No.", Rec."No.");
                            DCL1.SETFILTER(DCL1.Quantity, '>%1', 0);
                            DCL1.SETRANGE(DCL1."Non-Returnable", FALSE);
                            IF DCL1.FINDSET THEN
                                REPEAT
                                        IF DCL1."Returned Quantity" <> DCL1.Quantity THEN
                                            ERROR('Returned Quantity must be equal to Quantity in Line No.: ' + FORMAT(DCL1."Line No."));
                                UNTIL DCL1.NEXT = 0;
                            IF Rec."Returned Date" = 0D THEN
                                Rec."Returned Date" := TODAY();
                            DCL1.RESET;
                            DCL1.SETRANGE(DCL1."Document No.", Rec."No.");
                            DCL1.SETFILTER(DCL1.Quantity, '>%1', 0);
                            DCL1.SETRANGE(DCL1."Non-Returnable", FALSE);
                            IF DCL1.FINDSET THEN
                                    REPEAT
                                        IF DCL1."Returned Quantity" = DCL1.Quantity THEN BEGIN
                                            DCL1.Returned := TRUE;
                                            DCL1."Returned Date" := Rec."Returned Date";
                                            DCL1.MODIFY;
                                        END;
                                    UNTIL DCL1.NEXT = 0;
                        END
                        ELSE BEGIN
                            Rec."Returned Date" := 0D;
                        END;
                        // End by Pranavi
                    end;
                }
                field("Returned Date"; Rec."Returned Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Courier Agency Name"; Rec."Courier Agency Name")
                {
                    ApplicationArea = All;
                }
                field("Docket No"; Rec."Docket No")
                {
                    ApplicationArea = All;
                }
            }
            part(DCLine; "DC Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            group(Shipping)
            {
                Caption = 'Shipping';
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
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Country Code"; Rec."Ship-to Country Code")
                {
                    ApplicationArea = All;
                }
                field("<L.R Number2>"; Rec."L.R Number")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Number"; Rec."Vehicle Number")
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
                field("Posted Shipment No."; Rec."Posted Shipment No.")
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
                    var
                        USER: Record "User Setup";
                    begin
                        Rec.TESTFIELD(Status, Rec.Status::Open);
                        //TESTFIELD("Posted Shipment No.");
                        IF NOT (USERID IN ['EFFTRONICS\PARDHU', 'EFFTRONICS\BRAHMAIAH', 'EFFTRONICS\RENUKACH', 'EFFTRONICS\RAVIKIRAN']) THEN BEGIN
                            USER.RESET;
                            USER.SETFILTER(USER."User ID", USERSECURITYID);//B2BUpg
                            USER.SETFILTER(USER.levels, '%1', TRUE);//B2BUpg
                            IF NOT USER.FINDFIRST THEN
                                ERROR('U Dont Have Rights to Authorize');
                        END;
                        IF Rec."From Date" = 0D THEN
                            ERROR('Please Enter From Date!');
                        IF (Rec.NonReturnable = FALSE) AND (Rec."To Date" = 0D) THEN
                            ERROR('Please Enter To Date as there are Returnable Items!');
                        IF (Rec."Mode Of Transport" = '') OR (Rec."Mode Of Transport" = ' ') THEN
                            ERROR('Please Enter Mode Of Transport!');
                        IF (Rec."Customer No." = '') OR (Rec."Customer No." = ' ') THEN
                            ERROR('Please Enter Customer No.!');
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
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+p';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        dcheader: Record "DC Header";
                    begin
                        /*InspectDataSheet.SETRANGE("No.","No.");
                        REPORT.RUN(33000250,TRUE,FALSE,InspectDataSheet);*/
                        Rec.TESTFIELD(Status, Rec.Status::Released);
                        dcheader.SETRANGE(dcheader."No.", Rec."No.");
                        REPORT.RUN(33000895, TRUE, FALSE, dcheader);

                    end;
                }
                action(Reopen)
                {
                    Caption = 'Reopen';
                    Image = ReOpen;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        USER: record "User Setup";
                    begin
                        Rec.TESTFIELD(Status, Rec.Status::Released);
                        IF NOT (USERID IN ['EFFTRONICS\PARDHU', 'EFFTRONICS\BRAHMAIAH', 'EFFTRONICS\RENUKACH', 'EFFTRONICS\RAVIKIRAN']) THEN BEGIN
                            USER.RESET;
                            USER.SETFILTER(USER."User ID", USERSECURITYID);
                            USER.SETFILTER(USER.levels, '%1', TRUE);
                            IF NOT USER.FINDFIRST THEN
                                ERROR('U Dont Have Rights to reopen');
                        END;
                        IF NOT CONFIRM('Do you want to reopen the DC') THEN
                            EXIT;
                        Rec.Status := Rec.Status::Open;
                        Rec.Authorized := USERID;
                        Rec.MODIFY;
                        CurrPage.UPDATE;
                    end;
                }
                action("Request For Authorization")
                {
                    Caption = 'Request For Authorization';
                    Image = SendApprovalRequest;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        DCL: Record "DC Line";
                        Body: text;
                    begin

                        IF Rec.Status = Rec.Status::Released THEN
                            ERROR('Request Already in Released Mode');
                        Body := '';
                        "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                        IF "Mail-Id".FINDFIRST THEN BEGIN
                            IF "Mail-Id".MailID <> '' THEN
                                //"from Mail" := "Mail-Id".MailID
                                ERROR('You do not Have Mail id in ERP & Please Tell the ERP Administrator to Create your Mail id');
                        END
                        ELSE
                            // "from Mail" := 'erp@efftronics.com';

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
                            ERROR('There is no quantity to Request for Authorization in line: ' + FORMAT(DCL."Line No."));

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
                                //Mail_to := "Mail-Id".MailID
                                Recipients.Add("Mail-Id".MailID);
                            end
                            ELSE
                                ERROR('You are Specified UnAuthorized person & If any Modification Please Contact ERP Administrtor');
                        END;

                        IF Rec.Remarks = '' THEN
                            ERROR('Please Enter DC purpose in Remarks column');

                        Subject := 'ERP- DC Request for Authorisation' + FORMAT(Rec."No.");
                        Body += '<body><strong><form><table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
                        Body += 'border="1" align="center">';
                        Body += '<tr><td>Requested No</td><td>' + Rec."No." + '</td></tr><br>';
                        Body += '<tr><td>Requested User</td><td>' + Rec."User Id" + ':  ' + Rec."Reciver Name" + '</td></tr><br>';
                        //Body+='<tr><td>Project Name</td><td>'+"Proj Description"+'</td></tr>';
                        Body += '<tr><td bgcolor="green">'; //#009900

                        //mnraju
                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        IF UserSetup.FINDFIRST THEN BEGIN
                            CurrentUserID := UserSetup."Current UserId";
                        END;
                        //mnraju

                        Body += '<a Href="http://192.168.50.155:5556/erp_reports/Mat_Auth.aspx?val1=' + FORMAT(Rec."No.") + '&val2=' + FORMAT(CurrentUserID);

                        //mnraju
                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", Rec.Indented);
                        IF UserSetup.FINDFIRST THEN BEGIN
                            AuthorizedID := UserSetup."Current UserId";
                        END;
                        //mnraju

                        Body += '&val3=' + FORMAT(AuthorizedID);
                        Body += '&val4=1';
                        Body += '&val5=' /* + Mail_to */;
                        Body += '&val6=' /* + "from Mail" */;
                        Body += '&val7=Accepted"target="_blank">';
                        Body += '<font face="arial" color="#ffffff">ACCEPT</font></a>';
                        Body += '</td><td bgcolor="red">';
                        Body += '<a Href="http://192.168.50.155:5556/erp_reports/Mat_Auth.aspx?val1=' + FORMAT(Rec."No.");
                        Body += '&val2=' + FORMAT(CurrentUserID);
                        Body += '&val3=' + FORMAT(AuthorizedID);
                        Body += '&val4=0';
                        Body += '&val5=' /* + Mail_to */;
                        Body += '&val6=' /* + "from Mail" */;
                        Body += '&val7=Rejected';
                        Body += '"target="_blank">';
                        Body += '<font face="arial" color="#ffffff">REJECT</font></a></td></tr>';
                        Body += '</table></form></font></strong></body>';
                        dcheader.SETRANGE(dcheader."No.", Rec."No.");
                        IF dcheader.FINDFIRST THEN
                            //REPORT.RUNFALSE,FALSE,dcheader);
                            REPORT.SAVEASPDF(33000896, '\\erpserver\ErpAttachments\ErpAttachments1\' + CONVERT(Rec."No.") + '.pdf', dcheader);
                        //  Attachment := '\\erpserver\ErpAttachments\ErpAttachments1\' + CONVERT(Rec."No.") + '.pdf';
                        /* SMTP_MAIL.CreateMessage("Mail-Id"."User Name", 'erp@efftronics.com', Mail_to, Subject, Body, TRUE);
                        SMTP_MAIL.AddAttachment(Attachment, '');//EFFUPG Added ('')
                        SMTP_MAIL.Send; */
                        EmailMessage.Create(Recipients, Subject, Body, true);
                        EmailMessage.AddAttachment(Attachment, '', '');
                        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                        MESSAGE('Mail Has been Sent');

                        //B2B UPG >>>
                        /* IF Rec.Status = Rec.Status::Released THEN
                            ERROR('Request Already in Released Mode');
                        Body := '';
                        "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                        IF "Mail-Id".FINDFIRST THEN BEGIN
                            IF "Mail-Id".MailID <> '' THEN
                                "from Mail" := "Mail-Id".MailID
                            ELSE
                                ERROR('You do not Have Mail id in ERP & Please Tell the ERP Administrator to Create your Mail id');
                        END
                        ELSE
                            "from Mail" := 'erp@efftronics.com';

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
                            ERROR('There is no quantity to Request for Authorization in line: ' + FORMAT(DCL."Line No."));

                        DCL.RESET;
                        DCL.SETFILTER(DCL."Document No.", Rec."No.");
                        DCL.SETFILTER(DCL.Description, '<>%1', '');
                        DCL.SETFILTER(DCL.Quantity, '%1', 0);
                        IF DCL.FINDFIRST THEN
                            ERROR('Enter Quantity in Line no %1', DCL."Line No.");

                        "Mail-Id".RESET;
                        "Mail-Id".SETRANGE("Mail-Id"."User Name", Rec.Indented);
                        IF "Mail-Id".FINDFIRST THEN BEGIN
                            IF "Mail-Id".levels = TRUE THEN
                                Mail_to := "Mail-Id".MailID
                            ELSE
                                ERROR('You are Specified UnAuthorized person & If any Modification Please Contact ERP Administrtor');
                        END;

                        IF Rec.Remarks = '' THEN
                            ERROR('Please Enter DC purpose in Remarks column');

                        Subject := 'ERP- DC Request for Authorisation' + FORMAT(Rec."No.");
                        Body += '<body><strong><form><table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
                        Body += 'border="1" align="center">';
                        Body += '<tr><td>Requested No</td><td>' + Rec."No." + '</td></tr><br>';
                        Body += '<tr><td>Requested User</td><td>' + Rec."User Id" + ':  ' + Rec."Reciver Name" + '</td></tr><br>';
                        //Body+='<tr><td>Project Name</td><td>'+"Proj Description"+'</td></tr>';
                        Body += '<tr><td bgcolor="green">'; //#009900

                        //mnraju
                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        IF UserSetup.FINDFIRST THEN BEGIN
                            CurrentUserID := UserSetup."Current UserId";
                        END;
                        //mnraju

                        Body += '<a Href="http://192.168.50.155:5556/erp_reports/Mat_Auth.aspx?val1=' + FORMAT(Rec."No.") + '&val2=' + FORMAT(CurrentUserID);

                        //mnraju
                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", Rec.Indented);
                        IF UserSetup.FINDFIRST THEN BEGIN
                            AuthorizedID := UserSetup."Current UserId";
                        END;
                        //mnraju

                        Body += '&val3=' + FORMAT(AuthorizedID);
                        Body += '&val4=1';
                        Body += '&val5=' + Mail_to;
                        Body += '&val6=' + "from Mail";
                        Body += '&val7=Accepted"target="_blank">';
                        Body += '<font face="arial" color="#ffffff">ACCEPT</font></a>';
                        Body += '</td><td bgcolor="red">';
                        Body += '<a Href="http://192.168.50.155:5556/erp_reports/Mat_Auth.aspx?val1=' + FORMAT(Rec."No.");
                        Body += '&val2=' + FORMAT(CurrentUserID);
                        Body += '&val3=' + FORMAT(AuthorizedID);
                        Body += '&val4=0';
                        Body += '&val5=' + Mail_to;
                        Body += '&val6=' + "from Mail";
                        Body += '&val7=Rejected';
                        Body += '"target="_blank">';
                        Body += '<font face="arial" color="#ffffff">REJECT</font></a></td></tr>';
                        Body += '</table></form></font></strong></body>';
                        dcheader.SETRANGE(dcheader."No.", Rec."No.");
                        IF dcheader.FINDFIRST THEN
                            //REPORT.RUNFALSE,FALSE,dcheader);
                            REPORT.SAVEASPDF(33000896, '\\erpserver\ErpAttachments\ErpAttachments1\' + CONVERT(Rec."No.") + '.pdf', dcheader);
                        Attachment := '\\erpserver\ErpAttachments\ErpAttachments1\' + CONVERT(Rec."No.") + '.pdf';
                        SMTP_MAIL.CreateMessage("Mail-Id"."User Name", 'erp@efftronics.com', Mail_to, Subject, Body, TRUE);
                        SMTP_MAIL.AddAttachment(Attachment, '');//EFFUPG Added ('')
                        SMTP_MAIL.Send; */
                        // B2B UPG <<<
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
                    // IF Rec.Status <> Rec.Status::Released THEN BEGIN
                    //     IF ISCLEAR(SQLConnection) THEN
                    //         CREATE(SQLConnection, FALSE, TRUE);// Rev01

                    //     IF ISCLEAR(RecordSet) THEN
                    //         CREATE(RecordSet, FALSE, TRUE);// Rev01

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
                END;
                        ERROR('The Request has Already in the Released Mode');
*/
                    //<< ORACLE UPG
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean;
    begin
        IF NOT (USERID IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\VISHNUPRIYA']) THEN
            ERROR('YOU DO NOT HAVE THE RIGHTS TO DELETE DC');
    end;

    trigger OnInit();
    begin
        sendmailVisible := FALSE;
        IF UPPERCASE(USERID) IN ['EFFTRONICS\PRANAVI', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\RATNA', 'EFFTRONICS\DMADHAVI'] THEN
            sendmailVisible := TRUE
        ELSE
            sendmailVisible := FALSE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        Rec.Type := Rec.Type::Site;
        IF UPPERCASE(USERID) IN ['EFFTRONICS\PARDHU', 'EFFTRONICS\BRAHMAIAH', 'EFFTRONICS\PHANI', 'EFFTRONICS\RENUKACH'] THEN
            Rec.Type := Rec.Type::Vendor;
    end;

    var

        dcheader: Record "DC Header";
        "Mail-Id": Record "User Setup";
        "from Mail": Text[150];
        "to mail": Text[1000];
        Mail_Subject: Text[1000];
        Mail_Body: Text[1000];
        //mail: Codeunit Mail;
        newline: Char;
        //SMTP_MAIL: Codeunit "SMTP Mail";
        Attachment1: Text[1000];

        Mail_to: Text[1000];

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
        /*  SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
         RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset"; */
        //<< ORACLE UPG
        UserSetup: Record "User Setup";
        CurrentUserID: Text[50];
        AuthorizedID: Text[50];
        User1: Record User;
        DCL1: Record "DC Line";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;


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
        //B2B UPG >>>
        /* IF Rec.sendmail THEN BEGIN
            newline := 10;
            Mail_Subject := 'ERP- DC Information  ' + Rec."No.";
            Mail_Body := 'DC Information     : ' + Rec."No.";
            Mail_Body += FORMAT(newline);
            Mail_Body += FORMAT(newline);
            Mail_Body += FORMAT(newline);
            Mail_Body += '***** Auto Mail Generated From ERP *****';
            "Mail-Id".SETRANGE("Mail-Id"."User Name", USERID);
            IF "Mail-Id".FINDFIRST THEN
                "from Mail" := "Mail-Id".MailID;

            "Mail-Id".RESET;
            "Mail-Id".SETFILTER("Mail-Id"."User Name", Rec.Indented);
            IF "Mail-Id".FINDFIRST THEN
                "to mail" := 'ratna@efftronics.com,' + "Mail-Id".MailID;

            USER.RESET;
            USER.SETFILTER(USER."User Name", Rec.Reciver);
            IF USER.FINDFIRST THEN BEGIN
                IF USER.EmployeeID <> '' THEN BEGIN
                    EMP.RESET;
                    EMP.SETFILTER(EMP."No.", USER.EmployeeID);
                    EMP.SETFILTER(EMP."E-Mail", '<>%1', '');
                    IF EMP.FINDFIRST THEN BEGIN
                        "to mail" += ',' + EMP."E-Mail";
                    END;
                END;
            END;
            dcheader.RESET;
            dcheader.SETFILTER(dcheader."No.", Rec."No.");
            IF dcheader.FINDFIRST THEN BEGIN
                Fname := '\\erpserver\ErpAttachments\dcdetails' + COPYSTR(Rec."No.", 15, 3) + '.pdf';
                REPORT.SAVEASPDF(33000896, Fname, dcheader);
                Attachment1 := Fname;
            END;

            IF ("from Mail" <> '') AND ("to mail" <> '') THEN BEGIN
                "from Mail" := 'erp@efftronics.com';
                SMTP_MAIL.CreateMessage('EFF', "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);
                SMTP_MAIL.AddAttachment(Attachment1, '');//EFFUPG Added ('')
                SMTP_MAIL.Send;
            END;
        END; */
        //B2B UPG <<<

        IF Rec.sendmail THEN BEGIN
            newline := 10;
            Mail_Subject := 'ERP- DC Information  ' + Rec."No.";
            Mail_Body := 'DC Information     : ' + Rec."No.";
            Mail_Body += FORMAT(newline);
            Mail_Body += FORMAT(newline);
            Mail_Body += FORMAT(newline);
            Mail_Body += '***** Auto Mail Generated From ERP *****';
            "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
            IF "Mail-Id".FINDFIRST THEN
                //"from Mail" := "Mail-Id".MailID;

            "Mail-Id".RESET;
            "Mail-Id".SETFILTER("Mail-Id"."User ID", Rec.Indented);
            IF "Mail-Id".FINDFIRST THEN
                //"to mail" := 'ratna@efftronics.com,' + "Mail-Id".MailID;
                Recipients.Add('ratna@efftronics.com');
            Recipients.Add("Mail-Id".MailID);
            USER.RESET;
            USER.SETFILTER(USER."User ID", Rec.Reciver);
            IF USER.FINDFIRST THEN BEGIN
                IF USER.EmployeeID <> '' THEN BEGIN
                    EMP.RESET;
                    EMP.SETFILTER(EMP."No.", USER.EmployeeID);
                    EMP.SETFILTER(EMP."E-Mail", '<>%1', '');
                    IF EMP.FINDFIRST THEN BEGIN
                        //"to mail" += ',' + EMP."E-Mail";
                        Recipients.Add(EMP."E-Mail");
                    END;
                END;
            END;
            dcheader.RESET;
            dcheader.SETFILTER(dcheader."No.", Rec."No.");
            IF dcheader.FINDFIRST THEN BEGIN
                Fname := '\\erpserver\ErpAttachments\dcdetails' + COPYSTR(Rec."No.", 15, 3) + '.pdf';
                REPORT.SAVEASPDF(33000896, Fname, dcheader);
                Attachment1 := Fname;
            END;

            /* IF ("from Mail" <> '') AND ("to mail" <> '') THEN BEGIN
                "from Mail" := 'erp@efftronics.com';
                SMTP_MAIL.CreateMessage('EFF', "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);
                SMTP_MAIL.AddAttachment(Attachment1, '');//EFFUPG Added ('')
                SMTP_MAIL.Send;
            END; */
            EmailMessage.Create(Recipients, Mail_Subject, Mail_Body, FALSE);
            EmailMessage.AddAttachment(Attachment1, '', '');
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        END;

    end;

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

