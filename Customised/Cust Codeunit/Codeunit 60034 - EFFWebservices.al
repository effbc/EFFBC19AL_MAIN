codeunit 60034 "EFF Web services"
{

    trigger OnRun()
    begin
        //CertifyBom('ATPC512D001','MNRAJU');

        //BOM_Reject('ECPBPCB01989');
        //Post_Action_Auto_Scheduled;
        GLS.GET;
        IF GLS."Session Killer Time Setup" = 15 THEN
            ERROR('Value is already 15!')
        ELSE BEGIN
            GLS."Session Killer Time Setup" := 15;
            GLS.MODIFY;
        END;
    end;

    var
        i: Decimal;
        j: Decimal;
        SQLQuery: Text[1000];
        ConnectionOpen: Integer;
        RowCount: Integer;
        User: Record User;
        UserGvar: Record "User Setup";
        Mail_Body: Text[1024];
        Mail_From: Text[250];
        Mail_To: Text[250];
        //Mail: Codeunit "SMTP Mail";
        Subject: Text[250];
        Attachment: Text[100];
        //SMTP_Mail: Codeunit "SMTP Mail";
        GLS: Record "General Ledger Setup";
        ProdBOMHeader: Record "Production BOM Header";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipient: List of [Text];
        Body: Text;


    procedure Capitalize(inputstring: Text) outputstring: Text[250]
    begin
        //j:=10/0;
        //outputstring := UPPERCASE(USERID);
        outputstring := UPPERCASE(inputstring);
    end;


    procedure CertifyBom(BOM: Code[20]; Authorized_ID: Code[50])
    var
        PBH: Record "Production BOM Header";
    begin
        PBH.RESET;
        PBH.SETFILTER(PBH."No.", BOM);
        IF PBH.FINDFIRST THEN BEGIN
            PBH.Status := PBH.Status::Certified;
            PBH.CertifyStatus := 1;
            PBH.CertifyModDate := CURRENTDATETIME;
            PBH."Modified User ID" := Authorized_ID;
            PBH.ValidateStatus(Authorized_ID, BOM, PBH.Status::Certified);
            //Added by Rakesh to clear Certify field on
            PBH.ClearCertify(BOM);
        END
        ELSE BEGIN
        END;
    end;


    procedure AuthorizeMaterialReq(No: Code[20]; Status: Integer) Result: Integer
    var
        MihLRec: Record "Material Issues Header";
    begin
        Result := 0;
        MihLRec.RESET;
        IF MihLRec.GET(No) THEN BEGIN
            IF MihLRec.Status = MihLRec.Status::"Sent for Authorization" THEN BEGIN
                IF Status = 1 THEN BEGIN
                    MihLRec.VALIDATE(MihLRec.Status, MihLRec.Status::Released);
                    MihLRec.VALIDATE(MihLRec."Released Date", WORKDATE);
                    MihLRec."Released Time" := TIME + 19800000;
                    MihLRec.VALIDATE(MihLRec."Released By", MihLRec."Request for Authorization");
                    MihLRec.VALIDATE(MihLRec."Released DateTime", CREATEDATETIME(MihLRec."Released Date", MihLRec."Released Time"));

                    // MihLRec."Posting Date":=WORKDATE;
                    IF MihLRec."Authorized Date" = 0D THEN
                        MihLRec."Authorized Date" := WORKDATE;
                    MihLRec.MODIFY;
                    Result := 1;

                    // Added by Rakesh for mailing the Authorization status  on 2-Apr-14
                    // start

                    //B2B UPG >>>>
                    /* User.SETFILTER(User."User Name", MihLRec."User ID");
                    IF User.FINDFIRST THEN BEGIN
                        IF User.MailID <> '' THEN
                            Mail_To := User.MailID
                        ELSE
                            Mail_To := 'erp@efftronics.com';
                    END ELSE
                        Mail_To := 'erp@efftronics.com';
                    Mail_From := 'erp@efftronics.com';
                    Subject := 'Material Authorization';
                    Mail_Body := '<html><body><h4>Material Request: ' + No + ' Has been Authorized</h4></body></html>';
                    Mail.CreateMessage('ERP', Mail_From, Mail_To, Subject, Mail_Body, TRUE);
                    Mail.Send; */
                    //B2B UPG <<<<

                    UserGvar.SETFILTER(UserGvar."User ID", MihLRec."User ID");
                    IF User.FINDFIRST THEN BEGIN
                        IF UserGvar.MailID <> '' THEN begin
                            Recipient.Add(UserGvar.MailID);
                        end
                        ELSE
                            Recipient.Add('erp@efftronics.com');
                    END ELSE
                        Recipient.Add('erp@efftronics.com');
                    Subject := 'Material Authorization';
                    Mail_Body := '<html><body><h4>Material Request: ' + No + ' Has been Authorized</h4></body></html>';
                    EmailMessage.Create(Recipient, Subject, Mail_Body, true);
                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                END
                ELSE BEGIN
                    MihLRec.Status := MihLRec.Status::Rejected;
                    MihLRec.MODIFY;
                    /* User.SETFILTER(User."User Name",MihLRec."User ID");
                    IF User.FINDFIRST THEN
                      Mail_To := User.MailID;
                    Mail_From := 'erp@efftronics.com';
                    Subject := 'Material Authorization';
                    Mail_Body := '<html><body><h4>Material Request: '+No+' has been Rejected</h4></body></html>';
                    Mail.CreateMessage('ERP',Mail_From,Mail_To,Subject,Mail_Body,TRUE);
                    Mail.Send; */  // Commented as rejection mail being sent from Web
                    Result := 4;
                END
            END
            ELSE
                IF MihLRec.Status = MihLRec.Status::Released THEN
                    Result := 2  //ERROR('The Request is in Released Mode')
                ELSE
                    IF MihLRec.Status = MihLRec.Status::Rejected THEN
                        Result := 3  //ERROR('The Request has Already in the Rejected Mode')
                    ELSE
                        IF MihLRec.Status = MihLRec.Status::Open THEN
                            Result := 6;  //ERROR('The Request has been modified')
        END
        ELSE
            Result := 5;

        // end by rakesh
        // >> Pranavi
        //STOPSESSION(SESSIONID,'Web Service session killing');
        // << Pranavi

    end;


    procedure Req_Status(No: Code[20]) Result: Integer
    var
        MihLRec: Record "Material Issues Header";
    begin
        // Added by Rakesh to get the status for Material Request on 9-Apr-14
        //begin
        Result := 0;
        MihLRec.RESET;
        IF MihLRec.GET(No) THEN BEGIN
            IF MihLRec.Status = MihLRec.Status::"Sent for Authorization" THEN
                Result := 1    //The Request is in Sent for Authorization Mode
            ELSE
                IF MihLRec.Status = MihLRec.Status::Released THEN
                    Result := 2   //The Request is in Released Mode
                ELSE
                    IF MihLRec.Status = MihLRec.Status::Rejected THEN
                        Result := 3   //The Request has Already in the Rejected Mode
                    ELSE
                        IF MihLRec.Status = MihLRec.Status::Open THEN
                            Result := 4;  //The Request has been modified
        END

        //end by Rakesh
    end;


    procedure BOM_Status(BOM: Code[20]) Result: Integer
    var
        PBH: Record "Production BOM Header";
    begin
        //Added by Rakesh to return BOM status on 11-Jul-14
        PBH.RESET;
        PBH.SETFILTER(PBH."No.", BOM);
        IF PBH.FINDFIRST THEN BEGIN
            IF PBH.Certify > 0 THEN
                // ADDED BY SUJANI ON 19-09-19
                /* CASE PBH.Certify OF
                   1:Result :=1;
                   2:Result :=2;
                   3:Result :=3;
                   4:Result :=4;
                   ELSE
                   END*/
            Result := PBH.Certify
            ELSE
                Result := 0;
        END;

    end;


    procedure BOM_Reject(BOM: Code[20])
    var
        PBH: Record "Production BOM Header";
    begin
        //Added by Rakesh to clear Certify field on reject by manager
        PBH.RESET;
        PBH.SETFILTER(PBH."No.", BOM);
        IF PBH.FINDFIRST THEN
            PBH.ClearCertify(BOM);
    end;


    procedure DayWiseMatIssuesStatus() Result: Integer
    var
        GLSetup: Record "General Ledger Setup";
    begin
        // Added by Pranavi on 21-Jan-2016 for Day Wise Material Issues Authorization
        GLSetup.RESET;
        GLSetup.GET();
        IF GLSetup."Day Wise Issues Status" = GLSetup."Day Wise Issues Status"::Applied THEN
            Result := 1     // Status is in Applied Mode
        ELSE
            IF GLSetup."Day Wise Issues Status" = GLSetup."Day Wise Issues Status"::Accepted THEN
                Result := 2     // Status is in Accepted
            ELSE
                IF GLSetup."Day Wise Issues Status" = GLSetup."Day Wise Issues Status"::Rejected THEN
                    Result := 3     // Status is in Rejected
                ELSE
                    IF GLSetup."Day Wise Issues Status" = GLSetup."Day Wise Issues Status"::Nothing THEN
                        Result := 4;    //   Status is modified
        // End by Pranavi
    end;

    //B2B UPG >>>>
    /* procedure AuthorizeDayWiseMatIssues(AcceptStatus: Integer; Mat_Req_Dt: Code[20]; Reply_To_ID: Code[30]) Result: Integer
    var
        GLSetup: Record "General Ledger Setup";
        MatRqDt: Date;
    begin
        // Added by Pranavi on 21-Jan-2016 for Day Wise Material Issues Authorization
        GLSetup.RESET;
        GLSetup.GET();
        EVALUATE(MatRqDt, Mat_Req_Dt);
        IF AcceptStatus = 1 THEN BEGIN
            GLSetup."Day Wise Issues Status" := GLSetup."Day Wise Issues Status"::Accepted;
            GLSetup.MODIFY;
            Result := 1;
            Mail_From := 'erp@efftronics.com';
            Mail_To := Reply_To_ID;
            IF Mail_To = '' THEN
                Mail_To := 'store@efftronics.com'
            ELSE
                Mail_To += ',store@efftronics.com';
            Mail_To := 'erp@efftronics.com';
            Subject := 'Authorization for Day Wise Material Issues on ' + FORMAT(Mat_Req_Dt, 0, '<Day,2>-<Month Text,3>-<Year>');
            Mail_Body := '<html><body><h4>Request for Day Wise Material Issues on : ' + FORMAT(Mat_Req_Dt, 0, '<Day,2>-<Month Text,3>-<Year>') + ' Has been Authorized</h4></body></html>';
            Mail.CreateMessage('ERP', Mail_From, Mail_To, Subject, Mail_Body, TRUE);
            Mail.Send;
        END
        ELSE
            IF AcceptStatus = 0 THEN BEGIN
                GLSetup."Day Wise Issues Status" := GLSetup."Day Wise Issues Status"::Rejected;
                GLSetup.MODIFY;
                Result := 0;
            END;
        // End by Pranavi
    end; */
    //B2B UPG <<<<

    procedure AuthorizeDayWiseMatIssues(AcceptStatus: Integer; Mat_Req_Dt: Code[20]; Reply_To_ID: Code[30]) Result: Integer
    var
        GLSetup: Record "General Ledger Setup";
        MatRqDt: Date;
    begin
        // Added by Pranavi on 21-Jan-2016 for Day Wise Material Issues Authorization
        GLSetup.RESET;
        GLSetup.GET();
        EVALUATE(MatRqDt, Mat_Req_Dt);
        IF AcceptStatus = 1 THEN BEGIN
            GLSetup."Day Wise Issues Status" := GLSetup."Day Wise Issues Status"::Accepted;
            GLSetup.MODIFY;
            Result := 1;
            Recipient.Add(Reply_To_ID);
            IF Mail_To = '' THEN begin
                Recipient.Add('store@efftronics.com');
            end
            ELSE
                Recipient.Add('');
            Recipient.Add('store@efftronics.com');
            Recipient.Add('erp@efftronics.com');
            Subject := 'Authorization for Day Wise Material Issues on ' + FORMAT(Mat_Req_Dt, 0, '<Day,2>-<Month Text,3>-<Year>');
            Mail_Body := '<html><body><h4>Request for Day Wise Material Issues on : ' + FORMAT(Mat_Req_Dt, 0, '<Day,2>-<Month Text,3>-<Year>') + ' Has been Authorized</h4></body></html>';
            EmailMessage.Create(Recipient, Subject, Mail_Body, true);
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        END
        ELSE
            IF AcceptStatus = 0 THEN BEGIN
                GLSetup."Day Wise Issues Status" := GLSetup."Day Wise Issues Status"::Rejected;
                GLSetup.MODIFY;
                Result := 0;
            END;
        // End by Pranavi
    end;


    procedure TestProcedure()
    var
        //AP: Codeunit ApplicationManagement;
        Session: Record Session;
        GlSetup: Record "General Ledger Setup";
        MilliSeconds: Integer;
    begin
        //AP.SessionKiller;
        /*
        Session.RESET;
        IF Session.FINDLAST THEN
          STARTSESSION(Session."Connection ID",60034);
        */

        GLS.GET;
        IF GLS."Session Killer Time Setup" = 15 THEN
            ERROR('Value is already 15!')
        ELSE BEGIN
            GLS."Session Killer Time Setup" := 15;
            GLS.MODIFY;
        END;

        //Post_Action_Auto_Scheduled;

    end;


    procedure POST_MATERIAL_ISSUES_Auto_Scheduled("PROD. ORDER": Code[20])
    var
        MATERIAL_ISSUES_HEAER: Record "Material Issues Header";
        Issue_Post: Codeunit "MaterialIssueOrde-Post Receipt";
        Mat_Issue_sLine: Record "Material Issues Line";
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
            UNTIL MATERIAL_ISSUES_HEAER.NEXT = 0;
        COMMIT; // pranavi on 31-01-2017
    end;


    procedure Post_Action_Auto_Scheduled()
    var
        //ProdWiseIssues: Page "Product wise Issues";
        GL: Record "General Ledger Setup";
        PO: Record "Production Order";
        PO_SHORTAGEITEMS: Record "Production Order Shortage Item";
        PO_FORM: Page "Released Production Order";
        POrdersList: Text;
        POrdersList1: Text;
        OrderNo: Text;
        CustName: Text;
        No: Text;
        ItemDesc: Text;
        ToBeshipedQty: Decimal;
        OrderDate: Date;
        No_of_Units: Decimal;
        ITEM: Record Item;
        Mail_Send_To: Text[250];
        From_Mail: Text[30];
        To_mail: Text[250];
        Day_wise_Details: Record "DAY WISE DETAILS";
        Body: Text;
        PrevItem: Code[50];
        PrevOrder: Code[50];
        ItemPrdQty: Decimal;
        SL: Record "Sales Line";
        SH: Record "Sales Header";
        pmih: Record "Posted Material Issues Header";
        POrdr: Record "Production Order";
        PrevPSDate: Date;
        PrdOrdr: Record "Production Order";
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
        //B2B UPG >>>>
        /* //Added by Pranavi on 14-09-2015
         IF POrdersList <> '' THEN BEGIN
             POrdersList1 := COPYSTR(POrdersList, 1, STRLEN(POrdersList) - 1);
             Body := '';
             PrevItem := '';
             PrevOrder := '';
             ItemPrdQty := 0;
             RowCount := 0;
             From_Mail := 'noreply@efftronics.com';
             To_mail := 'marketing@efftronics.com,erp@efftronics.com,projectmanagement@efftronics.com';
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
             SMTP_Mail.AppendBody('<th>Order Date</th><th>Prod Start Date</th></tr>');
             PrdOrdr.RESET;
             PrdOrdr.SETCURRENTKEY("Sales Order No.", "Source No.", "Prod Start date");
             PrdOrdr.SETFILTER(PrdOrdr.Status, '%1', PrdOrdr.Status::Released);
             //PrdOrdr.SETFILTER(PrdOrdr."Suppose to Plan",'%1',TRUE);
             PrdOrdr.SETFILTER(PrdOrdr."No.", POrdersList1);
             PrdOrdr.SETFILTER(PrdOrdr."Prod Start date", '>%1', 0D);*/
        //PrdOrdr.SETFILTER(PrdOrdr."Sales Order No.", '%1|%2', '*/L*', '*/T*');
        /*PrdOrdr.SETFILTER(PrdOrdr."Item Sub Group Code", 'LED LIGHT');
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
                                        SMTP_Mail.AppendBody('<tr><td>' + SH."No." + '</td><td>' + SH."Sell-to Customer Name" + '</td><td>' + SL."No." + '</td><td>' + SL.Description + '</td><td  align ="right">' + FORMAT(SL."Qty. to Ship") + '</td>');
                                        SMTP_Mail.AppendBody('<td align ="right">' + FORMAT(ItemPrdQty) + '</td><td>' + FORMAT(SH."Order Date") + '</td><td>' + FORMAT(PrdOrdr."Prod Start date") + '</td></tr>');
                                        ItemPrdQty := 0;
                                        RowCount := RowCount + 1;
                                    END;
                                END;
                            END
                            ELSE BEGIN
                                IF (PrevOrder <> PrdOrdr."Sales Order No.") AND (PrevOrder <> '') THEN BEGIN
                                    IF SH."No." <> 'EFF/08-09/AUG/087' THEN BEGIN
                                        IF ItemPrdQty > 0 THEN BEGIN
                                            SMTP_Mail.AppendBody('<tr><td>' + SH."No." + '</td><td>' + SH."Sell-to Customer Name" + '</td><td>' + SL."No." + '</td><td>' + SL.Description + '</td><td  align ="right">' + FORMAT(SL."Qty. to Ship") + '</td>');
                                            SMTP_Mail.AppendBody('<td align ="right">' + FORMAT(ItemPrdQty) + '</td><td>' + FORMAT(SH."Order Date") + '</td><td>' + FORMAT(PrevPSDate) + '</td></tr>');
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
                SMTP_Mail.AppendBody('<tr><td>' + OrderNo + '</td><td>' + CustName + '</td><td>' + No + '</td><td>' + ItemDesc + '</td><td  align ="right">' + FORMAT(ToBeshipedQty) + '</td>');
                SMTP_Mail.AppendBody('<td align ="right">' + FORMAT(ItemPrdQty) + '</td><td>' + FORMAT(OrderDate) + '</td><td>' + FORMAT(PrevPSDate) + '</td></tr>');
                RowCount := RowCount + 1;
            END;
        END;
        SMTP_Mail.AppendBody('</table><br><p align ="left"> Regards,<br>ERP Team </p>');
        SMTP_Mail.AppendBody('<br><p align = "center">:: Note: Auto Generated mail from ERP :: </P></div></body></html>');
        IF RowCount > 0 THEN
            SMTP_Mail.Send;
    END;
    //end by pranavi
    */ //B2B UPG <<<<

        //Added by Pranavi on 14-09-2015
        IF POrdersList <> '' THEN BEGIN
            POrdersList1 := COPYSTR(POrdersList, 1, STRLEN(POrdersList) - 1);
            Body := '';
            PrevItem := '';
            PrevOrder := '';
            ItemPrdQty := 0;
            RowCount := 0;
            Recipient.Add('marketing@efftronics.com');
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
                    Body += ('<tr><td>' + OrderNo + '</td><td>' + CustName + '</td><td>' + No + '</td><td>' + ItemDesc + '</td><td  align ="right">' + FORMAT(ToBeshipedQty) + '</td>');
                    Body += ('<td align ="right">' + FORMAT(ItemPrdQty) + '</td><td>' + FORMAT(OrderDate) + '</td><td>' + FORMAT(PrevPSDate) + '</td></tr>');
                    RowCount := RowCount + 1;
                END;
            END;
            Body += ('</table><br><p align ="left"> Regards,<br>ERP Team </p>');
            Body += ('<br><p align = "center">:: Note: Auto Generated mail from ERP :: </P></div></body></html>');
            IF RowCount > 0 THEN
                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        END;
        //end by pranavi
    end;


    procedure CF_BPV_Entries(CheckNo: Code[10]; CheckDate: Code[15]; Amount: Integer; Description: Text; VendorNo: Code[20]; ExtDocNo: Code[98]; PaymentType: Code[10]; Bank_Charges: Integer; Serive_Tax_Amt: Integer; SBCess_Amt: Integer; KKCess_Amt: Integer)
    var
        GenJrnlLine: Record "Gen. Journal Line";
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlBatch: Record "Gen. Journal Batch";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DocNo: Code[20];
        LastGenJrnlLine: Record "Gen. Journal Line";
        Last_Line_No: Integer;
        d: Integer;
        m: Integer;
        y: Integer;
        Temp_CheckDate: Date;
        //ServTaxSetup: Record "Service Tax Setup";
        ServiceTaxPerctg: Decimal;
        SBCess: Decimal;
        KKCess: Decimal;
    begin
        //>>Vendor Recard Entry
        Last_Line_No := 10000;
        LastGenJrnlLine.RESET;
        LastGenJrnlLine.SETRANGE(LastGenJrnlLine."Journal Template Name", 'GENERAL');
        LastGenJrnlLine.SETRANGE(LastGenJrnlLine."Journal Batch Name", 'BPV_CF');
        IF LastGenJrnlLine.FINDLAST THEN BEGIN
            DocNo := INCSTR(LastGenJrnlLine."Document No.");
            Last_Line_No := LastGenJrnlLine."Line No." + 10000;
        END
        ELSE BEGIN
            GenJnlTemplate.GET('GENERAL');
            GenJnlBatch.GET('GENERAL', 'BPV_CF');
            IF GenJnlBatch."No. Series" <> '' THEN BEGIN
                CLEAR(NoSeriesMgt);
                DocNo := NoSeriesMgt.TryGetNextNo(GenJnlBatch."No. Series", TODAY);
            END;
        END;
        /*
        LastGenJrnlLine.RESET;
        LastGenJrnlLine.SETRANGE(LastGenJrnlLine."Journal Template Name",'GENERAL');
        LastGenJrnlLine.SETRANGE(LastGenJrnlLine."Journal Batch Name",'BPV_CF');
        LastGenJrnlLine.SETRANGE(LastGenJrnlLine."Document No.",DocNo);
        IF LastGenJrnlLine.FINDLAST THEN
          Last_Line_No := LastGenJrnlLine."Line No."+10000;
        */
        EVALUATE(d, COPYSTR(CheckDate, 1, 2));
        EVALUATE(m, COPYSTR(CheckDate, 4, 2));
        EVALUATE(y, COPYSTR(CheckDate, 7, 4));
        Temp_CheckDate := DMY2DATE(d, m, y);
        GenJrnlLine.INIT;
        GenJrnlLine."Journal Template Name" := 'GENERAL';
        GenJrnlLine."Journal Batch Name" := 'BPV_CF';
        GenJrnlLine."Document No." := DocNo;
        GenJrnlLine."Line No." := Last_Line_No;
        GenJrnlLine."Account Type" := GenJrnlLine."Account Type"::Vendor;
        GenJrnlLine."Payment Type" := GenJrnlLine."Payment Type"::Payment;
        GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::Cheque;
        CASE PaymentType OF
            'Cheque':
                GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::Cheque;
            'DD':
                GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::DD;
            'FDR':
                GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::FDR;
            'RTGS':
                GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::RTGS;
            'Cash':
                GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::Cash;
            'FTT':
                GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::FTT;
            'Credit-Card':
                GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::"Credit-Card";
        END;
        GenJrnlLine.VALIDATE("Account No.", VendorNo);
        GenJrnlLine.VALIDATE("Posting Date", Temp_CheckDate);
        GenJrnlLine."Document Date" := Temp_CheckDate;
        GenJrnlLine."Debit Amount" := Amount;
        GenJrnlLine.Amount := Amount;
        GenJrnlLine."Cheque Date" := Temp_CheckDate;
        GenJrnlLine."Cheque No." := CheckNo;
        GenJrnlLine.Description := Description;
        GenJrnlLine."External Document No." := ExtDocNo;
        GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", 'PRD-0010');
        GenJrnlLine.INSERT;
        //<<Vendor Recard Entry
        //>>Bank Charges Entry Recards Entry
        IF Bank_Charges > 0 THEN BEGIN
            Last_Line_No += 10000;
            GenJrnlLine.INIT;
            GenJrnlLine."Journal Template Name" := 'GENERAL';
            GenJrnlLine."Journal Batch Name" := 'BPV_CF';
            GenJrnlLine."Document No." := DocNo;
            GenJrnlLine."Line No." := Last_Line_No;
            GenJrnlLine."Account Type" := GenJrnlLine."Account Type"::"G/L Account";
            GenJrnlLine."Payment Type" := GenJrnlLine."Payment Type"::Payment;
            GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::Cheque;
            CASE PaymentType OF
                'Cheque':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::Cheque;
                'DD':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::DD;
                'FDR':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::FDR;
                'RTGS':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::RTGS;
                'Cash':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::Cash;
                'FTT':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::FTT;
                'Credit-Card':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::"Credit-Card";
            END;
            GenJrnlLine.VALIDATE("Account No.", '67600');
            GenJrnlLine.VALIDATE("Posting Date", Temp_CheckDate);
            GenJrnlLine."Document Date" := Temp_CheckDate;
            GenJrnlLine."Debit Amount" := Bank_Charges;
            GenJrnlLine.Amount := Bank_Charges;
            GenJrnlLine."Cheque Date" := Temp_CheckDate;
            GenJrnlLine."Cheque No." := CheckNo;
            GenJrnlLine.Description := Description;
            GenJrnlLine."External Document No." := ExtDocNo;
            GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", 'PRD-0010');
            GenJrnlLine.INSERT;
        END;
        //<<Bank Charges Entry Recards Entry
        //>>Service Taxex Entry Recards Entry
        IF Serive_Tax_Amt > 0 THEN BEGIN
            Last_Line_No += 10000;
            /*
            ServTaxSetup.RESET;
            ServTaxSetup.SETRANGE(ServTaxSetup.Code,'EXP SERVICES');
            ServTaxSetup.SETFILTER(ServTaxSetup."From Date",'>=%1',TODAY);
            IF ServTaxSetup.FINDLAST THEN
            BEGIN
              ServiceTaxPerctg := ServTaxSetup."Service Tax %";
              SBCess := ServTaxSetup."SB Cess%";
              KKCess := ServTaxSetup."KK Cess%";
            END ELSE
            BEGIN
              ServiceTaxPerctg := 14.5;
              SBCess := 0.5;
              KKCess := 0.5;
            END;
            */
            //>>Service Tax Entry Recard Entry
            GenJrnlLine.INIT;
            GenJrnlLine."Journal Template Name" := 'GENERAL';
            GenJrnlLine."Journal Batch Name" := 'BPV_CF';
            GenJrnlLine."Document No." := DocNo;
            GenJrnlLine."Line No." := Last_Line_No;
            GenJrnlLine."Account Type" := GenJrnlLine."Account Type"::"G/L Account";
            GenJrnlLine."Payment Type" := GenJrnlLine."Payment Type"::Payment;
            GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::Cheque;
            CASE PaymentType OF
                'Cheque':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::Cheque;
                'DD':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::DD;
                'FRD':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::FDR;
                'RTGS':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::RTGS;
                'Cash':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::Cash;
                'FTT':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::FTT;
                'Credit-Card':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::"Credit-Card";
            END;
            GenJrnlLine."Account No." := '33809';
            GenJrnlLine.VALIDATE("Posting Date", Temp_CheckDate);
            GenJrnlLine."Document Date" := Temp_CheckDate;
            GenJrnlLine."Debit Amount" := Serive_Tax_Amt;
            GenJrnlLine.Amount := Serive_Tax_Amt;
            GenJrnlLine."Cheque Date" := Temp_CheckDate;
            GenJrnlLine."Cheque No." := CheckNo;
            GenJrnlLine.Description := Description;
            GenJrnlLine."External Document No." := ExtDocNo;
            GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", 'PRD-0010');
            GenJrnlLine.INSERT;
        END;
        //<<Service Tax Entry Recard Entry
        IF SBCess_Amt > 0 THEN BEGIN
            //>>SBCess Entry Recard Entry
            Last_Line_No += 10000;
            GenJrnlLine.INIT;
            GenJrnlLine."Journal Template Name" := 'GENERAL';
            GenJrnlLine."Journal Batch Name" := 'BPV_CF';
            GenJrnlLine."Document No." := DocNo;
            GenJrnlLine."Line No." := Last_Line_No;
            GenJrnlLine."Account Type" := GenJrnlLine."Account Type"::"G/L Account";
            GenJrnlLine."Payment Type" := GenJrnlLine."Payment Type"::Payment;
            GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::Cheque;
            CASE PaymentType OF
                'Cheque':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::Cheque;
                'DD':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::DD;
                'FRD':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::FDR;
                'RTGS':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::RTGS;
                'Cash':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::Cash;
                'FTT':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::FTT;
                'Credit-Card':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::"Credit-Card";
            END;
            //GenJrnlLine."Account No.":='61937'; SB Changes to CGST Input head by vijaya on 24-10-2017
            GenJrnlLine."Account No." := '58002';
            GenJrnlLine.VALIDATE("Posting Date", Temp_CheckDate);
            GenJrnlLine."Document Date" := Temp_CheckDate;
            GenJrnlLine."Debit Amount" := SBCess_Amt;
            GenJrnlLine.Amount := SBCess_Amt;
            GenJrnlLine."Cheque Date" := Temp_CheckDate;
            GenJrnlLine."Cheque No." := CheckNo;
            GenJrnlLine.Description := Description;
            GenJrnlLine."External Document No." := ExtDocNo;
            GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", 'PRD-0010');
            GenJrnlLine.INSERT;
            //<<SBCess Entry Recard Entry
        END;
        IF KKCess_Amt > 0 THEN BEGIN
            //>>KKCess Entry Recard Entry
            Last_Line_No += 10000;
            GenJrnlLine.INIT;
            GenJrnlLine."Journal Template Name" := 'GENERAL';
            GenJrnlLine."Journal Batch Name" := 'BPV_CF';
            GenJrnlLine."Document No." := DocNo;
            GenJrnlLine."Line No." := Last_Line_No;
            GenJrnlLine."Account Type" := GenJrnlLine."Account Type"::"G/L Account";
            GenJrnlLine."Payment Type" := GenJrnlLine."Payment Type"::Payment;
            GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::Cheque;
            CASE PaymentType OF
                'Cheque':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::Cheque;
                'DD':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::DD;
                'FRD':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::FDR;
                'RTGS':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::RTGS;
                'Cash':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::Cash;
                'FTT':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::FTT;
                'Credit-Card':
                    GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::"Credit-Card";
            END;
            //GenJrnlLine."Account No.":='33813';  SB Changes to SGST Input head by vijaya on 24-10-2017
            GenJrnlLine."Account No." := '58003';
            GenJrnlLine.VALIDATE("Posting Date", Temp_CheckDate);
            GenJrnlLine."Document Date" := Temp_CheckDate;
            GenJrnlLine."Debit Amount" := KKCess_Amt;
            GenJrnlLine.Amount := KKCess_Amt;
            GenJrnlLine."Cheque Date" := Temp_CheckDate;
            GenJrnlLine."Cheque No." := CheckNo;
            GenJrnlLine.Description := Description;
            GenJrnlLine."External Document No." := ExtDocNo;
            GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", 'PRD-0010');
            GenJrnlLine.INSERT;
        END;
        //<<KKCess Entry Recard Entry
        //<<G/L Entry Recard Entry
        //>>Bank Account Recard Entry
        Last_Line_No += 10000;
        GenJrnlLine.INIT;
        GenJrnlLine."Journal Template Name" := 'GENERAL';
        GenJrnlLine."Journal Batch Name" := 'BPV_CF';
        GenJrnlLine."Document No." := DocNo;
        GenJrnlLine."Line No." := Last_Line_No;
        GenJrnlLine."Account Type" := GenJrnlLine."Account Type"::"Bank Account";
        GenJrnlLine."Payment Type" := GenJrnlLine."Payment Type"::Payment;
        GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::Cheque;
        CASE PaymentType OF
            'Cheque':
                GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::Cheque;
            'DD':
                GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::DD;
            'FRD':
                GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::FDR;
            'RTGS':
                GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::RTGS;
            'Cash':
                GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::Cash;
            'FTT':
                GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::FTT;
            'Credit-Card':
                GenJrnlLine."Payment Through" := GenJrnlLine."Payment Through"::"Credit-Card";
        END;
        GenJrnlLine."Account No." := 'BA-000001';
        GenJrnlLine.VALIDATE("Posting Date", Temp_CheckDate);
        GenJrnlLine."Document Date" := Temp_CheckDate;
        GenJrnlLine."Credit Amount" := Amount + Bank_Charges + Serive_Tax_Amt + SBCess_Amt + KKCess_Amt;
        GenJrnlLine.Amount := -(Amount + Bank_Charges + Serive_Tax_Amt + SBCess_Amt + KKCess_Amt);
        GenJrnlLine."Cheque Date" := Temp_CheckDate;
        GenJrnlLine."Cheque No." := CheckNo;
        GenJrnlLine.Description := Description;
        GenJrnlLine."External Document No." := ExtDocNo;
        GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", 'PRD-0010');
        GenJrnlLine.INSERT;
        //>>Bank Account Recard Entry

    end;


    procedure DecreaseCertify(BOM: Code[20]; Authorized_ID: Code[50]; Certifyint: Integer; CertifyStatus: Integer)
    begin
        ProdBOMHeader.RESET;
        ProdBOMHeader.SETFILTER(ProdBOMHeader."No.", BOM);
        IF ProdBOMHeader.FINDFIRST THEN BEGIN
            IF ProdBOMHeader.Certify > 0 THEN BEGIN
                ProdBOMHeader.Certify := Certifyint;
                ProdBOMHeader."Modified User ID" := Authorized_ID;
                ProdBOMHeader.CertifyModDate := CURRENTDATETIME;
                ProdBOMHeader.CertifyStatus := CertifyStatus;
                ProdBOMHeader.MODIFY;
            END;
        END;
    end;
}

