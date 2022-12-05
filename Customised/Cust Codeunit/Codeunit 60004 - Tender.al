codeunit 60004 Tender
{
    TableNo = "Tender Header";

    trigger OnRun();
    var
        Text001: Label 'Do you want to Release the Tender?';
        ErrorMess: Text[1000];
        OMSintegration: Codeunit SQLIntegration;
    begin

        TESTFIELD("Tender Posting Group");

        ErrorMess := 'Please Enter the Following fields ::';
        IF "Minimum Bid Amount" = 0.0 THEN
            ErrorMess := ErrorMess + 'Minimum Bid Amount,';
        IF "EMD Satus" <> "EMD Satus"::NA THEN BEGIN
            IF "EMD Amount" = 0 THEN
                ErrorMess := ErrorMess + 'Emd Amount,';
            IF "EMD Required Date" = 0D THEN
                ErrorMess := ErrorMess + 'Emd Required Date,';
            IF "EMD Expected Date" = 0D THEN
                ErrorMess := ErrorMess + 'EMD Expected Date,';
        END;
        IF Product = '' THEN
            ErrorMess := ErrorMess + 'Product,';
        IF "InFavour of" = '' THEN
            ErrorMess := ErrorMess + 'InFavour of,';
        IF "Customer Name" = '' THEN
            ErrorMess := ErrorMess + 'Customer Name,';
        IF "Minimum Bid Amount" = 0 THEN
            ErrorMess := ErrorMess + 'Bid Value,';
        IF "Tech. Bid Opening Date" = 0D THEN
            ErrorMess := ErrorMess + 'Bid Opening Date,';
        IF "Salesperson Code" = '' THEN
            ErrorMess := ErrorMess + 'Sales Executive,';
        IF "Customer Tender No." = '' THEN
            ErrorMess := ErrorMess + 'Customer Tender No.,';
        IF "Tender Dated" = 0D THEN
            ErrorMess := ErrorMess + 'Tender Dated,';
        IF "Tender Source Date" = 0D THEN
            ErrorMess := ErrorMess + 'Tender Source Date,';
        ErrorMess := COPYSTR(ErrorMess, 1, STRLEN(ErrorMess) - 1);
        IF ErrorMess <> 'Please Enter the Following fields :' THEN BEGIN
            ERROR(ErrorMess);
            EXIT;
        END;

        //sundar for tender register
        /*
        TL.RESET;
        TL.SETFILTER(TL."Document No.","Tender No.");
        IF TL.FINDSET THEN
        BEGIN
        REPEAT
          IF TL.Description ='' THEN
            ERROR('There is no Item in the Tender line %1',TL."Line No.");
          {
          IF TL."Cust. Estimated Unit Cost"<=0 THEN
            ERROR('Enter the customer estimated unit cost in Tender line %1',TL."Line No.");
          }
          Total:=Total+TL."Cust.Estimated Total Cost";
        UNTIL TL.NEXT=0;
        END
        ELSE
          ERROR('There are no tender lines to release');
        */
        /*IF ABS(Total-"Minimum Bid Amount")>1 THEN
        ERROR('BID amounts in lines not matching with min bid amount in header');*/

        //sundar
        // Nagaraju

        IF NOT CONFIRM(Text001, FALSE) THEN
            EXIT;
        TESTFIELD(Status, Status::Open);
        Status := Status::Release;
        "USER ID" := USERID;
        "Tender Relese Date Time" := CURRENTDATETIME;
        "Released to Finance" := TRUE;    //CODE ADDED BY SREENIVAS ON 24-04-2010 AT 5:18 PM

        // CashFLow Integration
        OMSintegration.TenderCreationInCF(Rec);
        IF "EMD Satus" <> "EMD Satus"::NA THEN
            OMSintegration.EMDCreationInCF(Rec);
        // CashFLow Integration

        THA.SETRANGE(THA."Tender No.", "Tender No.");
        IF THA.FINDFIRST THEN
            MODIFY
        ELSE BEGIN
            /*IF Status = Status::Release THEN BEGIN
                sperson.RESET;
                sperson.SETRANGE(sperson.Code, "Salesperson Code");
                IF sperson.FINDFIRST THEN BEGIN
                    IF sperson."E-Mail" <> '' THEN
                        "to mail" := sperson."E-Mail";//rec
                END;
                User.RESET;
                User.SETRANGE(User."User Name", USERID);
                IF User.FINDFIRST THEN
                    IF User.MailID <> '' THEN
                        IF "to mail" <> '' THEN
                            "to mail" := "to mail" + ',' + User.MailID//
                        ELSE
                            "to mail" := User.MailID;//
                IF "to mail" <> '' THEN BEGIN
                    IF "to mail" <> 'anvesh@efftronics.com' THEN
                        "to mail" += ',anvesh@efftronics.com,mk@effe.in,erp@efftronics.com'//
                    ELSE
                        "to mail" += ',mk@effe.in,erp@efftronics.com';
                END
                ELSE
                    "to mail" += 'anvesh@efftronics.com,mk@effe.in,erp@efftronics.com';
                IF FORMAT(TenderType) = 'AMC' THEN
                    "to mail" += ',prasanthi@efftronics.com';
                "from Mail" := 'erp@efftronics.com';
                Mail_To := "to mail";
                Mail_From := "from Mail";
                Mail_Body := '';
                Shedul2_Count := 0;
                Mail_Subject := 'ERP- Tender No: ' + "Tender No." + ' Released on for the Customer ' + "Customer Name";
                ROMail.CreateMessage('erp', 'erp@efftronics.com', Mail_To, 'ERP - ' + Mail_Subject, Mail_Body, TRUE);
                Body+=('<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>');
                Body+=('<body><div style="border-color:#025E4D;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;">');
                Body+=('<label><font size="6"> Tender Information</font></label>');
                Body+=('<hr style=solid; color= #3333CC>');
                Body+=('<h>Dear Sir/Madam,</h><br>');
                Body+=('<P>TENDER DETAILS</P>');
                Body+=('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><td width="40%"><b>Tender No  </b></td><td>' + "Tender No." + '</td></tr>');
                Customer.RESET;
                Customer.SETRANGE(Customer."No.", "Customer No.");
                IF Customer.FINDFIRST THEN BEGIN
                    Body+=('<tr><td><b>Customer Name   </b> </td><td>' + Customer.Name + '</td></tr>');
                    Body+=('<tr><td><b>Customer Type  </b></td><td>' + Customer."Customer Posting Group" + '</td></tr>');
                END;
                Body+=('<tr><td><b>Tender Type  </b></td><td>' + FORMAT(TenderType) + '</td></tr>');
                Body+=('<tr><td><b>Product  </b></td><td>' + Product + '</td></tr>');
                Body+=('<tr><td><b>Customer Tender No.  </b></td><td>' + "Customer Tender No." + '</td></tr>');
                Body+=('<tr><td><b>BID Value  </b></td><td>' + formataddress.ChangeCurrency(ROUND("Minimum Bid Amount", 1)) + '</td></tr>');
                Body+=('<tr><td><b>BID Opening Date  </b></td><td>' + FORMAT(("Tech. Bid Opening Date"), 0, 4) + '</td></tr>');
                IF "EMD Satus" <> "EMD Satus"::NA THEN BEGIN
                    Body+=('<tr><td><b>EMD Value  </b></td><td>' + formataddress.ChangeCurrency(ROUND("EMD Amount", 1)) + '</td></tr>');
                    Body+=('<tr><td><b>EMD Required Date  </b></td><td>' + FORMAT("EMD Required Date") + '</td></tr>');
                END;
                Body+=('<tr><td><b>Tender Doc Cost  </b></td><td>' + formataddress.ChangeCurrency(ROUND("Tender Document Cost", 1)) + '</td></tr>');
                "Mail-Id".RESET;
                "Mail-Id".SETRANGE("Mail-Id".EmployeeID, "Salesperson Code");//B2B
                IF "Mail-Id".FINDFIRST THEN
                    Body+=('<tr><td><b>Sales Executive  </b></td><td>' + FORMAT("Mail-Id"."Full Name") + '</td></tr>');
                Body+=('</Table>');
                {
                TestTL.RESET;
                TestTL.SETRANGE(TestTL."Document No.","Tender No.");
                TestTL.SETFILTER(TestTL."No.",'<>%1','');
                TestTL.SETFILTER(TestTL.Quantity,'>%1',0);
                IF TestTL.FINDSET THEN
                BEGIN
                  Body+=('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th><b>Item no.</b></th>');
                  Body+=('<th>Item Description </th> <th>QTY</th><th>UOM</th><th>AMOUNT</th></tr>');
                  TL.RESET;
                  TL.SETRANGE(TL."Document No.","Tender No.");
                  TL.SETFILTER(TL."No.",'<>%1','');
                  TL.SETFILTER(TL.Quantity,'>%1',0);
                  IF TL.FINDSET THEN
                  REPEAT
                    Body+=('<tr><td>'+TL."No."+'</td><td>'+TL.Description+'</td><TD>'+FORMAT(ROUND(TL.Quantity,1))+'</TD><td>'+TL.UOM+'</td>');
                    Body+=('<td align=right>'+formataddress.ChangeCurrency(ROUND(TL.Quantity*TL."Unit Cost",1))+'</td></tr>');
                    Schedule2.RESET;
                    Schedule2.SETRANGE(Schedule2."Document No.",TL."Document No.");
                    Schedule2.SETRANGE(Schedule2."Document Line No.",TL."Line No.");
                    Schedule2.SETFILTER(Schedule2."No.",'<>%1','');
                    Schedule2.SETFILTER(Schedule2.Quantity,'>%1',0);
                    IF Schedule2.FINDSET THEN
                    REPEAT
                      IF Schedule2."Document Line No." <> Schedule2."Line No." THEN
                      BEGIN
                        Body+=('<tr><td style="color:#FF0000">'+'  '+Schedule2."No."+'</td><td style="color:#FF0000">'+'  '+Schedule2.Description+'</td>');
                        Body+=('<TD style="color:#FF0000">'+FORMAT(Schedule2.Quantity)+'</TD><td style="color:#FF0000">'+Schedule2."Unit of Measure Code"+'</td>');
                        Body+=('<td align=right style="color:#FF0000">'+' '+'</td></tr>');
                        Shedul2_Count+=1;
                      END;
                    UNTIL Schedule2.NEXT =0 ;
                  UNTIL TL.NEXT =0 ;
                  Body+=('</Table>');
                  IF Shedul2_Count > 0  THEN
                    Body+=('<BR><p align ="left" style="color:#FF0000"> Note: Red Color Items are Schedule Items</p>');
                END;
                }  //Commented Eff
                Body+=('<BR><p align ="left"> Regards,<br>ERP Team </p>');
                Body+=('<br><p align = "center">::::Note: Auto Generated mail from ERP:::: </b></P></div></body></html>');
                IF (Mail_From <> '') AND (Mail_To <> '') THEN
                    ROMail.Send;
                "ArichiveTender Document"(Rec);
                IF TenderHead2.GET("Tender No.") THEN BEGIN
                    TenderHead2.Status := Status;
                    "Tender Relese Date Time" := CURRENTDATETIME;
                    TenderHead2.MODIFY;
                END;*/                  //UPG



            IF Status = Status::Release THEN BEGIN
                sperson.RESET;
                sperson.SETRANGE(sperson.Code, "Salesperson Code");
                IF sperson.FINDFIRST THEN BEGIN
                    IF sperson."E-Mail" <> '' THEN
                        //"to mail" := sperson."E-Mail";
                        Recipients.Add(sperson."E-Mail")
                END;
                user.RESET;
                user.SETRANGE(user."User ID", USERID);
                IF user.FINDFIRST THEN
                    IF user.MailID <> '' THEN
                        IF "to mail" <> '' THEN begin
                            //"to mail" := "to mail" + ',' + User.MailID
                            Recipients.Add(UserSetup.MailID)
                        end
                        ELSE
                            // "to mail" := User.MailID;
                            Recipients.Add(UserSetup.MailID);
                IF "to mail" <> '' THEN BEGIN
                    IF "to mail" <> 'anvesh@efftronics.com' THEN begin
                        //"to mail" += ',anvesh@efftronics.com,mk@effe.in,erp@efftronics.com'
                        Recipients.Add('anvesh@efftronics.com');
                        Recipients.Add('mk@effe.in');
                        Recipients.Add('erp@efftronics.com')
                    end ELSE
                        //"to mail" += ',mk@effe.in,erp@efftronics.com';
                        Recipients.Add('mk@effe.in');
                    Recipients.Add('erp@efftronics.com');
                END
                ELSE
                    //"to mail" += 'anvesh@efftronics.com,mk@effe.in,erp@efftronics.com';
                Recipients.Add('anvesh@efftronics.com');
                Recipients.Add('mk@effe.in');
                Recipients.Add('erp@efftronics.com');
                IF FORMAT(TenderType) = 'AMC' THEN
                    // "to mail" += ',prasanthi@efftronics.com';
                    Recipients.Add('prasanthi@efftronics.com');
                "from Mail" := 'erp@efftronics.com';
                Mail_To := "to mail";
                Mail_From := "from Mail";
                Mail_Body := '';
                Shedul2_Count := 0;
                Mail_Subject := 'ERP- Tender No: ' + "Tender No." + ' Released on for the Customer ' + "Customer Name";
                Subject := (Mail_Subject);

                Body += ('<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>');
                Body += ('<body><div style="border-color:#025E4D;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;">');
                Body += ('<label><font size="6"> Tender Information</font></label>');
                Body += ('<hr style=solid; color= #3333CC>');
                Body += ('<h>Dear Sir/Madam,</h><br>');
                Body += ('<P>TENDER DETAILS</P>');
                Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><td width="40%"><b>Tender No  </b></td><td>' + "Tender No." + '</td></tr>');
                Customer.RESET;
                Customer.SETRANGE(Customer."No.", "Customer No.");
                IF Customer.FINDFIRST THEN BEGIN
                    Body += ('<tr><td><b>Customer Name   </b> </td><td>' + Customer.Name + '</td></tr>');
                    Body += ('<tr><td><b>Customer Type  </b></td><td>' + Customer."Customer Posting Group" + '</td></tr>');
                END;
                Body += ('<tr><td><b>Tender Type  </b></td><td>' + FORMAT(TenderType) + '</td></tr>');
                Body += ('<tr><td><b>Product  </b></td><td>' + Product + '</td></tr>');
                Body += ('<tr><td><b>Customer Tender No.  </b></td><td>' + "Customer Tender No." + '</td></tr>');
                Body += ('<tr><td><b>BID Value  </b></td><td>' + formataddress.ChangeCurrency(ROUND("Minimum Bid Amount", 1)) + '</td></tr>');
                Body += ('<tr><td><b>BID Opening Date  </b></td><td>' + FORMAT(("Tech. Bid Opening Date"), 0, 4) + '</td></tr>');
                IF "EMD Satus" <> "EMD Satus"::NA THEN BEGIN
                    Body += ('<tr><td><b>EMD Value  </b></td><td>' + formataddress.ChangeCurrency(ROUND("EMD Amount", 1)) + '</td></tr>');
                    Body += ('<tr><td><b>EMD Required Date  </b></td><td>' + FORMAT("EMD Required Date") + '</td></tr>');
                END;
                Body += ('<tr><td><b>Tender Doc Cost  </b></td><td>' + formataddress.ChangeCurrency(ROUND("Tender Document Cost", 1)) + '</td></tr>');
                "Mail-Id".RESET;
                "Mail-Id".SETRANGE("Mail-Id".EmployeeID, "Salesperson Code");//B2B
                IF "Mail-Id".FINDFIRST THEN
                    UserGRec.SetRange("User Name", "Mail-Id"."User ID");
                if UserGRec.FindFirst() then;
                Body += ('<tr><td><b>Sales Executive  </b></td><td>' + FORMAT(UserGRec."Full Name") + '</td></tr>');
                Body += ('</Table>');
                Body += ('<BR><p align ="left"> Regards,<br>ERP Team </p>');
                Body += ('<br><p align = "center">::::Note: Auto Generated mail from ERP:::: </b></P></div></body></html>');
                // IF (Mail_From <> '') AND (Mail_To <> '') THEN
                RecipientsNew.add('erp@efftronics.com');
                EmailMessage.Create(RecipientsNew, Subject, Body, true);
                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                "ArichiveTender Document"(Rec);
                IF TenderHead2.GET("Tender No.") THEN BEGIN
                    TenderHead2.Status := Status;
                    "Tender Relese Date Time" := CURRENTDATETIME;
                    TenderHead2.MODIFY;
                END;
            END;
        END;
        //Pranavi
        SO.RESET;
        SO.SETFILTER(SO."No.", "Tender No.");
        IF NOT SO.FINDFIRST THEN BEGIN
            SO.INIT;
            SO."Document Type" := 7;
            SO."No." := "Tender No.";
            SO."Sell-to Customer No." := "Customer No.";
            SO."Customer OrderNo." := "Customer Tender No.";
            SO."Bill-to Name" := "Customer Name";
            SO."Security Deposit Amount" := "Security Deposit Amount";
            SO."EMD Amount" := "EMD Amount";
            SO."Security Deposit Status" := "Security Deposit Status";
            SO."SD Requested Date" := "SD Requested Date";
            SO."SD Required Date" := "SD Required Date";
            SO.Product := Product;
            SO."EMD Status" := "EMD Status";
            SO.INSERT;
        END
        ELSE BEGIN
            SO."Sell-to Customer No." := "Customer No.";
            SO."Customer OrderNo." := "Customer Tender No.";
            SO."Bill-to Name" := "Customer Name";
            SO."Security Deposit Amount" := "Security Deposit Amount";
            SO."EMD Amount" := "EMD Amount";
            SO."Security Deposit Status" := "Security Deposit Status";
            SO."SD Requested Date" := "SD Requested Date";
            SO."SD Required Date" := "SD Required Date";
            SO.Product := Product;
            SO."EMD Status" := "EMD Status";
            SO.MODIFY;
        END;
        //Pranavi


        //OMS integration

        // OMSintegration.TenderCreationOMS(Rec);  //commented by sreenivas on 29-jan-2010 at 12.43pm

        //OMS Integration

    end;

    var
        Text001: Label 'Do your want to archive Tender :%1?';
        Text002: Label 'Tender No. %1 has been Archived.';
        ArchiveTenderHeader: Record "Tender Header Archive";
        ArchiveTenderLine: Record "Tender Line Archive";
        "Mail-Id": Record "User Setup";
        "from Mail": Text[100];
        "to mail": Text[1000];
        Mail_Subject: Text[1000];
        Mail_Body: Text[1000];
        //mail: Codeunit 397;
        charline: Char;
        "g/l setup": Record "General Ledger Setup";
        Attachment1: Text[1000];
        TH: Record "Tender Header";
        CUST: Record Customer;
        Tender: Codeunit Tender;
        THA: Record "Tender Header Archive";
        TenderHead2: Record "Tender Header";
        TL: Record "Tender Line";
        Total: Decimal;
        UserSetupGRec: Record "User Setup";
        Schedule2: Record Schedule2;
        Customer: Record Customer;
        Mail_To: Text;
        //ROMail: Codeunit "SMTP Mail";
        Shedul2_Count: Integer;
        Mail_From: Text;
        formataddress: Codeunit "Correct Dimension Values Cust";
        SO: Record "Sales Invoice-Dummy";
        TestTL: Record "Tender Line";
        sperson: Record "Salesperson/Purchaser";
        UserSetup: Record "User Setup";
        Recipients: List of [Text];
        RecipientsNew: List of [Text];

        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        UserGRec: Record User;
        Subject: Text;
        Body: Text;
        user: Record "User Setup";



    procedure ReopenTender(TenderHeader: Record "Tender Header");
    var
        Text001: Label 'Do you want to Reopen the Tender?';
    begin
        IF NOT CONFIRM(Text001, FALSE) THEN
            EXIT;
        TenderHeader.TESTFIELD(Status, TenderHeader.Status::Release);
        Tender."ArichiveTender Document"(TenderHeader);
        IF TenderHead2.GET(TenderHeader."Tender No.") THEN BEGIN
            TenderHead2.Status := TenderHead2.Status::Open;
            TenderHead2."USER ID" := USERID;
            TenderHead2.MODIFY;
        END;
    end;


    procedure "ArichiveTender Document"(var TenderHeader: Record "Tender Header");
    begin
        //IF CONFIRM(Text001,TRUE,TenderHeader."Tender No.")
        //THEN BEGIN
        "Store Tender Document"(TenderHeader, FALSE);
        // MESSAGE(Text002,TenderHeader."Tender No.");
        //END;
    end;


    procedure "Store Tender Document"(var TenderHeader: Record "Tender Header"; InteractionExist: Boolean);
    var
        TenderHeader1: Record "Tender Header";
        TenderLine: Record "Tender Line";
        DesignWorkSheetHeader: Record "Design Worksheet Header";
        DesignWorkSheetLine: Record "Design Worksheet Line";
        ArchivedDesignWorkSheetHeader: Record "Archived DesignWorksheet";
        ArchivedDesignWorkSheetLine: Record "Archived DesignWorksheet Line";
        "DWSVersionNo.": Integer;
    begin
        ArchiveTenderHeader.INIT;
        ArchiveTenderHeader.TRANSFERFIELDS(TenderHeader);
        ArchiveTenderHeader."Archived By" := USERID;
        ArchiveTenderHeader."Date Archived" := WORKDATE;
        ArchiveTenderHeader."Time Archived" := TIME;
        ArchiveTenderHeader."Version No." := GetNextVersionNo(TenderHeader."Tender No.");
        ArchiveTenderHeader.INSERT;

        "Store Tender Attachments"(TenderHeader, DATABASE::"Tender Header");

        TenderLine.SETRANGE("Document No.", TenderHeader."Tender No.");
        IF TenderLine.FINDSET THEN
            REPEAT
                ArchiveTenderLine.INIT;
                ArchiveTenderLine.TRANSFERFIELDS(TenderLine);
                ArchiveTenderLine."Version No." := ArchiveTenderHeader."Version No.";
                ArchiveTenderLine.INSERT;
                //To Archive the Design Work Sheet
                DesignWorkSheetHeader.SETRANGE("Document Type", DesignWorkSheetHeader."Document Type"::Tender);
                DesignWorkSheetHeader.SETRANGE("Document No.", TenderLine."Document No.");
                DesignWorkSheetHeader.SETRANGE("Document Line No.", TenderLine."Line No.");
                IF DesignWorkSheetHeader.FINDFIRST THEN BEGIN
                    DesignWorkSheetHeader."Version No." := DesignWorkSheetHeader."Version No." + 1;
                    DesignWorkSheetHeader."No. of Archived Versions" := DesignWorkSheetHeader."No. of Archived Versions" + 1;
                    "Store Design Document"(DesignWorkSheetHeader, "DWSVersionNo.");
                    DesignWorkSheetHeader.MODIFY;
                END;
            UNTIL TenderLine.NEXT = 0;


        //To Update the values of the DesignWorksheet Header
        TenderHeader1.SETRANGE("Tender No.", TenderHeader."Tender No.");
        IF TenderHeader1.FINDFIRST THEN BEGIN
            TenderHeader1."Version No." := ArchiveTenderHeader."Version No.";
            TenderHeader1."No. of Archived Versions" := TenderHeader1."No. of Archived Versions" + 1;
            TenderHeader1.MODIFY;
        END;
    end;


    procedure "Store Design Document"(DesignWorksheetHeader: Record "Design Worksheet Header"; "VersionNo.": Integer);
    var
        DWSHeader: Record "Design Worksheet Header";
        ArchivedDesignWorkSheetHeader: Record "Archived DesignWorksheet";
        ArchivedDesignWorkSheetLine: Record "Archived DesignWorksheet Line";
        DWSLine: Record "Design Worksheet Line";
    begin
        DWSHeader.SETRANGE("Document Type", DWSHeader."Document Type"::Tender);
        DWSHeader.SETRANGE("Document No.", DesignWorksheetHeader."Document No.");
        DWSHeader.SETRANGE("Document Line No.", DesignWorksheetHeader."Document Line No.");
        IF DWSHeader.FINDFIRST THEN BEGIN
            ArchivedDesignWorkSheetHeader.INIT;
            ArchivedDesignWorkSheetHeader.TRANSFERFIELDS(DWSHeader);
            ArchivedDesignWorkSheetHeader.SETRANGE("Document Type", ArchivedDesignWorkSheetHeader."Document Type"::Tender);
            ArchivedDesignWorkSheetHeader.SETRANGE("Document No.", ArchivedDesignWorkSheetHeader."Document No.");
            ArchivedDesignWorkSheetHeader.SETRANGE("Document Line No.", ArchivedDesignWorkSheetHeader."Document Line No.");
            IF ArchivedDesignWorkSheetHeader.FINDLAST THEN
                ArchivedDesignWorkSheetHeader."Version No." := ArchivedDesignWorkSheetHeader."Version No." + 1
            ELSE
                ArchivedDesignWorkSheetHeader."Version No." := 1;
            ArchivedDesignWorkSheetHeader."Archived By." := USERID;
            ArchivedDesignWorkSheetHeader."Date of Archive" := WORKDATE;
            ArchivedDesignWorkSheetHeader."Time of Archive" := TIME;
            ArchivedDesignWorkSheetHeader.INSERT;
            DWSLine.SETRANGE("Document Type", DWSHeader."Document Type"::Tender);
            DWSLine.SETRANGE("Document No.", DWSHeader."Document No.");
            DWSLine.SETRANGE("Document Line No.", DWSHeader."Document Line No.");
            IF DWSLine.FINDSET THEN BEGIN
                REPEAT
                    ArchivedDesignWorkSheetLine.INIT;
                    ArchivedDesignWorkSheetLine.TRANSFERFIELDS(DWSLine);
                    ArchivedDesignWorkSheetLine."Version No." := ArchivedDesignWorkSheetHeader."Version No.";
                    ArchivedDesignWorkSheetLine.INSERT;
                UNTIL DWSLine.NEXT = 0;
            END;
        END;
    end;


    procedure "Store Tender Attachments"(var TenderHeader: Record "Tender Header"; TableID: Option);
    var
        ESPLAttachment: Record Attachments;
        TableName: Text[100];
        "ESPL AttachmentArchive": Record "Attachments Archive";
        TenderHeader1: Record "Tender Header";
    begin
        ESPLAttachment.RESET;
        ESPLAttachment.SETRANGE("Table ID", TableID);
        ESPLAttachment.SETRANGE("Document No.", TenderHeader."Tender No.");
        IF ESPLAttachment.FINDSET THEN BEGIN
            TenderHeader1 := TenderHeader;
            "ESPL AttachmentArchive"."Document Version No." := TenderHeader1."No. of Archived Versions" + 1;
            REPEAT
                ESPLAttachment.CALCFIELDS(FileAttachment);
                "ESPL AttachmentArchive".TRANSFERFIELDS(ESPLAttachment);
                "ESPL AttachmentArchive".INSERT;
            UNTIL ESPLAttachment.NEXT = 0;
        END;
    end;


    procedure GetNextVersionNo(DocNo: Code[20]): Integer;
    begin
        ArchiveTenderHeader.SETRANGE("Tender No.", DocNo);
        IF ArchiveTenderHeader.FINDLAST THEN
            EXIT(ArchiveTenderHeader."Version No." + 1)
        ELSE
            EXIT(1);
    end;
}

