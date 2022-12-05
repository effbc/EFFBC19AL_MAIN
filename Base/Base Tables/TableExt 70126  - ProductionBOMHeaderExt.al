tableextension 70126 ProductionBOMHeaderExt extends "Production BOM Header"
{
    fields
    {
        field(60031; Description1; Text[60])
        {
            DataClassification = CustomerContent;
        }
        modify("No.")
        {
            trigger OnBeforeValidate()
            var
                Item: Record Item;
            begin
                if Item.Get("No.") then       //Added by Pranavi on 08-09-2015 to prevent Item selection if Itm Tracking code is blank
                    Item.TestField(Item."Item Tracking Code");
            end;
        }
        modify(Status)
        {
            trigger OnBeforeValidate()
            var
                BOMLine: Record "Production BOM Line";
                PrevItem: Text[30];
                PrevPosition: Text[250];
                PrevDescription: Text[250];
                OldStatus: Integer;
            begin
                if BOMLine.FindSet then
                    PrevItem := '';
                PrevPosition := '';
                PrevDescription := '';
                BOMLine.Reset;
                BOMLine.SetCurrentKey(Type, "No.");
                BOMLine.SetRange("Version Code", '');
                BOMLine.SetRange("Production BOM No.", "No.");
                if BOMLine.FindSet then
                    repeat
                        if (PrevItem = BOMLine."No.") and (PrevPosition = BOMLine.Position) and (PrevDescription = BOMLine.Description) then
                            Error('BOM having Duplicate Item :: ' + PrevItem + ' With the BOM No::' + "No.");
                        PrevItem := BOMLine."No.";
                        PrevPosition := BOMLine.Position;
                    until BOMLine.Next = 0;
                //added by vishnu priya on 24-09-2020
                if (Rec."Creation Date" <= 20200909D) and (xRec.Status.AsInteger() = 1) and not (UserId in ['EFFTRONICS\SUVARCHALADEVI','EFFTRONICS\DURGAMAHESWARI','EFFTRONICS\BHARAT']) then
                    Error('You can not modify the old certified BOMs');
                //added by vishnu priya on 24-09-2020

                // Commented  by Vishnu Priya on 28-09-2020

                /* IF NOT (USERID IN ['SUPER', 'EFFTRONICS\JHANSI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\PARVATHI', 'EFFTRONICS\RSILPARANI', 'EFFTRONICS\RATNARAVALI', 'EFFTRONICS\UBEDULLA',
                                     'EFFTRONICS\MEENA', 'EFFTRONICS\GRAVI', 'EFFTRONICS\VANIDEVI', 'EFFTRONICS\VISHNUPRIYA',
                                     'EFFTRONICS\YNARESH', 'EFFTRONICS\INDUMATHI', 'EFFTRONICS\SARAT', 'EFFTRONICS\VIMALANAND', 'EFFTRONICS\VENKATESH', 'EFFTRONICS\SARDHAR', 'EFFTRONICS\HARI']) THEN
                 ERROR('You dont have permissions to change the Status of BOM'); */

                // Commented  by Vishnu Priya on 28-09-2020
                if not (TableCode.Permission_Checking(UserId, 'BOM_CREATION_ROLE')) then
                    Error('You dont have permissions to change the Status of BOM');


                 IF (COPYSTR("No.",1,8)='ECMPBPCB') AND NOT (USERID IN ['EFFTRONICS\PARVATHI','EFFTRONICS\JHANSI','EFFTRONICS\RAMALAKSHMI','EFFTRONICS\RATNARAVALI','EFFTRONICS\UBEDULLA','EFFTRONICS\VISHNUPRIYA','EFFTRONICS\ANILKUMAR','EFFTRONICS\MANOJA','EFFTRONICS\SUVARCHALADEVI','EFFTRONICS\DURGAMAHESWARI','EFFTRONICS\BHARAT','EFFTRONICS\TPRIYANKA','EFFTRONICS\BHAVANI']) THEN
              
                    Error('You dont have permissions to Certify the MASTER BOM');


                IF (COPYSTR("No.",1,8)<>'ECMPBPCB') AND (Status=Status::Certified) AND NOT (USERID IN ['EFFTRONICS\TPRIYANKA','EFFTRONICS\ANILKUMAR','ERPSERVER\ADMINISTRATOR','EFFTRONICS\SUVARCHALADEVI','EFFTRONICS\DURGAMAHESWARI','EFFTRONICS\BHARAT','EFFTRONICS\BHAVANI']) THEN
                    Error('You dont have permissions to Certify the BOM');




                if Status = Status::Certified then
                    StatusCheck3;

                if Status.AsInteger() = 2 then
                    StatusCheck4;
                //
                IF ((Status <> Status::Certified) AND (Status <> Status::Closed) AND (Status = Status::New) AND
                                                                     (USERID<>'SUPER')  AND (USERID<>'EFFTRONICS\DIR')  AND (USERID<>'EFFTRONICS\BHAVANI')
                                                                      AND("Stranded BOM"<>TRUE)) THEN begin
                    Message('Not possible to underdevelopment');
                    Status := Status::Certified;
                end
                else
                    OldStatus := xRec.Status.AsInteger();

            end;

            trigger OnAfterValidate()
            var
                MfgSetup: Record "Manufacturing Setup";
                ProdBOMLineRec: Record "Production BOM Line";
                ProdBOMHeader: Record "Production BOM Header";
                Item: Record Item;
                TypeofSolder: Boolean;
                "NewNo.": Text[30];
                user: Record User;
                Mail_Body: array[5] of Text[30];
                Attachment: Text[1000];
                "Mail-Id": Record User;
                from_Mail: Text[1000];
                to_mail: Text[1000];
                Mail_Subject: Text[1000];
                //SMTP_MAIL: Codeunit "SMTP Mail";
                Body: Text[1000];

                NAME: Text[100];
                //Recipients: Text[1000];

                changelog: Record "Change Log Entry";
                FileDirectory: Text[100];
                FileName: Text[100];
                RunOnceFile: Text[1000];
                TimeOut: Integer;
                WINDOW: Dialog;
            begin
                MfgSetup.Get();
                "Total No. of Fixing Holes" := 0;
                ProdBOMLineRec.Reset;
                ProdBOMLineRec.SetRange("Production BOM No.", "No.");
                ProdBOMLineRec.SetRange("Version Code", '');
                if ProdBOMLineRec.FindSet then
                    repeat
                        "Total No. of Fixing Holes" := "Total No. of Fixing Holes" + ProdBOMLineRec."No. of Fixing Holes";
                    until ProdBOMLineRec.Next = 0;

                //NSS 140907
                "Total Soldering Points SMD" := 0;
                "Total Soldering Points DIP" := 0;
                "Total Soldering Points" := 0;


                TypeofSolder := false;
                ProdBOMLineRec.Reset;
                ProdBOMLineRec.SetRange("Production BOM No.", "No.");
                ProdBOMLineRec.SetRange("Version Code", '');
                if ProdBOMLineRec.FindSet then
                    repeat
                        if ProdBOMLineRec."Type of Solder".AsInteger() > 0 then
                            TypeofSolder := true;

                        if ProdBOMHeader.Get(ProdBOMLineRec."No.") then begin
                            CALC_SOLDERING_POINTS(ProdBOMLineRec."No.");
                            ProdBOMLineRec."No. of Soldering Points" := ProdBOMLineRec."Quantity per" * ProdBOMHeader."Total Soldering Points";
                            ProdBOMLineRec."No. of SMD Points" := ProdBOMLineRec."Quantity per" * ProdBOMHeader."Total Soldering Points SMD";
                            ProdBOMLineRec."No. of DIP Point" := ProdBOMLineRec."Quantity per" * ProdBOMHeader."Total Soldering Points DIP";

                        end else
                            if Item.Get(ProdBOMLineRec."No.") then begin
                                ProdBOMLineRec."No. of Pins" := Item."No. of Pins";
                                ProdBOMLineRec."No. of Soldering Points" := Item."No. of Soldering Points" * (ProdBOMLineRec.Quantity -
                                                                                                              ProdBOMLineRec."Scrap Quantity");
                                ProdBOMLineRec."Type of Solder" := Item."Type of Solder";
                            end;


                        ProdBOMLineRec.Modify;
                    until ProdBOMLineRec.Next = 0;

                if TypeofSolder = true then begin
                    //Commentd on 011007
                    ProdBOMLineRec.Reset;
                    ProdBOMLineRec.SetRange("Production BOM No.", "No.");
                    ProdBOMLineRec.SetRange("Version Code", '');
                    ProdBOMLineRec.SetFilter("Type of Solder", '%1', ProdBOMLineRec."Type of Solder"::SMD);
                    if ProdBOMLineRec.Find('-') then
                        repeat
                            "Total Soldering Points SMD" := "Total Soldering Points SMD" + ProdBOMLineRec."No. of Soldering Points";
                        until ProdBOMLineRec.Next = 0;

                    ProdBOMLineRec.Reset;
                    ProdBOMLineRec.SetRange("Production BOM No.", "No.");
                    ProdBOMLineRec.SetRange("Version Code", '');
                    ProdBOMLineRec.SetFilter("Type of Solder", '%1', ProdBOMLineRec."Type of Solder"::DIP);
                    if ProdBOMLineRec.Find('-') then
                        repeat
                            if Item.Get(ProdBOMLineRec."No.") then
                                ProdBOMLineRec."No. of Soldering Points" := Item."No. of Soldering Points" * (ProdBOMLineRec.Quantity -
                                                                                                     ProdBOMLineRec."Scrap Quantity");
                            "Total Soldering Points DIP" := "Total Soldering Points DIP" + ProdBOMLineRec."No. of Soldering Points";
                        until ProdBOMLineRec.Next = 0;

                    ProdBOMLineRec.Reset;
                    ProdBOMLineRec.SetRange("Production BOM No.", "No.");
                    ProdBOMLineRec.SetRange("Version Code", '');
                    ProdBOMLineRec.SetFilter("Type of Solder", '%1', ProdBOMLineRec."Type of Solder"::" ");
                    if ProdBOMLineRec.Find('-') then
                        repeat
                            "Total Soldering Points SMD" := "Total Soldering Points SMD" + ProdBOMLineRec."No. of SMD Points";
                            "Total Soldering Points DIP" := "Total Soldering Points DIP" + ProdBOMLineRec."No. of DIP Point";
                        until ProdBOMLineRec.Next = 0;
                    "Total Soldering Points" := "Total Soldering Points DIP" + "Total Soldering Points SMD";
                end;

                if TypeofSolder = false then begin
                    if Status = Status::Certified then begin
                        ProdBOMHeader.Reset;
                        ProdBOMLineRec.Reset;
                        Item.Reset;
                        ProdBOMLineRec.SetRange("Production BOM No.", "No.");
                        ProdBOMLineRec.SetRange("Version Code", '');
                        if ProdBOMLineRec.Find('-') then
                            repeat
                                if ProdBOMLineRec.Type = ProdBOMLineRec.Type::Item then begin
                                    Item.Get(ProdBOMLineRec."No.");
                                    if ProdBOMHeader.Get(Item."Production BOM No.") then begin
                                        ProdBOMHeader.TestField(Status, ProdBOMHeader.Status::Certified);
                                        "Total Soldering Points SMD" := "Total Soldering Points SMD" + (ProdBOMHeader."Total Soldering Points SMD" *
                                                                                                         ProdBOMLineRec."Quantity per");
                                        "Total Soldering Points DIP" := "Total Soldering Points DIP" + (ProdBOMHeader."Total Soldering Points DIP" *
                                                                                                       ProdBOMLineRec."Quantity per");
                                    end;
                                end else begin
                                    if ProdBOMLineRec.Type = ProdBOMLineRec.Type::"Production BOM" then begin
                                        if ProdBOMHeader.Get(ProdBOMLineRec."No.") then begin
                                            ProdBOMHeader.TestField(Status, ProdBOMHeader.Status::Certified);
                                            "Total Soldering Points SMD" := "Total Soldering Points SMD" + (ProdBOMHeader."Total Soldering Points SMD" *
                                                                                                            ProdBOMLineRec."Quantity per");
                                            "Total Soldering Points DIP" := "Total Soldering Points DIP" + (ProdBOMHeader."Total Soldering Points DIP" *
                                                                                                          ProdBOMLineRec."Quantity per");
                                        end;
                                    end;
                                end;
                            until ProdBOMLineRec.Next = 0;
                    end;
                    "Total Soldering Points" := "Total Soldering Points DIP" + "Total Soldering Points SMD";
                end;

                "Bench Mark Time(In Hours)" := "Total Soldering Points SMD" * (MfgSetup."Soldering Time Req.for BID" / 3600) +
                                               "Total Soldering Points DIP" * (MfgSetup."Soldering Time Req.for DIP" / 3600) +
                                               "Total No. of Fixing Holes" * (MfgSetup."Total Fixing Points Time" / 3600);

                ProdBOMLineRec.Reset;
                ProdBOMLineRec.SetRange("Production BOM No.", "No.");
                ProdBOMLineRec.SetRange("Version Code", '');
                if ProdBOMLineRec.Find('-') then
                    repeat
                        if ProdBOMLineRec."BOM Type" = ProdBOMLineRec."BOM Type"::" " then begin   // Condition added by Pranavi on 11-Jan-2016
                            ProdBOMLineRec."BOM Type" := ProdBOMLineRec."BOM Type";
                            ProdBOMLineRec.Modify;
                        end;
                    until ProdBOMLineRec.Next = 0;

                Modify(true);

                if (Status = xRec.Status) then
                    exit;

                if not (UpperCase(UserId) in ['EFFTRONICS\PRANAVI', 'EFFTRONICS\VIJAYA']) then begin
                    if (Status = Status::Certified) and (xRec.Status <> Status::"Under Development") then begin
                        "NewNo." := CopyStr("No.", 1, 7);
                        if ("Creation Date" >= DMY2Date(1, 1, 2011)) and ("NewNo." = 'ECPBPCB') then begin
                            if not "mail check" then begin
                                user.Reset;
                                user.SetFilter(user."User Name", UserId);//Rev01
                                if user.Find('-') then begin
                                    NAME := 'ERP';// user."Full Name";//Rev01
                                    Body := '<br>The Production Bom "' + Format("No.") + '"  (' + Description + ') is certified by user ';
                                    Body += Format(Authorised_ID_GVar);//          Body+=FORMAT(NAME)+'('+FORMAT(USERID)+')';
                                    Body += '<br><br><br><b><u> NOTE:- </u></B> Please Post the Layout using PRM Layout Software';
                                    Body += '<br><br><br>*** This is a Auto Mail Generated From ERP ***';
                                    Mail_Subject := 'New Production BOM was Created';
                                    //   from_Mail := 'noreply@efftronics.com';// FORMAT(user.MailID);
                                    /* to_mail := 'erp@efftronics.com,vishnupriya@efftronics.com';//'Layouts1@efftronics.com';
                                    SMTP_MAIL.CreateMessage(NAME, from_Mail, to_mail, Mail_Subject, Body, true);
                                    Recipients += 'prm@efftronics.com,layouts1@efftronics.com,padmaja@efftronics.com,bharat@efftronics.com,';
                                    Recipients += 'jhansi@efftronics.com,erp@efftronics.com';
                                    SMTP_MAIL.AddCC(Recipients);
                                    SMTP_MAIL.Send; */          //B2B UPG

                                    Recipients.Add('noreply@efftronics.com');
                                    Recipients.Add('prm@efftronics.com,');
                                    Recipients.Add('layouts1@efftronics.com');
                                    Recipients.Add('padmaja@efftronics.com');
                                    Recipients.Add('bharat@efftronics.com');
                                    Recipients.Add('controlroom@efftronics.com');
                                    Recipients.Add('erp@efftronics.com');
                                    Recipients.Add('hwd@efftronics.com');
                                    Recipients.add('dqa@efftronics.com');
                                    EmailMessage.Create(Recipients, Mail_Subject, Body, true);
                                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                                    "mail check" := true;
                                    Commit;
                                    //MESSAGE('Mail was succesfully sent to Layouts Department');//Suvarchala
                                                                          MESSAGE('Mail was succesfully sent');
                                    
                                end;
                            end;
                        end;
                    end;
                end;



                // PRM Integration
                if Status = Status::Certified then begin
                    PRMIntegration.ProdBOMHeadertoPRM(Rec);
                end;
                // PRM Integration

                /* IF (Status = Status::Certified) OR (xRec.Status = xRec.Status::Certified) THEN BEGIN
                     "NewNo." := COPYSTR("No.", 1, 7);
                     IF ("Creation Date" >= DMY2DATE(1, 1, 2011)) THEN BEGIN
                         user.RESET;
                         user.SETFILTER(user."User Name", USERID);
                         IF user.FIND('-') THEN BEGIN
                             NAME := user."Full Name";
                             Body := '<br>Production Bom     - ' + Description + ' (' + FORMAT("No.") + ')';
                             Item.RESET;
                             Item.SETFILTER(Item."No.", "No.");

                             IF Item.FINDFIRST THEN
                                 Body += '<br>Product Group Code - ' + FORMAT(Item."Product Group Code");
                             Body += '<br>Previous Status    - ' + FORMAT(xRec.Status);
                             Body += '<br>Present Status     - ' + FORMAT(Status);
                             Body += '<br>User Name          -' + FORMAT(NAME) + '(' + FORMAT(USERID) + ')';
                         END;

                         IF (Status = Status::Certified) AND ("mail check" = FALSE) AND ("NewNo." = 'ECPBPCB') THEN
                             Body += '<br><br><br><b><u> NOTE:- </u></B> Please Post the Layout using PRM Layout Software';
                         Body += '<br><br><br>*** This is a Auto Mail Generated From ERP ***';
                         IF (Status = Status::Certified) AND NOT ("mail check") THEN
                             Mail_Subject := 'New Production BOM (' + Description + ') was Created'
                         ELSE
                             Mail_Subject := 'Production BOM (' + Description + ') has been modified';
                         from_Mail := FORMAT(user.MailID);
                         IF "BOM Type" = "BOM Type"::Mechanical THEN
                             to_mail := 'ubedulla@efftronics.com'
                         ELSE
                             to_mail := 'Layouts1@efftronics.com,Layouts2@efftronics.com';
                         SMTP_MAIL.CreateMessage(NAME, from_Mail, to_mail, Mail_Subject, Body, TRUE);
                         IF ("NewNo." = 'ECPBPCB') AND (Status = Status::Certified) AND ("mail check" = FALSE) THEN
                             Recipients += 'prm@efftronics.com,';

                         Recipients += 'parvathi@efftronics.com,padmaja@efftronics.com,bharat@efftronics.com,';
                         Recipients += 'anilkumar@efftronics.com,jhansi@efftronics.com,layouts1@efftronics.com,Prasannad@efftronics.com,';
                         Recipients += 'tulasi@efftronics.com,lakshmit@efftronics.com,erp@efftronics.com';
                         SMTP_MAIL.AddCC(Recipients);

                         IF (Status = Status::Certified) AND ("mail check" = TRUE) THEN BEGIN
                             changelog.RESET;
                             changelog.SETFILTER(changelog."Table No.", '99000772');
                             changelog.SETFILTER(changelog."Primary Key Field 1 Value", "No.");
                             changelog.SETFILTER(changelog."Field No.", '11|12|14');
                             changelog.SETFILTER(changelog."Date and Time", FORMAT(xRec."Last Date Modified") + '..' + FORMAT("Last Date Modified" + 1));
                             IF changelog.FINDFIRST THEN BEGIN
                                 IF ISCLEAR(BullZipPDF) THEN
                                     CREATE(BullZipPDF);
                                 FileDirectory := '\\erpserver\ErpAttachments\';//anil
                                 WINDOW.OPEN('PREPARING THE REPORT');
                                 FileName := 'BOM_Changes.pdf';
                                 Attachment := FileDirectory + FileName;
                                 IF EXISTS(Attachment) THEN
                                     ERASE(Attachment);
                                 BullZipPDF.Init;
                                 BullZipPDF.LoadSettings;
                                 RunOnceFile := BullZipPDF.GetSettingsFileName(TRUE);
                                 BullZipPDF.SetValue('Output', FileDirectory + FileName);
                                 BullZipPDF.SetValue('Showsettings', 'never');
                                 BullZipPDF.SetValue('ShowPDF', 'no');
                                 BullZipPDF.SetValue('ShowProgress', 'no');
                                 BullZipPDF.SetValue('ShowProgressFinished', 'no');
                                 BullZipPDF.SetValue('SuppressErrors', 'yes');
                                 BullZipPDF.SetValue('ConfirmOverwrite', 'yes');
                                 BullZipPDF.WriteSettings(TRUE);
                                 REPORT.RUNMODAL(509, FALSE, FALSE, changelog);
                                 TimeOut := 0;
                                 WHILE EXISTS(RunOnceFile) AND (TimeOut < 20) DO BEGIN
                                     SLEEP(2000);
                                     TimeOut := TimeOut + 1;
                                 END;
                                 WINDOW.CLOSE;
                                 Attachment := FileDirectory + FileName;
                                 SMTP_MAIL.AddAttachment(Attachment);
                             END;
                         END;
                         SMTP_MAIL.Send;
                         "mail check" := TRUE;

                         //COMMIT;
                         MESSAGE('Mail was succesfully sent to Layouts Department');
                     END;
                 END; */



                /* IF (Status=Status::Certified) AND (USERID<>'10RD010') THEN
                BEGIN
                  "NewNo." := COPYSTR("No.",1,7);
                  IF  ("Creation Date" >=DMY2DATE(1,1,2011)) AND ("NewNo." = 'ECPBPCB') THEN
                  BEGIN
                    IF NOT "mail check"  THEN
                    BEGIN
                      user.RESET;
                      user.SETFILTER(user."User Name",USERID);
                      IF user.FIND('-') THEN
                      BEGIN
                        NAME:= user."Full Name";
                        Body :='<br>Production Bom     - '+Description+' ('+FORMAT("No.")+')';
                        Item.RESET;
                        Item.SETFILTER(Item."No.","No.");
                        IF Item.FINDFIRST THEN
                          Body +='<br>Product Group Code - '+FORMAT(Item."Product Group Code");
                          Body +='<br>Previous Status    - '+FORMAT(xRec.Status);
                          Body +='<br>Present Status     - '+FORMAT(Status);
                          Body +='<br>User Name          -'+FORMAT(NAME)+'('+FORMAT(USERID)+')';

                      Body :='<br>The Production Bom "'+FORMAT("No.") +'"  ('+Description+') is certified by user ';
                      Body+=FORMAT(NAME)+'('+FORMAT(USERID)+')';
                      Body+='<br><br><br><b><u> NOTE:- </u></B> Please Post the Layout using PRM Layout Software';
                      Body+='<br><br><br>*** This is a Auto Mail Generated From ERP ***';
                      Mail_Subject := 'New Production BOM was Created';
                      from_Mail := FORMAT(user.MailID);
                      to_mail:='Layouts1@efftronics.com,Layouts2@efftronics.com';
                      SMTP_MAIL.CreateMessage(NAME,from_Mail,to_mail,Mail_Subject,Body,TRUE);
                      Recipients +='prm@efftronics.com,layouts1@efftronics.com,padmaja@efftronics.com,bharat@efftronics.com,';
                      Recipients +='anilkumar@efftronics.com,jhansi@efftronics.com,Parvathi@efftronics.com';
                      SMTP_MAIL.AddCC(Recipients);
                      SMTP_MAIL.Send;
                      "mail check" :=TRUE;
                      COMMIT;
                      MESSAGE('Mail was succesfully sent to Layouts Department');
                    END;
                    END;
                  END;
                END; */


                if Status <> Status::Certified then begin
                    "Update in PRM" := false;
                    Modify;
                end;


                Commit;
            end;
        }

        field(60001; "Bench Mark Time(In Hours)"; Decimal)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60002; "Total Soldering Points SMD"; Decimal)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60003; "Total No. of Fixing Holes"; Decimal)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60004; "User Id"; Code[50])
        {
            Description = 'B2B,Rev01';
            TableRelation = User."User Name";
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(60005; "Total Soldering Points DIP"; Decimal)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60006; "Total Soldering Points"; Decimal)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60007; BOMCOST; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60015; "BOM Type"; Enum BOMType)
        {
            Description = 'B2B';


            trigger OnValidate();
            begin
                if Status = Status::Certified then
                    FieldError(Status);
            end;
        }
        field(60016; "BOM Cost"; Decimal)
        {
            CalcFormula = Sum("Production BOM Line"."Tot Avg Cost" WHERE("Production BOM No." = FIELD("No.")));
            Description = 'Cost1.0';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60017; "BOM Manufacturing Cost"; Decimal)
        {
            CalcFormula = Sum("Production BOM Line"."Manufacturing Cost" WHERE("Production BOM No." = FIELD("No.")));
            Description = 'Cost1.0';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60018; "Modified User ID"; Code[50])
        {
            Description = 'Rev01';
            TableRelation = User."User Name";
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(60019; "Stranded BOM"; Boolean)
        {
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(60020; "Update BOM"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60021; "mail check"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60022; Certify; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60023; "Update in PRM"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60024; "BOM Running Status"; Option)
        {
            Description = 'Added by sujani for running/old bom segregation';
            OptionMembers = "  ",Running,Old;
            DataClassification = CustomerContent;
        }
        field(60025; "Inherited From"; Code[20])
        {
            Description = 'Added by sujani for running/old bom segregation';
            TableRelation = "Production BOM Header"."No.";
            DataClassification = CustomerContent;
        }
        field(60026; Configuration; Code[50])
        {
            Description = 'Added by sujani for Configuration tracking';
            TableRelation = "Product Configurations Master".Configuration;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(60027; "BOM Category"; Option)
        {
            Description = 'Added by sujani bom tentative or final';
            OptionCaption = '" ,Tentative,Final"';
            OptionMembers = " ",Tentative,Final;
            DataClassification = CustomerContent;
        }
        field(60028; CertifyStatus; Option)
        {
            Description = 'Added by sujani for approval rejection tracking';
            OptionCaption = '" ,Accept,Reject"';
            OptionMembers = " ",Accept,Reject;
            DataClassification = CustomerContent;
        }
        field(60029; CertifyModDate; DateTime)
        {
            Description = 'Added by sujani for approval rejection tracking';
            DataClassification = CustomerContent;
        }
        field(60030; "Remarks/Reason"; Text[250])
        {
            DataClassification = CustomerContent;
            Description = 'Added by Vishnu Priya for the Approvals process';
        }
    }

    trigger OnAfterInsert()
    begin
        //B2B 100807 Eid 169
        "User Id" := UserId;
        //B2B 100807 Eid 169
    end;

    trigger OnAfterModify()
    var
        Authorised_ID_GVar: Code[50];
    begin
        if Authorised_ID_GVar = '' then begin
            if not (UserId in ['EFFTRONICS\PRANAVI', 'EFFTRONICS\RAKESHT'/*,'EFFTRONICS\JHANSI'*/]) then   //commented by pranavi on 13-04-2015
                 begin
                "Modified User ID" := UserId
            end;
        end
        else
            "Modified User ID" := Authorised_ID_GVar;
    end;

    trigger OnBeforeDelete()
    begin
        //Added by Rakesh on 12-Jul-14 to stop modification when BOM is under certification
        /* IF NOT (UPPERCASE(USERID) IN ['ERPSERVER\ADMINISTRATOR','EFFTRONICS\PRANAVI']) THEN
        BEGIN
          IF Certify > 0  THEN
            ERROR('BOM('+"No."+') is submitted for Approval. Changes are not allowed.');
        END; */
        //end by Rakesh
    end;

    var
        TypeofSolder: Boolean;
        PBMV: Record "Production BOM Version";
        Version1: Code[30];
        SMTPSETUP: Record "SMTP SETUP";
        //objEmailConf: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000002-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Configuration";
        //objEmail: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000001-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Message";
        //flds: Automation "'{00000205-0000-0010-8000-00AA006D2EA4}' 2.5:'{00000564-0000-0010-8000-00AA006D2EA4}':''{00000205-0000-0010-8000-00AA006D2EA4}' 2.5'.Fields";
        fld: Integer;
        Authorised_ID_GVar: Code[50];
        RoutingHeader: Record "Routing Header";
        ProdBomLineLoc: Record "Production BOM Line";
        PRMIntegration: Codeunit SQLIntegration;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        ProdBOMLineRec: Record "Production BOM Line";
        Item: Record Item;
        ProdBOMHeader: Record "Production BOM Header";
        "NewNo.": Text[30];
        user: Record User;
        Mail_Body: array[5] of Text[30];
        Mail_Subject: Text[1000];
        Body: Text[1000];
        TableCode: Codeunit "Custom Events";


    PROCEDURE StatusCheck(ItemNoParam: Code[20]);
    VAR
        ProdBomHeaderLoc: Record "Production BOM Header";
        ProdBomLineLoc: Record "Production BOM Line";
        ProdBomHeaderLoc2: Record "Production BOM Header";
        ItemLoc: Record Item;
        ProdBomNo: Code[20];
    BEGIN
        ItemLoc.Get(ItemNoParam);
        //MESSAGE(FORMAT(ItemNoParam));
        /* IF NOT ((ItemLoc."Product Group Code" = 'FPRODUCT') OR (ItemLoc."Product Group Code" = 'MPCB') OR (ItemLoc."Product Group Code" = 'CPCB')
                 OR (ItemLoc."Item Category Code" = 'MECH') OR (ItemLoc."Item Category Code" = 'MISC') OR
                 (ItemLoc."Product Group Code" = 'PCB')) THEN BEGIN
              IF ItemLoc."Semi Mounted" = 0 THEN
                  ERROR('Please mention whether %1 is a semi-mount or not', ItemNoParam)      //Added by Sundar
          END; */

        ProdBomNo := ItemLoc."Production BOM No.";
        //MESSAGE(FORMAT(ProdBomNo));
        if ProdBomNo <> '' then begin
            ProdBomHeaderLoc2.SetRange("No.", ProdBomNo);
            if ProdBomHeaderLoc2.Find('-') then begin
                if Format(ProdBomHeaderLoc2.Status) = 'Closed' then
                    ProdBomHeaderLoc2.TestField(Status, ProdBomHeaderLoc2.Status::Certified);

                RoutingHeader.Reset;
                RoutingHeader.SetRange(RoutingHeader."No.", ProdBomNo);
                if RoutingHeader.Find('-') then begin
                    // error(ProdBomNo);
                    RoutingHeader.Status := RoutingHeader.Status::Certified;
                    RoutingHeader.statusValidate(RoutingHeader.Status::Certified);

                end;

                if Format(ProdBomHeaderLoc2.Status) <> 'Certified' then begin
                    ProdBomHeaderLoc2.Status := ProdBomHeaderLoc2.Status::Certified;
                    ProdBomHeaderLoc2.ValidateStatus(Authorised_ID_GVar, ProdBomNo, ProdBomHeaderLoc2.Status::Certified);
                end
                else begin
                    ProdBomHeaderLoc2.ValidateStatus(Authorised_ID_GVar, ProdBomNo, ProdBomHeaderLoc2.Status::Certified);
                end;
            end;

        end;
    END;


    PROCEDURE StatusCheck2(ProdBomNoParam: Code[20]);
    VAR
        ProdBomHeaderLoc: Record "Production BOM Header";
        ProdBomLineLoc: Record "Production BOM Line";
        ProdBomHeaderLoc2: Record "Production BOM Header";
        ItemLoc: Record Item;
        ProdBomNo: Code[20];
    BEGIN
        ProdBomHeaderLoc2.SetRange("No.", ProdBomNoParam);
        if ProdBomHeaderLoc2.Find('-') then begin
            if Format(ProdBomHeaderLoc2.Status) = 'Closed' then
                ProdBomHeaderLoc2.TestField(Status, ProdBomHeaderLoc2.Status::Certified);

            RoutingHeader.Reset;
            RoutingHeader.SetRange(RoutingHeader."No.", ProdBomNo);
            if RoutingHeader.Find('-') then begin
                // error(ProdBomNo);
                RoutingHeader.Status := RoutingHeader.Status::Certified;
                RoutingHeader.statusValidate(RoutingHeader.Status::Certified);

            end;

            if Format(ProdBomHeaderLoc2.Status) <> 'Certified' then begin
                ProdBomHeaderLoc2.Status := ProdBomHeaderLoc2.Status::Certified;
                ProdBomHeaderLoc2.ValidateStatus(Authorised_ID_GVar, ProdBomNo, ProdBomHeaderLoc2.Status::Certified);
            end
            else begin
                ProdBomHeaderLoc2.ValidateStatus(Authorised_ID_GVar, ProdBomNo, ProdBomHeaderLoc2.Status::Certified);
            end;

        end;

        //ProdBomHeaderLoc2.TESTFIELD(Status,ProdBomHeaderLoc2.Status::Certified);
    END;


    PROCEDURE StatusCheck3();
    VAR
        ProdBomHeaderLoc: Record "Production BOM Header";
        ProdBomLineLoc: Record "Production BOM Line";
        ProdBomHeaderLoc2: Record "Production BOM Header";
        ItemLoc: Record Item;
        ProdBomNo: Code[20];
    BEGIN
        PBMV.SetRange(PBMV."Production BOM No.", "No.");
        PBMV.SetRange(PBMV.Status, PBMV.Status::Certified);
        if PBMV.Find('+') then
            Version1 := PBMV."Version Code";

        ProdBomLineLoc.SetRange("Production BOM No.", "No.");
        if ProdBomLineLoc.Find('-') then
            repeat
                if ProdBomLineLoc.Type = ProdBomLineLoc.Type::Item then
                    StatusCheck(ProdBomLineLoc."No.")
                else
                    if ProdBomLineLoc.Type = ProdBomLineLoc.Type::"Production BOM" then
                        StatusCheck2(ProdBomLineLoc."No.");
            until ProdBomLineLoc.Next = 0;
    END;


    PROCEDURE StatusCheck4();
    BEGIN
        //MESSAGE('HAI');
        // IF USERID<>'EFFTRONICS\DIR@EFFTRONICS.COM#MURALI' THEN BEGIN
        if "Stranded BOM" = true then
            if UserId <> 'EFFTRONICS\JHANSI' then begin
                Error('Not possible to underdevelopment');
                Status := Status::Certified;
            end
            else
                Status := "BOM Status".FromInteger(2);
    END;


    PROCEDURE CALC_SOLDERING_POINTS("BOM NO.": Code[20]);
    VAR
        BOM_LINE: Record "Production BOM Line";
        BOM_HEADER: Record "Production BOM Header";
        BOM_ITEM: Record Item;
        BOM_HEADER2: Record "Production BOM Header";
        Item: Record Item;
    BEGIN
        if BOM_HEADER.Get("BOM NO.") then begin
            BOM_HEADER."Total Soldering Points SMD" := 0;
            BOM_HEADER."Total Soldering Points DIP" := 0;
            BOM_HEADER."Total Soldering Points" := 0;
            BOM_LINE.SetRange(BOM_LINE."Production BOM No.", BOM_HEADER."No.");
            if BOM_LINE.FindSet then
                repeat
                    if BOM_HEADER2.Get(BOM_LINE."No.") then begin
                        CALC_SOLDERING_POINTS(BOM_LINE."No.");
                        BOM_LINE."No. of SMD Points" := BOM_HEADER2."Total Soldering Points SMD";
                        BOM_LINE."No. of DIP Point" := BOM_HEADER2."Total Soldering Points DIP";
                        BOM_LINE."No. of Soldering Points" := BOM_HEADER2."Total Soldering Points";
                        BOM_LINE.Modify;
                        BOM_HEADER."Total Soldering Points DIP" += BOM_HEADER2."Total Soldering Points DIP";
                        BOM_HEADER."Total Soldering Points SMD" += BOM_HEADER2."Total Soldering Points SMD";
                        BOM_HEADER."Total Soldering Points" += BOM_HEADER2."Total Soldering Points";
                    end else
                        if Item.Get(BOM_LINE."No.") then begin
                            BOM_LINE."No. of Pins" := Item."No. of Pins";
                            BOM_LINE."No. of Soldering Points" := (BOM_LINE."Quantity per" - BOM_LINE."Scrap Quantity") * Item."No. of Soldering Points";
                            BOM_LINE."Type of Solder" := Item."Type of Solder";
                            if BOM_LINE."Type of Solder".AsInteger() = 1 then
                                BOM_HEADER."Total Soldering Points SMD" += BOM_LINE."No. of Soldering Points";
                            if BOM_LINE."Type of Solder".AsInteger() = 2 then
                                BOM_HEADER."Total Soldering Points DIP" += BOM_LINE."No. of Soldering Points";
                            BOM_HEADER."Total Soldering Points" += BOM_LINE."No. of Soldering Points";
                        end;
                    BOM_LINE.Modify;
                until BOM_LINE.Next = 0;
        end;
    END;


    PROCEDURE StatusCheck_new(ItemNoParam: Code[20]);
    VAR
        ProdBomHeaderLoc: Record "Production BOM Header";
        ProdBomLineLoc: Record "Production BOM Line";
        ProdBomHeaderLoc2: Record "Production BOM Header";
        ItemLoc: Record Item;
        ProdBomNo: Code[20];
    BEGIN
        ItemLoc.Get(ItemNoParam);
        // Added by Mnraju
        if (ItemLoc."Product Group Code Cust" = 'FPRODUCT') or (ItemLoc."Product Group Code Cust" = 'CPCB') then begin
            if Format(ItemLoc."Production BOM No.") = '' then
                Error('LINK THE PRODUCTION BOM NO FOR ITEM :' + Format(ItemNoParam));
            if Format(ItemLoc."Routing No.") = '' then
                Error('LINK THE ROUTING NO FOR ITEM :' + Format(ItemNoParam));
        end;
        // end by mnraju
        ProdBomNo := ItemLoc."Production BOM No.";

        if ProdBomNo <> '' then begin
            ProdBomHeaderLoc2.SetRange("No.", ProdBomNo);
            if ProdBomHeaderLoc2.Find('-') then
                StatusCheck3_New(ProdBomHeaderLoc2."No.");
        end;
    END;


    PROCEDURE StatusCheck2_New(ProdBomNoParam: Code[20]);
    VAR
        ProdBomHeaderLoc: Record "Production BOM Header";
        ProdBomLineLoc: Record "Production BOM Line";
        ProdBomHeaderLoc2: Record "Production BOM Header";
        ItemLoc: Record Item;
        ProdBomNo: Code[20];
    BEGIN
        ProdBomHeaderLoc2.SetRange("No.", ProdBomNoParam);
        if ProdBomHeaderLoc2.Find('-') then
            StatusCheck3_New(ProdBomHeaderLoc2."No.");
    END;


    PROCEDURE StatusCheck3_New(No: Code[20]);
    VAR
        ProdBomHeaderLoc: Record "Production BOM Header";
        ProdBomLineLoc: Record "Production BOM Line";
        ProdBomHeaderLoc2: Record "Production BOM Header";
        ItemLoc: Record Item;
        ProdBomNo: Code[20];
        Item: Record Item;
        ProdBOMHeader: Record "Production BOM Header";
    BEGIN
        PBMV.SetRange(PBMV."Production BOM No.", No);
        PBMV.SetRange(PBMV.Status, PBMV.Status::Certified);
        if PBMV.Find('+') then
            Version1 := PBMV."Version Code";

        ProdBomLineLoc.SetRange("Production BOM No.", No);
        if ProdBomLineLoc.Find('-') then begin
            ProdBOMHeader.Reset;
            ProdBOMHeader.SetFilter(ProdBOMHeader."No.", No);
            if ProdBOMHeader.FindFirst then begin
                if not Item.Get(No) then begin
                    //IF ProdBOMHeader."BOM Type"=ProdBOMHeader."BOM Type"::" " THEN
                    // ERROR('SPECIFY THE BOM TYPE IN  BOM :'+FORMAT(No));commented by vijaya on 08-May-17
                end
                else begin
                    if (Item."Product Group Code Cust" = 'FPRODUCT') or (Item."Product Group Code Cust" = 'CPCB') then begin
                        if Format(Item."Production BOM No.") = '' then
                            Error('LINK THE PRODUCTION BOM NO FOR ITEM :' + Format(No));
                        if Format(Item."Routing No.") = '' then
                            Error('LINK THE ROUTING NO FOR ITEM :' + Format(No));
                    end;
                end;

                ProdBOMHeader.Certify := 4;//ProdBOMHeader.Certify+1;
                ProdBOMHeader.CertifyStatus := 0;
                ProdBOMHeader.CertifyModDate := CurrentDateTime;
                ProdBOMHeader.Modify;
            end;
            repeat
                if ProdBomLineLoc."Quantity per" <= 0 then
                    Error('Quantity Per field must be greater than 0. for the BOM:' + Format(No) + ' in Line No:' + Format(ProdBomLineLoc."Line No."));
                if Item.Get(ProdBomLineLoc."No.") then begin
                    if not (Item."Product Group Code Cust" in ['FPRODUCT', 'CPCB']) then begin
                        if ProdBomLineLoc."Material Reqired Day" <= 0 then
                            Error('Material Required Day field must be greater than 0. for the BOM:' + Format(No) + ' in Line No:' + Format(ProdBomLineLoc."Line No."));
                    end;
                end;


                if ProdBomLineLoc.Type = ProdBomLineLoc.Type::Item then
                    StatusCheck_new(ProdBomLineLoc."No.")
                else
                    if ProdBomLineLoc.Type = ProdBomLineLoc.Type::"Production BOM" then
                        StatusCheck2_New(ProdBomLineLoc."No.");
            until ProdBomLineLoc.Next = 0;
        end;
    end;

    PROCEDURE ValidateStatus(Authorised_ID_LVar: Code[50]; BOM: Code[20]; StatusLVAr: Enum "BOM Status");
    VAR
        PlanningAssignment: Record "Planning Assignment";
        MfgSetup: Record "Manufacturing Setup";
        ProdBOMCheck: Codeunit "Production BOM-Check";
        PRMIntegration: Codeunit SQLIntegration;
        BOMLine: Record "Production BOM Line";
        PrevItem: Text;
        PrevPosition: Text;
        PrevDescription: Text[250];

    BEGIN

        PrevItem := '';
        PrevPosition := '';
        PrevDescription := '';
        BOMLine.Reset;
        BOMLine.SetCurrentKey(Type, "No.");
        BOMLine.SetRange("Version Code", '');
        BOMLine.SetRange("Production BOM No.", "No.");
        if BOMLine.FindSet then
            repeat
                if (PrevItem = BOMLine."No.") and (PrevPosition = BOMLine.Position) and (PrevDescription = BOMLine.Description) then
                    Error('BOM having Duplicate Item :: ' + PrevItem + ' With the BOM No::' + "No.");
                PrevItem := BOMLine."No.";
                PrevPosition := BOMLine.Position;
            until BOMLine.Next = 0;
        Authorised_ID_GVar := Authorised_ID_LVar;

        if Status = Status::Certified then
            StatusCheck3;

        if Status.AsInteger() = 2 then
            StatusCheck4;


        if /*(Status <> xRec.Status) AND*/ (Status = Status::Certified) then begin
            if RecordLevelLocking then begin
                MfgSetup.LockTable;
                MfgSetup.Get;
            end;
            ProdBOMCheck.ProdBOMLineCheck("No.", '');
            "Low-Level Code" := 0;
            ProdBOMCheck.Run(Rec);
            PlanningAssignment.NewBOM("No.");
        end;

        MfgSetup.Get();
        "Total No. of Fixing Holes" := 0;
        ProdBOMLineRec.Reset;
        ProdBOMLineRec.SetRange("Production BOM No.", "No.");
        ProdBOMLineRec.SetRange("Version Code", '');
        if ProdBOMLineRec.FindSet then
            repeat
                "Total No. of Fixing Holes" := "Total No. of Fixing Holes" + ProdBOMLineRec."No. of Fixing Holes";
            until ProdBOMLineRec.Next = 0;

        //NSS 140907
        "Total Soldering Points SMD" := 0;
        "Total Soldering Points DIP" := 0;
        "Total Soldering Points" := 0;


        TypeofSolder := false;
        ProdBOMLineRec.Reset;
        ProdBOMLineRec.SetRange("Production BOM No.", "No.");
        ProdBOMLineRec.SetRange("Version Code", '');
        if ProdBOMLineRec.FindSet then
            repeat
                if ProdBOMLineRec."Type of Solder".AsInteger() > 0 then
                    TypeofSolder := true;

                if ProdBOMHeader.Get(ProdBOMLineRec."No.") then begin
                    CALC_SOLDERING_POINTS(ProdBOMLineRec."No.");
                    ProdBOMLineRec."No. of Soldering Points" := ProdBOMLineRec."Quantity per" * ProdBOMHeader."Total Soldering Points";
                    ProdBOMLineRec."No. of SMD Points" := ProdBOMLineRec."Quantity per" * ProdBOMHeader."Total Soldering Points SMD";
                    ProdBOMLineRec."No. of DIP Point" := ProdBOMLineRec."Quantity per" * ProdBOMHeader."Total Soldering Points DIP";

                end else
                    if Item.Get(ProdBOMLineRec."No.") then begin
                        ProdBOMLineRec."No. of Pins" := Item."No. of Pins";
                        ProdBOMLineRec."No. of Soldering Points" := Item."No. of Soldering Points" * (ProdBOMLineRec.Quantity -
                                                                                                      ProdBOMLineRec."Scrap Quantity");
                        ProdBOMLineRec."Type of Solder" := Item."Type of Solder";
                    end;


                ProdBOMLineRec.Modify;
            until ProdBOMLineRec.Next = 0;

        if TypeofSolder = true then begin
            //Commentd on 011007
            ProdBOMLineRec.Reset;
            ProdBOMLineRec.SetRange("Production BOM No.", "No.");
            ProdBOMLineRec.SetRange("Version Code", '');
            ProdBOMLineRec.SetFilter("Type of Solder", '%1', ProdBOMLineRec."Type of Solder"::SMD);
            if ProdBOMLineRec.Find('-') then
                repeat
                    "Total Soldering Points SMD" := "Total Soldering Points SMD" + ProdBOMLineRec."No. of Soldering Points";
                until ProdBOMLineRec.Next = 0;

            ProdBOMLineRec.Reset;
            ProdBOMLineRec.SetRange("Production BOM No.", "No.");
            ProdBOMLineRec.SetRange("Version Code", '');
            ProdBOMLineRec.SetFilter("Type of Solder", '%1', ProdBOMLineRec."Type of Solder"::DIP);
            if ProdBOMLineRec.Find('-') then
                repeat
                    if Item.Get(ProdBOMLineRec."No.") then
                        ProdBOMLineRec."No. of Soldering Points" := Item."No. of Soldering Points" * (ProdBOMLineRec.Quantity -
                                                                                             ProdBOMLineRec."Scrap Quantity");
                    "Total Soldering Points DIP" := "Total Soldering Points DIP" + ProdBOMLineRec."No. of Soldering Points";
                until ProdBOMLineRec.Next = 0;

            ProdBOMLineRec.Reset;
            ProdBOMLineRec.SetRange("Production BOM No.", "No.");
            ProdBOMLineRec.SetRange("Version Code", '');
            ProdBOMLineRec.SetFilter("Type of Solder", '%1', ProdBOMLineRec."Type of Solder"::" ");
            if ProdBOMLineRec.Find('-') then
                repeat
                    "Total Soldering Points SMD" := "Total Soldering Points SMD" + ProdBOMLineRec."No. of SMD Points";
                    "Total Soldering Points DIP" := "Total Soldering Points DIP" + ProdBOMLineRec."No. of DIP Point";
                until ProdBOMLineRec.Next = 0;
            "Total Soldering Points" := "Total Soldering Points DIP" + "Total Soldering Points SMD";
        end;

        if TypeofSolder = false then begin
            if Status = Status::Certified then begin
                ProdBOMHeader.Reset;
                ProdBOMLineRec.Reset;
                Item.Reset;
                ProdBOMLineRec.SetRange("Production BOM No.", "No.");
                ProdBOMLineRec.SetRange("Version Code", '');
                if ProdBOMLineRec.Find('-') then
                    repeat
                        if ProdBOMLineRec.Type = ProdBOMLineRec.Type::Item then begin
                            Item.Get(ProdBOMLineRec."No.");
                            if ProdBOMHeader.Get(Item."Production BOM No.") then begin
                                ProdBOMHeader.TestField(Status, ProdBOMHeader.Status::Certified);
                                "Total Soldering Points SMD" := "Total Soldering Points SMD" + (ProdBOMHeader."Total Soldering Points SMD" *
                                                                                                 ProdBOMLineRec."Quantity per");
                                "Total Soldering Points DIP" := "Total Soldering Points DIP" + (ProdBOMHeader."Total Soldering Points DIP" *
                                                                                               ProdBOMLineRec."Quantity per");
                            end;
                        end else begin
                            if ProdBOMLineRec.Type = ProdBOMLineRec.Type::"Production BOM" then begin
                                if ProdBOMHeader.Get(ProdBOMLineRec."No.") then begin
                                    ProdBOMHeader.TestField(Status, ProdBOMHeader.Status::Certified);
                                    "Total Soldering Points SMD" := "Total Soldering Points SMD" + (ProdBOMHeader."Total Soldering Points SMD" *
                                                                                                    ProdBOMLineRec."Quantity per");
                                    "Total Soldering Points DIP" := "Total Soldering Points DIP" + (ProdBOMHeader."Total Soldering Points DIP" *
                                                                                                  ProdBOMLineRec."Quantity per");
                                end;
                            end;
                        end;
                    until ProdBOMLineRec.Next = 0;
            end;
            "Total Soldering Points" := "Total Soldering Points DIP" + "Total Soldering Points SMD";
        end;

        "Bench Mark Time(In Hours)" := "Total Soldering Points SMD" * (MfgSetup."Soldering Time Req.for BID" / 3600) +
                                       "Total Soldering Points DIP" * (MfgSetup."Soldering Time Req.for DIP" / 3600) +
                                       "Total No. of Fixing Holes" * (MfgSetup."Total Fixing Points Time" / 3600);

        ProdBOMLineRec.Reset;
        ProdBOMLineRec.SetRange("Production BOM No.", "No.");
        ProdBOMLineRec.SetRange("Version Code", '');
        if ProdBOMLineRec.Find('-') then
            repeat
                // Condition added by Vijaya on 20-01-2018 for BOM Type need not be update While Line Item had a BOM Type.
                if ProdBOMLineRec."BOM Type" = ProdBOMLineRec."BOM Type"::" " then begin
                    ProdBOMLineRec."BOM Type" := ProdBOMLineRec."BOM Type";
                    ProdBOMLineRec.Modify;
                end;
            //end by vijaya
            until ProdBOMLineRec.Next = 0;

        Modify(true);

        RoutingHeader.Reset;
        RoutingHeader.SetRange(RoutingHeader."No.", BOM);
        if RoutingHeader.Find('-') then begin
            // error(ProdBomNo);
            RoutingHeader.Status := RoutingHeader.Status::Certified;
            RoutingHeader.statusValidate(RoutingHeader.Status::Certified);

        end;


        //IF (Status = xRec.Status) THEN
        //  EXIT;

        if not (UpperCase(UserId) in ['EFFTRONICS\MNRAJU', 'EFFTRONICS\RAKESHT']) then begin
            if Status = Status::Certified then begin
                "NewNo." := CopyStr("No.", 1, 7);
                if ("Creation Date" >= DMY2Date(1, 1, 2011)) and ("NewNo." = 'ECPBPCB') then begin
                    if not "mail check" then begin
                        user.Reset;
                        user.SetFilter(user."User Name", UserId);//Rev01
                        if user.Find('-') then begin
                            //NAME := 'ERP';//user."Full Name";//Rev01   //B2BUPG
                            Body := '<br>The Production Bom "' + Format("No.") + '"  (' + Description + ') is certified by user ';
                            Body += Format(Authorised_ID_GVar);//  FORMAT(NAME)+'('+FORMAT(USERID)+')';//Authorised_ID_GVar
                            Body += '<br><br><br><b><u> NOTE:- </u></B> Please Post the Layout using PRM Layout Software';
                            Body += '<br><br><br>*** This is a Auto Mail Generated From ERP ***';
                            Mail_Subject := 'New Production BOM was Created';
                            /*from_Mail := 'noreply@efftronics.com'; //FORMAT(user.MailID);
                             to_mail := 'erp@efftronics.com';//'Layouts1@efftronics.com';
                            SMTP_MAIL.CreateMessage(NAME, from_Mail, to_mail, Mail_Subject, Body, true);
                            Recipients += 'prm@efftronics.com,layouts1@efftronics.com,padmaja@efftronics.com,bharat@efftronics.com';
                            // Recipients +='sitarani@efftronics.com,jhansi@efftronics.com';
                            SMTP_MAIL.AddCC(Recipients);
                            //  SMTP_MAIL.Send; */          //B2BUPG

                            Recipients.Add('erp@efftronics.com');
                            Recipients.Add('prm@efftronics.com');
                            Recipients.Add('layouts1@efftronics.com');
                            Recipients.Add('padmaja@efftronics.com');
                            Recipients.Add('bharat@efftronics.com');
                            EmailMessage.Create(Recipients, Mail_Subject, Body, true);
                            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                            "mail check" := true;
                            Commit;
                            
                            //MESSAGE('Mail was succesfully sent to Layouts Department');//Suvarchala
              MESSAGE('Mail was succesfully sent');
                        end;
                    end;
                end;
            end;
        end;




        // PRM Integration
        /* IF Status=Status::Certified  THEN
        BEGIN
         PRMIntegration.ProdBOMHeadertoPRM(Rec);
        END; */
        // PRM Integration


        Commit;
    END;

    PROCEDURE ClearCertify(No: Code[20]);
    VAR
        ProdBomHeaderLoc: Record "Production BOM Header";
        ProdBomLineLoc: Record "Production BOM Line";
        ProdBomHeaderLoc2: Record "Production BOM Header";
        ItemLoc: Record Item;
        ProdBomNo: Code[20];
    BEGIN
        // Added by Rakesh to clear Certify when BOM Approval is finished on 11-Jul-14
        ProdBomLineLoc.SetRange("Production BOM No.", No);
        if ProdBomLineLoc.Find('-') then begin
            ProdBOMHeader.Reset;
            ProdBOMHeader.SetFilter(ProdBOMHeader."No.", No);
            if ProdBOMHeader.FindFirst then begin
                if ProdBOMHeader.Certify > 0 then begin
                    ProdBOMHeader.Certify := ProdBOMHeader.Certify - 1;
                    ProdBOMHeader.Modify;
                end;
            end;
            repeat
                if ProdBomLineLoc.Type = ProdBomLineLoc.Type::Item then
                    ClearCertify2(ProdBomLineLoc."No.")
                else
                    if ProdBomLineLoc.Type = ProdBomLineLoc.Type::"Production BOM" then
                        ClearCertify3(ProdBomLineLoc."No.");
            until ProdBomLineLoc.Next = 0;
        end;
        //End by Rakesh
    END;


    PROCEDURE ClearCertify2(ItemNoParam: Code[20]);
    VAR
        ProdBomHeaderLoc: Record "Production BOM Header";
        ProdBomLineLoc: Record "Production BOM Line";
        ProdBomHeaderLoc2: Record "Production BOM Header";
        ItemLoc: Record Item;
        ProdBomNo: Code[20];
    BEGIN
        // Added by Rakesh to clear Certify when BOM Approval is finished on 11-Jul-14
        ItemLoc.Get(ItemNoParam);
        ProdBomNo := ItemLoc."Production BOM No.";

        if ProdBomNo <> '' then begin
            ProdBomHeaderLoc2.SetRange("No.", ProdBomNo);
            if ProdBomHeaderLoc2.Find('-') then
                ClearCertify(ProdBomHeaderLoc2."No.");
        end;
        //End by Rakesh
    END;


    PROCEDURE ClearCertify3(ProdBomNoParam: Code[20]);
    VAR
        ProdBomHeaderLoc: Record "Production BOM Header";
        ProdBomLineLoc: Record "Production BOM Line";
        ProdBomHeaderLoc2: Record "Production BOM Header";
        ItemLoc: Record Item;
        ProdBomNo: Code[20];
    BEGIN
        // Added by Rakesh to clear Certify when BOM Approval is finished on 11-Jul-14
        ProdBomHeaderLoc2.SetRange("No.", ProdBomNoParam);
        if ProdBomHeaderLoc2.Find('-') then
            ClearCertify(ProdBomHeaderLoc2."No.");
        //End by Rakesh
    END;


    PROCEDURE StatusCheck_Solder(ItemNoParam: Code[20]);
    VAR
        ProdBomHeaderLoc: Record "Production BOM Header";
        ProdBomLineLoc: Record "Production BOM Line";
        ProdBomHeaderLoc2: Record "Production BOM Header";
        ItemLoc: Record Item;
        ProdBomNo: Code[20];
    BEGIN
        ItemLoc.Get(ItemNoParam);
        if (ItemLoc."Product Group Code Cust" = 'FPRODUCT') or (ItemLoc."Product Group Code Cust" = 'CPCB') then begin
            if Format(ItemLoc."Production BOM No.") = '' then
                Error('LINK THE PRODUCTION BOM NO FOR ITEM :' + Format(ItemNoParam));
            if Format(ItemLoc."Routing No.") = '' then
                Error('LINK THE ROUTING NO FOR ITEM :' + Format(ItemNoParam));
        end;
        ProdBomNo := ItemLoc."Production BOM No.";


        if ProdBomNo <> '' then begin
            ProdBomHeaderLoc2.SetRange("No.", ProdBomNo);
            if ProdBomHeaderLoc2.Find('-') then begin
                StatusCheck3_Solder(ProdBomHeaderLoc2."No.");
                SolderingPointsUpdate(ProdBomHeaderLoc2."No.");
            end;
        end;
    END;


    PROCEDURE StatusCheck2_Solder(ProdBomNoParam: Code[20]);
    VAR
        ProdBomHeaderLoc: Record "Production BOM Header";
        ProdBomLineLoc: Record "Production BOM Line";
        ProdBomHeaderLoc2: Record "Production BOM Header";
        ItemLoc: Record Item;
        ProdBomNo: Code[20];
    BEGIN
        ProdBomHeaderLoc2.SetRange("No.", ProdBomNoParam);
        if ProdBomHeaderLoc2.Find('-') then begin
            StatusCheck3_Solder(ProdBomHeaderLoc2."No.");
            SolderingPointsUpdate(ProdBomHeaderLoc2."No.");
        end;
    END;


    PROCEDURE StatusCheck3_Solder(No: Code[20]);
    VAR
        ProdBomHeaderLoc: Record "Production BOM Header";
        ProdBomLineLoc: Record "Production BOM Line";
        ProdBomHeaderLoc2: Record "Production BOM Header";
        ItemLoc: Record Item;
        ProdBomNo: Code[20];
        Item: Record Item;
    BEGIN


        PBMV.SetRange(PBMV."Production BOM No.", No);
        PBMV.SetRange(PBMV.Status, PBMV.Status::Certified);
        if PBMV.Find('+') then
            Version1 := PBMV."Version Code";

        ProdBomLineLoc.SetRange("Production BOM No.", No);
        if ProdBomLineLoc.Find('-') then begin
            ProdBOMHeader.Reset;
            ProdBOMHeader.SetFilter(ProdBOMHeader."No.", No);
            if ProdBOMHeader.FindFirst then begin
                if not Item.Get(No) then begin
                    // IF ProdBOMHeader."BOM Type"=ProdBOMHeader."BOM Type"::" " THEN
                    //  ERROR('SPECIFY THE BOM TYPE IN  BOM :'+FORMAT(No)); commented by vijaya on 08-May-17
                end
                else begin
                    if (Item."Product Group Code Cust" = 'FPRODUCT') or (Item."Product Group Code Cust" = 'CPCB') then begin
                        if Format(Item."Production BOM No.") = '' then
                            Error('LINK THE PRODUCTION BOM NO FOR ITEM :' + Format(No));
                        if Format(Item."Routing No.") = '' then
                            Error('LINK THE ROUTING NO FOR ITEM :' + Format(No));
                    end;
                end;
            end;
            repeat
                if ProdBomLineLoc."Quantity per" <= 0 then
                    Error('Quantity Per field must be greater than 0. for the BOM:' + Format(No) + ' in Line No:' + Format(ProdBomLineLoc."Line No."));
                if ProdBomLineLoc.Type = ProdBomLineLoc.Type::Item then
                    StatusCheck_Solder(ProdBomLineLoc."No.")
                else
                    if ProdBomLineLoc.Type = ProdBomLineLoc.Type::"Production BOM" then
                        StatusCheck2_Solder(ProdBomLineLoc."No.");

            // SolderingPointsUpdate(ProdBomLineLoc."No.");

            until ProdBomLineLoc.Next = 0;
        end;
    END;


    PROCEDURE SolderingPointsUpdate(No: Code[20]);
    VAR
        ProductionBomHeader: Record "Production BOM Header";
    BEGIN

        ProductionBomHeader.Reset;
        ProductionBomHeader.SetFilter(ProductionBomHeader."No.", No);
        if ProductionBomHeader.FindFirst then begin
            ProductionBomHeader."Total Soldering Points SMD" := 0;
            ProductionBomHeader."Total Soldering Points DIP" := 0;
            ProductionBomHeader."Total Soldering Points" := 0;


            TypeofSolder := false;
            ProdBOMLineRec.Reset;
            ProdBOMLineRec.SetRange("Production BOM No.", No);
            ProdBOMLineRec.SetRange("Version Code", '');
            if ProdBOMLineRec.FindSet then
                repeat
                    if ProdBOMLineRec."Type of Solder".AsInteger() > 0 then
                        TypeofSolder := true;

                    if ProdBOMHeader.Get(ProdBOMLineRec."No.") then begin
                        CALC_SOLDERING_POINTS(ProdBOMLineRec."No.");
                        ProdBOMLineRec."No. of Soldering Points" := ProdBOMLineRec."Quantity per" * ProdBOMHeader."Total Soldering Points";
                        ProdBOMLineRec."No. of SMD Points" := ProdBOMLineRec."Quantity per" * ProdBOMHeader."Total Soldering Points SMD";
                        ProdBOMLineRec."No. of DIP Point" := ProdBOMLineRec."Quantity per" * ProdBOMHeader."Total Soldering Points DIP";

                    end else
                        if Item.Get(ProdBOMLineRec."No.") then begin
                            ProdBOMLineRec."No. of Pins" := Item."No. of Pins";
                            ProdBOMLineRec."No. of Soldering Points" := Item."No. of Soldering Points" * (ProdBOMLineRec.Quantity -
                                                                                                          ProdBOMLineRec."Scrap Quantity");
                            ProdBOMLineRec."Type of Solder" := Item."Type of Solder";
                        end;


                    ProdBOMLineRec.Modify;
                until ProdBOMLineRec.Next = 0;

            if TypeofSolder = true then begin
                //Commentd on 011007
                ProdBOMLineRec.Reset;
                ProdBOMLineRec.SetRange("Production BOM No.", No);
                ProdBOMLineRec.SetRange("Version Code", '');
                ProdBOMLineRec.SetFilter("Type of Solder", '%1', ProdBOMLineRec."Type of Solder"::SMD);
                if ProdBOMLineRec.Find('-') then
                    repeat
                        ProductionBomHeader."Total Soldering Points SMD" := ProductionBomHeader."Total Soldering Points SMD" + ProdBOMLineRec."No. of Soldering Points";
                    until ProdBOMLineRec.Next = 0;

                ProdBOMLineRec.Reset;
                ProdBOMLineRec.SetRange("Production BOM No.", No);
                ProdBOMLineRec.SetRange("Version Code", '');
                ProdBOMLineRec.SetFilter("Type of Solder", '%1', ProdBOMLineRec."Type of Solder"::DIP);
                if ProdBOMLineRec.Find('-') then
                    repeat
                        if Item.Get(ProdBOMLineRec."No.") then
                            ProdBOMLineRec."No. of Soldering Points" := Item."No. of Soldering Points" * (ProdBOMLineRec.Quantity -
                                                                                                 ProdBOMLineRec."Scrap Quantity");
                        ProductionBomHeader."Total Soldering Points DIP" := ProductionBomHeader."Total Soldering Points DIP" + ProdBOMLineRec."No. of Soldering Points";
                    until ProdBOMLineRec.Next = 0;

                ProdBOMLineRec.Reset;
                ProdBOMLineRec.SetRange("Production BOM No.", No);
                ProdBOMLineRec.SetRange("Version Code", '');
                ProdBOMLineRec.SetFilter("Type of Solder", '%1', ProdBOMLineRec."Type of Solder"::" ");
                if ProdBOMLineRec.Find('-') then
                    repeat
                        ProductionBomHeader."Total Soldering Points SMD" := ProductionBomHeader."Total Soldering Points SMD" + ProdBOMLineRec."No. of SMD Points";
                        ProductionBomHeader."Total Soldering Points DIP" := ProductionBomHeader."Total Soldering Points DIP" + ProdBOMLineRec."No. of DIP Point";
                    until ProdBOMLineRec.Next = 0;
                ProductionBomHeader."Total Soldering Points" := ProductionBomHeader."Total Soldering Points DIP" + ProductionBomHeader."Total Soldering Points SMD";
            end;

            if TypeofSolder = false then begin
                // IF ProductionBomHeader.Status = ProductionBomHeader.Status ::Certified THEN
                begin
                    ProdBOMHeader.Reset;
                    ProdBOMLineRec.Reset;
                    Item.Reset;
                    ProdBOMLineRec.SetRange("Production BOM No.", No);
                    ProdBOMLineRec.SetRange("Version Code", '');
                    if ProdBOMLineRec.Find('-') then
                        repeat
                            if ProdBOMLineRec.Type = ProdBOMLineRec.Type::Item then begin
                                Item.Get(ProdBOMLineRec."No.");
                                if ProdBOMHeader.Get(Item."Production BOM No.") then begin
                                    // ProdBOMHeader.TESTFIELD(Status,ProdBOMHeader.Status::Certified);
                                    ProductionBomHeader."Total Soldering Points SMD" := ProductionBomHeader."Total Soldering Points SMD" + (ProdBOMHeader."Total Soldering Points SMD" *
                                                                                                     ProdBOMLineRec."Quantity per");
                                    ProductionBomHeader."Total Soldering Points DIP" := ProductionBomHeader."Total Soldering Points DIP" + (ProdBOMHeader."Total Soldering Points DIP" *
                                                                                                   ProdBOMLineRec."Quantity per");
                                end;
                            end else begin
                                if ProdBOMLineRec.Type = ProdBOMLineRec.Type::"Production BOM" then begin
                                    if ProdBOMHeader.Get(ProdBOMLineRec."No.") then begin
                                        // ProdBOMHeader.TESTFIELD(Status,ProdBOMHeader.Status::Certified);
                                        ProductionBomHeader."Total Soldering Points SMD" := ProductionBomHeader."Total Soldering Points SMD" + (ProdBOMHeader."Total Soldering Points SMD" *
                                                                                                        ProdBOMLineRec."Quantity per");
                                        ProductionBomHeader."Total Soldering Points DIP" := ProductionBomHeader."Total Soldering Points DIP" + (ProdBOMHeader."Total Soldering Points DIP" *
                                                                                                      ProdBOMLineRec."Quantity per");
                                    end;
                                end;
                            end;
                        until ProdBOMLineRec.Next = 0;
                end;
                ProductionBomHeader."Total Soldering Points" := ProductionBomHeader."Total Soldering Points DIP" + ProductionBomHeader."Total Soldering Points SMD";
            end;
            ProductionBomHeader.Modify(true);
        end;
    END;


    PROCEDURE StatusCheck_check(ItemNoParam: Code[20]);
    VAR
        ProdBomHeaderLoc: Record "Production BOM Header";
        ProdBomLineLoc: Record "Production BOM Line";
        ProdBomHeaderLoc2: Record "Production BOM Header";
        ItemLoc: Record Item;
        ProdBomNo: Code[20];
    BEGIN
        ItemLoc.Get(ItemNoParam);
        // Added by Mnraju
        if (ItemLoc."Product Group Code Cust" = 'FPRODUCT') or (ItemLoc."Product Group Code Cust" = 'CPCB') then begin
            if Format(ItemLoc."Production BOM No.") = '' then
                Error('LINK THE PRODUCTION BOM NO FOR ITEM :' + Format(ItemNoParam));
            if Format(ItemLoc."Routing No.") = '' then
                Error('LINK THE ROUTING NO FOR ITEM :' + Format(ItemNoParam));
        end;
        // end by mnraju

        ProdBomNo := ItemLoc."Production BOM No.";

        if ProdBomNo <> '' then begin
            ProdBomHeaderLoc2.SetRange("No.", ProdBomNo);
            if ProdBomHeaderLoc2.Find('-') then
                StatusCheck3_check(ProdBomHeaderLoc2."No.");
        end;
    END;


    PROCEDURE StatusCheck2_check(ProdBomNoParam: Code[20]);
    VAR
        ProdBomHeaderLoc: Record "Production BOM Header";
        ProdBomLineLoc: Record "Production BOM Line";
        ProdBomHeaderLoc2: Record "Production BOM Header";
        ItemLoc: Record Item;
        ProdBomNo: Code[20];
    BEGIN
        ProdBomHeaderLoc2.SetRange("No.", ProdBomNoParam);
        if ProdBomHeaderLoc2.Find('-') then
            StatusCheck3_check(ProdBomHeaderLoc2."No.");
    END;


    PROCEDURE StatusCheck3_check(No: Code[20]);
    VAR
        ProdBomHeaderLoc: Record "Production BOM Header";
        ProdBomLineLoc: Record "Production BOM Line";
        ProdBomHeaderLoc2: Record "Production BOM Header";
        ItemLoc: Record Item;
        ProdBomNo: Code[20];
        Item: Record Item;
        RoutingHeaderGRec: Record "Routing Header";
        RoutingLineGRec: Record "Routing Line";
        PBLLoc: Record "Production BOM Line";
    BEGIN
        PBMV.SetRange(PBMV."Production BOM No.", No);
        PBMV.SetRange(PBMV.Status, PBMV.Status::Certified);
        if PBMV.Find('+') then
            Version1 := PBMV."Version Code";

        ProdBomLineLoc.SetRange("Production BOM No.", No);
        if ProdBomLineLoc.Find('-') then begin
            ProdBOMHeader.Reset;
            ProdBOMHeader.SetFilter(ProdBOMHeader."No.", No);
            if ProdBOMHeader.FindFirst then begin
                if not Item.Get(No) then begin
                    //IF ProdBOMHeader."BOM Type"=ProdBOMHeader."BOM Type"::" " THEN
                    // ERROR('SPECIFY THE BOM TYPE IN  BOM :'+FORMAT(No)); commented by vijaya on 08-May-17
                end
                else begin
                    if (Item."Product Group Code Cust" = 'FPRODUCT') or (Item."Product Group Code Cust" = 'CPCB') then begin
                        if Format(Item."Production BOM No.") = '' then
                            Error('LINK THE PRODUCTION BOM NO FOR ITEM :' + Format(No));
                        if Format(Item."Routing No.") = '' then
                            Error('LINK THE ROUTING NO FOR ITEM :' + Format(No))
                        else  // Added by Pranavi on 08-Jan-2015 for routings lines checking
                        begin
                            if RoutingHeaderGRec.Get(Item."Routing No.") then begin
                                RoutingLineGRec.Reset;
                                RoutingLineGRec.SetFilter(RoutingLineGRec."Routing No.", Item."Routing No.");
                                if RoutingLineGRec.FindSet then begin
                                    if RoutingLineGRec."Operation No." = '' then
                                        Error('Operation No. is blank in Routing BOM: ' + Item."Routing No.");
                                    if (RoutingLineGRec."Operation No." <> '') and (RoutingLineGRec."Operation Description" = '') then
                                        Error('Operation Description is blank in Routing BOM: ' + Item."Routing No." + 'for operation no.:' + RoutingLineGRec."Operation No.");
                                    if RoutingLineGRec."No." = '' then
                                        Error('Dept No. is blank in Routing BOM: ' + Item."Routing No." + 'for operation no.:' + RoutingLineGRec."Operation No.");
                                    if (RoutingLineGRec."Operation No." <> '9999') and (RoutingLineGRec."Run Time" = 0) then
                                        Error('Run Time is zero in Routing BOM: ' + Item."Routing No." + 'for operation no.:' + RoutingLineGRec."Operation No.");
                                end
                                else
                                    Error('PLEASE SPECIFY ROUTING LINES FOR ROUTING BOM: ' + Item."Routing No.");
                            end;
                        end;  // End by Pranavi on 08-Jan-2015 for routings lines checking
                    end;

                    // Added by Pranavi on 26-Mar-2016 for checking Bom Type
                    /* IF (Item."Product Group Code"='FPRODUCT') THEN
                    BEGIN
                      PBLLoc.RESET;
                      PBLLoc.SETRANGE(PBLLoc."Production BOM No.",No);
                      PBLLoc.SETRANGE(PBLLoc."BOM Type",PBLLoc."BOM Type"::" ");
                      PBLLoc.SETRANGE(PBLLoc.Type,PBLLoc.Type::Item);
                      IF PBLLoc.FINDSET THEN
                      REPEAT
                        IF Item.GET(PBLLoc."No.") THEN
                          IF NOT (Item."Product Group Code" IN ['FPRODUCT','CPCB']) THEN
                            ERROR('SPECIFY THE BOM TYPE FOR '+PBLLoc."No."+' IN  BOM :'+FORMAT(No));
                      UNTIL PBLLoc.NEXT=0;
                    END; */
                    // End by Pranavi

                end;

            end;
            repeat
                if ProdBomLineLoc."Quantity per" <= 0 then
                    Error('Quantity Per field must be greater than 0. for the BOM:' + Format(No) + ' in Line No:' + Format(ProdBomLineLoc."Line No."));
                if Item.Get(ProdBomLineLoc."No.") then begin
                    if not (Item."Product Group Code Cust" in ['FPRODUCT', 'CPCB']) then begin
                        if ProdBomLineLoc."Material Reqired Day" <= 0 then
                            Error('Material Required Day field must be greater than 0. for the BOM:' + Format(No) + ' in Line No:' + Format(ProdBomLineLoc."Line No."));
                    end;
                end;


                if ProdBomLineLoc.Type = ProdBomLineLoc.Type::Item then
                    StatusCheck_check(ProdBomLineLoc."No.")
                else
                    if ProdBomLineLoc.Type = ProdBomLineLoc.Type::"Production BOM" then
                        StatusCheck2_check(ProdBomLineLoc."No.");
            until ProdBomLineLoc.Next = 0;
        end;
    END;


    PROCEDURE StatusCheck_PRM(ItemNoParam: Code[20]);
    VAR
        ProdBomHeaderLoc: Record "Production BOM Header";
        ProdBomLineLoc: Record "Production BOM Line";
        ProdBomHeaderLoc2: Record "Production BOM Header";
        ItemLoc: Record Item;
        ProdBomNo: Code[20];
        PRMIntegration: Codeunit SQLIntegration;
    BEGIN
        ItemLoc.Get(ItemNoParam);
        // Added by Mnraju
        if (ItemLoc."Product Group Code Cust" = 'FPRODUCT') or (ItemLoc."Product Group Code Cust" = 'CPCB') then begin
            if Format(ItemLoc."Production BOM No.") = '' then
                Error('LINK THE PRODUCTION BOM NO FOR ITEM :' + Format(ItemNoParam));
            if Format(ItemLoc."Routing No.") = '' then
                Error('LINK THE ROUTING NO FOR ITEM :' + Format(ItemNoParam));
        end;
        // end by mnraju

        ProdBomNo := ItemLoc."Production BOM No.";

        if ProdBomNo <> '' then begin
            ProdBomHeaderLoc2.SetRange("No.", ProdBomNo);
            if ProdBomHeaderLoc2.Find('-') then begin
                StatusCheck3_PRM(ProdBomHeaderLoc2."No.");
                PRMIntegration.ProdBOMHeadertoPRM(ProdBomHeaderLoc2);
                ProdBomHeaderLoc2."Update in PRM" := true;
                ProdBomHeaderLoc2.Modify;
            end;
        end;
    END;


    PROCEDURE StatusCheck2_PRM(ProdBomNoParam: Code[20]);
    VAR
        ProdBomHeaderLoc: Record "Production BOM Header";
        ProdBomLineLoc: Record "Production BOM Line";
        ProdBomHeaderLoc2: Record "Production BOM Header";
        ItemLoc: Record Item;
        ProdBomNo: Code[20];
        PRMIntegration: Codeunit SQLIntegration;
    BEGIN
        ProdBomHeaderLoc2.SetRange("No.", ProdBomNoParam);
        if ProdBomHeaderLoc2.Find('-') then begin
            if ProdBomHeaderLoc2.Status = ProdBomHeaderLoc2.Status::Certified then begin
                StatusCheck3_PRM(ProdBomHeaderLoc2."No.");
                PRMIntegration.ProdBOMHeadertoPRM(ProdBomHeaderLoc2);
                ProdBomHeaderLoc2."Update in PRM" := true;
                ProdBomHeaderLoc2.Modify;
            end
            else
                Error('BOM No: ' + ProdBomNoParam + ' was not certified. It must be certified to update in PRM');
        end;
    END;


    PROCEDURE StatusCheck3_PRM(No: Code[20]);
    VAR
        ProdBomHeaderLoc: Record "Production BOM Header";
        ProdBomLineLoc: Record "Production BOM Line";
        ProdBomHeaderLoc2: Record "Production BOM Header";
        ItemLoc: Record Item;
        ProdBomNo: Code[20];
        Item: Record Item;
    BEGIN
        PBMV.SetRange(PBMV."Production BOM No.", No);
        PBMV.SetRange(PBMV.Status, PBMV.Status::Certified);
        if PBMV.Find('+') then
            Version1 := PBMV."Version Code";

        ProdBomLineLoc.SetRange("Production BOM No.", No);
        if ProdBomLineLoc.Find('-') then begin
            ProdBOMHeader.Reset;
            ProdBOMHeader.SetFilter(ProdBOMHeader."No.", No);
            if ProdBOMHeader.FindFirst then begin
                if not Item.Get(No) then begin
                    // IF ProdBOMHeader."BOM Type"=ProdBOMHeader."BOM Type"::" " THEN
                    // ERROR('SPECIFY THE BOM TYPE IN  BOM :'+FORMAT(No)); commented by vijaya on 08-May-17

                end
                else begin
                    if (Item."Product Group Code Cust" = 'FPRODUCT') or (Item."Product Group Code Cust" = 'CPCB') then begin
                        if Format(Item."Production BOM No.") = '' then
                            Error('LINK THE PRODUCTION BOM NO FOR ITEM :' + Format(No));
                        if Format(Item."Routing No.") = '' then
                            Error('LINK THE ROUTING NO FOR ITEM :' + Format(No));
                    end;
                end;

            end;
            repeat
                if ProdBomLineLoc."Quantity per" <= 0 then
                    Error('Quantity Per field must be greater than 0. for the BOM:' + Format(No) + ' in Line No:' + Format(ProdBomLineLoc."Line No."));
                if Item.Get(ProdBomLineLoc."No.") then begin
                    if not (Item."Product Group Code Cust" in ['FPRODUCT', 'CPCB']) then begin
                        if ProdBomLineLoc."Material Reqired Day" <= 0 then
                            Error('Material Required Day field must be greater than 0. for the BOM:' + Format(No) + ' in Line No:' + Format(ProdBomLineLoc."Line No."));
                    end;
                end;

                if ProdBomLineLoc.Type = ProdBomLineLoc.Type::Item then
                    StatusCheck_PRM(ProdBomLineLoc."No.")
                else
                    if ProdBomLineLoc.Type = ProdBomLineLoc.Type::"Production BOM" then
                        StatusCheck2_PRM(ProdBomLineLoc."No.");
            until ProdBomLineLoc.Next = 0;
        end;
    END;


    PROCEDURE StatusCheck4_New_single_level_Approval(No: Code[20]);
    VAR
        ProdBomHeaderLoc: Record "Production BOM Header";
        ProdBomLineLoc: Record "Production BOM Line";
        ProdBomHeaderLoc2: Record "Production BOM Header";
        ItemLoc: Record Item;
        ProdBomNo: Code[20];
        Item: Record Item;
    BEGIN
        PBMV.SetRange(PBMV."Production BOM No.", No);
        PBMV.SetRange(PBMV.Status, PBMV.Status::Certified);
        if PBMV.Find('+') then
            Version1 := PBMV."Version Code";

        ProdBomLineLoc.SetRange("Production BOM No.", No);
        if ProdBomLineLoc.Find('-') then begin
            ProdBOMHeader.Reset;
            ProdBOMHeader.SetFilter(ProdBOMHeader."No.", No);
            if ProdBOMHeader.FindFirst then begin
                if not Item.Get(No) then begin
                    //IF ProdBOMHeader."BOM Type"=ProdBOMHeader."BOM Type"::" " THEN
                    // ERROR('SPECIFY THE BOM TYPE IN  BOM :'+FORMAT(No));commented by vijaya on 08-May-17
                end
                else begin
                    if (Item."Product Group Code Cust" = 'FPRODUCT') or (Item."Product Group Code Cust" = 'CPCB') then begin
                        if Format(Item."Production BOM No.") = '' then
                            Error('LINK THE PRODUCTION BOM NO FOR ITEM :' + Format(No));
                        if Format(Item."Routing No.") = '' then
                            Error('LINK THE ROUTING NO FOR ITEM :' + Format(No));
                    end;
                end;

                ProdBOMHeader.Certify := 3; // ProdBOMHeader.Certify+1; for single maill approval
                ProdBOMHeader.CertifyStatus := 0;
                ProdBOMHeader.CertifyModDate := CurrentDateTime;
                ProdBOMHeader.Modify;
            end;
            repeat
                if ProdBomLineLoc."Quantity per" <= 0 then
                    Error('Quantity Per field must be greater than 0. for the BOM:' + Format(No) + ' in Line No:' + Format(ProdBomLineLoc."Line No."));
                if Item.Get(ProdBomLineLoc."No.") then begin
                    if not (Item."Product Group Code Cust" in ['FPRODUCT', 'CPCB']) then begin
                        if ProdBomLineLoc."Material Reqired Day" <= 0 then
                            Error('Material Required Day field must be greater than 0. for the BOM:' + Format(No) + ' in Line No:' + Format(ProdBomLineLoc."Line No."));
                    end;
                end;


                if ProdBomLineLoc.Type = ProdBomLineLoc.Type::Item then
                    StatusCheck_new(ProdBomLineLoc."No.")
                else
                    if ProdBomLineLoc.Type = ProdBomLineLoc.Type::"Production BOM" then
                        StatusCheck2_New(ProdBomLineLoc."No.");
            until ProdBomLineLoc.Next = 0;
        end;
    END;


}

