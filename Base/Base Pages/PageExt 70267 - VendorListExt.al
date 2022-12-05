pageextension 70267 VendorListExt extends "Vendor List"
{
    layout
    {
        modify("Vendor Posting Group")
        {
            trigger OnBeforeValidate()
            begin
                //added by Vishnu Priya on 13-11-2020

                IF Rec.FINDFIRST THEN BEGIN
                    Rec.CALCFIELDS("No Of POs");
                    IF (Rec."No Of POs" > 0) AND (Rec."Vendor Posting Group" = 'OTHER(F&A)') THEN
                        Rec.Purchase_Finance := Rec.Purchase_Finance::MyBothValue
                    ELSE
                        IF (Rec."No Of POs" > 0) AND (Rec."Vendor Posting Group" <> 'OTHER(F&A)') THEN
                            Rec.Purchase_Finance := Rec.Purchase_Finance::Purchase
                        ELSE
                            IF (Rec."No Of POs" >= 0) AND (Rec."Vendor Posting Group" = 'OTHER(PUR)') THEN
                                Rec.Purchase_Finance := Rec.Purchase_Finance::Purchase
                            ELSE
                                IF (Rec."No Of POs" = 0) AND (Rec."Vendor Posting Group" = 'OTHER(F&A)') THEN
                                    Rec.Purchase_Finance := Rec.Purchase_Finance::Finance
                                ELSE
                                    Rec.Purchase_Finance := Rec.Purchase_Finance::None;
                    Rec.MODIFY;
                END;
                //added by Vishnu Priya on 13-11-2020
            end;
        }
        addafter(Control1)
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                Caption = 'Count of Vendors';
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
        }
        addafter(Name)
        {
            /*field("E.C.C. No."; "E.C.C. No.")
            {
                ApplicationArea = All;

            }*/
            field(category; Rec.category)
            {
                ApplicationArea = All;

            }
            field("Vendor Balance Verified"; Rec."Vendor Balance Verified")
            {
                ApplicationArea = All;

            }
        }
        addafter("Responsibility Center")
        {
            field("No Of POs"; Rec."No Of POs")
            {
                ApplicationArea = All;

            }
            field("Purchase_Finance"; Rec."Purchase_Finance")
            {
                ApplicationArea = All;

            }

            field("Tally Reference"; Rec."Tally Reference")
            {
                ApplicationArea = All;

            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;

            }
            /* field("Excise Bus. Posting Group"; "Excise Bus. Posting Group")
             {
                 ApplicationArea = All;

             }*/
            field("Prod Vendor Balance"; Rec."Prod Vendor Balance")
            {
                ApplicationArea = All;

            }
            field("CS Vendor Balance"; Rec."CS Vendor Balance")
            {
                ApplicationArea = All;

            }
            field("RD Vendor Balance"; Rec."RD Vendor Balance")
            {
                ApplicationArea = All;

            }
            field("Tax Area Code"; Rec."Tax Area Code")
            {
                ApplicationArea = All;

            }
            /*field(Structure; Structure)
            {
                ApplicationArea = All;

            }*/
            field(City; Rec.City)
            {
                ApplicationArea = All;

            }
        }
        addafter("Location Code")
        {
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;

            }

        }
        addafter("Application Method")
        {
            field("C-Form"; Rec."C-Form")
            {
                ApplicationArea = All;

            }
        }
        addafter("Base Calendar Code")
        {
            field("Updated in Cashflow"; Rec."Updated in Cashflow")
            {
                ApplicationArea = All;

            }
            field("Phone No2"; Rec."Phone No2")
            {
                ApplicationArea = All;

            }
            field("Phone No3"; Rec."Phone No3")
            {
                ApplicationArea = All;

            }
            field("GST Registration No."; Rec."GST Registration No.")
            {
                ApplicationArea = All;

            }
            field("GST Vendor Type"; Rec."GST Vendor Type")
            {
                ApplicationArea = All;

            }
            field("Phone No4"; Rec."Phone No4")
            {
                ApplicationArea = All;

            }
            field("Mobile No."; Rec."Mobile No.")
            {
                ApplicationArea = All;

            }
            /*field("T.I.N. No."; "T.I.N. No.")
            {
                ApplicationArea = All;

            }*/
            field("State Code"; Rec."State Code")
            {
                ApplicationArea = All;

            }
            /* field("Vendor Type"; "Vendor Type")
             {
                 ApplicationArea = All;

             }*/
            field("Vendor Category"; Rec."Vendor Category")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin

                    /* //added by Vishnu Priya on 13-11-2020
                    CALCFIELDS("No Of POs");
                    IF Rec.FINDFIRST THEN
                      BEGIN
                      IF (Rec."No Of POs" >0) AND (Rec."Vendor Category"="Vendor Category"::"F&A") THEN
                        Rec.Purchase_Finance := Purchase_Finance::Both
                      ELSE
                        IF (Rec."No Of POs" >0) AND (Rec."Vendor Category" <> "Vendor Category"::"F&A") THEN
                          Purchase_Finance := Purchase_Finance::Purchase
                      ELSE IF (Rec."No Of POs" >=0) AND (Rec."Vendor Category" ="Vendor Category"::OTHER) THEN
                        Purchase_Finance := Purchase_Finance::Purchase
                      ELSE IF (Rec."No Of POs" = 0) AND (Rec."Vendor Category"="Vendor Category"::"F&A") THEN
                        Rec.Purchase_Finance := Purchase_Finance::Finance
                      ELSE
                        Rec.Purchase_Finance := Purchase_Finance::None;
                      Rec.MODIFY;
                    END; */
                end;
            }
            field("Branch Name"; Rec."Branch Name")
            {
                ApplicationArea = All;

            }
            field("Name of Bank"; Rec."Name of Bank")
            {
                ApplicationArea = All;

            }
            field("RTGS Code"; Rec."RTGS Code")
            {
                ApplicationArea = All;

            }
            field("Our Account No."; Rec."Our Account No.")
            {
                ApplicationArea = All;

            }
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = All;

            }
            field("Vendor Status"; Rec."Vendor Status")
            {
                ApplicationArea = All;

            }
            field(Maintenacecommonmail; Rec.Maintenacecommonmail)
            {
                ApplicationArea = All;

            }

        }
        /* addafter(Control1)
         {
             group(Control1102152014)
             {
                 Editable = false;
                 ShowCaption = false;
                 grid(Control1102152013)
                 {
                     ShowCaption = false;
                 }
             }
             group(Control1102152012)
             {
                 ShowCaption = false;
                 field("TotalVendors+FORMAT(Rec.COUNT)"; "TotalVendors" + FORMAT(Rec.COUNT))
                 {
                     Editable = false;
                     ApplicationArea = All;
                 }
             }
         }*/
    }

    actions
    {
        addafter("Vendor - Detail Trial Balance")
        {
            action("GST Details")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    HYPERLINK('http://app.efftronics.org:8567/GSTRegInternal/GSTRegistrationDetails.aspx?V_C_Num=' + Rec."No.");
                end;
            }
            action("Send GST Mail")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    GSTMails;
                end;
            }
            action("CForms Mail")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    Vendor: Record Vendor;
                    Count: Integer;
                begin
                    Count := 0;
                    Vendor.RESET;
                    Vendor.SETRANGE("Country/Region Code", 'IN');
                    Vendor.SETFILTER("State Code", '<> %1', 'ANP');
                    Vendor.SETRANGE("Send Mail", FALSE);
                    //Vendor.SETFILTER("No.",'%1|%2','V00006','V00013');
                    Vendor.SETCURRENTKEY("No.");
                    IF Vendor.FINDSET THEN
                        REPEAT
                            /* Mail_From := 'purchase@efftronics.com';
                             Mail_To := Vendor."E-Mail";
                             Subject := 'Reg :: C- Forms  ';
                             SMTP_MAIL.CreateMessage('Purchase - Efftronics Systems Pvt Ltd.', Mail_From, Mail_To, Subject, Body, TRUE);
                             SMTP_MAIL.AppendBody('<html><body><div style="border-color:white;  margin: 20px; border-width:10px; font-size:11pt;  border-style:solid; padding: 20px; width: 1500px;">');
                             SMTP_MAIL.AppendBody('<div style="Background-color:#0971D9; color:#F0F1F5; "><br/><label><font size="4"> Pending C-Forms Required from ' + Vendor.Name + '</font></label></div><br/>');
                             SMTP_MAIL.AppendBody('Dear Sir/Madam,');
                             SMTP_MAIL.AppendBody('<br><br>');
                             SMTP_MAIL.AppendBody('<font size="2" color ="#0971D9">   We all are know that C-forms (Tax 2%) is upto this year 2017-18 1st Qtr (Apr-Jun) only ');
                             SMTP_MAIL.AppendBody('So as on date any forms pending from Efftronics side, please send pending invoice details immediately .</font></label><br>');
                             SMTP_MAIL.AppendBody('<font size="2" color ="#0971D9">We can apply C-form upto this month End (31-Aug-17) only.' + '</font></label><br>');
                             SMTP_MAIL.AppendBody('<font size="2" color ="#0971D9">If any C-forms pending list received in next month (From 01-Sep-17), we are not the responsible for any penalty from GOVT.' + '</font></label><br>');
                             SMTP_MAIL.AppendBody('<br><br>With Regards<br>');
                             SMTP_MAIL.AppendBody('<b>Renuka.ch </b><br>');
                             SMTP_MAIL.AppendBody('<b>Purchase Department </b><br>');
                             SMTP_MAIL.AppendBody('<b>Efftronics Systems Pvt. Ltd., </b><br>');
                             SMTP_MAIL.AppendBody('40-15-9,Brundavan Colony,<br>');
                             SMTP_MAIL.AppendBody('Vijayawada - 520010,<br>');
                             SMTP_MAIL.AppendBody('Andhra Pradesh, India.<br>');
                             SMTP_MAIL.AppendBody('Ph No : 0866-2466679(Direct)/2466699/75<br>');
                             SMTP_MAIL.AppendBody('<div style="Background-color:#0971D9; color:#F0F1F5; "><p align= "center">:::: AUTO GENERATED MAIL  ::::</div><br/></div>');
                             SMTP_MAIL.AddBCC('vijaya@efftronics.com');
                             SMTP_MAIL.Send;*/
                            Vendor."Send Mail" := TRUE;
                            Count := Count + 1;
                            Vendor.MODIFY;
                        UNTIL Vendor.NEXT = 0;
                    MESSAGE('Mail Sent Count :: ' + FORMAT(Count));
                end;
            }
        }
    }

    trigger OnOpenPage()
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
        END; */

        //added by Vishnu Priya on 13-11-2020
        //Rec.SETFILTER(Purchase_Finance,'%1|%2',Rec.Purchase_Finance::Both,Rec.Purchase_Finance::Purchase);
        //added by Vishnu Priya on 13-11-2020
    end;

    trigger OnClosePage()
    begin
        //SQLConnection.Close;
        //ConnectionOpen:=0;
    end;

    trigger OnAfterGetRecord()
    begin
        Color_GST_Update := '';
        //GSTUpdated;
    end;

    var
        TotalVendors: Label 'Total Vendors:';
        RowCount: Integer;
        //>> ORACLE UPG
        /* SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
        RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset"; */

        //<< ORACLE UPG
        ConnectionOpen: Integer;
        Color_GST_Update: Code[30];
        Color_GST_Update_C: Label 'GST Details Not Updated';
        Mail_From: Text;
        Mail_To: Text;
        Subject: Text;
        Body: Text;
        //SMTP_MAIL: Codeunit "SMTP Mail";
        PurchHdr: Record "Purchase Header";
        PurchaseOrderList: Page 9307;
        //EmailMessage: Codeunit 8904;
        //Email: Codeunit 8901;
        Recipients: List of [Text];

    PROCEDURE GSTMails();
    VAR
        Type: Code[2];
        No: Code[20];
        Subject: Text[1000];
        Mail_To: Text[1000];
        Mail_From: Text[1000];
        //SMTP_MAIL: Codeunit "SMTP Mail";
        SQLQuery: Text[1024];
        TempText: Text;
        Body: Text;
        Attachment: Text;
    BEGIN
        /*IF ISCLEAR(SQLConnection) THEN
            CREATE(SQLConnection, FALSE, TRUE);

        IF ISCLEAR(RecordSet) THEN
            CREATE(RecordSet, FALSE, TRUE);*/
        //B2BUPG
        //>> ORACLE UPG
        /*
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
                */
        //<< ORACLE UPG
        /* IF Type = 'V' THEN
            Mail_From := 'purchase@efftronics.com'
        ELSE
            Mail_From := 'sales@efftronics.com';
        Mail_To := FORMAT(RecordSet.Fields.Item('EMAIL').Value);
        Mail_To := 'pranavi@efftronics.com';

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
        RecordSet.MoveNext; */  //B2B UPG

        //>> ORACLE UPG
        /*
        //Mail_To := FORMAT(RecordSet.Fields.Item('EMAIL').Value);
        Recipients.Add('pranavi@efftronics.com');
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
            MESSAGE('Mail Has been send to ' + COPYSTR(TempText, 1, STRLEN(TempText) - 1) + ' - ' + Rec.Name + 'at ' + Mail_To);
            */
        //<< ORACLE UPG
    END;


    PROCEDURE GSTUpdated();
    VAR
        Type: Code[2];
        No: Code[20];
        Subject: Text[1000];
        Mail_To: Text[1000];
        Mail_From: Text[1000];
        //SMTP_MAIL: Codeunit "SMTP Mail";
        SQLQuery: Text[1024];
        TempText: Text;
        Body: Text;
        Attachment: Text;
    BEGIN
        //>> ORACLE UPG
        /*
            //SQLQuery := 'select * from Vendor_Cust_List where NO in(''CUST00971'',''CUST00972'') and (MAIL_SEND_COUNT <=0 or MAIL_SEND_COUNT is null) order by type,no;';
            SQLQuery := 'select * from Vendor_Cust_List where (GST_REG_NO is null) and NO = ''' + Rec."No." + ''' order by type,no';
            //MESSAGE(SQLQuery);
            RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
            IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                RecordSet.MoveFirst;
            WHILE NOT RecordSet.EOF DO BEGIN
                Color_GST_Update := 'StrongAccent';
                RowCount := RowCount + 1;
                RecordSet.MoveNext;
            END;
            //RecordSet.Close;
            //SQLConnection.CommitTrans;
            */
        //<< ORACLE UPG
    END;
}