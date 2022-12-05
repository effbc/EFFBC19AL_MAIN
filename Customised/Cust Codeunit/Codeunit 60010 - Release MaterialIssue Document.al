codeunit 60010 "Release MaterialIssue Document"
{
    // version MI1.0,Rev01

    // 2.0      UPGREV            Rectrified code in Trigger OnRun "Authorized Date" value.

    TableNo = "Material Issues Header";

    trigger OnRun();
    begin
        /*//authorization-anil
           user.SETRANGE(user."User ID","User ID");
          // MESSAGE("User ID");
           user.GET("User ID");
           dept:=user.Dept;
           user.RESET;
        
           //user.SETRANGE(,USERID);
          //user.SETRAN
          user.reset;
          user.setrange("User Name",USERID);
          IF (user.Dept=dept) OR (user.Dept='STR') THEN
           IF user.levels=FALSE   THEN
           ERROR('YOU HAVE NO PERMISSION TO AUTHORIZE');
           {IF (user.Dept<>dept)OR (user.Dept<>'STR') THEN
           ERROR('YOU HAVE NO PERMISSION TO RELEASE');
        }
           //  AUTHORIZARION ANIL 300808*/

        /*  IF NOT((USERID='08CM002') AND ("Transfer-to Code"='CAL')) THEN
          BEGIN
        
           user.SETRANGE(user."User ID",USERID);
             IF user.FINDFIRST THEN BEGIN
             IF user.levels= FALSE THEN
               ERROR('YOU HAVE NO PERMISSION TO AUTHORIZE')
              END;
          END;
         */

        IF rec."Prod. Order No." <> 'EFF14STA01' THEN BEGIN
            user.RESET;
            user.SETRANGE(user."User ID", USERID);
            IF user.FINDFIRST THEN BEGIN
                IF user.Dept <> 'STR' THEN
                    IF user.levels = FALSE THEN BEGIN
                        IF NOT ((Rec."Transfer-from Code" = 'CAL') AND (USERID = 'EFFTRONICS\VIJAYALAKSHMIB') AND (USERID = 'EFFTRONICS\SUVARCHALADEVI') AND (USERID = 'EFFTRONICS\TPRIYANKA') AND (USERID = 'EFFTRONICS\DURGAMAHESWARI')) THEN
                            ERROR('YOU HAVE NO PERMISSION TO AUTHORIZE');
                    END;
            END;
        END;


        IF Rec.Status = Rec.Status::Released THEN
            EXIT;

        IF NOT CONFIRM(Text003, FALSE, Rec."No.") THEN
            EXIT;

        Rec.TESTFIELD("Transfer-from Code");
        Rec.TESTFIELD("Transfer-to Code");
        IF Rec."Transfer-to Code" = 'CST' THEN BEGIN
            /* TESTFIELD("Service Order No.");
              TESTFIELD("Service Item");   */
        END;

        //>>a70608
        /*  TESTFIELD("Prod. Order No.");
          TESTFIELD("Prod. Order Line No.");*/
        //<<a70608
        IF (Rec."Transfer-from Code" <> '') AND
           (Rec."Transfer-from Code" = Rec."Transfer-to Code")
        THEN
            ERROR
              (Text001,
              Rec."No.", Rec.FIELDCAPTION("Transfer-from Code"), Rec.FIELDCAPTION("Transfer-to Code"));
        //TESTFIELD(Status,Status::Open);

        IF NOT ((Rec.Status = Rec.Status::Open) OR (Rec.Status = Rec.Status::"Sent for Authorization")) THEN
            ERROR('Material request must be in Open or Sent for Authorization to be authorized');

        MaterialIssueLine.SETRANGE("Document No.", Rec."No.");
        MaterialIssueLine.SETFILTER(Quantity, '<>0');
        IF NOT MaterialIssueLine.FINDFIRST THEN
            ERROR(Text002, Rec."No.");
        MaterialIssueLine.RESET;
        Rec.VALIDATE(Status, Rec.Status::Released);
        Rec.VALIDATE("Released Date", WORKDATE);
        Rec.VALIDATE("Released Time", TIME);
        Rec.VALIDATE("Released By", USERID);
        Release_time := TIME + 19800000;
        Rec.VALIDATE("Released DateTime", CREATEDATETIME(Rec."Released Date", Release_time));
        IF Rec."Authorized Date" = 0D THEN //UPGREV2.0
            Rec."Authorized Date" := WORKDATE;//UPGREV2.0
        Rec.MODIFY;
        //UPGREV2.0>>
        /*
        IF "Authorized Date"=0D THEN BEGIN
        "Authorized Date":=WORKDATE;
        MODIFY;
        END;
        */
        //UPGREV2.0<<
        Mail_Body := '';
        charline := 10;
        Mail_From := 'erp@efftronics.com';
        //Mail_To:='ramadevi@efftronics.net,nayomi@efftronics.net,Shilpa@efftronics.net,';
        //Mail_To:='krishnad@efftronics.com';
        /*Mail_To := 'vijayalakshmib@efftronics.com'; */   //UPG
        //Recipients.Add('vijayalakshmib@efftronics.com');
        Recipients.Add('qainward@efftronics.com');
        Subject := 'MATERIAL RETURNS TO ' + Rec."Transfer-to Code";
        // Mail_Body+=
        //    MESSAGE('mail testing');
        //  Attachment:='\\eff-cpu-222\ErpAttachments\'+'Cs Shortage.html';
        Mail_Body += 'Issed user name :---------------- ' + FORMAT(Rec."Resource Name");
        // Mail_Body+=FORMAT(charline2);
        Mail_Body += FORMAT(charline);
        Mail_Body += 'User ID :------------------------ ' + FORMAT(Rec."User ID");
        //   Mail_Body+=FORMAT(charline2);
        Mail_Body += FORMAT(charline);
        /*  Mail_Body+=FORMAT(charline);
          Mail_Body+=FORMAT(charline);
          Mail_Body+=FORMAT(charline);
          Mail_Body+=FORMAT(charline);  */
        j := 0;
        //Mail_Body:=
        MaterialIssueLine.SETRANGE(MaterialIssueLine."Document No.", Rec."No.");
        IF MaterialIssueLine.FINDSET THEN
            REPEAT

                IF ((MaterialIssueLine."Item No." = 'METOLGN00017') OR (MaterialIssueLine."Item No." = 'METOLGN00035')
                OR (MaterialIssueLine."Item No." = 'METOLGN00036') OR (MaterialIssueLine."Item No." = 'METOLGN00075')
                OR (MaterialIssueLine."Item No." = 'METOLGN00038') OR (MaterialIssueLine."Item No." = 'METOLGN00076')
                OR (MaterialIssueLine."Item No." = 'METOLGN00084') OR (MaterialIssueLine."Item No." = 'METOLGN00111')
                OR (MaterialIssueLine."Item No." = 'METOLGN00141') OR (MaterialIssueLine."Item No." = 'METOLGN00159')
                OR (MaterialIssueLine."Item No." = 'METOLGN00216') OR (MaterialIssueLine."Item No." = 'METOLGN00223')
                OR (MaterialIssueLine."Item No." = 'METOLGN00233') OR (MaterialIssueLine."Item No." = 'METOLGN00234')
                OR (MaterialIssueLine."Item No." = 'METOLGN00034') OR (MaterialIssueLine."Item No." = 'METOLGN00086')) THEN BEGIN
                    Mail_Body += MaterialIssueLine."Item No." + '---';
                    Mail_Body += MaterialIssueLine.Description;
                    Mail_Body += FORMAT(charline);
                    j := 1;
                END;
            UNTIL MaterialIssueLine.NEXT = 0;
        IF (Rec."Transfer-to Code" = 'STR') OR (Rec."Transfer-to Code" = 'DAMAGE') THEN
            IF j = 1 THEN BEGIN
                /* SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Mail_Body, FALSE);
                SMTP_MAIL.Send; */  //UPG
                EmailMessage.Create(Recipients, Subject, Mail_Body, true);
                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
            END;
        // Mail.NewCDOMessage(Mail_From,Mail_To,Subject,Mail_Body,'');


    end;

    var
        Text001: Label 'The MaterialIssue order %1 cannot be released because %2 and %3 are the same.';
        Text002: Label 'There is nothing to release for MaterialIssue order %1.';
        MaterialIssueLine: Record "Material Issues Line";
        Text003: Label 'Do you want to Authorize the Material Issue %1?';
        Text004: Label 'Do you want to Reopen the Material Issue %1?';
        user: Record "User Setup";
        dept: Code[10];
        SMTPSETUP: Record "SMTP SETUP";
        "Mail-Id": Record User;
        "from Mail": Text[150];
        "to mail": Text[1000];
        Mail_Subject: Text[1000];
        Mail_Body: Text[1000];
        bodies: Integer;
        //objEmailConf: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000002-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Configuration";
        //objEmail: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000001-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Message";
        //flds: Automation "'{00000205-0000-0010-8000-00AA006D2EA4}' 2.5:'{00000564-0000-0010-8000-00AA006D2EA4}':''{00000205-0000-0010-8000-00AA006D2EA4}' 2.5'.Fields";
        //fld: Automation "'{00000205-0000-0010-8000-00AA006D2EA4}' 2.5:'{00000569-0000-0010-8000-00AA006D2EA4}':''{00000205-0000-0010-8000-00AA006D2EA4}' 2.5'.Field";
        charline: Char;
        charline2: Char;
        j: Integer;
        Body: Text[250];
        Mail_From: Text[250];
        Mail_To: Text[250];
        // Mail: Codeunit 397;
        Subject: Text[250];
        //SMTP_MAIL: Codeunit "SMTP Mail";
        //>> ORACLE UPG
        //SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
        // RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        //>> ORACLE UPG
        SQLQuery: Text[1000];
        ConnectionOpen: Integer;
        RowCount: Integer;
        //LRecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        Release_time: Time;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];


    procedure Reopen(var MaterialIssueHeader: Record "Material Issues Header");
    begin
        IF USERID IN ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\MARY', 'EFFTRONICS\ANANDA', 'EFFTRONICS\RATNA', 'EFFTRONICS\DMADHAVI', 'EFFTRONICS\PADMASRI',
                     'EFFTRONICS\RAMADEVI', 'EFFTRONICS\MPUJITHA', 'EFFTRONICS\VSNGEETHA', 'EFFTRONICS\NAGALAKSHMI', 'EFFTRONICS\SITARAJYAM', 'EFFTRONICS\SUJANI', 'EFFTRONICS\BHAVANIP',
                     'EFFTRONICS\GRAVI', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\PKOTESWARARAO', 'EFFTRONICS\VARALAKSHMI', 'EFFTRONICS\TLAKSHMI',
                     'EFFTRONICS\TULASI', 'EFFTRONICS\RENUKACH', 'EFFTRONICS\RRAHUL', 'EFFTRONICS\B2BOTS', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA'] THEN BEGIN
            IF MaterialIssueHeader.Status = MaterialIssueHeader.Status::Open THEN
                EXIT;
            IF NOT CONFIRM(Text004, FALSE, MaterialIssueHeader."No.") THEN
                EXIT;
            MaterialIssueHeader.VALIDATE(Status, MaterialIssueHeader.Status::Open);
            MaterialIssueHeader.MODIFY;
        END
        ELSE
            ERROR('YOU dont have rights to reopen');
    end;


    procedure Release_Request("Material Issues Header": Record "Material Issues Header");
    begin
        user.SETRANGE(user."User ID", USERID);
        IF user.FINDFIRST THEN BEGIN
            IF NOT (user.Dept = 'STR') THEN
                IF user.levels = FALSE THEN
                    ERROR('YOU HAVE NO PERMISSION TO AUTHORIZE');
        END;

        IF "Material Issues Header".Status = "Material Issues Header".Status::Released THEN
            EXIT;

        //IF NOT CONFIRM(Text003,FALSE,"No.") THEN
        //  EXIT;

        "Material Issues Header".TESTFIELD("Material Issues Header"."Transfer-from Code");
        "Material Issues Header".TESTFIELD("Material Issues Header"."Transfer-to Code");
        IF "Material Issues Header"."Transfer-to Code" = 'CST' THEN BEGIN
            /* TESTFIELD("Service Order No.");
              TESTFIELD("Service Item");   */
        END;

        //>>a70608
        /*  TESTFIELD("Prod. Order No.");
          TESTFIELD("Prod. Order Line No.");*/
        //<<a70608
        IF ("Material Issues Header"."Transfer-from Code" <> '') AND
           ("Material Issues Header"."Transfer-from Code" = "Material Issues Header"."Transfer-to Code")
        THEN
            ERROR
              (Text001,
              "Material Issues Header"."No.", "Material Issues Header".FIELDCAPTION("Transfer-from Code"),
              "Material Issues Header".FIELDCAPTION("Transfer-to Code"));
        "Material Issues Header".TESTFIELD(Status, "Material Issues Header".Status::Open);

        MaterialIssueLine.SETRANGE("Document No.", "Material Issues Header"."No.");
        MaterialIssueLine.SETFILTER(Quantity, '<>0');
        /*IF NOT MaterialIssueLine.FINDFIRST THEN
          ERROR(Text002,"Material Issues Header"."No.");*/
        MaterialIssueLine.RESET;
        "Material Issues Header".VALIDATE(Status, "Material Issues Header".Status::Released);
        "Material Issues Header".VALIDATE("Released Date", WORKDATE);
        "Material Issues Header".VALIDATE("Released Time", TIME);
        "Material Issues Header".VALIDATE("Released By", USERID);
        //UPGREV2.0>>
        IF "Material Issues Header"."Authorized Date" = 0D THEN
            "Material Issues Header"."Authorized Date" := WORKDATE;
        //UPGREV2.0<<
        "Material Issues Header".MODIFY;
        //UPGREV2.0>>
        /*
        IF "Material Issues Header"."Authorized Date"=0D THEN BEGIN
        "Material Issues Header"."Authorized Date":=WORKDATE;
        "Material Issues Header".MODIFY;
        END;
        */
        //UPGREV2.0<<

    end;


    procedure Refresh(MIH: Record "Material Issues Header");
    begin
        IF MIH.Status <> MIH.Status::Released THEN BEGIN
            IF USERID IN ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\ANANDA', 'EFFTRONICS\MARY', 'EFFTRONICS\RATNA', 'EFFTRONICS\PADMASRI', 'EFFTRONICS\SUJANI',
                          'EFFTRONICS\PADMA', 'EFFTRONICS\SIRISHA', 'EFFTRONICS\VIJAYALAKSHMIB', 'EFFTRONICS\RENUKAH', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'] THEN BEGIN
                /*IF ISCLEAR(SQLConnection) THEN
                    CREATE(SQLConnection, FALSE, TRUE);// Rev01

                IF ISCLEAR(RecordSet) THEN
                    CREATE(RecordSet, FALSE, TRUE); // Rev01*/
                //>> ORACLE UPG
                /*
            IF ConnectionOpen <> 1 THEN BEGIN
                SQLConnection.ConnectionString := 'DSN=salinvoiceuser;UID=salinvoiceuser;PASSWORD=salinvoiceuser;SERVER=oracle_80;';
                SQLConnection.Open;
                SQLConnection.BeginTrans;
                ConnectionOpen := 1;
            END;
            SQLQuery := 'select requestid,status,Released_Date from materialauthor where (status=1) and materialauthor.requestid=''' + FORMAT(MIH."No.") + '''';
            RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
            IF RowCount < -1 THEN
                ERROR('Request not yet authorized to Refresh the data')
            ELSE BEGIN
                IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                    RecordSet.MoveFirst;
                WHILE NOT RecordSet.EOF DO BEGIN
                    //MESSAGE(FORMAT(RecordSet.Fields.Item('Released_Date').Value));
                    IF (MIH."No." = FORMAT(RecordSet.Fields.Item('requestid').Value)) THEN BEGIN
                        IF MIH."No." <> '' THEN BEGIN
                            MIH.Status := MIH.Status::Released;
                            MIH.VALIDATE(MIH."Released Date", DT2DATE(RecordSet.Fields.Item('Released_Date').Value));
                            MIH.VALIDATE(MIH."Released Time", DT2TIME(RecordSet.Fields.Item('Released_Date').Value));
                            MIH.VALIDATE(MIH."Released By", MIH."Request for Authorization");
                            //"Posting Date":=TODAY;
                            IF MIH."Authorized Date" = 0D THEN
                                MIH."Authorized Date" := TODAY;
                            MIH.MODIFY;
                        END;
                    END;
                    RecordSet.MoveNext;
                END;
                MESSAGE('Data Refreshed');
            END;
        END ELSE
            ERROR('You Do not Have Permission to Refresh');
    END ELSE
        ERROR('The Request has Already in the Released Mode');
        */
                //<< ORACLE UPG
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
        end;
    end;
}

