codeunit 33000250 "Post-Inspection Data Sheet"
{
    // version QC1.1,WIP1.1,QCB2B1.2,Cal1.0,QCP1.0,RQC1.0,Rev01

    TableNo = "Inspection Datasheet Header";

    trigger OnRun();
    var
        temp: Record Attachments;
        PostedIR: Record "Inspection Receipt Header";
        PostedIRLine: Record "Inspection Receipt Line";
        "Count": Decimal;
        MIH: Record "Material Issues Header";
        MIL: Record "Material Issues Line";
        MAIL_FROM: Text;
        mail_to: Text;
        Subject: Text;
        Body: Text;
        "Mail-Id": Record User;
        Cnt: Integer;
        NoSeriesMgt: Codeunit 396;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
    begin
        QualitySetup.GET;
        QualitySetup.TESTFIELD("Posted Inspect. Datasheet Nos.");
        QualitySetup.TESTFIELD("Inspection Receipt Nos.");
        PostInspectData.TRANSFERFIELDS(Rec);
        //B2b sankar
        PostInspectData."Ids Reference No." := "No.";
        //B2b sankar
        IF NOT QualitySetup."Posted IDS. No. Is IDS No." THEN
            PostInspectData."No." := NoSeriesMgt.GetNextNo(QualitySetup."Posted Inspect. Datasheet Nos.", TODAY, TRUE);

        //PIDSQC1.0 100608
        IF NOT "Partial Inspection" THEN
            InspReportNo := InsertInspectionReportHeader(PostInspectData);
        PostInspectData."Inspection Receipt No." := InspReportNo;

        //B2B-GGB
        PostedAttachments(Rec, PostInspectData);
        PostedComments(Rec, PostInspectData);
        //B2B-GGB

        //B2b sankar
        PostInspectData."Ids Reference No." := "No.";
        //B2b sankar
        PostInspectData."Posted Date" := WORKDATE;
        PostInspectData."Posted Time" := TIME;
        PostInspectData."Posted By" := USERID;

        //Sundar
        IF "Receipt No." <> '' THEN BEGIN
            PRH.SETFILTER(PRH."No.", "Receipt No.");
            PRH.SETFILTER(PRH."Order No.", "Order No.");
            IF PRH.FINDFIRST THEN BEGIN
                IF PostInspectData."Posting Date" < PRH."Posting Date" THEN
                    ERROR(Text001, PRH."Posting Date");
            END;
        END;


        //B2B-KNR
        Users.RESET;//Rev01
        Users.SETRANGE("User Name", PostInspectData."Posted By");//Rev01
        IF Users.FINDFIRST THEN
            PostInspectData."Posted By Name" := Users."User Name"
        ELSE
            MESSAGE('User ID Not found in User Table');

        PostInspectData.INSERT;

        InspectDataLine.SETRANGE("Document No.", "No.");
        InspectDataLine.SETCURRENTKEY("Character Group No.");
        InspectReport.SETRANGE("Document No.", InspReportNo);
        IF InspectReport.FINDLAST THEN
            LineNo := InspectReport."Line No.";
        CharGroupCode := 0;
        IF InspectDataLine.FINDSET THEN BEGIN
                                            REPEAT
                                                PostInspectDataLine.TRANSFERFIELDS(InspectDataLine);
                                                PostInspectDataLine."Document No." := PostInspectData."No.";

                                                //B2B-KNR
                                                PostInspectDataLine."IDS No." := InspectDataLine."Document No.";
                                                PostInspectDataLine."IDS Line No." := InspectDataLine."Line No.";

                                                PostInspectDataLine.INSERT;
                                                IF CharGroupCode <> InspectDataLine."Character Group No." THEN BEGIN
                                                    LineNo := LineNo + 1;
                                                    CharGroupCode := InspectDataLine."Character Group No.";
                                                    InspectReport.INIT;
                                                    InspectReport.TRANSFERFIELDS(InspectDataLine);
                                                    InspectReport."Document No." := InspReportNo;
                                                    InspectReport."Line No." := LineNo + 10000;
                                                    InspectReport."Receipt No." := "Receipt No.";
                                                    InspectReport."Posting Date" := TODAY;
                                                    //InspectReport."Item No." := "Item No."; //B2B ARN
                                                    InspectReport."Vendor No." := "Vendor No.";
                                                    InspectReport."Purch Line No." := PostInspectData."Purch Line No";
                                                    InspectReport."Posted Inspect Doc. No." := PostInspectData."No.";
                                                    //b2b EFF
                                                    InspectReport."IDS No." := InspectDataLine."Document No.";
                                                    InspectReport."IDS Line No." := InspectDataLine."Line No.";
                                                    //b2b EFF
                                                    //PIDSQC1.0 100608
                                                    IF NOT "Partial Inspection" THEN
                                                        InspectReport.INSERT;
                                                END;
                                            UNTIL InspectDataLine.NEXT = 0;
        END;

        MESSAGE(Text000);
        /*
        attachment.SETRANGE("Ids Reference No.","No.");
         IF attachment.FINDSET THEN BEGIN
          REPEAT
            temp.TRANSFERFIELDS(attachment);
            attachment.DELETE;
            temp.INSERT;
            attachment.TRANSFERFIELDS(temp);
            attachment."Table ID" :=33000263;
            attachment.INSERT;
            temp.DELETE;
           UNTIL attachment.NEXT=0;
        END;
        */

        Cnt := 0;
        MIH.RESET;
        MIH.SETFILTER(MIH."Transfer-from Code", '%1|%2', 'STR', 'MCH');
        MIH.SETRANGE(MIH."Transfer-to Code", 'PROD');
        //MIH.SETRANGE(MIH."User ID",'EFFTRONICS\GRAVI');
        MIH.SETRANGE("Auto Post", TRUE);
        IF MIH.FINDSET THEN
                REPEAT
                    MIL.RESET;
                    MIL.SETRANGE(MIL."Document No.", MIH."No.");
                    MIL.SETRANGE(MIL."Item No.", "Item No.");
                    IF MIL.FINDSET THEN
                            REPEAT
                                /* MAIL_FROM := 'erp@efftronics.com';
                                mail_to := 'erp@efftronics.com';
                                Subject := 'ERP- Material Shortage Item (' + "Item Description" + ') inwarded';
                                Body := '';
                                SMTP_mail.CreateMessage('ERP', MAIL_FROM, mail_to, Subject, Body, TRUE);
                                SMTP_mail.AppendBody('<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>');
                                SMTP_mail.AppendBody('<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;"><label><font size="6">Item Inwarded to Stores</font></label>');
                                SMTP_mail.AppendBody('<hr style=solid; color= #3333CC>');
                                SMTP_mail.AppendBody('<h>Dear Sir/Madam,</h><br>');
                                SMTP_mail.AppendBody('<P> Shortage Material Item Details. Please Move the Item to production because item is Shortage at Production  </P>');
                                SMTP_mail.AppendBody('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><td width="40%"><b> Item Description </b> </td><td>' + "Item Description" + '</td></tr>');
                                SMTP_mail.AppendBody('<tr><td><b> Inward DATE & TIME </b> </td><td>' + FORMAT((TODAY), 0, 4) + FORMAT(TIME) + '</td></tr>');
                                //SMTP_mail.AppendBody('<tr><td><b> Indent Number </b> </td><td>' +PurchLine."Indent No."+'</td></tr>');
                                SMTP_mail.AppendBody('<tr><td><b>Purchase Order No </b></td><td>' + "Order No." + '</td></tr>');
                                SMTP_mail.AppendBody('<tr><td><b>Vendor Name </b>    </td><td>' + "Vendor Name" + '</td></tr>');
                                SMTP_mail.AppendBody('<tr><td><b> Received quantity </b></td><td>' + FORMAT(Quantity) + '</td></tr>');
                                "Mail-Id".RESET;
                                "Mail-Id".SETRANGE("Mail-Id"."User Name", USERID);
                                IF "Mail-Id".FINDFIRST THEN BEGIN
                                    SMTP_mail.AppendBody('<tr><td><b> Inward By </b></td><td>' + "Mail-Id"."User Name" + '</td></tr>');
                                END;
                                SMTP_mail.AppendBody('</table>');
                                SMTP_mail.AppendBody('<br>');
                                SMTP_mail.AppendBody('<p align ="left"> Regards,<br>ERP Team </p>');
                                SMTP_mail.AppendBody('<br><p align = "center">::::Note: Auto Generated mail from ERP:::: </b></P></div></body></html>');
                                SMTP_mail.Send; */      //UPG

                                MAIL_FROM := 'erp@efftronics.com';
                                Recipients.Add('erp@efftronics.com');
                                Subject := 'ERP- Material Shortage Item (' + Rec."Item Description" + ') inwarded';
                                Body := '';
                                EmailMessage.Create(Recipients, Subject, Body, true);
                                Body += ('<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>');
                                Body += ('<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;"><label><font size="6">Item Inwarded to Stores</font></label>');
                                Body += ('<hr style=solid; color= #3333CC>');
                                Body += ('<h>Dear Sir/Madam,</h><br>');
                                Body += ('<P> Shortage Material Item Details. Please Move the Item to production because item is Shortage at Production  </P>');
                                Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><td width="40%"><b> Item Description </b> </td><td>' + "Item Description" + '</td></tr>');
                                Body += ('<tr><td><b> Inward DATE & TIME </b> </td><td>' + FORMAT((TODAY), 0, 4) + FORMAT(TIME) + '</td></tr>');
                                Body += ('<tr><td><b>Purchase Order No </b></td><td>' + Rec."Order No." + '</td></tr>');
                                Body += ('<tr><td><b>Vendor Name </b>    </td><td>' + Rec."Vendor Name" + '</td></tr>');
                                Body += ('<tr><td><b> Received quantity </b></td><td>' + FORMAT(Rec.Quantity) + '</td></tr>');
                                "Mail-Id".RESET;
                                "Mail-Id".SETRANGE("Mail-Id"."User Name", USERID);
                                IF "Mail-Id".FINDFIRST THEN BEGIN
                                    Body += ('<tr><td><b> Inward By </b></td><td>' + "Mail-Id"."User Name" + '</td></tr>');
                                END;
                                Body += ('</table>');
                                Body += ('<br>');
                                Body += ('<p align ="left"> Regards,<br>ERP Team </p>');
                                Body += ('<br><p align = "center">::::Note: Auto Generated mail from ERP:::: </b></P></div></body></html>');
                                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                                Cnt := 1;//Count:=1;
                            UNTIL (MIL.NEXT = 0) OR (Cnt = 1);
                UNTIL (MIH.NEXT = 0) OR (Cnt = 1);


        Rec.DELETE(TRUE);

    end;

    var
        QualitySetup: Record "Quality Control Setup";
        InspectDataLine: Record "Inspection Datasheet Line";
        PostInspectData: Record "Posted Inspect DatasheetHeader";
        PostInspectDataLine: Record "Posted Inspect Datasheet Line";
        InspectReportHeader: Record "Inspection Receipt Header";
        InspectReport: Record "Inspection Receipt Line";
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        CharGroupCode: Integer;
        LineNo: Integer;
        Text000: Label 'Document Posted Successfully';
        InspReportNo: Code[20];
        Users: Record User;
        "//B2B attachments": Integer;
        attachment: Record Attachments;
        PRH: Record "Purch. Rcpt. Header";
        Text001: Label 'Posting date must be Greater than or equal to %1';
        NoSeriesMgt: Codeunit 396;
    //SMTP_mail: Codeunit "SMTP Mail";


    procedure InsertInspectionReportHeader(InspectHeader: Record "Posted Inspect DatasheetHeader"): Code[20];
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
    begin
        IF InspectHeader."Source Type" = InspectHeader."Source Type"::"In Bound" THEN BEGIN
            IF InspectReportHeader."Quality Before Receipt" THEN
                InspectReportHeader.SETRANGE("Order No.", InspectHeader."Order No.")
            ELSE
                IF InspectHeader."Document Type" = InspectHeader."Document Type"::Receipt THEN BEGIN
                    InspectReportHeader.SETRANGE("Receipt No.", InspectHeader."Receipt No.");
                    InspectReportHeader.SETRANGE("Purch Line No", InspectHeader."Purch Line No");
                    InspectReportHeader.SETRANGE("Lot No.", InspectHeader."Lot No.");
                    InspectReportHeader.SETRANGE("Purchase Consignment", InspectHeader."Purchase Consignment No.");
                    InspectReportHeader.SETRANGE("Rework Reference No.", InspectHeader."Rework Reference No.");
                END
                ELSE
                    IF InspectHeader."Document Type" = InspectHeader."Document Type"::"Return Orders" THEN BEGIN
                        InspectReportHeader.SETRANGE("Posted Sales Order No.", InspectHeader."Posted Sales Order No.");
                        InspectReportHeader.SETRANGE("Sales Line No", InspectHeader."Sales Line No");
                        InspectReportHeader.SETRANGE("Rework Reference No.", InspectHeader."Rework Reference No.");
                    END ELSE
                        IF InspectHeader."Document Type" = InspectHeader."Document Type"::"Item Inspection" THEN BEGIN
                            InspectReportHeader.SETFILTER("Receipt No.", '%1', '');
                            InspectReportHeader.SETFILTER("Prod. Order No.", '%1', '');
                            InspectReportHeader.SETFILTER("Order No.", '%1', '');
                            InspectReportHeader.SETFILTER("Trans. Order No.", '%1', '');
                            InspectReportHeader.SETFILTER("Posted Sales Order No.", '%1', '');
                            InspectReportHeader.SETFILTER("Item Ledger Entry No.", '%1', InspectHeader."Item Ledger Entry No.");
                            InspectReportHeader.SETFILTER(Status, 'NO');
                            InspectReportHeader.SETRANGE("Item No.", InspectHeader."Item No.");
                        END;
        END ELSE
            IF InspectHeader."Source Type" = InspectHeader."Source Type"::Calibration THEN BEGIN
                InspectReportHeader.SETRANGE("Item No.", InspectHeader."Item No.");
                InspectReportHeader.SETRANGE("Eqpt. Serial No.", InspectHeader."Eqpt. Serial No.");
                InspectReportHeader.SETRANGE(Status, FALSE);

            END ELSE BEGIN
                InspectReportHeader.SETRANGE("Prod. Order No.", InspectHeader."Prod. Order No.");
                InspectReportHeader.SETRANGE("Prod. Order Line", InspectHeader."Prod. Order Line");
                InspectReportHeader.SETRANGE("Production Batch No.", InspectHeader."Production Batch No.");
                InspectReportHeader.SETRANGE("Rework Reference No.", InspectHeader."Rework Reference No.");
            END;

        //30/0708 PIDSQC1.0>>
        IF (InspectHeader."Parent IDS No" <> '') AND (InspectHeader."Partial Inspection" = FALSE) THEN BEGIN
            //IF InspectReportHeader.FINDFIRST THEN BEGIN
            InspectReportHeader.INIT;
            InspectReportHeader."Receipt No." := InspectHeader."Receipt No.";
            InspectReportHeader."No." := NoSeriesMgt.GetNextNo(QualitySetup."Inspection Receipt Nos.", TODAY, TRUE);
            InspectReportHeader."Order No." := InspectHeader."Order No.";
            IF InspectHeader."In Process" THEN BEGIN
                InspectReportHeader."Posting Date" := WORKDATE;
                InspectReportHeader."Document Date" := WORKDATE;
            END ELSE BEGIN
                InspectReportHeader."Posting Date" := InspectHeader."Posting Date";
                InspectReportHeader."Document Date" := InspectHeader."Document Date";
            END;
            InspectReportHeader."Vendor No." := InspectHeader."Vendor No.";
            InspectReportHeader."Vendor Name" := InspectHeader."Vendor Name";
            InspectReportHeader."Vendor Name 2" := InspectHeader."Vendor Name 2";
            InspectReportHeader.Address := InspectHeader.Address;

            //B2B-KNR
            Users.RESET;//Rev01
            Users.SETRANGE("User Name", USERID);//Rev01
            IF Users.FINDFIRST THEN
                InspectReportHeader."IDS Posted By" := Users."User Name"
            ELSE
                MESSAGE('User ID not found in User Table');


            InspectReportHeader."Address 2" := InspectHeader."Address 2";
            InspectReportHeader."Contact Person" := '';
            InspectReportHeader."Item No." := InspectHeader."Item No.";
            InspectReportHeader."Item Description" := InspectHeader."Item Description";
            InspectReportHeader."External Document No." := InspectHeader."External Document No.";
            InspectReportHeader."Unit Of Measure Code" := InspectHeader."Unit Of Measure Code";
            InspectReportHeader."Created Date" := WORKDATE;
            InspectReportHeader."Created time" := TIME;
            InspectReportHeader.Quantity := InspectHeader.Quantity;
            InspectReportHeader."Spec ID" := InspectHeader."Spec ID";
            InspectReportHeader."Purch Line No" := InspectHeader."Purch Line No";
            InspectReportHeader."Location Code" := InspectHeader.Location;
            InspectReportHeader."Lot No." := InspectHeader."Lot No.";
            InspectReportHeader."Inprocess Serial No." := InspectHeader."Inprocess Serial No.";
            InspectReportHeader."OutPut Jr Serial No." := InspectHeader."OutPut Jr Serial No.";
            InspectReportHeader."OLD IDS" := InspectHeader."OLD IDS";
            InspectReportHeader."IDS creation Date" := InspectHeader."Created Date";
            InspectReportHeader.Make := InspectHeader.Make;
            InspectReportHeader.Sample := InspectHeader.Sample;
            InspectReportHeader."Parent IDS" := InspectHeader."Parent IDS No";


            //b2bRQC1.0
            InspectReportHeader."Rework Posted" := InspectHeader."Rework Posted";
            InspectReportHeader."Rework User" := InspectHeader."Rework User";
            InspectReportHeader."Finished Product Sr No" := InspectHeader."Finished Product Sr No";
            //b2bRQC1.0

            //to copy serial no and DC Inbound ledger entry no. start
            IF InspectHeader."Rework Level" <> 0 THEN
                InspectReportHeader."DC Inbound Ledger Entry." := InspectHeader."DC Inbound Ledger Entry";
            // end;
            InspectReportHeader."Serial No." := InspectHeader."Serial No.";
            InspectReportHeader."Item Tracking Exists" := InspectHeader."Item Tracking Exists";
            InspectReportHeader."Rework Reference No." := InspectHeader."Rework Reference No.";
            InspectReportHeader."Rework Level" := InspectHeader."Rework Level";
            InspectReportHeader."Item Ledger Entry No." := InspectHeader."Item Ledger Entry No.";
            InspectReportHeader."Prod. Order No." := InspectHeader."Prod. Order No.";
            InspectReportHeader."Prod. Order Line" := InspectHeader."Prod. Order Line";

            //B2Bsankar
            InspectReportHeader."Prod. Description" := InspectHeader."Prod. Description";
            InspectReportHeader."Ids Reference No." := InspectHeader."Ids Reference No.";
            //B2Bsankar
            InspectReportHeader."Item Category Code" := InspectHeader."Item Category Code";
            InspectReportHeader."Product Group Code" := InspectHeader."Product Group Code";
            InspectReportHeader."Item Sub Group Code" := InspectHeader."Item Sub Group Code";
            InspectReportHeader."Item Sub Sub Group Code" := InspectHeader."Item Sub Sub Group Code";
            InspectReportHeader."No. of Soldering Points" := InspectHeader."No. of Soldering Points";
            InspectReportHeader."No. of Pins" := InspectHeader."No. of Pins";
            InspectReportHeader."No. of Opportunities" := InspectHeader."No. of Opportunities";
            InspectReportHeader."No.of Fixing Holes" := InspectHeader."No.of Fixing Holes";
            InspectReportHeader."Reason for Pending" := InspectHeader."Reason for Pending";
            //b2b EFF
            InspectReportHeader."Routing No." := InspectHeader."Routing No.";
            InspectReportHeader."Routing Reference No." := InspectHeader."Routing Reference No.";
            InspectReportHeader."Operation No." := InspectHeader."Operation No.";
            InspectReportHeader.Resource := InspectHeader.Resource;
            InspectReportHeader."Operation Description" := InspectHeader."Operation Description";
            InspectReportHeader."Sub Assembly Code" := InspectHeader."Sub Assembly Code";
            InspectReportHeader."Sub Assembly Description" := InspectHeader."Sub Assembly Description";
            InspectReportHeader."In Process" := InspectHeader."In Process";
            InspectReportHeader."Quality Before Receipt" := InspectHeader."Quality Before Receipt";
            InspectReportHeader."Source Type" := InspectHeader."Source Type";
            InspectReportHeader."Production Batch No." := InspectHeader."Production Batch No.";
            InspectReportHeader."Purchase Consignment" := InspectHeader."Purchase Consignment No.";
            //ESPL
            InspectReportHeader."Sample Inspection Line No." := InspectHeader."Sample Inspection Line No.";
            InspectReportHeader."Customer No." := InspectHeader."Customer No.";
            InspectReportHeader."Customer Name" := InspectHeader."Customer Name";
            InspectReportHeader."Customer Name 2" := InspectHeader."Customer Name 2";
            InspectReportHeader."Customer Address" := InspectHeader."Customer Address";
            InspectReportHeader."Customer Address2" := InspectHeader."Customer Address2";
            InspectReportHeader."Sales Line No" := InspectHeader."Sales Line No";
            InspectReportHeader."Sales Order No." := InspectHeader."Sales Order No.";
            InspectReportHeader."Posted Sales Order No." := InspectHeader."Posted Sales Order No.";
            InspectReportHeader."Sample Inspection" := InspectHeader."Sample Inspection";
            //QCP1.0
            InspectReportHeader."QAS/MPR" := InspectHeader."QAS/MPR";
            //QCP1.0
            //ESPL
            //Bhavani
            InspectReportHeader."Least Count" := InspectHeader."Least Count";
            InspectReportHeader."Measuring Range" := InspectHeader."Measuring Range";
            InspectReportHeader."Model No." := InspectHeader."Model No.";
            InspectReportHeader."Serial No." := InspectHeader."Serial No.";
            InspectReportHeader.Department := InspectHeader.Department;
            InspectReportHeader."Std. Reference" := InspectHeader."Std. Reference";
            InspectReportHeader.Manufacturer := InspectHeader.Manufacturer;
            InspectReportHeader."MFG. Serial No." := InspectHeader."MFG. Serial No.";
            IF InspectReportHeader."Source Type" = InspectReportHeader."Source Type"::Calibration THEN BEGIN
                InspectReportHeader.Quantity := InspectHeader.Quantity;
                InspectReportHeader."Qty. Accepted" := InspectHeader.Quantity;
            END;
            //QCP1.0
            InspectReportHeader."Item Ledger Entry No." := InspectHeader."Item Ledger Entry No.";
            //QCP1.0

            // >>Added by Pranavi on 25-05-2017 for MSL Process
            InspectReportHeader."MBB Packed Date" := InspectHeader."MBB Packed Date";
            InspectReportHeader."MBB Packet Close DateTime" := InspectHeader."MBB Packet Close DateTime";
            InspectReportHeader."MBB Packet Open DateTime" := InspectHeader."MBB Packet Open DateTime";
            InspectReportHeader."MBB Status" := InspectHeader."MBB Status";
            InspectReportHeader."Baked Hours" := InspectHeader."Baked Hours";
            InspectReportHeader."MFD Date" := InspectHeader."MFD Date";
            InspectReportHeader."HIC 10%" := InspectHeader."HIC 10%";
            InspectReportHeader."HIC 5%" := InspectHeader."HIC 5%";
            InspectReportHeader."HIC 60%" := InspectHeader."HIC 60%";
            // <<Added by Pranavi on 25-05-2017 for MSL Process

            // Added by Vishnu Priya on 21-11-18
            InspectReportHeader."Issues For Pending" := InspectHeader."Issues For Pending";
            InspectReportHeader.INSERT;

            //B2B-GGB
            IRComments(InspectHeader, InspectReportHeader);
            IRAttachments(InspectHeader, InspectReportHeader);

            //END
        END ELSE BEGIN
            //30/07/08 PIDSQC1.0<<

            //Base PIDSQC1.0>>
            IF NOT InspectReportHeader.FINDFIRST THEN BEGIN
                InspectReportHeader.INIT;
                InspectReportHeader."Receipt No." := InspectHeader."Receipt No.";
                InspectReportHeader."No." := NoSeriesMgt.GetNextNo(QualitySetup."Inspection Receipt Nos.", TODAY, TRUE);
                ;
                InspectReportHeader."Order No." := InspectHeader."Order No.";
                IF InspectHeader."In Process" THEN BEGIN
                    InspectReportHeader."Posting Date" := WORKDATE;
                    InspectReportHeader."Document Date" := WORKDATE;
                END ELSE BEGIN
                    InspectReportHeader."Posting Date" := InspectHeader."Posting Date";
                    InspectReportHeader."Document Date" := InspectHeader."Document Date";
                END;
                InspectReportHeader."Vendor No." := InspectHeader."Vendor No.";
                InspectReportHeader."Vendor Name" := InspectHeader."Vendor Name";
                InspectReportHeader."Vendor Name 2" := InspectHeader."Vendor Name 2";
                InspectReportHeader.Address := InspectHeader.Address;

                //B2B-KNR
                Users.RESET;//Rev01
                Users.SETRANGE("User Name", USERID);//Rev01
                IF Users.FINDFIRST THEN
                    InspectReportHeader."IDS Posted By" := Users."User Name"
                ELSE
                    MESSAGE('User ID Not found in User table');

                InspectReportHeader."Address 2" := InspectHeader."Address 2";
                InspectReportHeader."Contact Person" := '';
                InspectReportHeader."Item No." := InspectHeader."Item No.";
                InspectReportHeader."Item Description" := InspectHeader."Item Description";
                InspectReportHeader."External Document No." := InspectHeader."External Document No.";
                InspectReportHeader."Unit Of Measure Code" := InspectHeader."Unit Of Measure Code";
                InspectReportHeader."Created Date" := WORKDATE;
                InspectReportHeader.Quantity := InspectHeader.Quantity;
                InspectReportHeader."Spec ID" := InspectHeader."Spec ID";
                InspectReportHeader."Purch Line No" := InspectHeader."Purch Line No";
                InspectReportHeader."Location Code" := InspectHeader.Location;
                InspectReportHeader."Lot No." := InspectHeader."Lot No.";
                InspectReportHeader."Inprocess Serial No." := InspectHeader."Inprocess Serial No.";
                InspectReportHeader."OutPut Jr Serial No." := InspectHeader."OutPut Jr Serial No.";
                InspectReportHeader."OLD IDS" := InspectHeader."OLD IDS";
                //b2bRQC1.0
                InspectReportHeader."Rework Posted" := InspectHeader."Rework Posted";
                InspectReportHeader."Rework User" := InspectHeader."Rework User";
                InspectReportHeader."Finished Product Sr No" := InspectHeader."Finished Product Sr No";
                InspectReportHeader."IDS creation Date" := InspectHeader."Created Date";
                InspectReportHeader.Make := InspectHeader.Make;
                InspectReportHeader.Sample := InspectHeader.Sample;
                InspectReportHeader."Parent IDS" := InspectHeader."Parent IDS No";

                //b2bRQC1.0

                //to copy serial no and DC Inbound ledger entry no. start
                IF InspectHeader."Rework Level" <> 0 THEN
                    InspectReportHeader."DC Inbound Ledger Entry." := InspectHeader."DC Inbound Ledger Entry";
                // end;
                InspectReportHeader."Serial No." := InspectHeader."Serial No.";
                InspectReportHeader."Item Tracking Exists" := InspectHeader."Item Tracking Exists";
                InspectReportHeader."Rework Reference No." := InspectHeader."Rework Reference No.";
                InspectReportHeader."Rework Level" := InspectHeader."Rework Level";
                InspectReportHeader."Item Ledger Entry No." := InspectHeader."Item Ledger Entry No.";
                InspectReportHeader."Prod. Order No." := InspectHeader."Prod. Order No.";
                InspectReportHeader."Prod. Order Line" := InspectHeader."Prod. Order Line";

                //B2Bsankar
                InspectReportHeader."Prod. Description" := InspectHeader."Prod. Description";
                InspectReportHeader."Ids Reference No." := InspectHeader."Ids Reference No.";
                //B2Bsankar
                InspectReportHeader."Item Category Code" := InspectHeader."Item Category Code";
                InspectReportHeader."Product Group Code" := InspectHeader."Product Group Code";
                InspectReportHeader."Item Sub Group Code" := InspectHeader."Item Sub Group Code";
                InspectReportHeader."Item Sub Sub Group Code" := InspectHeader."Item Sub Sub Group Code";
                InspectReportHeader."No. of Soldering Points" := InspectHeader."No. of Soldering Points";
                InspectReportHeader."No. of Pins" := InspectHeader."No. of Pins";
                InspectReportHeader."No. of Opportunities" := InspectHeader."No. of Opportunities";
                InspectReportHeader."No.of Fixing Holes" := InspectHeader."No.of Fixing Holes";
                InspectReportHeader."Reason for Pending" := InspectHeader."Reason for Pending";
                //b2b EFF
                InspectReportHeader."Routing No." := InspectHeader."Routing No.";
                InspectReportHeader."Routing Reference No." := InspectHeader."Routing Reference No.";
                InspectReportHeader."Operation No." := InspectHeader."Operation No.";
                InspectReportHeader.Resource := InspectHeader.Resource;
                InspectReportHeader."Operation Description" := InspectHeader."Operation Description";
                InspectReportHeader."Sub Assembly Code" := InspectHeader."Sub Assembly Code";
                InspectReportHeader."Sub Assembly Description" := InspectHeader."Sub Assembly Description";
                InspectReportHeader."In Process" := InspectHeader."In Process";
                InspectReportHeader."Quality Before Receipt" := InspectHeader."Quality Before Receipt";
                InspectReportHeader."Source Type" := InspectHeader."Source Type";
                InspectReportHeader."Production Batch No." := InspectHeader."Production Batch No.";
                InspectReportHeader."Purchase Consignment" := InspectHeader."Purchase Consignment No.";
                //ESPL
                InspectReportHeader."Sample Inspection Line No." := InspectHeader."Sample Inspection Line No.";
                InspectReportHeader."Customer No." := InspectHeader."Customer No.";
                InspectReportHeader."Customer Name" := InspectHeader."Customer Name";
                InspectReportHeader."Customer Name 2" := InspectHeader."Customer Name 2";
                InspectReportHeader."Customer Address" := InspectHeader."Customer Address";
                InspectReportHeader."Customer Address2" := InspectHeader."Customer Address2";
                InspectReportHeader."Sales Line No" := InspectHeader."Sales Line No";
                InspectReportHeader."Sales Order No." := InspectHeader."Sales Order No.";
                InspectReportHeader."Posted Sales Order No." := InspectHeader."Posted Sales Order No.";
                InspectReportHeader."Sample Inspection" := InspectHeader."Sample Inspection";
                //QCP1.0
                InspectReportHeader."QAS/MPR" := InspectHeader."QAS/MPR";
                //QCP1.0
                //ESPL
                //Bhavani
                InspectReportHeader."Least Count" := InspectHeader."Least Count";
                InspectReportHeader."Measuring Range" := InspectHeader."Measuring Range";
                InspectReportHeader."Model No." := InspectHeader."Model No.";
                InspectReportHeader."Serial No." := InspectHeader."Serial No.";
                InspectReportHeader.Department := InspectHeader.Department;
                InspectReportHeader."Std. Reference" := InspectHeader."Std. Reference";
                InspectReportHeader.Manufacturer := InspectHeader.Manufacturer;
                InspectReportHeader."MFG. Serial No." := InspectHeader."MFG. Serial No.";
                IF InspectReportHeader."Source Type" = InspectReportHeader."Source Type"::Calibration THEN BEGIN
                    InspectReportHeader.Quantity := InspectHeader.Quantity;
                    InspectReportHeader."Qty. Accepted" := InspectHeader.Quantity;
                END;
                //QCP1.0
                InspectReportHeader."Item Ledger Entry No." := InspectHeader."Item Ledger Entry No.";
                //QCP1.0

                // >>Added by Pranavi on 25-05-2017 for MSL Process
                InspectReportHeader."MBB Packed Date" := InspectHeader."MBB Packed Date";
                InspectReportHeader."MBB Packet Close DateTime" := InspectHeader."MBB Packet Close DateTime";
                InspectReportHeader."MBB Packet Open DateTime" := InspectHeader."MBB Packet Open DateTime";
                InspectReportHeader."MBB Status" := InspectHeader."MBB Status";
                InspectReportHeader."Baked Hours" := InspectHeader."Baked Hours";
                InspectReportHeader."MFD Date" := InspectHeader."MFD Date";
                InspectReportHeader."HIC 10%" := InspectHeader."HIC 10%";
                InspectReportHeader."HIC 5%" := InspectHeader."HIC 5%";
                InspectReportHeader."HIC 60%" := InspectHeader."HIC 60%";
                // <<Added by Pranavi on 25-05-2017 for MSL Process

                // <<Added By Vishnu Priya on 29-11-18
                InspectReportHeader."Issues For Pending" := InspectHeader."Issues For Pending";
                InspectReportHeader.INSERT;

                //B2B-GGB
                IRComments(InspectHeader, InspectReportHeader);
                IRAttachments(InspectHeader, InspectReportHeader);

            END;

        END;

        EXIT(InspectReportHeader."No.");

        //Base PIDSQC1.0<<
    end;


    procedure TransferOrderPostIDS(var Rec: Record "Inspection Datasheet Header");
    begin
        QualitySetup.GET;
        QualitySetup.TESTFIELD("Posted Inspect. Datasheet Nos.");
        QualitySetup.TESTFIELD("Inspection Receipt Nos.");

        PostInspectData.TRANSFERFIELDS(Rec);
        IF NOT QualitySetup."Posted IDS. No. Is IDS No." THEN
            PostInspectData."No." := NoSeriesMgt.GetNextNo(QualitySetup."Posted Inspect. Datasheet Nos.", TODAY, TRUE);
        InspReportNo := TransferOrderInserIR(PostInspectData);
        PostInspectData."Inspection Receipt No." := InspReportNo;

        PostInspectData."Posted Date" := WORKDATE;
        PostInspectData."Posted Time" := TIME;
        PostInspectData."Posted By" := USERID;
        PostInspectData.INSERT;
        //B2B-GGB
        PostedAttachments(Rec, PostInspectData);
        PostedComments(Rec, PostInspectData);


        InspectDataLine.SETRANGE("Document No.", Rec."No.");
        InspectDataLine.SETCURRENTKEY("Character Group No.");
        InspectReport.SETRANGE("Document No.", InspReportNo);
        IF InspectReport.FINDLAST THEN
            LineNo := InspectReport."Line No.";
        CharGroupCode := 0;
        IF InspectDataLine.FINDSET THEN BEGIN
                                            REPEAT
                                                PostInspectDataLine.TRANSFERFIELDS(InspectDataLine);
                                                PostInspectDataLine."Document No." := PostInspectData."No.";
                                                PostInspectDataLine.INSERT;
                                                IF CharGroupCode <> InspectDataLine."Character Group No." THEN BEGIN
                                                    LineNo := LineNo + 1;
                                                    CharGroupCode := InspectDataLine."Character Group No.";
                                                    InspectReport.INIT;
                                                    InspectReport.TRANSFERFIELDS(InspectDataLine);
                                                    InspectReport."Document No." := InspReportNo;
                                                    InspectReport."Line No." := LineNo + 10000;
                                                    InspectReport."Receipt No." := Rec."Receipt No.";
                                                    InspectReport."Posting Date" := TODAY;
                                                    InspectReport."Item No." := Rec."Item No.";
                                                    InspectReport."Vendor No." := Rec."Vendor No.";
                                                    InspectReport."Purch Line No." := PostInspectData."Purch Line No";
                                                    InspectReport."Posted Inspect Doc. No." := PostInspectData."No.";
                                                    InspectReport.INSERT;
                                                END;
                                            UNTIL InspectDataLine.NEXT = 0;
        END;
        MESSAGE(Text000);
        Rec.DELETE(TRUE);
    end;


    procedure TransferOrderInserIR(InspectHeader: Record "Posted Inspect DatasheetHeader"): Code[20];
    begin
        IF InspectHeader."Source Type" = InspectHeader."Source Type"::Transfer THEN BEGIN
            InspectReportHeader.SETRANGE("Trans. Order No.", InspectHeader."Trans. Order No.");
            InspectReportHeader.SETRANGE("Trans. Order Line", InspectHeader."Trans. Order Line");
            InspectReportHeader.SETRANGE(Status, FALSE);
            InspectReportHeader.SETRANGE("Lot No.", InspectHeader."Lot No.");
        END;
        IF NOT InspectReportHeader.FINDFIRST THEN BEGIN
            InspectReportHeader.INIT;
            InspectReportHeader."Receipt No." := InspectHeader."Receipt No.";
            InspectReportHeader."No." := NoSeriesMgt.GetNextNo(QualitySetup."Inspection Receipt Nos.", TODAY, TRUE);
            ;
            InspectReportHeader."Order No." := InspectHeader."Order No.";
            IF InspectHeader."In Process" THEN BEGIN
                InspectReportHeader."Posting Date" := WORKDATE;
                InspectReportHeader."Document Date" := WORKDATE;
            END ELSE BEGIN
                InspectReportHeader."Posting Date" := InspectHeader."Posting Date";
                InspectReportHeader."Document Date" := InspectHeader."Document Date";
            END;
            InspectReportHeader."Vendor No." := InspectHeader."Vendor No.";
            InspectReportHeader."Vendor Name" := InspectHeader."Vendor Name";
            InspectReportHeader."Vendor Name 2" := InspectHeader."Vendor Name 2";
            InspectReportHeader.Address := InspectHeader.Address;
            InspectReportHeader."Address 2" := InspectHeader."Address 2";
            InspectReportHeader."Contact Person" := '';
            InspectReportHeader."Item No." := InspectHeader."Item No.";
            InspectReportHeader."Item Description" := InspectHeader."Item Description";
            InspectReportHeader."External Document No." := InspectHeader."External Document No.";
            InspectReportHeader."Unit Of Measure Code" := InspectHeader."Unit Of Measure Code";
            InspectReportHeader."Created Date" := WORKDATE;
            InspectReportHeader.Quantity := InspectHeader.Quantity;
            InspectReportHeader."Spec ID" := InspectHeader."Spec ID";
            InspectReportHeader."Purch Line No" := InspectHeader."Purch Line No";
            InspectReportHeader."Location Code" := InspectHeader.Location;
            InspectReportHeader."New Location Code" := InspectHeader.Location;
            InspectReportHeader."Lot No." := InspectHeader."Lot No.";
            InspectReportHeader."Item Tracking Exists" := InspectHeader."Item Tracking Exists";
            InspectReportHeader."Rework Reference No." := InspectHeader."Rework Reference No.";
            InspectReportHeader."Rework Level" := InspectHeader."Rework Level";
            InspectReportHeader."Item Ledger Entry No." := InspectHeader."Item Ledger Entry No.";
            InspectReportHeader."Prod. Order No." := InspectHeader."Prod. Order No.";
            InspectReportHeader."Prod. Order Line" := InspectHeader."Prod. Order Line";
            InspectReportHeader."Routing No." := InspectHeader."Routing No.";
            InspectReportHeader."Routing Reference No." := InspectHeader."Routing Reference No.";
            InspectReportHeader."Operation No." := InspectHeader."Operation No.";
            InspectReportHeader."Operation Description" := InspectHeader."Operation Description";
            InspectReportHeader."Sub Assembly Code" := InspectHeader."Sub Assembly Code";
            InspectReportHeader."Sub Assembly Description" := InspectHeader."Sub Assembly Description";
            InspectReportHeader."In Process" := InspectHeader."In Process";
            InspectReportHeader."Quality Before Receipt" := InspectHeader."Quality Before Receipt";
            InspectReportHeader."Source Type" := InspectHeader."Source Type";
            InspectReportHeader."Production Batch No." := InspectHeader."Production Batch No.";
            InspectReportHeader."Purchase Consignment" := InspectHeader."Purchase Consignment No.";
            InspectReportHeader."Trans. Order No." := InspectHeader."Trans. Order No.";
            InspectReportHeader."Trans. Order Line" := InspectHeader."Trans. Order Line";
            InspectReportHeader."Trans. Description" := InspectHeader."Trans. Description";
            InspectReportHeader."Transfer-from Code" := InspectHeader."Transfer-from Code";
            InspectReportHeader."Transfer-to Code" := InspectHeader."Transfer-to Code";
            //b2b EFF
            InspectReportHeader."Item Category Code" := InspectHeader."Item Category Code";
            InspectReportHeader."Product Group Code" := InspectHeader."Product Group Code";
            InspectReportHeader."Item Sub Group Code" := InspectHeader."Item Sub Group Code";
            InspectReportHeader."Item Sub Sub Group Code" := InspectHeader."Item Sub Sub Group Code";
            InspectReportHeader."No. of Soldering Points" := InspectHeader."No. of Soldering Points";
            InspectReportHeader."No. of Pins" := InspectHeader."No. of Pins";
            InspectReportHeader."No. of Opportunities" := InspectHeader."No. of Opportunities";
            InspectReportHeader."No.of Fixing Holes" := InspectHeader."No.of Fixing Holes";
            InspectReportHeader."Reason for Pending" := InspectHeader."Reason for Pending";

            //b2b EFF

            // >>Added by Pranavi on 25-05-2017 for MSL Process
            InspectReportHeader."MBB Packed Date" := InspectHeader."MBB Packed Date";
            InspectReportHeader."MBB Packet Close DateTime" := InspectHeader."MBB Packet Close DateTime";
            InspectReportHeader."MBB Packet Open DateTime" := InspectHeader."MBB Packet Open DateTime";
            InspectReportHeader."MBB Status" := InspectHeader."MBB Status";
            InspectReportHeader."Baked Hours" := InspectHeader."Baked Hours";
            InspectReportHeader."MFD Date" := InspectHeader."MFD Date";
            InspectReportHeader."HIC 10%" := InspectHeader."HIC 10%";
            InspectReportHeader."HIC 5%" := InspectHeader."HIC 5%";
            InspectReportHeader."HIC 60%" := InspectHeader."HIC 60%";
            // <<Added by Pranavi on 25-05-2017 for MSL Process

            //Added by Vishnu on 29-11-18
            InspectReportHeader."Issues For Pending" := InspectHeader."Issues For Pending";


            InspectReportHeader.INSERT;

            //B2B-GGB
            IRComments(InspectHeader, InspectReportHeader);
            IRAttachments(InspectHeader, InspectReportHeader);


        END;
        EXIT(InspectReportHeader."No.");
    end;


    procedure "----------B2B-----------"();
    begin
    end;


    procedure PostedAttachments(InspDataSheet: Record "Inspection Datasheet Header"; PostedIDS: Record "Posted Inspect DatasheetHeader");
    var
        Attach: Record Attachments;
        PostAttach: Record Attachments;
    begin
        Attach.RESET;
        Attach.SETRANGE("Table ID", DATABASE::"Inspection Datasheet Header");
        Attach.SETRANGE("Document No.", InspDataSheet."No.");
        IF Attach.FINDSET THEN
                REPEAT
                    Attach.CALCFIELDS(Attach.FileAttachment);
                    PostAttach.TRANSFERFIELDS(Attach);
                    PostAttach."Table ID" := DATABASE::"Posted Inspect DatasheetHeader";
                    PostAttach."Document No." := PostedIDS."No.";
                    PostAttach.INSERT;
                UNTIL Attach.NEXT = 0;
    end;


    procedure PostedComments(InspDataSheet: Record "Inspection Datasheet Header"; PostedIDS: Record "Posted Inspect DatasheetHeader");
    var
        QcComments: Record "Quality Comment Line";
        PostComments: Record "Quality Comment Line";
    begin
        QcComments.RESET;
        QcComments.SETRANGE(Type, QcComments.Type::"Inspection Data Sheets");
        QcComments.SETRANGE("No.", InspDataSheet."No.");
        IF QcComments.FINDSET THEN
            REPEAT
                    PostComments.TRANSFERFIELDS(QcComments);
                PostComments.Type := PostComments.Type::"Posted Inspection Data Sheets";
                PostComments."No." := PostedIDS."No.";
                PostComments.INSERT;
            UNTIL QcComments.NEXT = 0;
    end;


    procedure IRComments(PostedIDS: Record "Posted Inspect DatasheetHeader"; IR: Record "Inspection Receipt Header");
    var
        QcComments: Record "Quality Comment Line";
        PostComments: Record "Quality Comment Line";
    begin
        /*
        QcComments.RESET;
        QcComments.SETRANGE(Type,QcComments.Type :: "Posted Inspection Data Sheets");
        QcComments.SETRANGE("No.",PostedIDS."No.");
        IF QcComments.FINDSET THEN BEGIN
          REPEAT
            PostComments.INIT;
            PostComments.TRANSFERFIELDS(QcComments);
            PostComments.Type := PostComments.Type :: "Inspection Receipt";
            PostComments."No." := IR."No.";
            PostComments.INSERT;
          UNTIL QcComments.NEXT = 0;
        END;
        */
        QcComments.RESET;
        QcComments.SETRANGE(Type, QcComments.Type::"Inspection Data Sheets");
        QcComments.SETRANGE("No.", PostedIDS."No.");
        IF QcComments.FINDSET THEN BEGIN
                                       REPEAT
                                           PostComments.INIT;
                                           PostComments.TRANSFERFIELDS(QcComments);
                                           PostComments.Type := PostComments.Type::"Inspection Receipt";
                                           PostComments."No." := IR."No.";
                                           PostComments.INSERT;
                                       UNTIL QcComments.NEXT = 0;
        END;

    end;


    procedure IRAttachments(PostedIDS: Record "Posted Inspect DatasheetHeader"; IR: Record "Inspection Receipt Header");
    var
        Attach: Record Attachments;
        PostAttach: Record Attachments;
    begin
        Attach.RESET;
        //Attach.SETRANGE("Table ID",DATABASE:: "Posted Inspect DatasheetHeader"); //modified for Attachments as on 20-01-09
        Attach.SETRANGE("Document No.", PostedIDS."No.");
        IF Attach.FINDSET THEN
                REPEAT
                    Attach.CALCFIELDS(Attach.FileAttachment);
                    PostAttach.TRANSFERFIELDS(Attach);
                    PostAttach."Table ID" := DATABASE::"Inspection Receipt Header";
                    PostAttach."Document No." := IR."No.";
                    PostAttach.INSERT;
                UNTIL Attach.NEXT = 0;
    end;
}

