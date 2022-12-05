pageextension 70063 GeneralLedgerSetupExt extends "General Ledger Setup"
{
    layout
    {
        modify("Allow Posting To")
        {
            trigger OnBeforeValidate()
            begin
                //TAMS_BASED_USERS_BLOCKING;
                // CS SHORTAGE MATERIAL AUTOMATIC REPORT
                //dcMails.MailDC; // added by vishnu
                Stock_Alert_On_Threshold; // added by sujani 17-sep-2018 for alerting the item details based threshold value specified
                Open_Orders_Allert; // added by vishnu priya for the verified-open orders alerts
                                    // IF DATE2DWY("Allow Posting To", 1) IN [1,4] THEN //added by vishnu priya 0-sun,1-mon,2-tues,3-wednes,4-thurs,5-fri,6-sat
                                    // RD_Mail_for_SalesOrders;//added by vishnu priya 0-sun,1-mon,2-tues,3-wednes,4-thurs,5-fri,6-sat
                SALESACTUALSDUMPING; //added  by vishnu
                                     //   Stock_Analysis; //added by Vishnu Priya on 02-08-2019
                                     //  SDStatusUpdation; // SDs Statsu updation vishnu
                IREPS_Tenders; // Added by Vishnu Priya on 01-03-2019 for IREPS Alerts
                               // CalibrationAlerts;  // Added by Vishnu Priya on 01-03-2019 for QC Alerts

                CSIGCS_MAIL; // added by vishnu priya on 30-10-2019 for CS IGC not update alerting purpose.

                // Posting Date Change to Active users only on 02-07-2019
                //QAFLAG;
                user.RESET;
                user.SETRANGE(Blocked, FALSE);
                IF user.FINDSET THEN
                    REPEAT
                        USER_SETUP.RESET;
                        USER_SETUP.SETFILTER("User ID", user."User ID");
                        IF USER_SETUP.FINDSET THEN
                            REPEAT
                                IF NOT (USER_SETUP."User ID" IN ['EFFTRONICS\RAJANI', 'EFFTRONICS\SITARAJYAM', 'EFFTRONICS\ASWINI', 'EFFTRONICS\YESU']) THEN BEGIN
                                    USER_SETUP."Allow Posting To" := Rec."Allow Posting To";
                                    USER_SETUP.MODIFY;
                                END
                                ELSE
                                    IF (USER_SETUP."User ID" IN ['EFFTRONICS\SITARAJYAM', 'EFFTRONICS\ASWINI']) THEN BEGIN
                                        USER_SETUP."Allow Posting To" := CALCDATE('900D', TODAY());
                                        USER_SETUP.MODIFY;
                                    END
                                    ELSE
                                        IF (USER_SETUP."User ID" IN ['EFFTRONICS\RAJANI', 'EFFTRONICS\YESU']) THEN BEGIN
                                            USER_SETUP."Allow Posting To" := CALCDATE('31D', TODAY());
                                            USER_SETUP.MODIFY;
                                            /* IF DATE2DMY("Allow Posting To", 1) = 1 THEN BEGIN
                                                IF DATE2DMY("Allow Posting To", 2) + 1 = 13 THEN
                                                    USER_SETUP."Allow Posting To" := DMY2DATE(1, 1, DATE2DMY("Allow Posting To", 3) + 1)
                                                ELSE
                                                    USER_SETUP."Allow Posting To" := DMY2DATE(1, DATE2DMY("Allow Posting To", 2) + 1, DATE2DMY("Allow Posting To", 3));
                                                USER_SETUP.MODIFY;
                                            END; */
                                        END;
                            UNTIL USER_SETUP.NEXT = 0;
                    UNTIL user.NEXT = 0;
                //commented by Vishnu Priya to restrict all users postings

                /* IF USER_SETUP.FINDSET THEN
       REPEAT
           IF NOT (USER_SETUP."User ID" IN ['EFFTRONICS\RAJANI', 'EFFTRONICS\SITARAJYAM', 'EFFTRONICS\ASWINI', 'EFFTRONICS\RAMKUMARL',
                                           'EFFTRONICS\YESU']) THEN BEGIN
               USER_SETUP."Allow Posting To" := "Allow Posting To";
               USER_SETUP.MODIFY;
           END
           ELSE
               IF (USER_SETUP."User ID" IN ['EFFTRONICS\SITARAJYAM', 'EFFTRONICS\ASWINI']) THEN BEGIN
                   USER_SETUP."Allow Posting To" := CALCDATE('92D', TODAY());
                   USER_SETUP.MODIFY;

               END
               ELSE
                   IF (USER_SETUP."User ID" IN ['EFFTRONICS\RAJANI', 'EFFTRONICS\RAMKUMARL',
                                              'EFFTRONICS\YESU', 'EFFTRONICS\DURGARAOV']) THEN BEGIN
                       USER_SETUP."Allow Posting To" := CALCDATE('31D', TODAY());
                       USER_SETUP.MODIFY;

                       {IF DATE2DMY("Allow Posting To", 1) = 1 THEN BEGIN
                           IF DATE2DMY("Allow Posting To", 2) + 1 = 13 THEN
                               USER_SETUP."Allow Posting To" := DMY2DATE(1, 1, DATE2DMY("Allow Posting To", 3) + 1)
                           ELSE
                               USER_SETUP."Allow Posting To" := DMY2DATE(1, DATE2DMY("Allow Posting To", 2) + 1, DATE2DMY("Allow Posting To", 3));
                           USER_SETUP.MODIFY;
                       END;}
                  END;

                UNTIL USER_SETUP.NEXT=0; */

                //commented by Vishnu Priya to restrict all users postings

                Rec."Restrict Store Material Issues" := FALSE;
                IF Rec."Production_ Shortage_Status" <> Rec."Production_ Shortage_Status"::Accepted THEN
                    Rec."Production_ Shortage_Status" := Rec."Production_ Shortage_Status"::nothing;
                Rec."Allow Posting to(15)" := Rec."Allow Posting To" - 15;
                Rec.MODIFY;

                New_Line := 10;
                /* bg.SETRANGE(bg.Status, bg.Status::Open);
                bg.SETFILTER(bg."Expiry Date", '<%1', TODAY + 10);
                MESSAGE(FORMAT(TODAY + 10));
                bg.SETFILTER(bg."Claim Date", '=%1', 0D);
                //REPORT.RUN(50202,FALSE,FALSE,bg);
                REPORT.SAVEASPDF(33000891, '\\erpserver\ErpAttachments\bg1.PDF', FALSE, bg);
                Attachment := '\\erpserver\ErpAttachments\bg1.PDF';
                bg.RESET; */
                //bg.SETRANGE(bg.Status,bg.Status::Open); for relase option purpose
                bg.SETFILTER(bg.Closed, 'No');
                bg.SETFILTER(bg."BG No.", '<>%1', 'F%');
                bg.SETFILTER(bg."Claim Date", '<%1', TODAY + 10);
                //bg.SETFILTER(bg."Expiry Date",'<>%1',0D);
                bg.SETFILTER(bg."Expiry Date", '<%1', TODAY + 10);
                IF bg.FINDFIRST THEN BEGIN
                    //REPORT.RUN(33000891,FALSE,FALSE,bg);
                    REPORT.SAVEASPDF(33000891, '\\erpserver\ErpAttachments\bg1.pdf', bg);
                    Attachment1 := '\\erpserver\ErpAttachments\bg1.pdf';
                    Subject := 'ERP- Possible expire BG Details for the coming 10 Days';


                    /* IF bg.FINDSET THEN
                    REPEAT
                    IF bg."Claim Date"=0D THEN
                    BEGIN
                    Subject:='ERP- BG Will Expire for '+bg."BG No.";
                    Body:='Customer Name      : '+bg."Issued to/Received from";
                    Body+=FORMAT(New_Line);
                    Body+='Customer Order No. : '+bg."Customer Order No.";
                    Body+=FORMAT(New_Line);
                    Body+='BG Value           : '+FORMAT(bg."BG Value");
                    Body+=FORMAT(New_Line);
                    Body+='BG Expired Date   : '+FORMAT((bg."Expiry Date"),0,4);
                    Body+=FORMAT(New_Line);
                    Body+=FORMAT(New_Line); */


                    /* Body := '***** Auto Mail Generated From ERP *****'; //B2BUPG
                    Mail_From := 'noreply@efftronics.com';
                    //Mail_To:='sreenu@efftronics.com';
                    IF FORMAT(bg."Transaction Type") = 'amc' THEN BEGIN
                        Mail_To := 'rajani@efftronics.com,yesu@efftronics.com,susmithal@efftronics.com,erp@efftronics.com,';
                        Mail_To += 'sales@efftronics.com';
                    END
                    ELSE BEGIN
                        //Mail_To:='anilkumar@efftronics.com';
                        Mail_To := 'rajani@efftronics.com,';//dir
                        Mail_To += 'sales@efftronics.com,yesu@efftronics.com,susmithal@efftronics.com,erp@efftronics.com';
                    END;
                    //attachment13:='';
                    attachment14 := Attachment;
                    IF (Mail_From <> '') AND (Mail_To <> '') THEN
                        SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
                    //EFFUPG Start

                    // SMTP_MAIL.AddAttachment(Attachment1);
                   // SMTP_MAIL.AddAttachment(attachment13);
                    //SMTP_MAIL.AddAttachment(attachment14);

                    SMTP_MAIL.AddAttachment(Attachment1, '');
                    // SMTP_MAIL.AddAttachment(attachment13);
                    SMTP_MAIL.AddAttachment(attachment14, '');
                    //  SMTP_MAIL.Send;
                    //EFFUPG End */             //B2BUPG

                    Body := '***** Auto Mail Generated From ERP *****';
                    IF FORMAT(bg."Transaction Type") = 'amc' THEN BEGIN
                        Recipients.Add('rajani@efftronics.com');
                        Recipients.Add('yesu@efftronics.com');
                        Recipients.Add('susmithal@efftronics.com');
                        Recipients.Add('erp@efftronics.com');
                        Recipients.Add('sales@efftronics.com');
                    END
                    ELSE BEGIN
                        Recipients.Add('rajani@efftronics.com');
                        Recipients.Add('yesu@efftronics.com');
                        Recipients.Add('susmithal@efftronics.com');
                        Recipients.Add('erp@efftronics.com');
                        Recipients.Add('sales@efftronics.com');
                    END;
                    attachment14 := Attachment;
                    IF (Mail_From <> '') AND (Mail_To <> '') THEN
                        EmailMessage.Create(Recipients, Subject, Body, true);


                    EmailMessage.AddAttachment(Attachment, '', '');
                    EmailMessage.AddAttachment(attachment14, '', '');
                END;

                /* Item.CALCFIELDS(Item."Stock at CS Stores");
                Item.SETFILTER(Item."Safety Stock Qty (CS)", '>%1', Item."Stock at CS Stores");
                Cs_Shortage_QTY := Item.COUNT;
                Body += '****  Automatic Mail Generated From ERP  ****';

                REPORT.RUN(1102, FALSE, FALSE, Item);
                "g/l setup".FINDFIRST;
                REPORT.SAVEASPDF(1102, FORMAT('\\erpserver\ErpAttachments\' + 'Cs Shortage' + '.PDF'), FALSE);

                Mail_From := 'anilkumar@efftronics.com';
                Mail_To := 'Prasanthi@efftronics.com,shilpa@efftronics.com,Ramadevi@efftronics.com,nayomi@efftronics.com,';
                Mail_To += 'anilkumar@efftronics.com,anilkumar@efftronics.com';
                //  Mail_To:='anilkumar@efftronics.com';
                Subject := ' Shortage at CS Stores ';

                Attachment := '\\erpserver\ErpAttachments\' + 'Cs Shortage.PDF';
                //     Mail.NewCDOMessage(Mail_From,Mail_To,Subject,Body,Attachment);
                SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
                //  SMTP_MAIL.AddAttachment(Attachment1);
                // SMTP_MAIL.AddAttachment(attachment13);
                SMTP_MAIL.AddAttachment(Attachment);
                SMTP_MAIL.Send; */

                /* //Daily Transactions report
                totalsales := 0;
                totalreceivedamts := 0;
                totalpayments := 0;
                fromdate := "Allow Posting To" - 1;
                SIH.RESET;
                SIH.SETRANGE(SIH."Posting Date", fromdate, fromdate);
                IF SIH.FINDSET THEN
                    REPEAT
                        SIH.CALCFIELDS(SIH."Total Invoiced Amount");
                        totalsales := totalsales + SIH."Total Invoiced Amount";
                    UNTIL SIH.NEXT = 0;
                S1 := formataddress.ChangeCurrency(totalsales);
                CLE.RESET;
                CLE.SETFILTER(CLE."Amount (LCY)", '<%1', 0);
                CLE.SETRANGE(CLE."Posting Date", fromdate, fromdate);
                IF CLE.FINDSET THEN
                    REPEAT
                        CLE.CALCFIELDS(CLE."Amount (LCY)");
                        totalreceivedamts := totalreceivedamts + ABS(CLE."Amount (LCY)");
                    UNTIL CLE.NEXT = 0;
                S2 := formataddress.ChangeCurrency(totalreceivedamts);
                VLE.RESET;
                VLE.SETFILTER(VLE."Amount (LCY)", '>%1', 0);
                VLE.SETRANGE(VLE."Posting Date", fromdate, fromdate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS(VLE."Amount (LCY)");
                        totalpayments := totalpayments + VLE."Amount (LCY)";
                    UNTIL VLE.NEXT = 0;
                S3 := formataddress.ChangeCurrency(ROUND(totalpayments, 1));
                SIH.RESET;
                SIH.SETRANGE(SIH."Posting Date", fromdate, fromdate);
                IF SIH.FINDFIRST THEN BEGIN
                    REPORT.RUN(50186, FALSE, FALSE, SIH);
                    //   REPORT.SAVEASPDF(50186,'\\eff-cpu-211\erp\testing1.PDF',FALSE,SIH);
                    //   Attachment1:='\\eff-cpu-211\erp\testing1.PDF';
                    REPORT.SAVEASPDF(50186, '\\erpserver\ERPattachments\salestrans.pdf', SIH);
                    Attachment1 := '\\erpserver\erpattachments\salestrans.pdf';
                END ELSE
                    Attachment1 := '';
                CLE.RESET;
                CLE.SETFILTER(CLE."Amount (LCY)", '<%1', 0);
                CLE.SETRANGE(CLE."Posting Date", fromdate, fromdate);
                IF CLE.FINDFIRST THEN BEGIN
                    REPORT.RUN(50187, FALSE, FALSE, CLE);
                    //   REPORT.SAVEASPDF(50187,'\\eff-cpu-211\erp\testing2.PDF',FALSE,CLE);
                    //   attachment13:='\\eff-cpu-211\erp\testing2.PDF';
                    REPORT.SAVEASpdf(50187, '\\erpserver\ERPattachments\custpayments.pdf', CLE);
                    attachment13 := '\\erpserver\ERPattachments\custpayments.PDF';
                END ELSE
                    attachment13 := '';
                VLE.RESET;
                VLE.SETFILTER(VLE."Amount (LCY)", '>%1', 0);
                VLE.SETRANGE(VLE."Posting Date", fromdate, fromdate);
                IF VLE.FINDFIRST THEN BEGIN
                    REPORT.RUN(50188, FALSE, FALSE, VLE);
                    //   REPORT.SAVEASPDF(50188,'\\eff-cpu-211\erp\testing3.PDF',FALSE,VLE);
                    //   attachment14:='\\eff-cpu-211\erp\testing3.PDF';
                    REPORT.SAVEASPDF(50188, '\\erpserver\ERPattachments\vendorpayments.PDF', VLE);
                    attachment14 := '\\erpserver\ERPattachments\vendorpayments.PDF';
                END ELSE
                    attachment14 := '';
                Subject := FORMAT(fromdate, 0, 4) + ' Consolidate Transactions Summary ';
                Mail_From := 'erp@efftronics.com';
                //     Mail_To:='sreenu@efftronics.com';
                //   Mail_To:='dmadhavi@efftronics.com,fathima@efftronics.com,padmaja@efftronics.com,';
                //  Mail_To+='cvmohan@efftronics.com,anilkumar@efftronics.com,sitarani@efftronics.com';
                Mail_To := 'ceo@efftronics.com,anilkumar@efftronics.com,sganesh@efftronics.com,';//dir
                Mail_To += 'padmaja@efftronics.com';
                Body := '<body><strong><form><table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
                Body += 'border="1" align="left">';
                Body += '<tr><td>Total Sales</td><td>' + S1 + '</td></tr><br>';
                Body += '<tr><td>Total Received Amount from Customers</td><td>' + S2;
                Body += '</td></tr><br>';
                Body += '<tr><td>Total Paid Amount to Suppliers</td><td>' + S3;
                Body += '</td></tr></table></body>';
                {
                Body+='<br><br>Total Sales.............................:'+FORMAT(ROUND(totalsales,1));
                Body+='<br><br>Total Received Amount from Customers....:'+FORMAT(ROUND(totalreceivedamts,1));
                Body+='<br><br>Total Paid Amount to Suppliers..........:'+FORMAT(ROUND(totalpayments,1)); 
                }
                Body += '<br><br><br>****  Automatic Mail Generated From ERP  ****';
                //Attachment1:='';
                //    NewCDOMessage(Mail_From,Mail_To,Subject,Body,Attachment1,attachment13,attachment14);
                // CS SHORTAGE MATERIAL AUTOMATIC REPORT

                Item.CALCFIELDS(Item."Stock at CS Stores");
                Item.SETFILTER(Item."Safety Stock Qty (CS)", '>%1', Item."Stock at CS Stores");
                Cs_Shortage_QTY := Item.COUNT;
                Body += '****  Automatic Mail Generated From ERP  ****';

                REPORT.RUN(1102, FALSE, FALSE, Item);
                "g/l setup".FINDFIRST;
                REPORT.SAVEASPDF(1102, FORMAT('\\erpserver\ErpAttachments\' + 'Cs Shortage' + '.PDF'), FALSE);

                Mail_From := 'noreply@efftronics.com';
                Mail_To := 'Prasanthi@efftronics.com,shilpa@efftronics.com,Ramadevi@efftronics.com,nayomi@efftronics.com,';
                Mail_To += 'anilkumar@efftronics.com,anilkumar@efftronics.com';
                //  Mail_To:='anilkumar@efftronics.com';
                Subject := ' Shortage at CS Stores ';

                Attachment := '\\erpserver\ErpAttachments\' + 'Cs Shortage.PDF';
                SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
                //  SMTP_MAIL.AddAttachment(Attachment1);
                // SMTP_MAIL.AddAttachment(attachment13);
                SMTP_MAIL.AddAttachment(Attachment);
                SMTP_MAIL.Send;

                //     Mail.NewCDOMessage(Mail_From,Mail_To,Subject,Body,Attachment); */

                /* //BG Alert for BG Expiration Date

                New_Line := 10;
                bg.SETRANGE(bg.Status, bg.Status::Open);
                bg.SETFILTER(bg."Expiry Date", '<%1', TODAY + 10);
                MESSAGE(FORMAT(TODAY + 10));
                bg.SETFILTER(bg."Claim Date", '=%1', 0D);
                REPORT.RUN(50202, FALSE, FALSE, bg);
                REPORT.SAVEASPDF(33000891, '\\erpserver\ErpAttachments\bg2.PDF', FALSE, bg);
                Attachment := '\\erpserver\ErpAttachments\bg2.PDF';
                             {bg.RESET;
                bg.SETRANGE(bg.Status, bg.Status::Open);
                bg.SETFILTER(bg."Claim Date", '<%1', TODAY + 10);
                bg.SETFILTER(bg."Expiry Date", '<>%1', 0D);
                REPORT.RUN(33000891, FALSE, FALSE, bg);
                REPORT.SAVEASPDF(33000891, '\\erpserver\ErpAttachments\bg1.PDF', FALSE, bg);
                Attachment1 := '\\erpserver\ErpAttachments\bg1.PDF';
                Subject := 'ERP- Possible expire BG Details for the coming 10 Days'; */


                /* IF bg.FINDSET THEN
                REPEAT
                IF bg."Claim Date"=0D THEN
                BEGIN
                Subject:='ERP- BG Will Expire for '+bg."BG No.";
                Body:='Customer Name      : '+bg."Issued to/Received from";
                Body+=FORMAT(New_Line);
                Body+='Customer Order No. : '+bg."Customer Order No.";
                Body+=FORMAT(New_Line);
                Body+='BG Value           : '+FORMAT(bg."BG Value");
                Body+=FORMAT(New_Line);
                Body+='BG Expired Date   : '+FORMAT((bg."Expiry Date"),0,4);
                Body+=FORMAT(New_Line);
                Body+=FORMAT(New_Line); */


                /* Body := '***** Auto Mail Generated From ERP *****';
                Mail_From := 'erp@efftronics.com';
                //Mail_To:='sreenu@efftronics.com';
                IF FORMAT(bg."Transaction Type") = 'amc' THEN
                    Mail_To := 'sganesh@efftronics.com,rajani@efftronics.com,yesu@efftronics.com,prasannat@efftronics.com,anilkumar@efftronics.com,'
                ELSE BEGIN
                    //Mail_To:='sganesh@efftronics.com,rajani@efftronics.com,dir@efftronics.com,';
                    Mail_To += 'anuradhag@efftronics.com,anilkumar@efftronics.com';
                END;
                //attachment13:='';
                Mail_To := 'sales@efftronics.com';
                attachment14 := Attachment;
                IF (Mail_From <> '') AND (Mail_To <> '') THEN
                    SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
                //  SMTP_MAIL.AddAttachment(Attachment1);
                // SMTP_MAIL.AddAttachment(attachment13);
                SMTP_MAIL.AddAttachment(attachment14);
                SMTP_MAIL.Send; */      //B2BUPG

                Body := '***** Auto Mail Generated From ERP *****';
                IF FORMAT(bg."Transaction Type") = 'amc' THEN begin
                    Recipients.Add('sganesh@efftronics.com');
                    Recipients.Add('rajani@efftronics.com');
                    Recipients.Add('yesu@efftronics.com');
                    Recipients.Add('prasannat@efftronics.com');
                    Recipients.Add('anilkumar@efftronics.com');
                end
                ELSE BEGIN
                    Recipients.Add('anuradhag@efftronics.com');
                    Recipients.Add('anilkumar@efftronics.com');
                END;

                Recipients.Add('sales@efftronics.com');
                attachment14 := Attachment;
                IF (Mail_From <> '') AND (Mail_To <> '') THEN
                    EmailMessage.Create(Recipients, Subject, Body, true);
                EmailMessage.AddAttachment(attachment14, '', '');
                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

                // NewCDOMessage(Mail_From,Mail_To,Subject,Body,Attachment,attachment13,attachment14);

                //END;
                //UNTIL bg.NEXT=0;



                /* // Peinding Material Requests For Stores
                MIH.SETRANGE(MIH."Transfer-from Code", 'STR');
                MIH.SETRANGE(MIH.Status, MIH.Status::Released);
                MIH.SETFILTER(MIH."Released Date", '<%1', TODAY - 1);
                REPORT.RUN(5985, FALSE, FALSE, MIH);
                REPORT.SAVEASPDF(5985, '\\Eff-cpu-222\ErpAttachments\santhosh.PDF', FALSE, MIH);

                Body := '****  Automatic Mail Generated From ERP  ****';
                Mail_From := 'anilkumar@efftronics.com';
                //     Mail_To:='dmadhavi@efftronics.com,fathima@efftronics.com,padmaja@efftronics.com,';
                //     Mail_To+='cvmohan@efftronics.com,anilkumar@efftronics.com,sitarani@efftronics.com';
                Mail_To := 'anilkumar@efftronics.com';
                Subject := FORMAT(MIH.COUNT) + ' STR Issues Pending ';
                Attachment1 := '\\eff-cpu-222\ErpAttachments\santhosh.PDF';
                Mail.NewCDOMessage(Mail_From, Mail_To, Subject, Body, Attachment1);



                // Peinding Material Requests For R&D Str
                MIH.SETRANGE(MIH."Transfer-from Code", 'R&D STR');
                MIH.SETRANGE(MIH.Status, MIH.Status::Released);
                MIH.SETFILTER(MIH."Released Date", '<%1', TODAY - 1);
                REPORT.RUN(5985, FALSE, FALSE);
                "g/l setup".FINDFIRST;
                REPORT.SAVEASPDF(5985, FORMAT('\\Eff-cpu-222\ErpAttachments\santhosh.PDF'), FALSE);

                Body := '****  Automatic Mail Generated From ERP  ****';
                Mail_From := 'anilkumar@efftronics.com';
                Mail_To := 'dmadhavi@efftronics.com,sowjanya@efftronics.com,padmaja@efftronics.com,';
                Mail_To += 'cvmohan@efftronics.com,anilkumar@efftronics.com';
                // Mail_To:='swarupa@efftronics.com';
                Subject := FORMAT(MIH.COUNT) + ' R&D STR Issues Pending ';
                Attachment1 := '\\eff-cpu-222\ErpAttachments\santhosh.PDF';
                Mail.NewCDOMessage(Mail_From, Mail_To, Subject, Body, Attachment1); */


                /* // Peinding Material Requests For Cs Stores
                MIH.SETRANGE(MIH."Transfer-from Code", 'CS STR');
                MIH.SETRANGE(MIH.Status, MIH.Status::Released);
                MIH.SETFILTER(MIH."Released Date", '<%1', TODAY - 1);
                IF MIH.FINDFIRST THEN BEGIN

                    REPORT.RUN(5985, FALSE, FALSE, MIH);
                    "g/l setup".FINDFIRST;
                    REPORT.SAVEASPDF(5985, '\\eff-cpu-222\ErpAttachments\Pending CS Str Material Requests.PDF', MIH);

                    Body := '****  Automatic Mail Generated From ERP  ****';
                    Mail_From := 'anilkumar@efftronics.com';
                    Mail_To := 'dmadhavi@efftronics.com,nayomi@efftronics.com,padmaja@efftronics.com,';
                    Mail_To += 'cvmohan@efftronics.com,anilkumar@efftronics.com,prasanthi@efftronics.com,shilpa@efftronics.com';

                    Subject := FORMAT(MIH.COUNT) + 'CS STR Issues Pending ';
                    Attachment1 := '\\eff-cpu-222\ErpAttachments\Pending CS Str Material Requests.PDF';
                    Mail.NewCDOMessage(Mail_From, Mail_To, Subject, Body, Attachment1);
                END; */


                // Qc Pending Inwards


                /* max := TODAY - 1;
                min := 040108D;
                IDS.SETFILTER(IDS."Source Type", 'In Bound');
                IF IDS.GETFILTER(IDS."Created Date") <> '' THEN BEGIN                                                               //modified by swarupa(13-01-09) for count
                    max := IDS.GETRANGEMAX(IDS."Created Date");
                    min := IDS.GETRANGEMIN(IDS."Created Date");
                END ELSE BEGIN
                    max := TODAY - 1;
                    min := 040108D;
                    IDS.SETRANGE(IDS."Created Date", min, max);
                    PENDING := IDS.COUNT;
                END;

                //   MESSAGE(FORMAT(PENDING));
                IR.SETRANGE(IR."IDS creation Date", min, max);
                IR.SETRANGE(IR.Status, FALSE);
                IR.SETFILTER(IR."Source Type", 'In Bound');
                PENDING += IR.COUNT;
                //MESSAGE(FORMAT(PENDING));
                REPORT.RUN(50039, FALSE, FALSE, IDS);
                REPORT.SAVEASPDF(50039, '\\Eff-cpu-222\ErpAttachments\qc Pending Inwards.PDF', IDS);


                Body := '****  Automatic Mail Generated From ERP  ****';
                Mail_From := 'anilkumar@efftronics.com';
                Mail_To := 'bharat@efftronics.com,padmaja@efftronics.com,';
                Mail_To += 'cvmohan@efftronics.com,anilkumar@efftronics.com,nayomi@efftronics.com,sowjanya@efftronics.com';
                //Mail_To:='swarupa@efftronics.com';
                Subject := FORMAT(PENDING) + ' Qc Inwards Pending ';
                Attachment1 := '\\eff-cpu-222\ErpAttachments\qc Pending Inwards.PDF';
                //    Mail.NewCDOMessage(Mail_From,Mail_To,Subject,Body,Attachment1);
                SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
                //  SMTP_MAIL.AddAttachment(Attachment1);
                // SMTP_MAIL.AddAttachment(attachment13);
                SMTP_MAIL.AddAttachment(attachment14);
                SMTP_MAIL.Send; */



                // Pending Purchase Inward Material For Stores

                /* Pl.SETRANGE(Pl."Location Code", 'STR');
                REPORT.RUN(50169, FALSE, FALSE, Pl);
                REPORT.SAVEASPDF(50169, '\\eff-cpu-222\ErpAttachments\Pending Purchase Inwards at STR.PDF', FALSE, Pl);

                Body := '****  Automatic Mail Generated From ERP  ****';
                Mail_From := 'anilkumar@efftronics.com';
                Mail_To := 'purchase@efftronics.com,dmadhavi@efftronics.com,';
                Mail_To += 'cvmohan@efftronics.com,anilkumar@efftronics.com';
                // Mail_To:='swarupa@efftronics.com';
                Subject := ' Str Pending Purchase Material ';
                Attachment1 := '\\eff-cpu-222\ErpAttachments\Pending Purchase Inwards at Str.PDF';
                Mail.NewCDOMessage(Mail_From, Mail_To, Subject, Body, Attachment1); */




                // Pending Purchase Inward Material For R&D Stores

                /* REPORT.RUN(50169, FALSE, FALSE);
                REPORT.SAVEASPDF(50169, '\\eff-cpu-222\ErpAttachments\Pending Purchase Inwards at R&D Str.PDF', FALSE);

                Body := '****  Automatic Mail Generated From ERP  ****';
                Mail_From := 'anilkumar@efftronics.com';
                Mail_To := 'purchase@efftronics.com,dmadhavi@efftronics.com,sowjanya@efftronics.com,';
                Mail_To += 'cvmohan@efftronics.com,anilkumar@efftronics.com';
                //   Mail_To:='swarupa@efftronics.com';
                Subject := 'R&D Str Pending Purchase Material ';
                Attachment1 := '\\eff-cpu-222\ErpAttachments\Pending Purchase Inwards at R&D Str.PDF';
                Mail.NewCDOMessage(Mail_From, Mail_To, Subject, Body, Attachment1);

                // Pending Purchase Inward Material For CS Stores

                Pl.SETRANGE(Pl."Location Code", 'CS STR');
                IF Pl.FINDFIRST THEN
                    REPORT.RUN(50169, FALSE, FALSE, Pl);
                REPORT.SAVEASPDF(50169, '\\eff-cpu-222\ErpAttachments\Pending Purchase Inwards at CS Str.PDF', FALSE, Pl);

                Body := '****  Automatic Mail Generated From ERP  ****';
                Mail_From := 'anilkumar@efftronics.com';
                Mail_To := 'purchase@efftronics.com,dmadhavi@efftronics.com,nayomi@efftronics.com,';
                Mail_To += 'cvmohan@efftronics.com,anilkumar@efftronics.com,prasanthi@efftronics.com,shilpa@efftronics.com';
                //    Mail_To:='swarupa@efftronics.com';
                Subject := 'CS Str Pending Purchase Material ';
                Attachment1 := '\\eff-cpu-222\ErpAttachments\Pending Purchase Inwards at Cs Str.PDF';
                Mail.NewCDOMessage(Mail_From, Mail_To, Subject, Body, Attachment1);

                // Future Arrival Material For Main Stores
                Pl.SETRANGE(Pl."Location Code", 'STR');
                IF Pl.FINDFIRST THEN
                    REPORT.RUN(310, FALSE, FALSE, Pl);
                REPORT.SAVEASPDF(310, '\\eff-cpu-222\ErpAttachments\Future Purchase Inwards at Str.PDF', FALSE, Pl);

                Body := '****  Automatic Mail Generated From ERP  ****';
                Mail_From := 'anilkumar@efftronics.com';
                Mail_To := 'purchase@efftronics.com,dmadhavi@efftronics.com,padmaja@efftronics.com,bharat@efftronics.com,';
                Mail_To += 'cvmohan@efftronics.com,anilkumar@efftronics.com';
                //  Mail_To:='swarupa@efftronics.com';
                Subject := 'Str Future Purchase Inward Material ';
                Attachment1 := '\\EFF-CPU-222\ErpAttachments\Future Purchase Inwards at Str.PDF';
                Mail.NewCDOMessage(Mail_From, Mail_To, Subject, Body, Attachment1);

                // Future Arrival Material  For R&D Stores
                REPORT.RUN(310, FALSE, FALSE);
                REPORT.SAVEASPDF(310, '\\eff-cpu-222\ErpAttachments\Future Purchase Inwards at R&D Str.PDF', FALSE);

                Body := '****  Automatic Mail Generated From ERP  ****';
                Mail_From := 'anilkumar@efftronics.com';
                Mail_To := 'purchase@efftronics.com,dmadhavi@efftronics.com,sowjanya@efftronics.com' +
                         ',padmaja@efftronics.com,bharat@efftronics.com,';
                Mail_To += 'cvmohan@efftronics.com,anilkumar@efftronics.com';
                //  Mail_To:='swarupa@efftronics.com';
                Subject := 'R&D Str Future  Purchase Inward Material ';
                Attachment1 := '\\EFF-CPU-222\ErpAttachments\Future Purchase Inwards at R&D Str.PDF';
                Mail.NewCDOMessage(Mail_From, Mail_To, Subject, Body, Attachment1);

                // Future Arrival Material   For Cs Stores
                Pl.SETRANGE(Pl."Location Code", 'CS STR');
                IF Pl.FINDFIRST THEN
                    REPORT.RUN(310, FALSE, FALSE, Pl);
                REPORT.SAVEASPDF(310, '\\eff-cpu-222\ErpAttachments\Future Purchase Inwards at CS Str.PDF', FALSE, Pl);

                Body := '****  Automatic Mail Generated From ERP  ****';
                Mail_From := 'anilkumar@efftronics.com';
                Mail_To := 'purchase@efftronics.com,dmadhavi@efftronics.com,nayomi@efftronics.com,' +
                          'padmaja@efftronics.com,bharat@efftronics.com,';
                Mail_To += 'cvmohan@efftronics.com,anilkumar@efftronics.com,prasanthi@efftronics.com,shilpa@efftronics.com';
                //  Mail_To:='swarupa@efftronics.com';
                Subject := 'CS Str Future Purchase Inward Material ';
                Attachment1 := '\\EFF-CPU-222\ErpAttachments\Future Purchase Inwards at CS Str.PDF';
                Mail.NewCDOMessage(Mail_From, Mail_To, Subject, Body, Attachment1);


                // Pending Purchase Bills From Purchase
                PRL.SETFILTER(PRL."Document date", '>%1', 040108D);
                IF PRL.FINDFIRST THEN
                    REPORT.RUN(301, FALSE, FALSE, PRL);
                REPORT.SAVEASPDF(301, '\\eff-cpu-222\ErpAttachments\Pending Purchase Bills(PUR).PDF', FALSE, PRL);

                Body := '****  Automatic Mail Generated From ERP  ****';

                Mail_From := 'anilkumar@efftronics.com';
                Mail_To := 'purchase@efftronics.com,';
                Mail_To += 'cvmohan@efftronics.com,anilkumar@efftronics.com';

                Subject := 'Pending Purchase Bills of PUR From April 2008';
                Attachment1 := '\\EFF-CPU-222\ErpAttachments\Pending Purchase Bills(PUR).PDF';
                Mail.NewCDOMessage(Mail_From, Mail_To, Subject, Body, Attachment1);


                //STR Returns Pending

                RETMIH.SETFILTER(RETMIH.Status, 'Released');
                RETMIH.SETRANGE(RETMIH."Transfer-to Code", 'STR');
                IF RETMIH.FINDFIRST THEN
                    REPORT.RUN(50097, FALSE, FALSE, RETMIH);
                REPORT.SAVEASPDF(50097, '\\Eff-cpu-222\ErpAttachments\qc Pending Returns.PDF', FALSE, RETMIH);
                Mail_From := 'anilkumar@efftronics.com';
                //  Mail_To:='swarupa@efftronics.com';
                Mail_To := 'bharat@efftronics.com,padmajak@efftronics.com,str@efftronics.com,anilkumar@efftronics.com';
                Subject := FORMAT(RETMIH.COUNT) + ' STR Returns Pending';
                Attachment1 := '\\EFF-CPU-222\ErpAttachments\qc Pending Returns.PDF';
                Mail.NewCDOMessage(Mail_From, Mail_To, Subject, Body, Attachment1);


                //RDSTR Returns Pending

                RETMIH.SETFILTER(RETMIH.Status, 'Released');
                RETMIH.SETRANGE(RETMIH."Transfer-to Code", 'R&D STR');
                RETMIH.SETFILTER(RETMIH."Transfer-from Code", '<>%1', 'STR');
                IF RETMIH.FINDFIRST THEN
                    REPORT.RUN(50097, FALSE, FALSE, RETMIH);
                REPORT.SAVEASPDF(50097, '\\Eff-cpu-222\ErpAttachments\qc Pending Returns.PDF', FALSE, RETMIH);
                Mail_From := 'anilkumar@efftronics.com';
                //    Mail_To:='swarupa@efftronics.com';
                Mail_To := 'bharat@efftronics.com,padmajak@efftronics.com,str@efftronics.com,anilkumar@efftronics.com';
                Subject := FORMAT(RETMIH.COUNT) + ' RD STR Returns Pending';
                Attachment1 := '\\EFF-CPU-222\ErpAttachments\qc Pending Returns.PDF';
                Mail.NewCDOMessage(Mail_From, Mail_To, Subject, Body, Attachment1);


                //CSSTR Returns Pending

                RETMIH.SETFILTER(RETMIH.Status, 'Released');
                RETMIH.SETRANGE(RETMIH."Transfer-to Code", 'CS STR');
                RETMIH.SETFILTER(RETMIH."Transfer-from Code", '<>%1', 'STR');
                IF RETMIH.FINDFIRST THEN
                    REPORT.RUN(50097, FALSE, FALSE, RETMIH);
                REPORT.SAVEASPDF(50097, '\\Eff-cpu-222\ErpAttachments\qc Pending Returns.PDF', FALSE, RETMIH);
                Mail_From := 'anilkumar@efftronics.com';
                //  Mail_To:='swarupa@efftronics.com';
                Mail_To := 'bharat@efftronics.com,padmajak@efftronics.com,str@efftronics.com,anilkumar@efftronics.com';
                Subject := FORMAT(RETMIH.COUNT) + ' CS STR Returns Pending';
                Attachment1 := '\\EFF-CPU-222\ErpAttachments\qc Pending Returns.PDF';
                Mail.NewCDOMessage(Mail_From, Mail_To, Subject, Body, Attachment1);
                IF (DATE2DWY(TODAY, 1) = 2) OR (DATE2DWY(TODAY, 1) = 4) OR (DATE2DWY(TODAY, 1) = 6) THEN BEGIN
                    Body += '****  Automatic Mail Generated From ERP  ****';
                    REPORT.RUN(5935, FALSE, FALSE);
                    REPORT.SAVEASPDF(5935, FORMAT('\\eff-cpu-222\ErpAttachments\Pending Site' + '.PDF'), FALSE);
                    Mail_From := 'anilkumar@efftronics.com';
                    Mail_To := 'sambireddy@efftronics.com,prasanthi@efftronics.com,shilpa@efftronics.com,padmasri@efftronics.com,';
                    Mail_To += 'sivakumari@efftronics.com,pmurali@efftronics.com,vasavi@efftronics.com,madhavip@efftronics.com,';
                    Mail_To += 'praveena@efftronics.com,bjaya@efftronics.com,ramadevi@efftronics.com,nayomi@efftronics.com';
                    Mail_To += ',anilkumar@efftronics.com';
                    // Mail_To:='anilkumar@efftronics.com';
                    Subject := ' Pending Site Material ';
                    Attachment := '\\eff-cpu-222\ErpAttachments\' + 'Pending Site.PDF';
                    Mail.NewCDOMessage(Mail_From, Mail_To, Subject, Body, Attachment);
                END; */


                /* //BG Alert

                             Sh.SETFILTER(Sh."Customer Posting Group",'RAILWAYS');
                             Sh.SETRANGE(Sh."CA Date",TODAY+5);
                             //MESSAGE(FORMAT(TODAY-5));
                             New_Line:=10;
                             IF Sh.FINDSET THEN
                             REPEAT
                             Subject:='ERP- BG Alert for '+Sh."No.";
                             Body:='Customer Name      : '+Sh."Sell-to Customer Name";
                             Body+=FORMAT(New_Line);
                             Body+='Customer Order No. : '+Sh."Customer OrderNo.";
                             Body+=FORMAT(New_Line);
                             Body+='BG Value           : '+FORMAT(Sh."Exp.Payment");
                             Body+=FORMAT(New_Line);
                             Body+='BG Required Date   : '+FORMAT((Sh."CA Date"),0,4);
                             Body+=FORMAT(New_Line);
                             Body+=FORMAT(New_Line);
                             Body+='***** Auto Mail Generated From ERP *****';
                             Mail_From:='anilkumar@efftronics.com';
                             //Mail_To:='swarupa@efftronics.com';
                             Mail_To:={'dir@efftronics.com,}'cvmohan@efftronics.com,anilkumar@efftronics.com,';
                             Mail_To+='sganesh@efftronics.com,rajani@efftronics.com,dsr@efftronics.com,';
                             Mail_To+='sunil@efftronics.com,ravi@efftronics.com,samba@efftronics.com,baji@efftronics.com,prasannat@efftronics.com,';
                             Mail_To+='anuradhag@efftronics.com,chandi@efftronics.com,anulatha@efftronics.com,srasc@efftronics.com';//,milind@efftronics.com

                              IF (Mail_From<>'')AND(Mail_To<>'') THEN
                              Mail.NewCDOMessage(Mail_From,Mail_To,Subject,Body,'');
                             UNTIL Sh.NEXT=0; */


                /* //Mail for Security Deposit Alert

                  New_Line:=10;
                SIH.SETRANGE(SIH."Date Sent",TODAY-334);
                IF SIH.FINDSET THEN
                REPEAT
                Subject:='ERP- Alert for Security Deposit';
                Body:='Sale Order No.         : '+SIH."Order No.";
                Body+=FORMAT(New_Line);
                Body+='Customer Name          : '+FORMAT(SIH."Sell-to Customer Name");
                Body+=FORMAT(New_Line);
                Body+='Customer City          : '+FORMAT(SIH."Sell-to City");
                Body+=FORMAT(New_Line);
                Body+='Customer Order No.     : '+FORMAT(SIH."Customer OrderNo.");
                Body+=FORMAT(New_Line);
                Body+='Sale Order value       : '+FORMAT(SIH."Sale Order Total Amount");
                Body+=FORMAT(New_Line);
                Body+='SD Amount              : '+FORMAT(SIH."Security Deposit Amount");
                Body+=FORMAT(New_Line);
                Body+='SD Due Date            : '+FORMAT((TODAY+31),0,4);
                Body+=FORMAT(New_Line);
                Body+='Final Completion Date  : '+FORMAT((SIH."Date Sent"),0,4);
                Body+=FORMAT(New_Line);
                    "Mail-Id".SETRANGE("Mail-Id"."User ID",SIH."Salesperson Code");
                    IF "Mail-Id".FINDFIRST THEN
                Body+='Sales Executive   :'+"Mail-Id".Name;
                Body+=FORMAT(New_Line);
                Body+=FORMAT(New_Line);
                Mail_From:='anilkumar@efftronics.com';
                //Mail_To:='swarupa@efftronics.com';
                Mail_To:={'dir@efftronics.com,}'cvmohan@efftronics.com,anilkumar@efftronics.com,';
                Mail_To+='ravi@efftronics.com,samba@efftronics.com,baji@efftronics.com,prasannat@efftronics.com,';
                Mail_To+='anuradhag@efftronics.com,chandi@efftronics.com,anulatha@efftronics.com,srasc@efftronics.com'; //,milind@efftronics.com


                 IF (Mail_From<>'')AND(Mail_To<>'') THEN
                 Mail.NewCDOMessage(Mail_From,Mail_To,Subject,Body,'');
                UNTIL SIH.NEXT=0;


                //Alert for Project Completion

                Sh.RESET;
                Sh.SETFILTER(Sh."Customer Posting Group",'RAILWAYS');
                Sh.SETFILTER(Sh."Document Type",'Order');
                Sh.SETRANGE(Sh."Project Completion Date",TODAY+30);
                //MESSAGE(FORMAT(TODAY-5));
                New_Line:=10;
                IF Sh.FINDSET THEN
                REPEAT
                Subject:='ERP- Alert of Project Completion for '+Sh."No.";
                Body:='Customer Name      : '+Sh."Sell-to Customer Name";
                Body+=FORMAT(New_Line);
                Body+='Customer Order No. : '+Sh."Customer OrderNo.";
                Body+=FORMAT(New_Line);
                Body+='Sale Order Value   : '+FORMAT(Sh."Sale Order Total Amount");
                Body+=FORMAT(New_Line);
                Body+='Order Date         : '+FORMAT((Sh."Order Date"),0,4);
                Body+=FORMAT(New_Line);
                Body+=FORMAT(New_Line);
                Body+='***** Auto Mail Generated From ERP *****';
                Mail_From:='anilkumar@efftronics.com';
                //Mail_To:='swarupa@efftronics.com';
                Mail_To:={'dir@efftronics.com,}'cvmohan@efftronics.com,anilkumar@efftronics.com,';
                Mail_To+='sganesh@efftronics.com,rajani@efftronics.com,dsr@efftronics.com,';
                Mail_To+='sunil@efftronics.com,ravi@efftronics.com,samba@efftronics.com,baji@efftronics.com,prasannat@efftronics.com,';
                Mail_To+='anuradhag@efftronics.com,chandi@efftronics.com,anulatha@efftronics.com,srasc@efftronics.com'; //,milind@efftronics.com

                 IF (Mail_From<>'')AND(Mail_To<>'') THEN
                 Mail.NewCDOMessage(Mail_From,Mail_To,Subject,Body,'');
                UNTIL Sh.NEXT=0; */

                /* //AMC Mail Alerts for Quarterly Bills

                Sh.RESET;
                Sh.SETFILTER(Sh."Document Type",'Amc');
                Sh.SETRANGE(Sh."Payment Terms Code",'QUARTER');
                IF Sh.FINDSET THEN
                REPEAT
                noofperiod:=(Sh."Promised Delivery Date"-Sh."Requested Delivery Date")DIV 90;
                billedamt:=Sh."Sale Order Total Amount"/noofperiod;
                New_Line:=10;
                temp:=10000;
                temp1:=90;
                present:=TODAY-Sh."Requested Delivery Date";
                SL.SETRANGE(SL."Document No.",Sh."No.");
                IF SL.FINDSET THEN  REPEAT
                IF (present>=temp1) AND (SL."Line No."=temp) THEN
                IF SL."Qty. to Ship">0 THEN
                BEGIN
                Billenddate:=Sh."Requested Delivery Date"+temp1+1;
                presentqua:=(Billenddate-Sh."Requested Delivery Date")DIV 90;
                MG;
                END;
                temp+=10000;
                temp1+=90;
                UNTIL SL.NEXT=0;
                UNTIL Sh.NEXT=0;


                //AMC Mail Alerts for Halfyearly Bills
                Sh.RESET;
                Sh.SETFILTER(Sh."Document Type",'Amc');
                Sh.SETRANGE(Sh."Payment Terms Code",'HALFYEARLY');
                IF Sh.FINDSET THEN
                REPEAT
                noofperiod:=(Sh."Promised Delivery Date"-Sh."Requested Delivery Date")DIV 180;
                billedamt:=Sh."Sale Order Total Amount"/noofperiod;
                New_Line:=10;
                present:=TODAY-Sh."Requested Delivery Date";
                temp:=10000;
                temp1:=180;
                SL.SETRANGE(SL."Document No.",Sh."No.");
                IF SL.FINDSET THEN  REPEAT
                IF (present>=temp1) AND (SL."Line No."=temp) THEN
                IF SL."Qty. to Ship">0 THEN
                MG;
                temp+=10000;
                temp1+=180;
                UNTIL SL.NEXT=0;
                UNTIL Sh.NEXT=0;

                //AMC Mail Alerts for early Bills
                Sh.RESET;
                Sh.SETFILTER(Sh."Document Type",'Amc');
                Sh.SETRANGE(Sh."Payment Terms Code",'YEAR');
                IF Sh.FINDSET THEN
                REPEAT
                noofperiod:=(Sh."Promised Delivery Date"-Sh."Requested Delivery Date")DIV 365;
                billedamt:=(Sh."Sale Order Total Amount"/noofperiod);
                New_Line:=10;
                present:=TODAY-Sh."Requested Delivery Date";
                temp:=10000;
                temp1:=365;
                SL.SETRANGE(SL."Document No.",Sh."No.");
                IF SL.FINDSET THEN  REPEAT
                IF (present>=temp1) AND (SL."Line No."=temp) THEN
                IF SL."Qty. to Ship">0 THEN
                MG;
                temp+=10000;
                temp1+=365;
                UNTIL SL.NEXT=0;
                UNTIL Sh.NEXT=0; */

                /* //Travelling Advance Mail.
                //COPYSTR(user.Dept,1,2)='RD'
                //user.SETFILTER(user.Dimension,'ADMIN-0002|CUS-005|PRD-0010|RD-000');
                //user.SETFILTER(user.Dimension,'RD-000');
                //user.SETFILTER(user.Dept,'MNG');
                //user.SETFILTER(user.Dept,'SAL');
                user.SETFILTER(user.Dimension,'ADMIN-0002');

                //user.SETRANGE(user."User ID",'EFFTRONICS\CEO@EFFTRONICS.COM#MD');
                user.SETFILTER(user.Blocked,'NO');
                user.SETFILTER(user.MailID,'<>%1','');
                New_Line:=10;
                Mail_To:='';
                IF user.FINDSET THEN
                REPEAT
                maxdate:=TODAY;
                mindate:=040108D;
                AVE.SETRANGE(AVE."Analysis View Code",'ADVANCES');
                AVE.SETRANGE(AVE."G/L Account No.",'24000');
                AVE.SETRANGE(AVE."Dimension 2 Value Code",user."User ID");
                //AVE.SETFILTER(AVE."Dimension 1 Value Code",'RD*');
                AVE.SETRANGE(AVE."Posting Date",mindate,maxdate);

                IF AVE.FINDSET THEN
                BEGIN
                "Bal amt":=0;
                Body:='';
                Mail_To:='';
                REPEAT
                "Bal amt"+=AVE.Amount;
                UNTIL AVE.NEXT=0;

                IF "Bal amt"<>0 THEN
                BEGIN
                 REPORT.RUN(50173,FALSE,FALSE,AVE);
                 REPORT.SAVEASPDF(50173,'\\erpserver\ErpAttachments\TA Detail.PDF',FALSE,AVE);
                 Attachment1:='\\erpserver\ErpAttachments\TA Detail.PDF';
                Mail_To:=user.MailID+',';
                Mail_To+='anilkumar@efftronics.com,';
                Mail_To+='rajani@efftronics.com';

                Subject:='Travelling Advance Balance';
                Body+=FORMAT(New_Line);
                Body+=FORMAT(New_Line);
                Body+='CREDIT AMOUNT(-) NEED TO PAY BY ADMINISTRATION';
                Body+=FORMAT(New_Line);
                Body+='DEBIT AMOUNT(+) BILLS NEED TO SUBMIT BY EMPLOYEE';

                Body+=FORMAT(New_Line);
                Body+=FORMAT(New_Line);
                Body+='Employee ID         : '+ user."User ID";
                Body+=FORMAT(New_Line);
                Body+='Employee Name       : '+ user.Name;
                Body+=FORMAT(New_Line);
                Body+='Department          : '+ user.Dept;
                Body+=FORMAT(New_Line);

                Body+='Travelling Balance  : '+FORMAT(ROUND("Bal amt",1));
                Body+=FORMAT(New_Line);
                Body+=FORMAT(New_Line);
                Body+=FORMAT(New_Line);
                Body+='*** Auto Mail Generated from ERP ***';
                Mail_From:='anilkumar@efftronics.com';

                 IF ( Mail_From<>'') AND (Mail_To<>'') THEN
                  Mail.NewCDOMessage(Mail_From,Mail_To,Subject,Body,Attachment1);
                END;
                END;
                UNTIL user.NEXT=0; */

                /* //Indents Mail

                user.SETFILTER(user.Dimension,'RD-000');
                user.SETFILTER(user.MailID,'<>%1','');
                //user.SETFILTER(user.Dept,'RD5');
                //user.SETRANGE(user."User ID",'07TE041');
                IF user.FINDSET THEN
                //MESSAGE(FORMAT(user.Name));
                REPEAT
                IH.SETFILTER(IH."Released Status",'Released');
                IH.SETFILTER(IH."Person Code",user."User ID");
                IH.SETRANGE(IH."Delivery Location",'R&D STR');
                IF IH.FINDSET THEN
                REPEAT
                IL.SETRANGE(IL."Document No.",IH."No.");
                IL.SETFILTER(IL."Indent Status",'INDENT');
                IL.SETFILTER(IL.Quantity,'<>%1',0);
                IF IL.FINDFIRST THEN
                BEGIN
                IF (TODAY-IL."Due Date")>2 THEN
                BEGIN
                 REPORT.RUN(50179,FALSE,FALSE,IH);
                 REPORT.SAVEASPDF(50179,'\\erpserver\ErpAttachments\Indent Details.PDF',FALSE,IH);
                 Attachment1:='\\erpserver\ErpAttachments\Indent Details.PDF';
                 Mail_To:=user.MailID+',';
                Mail_To+='anilkumar@efftronics.com,suri@efftronics.com';
                //Mail_To:='swarupa@efftronics.com';
                 END;
                 END;
                UNTIL IH.NEXT=0
                 ELSE
                 Mail_To:='';
                 Subject:='Indent Details';
                 Mail_From:='anilkumar@efftronics.com';
                  IF ( Mail_From<>'') AND (Mail_To<>'') THEN
                 Mail.NewCDOMessage(Mail_From,Mail_To,Subject,Body,Attachment1);
                 UNTIL user.NEXT=0; */


                /* //QC pending mails
                New_Line:=10;
                //PRL.RESET;
                max:=TODAY;
                min:=040109D;
                PRL.SETRANGE(PRL."Document date",min,max);
                PRL.SETFILTER(PRL.Quantity,'<>%1',0);
                PRL.SETRANGE(PRL."Location Code",'R&D STR');
                //PRL.SETRANGE(PRL."Location Code",'CS STR');
                IF PRL.FINDSET THEN
                REPEAT
                IF (PRL.Quantity>(PRL."Quantity Accepted"+PRL."Quantity Rejected"+PRL."Quantity Rework")) THEN
                BEGIN
                IH.SETRANGE(IH."No.",PRL."Indent No.");
                IF IH.FINDFIRST THEN
                BEGIN
                 Body:='';
                  user.SETRANGE(user."User ID",IH."Person Code");
                  IF user.FINDFIRST THEN
                  Mail_To:=user.MailID+',';
                //  Mail_To:='sreenu@efftronics.com';
                // Mail_To:='prasanthi@efftronics.com,shilpa@efftronics.com,nayomi@efftronics.com,';
                  Subject:='ERP- ITEM '+PRL.Description+' PENDING AT QA';
                  Body+='YOUR ITEM INWARDED , BUT PENDING AT QAS';
                  Body+=FORMAT(New_Line);
                  Body+=FORMAT(New_Line);
                  Mail_From:='anilkumar@efftronics.com';
                  Body+='Indented Person    : '+user.Name;
                  Body+=FORMAT(New_Line);
                  Body+='Employee ID        : '+user."User ID";
                  Body+=FORMAT(New_Line);
                  Body+='Department         : '+user.Dept;
                  Body+=FORMAT(New_Line);
                  Body+='Item Name          : '+PRL.Description;
                  Body+=FORMAT(New_Line);
                  Body+='Quantity           : '+FORMAT(PRL.Quantity-(PRL."Quantity Accepted"+PRL."Quantity Rejected"+PRL."Quantity Rework"));
                  Body+=FORMAT(New_Line);
                  Body+='Unit of Measure    : '+PRL."Unit of Measure";
                  Body+=FORMAT(New_Line);
                  PRL.CALCFIELDS(PRL."Document date");
                  Body+='Inward Date        : '+FORMAT((PRL."Document date"),0,4);
                  Body+=FORMAT(New_Line);
                   IF (TODAY-PRL."Document date")>1 THEN
                   BEGIN
                  Body+='Pending Days       : '+FORMAT(TODAY-PRL."Document date");
                  Body+=FORMAT(New_Line);
                  Body+=FORMAT(New_Line);
                //  MESSAGE(FORMAT(Mail_To));
                //  MESSAGE(FORMAT(Mail_From));
                  Body+='*** Auto Mail Generated from ERP ***';
                  Mail_To+='anilkumar@efftronics.com';
                 IF ( Mail_From<>'') AND (Mail_To<>'') THEN
                 Mail.NewCDOMessage(Mail_From,Mail_To,Subject,Body,'');
                 END;
                END;
                END;
                UNTIL PRL.NEXT=0; */


                /* //Pending Orders Items

                 New_Line:=10;
                 max:=TODAY-1;
                 min:=040108D;
                Pl.SETFILTER(Pl."Document Type",'ORDER');
                Pl.SETFILTER(Pl.Quantity,'<>%1',0);
                Pl.SETFILTER(Pl."Qty. to Receive",'<>%1',0);
                Pl.SETRANGE(Pl."Location Code",'R&D STR');
                Pl.SETRANGE(Pl."Deviated Receipt Date",min,max);
                IF Pl.FINDSET THEN
                REPEAT
                IH.SETRANGE(IH."No.",Pl."Indent No.");
                IF IH.FINDFIRST THEN
                BEGIN
                 user.SETRANGE(user."User ID",IH."Person Code");
                 IF user.FINDFIRST THEN
                 BEGIN
                 Body:='';
                 Mail_To:='swarupa@efftronics.com';
                  Mail_From:='anilkumar@efftronics.com';
                  Subject:=' Purchase Ordered but deviated Items';
                  Body+='Item Details are as Follows :';
                  Body+=FORMAT(New_Line);
                  Body+=FORMAT(New_Line);
                  Body+='Indented Person       : '+user.Name;
                  Body+=FORMAT(New_Line);
                  Body+='Employee ID           : '+user."User ID";
                  Body+=FORMAT(New_Line);
                  Body+='Department            : '+user.Dept;
                  Body+=FORMAT(New_Line);
                  Body+='Item Name             : '+Pl.Description;
                  Body+=FORMAT(New_Line);
                  Body+='Quantity              : '+FORMAT(Pl."Qty. to Receive");
                  Body+=FORMAT(New_Line);
                  Body+='Unit of Measure       : '+Pl."Unit of Measure";
                  Body+=FORMAT(New_Line);
                  Body+='Expected Receipt Date : '+FORMAT((Pl."Deviated Receipt Date"),0,4);
                  Body+=FORMAT(New_Line);
                  Body+='Pending Days          : '+FORMAT(TODAY-Pl."Deviated Receipt Date");
                  Body+=FORMAT(New_Line);
                  IF ( Mail_From<>'') AND (Mail_To<>'') THEN
                 Mail.NewCDOMessage(Mail_From,Mail_To,Subject,Body,'');
                  END;
                  END;
                UNTIL Pl.NEXT=0; */

                /* //Newmail

                Sh.SETRANGE(Sh."Expiration Date",TODAY);

                New_Line:=10;
                body1:='';
                 bodies:=1;
                Mail_Body[bodies]:='';
                Subject:='ERP- Today  Released Sale Orders ';
                body1+='RELEASED ORDER DETAILS';
                body1+=FORMAT(New_Line);
                body1+=FORMAT(New_Line);
                IF Sh.FINDSET THEN
                REPEAT
                      IF (STRLEN(body1)>800) THEN
                      BEGIN
                        Mail_Body[bodies]:=body1;
                        bodies+=1;
                        body1:='';
                      END;
                body1+='Customer Name      : '+Sh."Sell-to Customer Name";
                body1+=FORMAT(New_Line);
                body1+='Customer Order No. : '+Sh."Customer OrderNo.";
                body1+=FORMAT(New_Line);
                body1+='Order Value        : '+FORMAT(Sh."Sale Order Total Amount");
                body1+=FORMAT(New_Line);
                    "Mail-Id".SETRANGE("Mail-Id"."User ID",Sh."Salesperson Code");
                    IF "Mail-Id".FINDFIRST THEN
                body1+='Sales Executive    : '+"Mail-Id".Name;
                body1+=FORMAT(New_Line);
                body1+='Sale order No.     : '+Sh."No.";
                body1+=FORMAT(New_Line);
                body1+=FORMAT(New_Line);
                      IF (STRLEN(body1)>800) THEN
                      BEGIN
                        Mail_Body[bodies]:=body1;
                        bodies+=1;
                        body1:='';
                      END;
                UNTIL Sh.NEXT=0;
                body1+='***** Auto Mail Generated From ERP *****';
                Mail_From:='anilkumar@efftronics.com';
                //Mail_To:='swarupa@efftronics.com';

                Mail_To:='ceo@efftronics.com,anilkumar@efftronics.com';
                 IF (Mail_From<>'')AND(Mail_To<>'') THEN
                NewCDOMessage(Mail_From,Mail_To,Subject,body1,''); */


                /* //QC Rejection List
                Body:='';
                New_Line:=10;
                IR.RESET;
                IR.SETFILTER(IR."Source Type",'In Bound');
                IR.SETFILTER(IR.Status,'YES');
                IR.SETRANGE(IR."Posted Date",TODAY);
                IR.SETFILTER(IR."Qty. Rejected",'>0');
                IF IR.FINDSET THEN
                  Body+='Item Details  :';
                REPEAT
                  Body+=FORMAT(New_Line);
                  Body+=FORMAT(New_Line);
                  Body+='Item Name            : '+IR."Item Description";
                  Body+=FORMAT(New_Line);
                  Body+='Rejected Quantity    : '+FORMAT(IR."Qty. Rejected");
                  Body+=FORMAT(New_Line);
                  Body+='Total Quantity       : '+FORMAT(IR.Quantity);
                  Body+=FORMAT(New_Line);
                  PIDS.SETRANGE(PIDS."No.",IR."Parent IDS");
                  IF PIDS.FINDFIRST THEN
                  Body+='Inward Quantity      : '+FORMAT(PIDS.Quantity)
                  ELSE
                  Body+='Inward Quantity      : '+FORMAT(IR.Quantity);
                  Body+=FORMAT(New_Line);
                  Body+='Vendor Name          : '+IR."Vendor Name";
                  Body+=FORMAT(New_Line);
                  Body+='Rejected Reason      : '+IR."Nature Of Rejection";
                  Body+=FORMAT(New_Line);
                  Body+='Inward Date          : '+FORMAT((IR."IDS creation Date"),0,4);
                  Body+=FORMAT(New_Line);
                 UNTIL IR.NEXT=0;
                Body+=FORMAT(New_Line);
                Body+='*** Auto Mail Generated From ERP ***';
                Subject:='ERP- Today  Rejected Items ';
                Mail_From:='anilkumar@efftronics.com';
                //Mail_To:='mohang@efftronics.com';
                //Mail_To:='ceo@efftronics.com,anilkumar@efftronics.com';
                 IF (Mail_From<>'')AND(Mail_To<>'') THEN
                Mail.NewCDOMessage(Mail_From,Mail_To,Subject,Body,''); */


                /* IF (TODAY-"Shortage. Calc. Date")>2 THEN
                BEGIN
                  Mail_From:='anilkumar@efftronics.com';
                  Mail_To:='anilkumar@efftronics.com,';
                 //  Mail_To:='ceo@efftronics.com,padmaja@efftronics.com,purchase@efftronics.com,himabindu@efftronics.com,cvmohan@efftronics.com,';
                 // Mail_To+='anilkumar@efftronics.com,anilkumar@efftronics.com';
                  Subject:='ERP- Alert **  PRODUCTION GETTING DEVIATED ** ';
                  Body:='****  Automatic Mail Generated From ERP  ****';
                  IF  Shortage_Status('OPEN') THEN
                  BEGIN
                    Subject+='Shortage data not Forwarded to Purchase ('
                             +INDIAN_FORMAT("Shortage. Calc. Date")+' TO '+INDIAN_FORMAT("Shortage. Calc. Date"+2)+')';
                  END ELSE IF Shortage_Status('WAP') THEN
                  BEGIN
                    Subject+=' Vendor & Cost data preparation pending at Purchase ('
                              +INDIAN_FORMAT("Shortage. Calc. Date")+' TO '+INDIAN_FORMAT("Shortage. Calc. Date"+2)+')';
                  END ELSE
                  IF Shortage_Status('WFA') THEN
                  BEGIN
                          Subject+='AUTHORISATION WAS PENDING ('+INDIAN_FORMAT("Shortage. Calc. Date")+' TO '+INDIAN_FORMAT("Shortage. Calc. Date"+2)+')';

                  END ELSE
                  IF Shortage_Status('AUTHORISED') THEN
                  BEGIN
                     Subject+=' INDENTS ARE NOT CREATED ('+INDIAN_FORMAT("Shortage. Calc. Date")+' TO '+
                                                                                    INDIAN_FORMAT("Shortage. Calc. Date"+2)+')';
                  END ELSE
                  IF Shortage_Status('INDENT') THEN
                  BEGIN
                     Subject+='Indents are not Released ('+INDIAN_FORMAT("Shortage. Calc. Date")+' TO '+
                                                                                    INDIAN_FORMAT("Shortage. Calc. Date"+2)+')';
                  END ELSE  IF Shortage_Status('Pur') THEN
                  BEGIN
                    MESSAGE('hi');
                    Subject+='Purchase Orders are not raised ('+INDIAN_FORMAT("Shortage. Calc. Date")+' TO '+
                                                                                  INDIAN_FORMAT("Shortage. Calc. Date"+2)+')';
                  END ELSE
                  BEGIN
                     Subject+='Shortage Report was not run ('+INDIAN_FORMAT("Shortage. Calc. Date")+' TO '+
                                                                                    INDIAN_FORMAT("Shortage. Calc. Date"+2)+')';
                   END;
                  Mail.NewCDOMessage(Mail_From,Mail_To,Subject,Body,'');
                END ELSE
                BEGIN
                  Send_Mail:=FALSE;
                  Mail_From:='anilkumar@efftronics.com';
                  Mail_To:='anilkumar@efftronics.com,';
                  Subject:='ERP- Alert  ';
                  Body:='****  Automatic Mail Generated From ERP  ****';

                  IF  ((DATE2DWY(TODAY,1)=1) OR (DATE2DWY(TODAY,1)=4))THEN
                  BEGIN
                    IF Shortage_Status_Present('OPEN',TODAY,TODAY+2) THEN
                    BEGIN
                      Subject+='Shortage data not Forwarded to Purchase';
                       Send_Mail:=TRUE;
                      //Mail_To:='padmaja@efftronics.com,purchase@efftronics.com,himabindu@efftronics.com,cvmohan@efftronics.com,';
                      //Mail_To+='anilkumar@efftronics.com';
                    END ELSE IF Shortage_Status_Present('WAP',TODAY,TODAY+2) THEN
                    BEGIN
                      Subject+=' Vendor & Cost data preparation pending at Purchase ';
                       Send_Mail:=TRUE;
                      //Mail_To:='padmaja@efftronics.com,purchase@efftronics.com,himabindu@efftronics.com,cvmohan@efftronics.com,';
                      //Mail_To+='anilkumar@efftronics.com';
                    END;

                  END ELSE IF ((DATE2DWY(TODAY,1)=2) OR (DATE2DWY(TODAY,1)=5)) THEN
                  BEGIN
                    IF  Shortage_Status_Present('OPEN',TODAY-1,TODAY+1) THEN
                    BEGIN
                      Subject+='Shortage data not Forwarded to Purchase ';
                      Send_Mail:=TRUE;
                      //Mail_To:='ceo@efftronics.com,padmaja@efftronics.com,purchase@efftronics.com,himabindu@efftronics.com';
                      //Mail_To+=',cvmohan@efftronics.com,anilkumar@efftronics.com';

                    END ELSE IF Shortage_Status_Present('WAP',TODAY-1,TODAY+1) THEN
                    BEGIN
                      Subject+=' Vendor & Cost data preparation pending at Purchase ';
                       Send_Mail:=TRUE;
                      //Mail_To:='purchase@efftronics.com,padmaja@efftronics.com,himabindu@efftronics.com';
                      //Mail_To+=',cvmohan@efftronics.com,anilkumar@efftronics.com';

                    END ELSE IF Shortage_Status_Present('WFA',TODAY-1,TODAY+1) THEN
                    BEGIN
                      Subject+='Authorisation Process Was Pending ';
                      Send_Mail:=TRUE;
                      //Mail_To:='purchase@efftronics.com,padmaja@efftronics.com,himabindu@efftronics.com';
                      //Mail_To+=',cvmohan@efftronics.com,anilkumar@efftronics.com';

                    END ELSE
                    IF  Shortage_Status_Present('AUTHORISED',TODAY-1,TODAY+1) THEN
                    BEGIN
                      Subject+=' Indents are not created ';
                      Send_Mail:=TRUE;
                      //Mail_To:='padmaja@efftronics.com,chowdary@efftronics.com,himabindu@efftronics.com';
                      //Mail_To+=',cvmohan@efftronics.com,anilkumar@efftronics.com';

                    END ELSE
                    IF Shortage_Status_Present('INDENT',TODAY-1,TODAY+1) THEN
                    BEGIN
                       Subject+='Indents are not Released  ';
                       Send_Mail:=TRUE;
                      //Mail_To:='chowdary@efftronics.com,padmaja@efftronics.com,himabindu@efftronics.com';
                      //Mail_To+=',cvmohan@efftronics.com,anilkumar@efftronics.com';

                    END ELSE  IF Shortage_Status_Present('Pur',TODAY-1,TODAY+1) THEN
                    BEGIN
                      Send_Mail:=TRUE;
                      Subject+='Purchase Orders are not raised ('+INDIAN_FORMAT("Shortage. Calc. Date")+' TO '+
                                                                                  INDIAN_FORMAT("Shortage. Calc. Date"+2)+')';
                    END;


                  END ELSE
                  BEGIN
                    IF  Shortage_Status_Present('OPEN',"Shortage. Calc. Date"-2,"Shortage. Calc. Date") THEN
                    BEGIN
                      Subject+='Shortage data not Forwarded to Purchase ';
                       Send_Mail:=TRUE;
                      //Mail_To:='ceo@efftronics.com,padmaja@efftronics.com,chowdary@efftronics.com,himabindu@efftronics.com';
                      //Mail_To+=',cvmohan@efftronics.com,anilkumar@efftronics.com';

                    END ELSE IF Shortage_Status_Present('WAP',"Shortage. Calc. Date"-2,"Shortage. Calc. Date") THEN
                    BEGIN
                      Subject+=' Vendor & Cost data preparation pending at Purchase ';
                       Send_Mail:=TRUE;
                      //Mail_To:='ceo@efftronics.com,chowdary@efftronics.com,padmaja@efftronics.com,himabindu@efftronics.com';
                      //Mail_To+=',cvmohan@efftronics.com,anilkumar@efftronics.com';

                    END ELSE IF Shortage_Status_Present('WFA',"Shortage. Calc. Date"-2,"Shortage. Calc. Date") THEN
                    BEGIN
                      Subject+='Authorisation Process Was Pending ';
                      Send_Mail:=TRUE;
                      //Mail_To:='ceo@efftronics.com,chowdary@efftronics.com,padmaja@efftronics.com,himabindu@efftronics.com';
                      //Mail_To+=',cvmohan@efftronics.com,anilkumar@efftronics.com';

                    END ELSE
                    IF Shortage_Status_Present('AUTHORISED',"Shortage. Calc. Date"-2,"Shortage. Calc. Date") THEN
                    BEGIN
                      Subject+=' Indents are not created ';
                      Send_Mail:=TRUE;
                      //Mail_To:='ceo@efftronics.com,chowdary@efftronics.com,padmaja@efftronics.com,himabindu@efftronics.com';
                      //Mail_To+=',cvmohan@efftronics.com,anilkumar@efftronics.com';

                    END ELSE
                    IF Shortage_Status_Present('INDENT',"Shortage. Calc. Date"-2,"Shortage. Calc. Date") THEN
                    BEGIN
                       Subject+='Indents are not released  ';
                       Send_Mail:=TRUE;
                      //Mail_To:='ceo@efftronics.com,chowdary@efftronics.com,padmaja@efftronics.com,himabindu@efftronics.com';
                      //Mail_To+=',cvmohan@efftronics.com,anilkumar@efftronics.com';

                    END ELSE  IF Shortage_Status_Present('Pur',"Shortage. Calc. Date"-2,"Shortage. Calc. Date") THEN
                    BEGIN
                      Send_Mail:=TRUE;
                      Subject+='Purchase Orders are not raised ('+INDIAN_FORMAT("Shortage. Calc. Date")+' TO '+
                                                                                  INDIAN_FORMAT("Shortage. Calc. Date"+2)+')';
                    END;


                  END;
                  IF Send_Mail THEN
                  Mail.NewCDOMessage(Mail_From,Mail_To,Subject,Body,'')
                END; */

                //code to send mails for C-forms
                /*  IF DATE2DWY(TODAY,1)=6 THEN
                 BEGIN
                   CUSTOMER.RESET;
                   CUSTOMER.SETFILTER(CUSTOMER."E-Mail",'<>%1','');
                   IF CUSTOMER.FIND('-') THEN
                   REPEAT
                     SalInvHeader.RESET;
                     SalInvHeader.SETCURRENTKEY(SalInvHeader."Posting Date");
                     SalInvHeader.SETFILTER(SalInvHeader."Sell-to Customer No.",CUSTOMER."No.");
                     SalInvHeader.SETFILTER(SalInvHeader."Customer Posting Group",'PRIVATE');
                     SalInvHeader.SETFILTER(SalInvHeader."Form Code",'C');
                     SalInvHeader.SETFILTER(SalInvHeader."C-form Status",'<>%1',2);
                     SalInvHeader.SETFILTER(SalInvHeader."Posting Date",'>%1&<%2',DMY2DATE(31,3,2009),(TODAY-90));
                     IF SalInvHeader.FINDFIRST THEN
                     BEGIN
                       REPORT.SAVEASPDF(50215,'\\erpserver\ErpAttachments\ErpAttachments1\'+CUSTOMER.Name+'.PDF',SalInvHeader);
                       Mail_To:='anuradhag@efftronics.com,prasannat@efftronics.com';
                       Subject:= 'REG:C-FORMS';
                   Body:='';
                   Body+= '<body>Dear Sir ,<br/> <br/>';
                   Body+='Please Verify the Attachment and send the C-Forms for the below mentioned Invoices<br/><br/>';
                   Body+='*****  Generated Auto Mail   *****';
                   Mail_From:='erp@efftronics.com';

                   Body+='</body>';
                   Attachment:='\\erpserver\ErpAttachments\ErpAttachments1\'+CUSTOMER.Name+'.PDF';
                   SMTP_MAIL.CreateMessage('EFFTRONICS',Mail_From,Mail_To,Subject,Body,TRUE);
                   SMTP_MAIL.AddAttachment(Attachment);
                   SMTP_MAIL.Send;
                 END;
                 UNTIL CUSTOMER.NEXT = 0;
                 END; */


                //code to Send mails for AMC orders that are going to expire in four months.

                /* // coment for amc next expire details
                IF (DATE2DWY(TODAY,1)=1) OR (DATE2DWY(TODAY,1)=4) THEN
                 BEGIN
                   REPORT.SAVEASPDF(33000900,'\\erpserver\ErpAttachments\ErpAttachments1\AMC_Details.PDF');
                   Subject:='AMCs that are going to expire in 4 Months ';
                   Body:='****  Automatic Mail Generated From ERP  ****';
                   Attachment:='\\erpserver\ErpAttachments\ErpAttachments1\AMC_Details.PDF';
                   Mail_From:='noreply@efftronics.com';
                   Mail_To:='sambireddy@efftronics.com,prasanthi@efftronics.com,cuspm@efftronics.com,erp@efftronics.com,yesu@efftronics.com';
                   SMTP_MAIL.CreateMessage('EFFTRONICS',Mail_From,Mail_To,Subject,Body,TRUE);
                   //EFFUPG Start
                   {
                   SMTP_MAIL.AddAttachment(Attachment);
                   }
                   SMTP_MAIL.AddAttachment(Attachment,'');
                   //EFFUPG End
                   SMTP_MAIL.Send;

                 END; */

                //Mail to vendors to remined them the items to be sent to Efftronics
                /* Vendor.RESET;
                Vendor.SETRANGE(Vendor."Need to send Mail",TRUE);
                IF Vendor.FIND('-') THEN
                REPEAT
                PurchaseLine.RESET;
                PurchaseLine.SETFILTER(PurchaseLine."Buy-from Vendor No.",Vendor."No.");
                PurchaseLine.SETFILTER(PurchaseLine."Qty. to Receive",'>%1',0);
                PurchaseLine.SETFILTER(PurchaseLine."Deviated Receipt Date",'>%1',TODAY);
                IF PurchaseLine.FIND('-') THEN
                REPEAT
                  PurchaseHeader.RESET;
                  PurchaseHeader.SETFILTER(PurchaseHeader."No.",PurchaseLine."Document No.");
                  PurchaseHeader.SETFILTER(PurchaseHeader."Order Date",'<%1',TODAY);
                  IF PurchaseHeader.FINDFIRST THEN
                  BEGIN
                    Item.RESET;
                    Item.SETFILTER(Item."No.",PurchaseLine."No.");
                    IF Item.FINDFIRST THEN
                    BEGIN
                        IF  ((TODAY-PurchaseHeader."Order Date")=ROUND((PurchaseLine."Expected Receipt Date"-PurchaseHeader."Order Date"-4)/2-0.5,1))
                      OR
                            ((TODAY-PurchaseHeader."Order Date")=ROUND((PurchaseLine."Expected Receipt Date"-PurchaseHeader."Order Date"-4)/4-0.5,1))
                      THEN
                      BEGIN
                        PurchaseLine.MARK(TRUE);
                        k:=10;
                      END;
                    END;
                  END;
                UNTIL PurchaseLine.NEXT=0;
                IF k=10 THEN
                BEGIN
                  REPORT.SAVEASPDF(50217,'\\erpserver\ErpAttachments\ErpAttachments1\'+Vendor.Name+'.PDF',FALSE,PurchaseLine);
                  Subject:='Reminder to Vendor'+Vendor.Name;
                  Body:='<PDF><BODY>Dear Sir,<BR>';
                  Body+='<BR><PRE>       This is to Remind you the details of items you need to send to Efftronics in Next 5 Days</PRE><BR><BR>';
                  Body+='<PRE>             ****  Automatic Mail Generated From ERP  ****</PRE></BODY></PDF>';
                  Attachment:='\\erpserver\ErpAttachments\ErpAttachments1\'+Vendor.Name+'.PDF';
                  Mail_From:='erp@efftronics.com';
                  Mail_To:='Chowdary@Efftronics.com,anilkumar@efftronics.com,Phani@efftronics.com';
                  SMTP_MAIL.CreateMessage('EFFTRONICS',Mail_From,Mail_To,Subject,Body,TRUE);
                  SMTP_MAIL.AddAttachment(Attachment);
                  SMTP_MAIL.Send;
                  k:=0;
                  PurchaseLine.CLEARMARKS;
                END;
                UNTIL Vendor.NEXT=0; */


                // MAIN STORES SHORTAGE MATERIAL AUTOMATIC REPORT
                Item.CALCFIELDS(Item."Stock at PROD Stores");
                Item.SETFILTER(Item."Safety Stock Quantity", '>%1', (Item."Stock at Stores" + Item."Stock at PROD Stores"));
                Cs_Shortage_QTY := Item.COUNT;
                Body += '****  Automatic Mail Generated From ERP  ****';
                REPORT.RUN(33000892, FALSE, FALSE, Item);
                "g/l setup".FINDFIRST;
                REPORT.SAVEASPDF(33000892, FORMAT('\\erpserver\ErpAttachments\' + 'STR Shortage' + '.PDF'));

                /* Mail_From := 'noreply@efftronics.com';
                Mail_To := 'Store@efftronics.com,Padmaja@efftronics.com,';
                Mail_To += 'erp@efftronics.com';
                // Mail_To:='anilkumar@efftronics.com';
                Subject := ' Shortage at Main Stores ';

                Attachment := '\\erpserver\ErpAttachments\' + 'STR Shortage.PDF';
                SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
                // SMTP_MAIL.AddAttachment(Attachment1);
                // SMTP_MAIL.AddAttachment(attachment13); 

                
                IF EXISTS(Attachment) THEN  // Condition added by Pranavi on 13-Jan-2016 for solving error if shortage items doesnot exist
                BEGIN
                    //EFFUPG Start

                    //SMTP_MAIL.AddAttachment(Attachment);

                    SMTP_MAIL.AddAttachment(Attachment, '');
                    //EFFUPG End
                    SMTP_MAIL.Send;
                END;*/   //B2BUPG

                Recipients.Add('Store@efftronics.com');
                Recipients.Add('Padmaja@efftronics.com');
                Recipients.Add('erp@efftronics.com');
                Subject := ' Shortage at Main Stores ';

                Attachment := '\\erpserver\ErpAttachments\' + 'STR Shortage.PDF';
                EmailMessage.CREATE(Recipients, Subject, Body, true);
                IF EXISTS(Attachment) THEN BEGIN
                    EmailMessage.AddAttachment(Attachment, '', '');
                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                End;
                // End of MAIN STORES SHORTAGE MATERIAL AUTOMATIC REPORT

                // temporarily commented by Vishnu Priya on 20-07-2019 as there is an error in the SMS Tables Triggers
                REPORT.RUN(50023, FALSE); // Added by rakesh to run Report 50023 automatically on 27-Dec-14

                //Added by Pranavi on 04-Jan-2016 for Auto OMSDump
                //IF NOT ((DATE2DWY(TODAY,1)=3) OR (DATE2DWY(TODAY,1)=6)) THEN
                //  StockOMSDump.RUN;

                //MSL_Alert;

            end;
        }
        addafter(SEPAExportWoBankAccData)
        {
            field("Daily Entrires Posting Date";
            Rec."Daily Entrires Posting Date")
            {
                ApplicationArea = All;

                trigger OnValidate();
                begin

                    //Daily Transactions report
                    totalsales := 0;
                    totalreceivedamts := 0;
                    totalpayments := 0;

                    IF DATE2DWY(Rec."Daily Entrires Posting Date", 1) <> 1 THEN
                        fromdate := Rec."Daily Entrires Posting Date" - 1
                    ELSE
                        fromdate := Rec."Daily Entrires Posting Date" - 2;

                    //fromdate:="Daily Entrires Posting Date";
                    SIH.RESET;
                    SIH.SETRANGE(SIH."Posting Date", fromdate, fromdate);
                    IF SIH.FINDSET THEN
                        REPEAT
                            SIH.CALCFIELDS(SIH."Total Invoiced Amount");
                            totalsales := totalsales + SIH."Total Invoiced Amount";
                        UNTIL SIH.NEXT = 0;
                    S1 := formataddress.ChangeCurrency(totalsales);
                    CLE.RESET;
                    CLE.SETFILTER(CLE."Amount (LCY)", '<%1', 0);
                    CLE.SETRANGE(CLE."Posting Date", fromdate, fromdate);
                    IF CLE.FINDSET THEN
                        REPEAT
                            CLE.CALCFIELDS(CLE."Amount (LCY)");
                            totalreceivedamts := totalreceivedamts + ABS(CLE."Amount (LCY)");
                        UNTIL CLE.NEXT = 0;
                    S2 := formataddress.ChangeCurrency(totalreceivedamts);
                    VLE.RESET;
                    VLE.SETFILTER(VLE."Amount (LCY)", '>%1', 0);
                    VLE.SETRANGE(VLE."Posting Date", fromdate, fromdate);
                    IF VLE.FINDSET THEN
                        REPEAT
                            VLE.CALCFIELDS(VLE."Amount (LCY)");
                            totalpayments := totalpayments + VLE."Amount (LCY)";
                        UNTIL VLE.NEXT = 0;
                    S3 := formataddress.ChangeCurrency(ROUND(totalpayments, 1));
                    SIH.RESET;
                    SIH.SETRANGE(SIH."Posting Date", fromdate, fromdate);
                    IF SIH.FINDFIRST THEN BEGIN
                        REPORT.RUN(50018, FALSE, FALSE, SIH);
                        REPORT.SAVEASPDF(50018, '\\erpserver\ERPattachments\salestrans.PDF', SIH);

                        Attachment1 := '\\erpserver\erpattachments\salestrans.PDF';
                    END ELSE
                        Attachment1 := '';
                    CLE.RESET;
                    CLE.SETFILTER(CLE."Amount (LCY)", '<%1', 0);
                    CLE.SETRANGE(CLE."Posting Date", fromdate, fromdate);
                    IF CLE.FINDFIRST THEN BEGIN
                        REPORT.RUN(50019, FALSE, FALSE, CLE);
                        REPORT.SAVEASPDF(50019, '\\erpserver\ErpAttachments\custpayments.PDF', CLE);
                        attachment13 := '\\erpserver\ERPattachments\custpayments.PDF';
                    END ELSE
                        attachment13 := '';
                    VLE.RESET;
                    VLE.SETFILTER(VLE."Amount (LCY)", '>%1', 0);
                    VLE.SETRANGE(VLE."Posting Date", fromdate, fromdate);
                    IF VLE.FINDFIRST THEN BEGIN
                        REPORT.RUN(50020, FALSE, FALSE, VLE);
                        REPORT.SAVEASPDF(50020, '\\erpserver\ERPattachments\vendorpayments.PDF', VLE);
                        attachment14 := '\\erpserver\ERPattachments\vendorpayments.PDF';
                    END ELSE
                        attachment14 := '';


                    IF DATE2DWY(Rec."Daily Entrires Posting Date", 1) <> 1 THEN
                        fromdate := Rec."Daily Entrires Posting Date" - 1
                    ELSE
                        fromdate := Rec."Daily Entrires Posting Date" - 2;


                    //fromdate:="Daily Entrires Posting Date";
                    totalsales1 := 0;
                    installationamts := 0;
                    amc := 0;
                    boi := 0;
                    str := 'IN';
                    str1 := 'SI';
                    str2 := 'CI';
                    ExciseCollected := 0;
                    pos := 0;
                    pos1 := 0;
                    pos2 := 0;
                    SIH.RESET;
                    SIH.SETRANGE(SIH."Posting Date", DMY2Date(04, 01, 18), fromdate);  //need to update every year
                    IF SIH.FINDSET THEN
                        REPEAT
                            IF (SIH."Sell-to Customer No." <> 'CUST00536') THEN BEGIN
                                SIH.CALCFIELDS(SIH."Total Invoiced Amount");
                                totalsales1 := totalsales1 + SIH."Total Invoiced Amount" / 10000000;
                                pos := STRPOS(SIH."External Document No.", str);
                                pos1 := STRPOS(SIH."External Document No.", str1);
                                pos2 := STRPOS(SIH."External Document No.", str2);
                                IF pos <> 0 THEN
                                    installationamts := installationamts + SIH."Total Invoiced Amount" / 10000000;
                                IF pos1 <> 0 THEN
                                    amc := amc + SIH."Total Invoiced Amount" / 10000000;
                                IF pos2 <> 0 THEN
                                    boi := boi + SIH."Total Invoiced Amount" / 10000000;
                                month := DATE2DMY(SIH."Posting Date", 2);
                                IF month = 3 THEN BEGIN
                                    SIH.CALCFIELDS(SIH."Total Excise Amount");
                                    ExciseCollected := ExciseCollected + SIH."Total Excise Amount" / 10000000;
                                END;
                            END;
                            pos := 0;
                            pos1 := 0;
                            pos2 := 0;
                        UNTIL SIH.NEXT = 0;

                    actsales := totalsales1 - installationamts - amc - boi;
                    /*Subject:='ERP - Consolidate Sales & AMC Transactions Summary of 18-19 Year ';       //need to update every year
                    Body:='<BODY><h3><center>'+FORMAT(fromdate,0,'<Day>-<Month Text,3>-<Year4>')+' Transactions';
                    Body+= '</center></h3>';
                    Body+='<table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
                    Body+='border="1" align="Center">';
                    Body+='<tr><td>Sales</td><td align="right">'+S1+'</td></tr>';
                    Body+='<tr><td>Received</td><td align="right">'+S2+'</td></tr>';
                    Body+='<tr><td>Paid</td><td align="right">'+S3+'</td></tr></table>';
                    Body+='<h3><center>Sales Transactions(Amount in Crores) as on '+ FORMAT(fromdate,0,'<Day>-<Month Text,3>-<Year4>');
                    Body+= '</center></h3>';
                    Body+='<table style="WIDTH:400px; HEIGHT: 10px; FONT-WEIGHT: bold"';
                    Body+='border="1" align="Center">';
                    Body+='<tr><td>Excise Sales</td><td align="right">'+FORMAT(ROUND(actsales))+'</td></tr>';
                    Body+='<tr><td>Trading Items Sales</td><td align="right">'+FORMAT(ROUND(boi))+'</td></tr>';
                    Body+='<tr><td bgcolor="#CCFFCC">Sales Turnover</td><td bgcolor="#CCFFCC" align="right">'+FORMAT(ROUND(boi+actsales));
                    Body+='</td></tr><tr><td>Installation</td><td align="right">'+FORMAT(ROUND(installationamts))+'</td></tr>';//
                    Body+='<tr><td>AMC</td><td align="right">'+FORMAT(ROUND(amc))+'</td></tr>';
                    Body+='<tr><td bgcolor="#CCFFCC">Installa&AMC Totals</td><td bgcolor="#CCFFCC" align="right">';
                    Body+=FORMAT(ROUND(amc+installationamts))+'</td></tr>';
                    Body+='<tr><td bgcolor="#F0B4BC">Total</td><td bgcolor="#F0B4BC" align="right">'+FORMAT(ROUND(totalsales1))+'</td></tr>';
                    Body+='</table></body>';
                    //Body+= '</n>For More details see <a href="http://intranet:8080/SalesReport/Sales_Summary.aspx" target="Blank_">Sales Report</a> ';
                    //Body+='<tr><td>Total Excise Collected in March</td><td align="right">'+FORMAT(ROUND(ExciseCollected,1))
                    //+'</td></tr></table></body>';
                    
                         Mail_From:='noreply@efftronics.com';
                    //  Mail_To:='anilkumar@efftronics.com';
                        //Mail_To:='erp@efftronics.com,sganesh@efftronics.com';//dir
                       // Mail_To+='padmaja@efftronics.com,sambireddy@efftronics.com,ravi@efftronics.com,anuradhag@efftronics.com,prasannat@efftronics.com,mnraju@efftronics.com,rakesht@efftronics.com';
                      Mail_To+='purchase@efftronics.com,renukach@efftronics.com,anvesh@efftronics.com,bhavani@efftronics.com,ramasamy@efftronics.com,sbshankar@efftronics.com,committe@efftronics.com,ceo@efftronics.com,mk@effe.in';
                    
                        //Mail_To:='bharatik@efftronics.com,jhansi@efftronics.com,';//dir
                        //Mail_To+='erp@efftronics.com,mnraju@efftronics.com,rakesht@efftronics.com,sundar@efftronics.com';//prasannat@efftronics.com,mnraju@efftronics.com,rakesht@efftronics.com
                    
                    
                        //Mail_To+='durgaraov@efftronics.com,sundar@efftronics.com,bala@efftronics.com,ramkumarl@efftronics.com,';
                        Mail_To:='cuspm@efftronics.com,erp@efftronics.com';
                        //IF totalsales1>0 THEN
                        BEGIN
                          SMTP_MAIL.CreateMessage('ERP',Mail_From,Mail_To,Subject,Body,TRUE);
                          //EFFUPG Start
                          {
                          SMTP_MAIL.AddAttachment(Attachment1);
                          SMTP_MAIL.AddAttachment(attachment13);
                          SMTP_MAIL.AddAttachment(attachment14);
                          }
                          SMTP_MAIL.AddAttachment(Attachment1,'');
                          SMTP_MAIL.AddAttachment(attachment13,'');
                          SMTP_MAIL.AddAttachment(attachment14,'');
                          //EFFUPG End
                          SMTP_MAIL.Send;
                        END;*/

                    //RD_Material_Alerts;//Added by sujani on 11-06-2018 for R&D material Requisation Alerts

                    //Shortage_Delay; // Added by Rakesh to send automail if there is delay in Shortage Process on 21-Nov-14
                    // Pending_PO; //Added by Rakesh to send automail of Pending PO on 12-Dec-14
                    // Pending_QA; // Added by Rakesh to send automail or pending QA items on 27-Dec-14

                    //To_Be_Received_Bills_Mail;  //Added by Pranavi to send alert mail of To be Received Bills to Purchase on 12-08-2015
                    /*
                    // PENDING SITE BILLS
                       Body:='';
                       Body+='****  Automatic Mail Generated From ERP  ****';
                       REPORT.RUN(50170,FALSE,FALSE);
                     //  REPORT.SAVEASPDF(50170,'\\EFF-CPU-222\erp');
                       REPORT.SAVEASPDF(50170,'\\erpserver\ErpAttachments\SITE.PDF',FALSE);
                       Mail_From:='erp@efftronics.com';
                       Mail_To:='Prasanthi@efftronics.com,Purchase@efftronics.com,padmasri@efftronics.com,'+
                                'sudhakarreddy@efftronics.com,tnmrao@efftronics.com,tirupataiah@efftronics.com,nagamani@efftronics.com,'+
                                'madhavip@efftronics.com,praveena@efftronics.com,anupama@efftronics.com,anilkumar@efftronics.com,'+
                                'renukach@efftronics.com,anilkumar@efftronics.com,sambireddy@efftronics.com';//dir
                       Subject:=' SITE PENDING BILLS ';
                       SMTP_MAIL.CreateMessage('ERP',Mail_From,Mail_To,Subject,Body,FALSE);
                       SMTP_MAIL.AddAttachment('\\erpserver\ErpAttachments\SITE.PDF');
                       SMTP_MAIL.Send;
                     */

                    /*anil
                   //Code for sending sale order changes
                   CLE1.RESET;
                   CLE1.SETFILTER(CLE1."Date and Time",'%1..%2',CREATEDATETIME(TODAY-1,0T),CREATEDATETIME(TODAY-1,235900T));
                   REPORT.SAVEASPDF(50226,'\\erpserver\ErpAttachments\Changelog.PDF',FALSE,CLE1);
                   Attachment:='\\erpserver\ErpAttachments\Changelog.PDF';
                   Mail_From:='ERP@efftronics.com';
                     Mail_To:='Padmaja@efftronics.com,anuradhag@efftronics.com,prasannat@efftronics.com,anilkumar@efftronics.com,Sundar@efftronics.com'
                   ;
                   Mail_To+=',Purchase@efftronics.com';
                   Subject:='Changes in Sale Orders on '+FORMAT(TODAY-1);
                     Body:='<PDF><BODY>Dear Sir,<BR>';
                     Body+='<BR><PRE>       See the Attachment for list of changes in sale orders on yesterday</PRE><BR><BR>';
                     Body+='<PRE>             ****  Automatic Mail Generated From ERP  ****</PRE></BODY></PDF>';

                   SMTP_MAIL.CreateMessage('ERP',Mail_From,Mail_To,Subject,Body,TRUE);
                   SMTP_MAIL.AddAttachment(Attachment);
                   SMTP_MAIL.Send;

                   //Code for sending the sale orders with project completion dates in next 20 days

                    Sh.RESET;
                    Sh.SETFILTER(Sh."Document Type",'=%1',1);
                    Sh.SETFILTER(Sh."Project Completion Date",'%1..%2',TODAY,TODAY+20);
                    IF Sh.FINDFIRST THEN
                    BEGIN
                      REPORT.SAVEASPDF(50227,'\\erpserver\ErpAttachments\SALE ORDER COMPLETION DATE.PDF',FALSE,Sh);
                      Attachment:='\\erpserver\ErpAttachments\SALE ORDER COMPLETION DATE.PDF';
                     Mail_From:='ERP@efftronics.com';
                     Mail_To:='sales@efftronics.com,cuspm@efftronics.com,Prasanthi@efftronics.com,pmurali@efftronics.com,';//dir
                     Mail_To+='padmaja@efftronics.com,Anilkumar@efftronics.com,Sundar@efftronics.com';
                     Subject:='To be Completed sale orders';
                     Body:='<PDF><BODY>Dear Sir,<BR>';
                     Body+='<BR><PRE>       See the Attachment for list of sale orders whose completion date is in next 20 days</PRE><BR><BR>';
                     Body+='<PRE>             ****  Automatic Mail Generated From ERP  ****</PRE></BODY></PDF>';

                   SMTP_MAIL.CreateMessage('ERP',Mail_From,Mail_To,Subject,Body,TRUE);
                   SMTP_MAIL.AddAttachment(Attachment);
                   SMTP_MAIL.Send;

                    END;
                    */


                    //dcMails.MailDC; //commented by Rakesh for checking DC Mails
                    "BGS Expire mails";


                    //added by pranavi on 27-02-2015 for sending stock statement report
                    lastdate := CALCDATE('CM', Rec."Daily Entrires Posting Date");
                    IF DATE2DWY(lastdate, 1) = 1 THEN
                        lastsat := lastdate - 2
                    ELSE
                        IF DATE2DWY(lastdate, 1) = 2 THEN
                            lastsat := lastdate - 3
                        ELSE
                            IF DATE2DWY(lastdate, 1) = 3 THEN
                                lastsat := lastdate - 4
                            ELSE
                                IF DATE2DWY(lastdate, 1) = 4 THEN
                                    lastsat := lastdate - 5
                                ELSE
                                    IF DATE2DWY(lastdate, 1) = 5 THEN
                                        lastsat := lastdate - 6
                                    ELSE
                                        IF DATE2DWY(lastdate, 1) = 6 THEN
                                            lastsat := lastdate;
                    IF DATE2DWY(lastdate, 1) = 7 THEN
                        lastsat := lastdate - 1;

                    IF Rec."Daily Entrires Posting Date" = lastsat THEN BEGIN
                        stockstatementmail;
                    END;
                    //end by pranavi

                    //MD_Sir_Mails; // COMMENTED BU SUJANI ON 16-04-18 AS PER ANIL SIR  COMMAND

                    //SalesChangesAlert;

                    ToBeShippedAMCAlert;


                    DispatchAssuranceMail1;

                    DCTrackingStatusUpdate; // Added by Pranavi on 06-Aug-2016
                    PurchaseDCStatusUpdate; // Added by Pranavi on 15-Nov-2016
                    SDStatusUpdation; // Added by Pranavi on 20-Aug-2016 for SD Status Updates
                                      //ToBePlannedBOIAlert;  // Added by Pranavi on 02-Dec-2016

                    PendingQA_Auth_PO_Alert;  // Added by Pranavi on 24-Dec-2016
                    CS_Adjustment_Alert;    // Added by Pranavi On 07-05-2017
                    MSL_Alert;    // Added by Pranavi on 26-May-2017 for MSL Alert
                    MaterialShortage; // Added by Vijaya on 31-05-2017 for Material Shortage
                                      //omsdump.RUN;    // Added by Pranavi On 07-07-2015 for OMS Dumping
                                      //SQLIntegrtn.PRMRefresh; //system date format should be dd-mmm-yyyy
                                      //end by pranavi

                    TAMS_BASED_USERS_BLOCKING;// added by vishnu Priya
                    //TAMS_DEPT_UPDATION; //added by vishnu priya

                end;
            }
        }
        addafter("Payroll Trans. Import Format")
        {
            group(Attachments)
            {
                Caption = 'Attachments';
                field("ESPL Attachment Storage Type"; Rec."ESPL Attachment Storage Type")
                {
                    ApplicationArea = All;
                }
                field("ESPL Attmt. Storage Location"; Rec."ESPL Attmt. Storage Location")
                {
                    ApplicationArea = All;
                }
                field("Sql Connection String"; Rec."Sql Connection String")
                {
                    ApplicationArea = All;
                }
                field("Active ERP-CF Connection"; Rec."Active ERP-CF Connection")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ActiveERPCFConnectionOnPush;
                    end;
                }
                field("Session Killer Time Setup"; Rec."Session Killer Time Setup")
                {
                    ApplicationArea = All;
                }
                field("Shortage. Calc. Date"; Rec."Shortage. Calc. Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Production_ Shortage_Status"; Rec."Production_ Shortage_Status")
                {
                    ApplicationArea = All;
                }
                field("Restrict Store Material Issues"; Rec."Restrict Store Material Issues")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        addafter("Change Payment &Tolerance")
        {
            action(To_be_Received_Items)
            {
                Caption = 'To_be_Received_Items';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    // Added by rakesh to send automail for Deviated Purchase items on 27-Dec-14.
                    PurchLine.RESET;
                    PurchLine.SETRANGE(PurchLine."Document Type", PurchLine."Document Type"::Order);
                    PurchLine.SETFILTER(PurchLine.Type, '<>%1', 0);

                    //End by rakesh
                end;
            }
            action("MD Sir mails")
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    MD_Sir_Mails;
                end;
            }
            action(RD_Alerts)
            {
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    RD_Material_Alerts;
                    //RD_Mail_for_SalesOrders;
                end;
            }
            action("DC Mails")
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    dcMails.MailDC;
                    //SDStatusUpdation;
                    /*SIH.RESET;
                    SIH.SETFILTER("No.",'EX-INV-18-19-00952');
                    IF SIH.FINDSET THEN
                    
                        BEGIN
                          SIH.SecDepStatus := SIH.SecDepStatus::Warranty;
                          SIH.MODIFY;
                          MESSAGE('record modified');
                          END;
                          */

                end;
            }
            action(MSL)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    MSL_Alert;

                    //RD_Mail_for_SalesOrders;
                end;
            }
            action(SALEORDERS_ACTUALSDUMP)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //ERROR('You don not have rights to run the actuals');
                    //SALESACTUALSDUMPING; // Written By Vishnu Priya on 13-02-2019

                    //TAMS_BASED_USERS_BLOCKING;
                end;
            }
            action("QA Calibration Alerts")
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //CalibrationAlerts;
                    //QAFLAG; // vishnu
                end;
            }
            action(IREPS)
            {
                Image = Alerts;
                ToolTip = 'IREPS ALERTS';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //IREPS_Tenders;
                    //RD_Mail_for_SalesOrders;
                    //CSIGCS_MAIL;
                end;
            }
            action("CS STK")
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //CS_Adjustment_Alert;
                end;
            }
            action(TAMSBASEDUPDATES)
            {
                Caption = 'TAMS_BASED_USER_UPDATIONS';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    TAMS_BASED_USERS_BLOCKING;
                    //IF DATE2DWY("Allow Posting To", 1) IN [1] THEN //added by Vishnu Priya on 23-07-2019 for Updation of Dept in User Table
                    //TAMS_DEPT_UPDATION;
                end;
            }
            action("AMC DUMP")
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //REPORT.RUN(50023,FALSE);
                end;
            }
            action(Stockanalysis)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Stock_Analysis;
                end;
            }
            action(CSIGCs)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //CSIGCS_MAIL;
                end;
            }
            action(PendingPO)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    ToBePlannedBOIAlert;
                    //Pending_PO;
                end;
            }
            action("QA FLAG")
            {
                Image = Holiday;
                InFooterBar = true;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    SDStatusUpdation;
                    dcMails.MailDC_NEW; // added by vishnu
                    CalibrationAlerts;
                    //TAMS_BASED_USERS_BLOCKING;
                    //QAFLAG;
                    REPORT.RUN(50023, FALSE); // AMC Orders Dump
                    MSL_Alert;
                    CS_Adjustment_Alert;
                end;
            }
            action(DC_QC_CALIBRATION)
            {
                Caption = 'DC_QC_CALIBRATION';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    dcMails.MailDC_NEW; // added by vishnu
                    CalibrationAlerts;
                    SALESACTUALSDUMPING;
                end;
            }

        }
    }

    trigger OnOpenPage()
    begin
        //IF NOT (USERID IN ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\ANVESH', 'EFFTRONICS\20TE099', 'EFFTRONICS\20TE128', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\B2BOTS']) THEN
        //  ERROR('You Do not have rights to open GL Setup!');
        IF NOT (USERID IN ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\ANVESH', 'ERPSERVER\ADMINISTRATOR', 'EFFTRONICS\DURGAMAHESWARI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\B2BOTS', 'EFFTRONICS\SUVARCHALADEVI']) THEN
            ERROR('You Do not have rights to open GL Setup!');//EFFUPG1.2
    end;


    var
        Item: Record Item;
        Cs_Shortage_QTY: Integer;
        New_Line: Char;
        Body: Text;
        Subject: Text;
        Mail_To: Text;
        Mail_From: Text;
        Attachment: Text[1000];
        Mail: Codeunit 397;
        "No. Of Spaces": Integer;
        i: Integer;
        "g/l setup": Record "General Ledger Setup";
        "Document-Print": Codeunit 229;
        Sh: Record "Sales Header";
        PurchLine: Record "Purchase Line";
        Attachment1: Text[1000];
        MIH: Record "Material Issues Header";
        IRH: Record "Inspection Datasheet Header";
        IR: Record "Inspection Receipt Header";
        Pl: Record "Purchase Line";
        PRL: Record "Purch. Rcpt. Line";
        IDS: Record "Inspection Datasheet Header";
        "max": Date;
        "min": Date;
        PENDING: Integer;
        RETMIH: Record "Material Issues Header";
        PIMH: Record "Posted Material Issues Header";
        SIH: Record "Sales Invoice Header";
        "Mail-Id": Record User;
        Billenddate: Date;
        present: Integer;
        SL: Record "Sales Line";
        presentqua: Integer;
        temp: Integer;
        temp1: Integer;
        noofperiod: Integer;
        billedamt: Decimal;
        Shortage_Details: Record "Item Lot Numbers";
        Indent_Line: Record "Indent Line";
        Send_Mail: Boolean;
        AVE: Record "Analysis View Entry";
        user: Record "User Setup";
        "Bal amt": Decimal;
        maxdate: Date;
        mindate: Date;
        IH: Record "Indent Header";
        IL: Record "Indent Line";
        SMTPSETUP: Record "SMTP SETUP";
        AttachFileName: Text[1000];
        //objEmailConf: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000002-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Configuration";
        //objEmail: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000001-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Message";
        //flds: Automation "'{00000205-0000-0010-8000-00AA006D2EA4}' 2.5:'{00000564-0000-0010-8000-00AA006D2EA4}':''{00000205-0000-0010-8000-00AA006D2EA4}' 2.5'.Fields";
        //fld: Automation "'{00000205-0000-0010-8000-00AA006D2EA4}' 2.5:'{00000569-0000-0010-8000-00AA006D2EA4}':''{00000205-0000-0010-8000-00AA006D2EA4}' 2.5'.Field";
        bodies: Integer;
        Mail_Body: array[5] of Text[1000];
        body1: Text[1000];
        PIDS: Record "Posted Inspect DatasheetHeader";
        bg: Record "Bank Guarantee";
        totalsales: Decimal;
        totalreceivedamts: Decimal;
        totalpayments: Decimal;
        CLE: Record "Cust. Ledger Entry";
        VLE: Record "Vendor Ledger Entry";
        fromdate: Date;
        attachment3: Integer;
        attachment14: Text[1000];
        attachment13: Text[1000];
        totalsales1: Decimal;
        installationamts: Decimal;
        amc: Decimal;
        str: Text[5];
        str1: Text[5];
        pos: Integer;
        pos1: Integer;
        str2: Text[5];
        pos2: Integer;
        boi: Decimal;
        actsales: Decimal;
        ExciseCollected: Decimal;
        month: Integer;
        //SMTP_MAIL: Codeunit "SMTP Mail";
        USER_SETUP: Record "User Setup";
        CUSTOMER: Record Customer;
        SalInvHeader: Record "Sales Invoice Header";
        formataddress: Codeunit "Correct Dimension Values Cust"; // 365;
        S1: Text[30];
        S2: Text[30];
        S3: Text[30];
        Vendor: Record Vendor;
        PurchaseLine: Record "Purchase Line";
        PurchaseHeader: Record "Purchase Header";
        k: Integer;
        CLE1: Record "Change Log Entry";
        //SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
        //SQLConnection1: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
        //RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        SQLQuery: Text[1000];
        "Auth Date": DateTime;
        Mail_count: Integer;
        dcMails: Page "DC List";
        Pending_QA5: Integer;
        Pending_QA10: Integer;
        Pending_QAG: Integer;
        lastdate: Date;
        lastsat: Date;
        omsdump: Codeunit OMSDumping;
        PODateVar: Date;
        SQLIntegrtn: Codeunit SQLIntegration;
        RowCount: Integer;
        RowCount1: Integer;
        //RecordSet1: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        SQLQuery1: Text[1000];
        SQLQuery2: Text[1000];
        SQLQuery3: Text[1000];
        DeleteQuery: Text[500];
        ConnectionOpen: Integer;
        NoOfRowsAffected: Integer;
        PrevRec: Text;
        RowSpn: Decimal;
        temp12: Decimal;
        //RecordSet2: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        RowCount2: Integer;
        StockOMSDump: Codeunit "OMS Dump";
        CalMngmt: Codeunit "Calendar Management";
        "Stock at MCH": Decimal;
        "Stock at CS Stores": Decimal;
        "Stock at RD Stores": Decimal;
        "Stock at Stores": Decimal;
        Rqst_no: Text[1024];
        Rqstd_user: Text[1024];
        Rqstd_Item: Text[1024];
        Rqstd_Qty: Decimal;
        Pending_Qty: Decimal;
        //Mail1: Codeunit "SMTP Mail";
        SNO: Integer;
        ILE: Record "Item Ledger Entry";
        USER_TABLE: Record User;
        Rqsted_Mails: Code[1024];
        MIL: Record "Material Issues Line";
        Stock_At_Str_Qty: Decimal;
        Rqstd_user_old: Text[1024];
        QILE: Record "Quality Item Ledger Entry";
        ileqty: Decimal;
        salesheader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Managers: array[5] of Text;
        No_of_Managers: Integer;
        ISG: Record "Item Sub Group";
        ISG1: Record "Item Sub Group";
        US: Record "User Setup";
        BANKARRY: array[100] of Text;
        SQLQuery4: Text;
        SQLQuery5: Text;
        SQLQuery6: Text;
        SQLQuery7: Text;
        SQLQuery8: Text;
        SQLQuery9: Text;
        Day: Integer;
        FORLOOP1: Integer;
        ForLOOP2: Integer;
        SalesPerson: Record "Salesperson/Purchaser";
        NeedtoInvAmt: Decimal;
        Division: Record "Employee Statistics Group";
        Zone: Record "Cause of Inactivity";
        CalibrationEntr: Record Calibration;
        DateFilterCalbartion: Date;
        PMIH1: Record "Posted Material Issues Header";
        OwnersArr: array[800] of Text;
        SL1: Record "Sales Line";
        Updated_Cnt: Integer;
        AccessControlTable: Record "Access Control";
        EmployeeTable: Record Employee;
        Empleftdate: DateTime;
        EmployeeidNumber: Text[30];
        UsersTable: Record User;
        Employeedept: Text;
        t2: Text;
        Day1: Integer;
        Month1: Integer;
        Year1: Integer;
        UptoWhich: Date;
        ItemCount: Integer;
        loop_i: Integer;
        SalesLine1: Record "Sales Line";
        t3: Text;
        count1: Decimal;
        DCH1: Record "DC Header";
        DCL1: Record "DC Line";
        item1: Record Item;
        Desig: Text;
        //SMTPMAIL: Codeunit "SMTP Mail";
        DeptNumber: Decimal;
        concern_person: Text;
        NewString: Text;
        IRHeader: Record "Inspection Receipt Header";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];



    procedure MG();
    begin
        Subject := 'ERP- Alert for AMC Bill  ' + Sh."No.";
        Body := 'Customer Name                        : ' + Sh."Sell-to Customer Name";
        Body += FORMAT(New_Line);
        Body += 'AMC Order No.                        : ' + Sh."No.";
        Body += FORMAT(New_Line);
        Body += 'Customer Order No.                   : ' + Sh."Customer OrderNo.";
        Body += FORMAT(New_Line);
        Body += 'AMC Order Value                      : ' + FORMAT(Sh."Sale Order Total Amount");
        Body += FORMAT(New_Line);
        IF Sh."Payment Terms Code" = 'QUARTER' THEN BEGIN
            Body += 'Bill Period                          : ' + FORMAT((Billenddate - 90), 0, 4) + ' To ' + FORMAT((Billenddate), 0, 4);
            Body += FORMAT(New_Line);
        END
        ELSE
            IF Sh."Payment Terms Code" = 'HALFYEARLY' THEN BEGIN
                //Body+=FORMAT(New_Line);
                Body += 'Bill Period                          : ' + FORMAT((Billenddate - 180), 0, 4) + ' To ' + FORMAT((Billenddate), 0, 4);
                Body += FORMAT(New_Line);
            END;
        Body += 'Bill for ' + Sh."Payment Terms Code" + '                     : ' + FORMAT(presentqua);
        Body += FORMAT(New_Line);
        Body += 'Bill Amount                          : ' + FORMAT(ROUND(billedamt, 1));
        Body += FORMAT(New_Line);
        Body += 'AMC Period Start Date                : ' + FORMAT((Sh."Requested Delivery Date"), 0, 4);
        Body += FORMAT(New_Line);
        Body += FORMAT(New_Line);
        Body += '***** Auto Mail Generated From ERP *****';
        Mail_From := 'anilkumar@efftronics.com,';
        Mail_To := 'prasanthi@efftronics.com,yesu@efftronics.com,cvmohan@efftronics.com,anilkumar@efftronics.com';
        //Mail_To:='swarupa@efftronics.com';
        // IF (Mail_From<>'')AND(Mail_To<>'') THEN
        // Mail.NewCDOMessage(Mail_From,Mail_To,Subject,Body,'');
    end;

    procedure Shortage_Status(Search_String: Code[20]) status: Boolean;
    begin

        IF Search_String = 'OPEN' THEN BEGIN
            Shortage_Details.SETCURRENTKEY(Shortage_Details."Planned Purchase Date");
            Shortage_Details.SETFILTER(Shortage_Details."Planned Purchase Date", '%1|%2..%3', 0D, Rec."Shortage. Calc. Date",
                                                                                               (Rec."Shortage. Calc. Date" + 2));
            Shortage_Details.SETRANGE(Shortage_Details.Authorisation, Shortage_Details.Authorisation::Open);
            IF Shortage_Details.FINDFIRST THEN
                status := TRUE;
            EXIT(status)
        END ELSE

            IF Search_String = 'WAP' THEN BEGIN
                Shortage_Details.SETCURRENTKEY(Shortage_Details."Planned Purchase Date");
                Shortage_Details.SETFILTER(Shortage_Details."Planned Purchase Date", '%1|%2..%3', 0D, Rec."Shortage. Calc. Date",
                                                                                                   (Rec."Shortage. Calc. Date" + 2));
                Shortage_Details.SETRANGE(Shortage_Details.Authorisation, Shortage_Details.Authorisation::WAP);
                IF Shortage_Details.FINDFIRST THEN
                    status := TRUE;
                EXIT(status)
            END ELSE

                IF Search_String = 'WFA' THEN BEGIN
                    Shortage_Details.SETCURRENTKEY(Shortage_Details."Planned Purchase Date");
                    Shortage_Details.SETFILTER(Shortage_Details."Planned Purchase Date", '%1|%2..%3', 0D, Rec."Shortage. Calc. Date",
                                                                                                       (Rec."Shortage. Calc. Date" + 2));
                    Shortage_Details.SETRANGE(Shortage_Details.Authorisation, Shortage_Details.Authorisation::WFA);
                    IF Shortage_Details.FINDFIRST THEN
                        status := TRUE;
                END ELSE


                    IF Search_String = 'AUTHORISED' THEN BEGIN
                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Planned Purchase Date");
                        Shortage_Details.SETFILTER(Shortage_Details."Planned Purchase Date", '%1|%2..%3', 0D, Rec."Shortage. Calc. Date",
                                                                                                           (Rec."Shortage. Calc. Date" + 2));
                        Shortage_Details.SETRANGE(Shortage_Details.Authorisation, Shortage_Details.Authorisation::Authorised);
                        IF Shortage_Details.FINDFIRST THEN
                            status := TRUE;
                    END ELSE

                        IF Search_String = 'INDENT' THEN BEGIN
                            Shortage_Details.SETCURRENTKEY(Shortage_Details."Planned Purchase Date");
                            Shortage_Details.SETFILTER(Shortage_Details."Planned Purchase Date", '%1|%2..%3', 0D, Rec."Shortage. Calc. Date",
                                                                                                               (Rec."Shortage. Calc. Date" + 2));
                            Shortage_Details.SETRANGE(Shortage_Details.Authorisation, Shortage_Details.Authorisation::indent);
                            IF Shortage_Details.FINDSET THEN
                                REPEAT
                                    Indent_Line.RESET;
                                    Indent_Line.SETRANGE(Indent_Line."Document No.", Shortage_Details."Indent No.");
                                    Indent_Line.SETRANGE(Indent_Line."No.", Shortage_Details."Item No");
                                    Indent_Line.SETRANGE(Indent_Line."Release Status", Indent_Line."Release Status"::Open);
                                    IF Indent_Line.FINDFIRST THEN BEGIN
                                        status := TRUE;

                                        EXIT(status);
                                    END;
                                UNTIL Shortage_Details.NEXT = 0;
                            EXIT(status);
                        END ELSE BEGIN
                            Shortage_Details.SETCURRENTKEY(Shortage_Details."Planned Purchase Date");
                            Shortage_Details.SETFILTER(Shortage_Details."Planned Purchase Date", '%1|%2..%3', 0D, Rec."Shortage. Calc. Date",
                                                                                                               (Rec."Shortage. Calc. Date" + 2));
                            Shortage_Details.SETRANGE(Shortage_Details.Authorisation, Shortage_Details.Authorisation::indent);
                            IF Shortage_Details.FINDSET THEN
                                REPEAT
                                    Indent_Line.RESET;
                                    Indent_Line.SETRANGE(Indent_Line."Document No.", Shortage_Details."Indent No.");
                                    Indent_Line.SETRANGE(Indent_Line."No.", Shortage_Details."Item No");
                                    Indent_Line.SETRANGE(Indent_Line."Indent Status", Indent_Line."Indent Status"::Indent);
                                    IF Indent_Line.FINDFIRST THEN BEGIN
                                        status := TRUE;
                                        EXIT(status);
                                    END;
                                UNTIL Shortage_Details.NEXT = 0;
                            MESSAGE(FORMAT(status));
                            EXIT(status);
                        END;
    end;

    procedure INDIAN_FORMAT(GIVEN_DATE: Date) INDIAN_DATE: Text[30];
    var
        MONTH: Code[10];
    begin
        CASE DATE2DMY(GIVEN_DATE, 2) OF
            1:
                BEGIN
                    MONTH := 'JAN';

                END;
            2:
                BEGIN
                    MONTH := 'FEB';

                END;
            3:
                BEGIN
                    MONTH := 'MAR';

                END;
            4:
                BEGIN
                    MONTH := 'APR';

                END;
            5:
                BEGIN
                    MONTH := 'MAY';

                END;
            6:
                BEGIN
                    MONTH := 'JUN';

                END;
            7:
                BEGIN
                    MONTH := 'JUL';

                END;
            8:
                BEGIN
                    MONTH := 'AUG';

                END;
            9:
                BEGIN
                    MONTH := 'SEP';

                END;
            10:
                BEGIN
                    MONTH := 'OCt';

                END;
            11:
                BEGIN
                    MONTH := 'NOV';

                END;
            12:
                BEGIN
                    MONTH := 'DEC';

                END;
        END;

        INDIAN_DATE := FORMAT(DATE2DMY(GIVEN_DATE, 1)) + '-' + MONTH + '-' + COPYSTR(FORMAT(DATE2DMY(GIVEN_DATE, 3)), 3, 2);
    end;

    procedure Shortage_Status_Present(Search_String: Code[20]; From_Date: Date; To_Date: Date) status: Boolean;
    begin
        IF Search_String = 'OPEN' THEN BEGIN
            Shortage_Details.SETCURRENTKEY(Shortage_Details."Planned Purchase Date");
            Shortage_Details.SETFILTER(Shortage_Details."Planned Purchase Date", '%1|%2..%3', 0D, From_Date,
                                                                                               To_Date);
            Shortage_Details.SETRANGE(Shortage_Details.Authorisation, Shortage_Details.Authorisation::Open);
            IF Shortage_Details.FINDFIRST THEN
                status := TRUE;
            EXIT(status)
        END ELSE

            IF Search_String = 'WAP' THEN BEGIN
                Shortage_Details.SETCURRENTKEY(Shortage_Details."Planned Purchase Date");
                Shortage_Details.SETFILTER(Shortage_Details."Planned Purchase Date", '%1|%2..%3', 0D, From_Date,
                                                                                                   To_Date);
                Shortage_Details.SETRANGE(Shortage_Details.Authorisation, Shortage_Details.Authorisation::WAP);
                IF Shortage_Details.FINDFIRST THEN
                    status := TRUE;
                EXIT(status)
            END ELSE

                IF Search_String = 'WFA' THEN BEGIN
                    Shortage_Details.SETCURRENTKEY(Shortage_Details."Planned Purchase Date");
                    Shortage_Details.SETFILTER(Shortage_Details."Planned Purchase Date", '%1|%2..%3', 0D, From_Date,
                                                                                                       To_Date);
                    Shortage_Details.SETRANGE(Shortage_Details.Authorisation, Shortage_Details.Authorisation::WFA);
                    IF Shortage_Details.FINDFIRST THEN
                        status := TRUE;
                END ELSE


                    IF Search_String = 'AUTHORISED' THEN BEGIN
                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Planned Purchase Date");
                        Shortage_Details.SETFILTER(Shortage_Details."Planned Purchase Date", '%1|%2..%3', 0D, From_Date,
                                                                                                           To_Date);
                        Shortage_Details.SETRANGE(Shortage_Details.Authorisation, Shortage_Details.Authorisation::Authorised);
                        IF Shortage_Details.FINDFIRST THEN
                            status := TRUE;
                    END ELSE

                        IF Search_String = 'INDENT' THEN BEGIN
                            Shortage_Details.SETCURRENTKEY(Shortage_Details."Planned Purchase Date");
                            Shortage_Details.SETFILTER(Shortage_Details."Planned Purchase Date", '%1|%2..%3', 0D, From_Date,
                                                                                                               To_Date);
                            Shortage_Details.SETRANGE(Shortage_Details.Authorisation, Shortage_Details.Authorisation::indent);
                            IF Shortage_Details.FINDSET THEN
                                REPEAT
                                    Indent_Line.RESET;
                                    Indent_Line.SETRANGE(Indent_Line."Document No.", Shortage_Details."Indent No.");
                                    Indent_Line.SETRANGE(Indent_Line."No.", Shortage_Details."Item No");
                                    Indent_Line.SETRANGE(Indent_Line."Release Status", Indent_Line."Release Status"::Open);
                                    IF Indent_Line.FINDFIRST THEN BEGIN
                                        status := TRUE;

                                        EXIT(status);
                                    END;
                                UNTIL Shortage_Details.NEXT = 0;
                            EXIT(status);
                        END ELSE BEGIN
                            Shortage_Details.SETCURRENTKEY(Shortage_Details."Planned Purchase Date");
                            Shortage_Details.SETFILTER(Shortage_Details."Planned Purchase Date", '%1|%2..%3', 0D, From_Date,
                                                                                                               To_Date);
                            Shortage_Details.SETRANGE(Shortage_Details.Authorisation, Shortage_Details.Authorisation::indent);
                            IF Shortage_Details.FINDSET THEN
                                REPEAT
                                    Indent_Line.RESET;
                                    Indent_Line.SETRANGE(Indent_Line."Document No.", Shortage_Details."Indent No.");
                                    Indent_Line.SETRANGE(Indent_Line."No.", Shortage_Details."Item No");
                                    Indent_Line.SETRANGE(Indent_Line."Indent Status", Indent_Line."Indent Status"::Indent);
                                    IF Indent_Line.FINDFIRST THEN BEGIN
                                        status := TRUE;
                                        EXIT(status);
                                    END;
                                UNTIL Shortage_Details.NEXT = 0;
                            MESSAGE(FORMAT(status));
                            EXIT(status);
                        END;
    end;

    local procedure ActiveERPCFConnectionOnPush();
    begin
        IF NOT (UPPERCASE(USERID) IN ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\DURGAMAHESWARI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\SUVARCHALADEVI']) THEN
            ERROR('You dont have rights');
    end;

    procedure Shortage_Delay();
    begin
        // Added by Rakesh on 24-Nov-14 for automail when Shoratge is not run for more than 1 week
        /* IF ISCLEAR(SQLConnection) THEN
             CREATE(SQLConnection, FALSE, TRUE);
         IF ISCLEAR(RecordSet) THEN
             CREATE(RecordSet, FALSE, TRUE);*/
        //Rev01 End
        //>> ORACLE UPG
        /*  SQLConnection.ConnectionString := 'DSN=salinvoiceuser;UID=salinvoiceuser;PASSWORD=salinvoiceuser;SERVER=oracle_80;';
         SQLConnection.Open;
         SQLQuery := 'SELECT MAX(SYS_DATE) Auth_Date from SHORTAGE_AUT  order by 1';
         RecordSet := SQLConnection.Execute(SQLQuery); */
        //<< ORACLE UPG
        //>> ORACLE UPG
        /*
                IF NOT (RecordSet.EOF OR RecordSet.BOF) THEN BEGIN
                    //MESSAGE(FORMAT(RecordSet.Fields.Item('Auth_date').Value));
                    "Auth Date" := RecordSet.Fields.Item('Auth_date').Value;
                    IF (TODAY - DT2DATE("Auth Date")) > 4 THEN         // Modified for 3 days
                    BEGIN
                        //  MESSAGE('Shortage crossed over a week');
                        //  Mail_From := 'erp@efftronics.com';
                        // Mail_To := 'padmaja@efftronics.com,purchase@efftronics.com,projectmanagement@efftronics.com,anilkumar@efftronics.com,erp@efftronics.com';
                        // Subject := 'ERP - Delay in Shoratge Procurement Process';
                        // Body := '<Body>Dear Sir/Madam,<br><br>';
                        // Body += '               There has been a delay of Shortage Material Procurement process. The last Shortage was executed on ' + FORMAT("Auth Date") + '.<br>';
                        // Body += 'So Kindly execute the Shortage process.<br><br>';
                        // Body += 'Regards,<br>ERP Team<br><br><b>Note: This automail is generated if the delay is more than 3 days.<b></body>';
                        // SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
                        // SMTP_MAIL.Send;    
                        // MESSAGE('Mail has been sent');   //B2BUPG

                        Recipients.Add('padmaja@efftronics.com');
                        Recipients.Add('purchase@efftronics.com');
                        Recipients.Add('projectmanagement@efftronics.com');
                        Recipients.Add('anilkumar@efftronics.com');
                        Recipients.Add('erp@efftronics.com');
                        Subject := 'ERP - Delay in Shoratge Procurement Process';
                        Body := '<Body>Dear Sir/Madam,<br><br>';
                        Body += '               There has been a delay of Shortage Material Procurement process. The last Shortage was executed on ' + FORMAT("Auth Date") + '.<br>';
                        Body += 'So Kindly execute the Shortage process.<br><br>';
                        Body += 'Regards,<br>ERP Team<br><br><b>Note: This automail is generated if the delay is more than 3 days.<b></body>';

                        EmailMessage.Create(Recipients, Subject, Body, true);
                        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                    END;
                    SQLConnection.Close;
                END ELSE BEGIN
                    SQLConnection.Close;
                    ERROR('There was error while extracting Date while Shortage Delay');
                END;
                // End by Rakesh
                */ //<< ORACLE UPG
    end;

    procedure Pending_PO();
    begin
        // Added by Rakesh for automail for Pending Purchase Orders on 12-Dec-14
        //07-11-2014
        /* IF EVALUATE(PODateVar, '31-03-2015') = TRUE THEN BEGIN
            Mail_count := 0;
            PurchaseHeader.RESET;
            PurchaseHeader.SETRANGE(PurchaseHeader."Document Type", PurchaseHeader."Document Type"::Order);
            PurchaseHeader.SETFILTER(PurchaseHeader."Order Date", '>%1', PODateVar);
            PurchaseHeader.SETFILTER(PurchaseHeader.Mail_count, '%1', 0);
            //PurchaseHeader.SETFILTER(PurchaseHeader.Mail_Sent,'');
            Mail_From := 'erp@efftronics.com';
            Mail_To := 'purchase1@efftronics.com,erp@efftronics.com';
            //Mail_To := 'pranavi@efftronics.com';
            Subject := 'Reg: Pending Purchase Orders';
            Body := '';
            SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
            Body += ('<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>');
            Body += ('<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;"><label><font size="6">Pending Purchase Orders</font></label>');
            Body += ('<hr style=solid; color= #3333CC>');
            Body += ('<h>Dear Purchase Dept. ,</h><br><br>');
            Body += ('<h><b>Responsible Dept: <font color=red>Purchase.</font></h><br>');
            Body += ('<h>Action: <font color=red>Need to forward PO to vendors.</font></b></h><br>');
            Body += ('<P> The below Purchase Orders have been created and order is pending, </P>');
            Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Order No.</th><th>Vendor</th><th>Order Date</th><th>Pending Days</th></tr>');

            IF PurchaseHeader.FINDSET THEN
                REPEAT
                    IF (TODAY - PurchaseHeader."Order Date") > 2 THEN BEGIN
                        Body += ('<tr><td>' + PurchaseHeader."No." + '</td><td>' + PurchaseHeader."Buy-from Vendor Name" + '</td><td>' + FORMAT(PurchaseHeader."Order Date") + '</td><td>' + FORMAT(TODAY - PurchaseHeader."Order Date") + '</td></tr>');
                        Mail_count += 1;
                    END;
                UNTIL PurchaseHeader.NEXT = 0;

            Body += ('</table><br>');
            Body += ('<br>Click <a href="http://erpserver:8080/SSRSReports/Pages/ReportViewer.aspx?%2fPurchase_order_details%2fPur_Pending_Mail&rs:Command=Render"><b>here</b></a> to view the Pending Purchase Orders Report');
            Body += ('<p align ="left"> Regards,<br>ERP Team </p>');
            Body += ('<br><p align = "center">:: Note: Auto Generated mail from ERP if pending days greater than <b>2 days</b> :: </b></P></div></body></html>');
            SMTP_MAIL.AddCC('erp@efftronics.com');


            IF Mail_count > 0 THEN
                SMTP_MAIL.Send;
        END */                      //B2BUPG

        IF EVALUATE(PODateVar, '31-03-2015') = TRUE THEN BEGIN
            Mail_count := 0;
            PurchaseHeader.RESET;
            PurchaseHeader.SETRANGE(PurchaseHeader."Document Type", PurchaseHeader."Document Type"::Order);
            PurchaseHeader.SETFILTER(PurchaseHeader."Order Date", '>%1', PODateVar);
            PurchaseHeader.SETFILTER(PurchaseHeader.Mail_count, '%1', 0);
            Recipients.Add('purchase1@efftronics.com');
            Recipients.Add('erp@efftronics.com');
            Subject := 'Reg: Pending Purchase Orders';
            Body := '';
            EmailMessage.Create(Recipients, Subject, Body, true);

            Body += ('<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>');
            Body += ('<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;"><label><font size="6">Pending Purchase Orders</font></label>');
            Body += ('<hr style=solid; color= #3333CC>');
            Body += ('<h>Dear Purchase Dept. ,</h><br><br>');
            Body += ('<h><b>Responsible Dept: <font color=red>Purchase.</font></h><br>');
            Body += ('<h>Action: <font color=red>Need to forward PO to vendors.</font></b></h><br>');
            Body += ('<P> The below Purchase Orders have been created and order is pending, </P>');
            Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Order No.</th><th>Vendor</th><th>Order Date</th><th>Pending Days</th></tr>');

            IF PurchaseHeader.FINDSET THEN
                REPEAT
                    IF (TODAY - PurchaseHeader."Order Date") > 2 THEN BEGIN
                        Body += ('<tr><td>' + PurchaseHeader."No." + '</td><td>' + PurchaseHeader."Buy-from Vendor Name" + '</td><td>' + FORMAT(PurchaseHeader."Order Date") + '</td><td>' + FORMAT(TODAY - PurchaseHeader."Order Date") + '</td></tr>');
                        Mail_count += 1;
                    END;
                UNTIL PurchaseHeader.NEXT = 0;

            Body += ('</table><br>');
            Body += ('<br>Click <a href="http://erpserver:8080/SSRSReports/Pages/ReportViewer.aspx?%2fPurchase_order_details%2fPur_Pending_Mail&rs:Command=Render"><b>here</b></a> to view the Pending Purchase Orders Report');
            Body += ('<p align ="left"> Regards,<br>ERP Team </p>');
            Body += ('<br><p align = "center">:: Note: Auto Generated mail from ERP if pending days greater than <b>2 days</b> :: </b></P></div></body></html>');

            IF Mail_count > 0 THEN
                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        END
        ELSE
            ERROR('date format error');
        // end by Rakesh
    end;

    procedure Pending_QA();
    begin
        // Added by Rakesh to mail the pending QA items along on 26-Dec-2014
        Pending_QAG := 0;
        Pending_QA10 := 0;
        Pending_QA5 := 0;
        IDS.RESET;
        IDS.SETRANGE(IDS."Source Type", IDS."Source Type"::"In Bound");

        IF IDS.FINDSET THEN
            REPEAT
                IF (TODAY - DT2DATE(IDS."Creation DateTime")) > 10 THEN
                    Pending_QAG += 1
                ELSE
                    IF (TODAY - DT2DATE(IDS."Creation DateTime")) > 5 THEN
                        Pending_QA10 += 1
                    ELSE
                        IF (TODAY - DT2DATE(IDS."Creation DateTime")) >= 2 THEN
                            Pending_QA5 += 1;
            UNTIL IDS.NEXT = 0;

        /* Mail_From := 'noreply@efftronics.com';
        Mail_To := 'bharat@efftronics.com,dineel@efftronics.com,padmasri@efftronics.com,erp@efftronics.com,qainward@efftronics.com';
        Subject := 'Reg: Pending items at QA';
        Body := '';
        SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
        Body += ('<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#FF8000;  margin: 20px;} </style></head>');
        Body += ('<body><div style="border-color:#FF8000;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;"><label><font size="6">QA Inward Pending Items</font></label>');
        Body += ('<hr style=solid; color= #FF8000>');
        Body += ('<h>Dear Sir/Madam ,</h><br><br>');
        Body += ('<P> The below table represents the pending Items at the QA Inward.</P>');
        Body += ('<table border="1" style="border-collapse:collapse; width:60%; font-size:12pt;"><tr><th align="left"><font color="brown">Period</font></th><th>2-5 Days</th><th>6-10 Days</th><th>>10 Days</th></tr>');
        Body += ('<tr><td><b><font color="brown">Pending Items</font></b></td><td align="right">' + FORMAT(Pending_QA5) + '</td><td align="right">' + FORMAT(Pending_QA10) + '</td><td align="right">' + FORMAT(Pending_QAG) + '</td></tr>');
        Body += ('</table><br>');
        Body += ('<br>Click <a href="http://intranet:8080/QCReport/QASReport.aspx"><b>here</b></a> to view the QA Report');
        Body += ('<p align ="left"> Regards,<br>ERP Team </p>');
        Body += ('<br><p align = "center">:: Note: Auto Generated mail from ERP :: </b></P></div></body></html>');

        IF ((Pending_QA5 > 0) OR (Pending_QA10 > 0) OR (Pending_QAG > 0)) THEN
            SMTP_MAIL.Send;
        // End by Rakesh */        //B2BUPG

        Recipients.Add('bharat@efftronics.com');
        Recipients.Add('dineel@efftronics.com');
        Recipients.Add('padmasri@efftronics.com');
        Recipients.Add('erp@efftronics.com');
        Recipients.Add('qainward@efftronics.com');
        Subject := 'Reg: Pending items at QA';
        Body := '';
        EmailMessage.Create(Recipients, Subject, Body, true);
        Body += ('<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#FF8000;  margin: 20px;} </style></head>');
        Body += ('<body><div style="border-color:#FF8000;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;"><label><font size="6">QA Inward Pending Items</font></label>');
        Body += ('<hr style=solid; color= #FF8000>');
        Body += ('<h>Dear Sir/Madam ,</h><br><br>');
        Body += ('<P> The below table represents the pending Items at the QA Inward.</P>');
        Body += ('<table border="1" style="border-collapse:collapse; width:60%; font-size:12pt;"><tr><th align="left"><font color="brown">Period</font></th><th>2-5 Days</th><th>6-10 Days</th><th>>10 Days</th></tr>');
        Body += ('<tr><td><b><font color="brown">Pending Items</font></b></td><td align="right">' + FORMAT(Pending_QA5) + '</td><td align="right">' + FORMAT(Pending_QA10) + '</td><td align="right">' + FORMAT(Pending_QAG) + '</td></tr>');
        Body += ('</table><br>');
        Body += ('<br>Click <a href="http://intranet:8080/QCReport/QASReport.aspx"><b>here</b></a> to view the QA Report');
        Body += ('<p align ="left"> Regards,<br>ERP Team </p>');
        Body += ('<br><p align = "center">:: Note: Auto Generated mail from ERP :: </b></P></div></body></html>');

        IF ((Pending_QA5 > 0) OR (Pending_QA10 > 0) OR (Pending_QAG > 0)) THEN
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);


        /* //added by pranavi on 27-02-2015 to mail the stock statement
        //Attachment1:='';
        //REPORT.RUN(50060,FALSE,FALSE);
        //REPORT.SAVEASPDF(50060,'\\erpserver\ERPattachments\stockstatementrep.PDF',SIH);
        //Attachment1:='\\erpserver\ERPattachments\stockstatementrep.PDF';
        Mail_From := 'erp@efftronics.com';
        Mail_To := 'erp@efftronics.com,rajani@efftronics.com,mk@effe.in';
        Subject := 'Reg: Stock Statement Details';
        Body := '';
        SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
        //Body += ('<hr style=solid; color= #3333CC>');
        Body += ('<h>Dear Sir/Madam,</h><br><br>');
        Body += ('<br>Click <a href="http://erpserver:8080/SSRSReports/Pages/ReportViewer.aspx?%2fStock_Statement%2fStock_overall&rs:Command=Render"><b>here</b></a> to view the Stock Statement Report');
        Body += ('<p align ="left"> Regards,<br>ERP Team </p>');
        Body += ('<p align ="left"> Note: Please save above report as PDF </p>');
        Body += ('<br><p align = "center">:: Note: Auto Generated mail from ERP :: </b></P></div></body></html>');
        SMTP_MAIL.AddCC('anilkumar@efftronics.com,erp@efftronics.com');
        //SMTP_MAIL.AddAttachment(Attachment1);
        SMTP_MAIL.Send;
        //end by pranavi */             //B2BUPG


        Recipients.Add('erp@efftronics.com');
        Recipients.Add('rajani@efftronics.com');
        Recipients.Add('mk@effe.in');
        Recipients.Add('anilkumar@efftronics.com');
        Subject := 'Reg: Stock Statement Details';
        Body := '';

        Body += ('<h>Dear Sir/Madam,</h><br><br>');
        Body += ('<br>Click <a href="http://erpserver:8080/SSRSReports/Pages/ReportViewer.aspx?%2fStock_Statement%2fStock_overall&rs:Command=Render"><b>here</b></a> to view the Stock Statement Report');
        Body += ('<p align ="left"> Regards,<br>ERP Team </p>');
        Body += ('<p align ="left"> Note: Please save above report as PDF </p>');
        Body += ('<br><p align = "center">:: Note: Auto Generated mail from ERP :: </b></P></div></body></html>');
        EmailMessage.Create(Recipients, Subject, Body, true);
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;

    PROCEDURE stockstatementmail();
    BEGIN
        //added by pranavi on 27-02-2015 to mail the stock statement
        //Attachment1:='';
        //REPORT.RUN(50060,FALSE,FALSE);
        //REPORT.SAVEASPDF(50060,'\\erpserver\ERPattachments\stockstatementrep.PDF',SIH);
        //Attachment1:='\\erpserver\ERPattachments\stockstatementrep.PDF';

        //B2B UPG
        /* Mail_From :='erp@efftronics.com';
        Mail_To := 'erp@efftronics.com,rajani@efftronics.com,mk@effe.in';
        Subject := 'Reg: Stock Statement Details';
        Body:='';
        SMTP_MAIL.CreateMessage('ERP',Mail_From,Mail_To,Subject,Body,TRUE);
        //SMTP_MAIL.AppendBody('<hr style=solid; color= #3333CC>');
        SMTP_MAIL.AppendBody('<h>Dear Sir/Madam,</h><br><br>');
        SMTP_MAIL.AppendBody('<br>Click <a href="http://erpserver:8080/SSRSReports/Pages/ReportViewer.aspx?%2fStock_Statement%2fStock_overall&rs:Command=Render"><b>here</b></a> to view the Stock Statement Report');
        SMTP_MAIL.AppendBody('<p align ="left"> Regards,<br>ERP Team </p>');
        SMTP_MAIL.AppendBody('<p align ="left"> Note: Please save above report as PDF </p>');
        SMTP_MAIL.AppendBody('<br><p align = "center">:: Note: Auto Generated mail from ERP :: </b></P></div></body></html>');
        SMTP_MAIL.AddCC('anilkumar@efftronics.com,erp@efftronics.com');
        //SMTP_MAIL.AddAttachment(Attachment1);
         SMTP_MAIL.Send;
        //end by pranavi */
        //B2B UPG

        //Mail_From :='erp@efftronics.com';
        //Mail_To := 'erp@efftronics.com,rajani@efftronics.com,mk@effe.in';
        Recipients.Add('erp@efftronics.com');
        Recipients.Add('rajani@efftronics.com');
        Recipients.Add('mk@effe.in');
        Subject := 'Reg: Stock Statement Details';
        Body := '';
        EmailMessage.Create(Recipients, Subject, Body, true);
        Body += ('<h>Dear Sir/Madam,</h><br><br>');
        Body += ('<br>Click <a href="http://erpserver:8080/SSRSReports/Pages/ReportViewer.aspx?%2fStock_Statement%2fStock_overall&rs:Command=Render"><b>here</b></a> to view the Stock Statement Report');
        Body += ('<p align ="left"> Regards,<br>ERP Team </p>');
        Body += ('<p align ="left"> Note: Please save above report as PDF </p>');
        Body += ('<br><p align = "center">:: Note: Auto Generated mail from ERP :: </b></P></div></body></html>');
        //SMTP_MAIL.AddCC('anilkumar@efftronics.com,erp@efftronics.com');
        Recipients.Add('anilkumar@efftronics.com');
        //SMTP_MAIL.AddAttachment(Attachment1);
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    END;


    procedure To_Be_Received_Bills_Mail();
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
    begin
        //Added by Pranavi on 12-08-2015 for To be Received Purch. Rcpt Bills
        Mail_count := 0;
        PurchRcptHeader.RESET;
        PurchRcptHeader.SETFILTER(PurchRcptHeader."Bill Received", '%1', FALSE);
        PurchRcptHeader.SETFILTER(PurchRcptHeader."Posting Date", '>%1', CALCDATE(FORMAT(-7) + 'D', TODAY));
        /* Mail_From := 'erp@efftronics.com';
        Mail_To := 'purchase@efftronics.com';
        //Mail_To := 'pranavi@efftronics.com';{,anilkumar@efftronics.com';} */  //B2BUPG
        Recipients.Add('purchase@efftronics.com');
        Subject := 'Reg: Bill Not Received Posted Purch Receipts List';
        Body := '';
        //SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE); //B2BUPG
        EmailMessage.Create(Recipients, Subject, Body, true);
        Body += ('<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#8EB52B;  margin: 20px;} </style></head>');
        Body += ('<body><div style="border-color:#8EB52B;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;"><label><font size="6">To be Received Bills List</font></label>');
        Body += ('<hr style=solid; color= #3333CC>');
        Body += ('<h>Dear Purchase Dept. ,</h><br><br>');
        Body += ('<h><b>Responsible Dept: <font color=red>Purchase.</font></h><br>');
        Body += ('<h>Action: <font color=red>Need to Receive Bill from vendors.</font></b></h><br>');
        Body += ('<P> For the below Purchase Orders Material Received but Bill need to be Received , </P>');
        Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Vendor</th><th>Receipt No.</th><th>Order No.</th><th>Pending Days</th></tr>');

        IF PurchRcptHeader.FINDSET THEN
            REPEAT
            BEGIN
                Body += ('<tr><td>' + PurchRcptHeader."Buy-from Vendor Name" + '</td><td>' + PurchRcptHeader."No." + '</td><td>' + PurchRcptHeader."Order No." + '</td><td>' + FORMAT(TODAY - PurchRcptHeader."Posting Date") + '</td></tr>');
                Mail_count += 1;
            END;
            UNTIL PurchRcptHeader.NEXT = 0;

        Body += ('</table><br>');
        Body += ('<br>Click <a href="http://erpserver:8080/SSRSReports/Pages/ReportViewer.aspx?%2fPurchase_Links%2fSTR_BillsNotRcvd_Inwards&rs:Command=Render"><b>here</b></a> to view the Bills Not Received From Vendors Report');
        Body += ('<p align ="left"> Regards,<br>ERP Team </p>');
        Body += ('<br><p align = "center">:: Note: Auto Generated mail from ERP for Pending bills from last <b>7 Days</b> :: </P></div></body></html>');
        //SMTP_MAIL.AddCC('erp@efftronics.com');  //B2BUPG
        Recipients.Add('erp@efftronics.com');

        IF Mail_count > 0 THEN
            //SMTP_MAIL.Send;   //B2BUPG

              Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

        //End by Pranavi on 12-08-2015
    end;

    procedure MD_Sir_Mails();
    var
        //Email: Codeunit 8901;
        Mail_count: Integer;
        //SMTP_MAIL: Codeunit "SMTP Mail";
        Mail_Body: array[5] of Text[1000];
        Send_Mail: Boolean;
        Mail: Codeunit 397;
        Body: Text[1024];
        Subject: Text[1000];
        Mail_To: Text[1000];
        Mail_From: Text[1000];
        prevdate: Text[20];
        dateTot: Decimal;
        AFTot: Decimal;
        AFlTot: Decimal;
        CSAFTot: Decimal;
        CSAFlTot: Decimal;
        EmpTot: Decimal;
        LnTot: Decimal;
        PATot: Decimal;
        PBTot: Decimal;
        PCODTot: Decimal;
        TaxTot: Decimal;
        Tot_Tot: Decimal;
        AFAmt: Decimal;
        AFlAmt: Decimal;
        CSAFAmt: Decimal;
        CSAFlAmt: Decimal;
        EmpAmt: Decimal;
        LnAmt: Decimal;
        PAAmt: Decimal;
        PBAmt: Decimal;
        PCODAmt: Decimal;
        TaxAmt: Decimal;
        TempAmtText: Text;
        DecimalConv: Decimal;
        tempdatevar: Text;
        FromDate: Date;
        ToDate: Date;
        AFAmt1: Text;
        AFlAmt1: Text;
        CSAFAmt1: Text;
        CSAFlAmt1: Text;
        EmpAmt1: Text;
        LnAmt1: Text;
        PAAmt1: Text;
        PBAmt1: Text;
        PCODAmt1: Text;
        TaxAmt1: Text;
        TotalAmt1: Text;
        AF: Label 'Admin Fixed';
        AFl: Label 'Admin Flexible';
        CSAF: Label 'CS Admin Fixed';
        CSAFl: Label 'CS Admin Flexible';
        Emp: Label 'Employee';
        Ln: Label 'Loan';
        PA: Label 'Purchase Advance';
        PB: Label 'Purchase Bills';
        PCOD: Label 'Purchase COD';
        Tax: Label 'Tax';
        Total: Label 'Total';
        SubTot: Text;
        SQLQueryTotals: Text;
        recCount: Integer;
        Cust: Record Customer;
        UnitPrice: Decimal;
        TotalPrice: Decimal;
    begin
        //Daily Transactions report
        totalsales := 0;
        totalreceivedamts := 0;
        totalpayments := 0;
        //"g/l setup".GET;
        IF DATE2DWY("Daily Entrires Posting Date", 1) <> 1 THEN
            //FromDate:="Daily Entrires Posting Date"
            FromDate := "Daily Entrires Posting Date" - 1
        ELSE
            //FromDate:="Daily Entrires Posting Date"-1;
            FromDate := "Daily Entrires Posting Date" - 2;
        //EVALUATE(FromDate,'11-01-2016');
        //fromdate:="Daily Entrires Posting Date";
        SIH.RESET;
        SIH.SETRANGE(SIH."Posting Date", FromDate, FromDate);
        IF SIH.FINDSET THEN
            REPEAT
                IF ((SIH."Currency Factor" <> 0) AND (SIH."Currency Code" <> ''))//added on 01-04-18
                    THEN BEGIN
                    SIH.CALCFIELDS(SIH."Total Invoiced Amount");
                    totalsales := totalsales + SIH."Total Invoiced Amount";
                    totalsales := totalsales / SIH."Currency Factor"  //added on 01-04-18
                END
                ELSE BEGIN
                    SIH.CALCFIELDS(SIH."Total Invoiced Amount");
                    totalsales := totalsales + SIH."Total Invoiced Amount";
                END

            UNTIL SIH.NEXT = 0;
        S1 := formataddress.ChangeCurrency(totalsales);
        CLE.RESET;
        CLE.SETFILTER(CLE."Amount (LCY)", '<%1', 0);
        CLE.SETRANGE(CLE."Posting Date", FromDate, FromDate);
        IF CLE.FINDSET THEN
            REPEAT
                CLE.CALCFIELDS(CLE."Amount (LCY)");
                totalreceivedamts := totalreceivedamts + ABS(CLE."Amount (LCY)");
            UNTIL CLE.NEXT = 0;
        S2 := formataddress.ChangeCurrency(totalreceivedamts);
        VLE.RESET;
        VLE.SETFILTER(VLE."Amount (LCY)", '>%1', 0);
        VLE.SETRANGE(VLE."Posting Date", FromDate, FromDate);
        IF VLE.FINDSET THEN
            REPEAT
                VLE.CALCFIELDS(VLE."Amount (LCY)");
                totalpayments := totalpayments + VLE."Amount (LCY)";
            UNTIL VLE.NEXT = 0;
        S3 := formataddress.ChangeCurrency(ROUND(totalpayments, 1));
        SIH.RESET;
        SIH.SETRANGE(SIH."Posting Date", FromDate, FromDate);
        IF SIH.FINDFIRST THEN BEGIN
            REPORT.RUN(50018, FALSE, FALSE, SIH);
            REPORT.SAVEASPDF(50018, '\\erpserver\ERPattachments\salestrans.PDF', SIH);
            Attachment1 := '\\erpserver\erpattachments\salestrans.PDF';
        END ELSE
            Attachment1 := '';
        CLE.RESET;
        CLE.SETFILTER(CLE."Amount (LCY)", '<%1', 0);
        CLE.SETRANGE(CLE."Posting Date", FromDate, FromDate);
        IF CLE.FINDFIRST THEN BEGIN
            REPORT.RUN(50019, FALSE, FALSE, CLE);
            REPORT.SAVEASPDF(50019, '\\erpserver\ErpAttachments\custpayments.PDF', CLE);
            attachment13 := '\\erpserver\ERPattachments\custpayments.PDF';
        END ELSE
            attachment13 := '';
        VLE.RESET;
        VLE.SETFILTER(VLE."Amount (LCY)", '>%1', 0);
        VLE.SETRANGE(VLE."Posting Date", FromDate, FromDate);
        IF VLE.FINDFIRST THEN BEGIN
            REPORT.RUN(50020, FALSE, FALSE, VLE);
            REPORT.SAVEASPDF(50020, '\\erpserver\ERPattachments\vendorpayments.PDF', VLE);
            attachment14 := '\\erpserver\ERPattachments\vendorpayments.PDF';
        END ELSE
            attachment14 := '';

        /*
        IF DATE2DWY("Daily Entrires Posting Date",1)<>1 THEN
          FromDate:="Daily Entrires Posting Date"-1
        ELSE
          FromDate:="Daily Entrires Posting Date"-2;
        */
        //fromdate:="Daily Entrires Posting Date";
        totalsales1 := 0;
        installationamts := 0;
        amc := 0;
        boi := 0;
        str := 'IN';
        str1 := 'SI';
        str2 := 'CI';
        ExciseCollected := 0;
        pos := 0;
        pos1 := 0;
        pos2 := 0;
        SIH.RESET;
        SIH.SETRANGE(SIH."Posting Date", DMY2Date(04, 01, 18), FromDate);  //need to update every year
        IF SIH.FINDSET THEN
            REPEAT
                IF ((SIH."Currency Factor" <> 0) AND (SIH."Currency Code" <> ''))//added on 01-04-18
                THEN BEGIN
                    IF (SIH."Sell-to Customer No." <> 'CUST00536') THEN BEGIN
                        SIH.CALCFIELDS(SIH."Total Invoiced Amount");
                        totalsales1 := totalsales1 + ((SIH."Total Invoiced Amount" / 10000000) / SIH."Currency Factor");

                        pos := STRPOS(SIH."External Document No.", str);
                        pos1 := STRPOS(SIH."External Document No.", str1);
                        pos2 := STRPOS(SIH."External Document No.", str2);
                        IF pos <> 0 THEN
                            installationamts := installationamts + ((SIH."Total Invoiced Amount" / 10000000) / SIH."Currency Factor");

                        IF pos1 <> 0 THEN
                            amc := amc + ((SIH."Total Invoiced Amount" / 10000000) / SIH."Currency Factor");

                        IF pos2 <> 0 THEN
                            boi := boi + ((SIH."Total Invoiced Amount" / 10000000) / SIH."Currency Factor");

                        month := DATE2DMY(SIH."Posting Date", 2);
                        IF month = 3 THEN BEGIN
                            SIH.CALCFIELDS(SIH."Total Excise Amount");
                            ExciseCollected := ExciseCollected + ((SIH."Total Excise Amount" / 10000000) / SIH."Currency Factor");

                        END;
                    END;
                END
                ELSE BEGIN
                    IF (SIH."Sell-to Customer No." <> 'CUST00536') THEN BEGIN
                        SIH.CALCFIELDS(SIH."Total Invoiced Amount");
                        totalsales1 := totalsales1 + SIH."Total Invoiced Amount" / 10000000;
                        pos := STRPOS(SIH."External Document No.", str);
                        pos1 := STRPOS(SIH."External Document No.", str1);
                        pos2 := STRPOS(SIH."External Document No.", str2);
                        IF pos <> 0 THEN
                            installationamts := installationamts + SIH."Total Invoiced Amount" / 10000000;
                        IF pos1 <> 0 THEN
                            amc := amc + SIH."Total Invoiced Amount" / 10000000;
                        IF pos2 <> 0 THEN
                            boi := boi + SIH."Total Invoiced Amount" / 10000000;
                        month := DATE2DMY(SIH."Posting Date", 2);
                        IF month = 3 THEN BEGIN
                            SIH.CALCFIELDS(SIH."Total Excise Amount");
                            ExciseCollected := ExciseCollected + SIH."Total Excise Amount" / 10000000;
                        END;
                    END;
                END;
                pos := 0;
                pos1 := 0;
                pos2 := 0;
            UNTIL SIH.NEXT = 0;

        actsales := totalsales1 - installationamts - amc - boi;

        Mail_From := 'noreply@efftronics.com';
        //Mail_To:='ceo@efftronics.com,anvesh@efftronics.com,spurthi@efftronics.com,erp@efftronics.com,mk@effe.in,cuspm@efftronics.com,committee@efftronics.com,sales@efftronics.com,anilkumar@efftronics.com';//dir
        //Mail_To := 'erp@efftronics.com,sujani@efftronics.com';                //B2BUPG
        Recipients.Add('erp@efftronics.com');
        Recipients.Add('sujani@efftronics.com');
        Subject := 'Reg: ERP - Transaction Details as on ' + FORMAT(FromDate);       //need to update every year
        //SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);  //B2BUPG
        EmailMessage.Create(Recipients, Subject, Body, true);
        Body += ('<html><head><style> divone{background-color: white; width: 900px; padding: 20px; border-style:solid ; border-color:#8EB52B;  margin: 20px;} </style></head>');
        Body += ('<body><div style="border-color:#8EB52B;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 800px;"><label><font size="5">Consolidate Sales & AMC Transactions Summary of 18-19 Year</font></label>');
        Body += ('<hr style=solid; color= #3333CC>');
        Body += ('<h3><center>' + FORMAT(FromDate, 0, '<Day>-<Month Text,3>-<Year4>') + ' Transactions');
        Body += ('</center></h3>');
        Body += ('<table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"');
        Body += ('border="1" align="Center">');
        Body += ('<tr><td>Sales</td><td align="right">' + S1 + '</td></tr>');
        Body += ('<tr><td>Received</td><td align="right">' + S2 + '</td></tr>');
        Body += ('<tr><td>Paid</td><td align="right">' + S3 + '</td></tr></table>');
        Body += ('<h3><center>Sales Transactions(Amount in Crores) as on ' + FORMAT(FromDate, 0, '<Day>-<Month Text,3>-<Year4>'));
        Body += ('</center></h3>');
        Body += ('<table style="WIDTH:400px; HEIGHT: 10px; FONT-WEIGHT: bold"');
        Body += ('border="1" align="Center">');
        Body += ('<tr><td>Excise Sales</td><td align="right">' + FORMAT(ROUND(actsales)) + '</td></tr>');
        Body += ('<tr><td>Trading Items Sales</td><td align="right">' + FORMAT(ROUND(boi)) + '</td></tr>');
        Body += ('<tr><td bgcolor="#CCFFCC">Sales Turnover</td><td bgcolor="#CCFFCC" align="right">' + FORMAT(ROUND(boi + actsales)));
        Body += ('</td></tr><tr><td>Installation</td><td align="right">' + FORMAT(ROUND(installationamts)) + '</td></tr>');//
        Body += ('<tr><td>AMC</td><td align="right">' + FORMAT(ROUND(amc)) + '</td></tr>');
        Body += ('<tr><td bgcolor="#CCFFCC">Installa&AMC Totals</td><td bgcolor="#CCFFCC" align="right">');
        Body += (FORMAT(ROUND(amc + installationamts)) + '</td></tr>');
        Body += ('<tr><td bgcolor="#F0B4BC">Total</td><td bgcolor="#F0B4BC" align="right">' + FORMAT(ROUND(totalsales1)) + '</td></tr>');
        Body += ('</table><br><br>');
        //Initialization start
        RowCount := 0;
        SQLQuery := '';
        prevdate := '';
        Mail_count := 0;
        Body := '';
        AFAmt := 0;
        AFlAmt := 0;
        CSAFAmt := 0;
        CSAFlAmt := 0;
        EmpAmt := 0;
        LnAmt := 0;
        PAAmt := 0;
        PBAmt := 0;
        PCODAmt := 0;
        TaxAmt := 0;
        AFAmt1 := '';
        AFlAmt1 := '';
        CSAFAmt1 := '';
        CSAFlAmt1 := '';
        EmpAmt1 := '';
        LnAmt1 := '';
        PAAmt1 := '';
        PBAmt1 := '';
        PCODAmt1 := '';
        TaxAmt1 := '';

        //FromDate := CALCDATE('-1D',TODAY);
        //Initializations end

        /* IF ISCLEAR(SQLConnection) THEN
             CREATE(SQLConnection, FALSE, TRUE);

         IF ISCLEAR(RecordSet) THEN
             CREATE(RecordSet, FALSE, TRUE);

         IF ConnectionOpen <> 1 THEN BEGIN
             SQLConnection.ConnectionString := 'DSN=CASHFLOW;UID=cashflowuser;PASSWORD=firewall123;SERVER=oracle_80;';
             SQLConnection.Open;
             SQLConnection.BeginTrans;
             ConnectionOpen := 1;
         END;*/
        SQLQuery :=
        'select authdate,type,person,reason,orderno,INFAVOUROF,to_char(amount, ''99,99,99,99,990'') as amount1,authperson,authpersonname from ' +
        '(select a.authdate,a.authperson,a.orderno,a.amount,a.reason,a.INFAVOUROF,a.person,a.type,b.generalname authpersonname from ' +
        '(select trunc(pb.authdate) authdate,pb.authperson,pb.orderno,pb.amount,pb.reason,pb.INFAVOUROF,Vendr.name person,''Purchase Advance'' type from V_PURCHASE_ADVANCE pb ' +
        'left outer join (select distinct orderno,vendorid from PURCHASE_LINE) PL on (pb.orderno = PL.orderno) left outer join MRP_ERP_VENDOR Vendr on (PL.vendorid = Vendr.vendor_id) ' +
        'where (pb.authdate is not null) ' +
        'union ' +
        'select trunc(pb.authdate) authdate,pb.authperson,pb.orderno,pb.amount,pb.reason,pb.INFAVOUROF,Vendr.name person,''Purchase Bills'' type from V_PURCHASE_BILLS pb ' +
        'left outer join (select distinct orderno,vendorid from PURCHASE_LINE) PL on (pb.orderno = PL.orderno) left outer join MRP_ERP_VENDOR Vendr on (PL.vendorid = Vendr.vendor_id) ' +
        'where (pb.authdate is not null) ';
        SQLQuery1 :=
        'union ' +
        'select trunc(pb.authdate) authdate,pb.authperson,pb.orderno,pb.amount,pb.reason,pb.INFAVOUROF,Vendr.name person,''Purchase COD'' type  from V_PURCHASE_COD pb ' +
        'left outer join (select distinct orderno,vendorid from PURCHASE_LINE) PL on (pb.orderno = PL.orderno) left outer join MRP_ERP_VENDOR Vendr on (PL.vendorid = Vendr.vendor_id) ' +
        'where (pb.authdate is not null) ' +
        'union ' +
        'select trunc(authdate) authdate,authperson,''-'' orderno,budget_amount amount,reason,INFAVOUROF,expense_name person,''Admin Fixed'' type from MRP_EXPENSE ' +
        'where authdate is not null and upper(trim(group_id))=upper(''Admin'') and upper(trim(PAY_TYPE)) = upper(''fixed'') ' +
        'union ' +
        'select trunc(authdate) authdate,authperson,''-'' orderno,budget_amount amount,reason,INFAVOUROF,expense_name person,''CS Admin Fixed'' type from MRP_EXPENSE ' +
        'where authdate is not null and upper(trim(group_id))=upper(''csAdmin'') and upper(trim(PAY_TYPE)) = upper(''fixed'') ';

        SQLQuery2 :=
        'union ' +
        'select trunc(authdate) authdate,authperson,''-'' orderno,budget_amount amount,reason,INFAVOUROF,expense_name person,''Admin Flexible'' type from MRP_EXPENSE ' +
        'where authdate is not null and upper(trim(group_id))=upper(''Admin'') and upper(trim(PAY_TYPE)) = upper(''flexible'') ' +
        'union ' +
        'select trunc(authdate) authdate,authperson,''-'' orderno,budget_amount amount,reason,INFAVOUROF,expense_name person,''CS Admin Flexible'' type from MRP_EXPENSE ' +
        'where authdate is not null and upper(trim(group_id))=upper(''CSAdmin'') and upper(trim(PAY_TYPE)) = upper(''flexible'') ' +
        'union ' +
        'select trunc(authdate) authdate,authperson,''-'' orderno,budget_amount amount,reason,INFAVOUROF,expense_name person,''Tax'' type from MRP_EXPENSE ' +
        'where authdate is not null and upper(trim(group_id))=upper(''tax'') ';

        SQLQuery3 :=
        'union ' +
        'select trunc(authdate) authdate,authperson,''-'' orderno,budget_amount amount,reason,INFAVOUROF,expense_name person,''Loan'' type from MRP_EXPENSE ' +
        'where authdate is not null and upper(trim(group_id))=upper(''loan'') ' +
        'union ' +
        'select trunc(authdate) authdate,authperson,''-'' orderno,budget_amount amount,reason,INFAVOUROF,expense_name person,''Employee'' type from MRP_EXPENSE ' +
        'where authdate is not null and upper(trim(group_id))=upper(''employee'')) a,tams.v_emp_details b where a.authperson=b.ID_NO) ' +
        'where (authdate = to_date(''' + FORMAT(FromDate) + ''',''dd-mm-yy'')) order by authdate,type,amount ';

        SQLQueryTotals :=
        'select authdate,nvl(type,''Total'') type,to_char(sum(amount), ''99,99,99,99,990'') as amount1 from (select authdate,type,person,reason,orderno,INFAVOUROF,amount,authperson,authpersonname from ' +
        '(select a.authdate,a.authperson,a.orderno,a.amount,a.reason,a.INFAVOUROF,a.person,a.type,b.generalname authpersonname from ' +
        '(select trunc(pb.authdate) authdate,pb.authperson,pb.orderno,pb.amount,pb.reason,pb.INFAVOUROF,Vendr.name person,''Purchase Advance'' type from V_PURCHASE_ADVANCE pb ' +
        'left outer join (select distinct orderno,vendorid from PURCHASE_LINE) PL on (pb.orderno = PL.orderno) left outer join MRP_ERP_VENDOR Vendr on (PL.vendorid = Vendr.vendor_id) ' +
        'where (pb.authdate is not null) ' +
        'union ' +
        'select trunc(pb.authdate) authdate,pb.authperson,pb.orderno,pb.amount,pb.reason,pb.INFAVOUROF,Vendr.name person,''Purchase Bills'' type from V_PURCHASE_BILLS pb ' +
        'left outer join (select distinct orderno,vendorid from PURCHASE_LINE) PL on (pb.orderno = PL.orderno) left outer join MRP_ERP_VENDOR Vendr on (PL.vendorid = Vendr.vendor_id) ' +
        'where (pb.authdate is not null) ' +
        'union ' +
        'select trunc(pb.authdate) authdate,pb.authperson,pb.orderno,pb.amount,pb.reason,pb.INFAVOUROF,Vendr.name person,''Purchase COD'' type  from V_PURCHASE_COD pb ' +
        'left outer join (select distinct orderno,vendorid from PURCHASE_LINE) PL on (pb.orderno = PL.orderno) left outer join MRP_ERP_VENDOR Vendr on (PL.vendorid = Vendr.vendor_id) ' +
        'where (pb.authdate is not null) ' +
        'union ' +
        'select trunc(authdate) authdate,authperson,''-'' orderno,budget_amount amount,reason,INFAVOUROF,expense_name person,''Admin Fixed'' type from MRP_EXPENSE ' +
        'where authdate is not null and upper(trim(group_id))=upper(''Admin'') and upper(trim(PAY_TYPE)) = upper(''fixed'') ' +
        'union ' +
        'select trunc(authdate) authdate,authperson,''-'' orderno,budget_amount amount,reason,INFAVOUROF,expense_name person,''CS Admin Fixed'' type from MRP_EXPENSE ' +
        'where authdate is not null and upper(trim(group_id))=upper(''csAdmin'') and upper(trim(PAY_TYPE)) = upper(''fixed'') ' +
        'union ' +
        'select trunc(authdate) authdate,authperson,''-'' orderno,budget_amount amount,reason,INFAVOUROF,expense_name person,''Admin Flexible'' type from MRP_EXPENSE ' +
        'where authdate is not null and upper(trim(group_id))=upper(''Admin'') and upper(trim(PAY_TYPE)) = upper(''flexible'') ' +
        'union ' +
        'select trunc(authdate) authdate,authperson,''-'' orderno,budget_amount amount,reason,INFAVOUROF,expense_name person,''CS Admin Flexible'' type from MRP_EXPENSE ' +
        'where authdate is not null and upper(trim(group_id))=upper(''CSAdmin'') and upper(trim(PAY_TYPE)) = upper(''flexible'') ' +
        'union ' +
        'select trunc(authdate) authdate,authperson,''-'' orderno,budget_amount amount,reason,INFAVOUROF,expense_name person,''Tax'' type from MRP_EXPENSE ' +
        'where authdate is not null and upper(trim(group_id))=upper(''tax'') ' +
        'union ' +
        'select trunc(authdate) authdate,authperson,''-'' orderno,budget_amount amount,reason,INFAVOUROF,expense_name person,''Loan'' type from MRP_EXPENSE ' +
        'where authdate is not null and upper(trim(group_id))=upper(''loan'') ' +
        'union ' +
        'select trunc(authdate) authdate,authperson,''-'' orderno,budget_amount amount,reason,INFAVOUROF,expense_name person,''Employee'' type from MRP_EXPENSE ' +
        'where authdate is not null and upper(trim(group_id))=upper(''employee'')) a,tams.v_emp_details b where a.authperson=b.ID_NO) ' +
        'where (authdate = to_date(''' + FORMAT(FromDate) + ''',''dd-mm-yy'')) order by authdate,type,amount) group by rollup(authdate,type) order by 1,2 ';

        //>> ORACLE UPG
        /* RecordSet := SQLConnection.Execute(SQLQuery + SQLQuery1 + SQLQuery2 + SQLQuery3, RowCount);
        RecordSet1 := SQLConnection.Execute(SQLQuery + SQLQuery1 + SQLQuery2 + SQLQuery3, RowCount1);
        RecordSet2 := SQLConnection.Execute(SQLQueryTotals, RowCount2);
        IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN BEGIN
            RecordSet.MoveFirst;
            RowCount := 0;
        END;
        IF NOT ((RecordSet1.BOF) OR (RecordSet1.EOF)) THEN BEGIN
            RecordSet1.MoveFirst;
            RowCount1 := 0;
        END;
        IF NOT ((RecordSet2.BOF) OR (RecordSet2.EOF)) THEN BEGIN
            RecordSet2.MoveFirst;
            RowCount2 := 0;
        END;
        WHILE NOT RecordSet2.EOF DO BEGIN
            CASE FORMAT(RecordSet2.Fields.Item('TYPE').Value) OF
                AF:
                    BEGIN
                        AFAmt1 := RecordSet2.Fields.Item('amount1').Value;
                    END;
                AFl:
                    BEGIN
                        AFlAmt1 := RecordSet2.Fields.Item('amount1').Value;
                    END;
                CSAF:
                    BEGIN
                        CSAFAmt1 := RecordSet2.Fields.Item('amount1').Value;
                    END;
                CSAFl:
                    BEGIN
                        CSAFlAmt1 := RecordSet2.Fields.Item('amount1').Value;
                    END;
                Emp:
                    BEGIN
                        EmpAmt1 := RecordSet2.Fields.Item('amount1').Value;
                    END;
                Ln:
                    BEGIN
                        LnAmt1 := RecordSet2.Fields.Item('amount1').Value;
                    END;
                PA:
                    BEGIN
                        PAAmt1 := RecordSet2.Fields.Item('amount1').Value;
                    END;
                PB:
                    BEGIN
                        PBAmt1 := RecordSet2.Fields.Item('amount1').Value;
                    END;
                PCOD:
                    BEGIN
                        PCODAmt1 := RecordSet2.Fields.Item('amount1').Value;
                    END;
                Tax:
                    BEGIN
                        TaxAmt1 := RecordSet2.Fields.Item('amount1').Value;
                    END;
                Total:
                    BEGIN
                        TotalAmt1 := RecordSet2.Fields.Item('amount1').Value;
                    END;
            END;
            RowCount2 := RowCount2 + 1;
            RecordSet2.MoveNext;
        END;
        WHILE NOT RecordSet1.EOF DO BEGIN
            CASE FORMAT(RecordSet1.Fields.Item('TYPE').Value) OF
                AF:
                    BEGIN
                        AFAmt := AFAmt + 1;
                    END;
                AFl:
                    BEGIN
                        AFlAmt := AFlAmt + 1;
                    END;
                CSAF:
                    BEGIN
                        CSAFAmt := CSAFAmt + 1;
                    END;
                CSAFl:
                    BEGIN
                        CSAFlAmt := CSAFlAmt + 1;
                    END;
                Emp:
                    BEGIN
                        EmpAmt := EmpAmt + 1;
                    END;
                Ln:
                    BEGIN
                        LnAmt := LnAmt + 1;
                    END;
                PA:
                    BEGIN
                        PAAmt := PAAmt + 1;
                    END;
                PB:
                    BEGIN
                        PBAmt := PBAmt + 1;
                    END;
                PCOD:
                    BEGIN
                        PCODAmt := PCODAmt + 1;
                    END;
                Tax:
                    BEGIN
                        TaxAmt := TaxAmt + 1;
                    END;
            END;
            RowCount1 := RowCount1 + 1;
            RecordSet1.MoveNext;
        END;
        //MESSAGE(FORMAT(AFAmt)+'\'+FORMAT(AFlAmt)+'\'+FORMAT(CSAFAmt)+'\'+FORMAT(CSAFlAmt)+'\'+FORMAT(EmpAmt)+'\'+FORMAT(LnAmt)+'\'+FORMAT(PAAmt)+'\'+FORMAT(PBAmt)+'\'+FORMAT(PCODAmt)+'\'+FORMAT(TaxAmt));
        IF (AFAmt > 0) OR (AFlAmt > 0) OR (CSAFAmt > 0) OR (CSAFlAmt > 0) OR (EmpAmt > 0) OR (LnAmt > 0) OR (PAAmt > 0) OR (PBAmt > 0) OR (PCODAmt > 0) OR (TaxAmt > 0) THEN BEGIN
            Body += ('<br><label><font size="5">Cashflow Authorized Amount Details</font></label>');
            Body += ('<hr style=solid; color= #3333CC>');
            Body += ('<P> CashFlow Authorized Amounts on <b>' + FORMAT(FromDate) + ': </b></P>');
            Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Head Type</th><th>Person</th><th>Reason</th><th>In Favour Of</th>');
            Body += ('<th>Authorized Person</th><th>Amount</th></tr>');
            WHILE NOT RecordSet.EOF DO BEGIN
                IF (PrevRec <> FORMAT(RecordSet.Fields.Item('type').Value)) THEN BEGIN
                    IF PrevRec <> '' THEN BEGIN
                        CASE PrevRec OF
                            AF:
                                BEGIN
                                    SubTot := AFAmt1;
                                END;
                            AFl:
                                BEGIN
                                    SubTot := AFlAmt1;
                                END;
                            CSAF:
                                BEGIN
                                    SubTot := CSAFAmt1;
                                END;
                            CSAFl:
                                BEGIN
                                    SubTot := CSAFlAmt1;
                                END;
                            Emp:
                                BEGIN
                                    SubTot := EmpAmt1;
                                END;
                            Ln:
                                BEGIN
                                    SubTot := LnAmt1;
                                END;
                            PA:
                                BEGIN
                                    SubTot := PAAmt1;
                                END;
                            PB:
                                BEGIN
                                    SubTot := PBAmt1;
                                END;
                            PCOD:
                                BEGIN
                                    SubTot := PCODAmt1;
                                END;
                            Tax:
                                BEGIN
                                    SubTot := TaxAmt1;
                                END;
                        END;  //CASE_PREVREC END
                        Body += ('<tr><td colspan="5" align="center" style="color:#FF0000"><b>' + PrevRec + ' Total </b></td><td align="right" style="color:#FF0000"><b>' + FORMAT(SubTot) + '</b></td></tr>');
                    END;  //IF_PrvRec<>'' end
                    CASE FORMAT(RecordSet.Fields.Item('TYPE').Value) OF
                        AF:
                            BEGIN
                                RowSpn := AFAmt;
                            END;
                        AFl:
                            BEGIN
                                RowSpn := AFlAmt;
                            END;
                        CSAF:
                            BEGIN
                                RowSpn := CSAFAmt;
                            END;
                        CSAFl:
                            BEGIN
                                RowSpn := CSAFlAmt;
                            END;
                        Emp:
                            BEGIN
                                RowSpn := EmpAmt;
                            END;
                        Ln:
                            BEGIN
                                RowSpn := LnAmt;
                            END;
                        PA:
                            BEGIN
                                RowSpn := PAAmt;
                            END;
                        PB:
                            BEGIN
                                RowSpn := PBAmt;
                            END;
                        PCOD:
                            BEGIN
                                RowSpn := PCODAmt;
                            END;
                        Tax:
                            BEGIN
                                RowSpn := TaxAmt;
                            END;
                    END;
                    Body += ('<tr><td rowspan = "' + FORMAT(RowSpn) + '">' + FORMAT(RecordSet.Fields.Item('type').Value) + '</td><td>' + FORMAT(RecordSet.Fields.Item('person').Value) + '</td><td>' + FORMAT(RecordSet.Fields.Item('reason').Value) + '</td>');
                    Body += ('<td>' + FORMAT(RecordSet.Fields.Item('infavourof').Value) + '</td><td>' + FORMAT(RecordSet.Fields.Item('authpersonname').Value) + '</td><td align ="right">' + FORMAT(RecordSet.Fields.Item('amount1').Value) + '</td></tr>');
                END
                ELSE BEGIN
                    Body += ('<tr><td>' + FORMAT(RecordSet.Fields.Item('person').Value) + '</td><td>' + FORMAT(RecordSet.Fields.Item('reason').Value) + '</td>');
                    Body += ('<td>' + FORMAT(RecordSet.Fields.Item('infavourof').Value) + '</td><td>' + FORMAT(RecordSet.Fields.Item('authpersonname').Value) + '</td><td align ="right">' + FORMAT(RecordSet.Fields.Item('amount1').Value) + '</td></tr>');
                END;
                DecimalConv := 0;
                TempAmtText := '';
                TempAmtText := FORMAT(RecordSet.Fields.Item('amount1').Value);
                EVALUATE(DecimalConv, TempAmtText);
                PrevRec := FORMAT(RecordSet.Fields.Item('type').Value);
                Mail_count += 1;
                RowCount := RowCount + 1;
                RecordSet.MoveNext;
            END;
            CASE PrevRec OF
                AF:
                    BEGIN
                        SubTot := AFAmt1;
                    END;
                AFl:
                    BEGIN
                        SubTot := AFlAmt1;
                    END;
                CSAF:
                    BEGIN
                        SubTot := CSAFAmt1;
                    END;
                CSAFl:
                    BEGIN
                        SubTot := CSAFlAmt1;
                    END;
                Emp:
                    BEGIN
                        SubTot := EmpAmt1;
                    END;
                Ln:
                    BEGIN
                        SubTot := LnAmt1;
                    END;
                PA:
                    BEGIN
                        SubTot := PAAmt1;
                    END;
                PB:
                    BEGIN
                        SubTot := PBAmt1;
                    END;
                PCOD:
                    BEGIN
                        SubTot := PCODAmt1;
                    END;
                Tax:
                    BEGIN
                        SubTot := TaxAmt1;
                    END;
            END;  //CASE_PREVREC END
            Body += ('<tr><td colspan="5" align="center" style="color:#FF0000"><b>' + PrevRec + ' Total </b></td><td align="right" style="color:#FF0000"><b>' + FORMAT(SubTot) + '</b></td></tr>');
            Body += ('<tr><td colspan="5" align="center" style="color:#FF0000"><b> Day Total Authorized Amount  </b></td><td align="right" style="color:#FF0000"><b>' + FORMAT(TotalAmt1) + '</b></td></tr>');
            Body += ('</table><br>');
            Body += ('<br>Click <a href="http://erpserver:8080/ReportMGR/Pages/Report.aspx?ItemPath=%2fCashFlow+Authorisation+Report%2fAuthorisations"><b>here</b></a> to view the detailed report for about <b>1 Month</b>');
        END;
        // Added by Rakesh on 24-Nov-14 for automail when Shoratge is not run for more than 1 week
        //IF ISCLEAR(SQLConnection1) THEN
            //CREATE(SQLConnection1, FALSE, TRUE);
        //IF ISCLEAR(RecordSet) THEN
            //CREATE(RecordSet, FALSE, TRUE);//B2BUPG
        SQLConnection1.ConnectionString := 'DSN=salinvoiceuser;UID=salinvoiceuser;PASSWORD=salinvoiceuser;SERVER=oracle_80;';
        SQLConnection1.Open;
        SQLQuery := 'SELECT MAX(SYS_DATE) Auth_Date from SHORTAGE_AUT  order by 1';
        RecordSet := SQLConnection1.Execute(SQLQuery);
        IF NOT (RecordSet.EOF OR RecordSet.BOF) THEN BEGIN
            "Auth Date" := RecordSet.Fields.Item('Auth_date').Value;
            IF (TODAY - DT2DATE("Auth Date")) > 4 THEN         // Modified for 3 days
            BEGIN
                Body += ('<br><br><label><font size="5">Delay in Shoratge Procurement Process</font></label>');
                Body += ('<hr style=solid; color= #3333CC>');
                Body += ('<P>There has been a delay about more 3 days of Shortage Material Procurement process.<br>The last Shortage was executed on ' + FORMAT("Auth Date") + '.<br></P>');
                Body += ('So Kindly execute the Shortage process.<br>');
            END;
            SQLConnection1.Close;
        END ELSE BEGIN
            SQLConnection1.Close;
            ERROR('There was error while extracting Date while Shortage Delay');
        END; */
        //<< ORACLE UPG

        // End by Rakesh
        // Added by Rakesh to mail the pending QA items along on 26-Dec-2014
        Pending_QAG := 0;
        Pending_QA10 := 0;
        Pending_QA5 := 0;
        IDS.RESET;
        IDS.SETRANGE(IDS."Source Type", IDS."Source Type"::"In Bound");

        IF IDS.FINDSET THEN
            REPEAT
                IF (TODAY - DT2DATE(IDS."Creation DateTime")) > 10 THEN
                    Pending_QAG += 1
                ELSE
                    IF (TODAY - DT2DATE(IDS."Creation DateTime")) > 5 THEN
                        Pending_QA10 += 1
                    ELSE
                        IF (TODAY - DT2DATE(IDS."Creation DateTime")) >= 2 THEN
                            Pending_QA5 += 1;
            UNTIL IDS.NEXT = 0;

        IF ((Pending_QA5 > 0) OR (Pending_QA10 > 0) OR (Pending_QAG > 0)) THEN BEGIN
            Body += ('<br><br><label><font size="5">QA Inward Pending Items</font></label>');
            Body += ('<hr style=solid; color= ##3333CC>');
            Body += ('<P> The below table represents the pending Items at the QA Inward.</P>');
            Body += ('<table border="1" style="border-collapse:collapse; width:60%; font-size:12pt;"><tr><th align="left"><font color="brown">Period</font></th><th>2-5 Days</th><th>6-10 Days</th><th>>10 Days</th></tr>');
            Body += ('<tr><td><b><font color="brown">Pending Items</font></b></td><td align="right">' + FORMAT(Pending_QA5) + '</td><td align="right">' + FORMAT(Pending_QA10) + '</td><td align="right">' + FORMAT(Pending_QAG) + '</td></tr>');
            Body += ('</table><br>');
            Body += ('<br>Click <a href="http://intranet:8080/QCReport/QASReport.aspx"><b>here</b></a> to view the QA Report');
        END;
        // End by Rakesh
        // Added by Rakesh for automail for Pending Purchase Orders on 12-Dec-14
        IF EVALUATE(PODateVar, '31-03-2015') = TRUE THEN BEGIN
            Mail_count := 0;
            PurchaseHeader.RESET;
            PurchaseHeader.SETRANGE(PurchaseHeader."Document Type", PurchaseHeader."Document Type"::Order);
            PurchaseHeader.SETFILTER(PurchaseHeader."Order Date", '>%1', PODateVar);
            PurchaseHeader.SETFILTER(PurchaseHeader.Mail_count, '%1', 0);
            IF PurchaseHeader.FINDSET THEN
                REPEAT
                    IF (TODAY - PurchaseHeader."Order Date") > 2 THEN BEGIN
                        Mail_count += 1;
                    END;
                UNTIL PurchaseHeader.NEXT = 0;
            IF Mail_count > 0 THEN BEGIN
                Body += ('<br><br><br><label><font size="5">Pending Purchase Orders</font></label>');
                Body += ('<hr style=solid; color= #3333CC>');
                Body += ('<h><b>Responsible Dept: <font color=red>Purchase.</font></h><br>');
                Body += ('<h>Action: <font color=red>Need to forward PO to vendors.</font></b></h><br>');
                Body += ('<P> The below Purchase Orders have been created and order is pending, </P>');
                Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Order No.</th><th>Vendor</th><th>Order Date</th><th>Pending Days</th></tr>');
                PurchaseHeader.RESET;
                PurchaseHeader.SETRANGE(PurchaseHeader."Document Type", PurchaseHeader."Document Type"::Order);
                PurchaseHeader.SETFILTER(PurchaseHeader."Order Date", '>%1', PODateVar);
                PurchaseHeader.SETFILTER(PurchaseHeader.Mail_count, '%1', 0);
                IF PurchaseHeader.FINDSET THEN
                    REPEAT
                        IF (TODAY - PurchaseHeader."Order Date") > 2 THEN BEGIN
                            Body += ('<tr><td>' + PurchaseHeader."No." + '</td><td>' + PurchaseHeader."Buy-from Vendor Name" + '</td><td>' + FORMAT(PurchaseHeader."Order Date") + '</td><td align="center">' + FORMAT(TODAY - PurchaseHeader."Order Date") + '</td></tr>');
                        END;
                    UNTIL PurchaseHeader.NEXT = 0;
                Body += ('</table><br>');
                Body += ('<br>Click <a href="http://erpserver:8080/SSRSReports/Pages/ReportViewer.aspx?%2fPurchase_order_details%2fPur_Pending_Mail&rs:Command=Render"><b>here</b></a> to view the Pending Purchase Orders Report');
            END;
        END
        ELSE
            ERROR('date format error');
        // end by Rakesh
        //Added by Pranavi on 11-Jan-2016 to add billing deviated amc orders
        recCount := 0;
        TotalPrice := 0;
        UnitPrice := 0;
        SL.RESET;
        SL.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
        // SL.SETFILTER(SL."Document Type", '%1', SL."Document Type"::Amc);
        SL.SETFILTER(SL.SaleDocType, '%1', SL.SaleDocType::Amc);//EFFUPG1.5
        SL.SETFILTER(SL."Outstanding Quantity", '>%1', 0);
        SL.SETFILTER(SL."Shipment Date", '<%1', TODAY());
        IF SL.FINDSET THEN
            REPEAT
                recCount := recCount + 1;
            UNTIL SL.NEXT = 0;
        IF recCount > 0 THEN BEGIN
            Body += ('<br><br><br><label><font size="5">Billing Deviated AMC Details</font></label>');
            Body += ('<hr style=solid; color= #3333CC>');
            Body += ('<P> The below are details of To Be Shipped AMCs, </P>');
            Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >AMC order No.</th><th >Customer</th>');
            Body += ('<th>Line No.</th><th>Item No.</th><th>Description</th><th>Shipement Date</th><th>Deviated Days</th><th>Amount</th></tr>');
            recCount := 0;
            SL.RESET;
            SL.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
            // SL.SETFILTER(SL."Document Type", '%1', SL."Document Type"::Amc);
            SL.SETFILTER(SL.SaleDocType, '%1', SL.SaleDocType::Amc);//EFFUPG1.5
            SL.SETFILTER(SL."Outstanding Quantity", '>%1', 0);
            SL.SETFILTER(SL."Shipment Date", '<%1', TODAY());
            IF SL.FINDSET THEN
                REPEAT
                    Cust.RESET;
                    Cust.GET(SL."Sell-to Customer No.");
                    UnitPrice := 0;
                    UnitPrice := SL."Unit Price";
                    Body += ('<tr><td>' + SL."Document No." + '</td><td>' + Cust.Name + '</td><td align = "right">' + FORMAT(SL."Line No.") + '</td><td align = "center">' + SL."No." + '</td>');
                    Body += ('<td>' + SL.Description + '</td><td align = "center">' + FORMAT(SL."Shipment Date", 0, '<Day,2>-<Month Text,3>-<Year>') + '</td><td align = "right">' + FORMAT(TODAY() - SL."Shipment Date"));
                    Body += ('</td><td align = "right">' + formataddress.ChangeCurrency(ROUND(UnitPrice)) + '</td></tr>');
                    recCount := recCount + 1;
                    TotalPrice += SL."Unit Price";
                UNTIL SL.NEXT = 0;
            Body += ('<tr><td colspan="7" align="center" style="color:#FF0000"><b>Total Amount</b></td><td align="right" style="color:#FF0000"><b>' + formataddress.ChangeCurrency(ROUND(TotalPrice)) + '</b></td></tr>');
            Body += ('</table><br>');
            Body += ('<p align ="left">Note:: Please clear the above orders</p>');
        END;
        //End by Pranavi
        Body += ('<p align ="left"> Regards,<br>ERP Team </p>');
        Body += ('<br><p align = "center">:: Note: Auto Generated mail from ERP :: </P></div></body></html>');
        //EFFUPG Start
        /*
        SMTP_MAIL.AddAttachment(Attachment1);
        SMTP_MAIL.AddAttachment(attachment13);
        SMTP_MAIL.AddAttachment(attachment14);
        */
        /* SMTP_MAIL.AddAttachment(Attachment1, '');
        SMTP_MAIL.AddAttachment(attachment13, '');
        SMTP_MAIL.AddAttachment(attachment14, ''); */           //B2BUPG

        EmailMessage.AddAttachment(Attachment1, '', '');
        EmailMessage.AddAttachment(attachment13, '', '');
        EmailMessage.AddAttachment(attachment14, '', '');

        //EFFUPG End
        //SMTP_MAIL.Send;  //B2BUPG
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

    end;

    procedure SalesChangesAlert();
    var
        CHLG: Record "Change Log Entry";
        SL: Record "Sales Line";
        SH: Record "Sales Header";
        SHA: Record "Sales Header Archive";
        pDate: DateTime;
        Todaytime: DateTime;
        previousOrder: Code[20];
        releasedflag: Boolean;
        SL1: Record "Sales Line";
        ChangeFlag: Boolean;
        TypeOfChange: Text[30];
        Fromdaytime: DateTime;
        itemNo: Code[30];
        Desc: Code[250];
        item: Record Item;
        GLAccnt: Record "G/L Account";
        User: Record User;
        username: Text;
        customer: Record Customer;
        custname: Text;
        recCount: Integer;
        headerdate: Date;
        modifyflag: Boolean;
        newflag: Boolean;
        OldCLStusVal: Code[10];
        NewCLStusVal: Code[10];
        OldPendingByVal: Code[10];
        NewPendingByVal: Code[10];
        modifyflag1: Boolean;
        tempPendingBy: Code[10];
        SCH: Record Schedule2;
        SchLine: Text;
        SIL: Record "Sales Invoice Line";
        LMD_Count: Integer;
        CustomCalendarChange: Array[2] of Record "Customized Calendar Change";//EFFUPG
    begin
        //MESSAGE('HI');
        LMD_Count := 0;
        Mail_From := 'erp@efftronics.com';
        //Mail_To := 'controlroom@efftronics.com,padmaja@efftronics.com,sales@efftronics.com,anilkumar@efftronics.com,erp@efftronics.com'; //B2BUPg
        Recipients.Add('controlroom@efftronics.com');
        Recipients.Add('padmaja@efftronics.com');
        Recipients.Add('sales@efftronics.com');
        Recipients.Add('anilkumar@efftronics.com');
        Recipients.Add('erp@efftronics.com');
        //Mail_To := 'pranavi@efftronics.com';
        //headerdate := CalMngmt.CalcDateBOC('-1D', TODAY(), 3, 'PROD', '', 3, 'PROD', '', FALSE);//EFFUPG
        CustomCalendarChange[1].SetSource(CustomCalendarChange[1]."Source Type"::"Location", 'PROD', '', '');//EFFUPG
        CustomCalendarChange[2].SetSource(CustomCalendarChange[2]."Source Type"::"Location", 'PROD', '', '');//EFFUPG
        headerdate := CalMngmt.CalcDateBOC('-1D', TODAY(), CustomCalendarChange, FALSE);//EFFUPG
                                                                                        //Added by pranavi on 27-jan-2016 to consider public holidays also
                                                                                        /*
                                                                                        IF DATE2DWY(TODAY(),1)<>1 THEN
                                                                                          headerdate := CALCDATE('-1D',TODAY())
                                                                                        ELSE
                                                                                          headerdate := CALCDATE('-2D',TODAY());
                                                                                        */ //commented by pranavi on 27-jan-2016 to consider public holidays also
        Subject := 'Reg: Sale Order Changes on ' + FORMAT(headerdate);
        Body := '';
        //SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);  //B2BUPG
        EmailMessage.Create(Recipients, Subject, Body, true);
        Body += ('<html><head><style> divone{background-color: white; width: 1200px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>');
        Body += ('<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 1100px;"><label><font size="6">Sale Order Changes Details</font></label>');
        Body += ('<hr style=solid; color= #3333CC>');
        Body += ('<h>Dear Sir/Madam,</h><br><br>');
        //Body += ('<h><b>Responsible Dept: <font color=red>Manufacturing.</b></font></h><br>');
        Body += ('<P> The below are details of Changes made in Sale Order on ' + FORMAT(headerdate) + ', </P>');
        //Body += ('<P> Order Modifications, </P>');
        //Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Sale order No.</th><th >Customer</th><th>Line No.</th><th>Item No.</th><th>Description</th><th>Type of Change</th>');
        //Body += ('<th>Changed Field</th><th>Previous Value</th><th>New Value</th><th>User ID</th><th>Time of Change</th></tr>');
        /*
        IF DATE2DWY(TODAY(),1)<>1 THEN
          Todaytime := CREATEDATETIME(CALCDATE('-1D',TODAY()),000000T)
        ELSE
          Todaytime := CREATEDATETIME(CALCDATE('-2D',TODAY()),000000T);
        */ //commented by pranavi on 27-jan-2016 to consider public holidays also
        Todaytime := CREATEDATETIME(CALCDATE('0D', headerdate), 000000T); //Added by pranavi on 27-jan-2016 to consider public holidays also
        Fromdaytime := CREATEDATETIME(CALCDATE('0D', TODAY()), 000000T);
        //MESSAGE(FORMAT(Todaytime));

        recCount := 0;
        modifyflag := FALSE;
        CHLG.RESET;
        CHLG.SETCURRENTKEY("Table No.", "Primary Key Field 2 Value", "Primary Key Field 3 Value", "Date and Time");
        CHLG.SETFILTER(CHLG."Table No.", '%1', 36);
        CHLG.SETFILTER(CHLG."Date and Time", '>=%1&<=%2', Todaytime, Fromdaytime);
        CHLG.SETFILTER(CHLG."Field No.", '%1', 60074);
        CHLG.SETFILTER(CHLG."Type of Change", '%1', 1);
        IF CHLG.FINDSET THEN
            REPEAT
                custname := '';
                ChangeFlag := FALSE;
                releasedflag := FALSE;
                SH.RESET;
                //SH.SETFILTER(SH."Document Type", '<>%1', SH."Document Type"::Amc);
                SH.SETFILTER(SaleDocType, '<>%1', SH.SaleDocType::Amc);//EFFUPG1.5
                SH.SETFILTER(SH."No.", CHLG."Primary Key Field 2 Value");
                SH.SETFILTER(SH."First Released Date Time", '<%1', CHLG."Date and Time");
                IF SH.FINDFIRST THEN BEGIN      // If Sales Header Rec Find
                    IF SH.Status <> SH.Status::Released THEN BEGIN
                        SHA.RESET;
                        // SHA.SETFILTER(SHA."Document Type", '<>%1', SHA."Document Type"::Amc);
                        SHA.SETFILTER(SaleDOCTYPE, '<>%1', SHA.SaleDocType::Amc);//EFFUPG1.5
                        SHA.SETFILTER(SHA."No.", CHLG."Primary Key Field 2 Value");
                        SHA.SETFILTER(SHA."First Released Date Time", '<%1', CHLG."Date and Time");
                        IF SHA.FINDFIRST THEN
                            releasedflag := TRUE;
                    END
                    ELSE
                        releasedflag := TRUE;
                    custname := '';
                    customer.RESET;
                    customer.SETFILTER(customer."No.", SH."Sell-to Customer No.");
                    IF customer.FINDFIRST THEN
                        custname := customer.Name;
                    IF releasedflag = TRUE THEN BEGIN   // If order released atleast onces
                        CASE CHLG."Old Value" OF
                            '0':
                                OldCLStusVal := ' ';
                            '1':
                                OldCLStusVal := 'Received';
                            '2':
                                OldCLStusVal := 'Pending';
                            '3':
                                OldCLStusVal := 'NA';
                        END;
                        CASE CHLG."New Value" OF
                            '0':
                                NewCLStusVal := ' ';
                            '1':
                                NewCLStusVal := 'Received';
                            '2':
                                NewCLStusVal := 'Pending';
                            '3':
                                NewCLStusVal := 'NA';
                        END;
                        User.RESET;
                        User.SETFILTER(User."User Name", CHLG."User ID");
                        IF User.FINDFIRST THEN
                            username := User."Full Name"
                        ELSE
                            username := CHLG."User ID";
                        IF modifyflag1 = FALSE THEN BEGIN
                            Body += ('<P> Order Modifications, </P>');
                            Body += ('<P> Call Letter Status Modifications, </P>');
                            Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Sale order No.</th><th >Customer</th><th>Type of Change</th>');
                            Body += ('<th>Previous Value</th><th>New Value</th><th>User ID</th><th>Time of Change</th></tr>');
                            modifyflag1 := TRUE;
                        END;
                        IF (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/L') OR (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/T') THEN
                            LMD_Count := 1;
                        Body += ('<tr><td>' + CHLG."Primary Key Field 2 Value" + '</td><td>' + custname + '</td><td>' + 'Call Letter Status Change' + '</td>');
                        Body += ('<td>' + OldCLStusVal + '</td><td>' + NewCLStusVal + '</td><td>' + username + '</td><td>' + FORMAT(CHLG."Date and Time") + '</td></tr>');
                        recCount := recCount + 1;
                    END;
                END;
            UNTIL CHLG.NEXT = 0;
        IF recCount > 0 THEN
            Body += ('</table><br>');
        releasedflag := FALSE;
        modifyflag := FALSE;
        custname := '';
        ChangeFlag := FALSE;
        CHLG.RESET;
        CHLG.SETCURRENTKEY("Table No.", "Primary Key Field 2 Value", "Primary Key Field 3 Value", "Date and Time");
        CHLG.SETFILTER(CHLG."Table No.", '%1|%2', 37, 60095);
        CHLG.SETFILTER(CHLG."Date and Time", '>=%1&<=%2', Todaytime, Fromdaytime);
        CHLG.SETFILTER(CHLG."Field No.", '%1|%2|%3|%4|%5|%6|%7', 6, 15, 80006, 5, 7, 60, 50002);
        //CHLG.SETFILTER(CHLG."Primary Key Field 3 Value",'<>%1','EFF/SAL/15-16/0229');
        IF CHLG.FINDSET THEN
            REPEAT
                custname := '';
                ChangeFlag := FALSE;
                releasedflag := FALSE;
                SH.RESET;
                //SH.SETFILTER(SH."Document Type", '<>%1', SH."Document Type"::Amc);
                SH.SETFILTER(SaleDocType, '<>%1', SH.SaleDocType::Amc);//EFFUPG1.5
                SH.SETFILTER(SH."No.", CHLG."Primary Key Field 2 Value");
                SH.SETFILTER(SH."First Released Date Time", '<%1', CHLG."Date and Time");
                IF SH.FINDFIRST THEN BEGIN      // If Sales Header Rec Find
                    IF SH.Status <> SH.Status::Released THEN BEGIN
                        SHA.RESET;
                        //SHA.SETFILTER(SHA."Document Type", '<>%1', SHA."Document Type"::Amc);
                        SHA.SETFILTER(SHA.SaleDocType, '<>%1', SHA.SaleDocType::Amc);//EFFUPG1.5
                        SHA.SETFILTER(SHA."No.", CHLG."Primary Key Field 2 Value");
                        SHA.SETFILTER(SHA."First Released Date Time", '<%1', CHLG."Date and Time");
                        IF SHA.FINDFIRST THEN
                            releasedflag := TRUE;
                    END
                    ELSE
                        releasedflag := TRUE;
                    custname := '';
                    customer.RESET;
                    customer.SETFILTER(customer."No.", SH."Sell-to Customer No.");
                    IF customer.FINDFIRST THEN
                        custname := customer.Name;
                    IF releasedflag = TRUE THEN BEGIN   // If order released atleast onces
                        IF (CHLG."Type of Change" = 1) AND (CHLG."Field No." = 60) AND (CHLG."Table No." = 37) THEN BEGIN   // if qty shipped change in sales lines
                            SL1.RESET;
                            SL1.SETFILTER(SL1."Document No.", CHLG."Primary Key Field 2 Value");
                            SL1.SETFILTER(SL1."Line No.", CHLG."Primary Key Field 3 Value");
                            IF SL1.FINDFIRST THEN
                                IF FORMAT(SL1."Quantity Shipped") = CHLG."New Value" THEN BEGIN
                                    item.RESET;
                                    item.SETFILTER(item."No.", SL1."No.");
                                    IF item.FINDFIRST THEN BEGIN
                                        itemNo := item."No.";
                                        Desc := item.Description;
                                    END
                                    ELSE BEGIN
                                        GLAccnt.RESET;
                                        GLAccnt.SETFILTER(GLAccnt."No.", SL1."No.");
                                        IF GLAccnt.FINDFIRST THEN BEGIN
                                            itemNo := GLAccnt."No.";
                                            Desc := GLAccnt.Name;
                                        END;
                                    END;
                                    ChangeFlag := TRUE;
                                END;
                        END
                        ELSE
                            IF (CHLG."Type of Change" = 1) AND (CHLG."Field No." = 80006) AND (CHLG."Table No." = 37) THEN BEGIN
                                SL1.RESET;
                                SL1.SETFILTER(SL1."Document No.", CHLG."Primary Key Field 2 Value");
                                SL1.SETFILTER(SL1."Line No.", CHLG."Primary Key Field 3 Value");
                                IF SL1.FINDFIRST THEN
                                    CASE CHLG."New Value" OF
                                        '0':
                                            tempPendingBy := ' ';
                                        '1':
                                            tempPendingBy := 'R&D';
                                        '2':
                                            tempPendingBy := 'Sales';
                                        '3':
                                            tempPendingBy := 'LMD';
                                        '4':
                                            tempPendingBy := 'Customer';
                                        '5':
                                            tempPendingBy := 'Purchase';
                                        '6':
                                            tempPendingBy := 'CUS';
                                    END;
                                IF FORMAT(SL1."Pending By") = tempPendingBy THEN BEGIN
                                    item.RESET;
                                    item.SETFILTER(item."No.", SL1."No.");
                                    IF item.FINDFIRST THEN BEGIN
                                        itemNo := item."No.";
                                        Desc := item.Description;
                                    END
                                    ELSE BEGIN
                                        GLAccnt.RESET;
                                        GLAccnt.SETFILTER(GLAccnt."No.", SL1."No.");
                                        IF GLAccnt.FINDFIRST THEN BEGIN
                                            itemNo := GLAccnt."No.";
                                            Desc := GLAccnt.Name;
                                        END;
                                    END;
                                    ChangeFlag := TRUE;
                                END;
                            END
                            ELSE
                                IF (CHLG."Field No." = 15) AND (CHLG."Table No." = 37) THEN BEGIN   // If Qty changes rec
                                    SL1.RESET;
                                    SL1.SETFILTER(SL1."Document No.", CHLG."Primary Key Field 2 Value");
                                    SL1.SETFILTER(SL1."Line No.", CHLG."Primary Key Field 3 Value");
                                    IF SL1.FINDFIRST THEN
                                        IF FORMAT(SL1.Quantity) = CHLG."New Value" THEN BEGIN
                                            item.RESET;
                                            item.SETFILTER(item."No.", SL1."No.");
                                            IF item.FINDFIRST THEN BEGIN
                                                itemNo := item."No.";
                                                Desc := item.Description;
                                            END
                                            ELSE BEGIN
                                                GLAccnt.RESET;
                                                GLAccnt.SETFILTER(GLAccnt."No.", SL1."No.");
                                                IF GLAccnt.FINDFIRST THEN BEGIN
                                                    itemNo := GLAccnt."No.";
                                                    Desc := GLAccnt.Name;
                                                END;
                                            END;
                                            ChangeFlag := TRUE;
                                        END;
                                END // If Qty changes rec end
                                ELSE
                                    IF (CHLG."Field No." = 7) AND (CHLG."Table No." = 60095) THEN BEGIN  // If qty change in schedules
                                        SchLine := COPYSTR(CHLG."Primary Key", STRPOS(CHLG."Primary Key",
                                        CHLG."Primary Key Field 3 Value"), STRLEN(CHLG."Primary Key"));
                                        SchLine := COPYSTR(SchLine, ROUND(STRPOS(SchLine, '=') + 3), STRLEN(SchLine));
                                        SchLine := COPYSTR(SchLine, 1, STRLEN(SchLine) - 1);
                                        SCH.RESET;
                                        SCH.SETFILTER(SCH."Document No.", CHLG."Primary Key Field 2 Value");
                                        SCH.SETFILTER(SCH."Document Line No.", CHLG."Primary Key Field 3 Value");
                                        SCH.SETFILTER(SCH."Line No.", SchLine);
                                        IF SCH.FINDFIRST THEN BEGIN
                                            IF FORMAT(SCH.Quantity) = CHLG."New Value" THEN BEGIN
                                                SL1.RESET;
                                                SL1.SETFILTER(SL1."Document No.", CHLG."Primary Key Field 2 Value");
                                                SL1.SETFILTER(SL1."Line No.", CHLG."Primary Key Field 3 Value");
                                                IF SL1.FINDFIRST THEN BEGIN
                                                    IF (SL1."No." <> SCH."No.") AND (SCH."Document Line No." <> SCH."Line No.") THEN BEGIN
                                                        item.RESET;
                                                        item.SETFILTER(item."No.", SCH."No.");
                                                        IF item.FINDFIRST THEN BEGIN
                                                            itemNo := item."No.";
                                                            Desc := item.Description;
                                                        END
                                                        ELSE BEGIN
                                                            itemNo := SCH."No.";
                                                            Desc := SCH.Description;
                                                        END;
                                                        ChangeFlag := TRUE;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END // If qty change in schedules end
                                    ELSE
                                        IF (CHLG."Field No." = 50002) AND (CHLG."Table No." = 60095) AND (CHLG."Type of Change" = 1) THEN BEGIN  // If qty shipped change in schedules
                                            SchLine := COPYSTR(CHLG."Primary Key", STRPOS(CHLG."Primary Key",
                                            CHLG."Primary Key Field 3 Value"), STRLEN(CHLG."Primary Key"));
                                            SchLine := COPYSTR(SchLine, ROUND(STRPOS(SchLine, '=') + 3), STRLEN(SchLine));
                                            SchLine := COPYSTR(SchLine, 1, STRLEN(SchLine) - 1);
                                            SCH.RESET;
                                            SCH.SETFILTER(SCH."Document No.", CHLG."Primary Key Field 2 Value");
                                            SCH.SETFILTER(SCH."Document Line No.", CHLG."Primary Key Field 3 Value");
                                            SCH.SETFILTER(SCH."Line No.", SchLine);
                                            IF SCH.FINDFIRST THEN BEGIN
                                                IF FORMAT(SCH."Qty. Shipped") = CHLG."New Value" THEN BEGIN
                                                    SL1.RESET;
                                                    SL1.SETFILTER(SL1."Document No.", CHLG."Primary Key Field 2 Value");
                                                    SL1.SETFILTER(SL1."Line No.", CHLG."Primary Key Field 3 Value");
                                                    IF SL1.FINDFIRST THEN BEGIN
                                                        IF (SL1."No." <> SCH."No.") AND (SCH."Document Line No." <> SCH."Line No.") THEN BEGIN
                                                            item.RESET;
                                                            item.SETFILTER(item."No.", SCH."No.");
                                                            IF item.FINDFIRST THEN BEGIN
                                                                itemNo := item."No.";
                                                                Desc := item.Description;
                                                            END
                                                            ELSE BEGIN
                                                                itemNo := SCH."No.";
                                                                Desc := SCH.Description;
                                                            END;
                                                            ChangeFlag := TRUE;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END // If qty shipped change in schedules end
                                        ELSE
                                            IF (CHLG."Field No." = 6) AND (CHLG."Table No." = 37) THEN BEGIN  // If Item No. Changes rec
                                                IF (CHLG."Type of Change" <> 2) THEN BEGIN
                                                    SL1.RESET;
                                                    SL1.SETFILTER(SL1."Document No.", CHLG."Primary Key Field 2 Value");
                                                    SL1.SETFILTER(SL1."Line No.", CHLG."Primary Key Field 3 Value");
                                                    IF SL1.FINDFIRST THEN
                                                        IF SL1."No." = CHLG."New Value" THEN BEGIN
                                                            item.RESET;
                                                            item.SETFILTER(item."No.", SL1."No.");
                                                            IF item.FINDFIRST THEN BEGIN
                                                                itemNo := item."No.";
                                                                Desc := item.Description;
                                                            END
                                                            ELSE BEGIN
                                                                itemNo := SL1."No.";
                                                                Desc := SL1.Description;
                                                            END;
                                                            ChangeFlag := TRUE;
                                                        END;
                                                END
                                                ELSE BEGIN
                                                    item.RESET;
                                                    item.SETFILTER(item."No.", CHLG."Old Value");
                                                    IF item.FINDFIRST THEN BEGIN
                                                        itemNo := item."No.";
                                                        Desc := item.Description;
                                                    END
                                                    ELSE BEGIN
                                                        GLAccnt.RESET;
                                                        GLAccnt.SETFILTER(GLAccnt."No.", CHLG."Old Value");
                                                        IF GLAccnt.FINDFIRST THEN BEGIN
                                                            itemNo := GLAccnt."No.";
                                                            Desc := GLAccnt.Name;
                                                        END;
                                                    END;
                                                    ChangeFlag := TRUE;
                                                END;
                                            END  // If Item No. Changes rec end
                                            ELSE
                                                IF (CHLG."Field No." = 5) AND (CHLG."Table No." = 60095) THEN BEGIN   // if Schedule item no. change
                                                    SchLine := COPYSTR(CHLG."Primary Key", STRPOS(CHLG."Primary Key",
                                                    CHLG."Primary Key Field 3 Value"), STRLEN(CHLG."Primary Key"));
                                                    SchLine := COPYSTR(SchLine, ROUND(STRPOS(SchLine, '=') + 3), STRLEN(SchLine));
                                                    SchLine := COPYSTR(SchLine, 1, STRLEN(SchLine) - 1);
                                                    IF (CHLG."Type of Change" <> 2) THEN BEGIN
                                                        SCH.RESET;
                                                        SCH.SETFILTER(SCH."Document No.", CHLG."Primary Key Field 2 Value");
                                                        SCH.SETFILTER(SCH."Document Line No.", CHLG."Primary Key Field 3 Value");
                                                        SCH.SETFILTER(SCH."Line No.", SchLine);
                                                        IF SCH.FINDFIRST THEN BEGIN
                                                            SL1.RESET;
                                                            SL1.SETFILTER(SL1."Document No.", CHLG."Primary Key Field 2 Value");
                                                            SL1.SETFILTER(SL1."Line No.", CHLG."Primary Key Field 3 Value");
                                                            IF SL1.FINDFIRST THEN
                                                                IF (SL1."No." <> SCH."No.") AND (SCH."Line No." <> SCH."Document Line No.") THEN BEGIN
                                                                    item.RESET;
                                                                    item.SETFILTER(item."No.", SCH."No.");
                                                                    IF item.FINDFIRST THEN BEGIN
                                                                        itemNo := item."No.";
                                                                        Desc := item.Description;
                                                                    END
                                                                    ELSE BEGIN
                                                                        itemNo := SCH."No.";
                                                                        Desc := SCH.Description;
                                                                    END;
                                                                    ChangeFlag := TRUE;
                                                                END;
                                                        END;
                                                    END
                                                    ELSE BEGIN
                                                        IF CHLG."Primary Key Field 3 Value" <> SchLine THEN BEGIN
                                                            item.RESET;
                                                            item.SETFILTER(item."No.", CHLG."Old Value");
                                                            IF item.FINDFIRST THEN BEGIN
                                                                itemNo := item."No.";
                                                                Desc := item.Description;
                                                            END
                                                            ELSE BEGIN
                                                                GLAccnt.RESET;
                                                                GLAccnt.SETFILTER(GLAccnt."No.", CHLG."Old Value");
                                                                IF GLAccnt.FINDFIRST THEN BEGIN
                                                                    itemNo := GLAccnt."No.";
                                                                    Desc := GLAccnt.Name;
                                                                END;
                                                            END;
                                                            ChangeFlag := TRUE;
                                                        END;
                                                    END;
                                                END     // if Schedule item no. change end
                                                ELSE
                                                    IF (CHLG."Field No." = 60074) AND (CHLG."Table No." = 36) AND (CHLG."Type of Change" = 1) THEN BEGIN // call letter status changes
                                                        ChangeFlag := TRUE;
                                                    END;
                        IF ChangeFlag = TRUE THEN BEGIN   // If Change flag true
                            User.RESET;
                            User.SETFILTER(User."User Name", CHLG."User ID");
                            IF User.FINDFIRST THEN
                                username := User."Full Name"
                            ELSE
                                username := CHLG."User ID";
                            IF (CHLG."Field No." = 15) AND (CHLG."Table No." = 37) THEN BEGIN // If field is qty
                                IF (CHLG."Type of Change" = 1) AND (CHLG."Old Value" <> '0') THEN BEGIN
                                    IF modifyflag = FALSE THEN BEGIN
                                        IF modifyflag1 = FALSE THEN
                                            Body += ('<P> Order Modifications, </P>');
                                        Body += ('<P>Changes in Sales/Schedule Lines, </P>');
                                        Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Sale order No.</th><th >Customer</th><th>Line No.</th><th>Schdle Line No.</th><th>Item No.</th>');
                                        Body += ('<th>Description</th><th>Type of Change</th><th>Changed Field</th><th>Previous Value</th><th>New Value</th><th>User ID</th><th>Time of Change</th></tr>');
                                        modifyflag := TRUE;
                                    END;
                                    TypeOfChange := 'Quantity Change';
                                    IF (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/L') OR (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/T') THEN
                                        LMD_Count := 1;
                                    Body += ('<tr><td>' + CHLG."Primary Key Field 2 Value" + '</td><td>' + custname + '</td><td>' + CHLG."Primary Key Field 3 Value" + '</td><td>' + ' ' + '</td><td>' + itemNo + '</td><td>' + Desc + '</td>');
                                    Body += ('<td>' + TypeOfChange + '</td><td>Quantity</td><td>' + CHLG."Old Value" + '</td><td>' + CHLG."New Value" + '</td><td>' + username + '</td><td>' + FORMAT(CHLG."Date and Time") + '</td></tr>');
                                    recCount := recCount + 1;
                                END
                            END // If field is qty end
                            ELSE
                                IF (CHLG."Field No." = 60) AND (CHLG."Table No." = 37) THEN BEGIN // If field is qty shipped in SL
                                    IF (CHLG."Type of Change" = 1) THEN BEGIN
                                        IF modifyflag = FALSE THEN BEGIN
                                            IF modifyflag1 = FALSE THEN
                                                Body += ('<P> Order Modifications, </P>');
                                            Body += ('<P>Changes in Sales/Schedule Lines, </P>');
                                            Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Sale order No.</th><th >Customer</th><th>Line No.</th><th>Schdle Line No.</th><th>Item No.</th>');
                                            Body += ('<th>Description</th><th>Type of Change</th><th>Changed Field</th><th>Previous Value</th><th>New Value</th><th>User ID</th><th>Time of Change</th></tr>');
                                            modifyflag := TRUE;
                                        END;
                                        TypeOfChange := 'Qty Shipped Change';
                                        IF (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/L') OR (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/T') THEN
                                            LMD_Count := 1;

                                        Body += ('<tr><td>' + CHLG."Primary Key Field 2 Value" + '</td><td>' + custname + '</td><td>' + CHLG."Primary Key Field 3 Value" + '</td><td>' + ' ' + '</td><td>' + itemNo + '</td><td>' + Desc + '</td>');
                                        Body += ('<td>' + TypeOfChange + '</td><td>Qty Shipped</td><td>' + CHLG."Old Value" + '</td><td>' + CHLG."New Value" + '</td><td>' + username + '</td><td>' + FORMAT(CHLG."Date and Time") + '</td></tr>');
                                        recCount := recCount + 1;
                                    END
                                END // If field is qty shipped in SL end
                                ELSE
                                    IF (CHLG."Field No." = 7) AND (CHLG."Table No." = 60095) THEN BEGIN // If field is Schedule qty
                                        IF (CHLG."Type of Change" = 1) AND (CHLG."Old Value" <> '0') THEN BEGIN
                                            IF modifyflag = FALSE THEN BEGIN
                                                IF modifyflag1 = FALSE THEN
                                                    Body += ('<P> Order Modifications, </P>');
                                                Body += ('<P>Changes in Sales/Schedule Lines, </P>');
                                                Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Sale order No.</th><th >Customer</th><th>Line No.</th><th>Schdle Line No.</th><th>Item No.</th>');
                                                Body += ('<th>Description</th><th>Type of Change</th><th>Changed Field</th><th>Previous Value</th><th>New Value</th><th>User ID</th><th>Time of Change</th></tr>');
                                                modifyflag := TRUE;
                                            END;
                                            TypeOfChange := 'Quantity Change';
                                            IF (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/L') OR (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/T') THEN
                                                LMD_Count := 1;

                                            Body += ('<tr><td>' + CHLG."Primary Key Field 2 Value" + '</td><td>' + custname + '</td><td>' + CHLG."Primary Key Field 3 Value" + '</td><td>' + SchLine + '</td><td>' + itemNo + '</td><td>' + Desc + '</td>');
                                            Body += ('<td>' + TypeOfChange + '</td><td>Quantity</td><td>' + CHLG."Old Value" + '</td><td>' + CHLG."New Value" + '</td><td>' + username + '</td><td>' + FORMAT(CHLG."Date and Time") + '</td></tr>');
                                            recCount := recCount + 1;
                                        END
                                    END // If field is Shedule qty end
                                    ELSE
                                        IF (CHLG."Field No." = 50002) AND (CHLG."Table No." = 60095) THEN BEGIN // If field is Schedule qty shipped
                                            IF (CHLG."Type of Change" = 1) THEN BEGIN
                                                IF modifyflag = FALSE THEN BEGIN
                                                    IF modifyflag1 = FALSE THEN
                                                        Body += ('<P> Order Modifications, </P>');
                                                    Body += ('<P>Changes in Sales/Schedule Lines, </P>');
                                                    Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Sale order No.</th><th >Customer</th><th>Line No.</th><th>Schdle Line No.</th><th>Item No.</th>');
                                                    Body += ('<th>Description</th><th>Type of Change</th><th>Changed Field</th><th>Previous Value</th><th>New Value</th><th>User ID</th><th>Time of Change</th></tr>');
                                                    modifyflag := TRUE;
                                                END;
                                                IF (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/L') OR (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/T') THEN
                                                    LMD_Count := 1;

                                                TypeOfChange := 'Qty Shipped Change';
                                                Body += ('<tr><td>' + CHLG."Primary Key Field 2 Value" + '</td><td>' + custname + '</td><td>' + CHLG."Primary Key Field 3 Value" + '</td><td>' + SchLine + '</td><td>' + itemNo + '</td><td>' + Desc + '</td>');
                                                Body += ('<td>' + TypeOfChange + '</td><td>Qty Shipped</td><td>' + CHLG."Old Value" + '</td><td>' + CHLG."New Value" + '</td><td>' + username + '</td><td>' + FORMAT(CHLG."Date and Time") + '</td></tr>');
                                                recCount := recCount + 1;
                                            END
                                        END // If field is Shedule qty shipped end
                                        ELSE
                                            IF (CHLG."Field No." = 6) AND (CHLG."Table No." = 37) THEN BEGIN // If field item no.
                                                IF CHLG."Type of Change" = 1 THEN BEGIN
                                                    TypeOfChange := 'Item Change';
                                                END
                                                ELSE
                                                    IF CHLG."Type of Change" = 0 THEN BEGIN
                                                        TypeOfChange := 'New Item Insertion';
                                                    END
                                                    ELSE
                                                        IF CHLG."Type of Change" = 2 THEN BEGIN
                                                            TypeOfChange := 'Item Deletion';
                                                        END;
                                                IF modifyflag = FALSE THEN BEGIN
                                                    IF modifyflag1 = FALSE THEN
                                                        Body += ('<P> Order Modifications, </P>');
                                                    Body += ('<P>Changes in Sales/Schedule Lines, </P>');
                                                    Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Sale order No.</th><th >Customer</th><th>Line No.</th><th>Schdle Line No.</th><th>Item No.</th>');
                                                    Body += ('<th>Description</th><th>Type of Change</th><th>Changed Field</th><th>Previous Value</th><th>New Value</th><th>User ID</th><th>Time of Change</th></tr>');
                                                    modifyflag := TRUE;
                                                END;
                                                IF (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/L') OR (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/T') THEN
                                                    LMD_Count := 1;
                                                IF TypeOfChange <> 'New Item Insertion' THEN BEGIN   // if change is Insertion
                                                    IF CHLG."Old Value" <> '' THEN BEGIN
                                                        Body += ('<tr><td>' + CHLG."Primary Key Field 2 Value" + '</td><td>' + custname + '</td><td>' + CHLG."Primary Key Field 3 Value" + '</td><td>' + ' ' + '</td><td>' + itemNo + '</td><td>' + Desc + '</td>');
                                                        Body += ('<td>' + TypeOfChange + '</td><td>Item No.</td><td>' + CHLG."Old Value" + '</td><td>' + CHLG."New Value" + '</td><td>' + username + '</td><td>' + FORMAT(CHLG."Date and Time") + '</td></tr>');
                                                        recCount := recCount + 1;
                                                    END;
                                                END ELSE BEGIN  // if change is not Insertion
                                                    Body += ('<tr><td>' + CHLG."Primary Key Field 2 Value" + '</td><td>' + custname + '</td><td>' + CHLG."Primary Key Field 3 Value" + '</td><td>' + ' ' + '</td><td>' + itemNo + '</td><td>' + Desc + '</td>');
                                                    Body += ('<td>' + TypeOfChange + '</td><td>Item No.</td><td>' + CHLG."Old Value" + '</td><td>' + CHLG."New Value" + '</td><td>' + username + '</td><td>' + FORMAT(CHLG."Date and Time") + '</td></tr>');
                                                    recCount := recCount + 1;
                                                END; // if change is not Insertion end
                                            END // If field item no. end
                                            ELSE
                                                IF (CHLG."Field No." = 5) AND (CHLG."Table No." = 60095) THEN BEGIN // If field Shedule item no.
                                                    IF CHLG."Type of Change" = 1 THEN BEGIN
                                                        TypeOfChange := 'Item Change';
                                                    END
                                                    ELSE
                                                        IF CHLG."Type of Change" = 0 THEN BEGIN
                                                            TypeOfChange := 'New Item Insertion';
                                                        END
                                                        ELSE
                                                            IF CHLG."Type of Change" = 2 THEN BEGIN
                                                                TypeOfChange := 'Item Deletion';
                                                            END;
                                                    IF modifyflag = FALSE THEN BEGIN
                                                        IF modifyflag1 = FALSE THEN
                                                            Body += ('<P> Order Modifications, </P>');
                                                        Body += ('<P>Changes in Sales/Schedule Lines, </P>');
                                                        Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Sale order No.</th><th >Customer</th><th>Line No.</th><th>Schdle Line No.</th><th>Item No.</th>');
                                                        Body += ('<th>Description</th><th>Type of Change</th><th>Changed Field</th><th>Previous Value</th><th>New Value</th><th>User ID</th><th>Time of Change</th></tr>');
                                                        modifyflag := TRUE;
                                                    END;
                                                    IF TypeOfChange <> 'New Item Insertion' THEN BEGIN   // if change is Insertion
                                                        IF (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/L') OR (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/T') THEN
                                                            LMD_Count := 1;
                                                        IF CHLG."Old Value" <> '' THEN BEGIN
                                                            Body += ('<tr><td>' + CHLG."Primary Key Field 2 Value" + '</td><td>' + custname + '</td><td>' + CHLG."Primary Key Field 3 Value" + '</td><td>' + SchLine + '</td><td>' + itemNo + '</td><td>' + Desc + '</td>');
                                                            Body += ('<td>' + TypeOfChange + '</td><td>Item No.</td><td>' + CHLG."Old Value" + '</td><td>' + CHLG."New Value" + '</td><td>' + username + '</td><td>' + FORMAT(CHLG."Date and Time") + '</td></tr>');
                                                            recCount := recCount + 1;
                                                        END;
                                                    END ELSE BEGIN  // if change is not Insertion
                                                        IF (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/L') OR (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/T') THEN
                                                            LMD_Count := 1;
                                                        Body += ('<tr><td>' + CHLG."Primary Key Field 2 Value" + '</td><td>' + custname + '</td><td>' + CHLG."Primary Key Field 3 Value" + '</td><td>' + SchLine + '</td><td>' + itemNo + '</td><td>' + Desc + '</td>');
                                                        Body += ('<td>' + TypeOfChange + '</td><td>Item No.</td><td>' + CHLG."Old Value" + '</td><td>' + CHLG."New Value" + '</td><td>' + username + '</td><td>' + FORMAT(CHLG."Date and Time") + '</td></tr>');
                                                        recCount := recCount + 1;
                                                    END; // if change is not Insertion end
                                                END // If field item no. end
                                                ELSE
                                                    IF (CHLG."Type of Change" = 1) AND (CHLG."Field No." = 80006) AND (CHLG."Table No." = 37) THEN BEGIN // IF Pending by status change
                                                        CASE CHLG."Old Value" OF
                                                            '0':
                                                                OldPendingByVal := ' ';
                                                            '1':
                                                                OldPendingByVal := 'R&D';
                                                            '2':
                                                                OldPendingByVal := 'Sales';
                                                            '3':
                                                                OldPendingByVal := 'LMD';
                                                            '4':
                                                                OldPendingByVal := 'Customer';
                                                            '5':
                                                                OldPendingByVal := 'Purchase';
                                                            '6':
                                                                OldPendingByVal := 'CUS';
                                                        END;
                                                        CASE CHLG."New Value" OF
                                                            '0':
                                                                NewPendingByVal := ' ';
                                                            '1':
                                                                NewPendingByVal := 'R&D';
                                                            '2':
                                                                NewPendingByVal := 'Sales';
                                                            '3':
                                                                NewPendingByVal := 'LMD';
                                                            '4':
                                                                NewPendingByVal := 'Customer';
                                                            '5':
                                                                NewPendingByVal := 'Purchase';
                                                            '6':
                                                                NewPendingByVal := 'CUS';
                                                        END;
                                                        IF modifyflag = FALSE THEN BEGIN
                                                            IF modifyflag1 = FALSE THEN
                                                                Body += ('<P> Order Modifications, </P>');
                                                            Body += ('<P>Changes in Sales/Schedule Lines, </P>');
                                                            Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Sale order No.</th><th >Customer</th><th>Line No.</th><th>Schdle Line No.</th><th>Item No.</th>');
                                                            Body += ('<th>Description</th><th>Type of Change</th><th>Changed Field</th><th>Previous Value</th><th>New Value</th><th>User ID</th><th>Time of Change</th></tr>');
                                                            modifyflag := TRUE;
                                                        END;
                                                        IF (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/L') OR (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/T') THEN
                                                            LMD_Count := 1;

                                                        Body += ('<tr><td>' + CHLG."Primary Key Field 2 Value" + '</td><td>' + custname + '</td><td>' + CHLG."Primary Key Field 3 Value" + '</td><td>' + ' ' + '</td><td>' + itemNo + '</td><td>' + Desc + '</td>');
                                                        Body += ('<td>Pending By Change</td><td>Pending By</td><td>' + OldPendingByVal + '</td><td>' + NewPendingByVal + '</td><td>' + username + '</td><td>' + FORMAT(CHLG."Date and Time") + '</td></tr>');
                                                    END;  // IF Pending by status change end
                        END;  // If Change flag true end
                    END;  // If order released atleast onces End
                END;  // If Sales Header Rec Find ENd
            UNTIL CHLG.NEXT = 0;
        //Body += ('<td colspan=6 align="center"><b>Total RPOs</b></td><td align="right"><b>'+FORMAT(NoofRPO)+'</b></td></tr>');
        Body += ('</table><br>');
        releasedflag := FALSE;
        modifyflag := FALSE;
        custname := '';
        ChangeFlag := FALSE;
        CHLG.RESET;
        CHLG.SETCURRENTKEY("Table No.", "Primary Key Field 2 Value", "Primary Key Field 3 Value", "Date and Time");
        CHLG.SETFILTER(CHLG."Table No.", '%1|%2', 37, 60095);
        CHLG.SETFILTER(CHLG."Date and Time", '>=%1&<=%2', Todaytime, Fromdaytime);
        CHLG.SETFILTER(CHLG."Field No.", '%1|%2|%3|%4', 6, 15, 60, 50002);
        //CHLG.SETFILTER(CHLG."Primary Key Field 3 Value",'<>%1','EFF/SAL/15-16/0229');
        IF CHLG.FINDSET THEN
            REPEAT
                custname := '';
                ChangeFlag := FALSE;
                releasedflag := FALSE;
                SH.RESET;
                //SH.SETFILTER(SH."Document Type", '<>%1', SH."Document Type"::Amc);
                SH.SETFILTER(SaleDocType, '<>%1', SH.SaleDocType::Amc);//EFFUPG1.5
                SH.SETFILTER(SH."No.", CHLG."Primary Key Field 2 Value");
                //SH.SETFILTER(SH."First Released Date Time",'<%1',CHLG."Date and Time");
                IF NOT SH.FINDFIRST THEN BEGIN
                    SHA.RESET;
                    //SHA.SETFILTER(SHA."Document Type", '<>%1', SHA."Document Type"::Amc);
                    SHA.SETFILTER(SHA.SaleDocType, '<>%1', SHA.SaleDocType::Amc);//EFFUPG1.5
                    SHA.SETFILTER(SHA."No.", CHLG."Primary Key Field 2 Value");
                    //SHA.SETFILTER(SHA."First Released Date Time",'<%1',CHLG."Date and Time");
                    IF SHA.FINDFIRST THEN
                        releasedflag := TRUE;
                    custname := '';
                    customer.RESET;
                    customer.SETFILTER(customer."No.", SHA."Sell-to Customer No.");
                    IF customer.FINDFIRST THEN
                        custname := customer.Name;
                    IF releasedflag = TRUE THEN BEGIN
                        IF (CHLG."Field No." = 15) AND (CHLG."Table No." = 37) THEN BEGIN
                            SL1.RESET;
                            SL1.SETFILTER(SL1."Document No.", CHLG."Primary Key Field 2 Value");
                            SL1.SETFILTER(SL1."Line No.", CHLG."Primary Key Field 3 Value");
                            IF SL1.FINDFIRST THEN
                                IF FORMAT(SL1.Quantity) = CHLG."New Value" THEN BEGIN
                                    item.RESET;
                                    item.SETFILTER(item."No.", SL1."No.");
                                    IF item.FINDFIRST THEN BEGIN
                                        itemNo := item."No.";
                                        Desc := item.Description;
                                    END
                                    ELSE BEGIN
                                        GLAccnt.RESET;
                                        GLAccnt.SETFILTER(GLAccnt."No.", SL1."No.");
                                        IF GLAccnt.FINDFIRST THEN BEGIN
                                            itemNo := GLAccnt."No.";
                                            Desc := GLAccnt.Name;
                                        END;
                                    END;
                                    ChangeFlag := TRUE;
                                END;
                        END
                        ELSE
                            IF (CHLG."Field No." = 6) AND (CHLG."Table No." = 37) THEN BEGIN
                                IF (CHLG."Type of Change" <> 2) THEN BEGIN
                                    SL1.RESET;
                                    SL1.SETFILTER(SL1."Document No.", CHLG."Primary Key Field 2 Value");
                                    SL1.SETFILTER(SL1."Line No.", CHLG."Primary Key Field 3 Value");
                                    IF SL1.FINDFIRST THEN
                                        IF SL1."No." = CHLG."New Value" THEN BEGIN
                                            item.RESET;
                                            item.SETFILTER(item."No.", SL1."No.");
                                            IF item.FINDFIRST THEN BEGIN
                                                itemNo := item."No.";
                                                Desc := item.Description;
                                            END
                                            ELSE BEGIN
                                                itemNo := SL1."No.";
                                                Desc := SL1.Description;
                                            END;
                                            ChangeFlag := TRUE;
                                        END;
                                END
                                ELSE BEGIN
                                    item.RESET;
                                    item.SETFILTER(item."No.", CHLG."Old Value");
                                    IF item.FINDFIRST THEN BEGIN
                                        itemNo := item."No.";
                                        Desc := item.Description;
                                    END
                                    ELSE BEGIN
                                        GLAccnt.RESET;
                                        GLAccnt.SETFILTER(GLAccnt."No.", CHLG."Old Value");
                                        IF GLAccnt.FINDFIRST THEN BEGIN
                                            itemNo := GLAccnt."No.";
                                            Desc := GLAccnt.Name;
                                        END;
                                    END;
                                    ChangeFlag := TRUE;
                                END;
                            END
                            ELSE
                                IF (CHLG."Type of Change" = 1) AND (CHLG."Field No." = 60) AND (CHLG."Table No." = 37) THEN BEGIN   // if qty shipped change in sales lines
                                    SL1.RESET;
                                    SL1.SETFILTER(SL1."Document No.", CHLG."Primary Key Field 2 Value");
                                    SL1.SETFILTER(SL1."Line No.", CHLG."Primary Key Field 3 Value");
                                    IF NOT SL1.FINDFIRST THEN BEGIN
                                        SIL.RESET;
                                        SIL.SETFILTER(SIL."Order No.", CHLG."Primary Key Field 2 Value");
                                        SIL.SETFILTER(SIL."Order Line No.", CHLG."Primary Key Field 3 Value");
                                        SIL.SETFILTER(SIL.Quantity, '>%1', 0);
                                        SIL.SETRANGE(SIL."Posting Date", headerdate);
                                        IF SIL.FINDFIRST THEN
                                            IF FORMAT(SIL.Quantity) = CHLG."New Value" THEN BEGIN
                                                item.RESET;
                                                item.SETFILTER(item."No.", SIL."No.");
                                                IF item.FINDFIRST THEN BEGIN
                                                    itemNo := item."No.";
                                                    Desc := item.Description;
                                                END
                                                ELSE BEGIN
                                                    GLAccnt.RESET;
                                                    GLAccnt.SETFILTER(GLAccnt."No.", SIL."No.");
                                                    IF GLAccnt.FINDFIRST THEN BEGIN
                                                        itemNo := GLAccnt."No.";
                                                        Desc := GLAccnt.Name;
                                                    END;
                                                END;
                                                ChangeFlag := TRUE;
                                            END;
                                    END;
                                END
                                ELSE
                                    IF (CHLG."Field No." = 50002) AND (CHLG."Table No." = 60095) AND (CHLG."Type of Change" = 1) THEN BEGIN  // If qty shipped change in schedules
                                        SchLine := COPYSTR(CHLG."Primary Key", STRPOS(CHLG."Primary Key",
                                        CHLG."Primary Key Field 3 Value"), STRLEN(CHLG."Primary Key"));
                                        SchLine := COPYSTR(SchLine, ROUND(STRPOS(SchLine, '=') + 3), STRLEN(SchLine));
                                        SchLine := COPYSTR(SchLine, 1, STRLEN(SchLine) - 1);
                                        SH.RESET;
                                        SH.SETFILTER(SH."No.", CHLG."Primary Key Field 2 Value");
                                        IF NOT SH.FINDFIRST THEN BEGIN
                                            SCH.RESET;
                                            SCH.SETFILTER(SCH."Document No.", CHLG."Primary Key Field 2 Value");
                                            SCH.SETFILTER(SCH."Document Line No.", CHLG."Primary Key Field 3 Value");
                                            SCH.SETFILTER(SCH."Line No.", SchLine);
                                            IF SCH.FINDFIRST THEN BEGIN
                                                IF FORMAT(SCH."Qty. Shipped") = CHLG."New Value" THEN BEGIN
                                                    IF (SCH."Document Line No." <> SCH."Line No.") THEN BEGIN
                                                        item.RESET;
                                                        item.SETFILTER(item."No.", SCH."No.");
                                                        IF item.FINDFIRST THEN BEGIN
                                                            itemNo := item."No.";
                                                            Desc := item.Description;
                                                        END
                                                        ELSE BEGIN
                                                            itemNo := SCH."No.";
                                                            Desc := SCH.Description;
                                                        END;
                                                        ChangeFlag := TRUE;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END; // If qty shipped change in schedules end
                        IF ChangeFlag = TRUE THEN BEGIN
                            User.RESET;
                            User.SETFILTER(User."User Name", CHLG."User ID");
                            IF User.FINDFIRST THEN
                                username := User."Full Name"
                            ELSE
                                username := CHLG."User ID";
                            IF (CHLG."Field No." = 15) AND (CHLG."Table No." = 37) THEN BEGIN
                                IF (CHLG."Type of Change" = 1) AND (CHLG."Old Value" <> '0') THEN BEGIN
                                    IF modifyflag = FALSE THEN BEGIN
                                        Body += ('<P>Closed Orders, </P>');
                                        Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Sale order No.</th><th >Customer</th><th>Line No.</th><th>Schdle Line No.</th><th>Item No.</th>');
                                        Body += ('<th>Description</th><th>Type of Change</th><th>Changed Field</th><th>Previous Value</th><th>New Value</th><th>User ID</th><th>Time of Change</th></tr>');
                                        modifyflag := TRUE;
                                    END;
                                    IF (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/L') OR (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/T') THEN
                                        LMD_Count := 1;

                                    TypeOfChange := 'Quantity Change';
                                    Body += ('<tr><td>' + CHLG."Primary Key Field 2 Value" + '</td><td>' + custname + '</td><td>' + CHLG."Primary Key Field 3 Value" + '</td><td>' + ' ' + '</td><td>' + itemNo + '</td><td>' + Desc + '</td><td>' + TypeOfChange + '</td>');
                                    Body += ('<td>Quantity</td><td>' + CHLG."Old Value" + '</td><td>' + CHLG."New Value" + '</td><td>' + username + '</td><td>' + FORMAT(CHLG."Date and Time") + '</td></tr>');
                                    recCount := recCount + 1;
                                END
                            END
                            ELSE
                                IF (CHLG."Field No." = 60) AND (CHLG."Table No." = 37) THEN BEGIN // If field is qty shipped in SL
                                    IF (CHLG."Type of Change" = 1) THEN BEGIN
                                        IF modifyflag = FALSE THEN BEGIN
                                            Body += ('<P>Closed Orders, </P>');
                                            Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Sale order No.</th><th >Customer</th><th>Line No.</th><th>Schdle Line No.</th><th>Item No.</th>');
                                            Body += ('<th>Description</th><th>Type of Change</th><th>Changed Field</th><th>Previous Value</th><th>New Value</th><th>User ID</th><th>Time of Change</th></tr>');
                                            modifyflag := TRUE;
                                        END;
                                        IF (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/L') OR (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/T') THEN
                                            LMD_Count := 1;

                                        TypeOfChange := 'Qty Shipped Change';
                                        Body += ('<tr><td>' + CHLG."Primary Key Field 2 Value" + '</td><td>' + custname + '</td><td>' + CHLG."Primary Key Field 3 Value" + '</td><td>' + ' ' + '</td><td>' + itemNo + '</td><td>' + Desc + '</td>');
                                        Body += ('<td>' + TypeOfChange + '</td><td>Qty Shipped</td><td>' + CHLG."Old Value" + '</td><td>' + CHLG."New Value" + '</td><td>' + username + '</td><td>' + FORMAT(CHLG."Date and Time") + '</td></tr>');
                                        recCount := recCount + 1;
                                    END
                                END // If field is qty shipped in SL end
                                ELSE
                                    IF (CHLG."Field No." = 50002) AND (CHLG."Table No." = 60095) THEN BEGIN // If field is Schedule qty
                                        IF (CHLG."Type of Change" = 1) THEN BEGIN
                                            IF modifyflag = FALSE THEN BEGIN
                                                Body += ('<P>Closed Orders, </P>');
                                                Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Sale order No.</th><th >Customer</th><th>Line No.</th><th>Schdle Line No.</th><th>Item No.</th>');
                                                Body += ('<th>Description</th><th>Type of Change</th><th>Changed Field</th><th>Previous Value</th><th>New Value</th><th>User ID</th><th>Time of Change</th></tr>');
                                                modifyflag := TRUE;
                                            END;
                                            IF (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/L') OR (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/T') THEN
                                                LMD_Count := 1;

                                            TypeOfChange := 'Qty Shipped Change';
                                            Body += ('<tr><td>' + CHLG."Primary Key Field 2 Value" + '</td><td>' + custname + '</td><td>' + CHLG."Primary Key Field 3 Value" + '</td><td>' + SchLine + '</td><td>' + itemNo + '</td><td>' + Desc + '</td>');
                                            Body += ('<td>' + TypeOfChange + '</td><td>Qty Shipped</td><td>' + CHLG."Old Value" + '</td><td>' + CHLG."New Value" + '</td><td>' + username + '</td><td>' + FORMAT(CHLG."Date and Time") + '</td></tr>');
                                            recCount := recCount + 1;
                                        END
                                    END // If field is Shedule qty end
                                    ELSE
                                        IF (CHLG."Field No." = 6) AND (CHLG."Table No." = 37) THEN BEGIN   // If Qty Change in SL Begin
                                            IF CHLG."Type of Change" = 1 THEN BEGIN
                                                TypeOfChange := 'Item Change';
                                            END
                                            ELSE
                                                IF CHLG."Type of Change" = 0 THEN BEGIN
                                                    TypeOfChange := 'New Item Insertion';
                                                END
                                                ELSE
                                                    IF CHLG."Type of Change" = 2 THEN BEGIN
                                                        TypeOfChange := 'Item Deletion';
                                                    END;
                                            IF TypeOfChange <> 'New Item Insertion' THEN BEGIN
                                                IF CHLG."Old Value" <> '' THEN BEGIN
                                                    IF modifyflag = FALSE THEN BEGIN
                                                        Body += ('<P>Closed Orders, </P>');
                                                        Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Sale order No.</th><th >Customer</th><th>Line No.</th><th>Schdle Line No.</th><th>Item No.</th>');
                                                        Body += ('<th>Description</th><th>Type of Change</th><th>Changed Field</th><th>Previous Value</th><th>New Value</th><th>User ID</th><th>Time of Change</th></tr>');
                                                        modifyflag := TRUE;
                                                    END;
                                                    IF (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/L') OR (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/T') THEN
                                                        LMD_Count := 1;
                                                    Body += ('<tr><td>' + CHLG."Primary Key Field 2 Value" + '</td><td>' + custname + '</td><td>' + CHLG."Primary Key Field 3 Value" + '</td><td>' + ' ' + '</td><td>' + itemNo + '</td><td>' + Desc + '</td><td>' + TypeOfChange + '</td>');
                                                    Body += ('<td>Item No.</td><td>' + CHLG."Old Value" + '</td><td>' + CHLG."New Value" + '</td><td>' + username + '</td><td>' + FORMAT(CHLG."Date and Time") + '</td></tr>');
                                                    recCount := recCount + 1;
                                                END ELSE BEGIN
                                                    IF modifyflag = FALSE THEN BEGIN
                                                        Body += ('<P>Closed Orders, </P>');
                                                        Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Sale order No.</th><th >Customer</th><th>Line No.</th><th>Schdle Line No.</th><th>Item No.</th>');
                                                        Body += ('<th>Description</th><th>Type of Change</th><th>Changed Field</th><th>Previous Value</th><th>New Value</th><th>User ID</th><th>Time of Change</th></tr>');
                                                        modifyflag := TRUE;
                                                    END;
                                                    IF (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/L') OR (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/T') THEN
                                                        LMD_Count := 1;
                                                    Body += ('<tr><td>' + CHLG."Primary Key Field 2 Value" + '</td><td>' + custname + '</td><td>' + CHLG."Primary Key Field 3 Value" + '</td><td>' + ' ' + '</td><td>' + itemNo + '</td><td>' + Desc + '</td><td>' + TypeOfChange + '</td>');
                                                    Body += ('<td>Item No.</td><td>' + CHLG."Old Value" + '</td><td>' + CHLG."New Value" + '</td><td>' + username + '</td><td>' + FORMAT(CHLG."Date and Time") + '</td></tr>');
                                                    recCount := recCount + 1;
                                                END;
                                            END;
                                        END;
                        END;
                    END;
                END;
            UNTIL CHLG.NEXT = 0;
        Body += ('</table><br>');
        releasedflag := FALSE;
        custname := '';
        ChangeFlag := FALSE;
        CHLG.RESET;
        CHLG.SETCURRENTKEY("Table No.", "Primary Key Field 2 Value", "Primary Key Field 3 Value", "Date and Time");
        CHLG.SETFILTER(CHLG."Table No.", '%1|%2', 37, 36);
        CHLG.SETFILTER(CHLG."Date and Time", '>=%1&<=%2', Todaytime, Fromdaytime);
        CHLG.SETFILTER(CHLG."Field No.", '%1|%2|%3|%4', 6, 15, 60074, 80006);
        //CHLG.SETFILTER(CHLG."Primary Key Field 3 Value",'<>%1','EFF/SAL/15-16/0229');
        IF CHLG.FINDSET THEN
            REPEAT
                custname := '';
                ChangeFlag := FALSE;
                releasedflag := FALSE;
                SH.RESET;
                //SH.SETFILTER(SH."Document Type", '<>%1', SH."Document Type"::Amc);
                SH.SETFILTER(SaleDocType, '<>%1', SH.SaleDocType::Amc);//EFFUPG1.5
                SH.SETFILTER(SH."No.", CHLG."Primary Key Field 2 Value");
                SH.SETFILTER(SH."First Released Date Time", '>=%1', CHLG."Date and Time");
                IF SH.FINDFIRST THEN BEGIN
                    IF SH.Status <> SH.Status::Released THEN BEGIN
                        SHA.RESET;
                        //SHA.SETFILTER(SHA."Document Type", '<>%1', SHA."Document Type"::Amc);
                        SH.SETFILTER(SaleDocType, '<>%1', SH.SaleDocType::Amc);//EFFUPG1.5
                        SHA.SETFILTER(SHA."No.", CHLG."Primary Key Field 2 Value");
                        //SHA.SETFILTER(SHA."First Released Date Time",'>=%1',CHLG."Date and Time");
                        IF SHA.FINDFIRST THEN
                            releasedflag := TRUE;
                    END
                    ELSE
                        releasedflag := TRUE;
                    custname := '';
                    customer.RESET;
                    customer.SETFILTER(customer."No.", SH."Sell-to Customer No.");
                    IF customer.FINDFIRST THEN
                        custname := customer.Name;
                    IF releasedflag = TRUE THEN BEGIN
                        IF (CHLG."Field No." = 15) AND (CHLG."Table No." = 37) THEN BEGIN
                            SL1.RESET;
                            SL1.SETFILTER(SL1."Document No.", CHLG."Primary Key Field 2 Value");
                            SL1.SETFILTER(SL1."Line No.", CHLG."Primary Key Field 3 Value");
                            IF SL1.FINDFIRST THEN
                                IF FORMAT(SL1.Quantity) = CHLG."New Value" THEN BEGIN
                                    item.RESET;
                                    item.SETFILTER(item."No.", SL1."No.");
                                    IF item.FINDFIRST THEN BEGIN
                                        itemNo := item."No.";
                                        Desc := item.Description;
                                    END
                                    ELSE BEGIN
                                        GLAccnt.RESET;
                                        GLAccnt.SETFILTER(GLAccnt."No.", SL1."No.");
                                        IF GLAccnt.FINDFIRST THEN BEGIN
                                            itemNo := GLAccnt."No.";
                                            Desc := GLAccnt.Name;
                                        END;
                                    END;
                                    ChangeFlag := TRUE;
                                END;
                        END
                        ELSE
                            IF (CHLG."Field No." = 6) AND (CHLG."Table No." = 37) THEN BEGIN
                                IF (CHLG."Type of Change" <> 2) THEN BEGIN
                                    SL1.RESET;
                                    SL1.SETFILTER(SL1."Document No.", CHLG."Primary Key Field 2 Value");
                                    SL1.SETFILTER(SL1."Line No.", CHLG."Primary Key Field 3 Value");
                                    IF SL1.FINDFIRST THEN
                                        IF SL1."No." = CHLG."New Value" THEN BEGIN
                                            item.RESET;
                                            item.SETFILTER(item."No.", SL1."No.");
                                            IF item.FINDFIRST THEN BEGIN
                                                itemNo := item."No.";
                                                Desc := item.Description;
                                            END
                                            ELSE BEGIN
                                                itemNo := SL1."No.";
                                                Desc := SL1.Description;
                                            END;
                                            ChangeFlag := TRUE;
                                        END;
                                END
                                ELSE BEGIN
                                    item.RESET;
                                    item.SETFILTER(item."No.", CHLG."Old Value");
                                    IF item.FINDFIRST THEN BEGIN
                                        itemNo := item."No.";
                                        Desc := item.Description;
                                    END
                                    ELSE BEGIN
                                        GLAccnt.RESET;
                                        GLAccnt.SETFILTER(GLAccnt."No.", CHLG."Old Value");
                                        IF GLAccnt.FINDFIRST THEN BEGIN
                                            itemNo := GLAccnt."No.";
                                            Desc := GLAccnt.Name;
                                        END;
                                    END;
                                    ChangeFlag := TRUE;
                                END;
                            END;
                        IF ChangeFlag = TRUE THEN BEGIN
                            User.RESET;
                            User.SETFILTER(User."User Name", CHLG."User ID");
                            IF User.FINDFIRST THEN
                                username := User."Full Name"
                            ELSE
                                username := CHLG."User ID";
                            IF (CHLG."Field No." = 15) AND (CHLG."Table No." = 37) THEN BEGIN
                                IF (CHLG."Type of Change" = 1) AND (CHLG."Old Value" <> '0') THEN BEGIN
                                    TypeOfChange := 'Quantity Change';
                                    IF newflag = FALSE THEN BEGIN
                                        Body += ('<P>Orders Released on ' + FORMAT(headerdate) + ', </P>');
                                        Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Sale order No.</th><th >Customer</th><th>Line No.</th><th>Item No.</th><th>Description</th><th>Type of Change</th>');
                                        Body += ('<th>Changed Field</th><th>Previous Value</th><th>New Value</th><th>User ID</th><th>Time of Change</th></tr>');
                                        newflag := TRUE;
                                    END;
                                    IF (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/L') OR (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/T') THEN
                                        LMD_Count := 1;

                                    Body += ('<tr><td>' + CHLG."Primary Key Field 2 Value" + '</td><td>' + custname + '</td><td>' + CHLG."Primary Key Field 3 Value" + '</td><td>' + itemNo + '</td><td>' + Desc + '</td><td>' + TypeOfChange + '</td>');
                                    Body += ('<td>Quantity</td><td>' + CHLG."Old Value" + '</td><td>' + CHLG."New Value" + '</td><td>' + username + '</td><td>' + FORMAT(CHLG."Date and Time") + '</td></tr>');
                                    recCount := recCount + 1;
                                END
                            END
                            ELSE BEGIN
                                IF CHLG."Type of Change" = 1 THEN BEGIN
                                    TypeOfChange := 'Item Change';
                                END
                                ELSE
                                    IF CHLG."Type of Change" = 0 THEN BEGIN
                                        TypeOfChange := 'New Item Insertion';
                                    END
                                    ELSE
                                        IF CHLG."Type of Change" = 2 THEN BEGIN
                                            TypeOfChange := 'Item Deletion';
                                        END;
                                IF TypeOfChange <> 'New Item Insertion' THEN BEGIN
                                    IF CHLG."Old Value" <> '' THEN BEGIN
                                        IF newflag = FALSE THEN BEGIN
                                            Body += ('<P>Orders Released on ' + FORMAT(headerdate) + ', </P>');
                                            Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Sale order No.</th><th >Customer</th><th>Line No.</th><th>Item No.</th><th>Description</th><th>Type of Change</th>');
                                            Body += ('<th>Changed Field</th><th>Previous Value</th><th>New Value</th><th>User ID</th><th>Time of Change</th></tr>');
                                            newflag := TRUE;
                                        END;
                                        IF (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/L') OR (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/T') THEN
                                            LMD_Count := 1;

                                        Body += ('<tr><td>' + CHLG."Primary Key Field 2 Value" + '</td><td>' + custname + '</td><td>' + CHLG."Primary Key Field 3 Value" + '</td><td>' + itemNo + '</td><td>' + Desc + '</td><td>' + TypeOfChange + '</td>');
                                        Body += ('<td>Item No.</td><td>' + CHLG."Old Value" + '</td><td>' + CHLG."New Value" + '</td><td>' + username + '</td><td>' + FORMAT(CHLG."Date and Time") + '</td></tr>');
                                        recCount := recCount + 1;
                                    END;
                                END ELSE BEGIN
                                    IF newflag = FALSE THEN BEGIN
                                        Body += ('<P>Orders Released on ' + FORMAT(headerdate) + ', </P>');
                                        Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >Sale order No.</th><th >Customer</th><th>Line No.</th><th>Item No.</th><th>Description</th><th>Type of Change</th>');
                                        Body += ('<th>Changed Field</th><th>Previous Value</th><th>New Value</th><th>User ID</th><th>Time of Change</th></tr>');
                                        newflag := TRUE;
                                    END;
                                    IF (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/L') OR (COPYSTR(CHLG."Primary Key Field 2 Value", 14, 2) = '/T') THEN
                                        LMD_Count := 1;

                                    Body += ('<tr><td>' + CHLG."Primary Key Field 2 Value" + '</td><td>' + custname + '</td><td>' + CHLG."Primary Key Field 3 Value" + '</td><td>' + itemNo + '</td><td>' + Desc + '</td><td>' + TypeOfChange + '</td>');
                                    Body += ('<td>Item No.</td><td>' + CHLG."Old Value" + '</td><td>' + CHLG."New Value" + '</td><td>' + username + '</td><td>' + FORMAT(CHLG."Date and Time") + '</td></tr>');
                                    recCount := recCount + 1;
                                END;
                            END;
                        END;
                    END;
                END;
            UNTIL CHLG.NEXT = 0;
        Body += ('</table><br>');
        Body += ('<p align ="left"> Regards,<br>ERP Team </p>');
        Body += ('<br><p align = "center">:: Note: Auto Generated mail from ERP</b> :: </b></P></div></body></html>');
        IF LMD_Count > 0 THEN
            //SMTP_MAIL.AddRecipients('lmd@efftronics.com'); //B2BUPG
            Recipients.Add('lmd@efftronics.com');
        IF recCount > 0 THEN
            //SMTP_MAIL.Send;  //B2BUPG
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

    end;

    procedure ToBeShippedAMCAlert();
    var
        SH: Record "Sales Header";
        SL: Record "Sales Line";
        recCount: Integer;
        Cust: Record Customer;
        UnitPrice: Decimal;
        TotalPrice: Decimal;
    begin
        /* Mail_From := 'erp@efftronics.com';
        Mail_To := 'yesu@efftronics.com,prasanthi@efftronics.com,erp@efftronics.com,susmithal@efftronics.com'; */       //B2BUPG

        Recipients.Add('yesu@efftronics.com');
        Recipients.Add('prasanthi@efftronics.com');
        Recipients.Add('erp@efftronics.com');
        Recipients.Add('susmithal@efftronics.com');

        //Mail_To := 'pranavi@efftronics.com';
        Subject := 'Reg: Billing Deviated AMC Details';
        Body := '';
        //SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE); //B2BUPG
        EmailMessage.Create(Recipients, Subject, Body, true);
        Body += ('<html><head><style> divone{background-color: white; width: 9000px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>');
        Body += ('<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 800px;"><label><font size="6">Billing Deviated AMC Details</font></label>');
        Body += ('<hr style=solid; color= #3333CC>');
        Body += ('<h>Dear Sir/Madam,</h><br><br>');
        //Body += ('<h><b>Responsible Dept: <font color=red>Manufacturing.</b></font></h><br>');
        Body += ('<P> The below are details of To Be Shipped AMCs, </P>');
        Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >AMC order No.</th><th >Customer</th>');
        Body += ('<th>Line No.</th><th>Item No.</th><th>Description</th><th>Shipement Date</th><th>Deviated Days</th><th>Amount</th></tr>');
        recCount := 0;
        TotalPrice := 0;
        UnitPrice := 0;
        SL.RESET;
        SL.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
        //SL.SETFILTER(SL."Document Type", '%1', SL."Document Type"::Amc);
        SL.SETFILTER(SaleDocType, '%1', SL.SaleDocType::Amc);//EFFUPG1.5
        SL.SETFILTER(SL."Outstanding Quantity", '>%1', 0);
        SL.SETFILTER(SL."Shipment Date", '<%1&<>%2', TODAY(), 0D);
        IF SL.FINDSET THEN
            REPEAT
                Cust.RESET;
                Cust.GET(SL."Sell-to Customer No.");
                UnitPrice := 0;
                UnitPrice := SL."Unit Price";
                Body += ('<tr><td>' + SL."Document No." + '</td><td>' + Cust.Name + '</td><td align = "right">' + FORMAT(SL."Line No.") + '</td><td align = "center">' + SL."No." + '</td>');
                IF SL."Shipment Date" <> 0D THEN
                    Body += ('<td>' + SL.Description + '</td><td align = "center">' + FORMAT(SL."Shipment Date", 0, '<Day,2>-<Month Text,3>-<Year>') + '</td><td align = "right">' + FORMAT(TODAY() - SL."Shipment Date"))
                ELSE
                    Body += ('<td>' + SL.Description + '</td><td align = "center"> </td><td align = "right"> ');
                Body += ('</td><td align = "right">' + formataddress.ChangeCurrency(ROUND(UnitPrice)) + '</td></tr>');
                recCount := recCount + 1;
                TotalPrice += SL."Unit Price";
            UNTIL SL.NEXT = 0;
        Body += ('<tr><td colspan="7" align="center" style="color:#FF0000"><b>Total Amount</b></td><td align="right" style="color:#FF0000"><b>' + formataddress.ChangeCurrency(ROUND(TotalPrice)) + '</b></td></tr>');
        Body += ('</table><br>');
        Body += ('<p align ="left">Note:: Please clear the above orders</p>');
        Body += ('<p align ="left"> Regards,<br>ERP Team </p>');
        Body += ('<br><p align = "center">:: Note: Auto Generated mail from ERP</b> :: </b></P></div></body></html>');
        IF recCount > 0 THEN
            //SMTP_MAIL.Send;  //B2BUPG
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;

    procedure DispatchAssuranceMail1();
    var
        SIH: Record "Sales Invoice Header";
        SIL: Record "Sales Invoice Line";
        rowspan: Integer;
        recCount: Integer;
        Division: Record "Employee Statistics Group";
        Loc: Text;
        HandoverPerson: Text;
        ContactInfo: Text;
        user: Record User;
        SP: Record "Salesperson/Purchaser";
        SalesPerson: Text;
        headerdate: Date;
        LMD_count: Integer;
    begin

        //Var Initialization
        Subject := '';
        Mail_To := '';
        Mail_From := '';
        Body := '';
        headerdate := 0D;
        LMD_count := 0;
        //Initialization end

        IF DATE2DWY(TODAY(), 1) <> 1 THEN
            headerdate := CALCDATE('-1D', TODAY())
        ELSE
            headerdate := CALCDATE('-2D', TODAY());
        /* //Mail_From :='erp@efftronics.com';
        Mail_From := 'pmsubhani@efftronics.com';
        //Mail_To := 'pranavi@efftronics.com';
        Mail_To := 'erp@efftronics.com,pmsubhani@efftronics.com,padmaja@efftronics.com,projectmanagement@efftronics.com,cuspm@efftronics.com';
        Mail_To := Mail_To + ',pmurali@efftronics.com,bharat@efftronics.com,dineel@efftronics.com,prasanthi@efftronics.com,sales@efftronics.com'; */   //B2BUPG
        Recipients.Add('erp@efftronics.com');
        Recipients.Add('pmsubhani@efftronics.com');
        Recipients.Add('padmaja@efftronics.com');
        Recipients.Add('projectmanagement@efftronics.com');
        Recipients.Add('cuspm@efftronics.com');
        Recipients.Add('pmurali@efftronics.com');
        Recipients.Add('bharat@efftronics.com');
        Recipients.Add('dineel@efftronics.com');
        Recipients.Add('prasanthi@efftronics.com,');
        Recipients.Add('sales@efftronics.com');
        Subject := 'DISPATCH - Assurance for Dispatched Material Status on ' + FORMAT(headerdate);
        Body := '<html><head><style> divone{background-color: white; width: 1210px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>';
        Body := Body + '<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 1110px;"><label><font size="6">Assurance for Dispatched Material</font></label>';
        Body := Body + '<hr style=solid; color= #3333CC>';
        Body := Body + '<h>Dear Sir/Madam,</h><br><br>';
        Body := Body + '<P> The below are details of Assurance for dispatched material on ' + FORMAT(headerdate) + ', </P>';
        Body := Body + '<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th>Sales Person</th><th>Customer</th><th>Invoice No</th>';
        Body := Body + '<th>Sale Order No.</th><th>Consignee.</th><th>Invoice Date</th><th>Material Received On</th><th>Material Location</th><th>Mode of Transport</th>';
        Body := Body + '<th>HandOver Person</th><th>HandOver Person No.</th><th>Item Description</th><th>Quantity</th><th>Packet No.</th></tr>';
        SIH.RESET;
        SIH.SETFILTER(SIH."BizTalk Document Sent", '%1', TRUE);
        SIH.SETFILTER(SIH."Dispatch Assurance Date", '%1', headerdate);
        IF SIH.FINDSET THEN
            REPEAT
                rowspan := 0;
                HandoverPerson := '';
                ContactInfo := '';
                SalesPerson := '';
                Division.RESET;
                Division.SETFILTER(Division.Code, SIH."Dispatched Location");
                IF Division.FINDFIRST THEN
                    Loc := Division."Division Name";
                SIL.RESET;
                SIL.SETFILTER(SIL."Document No.", SIH."No.");
                SIL.SETFILTER(SIL.Quantity, '>%1', 0);
                IF SIL.FINDSET THEN
                    rowspan := SIL.COUNT;
                SP.RESET;
                SP.SETFILTER(SP.Code, SIH."Salesperson Code");
                IF SP.FINDFIRST THEN
                    SalesPerson := SP.Name;
                IF SIH."Hand Overed Person" <> '' THEN BEGIN
                    user.RESET;
                    user.SETFILTER(user."User Name", SIH."Hand Overed Person");
                    IF user.FINDFIRST THEN
                        HandoverPerson := user."Full Name";
                    ContactInfo := SIH."Contact Info";
                END
                ELSE BEGIN
                    HandoverPerson := SIH."Hand Overed Person(Others)";
                    ContactInfo := SIH."Contact Info(Others)";
                END;
                IF (COPYSTR(SIH."Order No.", 14, 2) = '/L') OR (COPYSTR(SIH."Order No.", 14, 2) = '/T') THEN
                    LMD_count := 1;

                Body := Body + '<tr><td rowspan ="' + FORMAT(rowspan + 1) + '">' + FORMAT(SalesPerson) + '</td><td rowspan ="' + FORMAT(rowspan + 1) + '">' + FORMAT(SIH."Sell-to Customer Name") + '</td><td rowspan ="' + FORMAT(rowspan + 1) + '">' + FORMAT(SIH."External Document No.") + '</td>';
                Body := Body + '<td rowspan ="' + FORMAT(rowspan + 1) + '">' + FORMAT(SIH."Order No.") + '</td><td rowspan ="' + FORMAT(rowspan + 1) + '">' + FORMAT(SIH."Consignee Name") + '</td><td rowspan ="' + FORMAT(rowspan + 1) + '">' + FORMAT(SIH."Posting Date") + '</td>';
                Body := Body + '<td rowspan ="' + FORMAT(rowspan + 1) + '">' + FORMAT(SIH."Date Sent") + '</td><td rowspan ="' + FORMAT(rowspan + 1) + '">' + Loc + '</td><td rowspan ="' + FORMAT(rowspan + 1) + '">' + FORMAT(SIH."Transport Method") + '</td>';
                Body := Body + '<td rowspan ="' + FORMAT(rowspan + 1) + '">' + HandoverPerson + '</td><td rowspan ="' + FORMAT(rowspan + 1) + '">' + ContactInfo + '</td></tr>';
                /*
                Body := Body+'<tr><td>'+SalesPerson+'</td><td>'+FORMAT(SIH."Sell-to Customer Name")+'</td><td>'+FORMAT(SIH."External Document No.")+'</td>';
                Body := Body+'<td>'+FORMAT(SIH."Order No.")+'</td><td>'+FORMAT(SIH."Consignee Name")+'</td><td>'+FORMAT(SIH."Posting Date")+'</td>';
                Body := Body+'<td>'+FORMAT(SIH."Date Sent")+'</td><td>'+Loc+'</td><td>'+FORMAT(SIH."Transport Method")+'</td>';
                Body := Body+'<td>'+HandoverPerson+'</td><td>'+ContactInfo+'</td>';
                */
                SIL.RESET;
                SIL.SETFILTER(SIL."Document No.", SIH."No.");
                SIL.SETFILTER(SIL.Quantity, '>%1', 0);
                IF SIL.FINDSET THEN
                    REPEAT
                        Body := Body + '<td>' + SIL.Description + '</td><td>' + FORMAT(SIL.Quantity) + '</td><td>' + FORMAT(SIL."Packet No") + '</td></tr>';
                    UNTIL SIL.NEXT = 0;
                recCount := recCount + 1;
            UNTIL SIH.NEXT = 0;

        Body := Body + '</table><br>';
        Body := Body + '<p align ="left"><br>*** I confirmed from Customer/Site Person,that Material has Reached and Packing Condition Also Satisfactory ***</p>';
        //Body := Body+'<p align ="left"> Regards,<br>ERP Team </p>';
        Body := Body + '<br><p align = "center">:: Note: Auto Generated mail from ERP</b> :: </b></P></div></body></html>';
        IF LMD_count > 0 THEN
            //Mail_To := Mail_To + ',lmd@efftronics.com'; //B2BUPG
            Recipients.Add('lmd@efftronics.com');
        //SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE); //B2BUPG
        EmailMessage.Create(Recipients, Subject, Body, true);
        //MESSAGE(Body);
        IF recCount > 0 THEN
            //SMTP_MAIL.Send;       //B2BUPG
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

    end;


    procedure SDStatusUpdation();
    var
        SIH: Record "Sales Invoice Header";
        BG: Record "Bank Guarantee";
        SIDummy: Record "Sales Invoice-Dummy";
        GLEntry: Record "G/L Entry";
        SDPaidAmt: Decimal;
        SDReceivedAmt: Decimal;
        SQLQuery: Text[1000];
        RowCount: Integer;
        ConnectionOpen: Integer;
        //>> ORACLE UPG
        // SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
        // RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        //<< ORACLE UPG
        SDId: Integer;
        Updated: Boolean;
        "Order": Text;
        PrevOrderNo: Code[30];
    begin
        // Added by Pranavi on 27-Jun-2016 for SD Status Updation
        //MESSAGE('SD Status Updation!');
        //Initialization start
        RowCount := 0;
        SDId := 0;
        SQLQuery := '';
        PrevOrderNo := '';
        Updated := FALSE;
        //Initializations end

        //>> ORACLE UPG
        /* IF ISCLEAR(SQLConnection) THEN
            CREATE(SQLConnection, FALSE, TRUE);

        IF ISCLEAR(RecordSet) THEN
            CREATE(RecordSet, FALSE, TRUE);

        IF ConnectionOpen <> 1 THEN BEGIN
            SQLConnection.ConnectionString := 'DSN=CASHFLOW;UID=cashflowuser;PASSWORD=firewall123;SERVER=oracle_80;';
            SQLConnection.Open;
            SQLConnection.BeginTrans;
            ConnectionOpen := 1;
        END; */
        //<< ORACLE UPG

        //Order := 'EFF/SAL/14-15/245|EFF/SAL/12-13/384|EFF/SAL/14-15/361|EFF/SAL/15-16/0374';
        SIH.RESET;
        SIH.SETCURRENTKEY("Order No.");
        //SIH.SETFILTER(SIH."Order No.",Order);
        SIH.SETRANGE(SIH.SecDepStatus, SIH.SecDepStatus::Warranty);
        SIH.SETFILTER(SIH."SD Status", '<>%1', SIH."SD Status"::NA);
        IF SIH.FINDSET THEN
            REPEAT
                IF PrevOrderNo <> SIH."Order No." THEN BEGIN
                    IF (SIH."Final Railway Bill Date" <> 0D) THEN BEGIN
                        IF (FORMAT(SIH."Warranty Period") <> '') THEN BEGIN
                            IF CALCDATE(FORMAT(SIH."Warranty Period"), SIH."Final Railway Bill Date") < TODAY() THEN BEGIN
                                SIH.VALIDATE(SIH.SecDepStatus, SIH.SecDepStatus::Due);
                                SIH.MODIFY;
                            END;
                        END
                        ELSE BEGIN
                            BG.RESET;
                            BG.SETRANGE(BG."Doc No.", SIH."Order No.");
                            IF BG.FINDLAST THEN BEGIN
                                IF FORMAT(BG."Warranty Period") <> '' THEN BEGIN
                                    SIH."Warranty Period" := BG."Warranty Period";
                                    IF CALCDATE(FORMAT(SIH."Warranty Period"), SIH."Final Railway Bill Date") < TODAY() THEN
                                        SIH.VALIDATE(SIH.SecDepStatus, SIH.SecDepStatus::Due);
                                    SIH.MODIFY;
                                END;
                            END;
                        END;
                    END
                    ELSE BEGIN
                        BG.RESET;
                        BG.SETRANGE(BG."Doc No.", SIH."Order No.");
                        IF BG.FINDLAST THEN BEGIN
                            IF BG."Final Railway Bill Date" <> 0D THEN BEGIN
                                SIH."Final Railway Bill Date" := BG."Final Railway Bill Date";
                                IF FORMAT(BG."Warranty Period") <> '' THEN BEGIN
                                    SIH."Warranty Period" := BG."Warranty Period";
                                    IF CALCDATE(FORMAT(SIH."Warranty Period"), SIH."Final Railway Bill Date") < TODAY() THEN
                                        SIH.VALIDATE(SIH.SecDepStatus, SIH.SecDepStatus::Due);
                                    SIH.MODIFY;
                                END;
                            END;
                        END;
                        IF SIH."Final Railway Bill Date" = 0D THEN BEGIN
                            GLEntry.RESET;
                            GLEntry.SETRANGE(GLEntry."Final Bill Payment", TRUE);
                            GLEntry.SETRANGE(GLEntry."Sale Order No.", SIH."Order No.");
                            IF GLEntry.FINDLAST THEN BEGIN
                                SIH."Final Railway Bill Date" := GLEntry."Posting Date";
                                IF CALCDATE(FORMAT(SIH."Warranty Period"), SIH."Final Railway Bill Date") < TODAY() THEN
                                    SIH.VALIDATE(SIH.SecDepStatus, SIH.SecDepStatus::Due);
                                SIH.MODIFY;
                            END;
                        END;
                    END;
                    IF COPYSTR(SIH."Order No.", 5, 3) = 'AMC' THEN BEGIN
                        IF SIH."Final Railway Bill Date" <> 0D THEN BEGIN
                            SIH.VALIDATE(SIH.SecDepStatus, SIH.SecDepStatus::Due);
                            SIH.MODIFY;
                        END;
                    END;

                    //>> ORACLE UPG
                    /* IF SIH."Final Railway Bill Date" <> 0D THEN BEGIN
                       SDId := 0;
                       SQLQuery := '';
                       SQLQuery := 'SELECT * FROM MRP_SECURITY_DEPOSIT WHERE INT_SAL_ORD_NO = ''' + FORMAT(SIH."Order No.") + ''' AND SD_STATUS = ''N''';
                       //MESSAGE(SQLQuery);
                       RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
                       IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                           RecordSet.MoveFirst;

                       WHILE NOT RecordSet.EOF DO BEGIN
                           SDId := RecordSet.Fields.Item('SD_ID').Value;
                           RowCount := RowCount + 1;
                           RecordSet.MoveNext;
                       END;
                       IF SDId <> 0 THEN BEGIN
                           SQLQuery := 'UPDATE MRP_SECURITY_DEPOSIT SET WARRANTY_PERIOD = ''' + FORMAT(SIH."Warranty Period") + ''', SD_FINAL_BILL_DATE = to_date(''' +
                           FORMAT(SIH."Final Railway Bill Date", 0, '<Day>-<Month Text,3>-<Year4>') + ''',''dd-mon-yyyy'') WHERE INT_SAL_ORD_NO = ''' + FORMAT(SIH."Order No.") + '''';
                           SQLConnection.Execute(SQLQuery);
                           Updated := TRUE;
                       END;
                   END; */
                    //<< ORACLE UPG
                END;
                PrevOrderNo := SIH."Order No.";
            UNTIL SIH.NEXT = 0;
        SIH.RESET;
        SIH.SETCURRENTKEY("Order No.");
        //SIH.SETFILTER(SIH."Order No.",Order);
        SIH.SETRANGE(SIH.SecDepStatus, SIH.SecDepStatus::Running);
        SIH.SETFILTER(SIH."SD Status", '<>%1', SIH."SD Status"::NA);
        IF SIH.FINDSET THEN
            REPEAT
                IF PrevOrderNo <> SIH."Order No." THEN BEGIN
                    BG.RESET;
                    BG.SETRANGE(BG."Doc No.", SIH."Order No.");
                    IF BG.FINDLAST THEN BEGIN
                        IF BG."Final Railway Bill Date" <> 0D THEN BEGIN
                            SIH.VALIDATE(SIH."Final Railway Bill Date", BG."Final Railway Bill Date");
                            IF FORMAT(BG."Warranty Period") <> '' THEN BEGIN
                                SIH.VALIDATE(SIH."Warranty Period", BG."Warranty Period");
                                IF CALCDATE(FORMAT(SIH."Warranty Period"), SIH."Final Railway Bill Date") < TODAY() THEN
                                    SIH.VALIDATE(SIH.SecDepStatus, SIH.SecDepStatus::Due)
                                ELSE
                                    SIH.VALIDATE(SIH.SecDepStatus, SIH.SecDepStatus::Warranty);
                                SIH.MODIFY;
                            END;
                        END;
                    END;
                    IF SIH."Final Railway Bill Date" = 0D THEN BEGIN
                        GLEntry.RESET;
                        GLEntry.SETRANGE(GLEntry."Final Bill Payment", TRUE);
                        GLEntry.SETRANGE(GLEntry."Sale Order No.", SIH."Order No.");
                        IF GLEntry.FINDLAST THEN BEGIN
                            SIH.VALIDATE(SIH."Final Railway Bill Date", GLEntry."Posting Date");
                            IF CALCDATE(FORMAT(SIH."Warranty Period"), SIH."Final Railway Bill Date") < TODAY() THEN
                                SIH.VALIDATE(SIH.SecDepStatus, SIH.SecDepStatus::Due)
                            ELSE
                                SIH.VALIDATE(SIH.SecDepStatus, SIH.SecDepStatus::Warranty);
                            SIH.MODIFY;
                        END;
                    END;
                    IF COPYSTR(SIH."Order No.", 5, 3) = 'AMC' THEN BEGIN
                        IF SIH."Final Railway Bill Date" <> 0D THEN BEGIN
                            SIH.VALIDATE(SIH.SecDepStatus, SIH.SecDepStatus::Due);
                            SIH.MODIFY;
                        END;
                    END;
                    //>> ORACLE UPG
                    /* IF SIH."Final Railway Bill Date" <> 0D THEN BEGIN
                        SDId := 0;
                        SQLQuery := '';
                        SQLQuery := 'SELECT * FROM MRP_SECURITY_DEPOSIT WHERE INT_SAL_ORD_NO = ''' + FORMAT(SIH."Order No.") + ''' AND SD_STATUS = ''N''';
                        //MESSAGE(SQLQuery);
                        RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
                        IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                            RecordSet.MoveFirst;

                        WHILE NOT RecordSet.EOF DO BEGIN
                            SDId := RecordSet.Fields.Item('SD_ID').Value;
                            RowCount := RowCount + 1;
                            RecordSet.MoveNext;
                        END;
                        IF SDId <> 0 THEN BEGIN
                            SQLQuery := 'UPDATE MRP_SECURITY_DEPOSIT SET WARRANTY_PERIOD = ''' + FORMAT(SIH."Warranty Period") + ''', SD_FINAL_BILL_DATE = to_date(''' +
                            FORMAT(SIH."Final Railway Bill Date", 0, '<Day>-<Month Text,3>-<Year4>') + ''',''dd-mon-yyyy'') WHERE INT_SAL_ORD_NO = ''' + FORMAT(SIH."Order No.") + '''';
                            SQLConnection.Execute(SQLQuery);
                            Updated := TRUE;
                        END;
                    END; */
                    //<< ORACLE UPG
                END;
                PrevOrderNo := SIH."Order No.";
            UNTIL SIH.NEXT = 0;
        SIH.RESET;
        SIH.SETCURRENTKEY("Order No.");
        SIH.SETRANGE(SIH.SecDepStatus, SIH.SecDepStatus::Due);
        SIH.SETFILTER(SIH."SD Status", '<>%1', SIH."SD Status"::NA);
        //SIH.SETFILTER(SIH."Order No.",Order);
        IF SIH.FINDSET THEN
            REPEAT
                SDReceivedAmt := 0;
                SDPaidAmt := 0;
                IF PrevOrderNo <> SIH."Order No." THEN BEGIN
                    GLEntry.RESET;
                    GLEntry.SETRANGE(GLEntry."Final Bill Payment", TRUE);
                    GLEntry.SETRANGE(GLEntry."Sale Order No.", SIH."Order No.");
                    IF GLEntry.FINDLAST THEN
                        REPEAT
                            IF GLEntry.Amount > 0 THEN
                                SDPaidAmt += GLEntry.Amount
                            ELSE
                                SDReceivedAmt += GLEntry.Amount;
                        UNTIL GLEntry.NEXT = 0;
                    //>> ORACLE UPG
                    /* IF (SDPaidAmt = SDReceivedAmt) AND (SDPaidAmt = SIH."Security Deposit Amount") THEN BEGIN
                        SIH."SD Status" := SIH."SD Status"::Received;
                        SIH.VALIDATE(SIH.SecDepStatus, SIH.SecDepStatus::Received);
                        SIH.MODIFY;
                        SDId := 0;
                        SQLQuery := '';
                        SQLQuery := 'SELECT * FROM MRP_SECURITY_DEPOSIT WHERE INT_SAL_ORD_NO = ''' + FORMAT(SIH."Order No.") + ''' AND SD_STATUS = ''N''';
                        //MESSAGE(SQLQuery);
                        RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
                        IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                            RecordSet.MoveFirst;

                        WHILE NOT RecordSet.EOF DO BEGIN
                            SDId := RecordSet.Fields.Item('SD_ID').Value;
                            RowCount := RowCount + 1;
                            RecordSet.MoveNext;
                        END;
                        IF SDId <> 0 THEN BEGIN
                            SQLQuery := 'UPDATE MRP_SECURITY_DEPOSIT SET SD_STATUS = ''Y'' WHERE SD_ID = ' + FORMAT(SDId) + ' AND INT_SAL_ORD_NO = ''' + FORMAT(SIH."Order No.") + '''';
                            // MESSAGE(SQLQuery);
                            SQLConnection.Execute(SQLQuery);
                            Updated := TRUE;
                        END;
                    END; */
                    //<< ORACLE UPG
                END;
                PrevOrderNo := SIH."Order No.";
            UNTIL SIH.NEXT = 0;
        //>> ORACLE UPG
        /* IF Updated = TRUE THEN BEGIN
            SQLConnection.CommitTrans;
            RecordSet.Close;
            SQLConnection.Close;
            ConnectionOpen := 0;
        END; */
        //<< ORACLE UPG

        // End by Pranavi
    end;


    procedure DCTrackingStatusUpdate();
    var
        CSH: Record "CS Transaction Header";
        CStL: Record "CS Stock Ledger";
        DCH: Record "DC Header";
        //>> ORACLE UPG
        //SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
        //RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        //<< ORACLE UPG
        SQLQuery: Text[1000];
        dcnum: Text;
        docnum: Text;
        Courier: Text;
        DCCOunt: Integer;
    begin
        //>> ORACLE UPG
        /* IF ISCLEAR(SQLConnection) THEN
            CREATE(SQLConnection, FALSE, TRUE);
        IF ISCLEAR(RecordSet) THEN
            CREATE(RecordSet, FALSE, TRUE);
        SQLConnection.ConnectionString := 'DSN=intranet;UID=sa;PASSWORD=admin@123;SERVER:=intranet;providerName=System.Data.SqlClient;';
        SQLConnection.Open;

        CSH.RESET;
        CSH.SETRANGE(CSH."Transaction Status", CSH."Transaction Status"::"In-Transit");
        //CSH.SETRANGE(CSH."Mode of Transport",CSH."Mode of Transport"::Courier);
        //CSH.SETFILTER(CSH."Transaction ID",'%1','CST0018638');
        IF CSH.FINDSET THEN
            REPEAT
                    CStL.RESET;
                CStL.SETRANGE(CStL."Transaction ID", CSH."Transaction ID");
                IF CStL.FINDFIRST THEN BEGIN
                    DCH.RESET;
                    DCH.SETRANGE(DCH."No.", CStL."DC No");
                    DCH.SETFILTER(DCH."Mode Of Transport", '%1', 'Courier');
                    DCH.SETFILTER(DCH."Docket No", '%1|%2|%3|%4', '', '0', 'NOT AVAILABLE', 'PENDING');
                    IF DCH.FINDFIRST THEN BEGIN
                        dcnum := '';
                        docnum := '';
                        Courier := '';
                        SQLQuery := '';
                        SQLQuery := ' SELECT  nvarchar4 AS CITY, nvarchar6 AS MODE, nvarchar7 AS DOCNUM, nvarchar1 AS DC FROM  [WSS_Content].[dbo].[AllUserData] ' +
                                     ' WHERE (tp_ListId = ' + '''D9CE8F4F-70CA-45C8-BD9D-67AC0531848C'')' + ' and (nvarchar1 like ''%' + FORMAT(DCH."No.") + '%'') ' +
                                     ' ORDER BY [tp_Created] DESC';
                        RecordSet := SQLConnection.Execute(SQLQuery);
                        IF NOT (RecordSet.EOF OR RecordSet.BOF) THEN BEGIN
                            IF NOT ISNULL(RecordSet.Fields.Item('DOCNUM').Value) THEN
                                docnum := FORMAT(RecordSet.Fields.Item('DOCNUM').Value);
                            IF NOT ISNULL(RecordSet.Fields.Item('MODE').Value) THEN
                                Courier := FORMAT(RecordSet.Fields.Item('MODE').Value);
                        END;
                        IF (docnum <> '') THEN BEGIN
                            DCH."Docket No" := docnum;
                            DCH."Courier Agency Name" := Courier;
                            DCH.MODIFY;
                            DCCOunt := DCCOunt + 1;
                        END
                        ELSE BEGIN
                            DCH."Docket No" := 'NOT AVAILABLE';
                            DCH.MODIFY;
                        END;
                    END;
                END;
            UNTIL CSH.NEXT = 0;
        SQLConnection.Close; */
        //<< ORACLE UPG
    end;

    procedure PurchaseDCStatusUpdate();
    var
        DCH: Record "DC Header";
        dcnum: Text;
        docnum: Text;
        Courier: Text;
        DCCOunt: Integer;
        tempdate: Date;
    //>> ORACLE UPG
    // SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
    //RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
    //<< ORACLE UPG
    begin
        //>> ORACLE UPG
        /* IF ISCLEAR(SQLConnection) THEN
            CREATE(SQLConnection, FALSE, TRUE);
        IF ISCLEAR(RecordSet) THEN
            CREATE(RecordSet, FALSE, TRUE);
        SQLConnection.ConnectionString := 'DSN=intranet;UID=sa;PASSWORD=admin@123;SERVER:=intranet;providerName=System.Data.SqlClient;';
        SQLConnection.Open;
        EVALUATE(tempdate, '01-10-2016');
        DCH.RESET;
        DCH.SETFILTER(DCH."No.", '%1', 'STR/DC/*');
        DCH.SETRANGE(DCH.Type, DCH.Type::Vendor);
        DCH.SETFILTER(DCH."Created Date", '>=%1', tempdate);
        DCH.SETRANGE(DCH.Returned, FALSE);
        DCH.SETFILTER(DCH."Mode Of Transport", '%1', 'Courier');
        DCH.SETFILTER(DCH."Docket No", '%1|%2|%3|%4', '', '0', 'NOT AVAILABLE', 'PENDING');
        IF DCH.FINDSET THEN
            REPEAT
                    dcnum := '';
                docnum := '';
                Courier := '';
                SQLQuery := '';
                SQLQuery := ' SELECT  nvarchar4 AS CITY, nvarchar6 AS MODE, nvarchar7 AS DOCNUM, nvarchar1 AS DC FROM  [WSS_Content].[dbo].[AllUserData] ' +
                             ' WHERE (tp_ListId = ' + '''D9CE8F4F-70CA-45C8-BD9D-67AC0531848C'')' + ' and (nvarchar1 like ''%' + FORMAT(DCH."No.") + '%'') ' +
                             ' ORDER BY [tp_Created] DESC';
                RecordSet := SQLConnection.Execute(SQLQuery);
                IF NOT (RecordSet.EOF OR RecordSet.BOF) THEN BEGIN
                    IF NOT ISNULL(RecordSet.Fields.Item('DOCNUM').Value) THEN
                        docnum := FORMAT(RecordSet.Fields.Item('DOCNUM').Value);
                    IF NOT ISNULL(RecordSet.Fields.Item('MODE').Value) THEN
                        Courier := FORMAT(RecordSet.Fields.Item('MODE').Value);
                END;
                IF (docnum <> '') THEN BEGIN
                    DCH."Docket No" := docnum;
                    DCH."Courier Agency Name" := Courier;
                    DCH.MODIFY;
                    DCCOunt := DCCOunt + 1;
                END;
            UNTIL DCH.NEXT = 0;
        SQLConnection.Close; */
        //<< ORACLE UPG
    end;

    procedure ToBePlannedBOIAlert();
    var
        SH: Record "Sales Header";
        SCH: Record Schedule2;
        Body: Text;
        Subject: Text;
        Mail_To: Text;
        Mail_From: Text;
        //EmailMessage: Codeunit 8904;
        //Email: Codeunit 8901;
        Recipients: List of [Text];
        //SMTP_MAIL: Codeunit "SMTP Mail";
        recCount: Integer;
        Item: Record Item;
        SHA: Record "Sales Header Archive";
        ReleasedFlag: Boolean;
        SL: Record "Sales Line";
        SCH_Count: Integer;
        ReleaseDate: Date;
        SFT: Code[10];
    begin
        //MESSAGE('To Be Planned BOI Items Alert!');
        //Var Initialization
        /* Subject := '';
        Mail_To := '';
        Mail_From := '';
        Body := '';
        recCount := 0;
        //Initialization end
        Mail_From := 'erp@efftronics.com';
        //Mail_To := 'pranavi@efftronics.com';
        Mail_To := 'erp@efftronics.com,controlroom@efftronics.com';
        Subject := 'ERP - To Be Planned Sales Bought-Out Items';
        Body := '<html><head><style> divone{background-color: white; width: 1210px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>';
        Body := Body + '<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 1110px;"><label><font size="6">To Be Planned Sales Bought-Out Items</font></label>';
        Body := Body + '<hr style=solid; color= #3333CC>';
        Body := Body + '<h>Dear Sir/Madam,</h><br><br>';
        Body := Body + '<P> The below are details of To Be Planned Sales Bought-Out Items, </P>';
        Body := Body + '<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th>Sale Order No.</th><th>Customer</th><th>Order Released Date</th>';
        Body := Body + '<th>Line No.</th><th>Sch. Line No.</th><th>Item No.</th><th>Item Description</th><th>Lead Time</th><th>Quantity</th><th>To Be Executed Qty</th></tr>';
        ReleasedFlag := FALSE;
        SH.RESET;
        //SH.SETRANGE(SH."No.",'EFF/SAL/16-17/0213');
        SH.SETRANGE(SH."Document Type", SH."Document Type"::Order);
        IF SH.FINDFIRST THEN
            REPEAT
                ReleasedFlag := FALSE;
                IF SH.Status = SH.Status::Released THEN
                    ReleasedFlag := TRUE
                ELSE BEGIN
                    SHA.RESET;
                    SHA.SETRANGE(SHA."No.", SH."No.");
                    IF (SHA.FINDFIRST) AND (NOT (SH."No." IN ['EFF/SAL/17-18/0163', 'EFF/SAL/17-18/0158'])) THEN
                        ReleasedFlag := TRUE;
                END;
                ReleaseDate := 0D;
                IF (ReleasedFlag = TRUE) THEN BEGIN
                    ReleaseDate := 0D;
                    EVALUATE(ReleaseDate, FORMAT(SH."Order Released Date"));
                    IF (TODAY() - ReleaseDate > 2) THEN BEGIN
                        SL.RESET;
                        SL.SETRANGE(SL."Document No.", SH."No.");
                        SL.SETFILTER(SL.Quantity, '>%1', 0);
                        SL.SETFILTER(SL."No.", '<>%1', '');
                        SL.SETRANGE(SL."Pending By", SL."Pending By"::" ");
                        SL.SETFILTER(SL."Outstanding Quantity", '>%1', 0);
                        IF SL.FINDSET THEN
                            REPEAT
                                SFT := '';
                                IF (SL."Gen. Prod. Posting Group" IN ['BOI', 'RAW-MAT']) AND (SL."Outstanding Quantity" > 0) AND (SL."Planned Dispatch Date" = 0D) AND NOT (SL."No." IN ['BOICHAR00014', 'ECBOUBT00004']) THEN BEGIN
                                    Item.RESET;
                                    IF Item.GET(SL."No.") THEN
                                        SFT := FORMAT(Item."Safety Lead Time");
                                    Body := Body + '<tr><td>' + SH."No." + '</td><td>' + SH."Sell-to Customer Name" + '</td><td>' + FORMAT(SH."Order Released Date", 0, '<Day,2>-<Month Text,3>-<Year>') + '</td>';
                                    Body := Body + '<td>' + FORMAT(SL."Line No.") + '</td><td>' + '' + '</td><td>' + FORMAT(SL."No.") + '</td><td>' + SL.Description + '</td><td>' + SFT + '</td>';
                                    Body := Body + '<td align="right">' + FORMAT(SL.Quantity) + '</td><td align="right">' + FORMAT(SL."Outstanding Quantity") + '</td></tr>';
                                    recCount := recCount + 1;
                                END;
                                SFT := '';
                                SCH.RESET;
                                SCH.SETRANGE(SCH."Document No.", SL."Document No.");
                                SCH.SETRANGE(SCH."Document Line No.", SL."Line No.");
                                SCH.SETFILTER(SCH."Posting Group", '%1|%2', 'RAW-MAT', 'BOI');
                                SCH.SETFILTER(SCH.Quantity, '>%1', 0);
                                SCH.SETFILTER(SCH."No.", '<>%1', '');
                                SCH.SETFILTER(SCH."Outstanding Qty.", '>%1', 0);
                                IF SCH.FINDSET THEN
                                    REPEAT
                                        SFT := '';
                                        IF (SCH."Document Line No." <> SCH."Line No.") AND (SCH."Planned Dispatch Date" = 0D) AND NOT (SCH."No." IN ['BOICHAR00014', 'ECBOUBT00004']) THEN BEGIN
                                            Item.RESET;
                                            IF Item.GET(SCH."No.") THEN
                                                SFT := FORMAT(Item."Safety Lead Time");
                                            Body := Body + '<tr style="color:#FF0000"><td>' + SH."No." + '</td><td>' + SH."Sell-to Customer Name" + '</td><td>' + FORMAT(SH."Order Released Date", 0, '<Day,2>-<Month Text,3>-<Year>') + '</td>';
                                            Body := Body + '<td>' + FORMAT(SL."Line No.") + '</td><td>' + FORMAT(SCH."Line No.") + '</td><td>' + FORMAT(SCH."No.") + '</td><td>' + SCH.Description + '</td></td><td>' + SFT + '</td>';
                                            Body := Body + '<td align="right">' + FORMAT(SCH.Quantity) + '</td><td align="right">' + FORMAT(SCH."Outstanding Qty.") + '</td></tr>';
                                            recCount := recCount + 1;
                                            SCH_Count := SCH_Count + 1;
                                        END;
                                    UNTIL SCH.NEXT = 0;
                            UNTIL SL.NEXT = 0;
                    END;
                END;
            UNTIL SH.NEXT = 0;
        IF recCount > 0 THEN
            Body := Body + '<tr style="color:#FF0000"><td colspan="9" align="center"><b>Total Items</b></td><td align="right"><b>' + FORMAT(recCount) + '</b></td></tr>';
        Body := Body + '</table><br>';
        IF SCH_Count > 0 THEN
            Body := Body + '<p align ="left" style="color:#FF0000"><br>Note: Red Color Items are Schedule Items</p>';
        Body := Body + '<p align ="left"> Regards,<br>ERP Team </p>';
        Body := Body + '<br><p align = "center">:: Note: Auto Generated mail from ERP</b> :: </b></P></div></body></html>';
        SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
        //MESSAGE(Body);
        IF recCount > 0 THEN
            SMTP_MAIL.Send; */  //B2BUPG

        Subject := '';
        Body := '';
        recCount := 0;
        Recipients.Add('erp@efftronics.com');
        Recipients.Add('controlroom@efftronics.com');
        Subject := 'ERP - To Be Planned Sales Bought-Out Items';
        Body := '<html><head><style> divone{background-color: white; width: 1210px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>';
        Body := Body + '<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 1110px;"><label><font size="6">To Be Planned Sales Bought-Out Items</font></label>';
        Body := Body + '<hr style=solid; color= #3333CC>';
        Body := Body + '<h>Dear Sir/Madam,</h><br><br>';
        Body := Body + '<P> The below are details of To Be Planned Sales Bought-Out Items, </P>';
        Body := Body + '<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th>Sale Order No.</th><th>Customer</th><th>Order Released Date</th>';
        Body := Body + '<th>Line No.</th><th>Sch. Line No.</th><th>Item No.</th><th>Item Description</th><th>Lead Time</th><th>Quantity</th><th>To Be Executed Qty</th></tr>';
        ReleasedFlag := FALSE;
        SH.RESET;
        //SH.SETRANGE(SH."No.",'EFF/SAL/16-17/0213');
        SH.SETRANGE(SH."Document Type", SH."Document Type"::Order);
        IF SH.FINDFIRST THEN
            REPEAT
                ReleasedFlag := FALSE;
                IF SH.Status = SH.Status::Released THEN
                    ReleasedFlag := TRUE
                ELSE BEGIN
                    SHA.RESET;
                    SHA.SETRANGE(SHA."No.", SH."No.");
                    IF (SHA.FINDFIRST) AND (NOT (SH."No." IN ['EFF/SAL/17-18/0163', 'EFF/SAL/17-18/0158'])) THEN
                        ReleasedFlag := TRUE;
                END;
                ReleaseDate := 0D;
                IF (ReleasedFlag = TRUE) THEN BEGIN
                    ReleaseDate := 0D;
                    EVALUATE(ReleaseDate, FORMAT(SH."Order Released Date"));
                    IF (TODAY() - ReleaseDate > 2) THEN BEGIN
                        SL.RESET;
                        SL.SETRANGE(SL."Document No.", SH."No.");
                        SL.SETFILTER(SL.Quantity, '>%1', 0);
                        SL.SETFILTER(SL."No.", '<>%1', '');
                        SL.SETRANGE(SL."Pending By", SL."Pending By"::" ");
                        SL.SETFILTER(SL."Outstanding Quantity", '>%1', 0);
                        IF SL.FINDSET THEN
                            REPEAT
                                SFT := '';
                                IF (SL."Gen. Prod. Posting Group" IN ['BOI', 'RAW-MAT']) AND (SL."Outstanding Quantity" > 0) AND (SL."Planned Dispatch Date" = 0D) AND NOT (SL."No." IN ['BOICHAR00014', 'ECBOUBT00004']) THEN BEGIN
                                    Item.RESET;
                                    IF Item.GET(SL."No.") THEN
                                        SFT := FORMAT(Item."Safety Lead Time");
                                    Body := Body + '<tr><td>' + SH."No." + '</td><td>' + SH."Sell-to Customer Name" + '</td><td>' + FORMAT(SH."Order Released Date", 0, '<Day,2>-<Month Text,3>-<Year>') + '</td>';
                                    Body := Body + '<td>' + FORMAT(SL."Line No.") + '</td><td>' + '' + '</td><td>' + FORMAT(SL."No.") + '</td><td>' + SL.Description + '</td><td>' + SFT + '</td>';
                                    Body := Body + '<td align="right">' + FORMAT(SL.Quantity) + '</td><td align="right">' + FORMAT(SL."Outstanding Quantity") + '</td></tr>';
                                    recCount := recCount + 1;
                                END;
                                SFT := '';
                                SCH.RESET;
                                SCH.SETRANGE(SCH."Document No.", SL."Document No.");
                                SCH.SETRANGE(SCH."Document Line No.", SL."Line No.");
                                SCH.SETFILTER(SCH."Posting Group", '%1|%2', 'RAW-MAT', 'BOI');
                                SCH.SETFILTER(SCH.Quantity, '>%1', 0);
                                SCH.SETFILTER(SCH."No.", '<>%1', '');
                                SCH.SETFILTER(SCH."Outstanding Qty.", '>%1', 0);
                                IF SCH.FINDSET THEN
                                    REPEAT
                                        SFT := '';
                                        IF (SCH."Document Line No." <> SCH."Line No.") AND (SCH."Planned Dispatch Date" = 0D) AND NOT (SCH."No." IN ['BOICHAR00014', 'ECBOUBT00004']) THEN BEGIN
                                            Item.RESET;
                                            IF Item.GET(SCH."No.") THEN
                                                SFT := FORMAT(Item."Safety Lead Time");
                                            Body := Body + '<tr style="color:#FF0000"><td>' + SH."No." + '</td><td>' + SH."Sell-to Customer Name" + '</td><td>' + FORMAT(SH."Order Released Date", 0, '<Day,2>-<Month Text,3>-<Year>') + '</td>';
                                            Body := Body + '<td>' + FORMAT(SL."Line No.") + '</td><td>' + FORMAT(SCH."Line No.") + '</td><td>' + FORMAT(SCH."No.") + '</td><td>' + SCH.Description + '</td></td><td>' + SFT + '</td>';
                                            Body := Body + '<td align="right">' + FORMAT(SCH.Quantity) + '</td><td align="right">' + FORMAT(SCH."Outstanding Qty.") + '</td></tr>';
                                            recCount := recCount + 1;
                                            SCH_Count := SCH_Count + 1;
                                        END;
                                    UNTIL SCH.NEXT = 0;
                            UNTIL SL.NEXT = 0;
                    END;
                END;
            UNTIL SH.NEXT = 0;
        IF recCount > 0 THEN
            Body := Body + '<tr style="color:#FF0000"><td colspan="9" align="center"><b>Total Items</b></td><td align="right"><b>' + FORMAT(recCount) + '</b></td></tr>';
        Body := Body + '</table><br>';
        IF SCH_Count > 0 THEN
            Body := Body + '<p align ="left" style="color:#FF0000"><br>Note: Red Color Items are Schedule Items</p>';
        Body := Body + '<p align ="left"> Regards,<br>ERP Team </p>';
        Body := Body + '<br><p align = "center">:: Note: Auto Generated mail from ERP</b> :: </b></P></div></body></html>';
        EmailMessage.Create(Recipients, Subject, Body, true);
        //MESSAGE(Body);
        IF recCount > 0 THEN
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;

    procedure PendingQA_Auth_PO_Alert();
    var
        PH: Record "Purchase Header";
        Body: Text;
        Subject: Text;
        Mail_To: Text;
        Mail_From: Text;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        //SMTP_MAIL: Codeunit "SMTP Mail";
        recCount: Integer;
        DaysDiff: Integer;
        Cust: Record Customer;
        SH: Record "Sales Header";
        Customer: Code[50];
    begin
        //MESSAGE('To Be Planned BOI Items Alert!');
        //Var Initialization
        /* Subject := '';
        Mail_To := '';
        Mail_From := '';
        Body := '';
        recCount := 0;
        //Initialization end
        Mail_From := 'erp@efftronics.com';
        Mail_To := 'erp@efftronics.com,qainward@efftronics.com,purchase@efftronics.com';
        //Mail_To := 'pranavi@efftronics.com';
        Subject := 'ERP - Purchase Orders Pending at QA for Confirmation';
        Body := '<html><head><style> divone{background-color: white; width: 1210px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>';
        Body := Body + '<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 1110px;"><label><font size="6">Purchase Orders Pending at QA for Confirmation</font></label>';
        Body := Body + '<hr style=solid; color= #3333CC>';
        Body := Body + '<h>Dear Sir/Madam,</h><br><br>';
        Body := Body + '<P> Below are list of Purch. Orders in Pending at QA for Confirmation from more than 2 days, </P>';
        Body := Body + '<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th>Purch. Order</th><th>Vendor</th><th>Sale Order</th>';
        Body := Body + '<th>Customer</th><th>Req Sent Date</th><th>Pending Days</th></tr>';
        PH.RESET;
        //SH.SETRANGE(SH."No.",'EFF/SAL/16-17/0213');
        PH.SETRANGE(PH."Document Type", PH."Document Type"::Order);
        PH.SETRANGE(PH.QA_Auth_Status, PH.QA_Auth_Status::"Sent For Auth");
        PH.SETFILTER(PH.QA_Auth_Date, '<%1', TODAY - 2);
        IF PH.FINDFIRST THEN
            REPEAT
                Customer := '';
                SH.RESET;
                SH.SETRANGE(SH."Document Type", SH."Document Type"::Order);
                SH.SETRANGE(SH."No.", PH."Sale Order No");
                IF SH.FINDFIRST THEN BEGIN
                    Cust.RESET;
                    Cust.SETRANGE(Cust."No.", SH."Sell-to Customer No.");
                    IF Cust.FINDFIRST THEN
                        Customer := Cust.Name;
                END;
                DaysDiff := 0;
                DaysDiff := TODAY - PH.QA_Auth_Date;
                IF DaysDiff > 2 THEN BEGIN
                    Body := Body + '<tr><td>' + PH."No." + '</td><td>' + PH."Buy-from Vendor Name" + '</td><td>' + PH."Sale Order No" + '</td>';
                    Body := Body + '<td>' + Customer + '</td><td>' + FORMAT(PH.QA_Auth_Date, 0, '<Day,2>-<Month Text,3>-<Year>') + '</td><td align="right">' + FORMAT(DaysDiff) + '</td></tr>';
                    recCount := recCount + 1;
                END;
            UNTIL SH.NEXT = 0;
        IF recCount > 0 THEN
            Body := Body + '<tr style="color:#FF0000"><td colspan="5" align="center"><b>Total Orders</b></td><td align="right"><b>' + FORMAT(recCount) + '</b></td></tr>';
        Body := Body + '</table><br>';
        Body := Body + '<p align ="left"> Regards,<br>ERP Team </p>';
        Body := Body + '<br><p align = "center">:: Note: Auto Generated mail from ERP</b> :: </b></P></div></body></html>';
        SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
        //MESSAGE(Body);
        IF recCount > 0 THEN
            SMTP_MAIL.Send; */      //B2BUPG

        Subject := '';
        Body := '';
        recCount := 0;
        Recipients.Add('erp@efftronics.com');
        Recipients.Add('qainward@efftronics.com');
        Recipients.Add('purchase@efftronics.com');
        Subject := 'ERP - Purchase Orders Pending at QA for Confirmation';
        Body := '<html><head><style> divone{background-color: white; width: 1210px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>';
        Body := Body + '<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 1110px;"><label><font size="6">Purchase Orders Pending at QA for Confirmation</font></label>';
        Body := Body + '<hr style=solid; color= #3333CC>';
        Body := Body + '<h>Dear Sir/Madam,</h><br><br>';
        Body := Body + '<P> Below are list of Purch. Orders in Pending at QA for Confirmation from more than 2 days, </P>';
        Body := Body + '<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th>Purch. Order</th><th>Vendor</th><th>Sale Order</th>';
        Body := Body + '<th>Customer</th><th>Req Sent Date</th><th>Pending Days</th></tr>';
        PH.RESET;
        PH.SETRANGE(PH."Document Type", PH."Document Type"::Order);
        PH.SETRANGE(PH.QA_Auth_Status, PH.QA_Auth_Status::"Sent For Auth");
        PH.SETFILTER(PH.QA_Auth_Date, '<%1', TODAY - 2);
        IF PH.FINDFIRST THEN
            REPEAT
                Customer := '';
                SH.RESET;
                SH.SETRANGE(SH."Document Type", SH."Document Type"::Order);
                SH.SETRANGE(SH."No.", PH."Sale Order No");
                IF SH.FINDFIRST THEN BEGIN
                    Cust.RESET;
                    Cust.SETRANGE(Cust."No.", SH."Sell-to Customer No.");
                    IF Cust.FINDFIRST THEN
                        Customer := Cust.Name;
                END;
                DaysDiff := 0;
                DaysDiff := TODAY - PH.QA_Auth_Date;
                IF DaysDiff > 2 THEN BEGIN
                    Body := Body + '<tr><td>' + PH."No." + '</td><td>' + PH."Buy-from Vendor Name" + '</td><td>' + PH."Sale Order No" + '</td>';
                    Body := Body + '<td>' + Customer + '</td><td>' + FORMAT(PH.QA_Auth_Date, 0, '<Day,2>-<Month Text,3>-<Year>') + '</td><td align="right">' + FORMAT(DaysDiff) + '</td></tr>';
                    recCount := recCount + 1;
                END;
            UNTIL SH.NEXT = 0;
        IF recCount > 0 THEN
            Body := Body + '<tr style="color:#FF0000"><td colspan="5" align="center"><b>Total Orders</b></td><td align="right"><b>' + FORMAT(recCount) + '</b></td></tr>';
        Body := Body + '</table><br>';
        Body := Body + '<p align ="left"> Regards,<br>ERP Team </p>';
        Body := Body + '<br><p align = "center">:: Note: Auto Generated mail from ERP</b> :: </b></P></div></body></html>';
        EmailMessage.Create(Recipients, Subject, Body, true);

        IF recCount > 0 THEN
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;

    procedure CS_Adjustment_Alert();
    var
        CSLG: Record "CS Stock Ledger";
        Body: Text;
        Subject: Text;
        Mail_To: Text;
        Mail_From: Text;
        //EmailMessage: Codeunit 8904;
        //Email: Codeunit 8901;
        Recipients: List of [Text];
        //SMTP_MAIL: Codeunit "SMTP Mail";
        RecCount: Integer;
        Itm: Record Item;
        Divsn: Record "Employee Statistics Group";
        User: Record "User Setup";
        UserGvar: Record User;
        Divsn_Name: Code[50];
        PM: Code[100];
        headerdate: Date;
        CustomCalendarChange: Array[2] of Record "Customized Calendar Change";//EFFUPG
    begin

        //headerdate := CalMngmt.CalcDateBOC('-1D', TODAY(), 3, 'PROD', '', 3, 'PROD', '', FALSE);//EFFUPG
        CustomCalendarChange[1].SetSource(CustomCalendarChange[1]."Source Type"::"Location", 'PROD', '', '');//EFFUPG
        CustomCalendarChange[2].SetSource(CustomCalendarChange[2]."Source Type"::"Location", 'PROD', '', '');//EFFUPG
        headerdate := CalMngmt.CalcDateBOC('-1D', TODAY(), CustomCalendarChange, FALSE);//EFFUPG

        CSLG.RESET;
        CSLG.SETRANGE("Posting Date", headerdate);
        CSLG.SETRANGE(Stock_Adjusted, TRUE);
        IF CSLG.FINDSET THEN BEGIN
            //Var Initialization
            /* Subject := '';
            Mail_To := '';
            Mail_From := '';
            Body := '';
            RecCount := 0;
            //Initialization end
            Mail_From := 'erp@efftronics.com';
            Mail_To := 'erp@efftronics.com,cuspm@efftronics.com,srivalli@efftronics.com,prasanthi@efftronics.com';
            Subject := 'ERP - CS Stock Adjustments on ' + FORMAT(headerdate, 0, '<Day,2>-<Month Text,3>-<Year>');
            Body := '<html><head><style> divone{background-color: white; width: 1210px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>';
            Body := Body + '<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 1110px;"><label><font size="6">CS Stock Adjustments details</font></label>';
            Body := Body + '<hr style=solid; color= #3333CC>';
            Body := Body + '<h>Dear Sir/Madam,</h><br><br>';
            Body := Body + '<P> Below are the details of CS Stock Adjustments done on ' + FORMAT(headerdate, 0, '<Day,2>-<Month Text,3>-<Year>') + ', </P>';
            Body := Body + '<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th>Item No.</th><th>Item Description</th><th>Card Status</th><th>Quantity Adjusted</th>';
            Body := Body + '<th>Division</th><th>Proj. Manager</th><th>User ID</th><th>Remarks</th></tr>';
            REPEAT
                IF Itm.GET(CSLG."Item No") THEN BEGIN
                    Divsn_Name := '';
                    PM := '';
                    Divsn.RESET;
                    Divsn.SETRANGE("Division Code", CSLG.Location);
                    IF Divsn.FINDFIRST THEN BEGIN
                        Divsn_Name := Divsn."Division Code" + '-' + Divsn."Division Name";
                        User.RESET;
                        User.SETRANGE(EmployeeID, Divsn."Project Manager");
                        IF User.FINDFIRST THEN
                            PM := User."Full Name";
                    END
                    ELSE
                        Divsn_Name := CSLG.Location;
                    Body := Body + '<tr><td>' + CSLG."Item No" + '</td><td>' + Itm.Description + '</td><td>' + FORMAT(CSLG."Card Status") + '</td>';
                    Body := Body + '<td align="right">' + FORMAT(CSLG.Quantity) + '</td><td>' + Divsn_Name + '</td><td>' + PM + '</td><td>' + CSLG."User ID" + '</td><td>' + CSLG.Remarks + '</td></tr>';
                    RecCount := RecCount + 1;
                END;
            UNTIL CSLG.NEXT = 0;
            IF RecCount > 0 THEN
                Body := Body + '<tr style="color:#FF0000"><td colspan="7" align="center"><b>Total Count</b></td><td align="right"><b>' + FORMAT(RecCount) + '</b></td></tr>';
            Body := Body + '</table><br>';
            Body := Body + '<p align ="left"> Regards,<br>ERP Team </p>';
            Body := Body + '<br><p align = "center">:: Note: Auto Generated mail from ERP</b> :: </b></P></div></body></html>';
            SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
            IF RecCount > 0 THEN
                SMTP_MAIL.Send;
        END; */   //B2BUPG

            Subject := '';

            Body := '';
            RecCount := 0;
            Recipients.Add('erp@efftronics.com');
            Recipients.Add('cuspm@efftronics.com');
            Recipients.Add('srivalli@efftronics.com');
            Recipients.Add('prasanthi@efftronics.com');
            Subject := 'ERP - CS Stock Adjustments on ' + FORMAT(headerdate, 0, '<Day,2>-<Month Text,3>-<Year>');
            Body := '<html><head><style> divone{background-color: white; width: 1210px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>';
            Body := Body + '<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 1110px;"><label><font size="6">CS Stock Adjustments details</font></label>';
            Body := Body + '<hr style=solid; color= #3333CC>';
            Body := Body + '<h>Dear Sir/Madam,</h><br><br>';
            Body := Body + '<P> Below are the details of CS Stock Adjustments done on ' + FORMAT(headerdate, 0, '<Day,2>-<Month Text,3>-<Year>') + ', </P>';
            Body := Body + '<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th>Item No.</th><th>Item Description</th><th>Card Status</th><th>Quantity Adjusted</th>';
            Body := Body + '<th>Division</th><th>Proj. Manager</th><th>User ID</th><th>Remarks</th></tr>';
            REPEAT
                IF Itm.GET(CSLG."Item No") THEN BEGIN
                    Divsn_Name := '';
                    PM := '';
                    Divsn.RESET;
                    Divsn.SETRANGE(Code, CSLG.Location);
                    IF Divsn.FINDFIRST THEN BEGIN
                        Divsn_Name := Divsn.Code + '-' + Divsn."Division Name";
                        User.RESET;
                        User.SETRANGE(EmployeeID, Divsn."Project Manager");
                        IF User.FINDFIRST THEN
                            if UserGvar.Get(User."User ID") then
                                PM := UserGvar."Full Name";
                    END
                    ELSE
                        Divsn_Name := CSLG.Location;
                    Body := Body + '<tr><td>' + CSLG."Item No" + '</td><td>' + Itm.Description + '</td><td>' + FORMAT(CSLG."Card Status") + '</td>';
                    Body := Body + '<td align="right">' + FORMAT(CSLG.Quantity) + '</td><td>' + Divsn_Name + '</td><td>' + PM + '</td><td>' + CSLG."User ID" + '</td><td>' + CSLG.Remarks + '</td></tr>';
                    RecCount := RecCount + 1;
                END;
            UNTIL CSLG.NEXT = 0;
            IF RecCount > 0 THEN
                Body := Body + '<tr style="color:#FF0000"><td colspan="7" align="center"><b>Total Count</b></td><td align="right"><b>' + FORMAT(RecCount) + '</b></td></tr>';
            Body := Body + '</table><br>';
            Body := Body + '<p align ="left"> Regards,<br>ERP Team </p>';
            Body := Body + '<br><p align = "center">:: Note: Auto Generated mail from ERP</b> :: </b></P></div></body></html>';
            EmailMessage.Create(Recipients, Subject, Body, true);
            IF RecCount > 0 THEN
                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        END;
    end;


    procedure MSL_Alert();
    var
        ILE: Record "Item Ledger Entry";
        //SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
        SQLQuery: Text;
        //RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        RowCount: Integer;
        ConnectionOpen: Integer;
        Itm: Record Item;
        colorcode: Code[10];
        Previous: Code[20];
        R_Cnt: Integer;
        status_desc: Text;
    begin
        //>> ORACLE UPG
        /* 
        //IF ISCLEAR(SQLConnection) THEN
            //CREATE(SQLConnection, FALSE, TRUE);//Rev01

        //IF ISCLEAR(RecordSet) THEN
            //CREATE(RecordSet, FALSE, TRUE);//Rev01 //B2BUPG

        RowCount := 0;
        IF ConnectionOpen <> 1 THEN BEGIN
            SQLConnection.ConnectionString := 'DSN=ERPServer;UID=report;PASSWORD=Efftronics@eff;SERVER:=erpserver;providerName=System.Data.SqlClient;';
            SQLConnection.Open;
            ConnectionOpen := 1;
        END;

        // Mail_From := 'erp@efftronics.com';
        //Mail_To := 'erp@efftronics.com,store@efftronics.com,controlroom@efftronics.com,temc@efftronics.com,qainward@efftronics.com,dineel@efftronics.com';  //B2BUPG
        //Mail_To := 'erp@efftronics.com';
        Recipients.Add('erp@efftronics.com');
        Recipients.Add('store@efftronics.com');
        Recipients.Add('controlroom@efftronics.com');
        Recipients.Add('temc@efftronics.com');
        Recipients.Add('qainward@efftronics.com');
        Recipients.Add('dineel@efftronics.com');
        Subject := 'ERP - Shelf Life/Floor Life Expired/To Be Expired Components Details';
        Body := '<html><head><style> divone{background-color: white; width: 1210px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>';
        Body := Body + '<body><div style="border-color:#666699; margin: 20px; border-width:15px; border-style:solid; padding: 20px; width: 1110px;"><label><font size="6">Shelf Life/Floor Life Expired/To Be Expired Components Details</font></label>';
        Body := Body + '<hr style=solid; color= #3333CC>';
        Body := Body + '<h>Dear Sir/Madam,</h><br><br>';
        Body := Body + '<P> Below are the details of Shelf Life/Floor Life Expired/To Be Expired Components Details </P>';
        Body := Body + '<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th>Item No.</th><th>Item Description</th><th>Prod Group</th><th>Item Category</th>';
        Body := Body + '<th>Item Sub Group</th><th>Lot No.</th><th>Stock At Store</th><th>Stock At MCH</th><th>Stock At R&D STR</th><th>Stock At CS STR</th></tr>';
        //  In the where condition, Entry type was changed from 0 to 0,2 and Document type = 5 was replaced with Positive =1 by Vishnu Priya on 09-09-2020
        SQLQuery := ' select * from (SELECT  Details.No_, Details.[Lot No_], Details.Purch_Rcpt_Entry_No, Details.MSL, Details.[Floor Life at 25 C 40_ RH], ' +
        ' Details.[Bake Hours], Details.[Component Shelf Life(Years)], Details.[ESD Class], ' +
        '   ILETemp.[MBB Packed Date], ILETemp.[MFD Date], ILETemp.[Recharge Cycles], ILETemp.[Floor Life], ILETemp.[MBB Packet Open DateTime], ILETemp.[MBB Packet Close DateTime], ' +
        ' case when  Details.[Component Shelf Life(Years)] > 0 and (ILETemp.[MFD Date] >= CONVERT(DATETIME, ''1990-04-01 00:00:00'', 102))  and ' +
        ' DATEDIFF(MONTH,ILETemp.[MFD Date],GETDATE()) >=  Details.[Component Shelf Life(Years)]*12 then ''S_Expired'' when ILETemp.[Recharge Cycles] >=2 then ''R_Expired'' ' +
        ' when  not Details.[Floor Life at 25 C 40_ RH] IN('''',''INFINITE'') and ILETemp.[Floor Life] >= Details.[Floor Life at 25 C 40_ RH] then ''F_Exipired'' ' +
        ' WHEN NOT Details.[Floor Life at 25 C 40_ RH] IN ('''', ''INFINITE'') AND ILETemp.[Floor Life] >= round(cast(Details.[Floor Life at 25 C 40_ RH] as decimal)*0.9,1) THEN ''F_T_Exipired'' ' +
        ' WHEN Details.[Component Shelf Life(Years)] > 0 AND (ILETemp.[MFD Date] >= CONVERT(DATETIME, ''1990-04-01 00:00:00'', 102)) AND ' +
        ' Details.[Component Shelf Life(Years)]*12 - DATEDIFF(MONTH, ILETemp.[MFD Date], GETDATE()) <= 1 THEN ''S_T_Expired'' else ''F_Ok'' end as ShelfLifestatus ' +
        ' FROM (SELECT  Itm.No_, ILE.[Lot No_], ISNULL((SELECT  max([Entry No_]) AS EXPR1 FROM   [Efftronics Systems Pvt Ltd_,$Item Ledger Entry] AS S_ILE WITH (nolock) ' +
        '  WHERE  ([Entry Type] in(2,0)) and (Positive =1 ) AND ([Item No_] = Itm.No_) AND ([Lot No_] = ILE.[Lot No_])), N'''') AS Purch_Rcpt_Entry_No, Itm.MSL, Itm.[Floor Life at 25 C 40_ RH], ' +
        '   Itm.[Bake Hours], Itm.[Component Shelf Life(Years)], Itm.[ESD Class]  FROM  [Efftronics Systems Pvt Ltd_,$Item] AS Itm WITH (nolock) INNER JOIN ' +
        '    [Efftronics Systems Pvt Ltd_,$Item Ledger Entry] AS ILE WITH (nolock) ON Itm.No_ = ILE.[Item No_] ' +
        '  WHERE  (Itm.MSL <> 0) AND (Itm.Blocked = 0) AND (ILE.[Remaining Quantity] > 0) AND (ILE.[Location Code] IN (''STR'', ''CS STR'', ''R&D STR'', ''PRODSTR'', ''MCH'')) ' +
        '   GROUP BY Itm.No_, ILE.[Lot No_], Itm.MSL, Itm.[Floor Life at 25 C 40_ RH], Itm.[Bake Hours], Itm.[Component Shelf Life(Years)], Itm.[ESD Class]) AS Details INNER JOIN ' +
        '  [Efftronics Systems Pvt Ltd_,$Item Ledger Entry] AS ILETemp WITH (nolock) ON Details.Purch_Rcpt_Entry_No = ILETemp.[Entry No_] where ' +
        '  case when  Details.[Component Shelf Life(Years)] > 0 and (ILETemp.[MFD Date] >= CONVERT(DATETIME, ''1990-04-01 00:00:00'', 102))  and  ' +
        ' DATEDIFF(MONTH,ILETemp.[MFD Date],GETDATE()) >=  Details.[Component Shelf Life(Years)]*12 then ''S_Expired'' when ILETemp.[Recharge Cycles] >=2 then ''R_Expired'' ' +
        ' when  not Details.[Floor Life at 25 C 40_ RH] IN('''',''INFINITE'') and ILETemp.[Floor Life] >= Details.[Floor Life at 25 C 40_ RH] then ''F_Exipired'' ' +
        ' WHEN NOT Details.[Floor Life at 25 C 40_ RH] IN ('''', ''INFINITE'') AND ILETemp.[Floor Life] >= round(cast(Details.[Floor Life at 25 C 40_ RH] as decimal)*0.9,1) ' +
        ' THEN ''F_T_Exipired'' WHEN Details.[Component Shelf Life(Years)] > 0 AND (ILETemp.[MFD Date] >= CONVERT(DATETIME, ''1990-04-01 00:00:00'', 102)) AND ' +
        ' Details.[Component Shelf Life(Years)]*12 - DATEDIFF(MONTH, ILETemp.[MFD Date], GETDATE()) <= 1 THEN ''S_T_Expired'' ' +
        ' else ''F_Ok'' end  in(''S_Expired'',''R_Expired'',''F_Exipired'',''F_T_Exipired'',''S_T_Expired'')) as temp ' +
        ' where No_ not in (''ECICSDI00631'',''ECICSAN00091'',''ECREGPV00029'',''ECICSDI00438'',''ECDIOPN00241'',''ECICSAN00122'',''ECICSAN00095'', ' +
        ' ''ELWLS00035'',''ECTRNPN00003'',''ECICSAN00005'',''ECICSDI00067'',''ECVARAX00057'',''ECDIOPN00241'',''ECICSDI00438'',''ECICSDI00706'') order by ShelfLifestatus';

        MESSAGE(SQLQuery);
        RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
        Previous := '';
        R_Cnt := 0;
        colorcode := '000000';
        IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
            RecordSet.MoveFirst;

        WHILE NOT RecordSet.EOF DO BEGIN
            IF Itm.GET(FORMAT(RecordSet.Fields.Item('No_').Value)) THEN BEGIN
                // added by sujani for not to have non stock items
                ILE.RESET;
                ILE.SETRANGE("Entry No.", RecordSet.Fields.Item('Purch_Rcpt_Entry_No').Value);
                ILE.SETFILTER("Remaining Quantity", '> %1', 0);
                IF ILE.FINDSET THEN
                //IF ILE.GET(FORMAT(RecordSet.Fields.Item('Purch_Rcpt_Entry_No').Value)) THEN // Commented by sujani for not to have non stock items
                BEGIN
                    //IF
                    GetStockOfLot(ILE."Item No.", ILE."Lot No.");

                    IF (Previous <> '') AND (Previous <> FORMAT(RecordSet.Fields.Item('ShelfLifestatus').Value)) THEN
                        IF R_Cnt > 0 THEN BEGIN
                            Body := Body + '<tr style="color:#' + colorcode + '" bgcolor="FCF2FF"><td colspan="9" align="center"><b>Total ' + status_desc + ' Count</b></td><td align="right"><b>' + FORMAT(R_Cnt) + '</b></td></tr>';
                            R_Cnt := 0;
                        END;
                    CASE FORMAT(RecordSet.Fields.Item('ShelfLifestatus').Value) OF
                        'S_Expired':
                            status_desc := 'Shelf Life Expired Items';
                        'R_Expired':
                            status_desc := 'Recharge Cycles Exceeded Items';
                        'F_Exipired':
                            status_desc := 'Floor Life Expired Items';
                        'F_T_Exipired':
                    END;
                        'S_Expired':
                            colorcode := 'FF9936';
                        'R_Expired':
                            colorcode := 'B85656';
                        'F_Exipired':
                            colorcode := 'E31E1E';
                        'F_T_Exipired':
                            colorcode := '579EEB';
                        'S_T_Expired':
                            colorcode := '199C65';
                    END;
                    Body := Body + '<tr style="color:#' + colorcode + '"><td>' + ILE."Item No." + '</td><td>' + Itm.Description + '</td><td>' + FORMAT(Itm."Product Group Code") + '</td><td>' + FORMAT(Itm."Item Category Code") + '</td>';
                    Body := Body + '<td>' + FORMAT(Itm."Item Sub Group Code") + '</td><td>' + ILE."Lot No." + '</td><td align = "right">' + FORMAT("Stock at Stores") + '</td><td align = "right">' + FORMAT("Stock at MCH") + '</td>';
                    Body := Body + '<td align = "right">' + FORMAT("Stock at RD Stores") + '</td><td align = "right">' + FORMAT("Stock at CS Stores") + '</td></tr>';
                    RowCount += 1;
                    R_Cnt += 1;
                    Previous := FORMAT(RecordSet.Fields.Item('ShelfLifestatus').Value);
                END;
            END;
            RecordSet.MoveNext;
        END;
        IF R_Cnt > 0 THEN
            Body := Body + '<tr style="color:#' + colorcode + '" bgcolor="FCF2FF"><td colspan="9" align="center"><b>Total ' + status_desc + ' Count</b></td><td align="right"><b>' + FORMAT(R_Cnt) + '</b></td></tr>';
        IF RowCount > 0 THEN
            Body := Body + '<tr style="color:#FF0000" bgcolor="FCF2FF"><td colspan="9" align="center"><b>Total Count</b></td><td align="right"><b>' + FORMAT(RowCount) + '</b></td></tr>';
        Body := Body + '</table><br>';
        IF RowCount > 0 THEN BEGIN
            Body := Body + '<p align ="left" style="color:#E31E1E"><br>:::Floor Life Expired Items:::</p>';
            Body := Body + '<p align ="left" style="color:#579EEB">:::Floor Life To Be Expired Items:::</p>';
            Body := Body + '<p align ="left" style="color:#B85656">:::Recharge Cycles Exceeded Items:::</p>';
            Body := Body + '<p align ="left" style="color:#FF9936">:::Shelf Life Expired Items:::</p>';
            Body := Body + '<p align ="left" style="color:#199C65">:::Shelf Life To Be Expired Items:::</p>';
        END;
        Body := Body + '<p align ="left"> Regards,<br>ERP Team </p>';
        Body := Body + '<p align = "center">:: Note: Auto Generated mail from ERP</b> :: </b></P></div></body></html>';
        //SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);  //B2BUPG
        EmailMessage.Create(Recipients, Subject, Body, true);

        IF RowCount > 0 THEN
            //SMTP_MAIL.Send;       //B2BUPG
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

        RecordSet.Close;
        SQLConnection.Close;
        ConnectionOpen := 0; */
        //<< ORACLE UPG
    end;


    procedure GetStockOfLot(Item: Code[30]; Lot: Code[30]);
    var
        ITEM1: Record Item;
        ItemLedgEntry: Record "Item Ledger Entry";
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
    begin
        IF ITEM1.GET(Item) THEN BEGIN

            "Stock at MCH" := 0;
            "Stock at CS Stores" := 0;
            "Stock at RD Stores" := 0;
            "Stock at Stores" := 0;

            ITEM1.CALCFIELDS(ITEM1."Quantity Under Inspection", ITEM1."Quantity Rejected", ITEM1."Quantity Rework", ITEM1."Quantity Sent for Rework",
                             ITEM1."Stock At MCH Location", ITEM1."Stock at CS Stores", ITEM1."Stock at RD Stores", ITEM1."Stock at PROD Stores", ITEM1."Inventory at Stores");

            IF (ITEM1."Quantity Under Inspection" = 0) AND (ITEM1."Quantity Rejected" = 0) AND (ITEM1."Quantity Rework" = 0) AND (ITEM1."Quantity Sent for Rework" = 0) THEN BEGIN
                ItemLedgEntry.RESET;
                ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                "Expiration Date", "Lot No.", "Serial No.");
                ItemLedgEntry.SETRANGE("Item No.", Item);
                ItemLedgEntry.SETRANGE(Open, TRUE);
                ItemLedgEntry.SETFILTER("Location Code", 'STR|CS STR|R&D STR|MCH');
                ItemLedgEntry.SETFILTER(ItemLedgEntry."Remaining Quantity", '>%1', 0);
                ItemLedgEntry.SETFILTER(ItemLedgEntry."Lot No.", Lot);
                IF ItemLedgEntry.FINDSET THEN
                    REPEAT
                        ItemLedgEntry.MARK(TRUE);
                    UNTIL ItemLedgEntry.NEXT = 0;
            END ELSE BEGIN
                ItemLedgEntry.RESET;
                ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date", "Expiration Date", "Lot No.", "Serial No.");
                ItemLedgEntry.SETRANGE("Item No.", Item);
                ItemLedgEntry.SETRANGE(Open, TRUE);
                ItemLedgEntry.SETFILTER("Location Code", 'STR|CS STR|R&D STR|MCH');
                ItemLedgEntry.SETFILTER(ItemLedgEntry."Remaining Quantity", '>%1', 0);
                ItemLedgEntry.SETFILTER(ItemLedgEntry."Lot No.", Lot);
                IF ItemLedgEntry.FINDSET THEN
                    REPEAT
                        ItemLedgEntry.MARK(TRUE);
                        IF (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") AND
                          (QualityItemLedgEntry."Inspection Status" = QualityItemLedgEntry."Inspection Status"::"Under Inspection")) OR
                          (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") AND
                          (QualityItemLedgEntry."Inspection Status" = QualityItemLedgEntry."Inspection Status"::Rejected)) THEN
                            ItemLedgEntry.MARK(FALSE);
                    UNTIL ItemLedgEntry.NEXT = 0;
            END;
            ItemLedgEntry.MARKEDONLY(TRUE);
            IF ItemLedgEntry.FINDSET THEN
                REPEAT
                    CASE ItemLedgEntry."Location Code" OF
                        'STR':
                            "Stock at Stores" := "Stock at Stores" + ItemLedgEntry."Remaining Quantity";
                        'CS STR':
                            "Stock at CS Stores" := "Stock at CS Stores" + ItemLedgEntry."Remaining Quantity";
                        'R&D STR':
                            "Stock at RD Stores" := "Stock at RD Stores" + ItemLedgEntry."Remaining Quantity";
                        'MCH':
                            "Stock at MCH" := "Stock at MCH" + ItemLedgEntry."Remaining Quantity";
                    END;
                UNTIL ItemLedgEntry.NEXT = 0;
        END;
    end;

    local procedure MaterialShortage();
    var
        "Count": Integer;
        "Present Item": Text;
        "Present BOM": Text;
        Req_Qty: Decimal;
        Days: Integer;
        Mail_Subject: Text;
        "Material Issues Line": Record "Material Issues Line";
        "Material Issues Header": Record "Material Issues Header";
    begin
        Count := 0;
        Days := 0;
        IF DATE2DWY(TODAY - 1, 1) = 7 THEN
            Days := 2
        ELSE
            Days := 1;
        Mail_Subject := 'ERP - To Be Recieved items(Auto Postings) on ' + FORMAT(TODAY - Days);
        /* Mail_To := '';
        Mail_From := 'erp@efftronics.com';
        Mail_To := 'Padmaja@efftronics.com,controlroom@efftronics.com,anilkumar@efftronics.com,erp@efftronics.com'; */  //B2BUPG
        Recipients.Add('Padmaja@efftronics.com');
        Recipients.Add('controlroom@efftronics.com');
        Recipients.Add('anilkumar@efftronics.com');
        Recipients.Add('erp@efftronics.com');

        Body := '';
        //added by Vishnu on 28th May 2019 to eliminate the empty mails (Without Body)
        /*
        MIL.RESET;
        MIL.SETCURRENTKEY("Production BOM No.","Item No.");
        MIL.SETRANGE("Transfer-from Code",'STR');
        MIL.SETFILTER("Transfer-to Code",'%1|%2','PROD','MCH');
        MIL.SETFILTER("Qty. to Receive",'>%1',0);
        MIL.SETRANGE(Status,MIL.Status::Released);
        */

        //SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Mail_Subject, Body, TRUE); //B2BUPG
        EmailMessage.Create(Recipients, Subject, Body, true);
        Body += ('<html><head><style> divone{background-color: white; width: 1210px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>');
        Body += ('<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 1110px;"><label><font size="6">To Be Recieved items(Auto Postings)</font></label>');
        Body += ('<hr style=solid; color= #3333CC>');
        Body += ('<h>Dear Sir/Madam,</h><br><br>');
        Body += ('<P> Details of Shortage Items, </P>');
        "Material Issues Line".RESET;
        "Material Issues Line".SETCURRENTKEY("Material Issues Line"."Production BOM No.", "Material Issues Line"."Item No.");
        // "Material Issues Line".RESET;
        "Material Issues Line".SETRANGE("Material Issues Line"."Transfer-from Code", 'STR');
        "Material Issues Line".SETFILTER("Material Issues Line"."Transfer-to Code", '%1|%2', 'PROD', 'MCH');
        "Material Issues Line".SETFILTER("Material Issues Line"."Qty. to Receive", '>%1', 0);
        "Material Issues Line".SETRANGE("Material Issues Line".Status, "Material Issues Line".Status::Released);
        "Present BOM" := '';
        "Present Item" := '';
        Req_Qty := 0;
        IF "Material Issues Line".FINDFIRST THEN
            REPEAT
                IF Count <> 0 THEN BEGIN
                    Count += 1;
                    IF ("Present BOM" <> "Material Issues Line"."Production BOM No.") AND ("Present Item" <> "Material Issues Line"."Item No.") THEN BEGIN
                        "Material Issues Header".RESET;
                        "Material Issues Header".SETRANGE("Material Issues Header"."No.", "Material Issues Line"."Document No.");
                        "Material Issues Header".SETFILTER("Material Issues Header"."Auto Post", FORMAT(1)); // ADDED BY VISHNU PRIYA
                                                                                                             //"Material Issues Header".SETRANGE("Material Issues Header"."User ID",'EFFTRONICS\GRAVI'); // commented by vishnu priya on 09-04-2019
                        "Material Issues Header".SETRANGE("Material Issues Header"."Released Date", TODAY - Days);
                        IF "Material Issues Header".FINDFIRST THEN BEGIN
                            Body += ('<td>' + FORMAT(Req_Qty) + '</td></tr>');
                            Req_Qty := "Material Issues Line"."Qty. to Receive";
                            Body += ('<tr><td>' + "Material Issues Header"."Proj Description" + '</td><td>' + "Material Issues Line".Description + '</td>');
                            "Present BOM" := "Material Issues Line"."Production BOM No.";
                            "Present Item" := "Material Issues Line"."Item No.";
                        END;
                    END
                    ELSE BEGIN
                        "Material Issues Header".RESET;
                        "Material Issues Header".SETRANGE("Material Issues Header"."No.", "Material Issues Line"."Document No.");
                        "Material Issues Header".SETFILTER("Material Issues Header"."Auto Post", FORMAT(1)); // ADDED BY VISHNU PRIYA
                                                                                                             // "Material Issues Header".SETRANGE("Material Issues Header"."User ID",'EFFTRONICS\GRAVI'); // commented by vishnu priya on 09-04-2019
                        "Material Issues Header".SETRANGE("Material Issues Header"."Released Date", TODAY - Days);
                        IF "Material Issues Header".FINDFIRST THEN BEGIN
                            Req_Qty := Req_Qty + "Material Issues Line"."Qty. to Receive";
                        END;
                    END;
                END
                ELSE BEGIN
                    "Material Issues Header".RESET;
                    "Material Issues Header".SETRANGE("Material Issues Header"."No.", "Material Issues Line"."Document No.");
                    "Material Issues Header".SETFILTER("Material Issues Header"."Auto Post", FORMAT(1)); // ADDED BY VISHNU PRIYA
                                                                                                         // "Material Issues Header".SETRANGE("Material Issues Header"."User ID",'EFFTRONICS\GRAVI');// COMMENTED BY VISHNU PRIYA
                    "Material Issues Header".SETRANGE("Material Issues Header"."Released Date", TODAY - Days);
                    IF "Material Issues Header".FINDFIRST THEN BEGIN
                        Count := 1;
                        Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th>PCB Description</th><th> Item Description </th><th>Req_Qty<th></tr>');
                        Body += ('<tr><td>' + "Material Issues Header"."Proj Description" + '</td><td>' + "Material Issues Line".Description + '</td>');
                        Req_Qty := "Material Issues Line"."Qty. to Receive";
                    END;
                END;
            UNTIL "Material Issues Line".NEXT = 0;
        IF Count = 0 THEN
            Body += ('No Pendings')
        ELSE BEGIN
            Body += ('<td>' + FORMAT(Req_Qty) + '</td></tr>');
            Body += ('</table>');
        END;
        /* SMTP_MAIL.AddBCC('vishnupriya@efftronics.com');
        SMTP_MAIL.Send; */  //B2BUPG
        Recipients.Add('vishnupriya@efftronics.com');
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        RESET;

    end;


    local procedure RD_Material_Alerts();
    begin
        MIH.RESET;
        MIH.SETRANGE(MIH."Transfer-from Code", 'STR');
        //MIH.SETFILTER(MIH."Transfer-to Code",'%1|%2|%3|%4|%5|%6','RD1','RD2','RD3','RD4','RD5','RD6');
        MIH.SETFILTER(MIH."Transfer-to Code", '<>%1', 'PROD');
        MIH.SETFILTER("Released Date", '>%1 & <%2', DMY2Date(04, 01, 08), TODAY);
        MIH.SETRANGE(Status, MIH.Status::Released);
        MIH.SETFILTER(Alert_Mail_Sent_date, '<>%1', TODAY);
        MIH.SETCURRENTKEY(MIH."User ID");
        MIH.ASCENDING(TRUE);
        //B2B UPG >>>
        /* IF MIH.FINDSET THEN BEGIN
            Subject := 'Material Request Stage';
                                REPEAT
                                    // Mail_To := 'sujani@efftronics.com';
                                    USER_TABLE.RESET;
                                    USER_TABLE.SETRANGE("User Name", MIH."User ID");
                                    IF USER_TABLE.FINDFIRST THEN
                                        Rqsted_Mails := USER_TABLE.MailID;
                                    IF Rqstd_user_old <> MIH."User ID" THEN BEGIN
                                        IF Rqstd_user_old <> '' THEN BEGIN
                                            Mail1.AppendBody('</table><br>');
                                            Mail1.AppendBody('<p align ="left"> Regards,<br>ERP Team </p>');
                                            Mail1.AppendBody('<p align = "center">:: Note: Auto Generated mail from ERP</b> :: </b></P></div></body></html>');
                                            Mail1.Send;
                                        END;
                                        Mail1.CreateMessage('ERP', 'erp@efftronics.com', Rqsted_Mails, Subject, Body, TRUE);
                                        //Mail1.CreateMessage('ERP','erp@efftronics.com',Mail_To,Subject,Body,TRUE);
                                        Mail1.AddBCC('erp@efftronics.com');
                                        Mail1.AppendBody('<html><head><style> divone{background-color: white; width: 1500px; padding: 20px; border-style:solid ; border-color:#CB80F4;  margin: 20px;} </style></head>');
                                        Mail1.AppendBody('<body><div style="border-color:#CB80F4;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 1200px;"><label><font size="6">Your Requested Materials State</font></label>');
                                        Mail1.AppendBody('<hr style=solid; color= #3333CC>');
                                        Mail1.AppendBody('<h>Dear Sir/Mam ,</h><br>    Below is the Details of your requested Materials<br>');
                                        Mail1.AppendBody('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;">' +
                                                            '<tr><th>Requisation No</th><th>Item No</th><th>Item Desc</th><th>Req Qty</th><th>Pending Qty</th><th>Stock At Str</th>' +
                                                             '<th>UOM</th><th>Indent No</th><th>Indent Released Dt</th><th>PO NO</th><th>Expected Rcvd Dt</th><th>PO Remarks</th><th>State</th></tr>');
                                        Rqstd_user_old := MIH."User ID";
                                    END;
                                    MIL.RESET;
                                    MIL.SETRANGE("Document No.", MIH."No.");
                                    MIL.SETFILTER("Outstanding Quantity", '>%1', 0);
                                    IF MIL.FINDFIRST THEN
                                            REPEAT
                                                Item.RESET;
                                                Item.SETRANGE("No.", MIL."Item No.");
                                                IF Item.FINDFIRST THEN BEGIN
                                                    Item.CALCFIELDS("Inventory at Stores");
                                                    Stock_At_Str_Qty := Item."Inventory at Stores";
                                                END;
                                                IF Stock_At_Str_Qty > 0 THEN BEGIN // have a stock bt still in released state
                                                    Rqst_no := MIH."No.";
                                                    Rqstd_user := MIH."User ID";
                                                    Rqstd_Item := MIL."Item No.";
                                                    Rqstd_Qty := MIL.Quantity;
                                                    Pending_Qty := MIL."Outstanding Quantity";
                                                    Mail1.AppendBody('<tr><td style=width:3%>' + Rqst_no + '</td><td style=width:3%>' + Rqstd_Item + '</td><td style=width:25%>' + MIL.Description + '</td><td style=width:2%>' + FORMAT(MIL.Quantity) + '</td>' +
                                                         '<td style=width:2%>' + FORMAT(MIL."Outstanding Quantity") + '</td><td style=width:2%>' + FORMAT(Stock_At_Str_Qty) + '</td><td style=width:2%>' + MIL."Unit of Measure" + '</td>' +
                                                         '<td></td><td></td><td></td><td style=width:3%>Depends on Posting</td><td></td>' +
                                                         '<td style=width:10%>Request Released State</td></tr>');
                                                END ELSE BEGIN
                                                    IL.RESET;
                                                    IL.SETRANGE("No.", MIL."Item No.");
                                                    IL.SETRANGE("Indent Status", IL."Indent Status"::Indent);
                                                    IF IL.FINDSET THEN BEGIN
                                                        IH.RESET;
                                                        IH.SETRANGE("No.", IL."Document No.");
                                                        IH.SETRANGE("Material Request No.", MIH."No.");
                                                        IF IH.FINDFIRST THEN
                                                              //   IF IH."Released Status"= IH."Released Status"::Released THEN
                                                              BEGIN
                                                            Rqst_no := MIH."No.";
                                                            Rqstd_user := MIH."User ID";
                                                            Rqstd_Item := MIL."Item No.";
                                                            Rqstd_Qty := MIL.Quantity;
                                                            Pending_Qty := MIL."Outstanding Quantity";
                                                            Mail1.AppendBody('<tr><td style=width:3%>' + Rqst_no + '</td><td style=width:3%>' + Rqstd_Item + '</td><td style=width:25%>' + MIL.Description + '</td><td style=width:2%>' + FORMAT(MIL.Quantity) + '</td>' +
                                                                       '<td style=width:2%>' + FORMAT(MIL."Outstanding Quantity") + '</td><td style=width:2%>' + FORMAT(Stock_At_Str_Qty) + '</td><td style=width:2%>' + MIL."Unit of Measure" + '</td>' +
                                                                       '<td style=width:15%>' + IH."No." + '</td><td style=width:7%>' + FORMAT(IH."Released Date") + '</td><td></td><td></td><td></td>' +
                                                                       '<td style=width:10%>Items To Be Ordered</td></tr>');

                                                        END
                                                        ELSE BEGIN//need to create
                                                            Rqst_no := MIH."No.";
                                                            Rqstd_user := MIH."User ID";
                                                            Rqstd_Item := MIL."Item No.";
                                                            Rqstd_Qty := MIL.Quantity;
                                                            Pending_Qty := MIL."Outstanding Quantity";
                                                            Mail1.AppendBody('<tr><td style=width:10%>' + Rqst_no + '</td><td style=width:10%>' + Rqstd_Item + '</td><td style=width:25%>' + MIL.Description + '</td><td style=width:2%>' + FORMAT(MIL.Quantity) + '</td>' +
                                                             '<td style=width:2%>' + FORMAT(MIL."Outstanding Quantity") + '</td><td style=width:2%>' + FORMAT(Stock_At_Str_Qty) + '</td><td style=width:2%>' + MIL."Unit of Measure" + '</td>' +
                                                             '<td ></td><td></td><td></td><td></td><td style=width:7%>' + Pl.Remarks + '</td>' +
                                                             '<td style=width:10%>Items To Be Ordered With Other Request</td></tr>');
                                                        END;
                                                    END
                                                    ELSE  // if not in indent too
                                                       BEGIN
                                                        Pl.RESET;
                                                        Pl.SETRANGE("No.", MIL."Item No.");
                                                        Pl.SETFILTER("Qty. to Receive", '>%1', 0);
                                                        Pl.SETRANGE("Document Type", Pl."Document Type"::Order);
                                                        IF Pl.FINDSET THEN BEGIN
                                                            IH.RESET;
                                                            IH.SETRANGE("No.", Pl."Indent No.");
                                                            IF IH.FINDSET THEN BEGIN
                                                                Rqst_no := MIH."No.";
                                                                Rqstd_user := MIH."User ID";
                                                                Rqstd_Item := MIL."Item No.";
                                                                Rqstd_Qty := MIL.Quantity;
                                                                Pending_Qty := MIL."Outstanding Quantity";
                                                                Mail1.AppendBody('<tr><td style=width:10%>' + Rqst_no + '</td><td style=width:10%>' + Rqstd_Item + '</td><td style=width:25%>' + MIL.Description + '</td><td style=width:2%>' + FORMAT(MIL.Quantity) + '</td>' +
                                                                     '<td style=width:2%>' + FORMAT(MIL."Outstanding Quantity") + '</td><td style=width:2%>' + FORMAT(Stock_At_Str_Qty) + '</td><td style=width:2%>' + MIL."Unit of Measure" + '</td>' +
                                                                      '<td style=width:15%>' + Pl."Indent No." + '</td><td style=width:7%>' + FORMAT(IH."Release Date Time") + '</td><td style=width:15%>' + Pl."Document No." + '</td>' +
                                                                      '<td style=width:3%>' + FORMAT(Pl."Deviated Receipt Date") + '</td><td style=width:7%>' + Pl.Remarks + '</td>' +
                                                                      '<td style=width:10%>Items To Be Received</td></tr>');
                                                            END
                                                            ELSE BEGIN
                                                                Rqst_no := MIH."No.";
                                                                Rqstd_user := MIH."User ID";
                                                                Rqstd_Item := MIL."Item No.";
                                                                Rqstd_Qty := MIL.Quantity;
                                                                Pending_Qty := MIL."Outstanding Quantity";
                                                                Mail1.AppendBody('<tr><td style=width:10%>' + Rqst_no + '</td><td style=width:10%>' + Rqstd_Item + '</td><td style=width:25%>' + MIL.Description + '</td><td style=width:2%>' + FORMAT(MIL.Quantity) + '</td>' +
                                                                     '<td style=width:2%>' + FORMAT(MIL."Outstanding Quantity") + '</td><td style=width:2%>' + FORMAT(Stock_At_Str_Qty) + '</td><td style=width:2%>' + MIL."Unit of Measure" + '</td>' +
                                                                      '<td style=width:15%>' + Pl."Indent No." + '</td><td></td><td style=width:15%>' + Pl."Document No." + '</td>' +
                                                                      '<td style=width:3%>' + FORMAT(Pl."Deviated Receipt Date") + '</td><td style=width:7%>' + Pl.Remarks + '</td>' +
                                                                      '<td style=width:10%>Items To Be Received</td></tr>');
                                                            END;
                                                        END
                                                        ELSE BEGIN
                                                            Rqst_no := MIH."No.";
                                                            Rqstd_user := MIH."User ID";
                                                            Rqstd_Item := MIL."Item No.";
                                                            Rqstd_Qty := MIL.Quantity;
                                                            Pending_Qty := MIL."Outstanding Quantity";
                                                            Mail1.AppendBody('<tr><td style=width:3%>' + Rqst_no + '</td><td style=width:3%>' + Rqstd_Item + '</td><td style=width:25%>' + MIL.Description + '</td><td style=width:2%>' + FORMAT(MIL.Quantity) + '</td>' +
                                                                    '<td style=width:2%>' + FORMAT(MIL."Outstanding Quantity") + '</td><td style=width:2%>' + FORMAT(Stock_At_Str_Qty) + '</td><td style=width:2%>' + MIL."Unit of Measure" + '</td>' +
                                                                    '<td></td><td></td><td></td><td style=width:3%></td><td></td>' +
                                                                 '<td style=width:10%>Indent Need to Be Created</td></tr>');
                                                        END;
                                                    END;
                                                END;
                                                MIH.Alert_Mail_Sent_date := TODAY;
                                                MIH.MODIFY;
                                            UNTIL MIL.NEXT = 0;
                                    //IF Rqstd_user_old <> Rqstd_user THEN
                                    //  Mail.Send;
                                    MIH.Alert_Mail_Sent_date := TODAY;
                                    MIH.MODIFY;
                                UNTIL MIH.NEXT = 0;

        END; */ //B2B UPG <<<

        IF MIH.FINDSET THEN BEGIN
            Subject := 'Material Request Stage';
            REPEAT
                // Mail_To := 'sujani@efftronics.com';
                user.RESET;

                user.SETRANGE("User ID", MIH."User ID");
                IF user.FINDFIRST THEN
                    Rqsted_Mails := user.MailID;
                IF Rqstd_user_old <> MIH."User ID" THEN BEGIN
                    IF Rqstd_user_old <> '' THEN BEGIN
                        Body += ('</table><br>');
                        Body += ('<p align ="left"> Regards,<br>ERP Team </p>');
                        Body += ('<p align = "center">:: Note: Auto Generated mail from ERP</b> :: </b></P></div></body></html>');
                        //Mail1.Send;
                    END;
                    //Mail1.CreateMessage('ERP', 'erp@efftronics.com', Rqsted_Mails, Subject, Body, TRUE);
                    //Mail1.CreateMessage('ERP','erp@efftronics.com',Mail_To,Subject,Body,TRUE);
                    //Mail1.AddBCC('erp@efftronics.com');
                    Recipients.Add('erp@efftronics.com');
                    EmailMessage.Create(Recipients, Subject, Body, true);
                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

                    Body += ('<html><head><style> divone{background-color: white; width: 1500px; padding: 20px; border-style:solid ; border-color:#CB80F4;  margin: 20px;} </style></head>');
                    Body += ('<body><div style="border-color:#CB80F4;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 1200px;"><label><font size="6">Your Requested Materials State</font></label>');
                    Body += ('<hr style=solid; color= #3333CC>');
                    Body += ('<h>Dear Sir/Mam ,</h><br>    Below is the Details of your requested Materials<br>');
                    Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;">' +
                                        '<tr><th>Requisation No</th><th>Item No</th><th>Item Desc</th><th>Req Qty</th><th>Pending Qty</th><th>Stock At Str</th>' +
                                         '<th>UOM</th><th>Indent No</th><th>Indent Released Dt</th><th>PO NO</th><th>Expected Rcvd Dt</th><th>PO Remarks</th><th>State</th></tr>');
                    Rqstd_user_old := MIH."User ID";
                END;
                MIL.RESET;
                MIL.SETRANGE("Document No.", MIH."No.");
                MIL.SETFILTER("Outstanding Quantity", '>%1', 0);
                IF MIL.FINDFIRST THEN
                    REPEAT
                        Item.RESET;
                        Item.SETRANGE("No.", MIL."Item No.");
                        IF Item.FINDFIRST THEN BEGIN
                            Item.CALCFIELDS("Inventory at Stores");
                            Stock_At_Str_Qty := Item."Inventory at Stores";
                        END;
                        IF Stock_At_Str_Qty > 0 THEN BEGIN // have a stock bt still in released state
                            Rqst_no := MIH."No.";
                            Rqstd_user := MIH."User ID";
                            Rqstd_Item := MIL."Item No.";
                            Rqstd_Qty := MIL.Quantity;
                            Pending_Qty := MIL."Outstanding Quantity";
                            Body += ('<tr><td style=width:3%>' + Rqst_no + '</td><td style=width:3%>' + Rqstd_Item + '</td><td style=width:25%>' + MIL.Description + '</td><td style=width:2%>' + FORMAT(MIL.Quantity) + '</td>' +
                                 '<td style=width:2%>' + FORMAT(MIL."Outstanding Quantity") + '</td><td style=width:2%>' + FORMAT(Stock_At_Str_Qty) + '</td><td style=width:2%>' + MIL."Unit of Measure" + '</td>' +
                                 '<td></td><td></td><td></td><td style=width:3%>Depends on Posting</td><td></td>' +
                                 '<td style=width:10%>Request Released State</td></tr>');
                        END ELSE BEGIN
                            IL.RESET;
                            IL.SETRANGE("No.", MIL."Item No.");
                            IL.SETRANGE("Indent Status", IL."Indent Status"::Indent);
                            IF IL.FINDSET THEN BEGIN
                                IH.RESET;
                                IH.SETRANGE("No.", IL."Document No.");
                                IH.SETRANGE("Material Request No.", MIH."No.");
                                IF IH.FINDFIRST THEN
                                      //   IF IH."Released Status"= IH."Released Status"::Released THEN
                                      BEGIN
                                    Rqst_no := MIH."No.";
                                    Rqstd_user := MIH."User ID";
                                    Rqstd_Item := MIL."Item No.";
                                    Rqstd_Qty := MIL.Quantity;
                                    Pending_Qty := MIL."Outstanding Quantity";
                                    Body += ('<tr><td style=width:3%>' + Rqst_no + '</td><td style=width:3%>' + Rqstd_Item + '</td><td style=width:25%>' + MIL.Description + '</td><td style=width:2%>' + FORMAT(MIL.Quantity) + '</td>' +
                                               '<td style=width:2%>' + FORMAT(MIL."Outstanding Quantity") + '</td><td style=width:2%>' + FORMAT(Stock_At_Str_Qty) + '</td><td style=width:2%>' + MIL."Unit of Measure" + '</td>' +
                                               '<td style=width:15%>' + IH."No." + '</td><td style=width:7%>' + FORMAT(IH."Released Date") + '</td><td></td><td></td><td></td>' +
                                               '<td style=width:10%>Items To Be Ordered</td></tr>');

                                END
                                ELSE BEGIN//need to create
                                    Rqst_no := MIH."No.";
                                    Rqstd_user := MIH."User ID";
                                    Rqstd_Item := MIL."Item No.";
                                    Rqstd_Qty := MIL.Quantity;
                                    Pending_Qty := MIL."Outstanding Quantity";
                                    Body += ('<tr><td style=width:10%>' + Rqst_no + '</td><td style=width:10%>' + Rqstd_Item + '</td><td style=width:25%>' + MIL.Description + '</td><td style=width:2%>' + FORMAT(MIL.Quantity) + '</td>' +
                                     '<td style=width:2%>' + FORMAT(MIL."Outstanding Quantity") + '</td><td style=width:2%>' + FORMAT(Stock_At_Str_Qty) + '</td><td style=width:2%>' + MIL."Unit of Measure" + '</td>' +
                                     '<td ></td><td></td><td></td><td></td><td style=width:7%>' + Pl.Remarks + '</td>' +
                                     '<td style=width:10%>Items To Be Ordered With Other Request</td></tr>');
                                END;
                            END
                            ELSE  // if not in indent too
                               BEGIN
                                Pl.RESET;
                                Pl.SETRANGE("No.", MIL."Item No.");
                                Pl.SETFILTER("Qty. to Receive", '>%1', 0);
                                Pl.SETRANGE("Document Type", Pl."Document Type"::Order);
                                IF Pl.FINDSET THEN BEGIN
                                    IH.RESET;
                                    IH.SETRANGE("No.", Pl."Indent No.");
                                    IF IH.FINDSET THEN BEGIN
                                        Rqst_no := MIH."No.";
                                        Rqstd_user := MIH."User ID";
                                        Rqstd_Item := MIL."Item No.";
                                        Rqstd_Qty := MIL.Quantity;
                                        Pending_Qty := MIL."Outstanding Quantity";
                                        Body += ('<tr><td style=width:10%>' + Rqst_no + '</td><td style=width:10%>' + Rqstd_Item + '</td><td style=width:25%>' + MIL.Description + '</td><td style=width:2%>' + FORMAT(MIL.Quantity) + '</td>' +
                                             '<td style=width:2%>' + FORMAT(MIL."Outstanding Quantity") + '</td><td style=width:2%>' + FORMAT(Stock_At_Str_Qty) + '</td><td style=width:2%>' + MIL."Unit of Measure" + '</td>' +
                                              '<td style=width:15%>' + Pl."Indent No." + '</td><td style=width:7%>' + FORMAT(IH."Release Date Time") + '</td><td style=width:15%>' + Pl."Document No." + '</td>' +
                                              '<td style=width:3%>' + FORMAT(Pl."Deviated Receipt Date") + '</td><td style=width:7%>' + Pl.Remarks + '</td>' +
                                              '<td style=width:10%>Items To Be Received</td></tr>');
                                    END
                                    ELSE BEGIN
                                        Rqst_no := MIH."No.";
                                        Rqstd_user := MIH."User ID";
                                        Rqstd_Item := MIL."Item No.";
                                        Rqstd_Qty := MIL.Quantity;
                                        Pending_Qty := MIL."Outstanding Quantity";
                                        Body += ('<tr><td style=width:10%>' + Rqst_no + '</td><td style=width:10%>' + Rqstd_Item + '</td><td style=width:25%>' + MIL.Description + '</td><td style=width:2%>' + FORMAT(MIL.Quantity) + '</td>' +
                                             '<td style=width:2%>' + FORMAT(MIL."Outstanding Quantity") + '</td><td style=width:2%>' + FORMAT(Stock_At_Str_Qty) + '</td><td style=width:2%>' + MIL."Unit of Measure" + '</td>' +
                                              '<td style=width:15%>' + Pl."Indent No." + '</td><td></td><td style=width:15%>' + Pl."Document No." + '</td>' +
                                              '<td style=width:3%>' + FORMAT(Pl."Deviated Receipt Date") + '</td><td style=width:7%>' + Pl.Remarks + '</td>' +
                                              '<td style=width:10%>Items To Be Received</td></tr>');
                                    END;
                                END
                                ELSE BEGIN
                                    Rqst_no := MIH."No.";
                                    Rqstd_user := MIH."User ID";
                                    Rqstd_Item := MIL."Item No.";
                                    Rqstd_Qty := MIL.Quantity;
                                    Pending_Qty := MIL."Outstanding Quantity";
                                    Body += ('<tr><td style=width:3%>' + Rqst_no + '</td><td style=width:3%>' + Rqstd_Item + '</td><td style=width:25%>' + MIL.Description + '</td><td style=width:2%>' + FORMAT(MIL.Quantity) + '</td>' +
                                            '<td style=width:2%>' + FORMAT(MIL."Outstanding Quantity") + '</td><td style=width:2%>' + FORMAT(Stock_At_Str_Qty) + '</td><td style=width:2%>' + MIL."Unit of Measure" + '</td>' +
                                            '<td></td><td></td><td></td><td style=width:3%></td><td></td>' +
                                         '<td style=width:10%>Indent Need to Be Created</td></tr>');
                                END;
                            END;
                        END;
                        MIH.Alert_Mail_Sent_date := TODAY;
                        MIH.MODIFY;
                    UNTIL MIL.NEXT = 0;
                //IF Rqstd_user_old <> Rqstd_user THEN
                //  Mail.Send;
                MIH.Alert_Mail_Sent_date := TODAY;
                MIH.MODIFY;
            UNTIL MIH.NEXT = 0;

        END;
    end;

    procedure Stock_Alert_On_Threshold();
    begin
        /* Item.RESET;
        Item.SETCURRENTKEY("No.");
        Item.SETFILTER(Stock_Threshold_Value, '>%1', 0);
        IF Item.FINDSET THEN
            Mail_To := 'vanidevi@efftronics.com,temc@efftronics.com,purchase@efftronics.com,controlroom@efftronics.com,padmaja@efftronics.com,store@efftronics.com';
        Subject := 'Item Stock Details';
        SMTP_MAIL.CreateMessage('ERP', 'erp@efftronics.com', Mail_To, Subject, Body, TRUE);
        Body += ('<html><head><style> divone{background-color: white; width:600px; padding: 20px; border-style:solid ; border-color:skyblue;  margin: 10px;} </style></head>');
        Body += ('<body><div style="border-color:skyblue;  margin:10px; border-width:10px;   border-style:solid; padding: 20px; width: 600px;"><label><font size="5">Item Stock Details</font></label>');
        Body += ('<hr style=solid; color= #3333CC>');
        Body += ('<h>Dear Sir/Mam ,</h> <br/> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Below are the Item details having stock less than the specified threshold value <br/>');
        Body += ('<table border="1" style="border-collapse:collapse; width:60%; font-size:10pt;">' +
             '<tr><th>Item No</th><th>Item Desc</th><th>Alert Threshold</th><th>Rem Qty (STR&MCH)</th><th>Uom</th></tr>');
        REPEAT
            ILE.RESET;
            ILE.SETCURRENTKEY(ILE."Item No.", ILE."Location Code", ILE."Global Dimension 1 Code", ILE."Global Dimension 2 Code", ILE.Open, ILE."Remaining Quantity");
            ILE.SETRANGE("Item No.", Item."No.");
            //ILE.SETRANGE("Location Code",'STR');
            ILE.SETFILTER("Location Code", '%1|%2', 'STR', 'MCH');
            ILE.SETFILTER("Remaining Quantity", '>%1', 0);
            ILE.SETFILTER(Open, FORMAT(TRUE));
            ileqty := 0;
            IF ILE.FINDSET THEN
                REPEAT
                    ileqty := ileqty + ILE."Remaining Quantity";
                UNTIL ILE.NEXT = 0;
            IF ileqty < Item.Stock_Threshold_Value THEN BEGIN
                Body += ('<tr><td style=width:3%>' + Item."No." + '</td><td style=width:25%;word-wrap:break-word;>' + Item.Description +
                '</td><td style=width:2%>' + FORMAT(Item.Stock_Threshold_Value) + '</td><td style=width:2%>' + FORMAT(ileqty) + '</td><td style=width:3%>' + ILE."Unit of Measure Code" + '</td></tr>');
            END;
        UNTIL Item.NEXT = 0;
        Body += ('</table><br>');
        Body += ('<hr style=solid; color= #3333CC>');
        Body += ('<b>Regards,<br>ERP</b><br>');
        Body += ('<br>********::<i>Note</i>: This is System generated Automail::********</b>');
        SMTP_MAIL.AddBCC('erp@efftronics.com');
        SMTP_MAIL.Send; */  //B2BUPG

        Item.RESET;
        Item.SETCURRENTKEY("No.");
        Item.SETFILTER(Stock_Threshold_Value, '>%1', 0);
        IF Item.FINDSET THEN
            Recipients.Add('vanidevi@efftronics.com');
        Recipients.Add('temc@efftronics.com');
        Recipients.Add('purchase@efftronics.com');
        Recipients.Add('controlroom@efftronics.com');
        Recipients.Add('padmaja@efftronics.com');
        Recipients.Add('store@efftronics.com');
        Subject := 'Item Stock Details';
        EmailMessage.Create(Recipients, Subject, Body, true);
        Body += ('<html><head><style> divone{background-color: white; width:600px; padding: 20px; border-style:solid ; border-color:skyblue;  margin: 10px;} </style></head>');
        Body += ('<body><div style="border-color:skyblue;  margin:10px; border-width:10px;   border-style:solid; padding: 20px; width: 600px;"><label><font size="5">Item Stock Details</font></label>');
        Body += ('<hr style=solid; color= #3333CC>');
        Body += ('<h>Dear Sir/Mam ,</h> <br/> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Below are the Item details having stock less than the specified threshold value <br/>');
        Body += ('<table border="1" style="border-collapse:collapse; width:60%; font-size:10pt;">' +
             '<tr><th>Item No</th><th>Item Desc</th><th>Alert Threshold</th><th>Rem Qty (STR&MCH)</th><th>Uom</th></tr>');
        REPEAT
            ILE.RESET;
            ILE.SETCURRENTKEY(ILE."Item No.", ILE."Location Code", ILE."Global Dimension 1 Code", ILE."Global Dimension 2 Code", ILE.Open, ILE."Remaining Quantity");
            ILE.SETRANGE("Item No.", Item."No.");
            //ILE.SETRANGE("Location Code",'STR');
            ILE.SETFILTER("Location Code", '%1|%2', 'STR', 'MCH');
            ILE.SETFILTER("Remaining Quantity", '>%1', 0);
            ILE.SETFILTER(Open, FORMAT(TRUE));
            ileqty := 0;
            IF ILE.FINDSET THEN
                REPEAT
                    ileqty := ileqty + ILE."Remaining Quantity";
                UNTIL ILE.NEXT = 0;
            IF ileqty < Item.Stock_Threshold_Value THEN BEGIN
                Body += ('<tr><td style=width:3%>' + Item."No." + '</td><td style=width:25%;word-wrap:break-word;>' + Item.Description +
                '</td><td style=width:2%>' + FORMAT(Item.Stock_Threshold_Value) + '</td><td style=width:2%>' + FORMAT(ileqty) + '</td><td style=width:3%>' + ILE."Unit of Measure Code" + '</td></tr>');
            END;
        UNTIL Item.NEXT = 0;
        Body += ('</table><br>');
        Body += ('<hr style=solid; color= #3333CC>');
        Body += ('<b>Regards,<br>ERP</b><br>');
        Body += ('<br>********::<i>Note</i>: This is System generated Automail::********</b>');
        Recipients.Add('erp@efftronics.com');
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;


    local procedure Posting_date_changes();
    begin

        IF USER_SETUP."User ID" IN ['EFFTRONICS\SUJANI'] THEN BEGIN
            USER_SETUP."Allow Posting To" := CALCDATE('1D', TODAY());
        END;

        /*IF USER_SETUP.FINDSET THEN
        REPEAT
          IF NOT (USER_SETUP."User ID" IN['EFFTRONICS\RAJANI','EFFTRONICS\SITARAJYAM','EFFTRONICS\RAMKUMARL',
                                          'EFFTRONICS\YESU'])THEN
          BEGIN
            USER_SETUP."Allow Posting To":=CALCDATE('1D',TODAY());
            USER_SETUP.MODIFY;
          END
          ELSE IF  (USER_SETUP."User ID" IN['EFFTRONICS\SITARAJYAM','EFFTRONICS\ASWINI'])THEN BEGIN
              USER_SETUP."Allow Posting To" := CALCDATE('92D', TODAY());
          END
          ELSE IF  (USER_SETUP."User ID" IN['EFFTRONICS\RAJANI','EFFTRONICS\RAMKUMARL',
                                          'EFFTRONICS\YESU','EFFTRONICS\DURGARAOV'])THEN BEGIN
                USER_SETUP."Allow Posting To" := CALCDATE('31D', TODAY());
          END;
        
        UNTIL USER_SETUP.NEXT=0;*/

        /* "Restrict Store Material Issues":=FALSE;
         IF "Production_ Shortage_Status"<>"Production_ Shortage_Status"::Accepted THEN
           "Production_ Shortage_Status":="Production_ Shortage_Status"::nothing;
             "Allow Posting to(15)":="Allow Posting To"-15;
         MODIFY;
        
        New_Line:=10;
        {bg.SETRANGE(bg.Status,bg.Status::Open);
        bg.SETFILTER(bg."Expiry Date",'<%1',TODAY+10);
        MESSAGE(FORMAT(TODAY+10));
        bg.SETFILTER(bg."Claim Date",'=%1',0D);
        //REPORT.RUN(50202,FALSE,FALSE,bg);
        REPORT.SAVEASPDF(33000891,'\\erpserver\ErpAttachments\bg1.PDF',FALSE,bg);
        Attachment:='\\erpserver\ErpAttachments\bg1.PDF';
        bg.RESET; }
        //bg.SETRANGE(bg.Status,bg.Status::Open); for relase option purpose
        bg.SETFILTER(bg.Closed,'No');
        bg.SETFILTER(bg."BG No.",'<>%1','F%');
        bg.SETFILTER(bg."Claim Date",'<%1',TODAY+10);
        //bg.SETFILTER(bg."Expiry Date",'<>%1',0D);
        bg.SETFILTER(bg."Expiry Date",'<%1',TODAY+10);
        IF bg.FINDFIRST THEN BEGIN
        //REPORT.RUN(33000891,FALSE,FALSE,bg);
        REPORT.SAVEASPDF(33000891,'\\erpserver\ErpAttachments\bg1.pdf',bg);
        Attachment1:='\\erpserver\ErpAttachments\bg1.pdf';
        Subject:='ERP- Possible expire BG Details for the coming 10 Days';
        
        
        
        Body:='***** Auto Mail Generated From ERP *****';
        Mail_From:='noreply@efftronics.com';
        //Mail_To:='sreenu@efftronics.com';
        IF FORMAT(bg."Transaction Type")='amc' THEN
        BEGIN
        Mail_To:='rajani@efftronics.com,yesu@efftronics.com,susmithal@efftronics.com,erp@efftronics.com,';
        Mail_To+='sales@efftronics.com';
        END
        ELSE
        BEGIN
        //Mail_To:='anilkumar@efftronics.com';
        Mail_To:='rajani@efftronics.com,';//dir
        Mail_To+='sales@efftronics.com,yesu@efftronics.com,susmithal@efftronics.com,erp@efftronics.com';
        END;
        //attachment13:='';
        attachment14:=Attachment;
         IF (Mail_From<>'')AND(Mail_To<>'') THEN
              SMTP_MAIL.CreateMessage('ERP',Mail_From,Mail_To,Subject,Body,TRUE);
              //EFFUPG Start
              {
              SMTP_MAIL.AddAttachment(Attachment1);
             // SMTP_MAIL.AddAttachment(attachment13);
              SMTP_MAIL.AddAttachment(attachment14);
              }
             SMTP_MAIL.AddAttachment(Attachment1,'');
             // SMTP_MAIL.AddAttachment(attachment13);
              SMTP_MAIL.AddAttachment(attachment14,'');
              SMTP_MAIL.Send;
              //EFFUPG End
        END;
        
          Item.CALCFIELDS(Item."Stock at PROD Stores");
          Item.SETFILTER(Item."Safety Stock Quantity",'>%1',(Item."Stock at Stores"+Item."Stock at PROD Stores"));
          Cs_Shortage_QTY:=Item.COUNT;
          Body+='****  Automatic Mail Generated From ERP  ****';
          REPORT.RUN(33000892,FALSE,FALSE,Item);
          "g/l setup".FINDFIRST;
          REPORT.SAVEASPDF(33000892,FORMAT('\\erpserver\ErpAttachments\'+'STR Shortage'+'.PDF'));
        
          Mail_From:='noreply@efftronics.com';
          Mail_To:='Store@efftronics.com,Padmaja@efftronics.com,';
          Mail_To+='erp@efftronics.com';
          // Mail_To:='anilkumar@efftronics.com';
          Subject:=' Shortage at Main Stores ';
        
          Attachment:='\\erpserver\ErpAttachments\'+'STR Shortage.PDF';
          SMTP_MAIL.CreateMessage('ERP',Mail_From,Mail_To,Subject,Body,TRUE);
          // SMTP_MAIL.AddAttachment(Attachment1);
          // SMTP_MAIL.AddAttachment(attachment13);
          IF EXISTS(Attachment) THEN  // Condition added by Pranavi on 13-Jan-2016 for solving error if shortage items doesnot exist
          BEGIN
           //EFFUPG Start
           {
           SMTP_MAIL.AddAttachment(Attachment);
           }
           SMTP_MAIL.AddAttachment(Attachment,'');
           //EFFUPG End
            SMTP_MAIL.Send;
          END;
        // End of MAIN STORES SHORTAGE MATERIAL AUTOMATIC REPORT
        
        
        REPORT.RUN(50023,FALSE); // Added by rakesh to run Report 50023 automatically on 27-Dec-14
        */

    end;

    procedure Open_Orders_Allert();
    begin
        // created by Vishnu Priya for the Verified Orders That are still in the Open State on 01-10-2018
        salesheader.RESET;
        salesheader.SETFILTER("Sale Order Created", FORMAT(0));
        salesheader.SETFILTER("Order Verified", FORMAT(1));
        salesheader.SETFILTER(Status, FORMAT(0));
        /* Subject := 'Verified Orders But in Open Status ';
        Mail_From := 'erp@efftronics.com';

        Mail_To := 'sales@efftronics.com,divya@efftronics.com,kmounika@effe.in,marketing@efftronics.com,marketing@effe.in';
        SMTP_MAIL.CreateMessage('erp', 'erp@efftronics.com', Mail_To, 'ERP - ' + Subject, Body, TRUE);
        Body += ('<html><head><style> divone{background-color: white; width: 500px; padding: 20px; border-style:solid ; border-color:#b268ab;  margin: 20px;} </style></head>');
        Body += ('<body><div style="border-color:#2980b9;  margin: 20px; border-width:10px;   border-style:solid; padding: 10px; width: 900px;">');
        Body += ('<label><font size="6"> Order Verified but Status is in Open Orders List </font></label>');
        Body += ('<hr style=solid; color= #c0392b >');
        Body += ('<h>Dear Sir/Madam,</h><br>');
        Body += ('<P>      These are the List of  Orders that are verified but still in OPEN Status</P>');
        Body += ('<table border = "1" style="border-collapse:collapse; width:90%; fond-size:9pt;">');
        Body += ('<tr>');
        Body += ('<th>Order No </th>');
        Body += ('<th>Customer Name</th>');
        Body += ('<th>Status</th>');
        Body += ('<th>Verified Status</th>');
        Body += ('<th>Sale Order Value </th>');
        Body += ('</tr>');
        salesheader.SETCURRENTKEY("Document Date");
        salesheader.ASCENDING(FALSE);
        IF salesheader.FINDSET THEN
            REPEAT
                Body += ('<tr>');
                Body += ('<td>' + ' ' + FORMAT(salesheader."No.") + '</td>');
                Body += ('<td>' + ' ' + FORMAT(salesheader."Sell-to Customer Name") + '</td>');
                Body += ('<td>' + ' ' + FORMAT(salesheader.Status) + '</td>');
                Body += ('<td>' + ' ' + FORMAT(salesheader."Order Verified") + '</td>');
                Body += ('<td>' + ' ' + FORMAT(salesheader."Sale Order Total Amount") + '</td>');
                Body += ('</tr>');
            UNTIL salesheader.NEXT = 0;
        Body += ('</table>');
        Body += ('<br>regards,<br>');
        Body += ('ERP.<br>');
        Body += ('<br>');
        Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><p align= "center"> AUTO GENERATED MAIL FROM ERP </div><br/></div>');
        SMTP_MAIL.AddCC('vanidevi@efftronics.com,erp@efftronics.com,controlroom@efftronics.com');
        SMTP_MAIL.Send; */   //B2BUPG

        Subject := 'Verified Orders But in Open Status ';
        Recipients.Add('sales@efftronics.com');
        Recipients.Add('divya@efftronics.com');
        Recipients.Add('kmounika@effe.in');
        Recipients.Add('marketing@efftronics.com');
        Recipients.Add('marketing@effe.in');
        EmailMessage.Create(Recipients, Subject, Body, true);
        Body += ('<html><head><style> divone{background-color: white; width: 500px; padding: 20px; border-style:solid ; border-color:#b268ab;  margin: 20px;} </style></head>');
        Body += ('<body><div style="border-color:#2980b9;  margin: 20px; border-width:10px;   border-style:solid; padding: 10px; width: 900px;">');
        Body += ('<label><font size="6"> Order Verified but Status is in Open Orders List </font></label>');
        Body += ('<hr style=solid; color= #c0392b >');
        Body += ('<h>Dear Sir/Madam,</h><br>');
        Body += ('<P>      These are the List of  Orders that are verified but still in OPEN Status</P>');
        Body += ('<table border = "1" style="border-collapse:collapse; width:90%; fond-size:9pt;">');
        Body += ('<tr>');
        Body += ('<th>Order No </th>');
        Body += ('<th>Customer Name</th>');
        Body += ('<th>Status</th>');
        Body += ('<th>Verified Status</th>');
        Body += ('<th>Sale Order Value </th>');
        Body += ('</tr>');
        salesheader.SETCURRENTKEY("Document Date");
        salesheader.ASCENDING(FALSE);
        IF salesheader.FINDSET THEN
            REPEAT
                Body += ('<tr>');
                Body += ('<td>' + ' ' + FORMAT(salesheader."No.") + '</td>');
                Body += ('<td>' + ' ' + FORMAT(salesheader."Sell-to Customer Name") + '</td>');
                Body += ('<td>' + ' ' + FORMAT(salesheader.Status) + '</td>');
                Body += ('<td>' + ' ' + FORMAT(salesheader."Order Verified") + '</td>');
                Body += ('<td>' + ' ' + FORMAT(salesheader."Sale Order Total Amount") + '</td>');
                Body += ('</tr>');
            UNTIL salesheader.NEXT = 0;
        Body += ('</table>');
        Body += ('<br>regards,<br>');
        Body += ('ERP.<br>');
        Body += ('<br>');
        Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><p align= "center"> AUTO GENERATED MAIL FROM ERP </div><br/></div>');
        Recipients.Add('vanidevi@efftronics.com');
        Recipients.Add('erp@efftronics.com');
        Recipients.Add('controlroom@efftronics.com');
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;

    procedure RD_Mail_for_SalesOrders();
    begin
        //Added by Vishnu Priya for the R&D managers pending orders reasons alerts
        Managers[1] := '01TD001';
        Managers[2] := '17RD031';
        Managers[3] := '17RD033';
        Managers[4] := '17RD038';
        Managers[5] := '17RD052';

        Subject := ' R&D Side-Pending Sale Orders';
        // MESSAGE(FORMAT("Allow Posting To"));
        FOR No_of_Managers := 1 TO ARRAYLEN(Managers) DO BEGIN
            ISG.RESET;
            ISG.SETCURRENTKEY(ISG."Product Group Code", Code);
            ISG.SETFILTER(ISG."Product Group Code", 'FPRODUCT');
            ISG.SETFILTER(ISG."Incharge id", Managers[No_of_Managers]);
            IF ISG.FINDSET THEN BEGIN
                //MESSAGE(FORMAT(ISG.COUNT));

                ISG1.RESET;
                ISG1.SETFILTER("Incharge id", Managers[No_of_Managers]);
                t3 := '';
                IF ISG1.FINDSET THEN
                    //newly adding on 09-10-2019
                    REPEAT
                        t3 := t3 + ISG1.Code + '|';
                    UNTIL ISG1.NEXT = 0;
                t2 := DELCHR(t3, '>', '|');
                //end by vishnu on 09-10-2019
                US.RESET;
                US.SETFILTER(EmployeeID, Managers[No_of_Managers]);
                US.FINDFIRST;
                //Mail_To := US.MailID;
                Recipients.Add(US.MailID);
                // version 2  for the  waste messages stop without body written by vishnu priya on 15-05-2019
                SalesLine.RESET;
                SalesLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                //SalesLine.SETFILTER(Type,'Item'); commented by Vishnu Priya
                //SalesLine.SETFILTER("Document Type",'Order'); commented by Vishnu Priya
                //SalesLine.SETFILTER("Document Type",'%1|%2',SalesLine."Document Type"::"Blanket Order",SalesLine."Document Type"::Order);
                SalesLine.SETFILTER("Document Type", '%1|%2', 1, 4);
                SalesLine.SETFILTER("Outstanding Quantity", '>%1', 0);
                SalesLine.SETRANGE(MainCategory, 3);
                SalesLine.SETFILTER(ProductGroup, t2);
                IF SalesLine.FINDSET THEN BEGIN
                    /* SMTP_MAIL.CreateMessage('erp', 'erp@efftronics.com', Mail_To, Subject, Body, TRUE);
                    Body += ('<html><head><style> divone{background-color: white; width: 2800px; padding: 20px; border-style:solid ; border-color:#b268ab;  margin: 20px;} </style></head>');
                    Body += ('<body><div style="border-color:#2980b9;  margin: 15px; border-width:8px;   border-style:solid; padding: 8px; width: 2800px;">');
                    Body += ('<label><font size="6">To be Executed Sale Orders List </font></label>');
                    Body += ('<hr style=solid; color= #c0392b >');
                    Body += ('<h>Dear Sir/Madam,</h><br>');
                    Body += ('<P>        These are the List of  Orders that are in Pending from R&D Side</P>');
                    Body += ('<table border = "1" style="border-collapse:collapse; width:100%; fond-size:5pt;">');
                    Body += ('<tr>');
                    Body += ('<th> Order Number </th>');
                    Body += ('<th> Item </th>');
                    Body += ('<th> Description </th>');
                    Body += ('<th> Product </th>');
                    Body += ('<th> Qty to Ship </th>');
                    Body += ('<th> Vertical </th>');
                    Body += ('<th> Main Category </th>');
                    Body += ('<th> Sub Category </th>');
                    Body += ('<th> Reason </th>');
                    Body += ('<th> Remarks </th>');
                    //Body += ('<th> Incharge </th>');
                    Body += ('</th>');
                    IF ISG1.FINDSET THEN
                        REPEAT
                            SalesLine1.RESET;
                            SalesLine1.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                            //SalesLine.SETFILTER(Type,'Item'); commented by Vishnu Priya
                            SalesLine1.SETFILTER("Document Type", '%1|%2', SalesLine1."Document Type"::"Blanket Order", SalesLine1."Document Type"::Order);
                            //SalesLine.SETFILTER("Document Type",'Order');
                            SalesLine1.SETFILTER("Outstanding Quantity", '>%1', 0);
                            SalesLine1.SETRANGE(MainCategory, 3);
                            SalesLine1.SETFILTER(ProductGroup, ISG1.Code);
                            IF SalesLine1.FINDSET THEN
                                REPEAT
                                BEGIN
                                    //MESSAGE(ISG."Incharge id" + ISG1.Code + FORMAT(SalesLine.COUNT));
                                    Body += ('<tr>');
                                    Body += ('<td  >' + ' ' + FORMAT(SalesLine1."Document No.") + '</td>');
                                    Body += ('<td >' + ' ' + FORMAT(SalesLine1."No.") + '</td>');
                                    Body += ('<td >' + ' ' + FORMAT(SalesLine1.Description) + '</td>');
                                    Body += ('<td >' + ' ' + FORMAT(SalesLine1.ProductGroup) + '</td>');
                                    Body += ('<td >' + ' ' + FORMAT(SalesLine1."Outstanding Quantity") + '</td>');
                                    Body += ('<td >' + ' ' + FORMAT(SalesLine1.Vertical) + '</td>');
                                    Body += ('<td >' + ' ' + FORMAT(SalesLine1.MainCategory) + '</td>');
                                    Body += ('<td >' + ' ' + FORMAT(SalesLine1.SubCategory) + '</td>');
                                    Body += ('<td >' + ' ' + FORMAT(SalesLine1.Reason) + '</td>');
                                    Body += ('<td >' + ' ' + FORMAT(SalesLine1.Remarks) + '</td>');
                                    //Body += ('<td >'+' '+FORMAT(US."Full Name")+'</td>');
                                    Body += ('</tr>');
                                END
                                UNTIL SalesLine1.NEXT = 0;
                        UNTIL ISG1.NEXT = 0;
                    Body += ('</table><br>');
                    Body += ('For report: <a href =' + '"https://app.powerbi.com/view?r=eyJrIjoiNTc0ZmQzNTYtNmJhMi00NWMwLThmMzQtYThmNjRhM2VhZWI0IiwidCI6IjZhZDY1ZDZkLWZkODctNDQ5OC04ZTkyLTUzNGM3YTA3ZjlmOCIsImMiOjEwfQ%3D%3D"' + '> click here </a><br>');
                    Body += ('<br>Regards,<br>');
                    Body += ('ERP.');
                    Body += ('<br>');
                    Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><p align= "center"> AUTO GENERATED MAIL FROM ERP </div><br/></div>');
                    IF DATE2DWY(TODAY, 1) = 1 THEN BEGIN
                        SMTP_MAIL.AddCC('erp@efftronics.com,controlroom@efftronics.com,vanidevi@efftronics.com,bhavani@efftronics.com,bharat@efftronics.com,mk@effe.in');
                        SMTP_MAIL.AddCC('ramasamy@efftronics.com,bala@efftronics.com,sbshankar@efftronics.com,anilkumar@efftronics.com,anvesh@efftronics.com');
                    END
                    ELSE
                        SMTP_MAIL.AddCC('erp@efftronics.com,controlroom@efftronics.com,vanidevi@efftronics.com');
                    //SMTP_MAIL.AddBCC('vishnupriya@efftronics.com');
                    SMTP_MAIL.Send; */  //B2BUPg

                    EmailMessage.Create(Recipients, Subject, Body, true);
                    Body += ('<html><head><style> divone{background-color: white; width: 2800px; padding: 20px; border-style:solid ; border-color:#b268ab;  margin: 20px;} </style></head>');
                    Body += ('<body><div style="border-color:#2980b9;  margin: 15px; border-width:8px;   border-style:solid; padding: 8px; width: 2800px;">');
                    Body += ('<label><font size="6">To be Executed Sale Orders List </font></label>');
                    Body += ('<hr style=solid; color= #c0392b >');
                    Body += ('<h>Dear Sir/Madam,</h><br>');
                    Body += ('<P>        These are the List of  Orders that are in Pending from R&D Side</P>');
                    Body += ('<table border = "1" style="border-collapse:collapse; width:100%; fond-size:5pt;">');
                    Body += ('<tr>');
                    Body += ('<th> Order Number </th>');
                    Body += ('<th> Item </th>');
                    Body += ('<th> Description </th>');
                    Body += ('<th> Product </th>');
                    Body += ('<th> Qty to Ship </th>');
                    Body += ('<th> Vertical </th>');
                    Body += ('<th> Main Category </th>');
                    Body += ('<th> Sub Category </th>');
                    Body += ('<th> Reason </th>');
                    Body += ('<th> Remarks </th>');
                    //Body += ('<th> Incharge </th>');
                    Body += ('</th>');
                    IF ISG1.FINDSET THEN
                        REPEAT
                            SalesLine1.RESET;
                            SalesLine1.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                            //SalesLine.SETFILTER(Type,'Item'); commented by Vishnu Priya
                            SalesLine1.SETFILTER("Document Type", '%1|%2', SalesLine1."Document Type"::"Blanket Order", SalesLine1."Document Type"::Order);
                            //SalesLine.SETFILTER("Document Type",'Order');
                            SalesLine1.SETFILTER("Outstanding Quantity", '>%1', 0);
                            SalesLine1.SETRANGE(MainCategory, 3);
                            SalesLine1.SETFILTER(ProductGroup, ISG1.Code);
                            IF SalesLine1.FINDSET THEN
                                REPEAT
                                BEGIN
                                    //MESSAGE(ISG."Incharge id" + ISG1.Code + FORMAT(SalesLine.COUNT));
                                    Body += ('<tr>');
                                    Body += ('<td  >' + ' ' + FORMAT(SalesLine1."Document No.") + '</td>');
                                    Body += ('<td >' + ' ' + FORMAT(SalesLine1."No.") + '</td>');
                                    Body += ('<td >' + ' ' + FORMAT(SalesLine1.Description) + '</td>');
                                    Body += ('<td >' + ' ' + FORMAT(SalesLine1.ProductGroup) + '</td>');
                                    Body += ('<td >' + ' ' + FORMAT(SalesLine1."Outstanding Quantity") + '</td>');
                                    Body += ('<td >' + ' ' + FORMAT(SalesLine1.Vertical) + '</td>');
                                    Body += ('<td >' + ' ' + FORMAT(SalesLine1.MainCategory) + '</td>');
                                    Body += ('<td >' + ' ' + FORMAT(SalesLine1.SubCategory) + '</td>');
                                    Body += ('<td >' + ' ' + FORMAT(SalesLine1.Reason) + '</td>');
                                    Body += ('<td >' + ' ' + FORMAT(SalesLine1.Remarks) + '</td>');
                                    //Body += ('<td >'+' '+FORMAT(US."Full Name")+'</td>');
                                    Body += ('</tr>');
                                END
                                UNTIL SalesLine1.NEXT = 0;
                        UNTIL ISG1.NEXT = 0;
                    Body += ('</table><br>');
                    Body += ('For report: <a href =' + '"https://app.powerbi.com/view?r=eyJrIjoiNTc0ZmQzNTYtNmJhMi00NWMwLThmMzQtYThmNjRhM2VhZWI0IiwidCI6IjZhZDY1ZDZkLWZkODctNDQ5OC04ZTkyLTUzNGM3YTA3ZjlmOCIsImMiOjEwfQ%3D%3D"' + '> click here </a><br>');
                    Body += ('<br>Regards,<br>');
                    Body += ('ERP.');
                    Body += ('<br>');
                    Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><p align= "center"> AUTO GENERATED MAIL FROM ERP </div><br/></div>');
                    IF DATE2DWY(TODAY, 1) = 1 THEN BEGIN
                        //SMTP_MAIL.AddCC('erp@efftronics.com,controlroom@efftronics.com,vanidevi@efftronics.com,bhavani@efftronics.com,bharat@efftronics.com,mk@effe.in');
                        //SMTP_MAIL.AddCC('ramasamy@efftronics.com,bala@efftronics.com,sbshankar@efftronics.com,anilkumar@efftronics.com,anvesh@efftronics.com');
                        Recipients.Add('erp@efftronics.com');
                        Recipients.Add('controlroom@efftronics.com');
                        Recipients.Add('vanidevi@efftronics.com');
                        Recipients.Add('bhavani@efftronics.com');
                        Recipients.Add('bharat@efftronics.com');
                        Recipients.Add('mk@effe.in');
                        Recipients.Add('ramasamy@efftronics.com');
                        Recipients.Add('bala@efftronics.com');
                        Recipients.Add('sbshankar@efftronics.com');
                        Recipients.Add('anilkumar@efftronics.com');
                        Recipients.Add('anvesh@efftronics.com');

                    END
                    ELSE
                        Recipients.Add('erp@efftronics.com');
                    Recipients.Add('controlroom@efftronics.com');
                    Recipients.Add('vanidevi@efftronics.com');
                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                END// version 2  for the  waste messages stop without body written by vishnu priya on 15-05-2019
            END
        END
    end;

    


    local procedure SALESACTUALSDUMPING();
    begin
        // written by vishnu priya
        /* IF ISCLEAR(SQLConnection) THEN
             CREATE(SQLConnection, FALSE, TRUE);

         IF ISCLEAR(RecordSet) THEN
             CREATE(RecordSet, FALSE, TRUE);*/
        //>> ORACLE UPG
        /* IF ConnectionOpen <> 1 THEN BEGIN
            SQLConnection.ConnectionString := 'DSN=erpserver;UID=report;PASSWORD=Efftronics@eff;SERVER=erpserver;';
            SQLConnection.Open;
            SQLConnection.BeginTrans;
            ConnectionOpen := 1;
        END; */
        //<< ORACLE UPG

        //********************************************************************************************************

        //>> ORACLE UPG
        /*  SQLQuery := 'insert into [INVOICED_18_19_Orders_BASIC]  SELECT *  from V_sales_Actuals_Mains_Equals';  //[INVOICED_18_19_Orders_BASIC_1]

         //MESSAGE(SQLQuery);
         IF SQLQuery <> '' THEN
             SQLConnection.Execute(SQLQuery);
         SQLConnection.CommitTrans; //vishnu coomented on 26-03-2019

         SQLQuery1 := 'insert into   [INVOICED_18_19_Orders_BASIC] select * from V_sales_Actuals_Mains_noRPOS ';
         SQLQuery2 := 'insert into   [INVOICED_18_19_Orders_BASIC] select *  from V_sales_Actuals_Schedules_1 ';
         SQLQuery3 := 'insert into   [INVOICED_18_19_Orders_BASIC] select *  from V_sales_Actuals_Schedules_2 ';
         //MESSAGE(SQLQuery1);
         IF SQLQuery1 <> '' THEN
             SQLConnection.Execute(SQLQuery1);
         //MESSAGE(SQLQuery2);
         IF SQLQuery2 <> '' THEN
             SQLConnection.Execute(SQLQuery2);
         //MESSAGE(SQLQuery3);
         IF SQLQuery3 <> '' THEN
             SQLConnection.Execute(SQLQuery3);
         //MESSAGE('Data Dumped to Base Tables');

         //**********************************************************************************************
         // Duming the Data details
         //******************************************** dumping the equal Qtys to Details tables that is phase 1 **********************************
         Day := 1;
         FORLOOP1 := 1;
         SQLQuery5 := 'Select Distinct   [Order No_] as OLre from Invoiced_Orders_View_1_Equal_Qty where Status = ''No'' ';
         //MESSAGE(SQLQuery5);
         RecordSet1 := SQLConnection.Execute(SQLQuery5, RowCount);
         IF RowCount <> 0 THEN
             IF NOT ((RecordSet1.BOF) OR (RecordSet1.EOF)) THEN
                 RecordSet1.MoveFirst;
         RowCount := 0;
         WHILE NOT RecordSet1.EOF DO BEGIN
             BANKARRY[Day] := FORMAT(RecordSet1.Fields.Item('OLre').Value);
             //MESSAGE(BANKARRY[Day]);
             Day := Day + 1;
             RowCount := RowCount + 1;
             RecordSet1.MoveNext;
         END;
         //MESSAGE(FORMAT(Day-1)+' len of Arr');
         FOR FORLOOP1 := 1 TO Day - 1 DO BEGIN
             SQLQuery4 := 'insert into [Invoiced_18_19_RAW_MATERIALS] ' +  //Invoiced_18_19_RAW_MATERIALS_1 Test

             'SELECT        DU.[Shipment No_], DU.INV_NUM, DU.[Order No_], DU.[Bill-to Customer No_], DU.[Bill-to Name], DU.[Posting  Date], DU.[External Document No_], DU.[Line No_], ' +
             'DU.[Item No_], DU.Description, DU.Line_Qty, DU.Vertical, DU.[Line Type], DU.SCHEDULE_LINE, DU.[Product Group Code], DU.[Item Sub Group Code], DU.[Lot No_],' +
             'DU.[Serial No_], DU.RPO, DU.RPO_QTY, DU.ACTUAL_QTY, DU.ECTDOC_TYPE, DU.SPARES_NOT, DU.Key_MAP, DU.Status, DU.TT,' +
             'POST.[Posting Date] AS COMPONN_POSTIND_DATE, POST.[Item No_] AS COMPONENT_NUM, POST.Quantity AS COMPONENT_QTY, ' +
             'POST.Description AS COMPONENT_DESC, POST.[Prod_ Order No_] AS BOM, POST.[Sub BOM Desc], POST.[Prod_ BOM No_] AS SUBBOM, ' +
             ' POST.[Lot No_] AS COMPO_LOT, POST.[Serial No_] AS COMPO_SERI,getdate(),NULL,NULL' +
             ' FROM            Invoiced_Orders_View_1_Equal_Qty AS DU LEFT OUTER JOIN ' +
             ' (SELECT        PMIH.No_, PMIH.[Posting Date], PMIL.[Item No_], ILE.Quantity, PMIL.Description, PMIH.[Prod_ Order No_], PMIH.[Prod_ BOM No_], ILE.[Lot No_], ' +
             '  ILE.[Serial No_], It.Description AS [Sub BOM Desc] ' +
             ' FROM            [Efftronics Systems Pvt Ltd_,$Posted Material Issues Header] AS PMIH WITH (NOLOCK) LEFT OUTER JOIN ' +
             ' [Efftronics Systems Pvt Ltd_,$Item] AS It WITH (NOLOCK) ON PMIH.[Prod_ BOM No_] = It.No_ INNER JOIN ' +
             ' [Efftronics Systems Pvt Ltd_,$Posted Material Issues Line] AS PMIL WITH (NOLOCK) ON PMIH.No_ = PMIL.[Document No_] LEFT OUTER JOIN ' +
             '[Efftronics Systems Pvt Ltd_,$Item Ledger Entry] AS ILE WITH (NOLOCK) ON ILE.[Document No_] = PMIL.[Document No_] AND ILE.Quantity > 0 AND ' +
             ' ILE.[Item No_] = PMIL.[Item No_] ' +
             '  WHERE        (PMIH.[Transfer-from Code] IN (N''STR'', N''MCH'')) AND (PMIH.[Prod_ Order No_] <> '''') AND (PMIH.[Transfer-to Code] = N''PROD'')) AS POST ON ' +
             ' POST.[Prod_ Order No_] = DU.RPO ' +
             ' where  DU.Status = ''No'' and DU.[Order No_] = ''' + BANKARRY[FORLOOP1] + '''';
             //MESSAGE(SQLQuery4);
             IF SQLQuery4 <> '' THEN BEGIN
                 SQLConnection.Execute(SQLQuery4);
                 //MESSAGE('Oredr Dumped - Ph-1');
             END;
         END;
         // MESSAGE('Data Dumped to Details Tables - phase 1');



         //************************phase 2 starts that is unqual RPO Qtys insertions ******************************************************

         Day := 1;
         ForLOOP2 := 1;
         SQLQuery6 := 'Select Distinct   [Order No_] as OLre from Invoiced_Orders_View_1_UnEqual_Qty where Status = ''No'' ';
         //MESSAGE(SQLQuery6);
         RecordSet1 := SQLConnection.Execute(SQLQuery6, RowCount);
         IF RowCount <> 0 THEN
             IF NOT ((RecordSet1.BOF) OR (RecordSet1.EOF)) THEN
                 RecordSet1.MoveFirst;
         RowCount := 0;
         WHILE NOT RecordSet1.EOF DO BEGIN
             BANKARRY[Day] := FORMAT(RecordSet1.Fields.Item('OLre').Value);
             //MESSAGE(BANKARRY[Day]);
             Day := Day + 1;
             RowCount := RowCount + 1;
             RecordSet1.MoveNext;
         END;
         //MESSAGE(FORMAT(Day-1)+' len of Arr');
         FOR ForLOOP2 := 1 TO Day - 1 DO BEGIN
             SQLQuery7 := 'insert into [Invoiced_18_19_RAW_MATERIALS] ' +

             ' SELECT        DU.[Shipment No_], DU.INV_NUM, DU.[Order No_], DU.[Bill-to Customer No_], DU.[Bill-to Name], DU.[Posting  Date], DU.[External Document No_], DU.[Line No_], ' +
             ' DU.[Item No_], DU.Description, DU.Line_Qty, DU.Vertical, DU.[Line Type], DU.SCHEDULE_LINE, DU.[Product Group Code], DU.[Item Sub Group Code], DU.[Lot No_],' +
             ' DU.[Serial No_], DU.RPO, DU.RPO_QTY, DU.ACTUAL_QTY, DU.ECTDOC_TYPE, DU.SPARES_NOT, DU.Key_MAP, DU.Status, DU.TT, PPP.COMPONN_POSTIND_DATE,' +
             ' PPP.[Item No_] AS COMPONENT_NUM, DU.ACTUAL_QTY * PPP.[Quantity per] AS COMPONENT_QTY, PPP.Description AS COMPONENT_DESC, ' +
             ' PPP.[Prod_ Order No_] AS BOM, PPP.SUB_BOM_DESC, PPP.[Prod_ BOM No_] AS SUBBOM, PPP.[Lot No_] AS COMPO_LOT, PPP.[Serial No_] AS COMPO_SERI, ' +
             ' getdate(),NULL,NULL' +
             ' FROM            Invoiced_Orders_View_1_UnEqual_Qty AS DU LEFT OUTER JOIN ' +
             ' (SELECT        [Prod_ Order No_], COMPONN_POSTIND_DATE, [Prod_ BOM No_], [Item No_], Description, [Quantity per], PMI_NUM, [Lot No_], [Serial No_],SUB_BOM_DESC ' +
            ' FROM            (SELECT        TBL1.[Prod_ Order No_], TBL1.COMPONN_POSTIND_DATE, TBL1.[Prod_ BOM No_], TBL1.[Item No_], TBL1.Description,' +
            'TBL2.[Quantity per], TBL1.PMI_NUM, ILE.[Lot No_], ILE.[Serial No_], TBL1.SUB_BOM_DESC' +
            ' FROM            (SELECT        PMIH.[Prod_ Order No_], MAX(PMIH.[Posting Date]) AS COMPONN_POSTIND_DATE, PMIH.[Prod_ BOM No_], PMIL.[Item No_],' +
            ' PMIL.Description, MAX(PMIH.No_) AS PMI_NUM, It.Description AS SUB_BOM_DESC' +
            ' FROM            [Efftronics Systems Pvt Ltd_,$Posted Material Issues Header] AS PMIH WITH (NOLOCK) LEFT OUTER JOIN' +
            ' [Efftronics Systems Pvt Ltd_,$Item] AS It WITH (NOLOCK) ON It.No_ = PMIH.[Prod_ BOM No_] INNER JOIN' +
            ' [Efftronics Systems Pvt Ltd_,$Posted Material Issues Line] AS PMIL WITH (NOLOCK) ON ' +
            ' PMIH.No_ = PMIL.[Document No_]' +
            ' WHERE        (PMIH.[Transfer-from Code] IN (''STR'', ''MCH'')) AND (PMIH.[Transfer-to Code] = ''PROD'')' +
            ' GROUP BY PMIH.[Prod_ Order No_], It.Description, PMIH.[Prod_ BOM No_], PMIL.[Item No_], PMIL.Description) AS TBL1 INNER JOIN' +
            ' (SELECT        [Prod_ Order No_], [Item No_], Description, [Quantity per]' +
            ' FROM            [Efftronics Systems Pvt Ltd_,$Prod_ Order Component] AS POC WITH (NOLOCK)) AS TBL2 ON ' +
            ' TBL1.[Prod_ Order No_] = TBL2.[Prod_ Order No_] AND TBL1.[Item No_] = TBL2.[Item No_] INNER JOIN' +
            ' (SELECT        [Item No_], [Document No_], [Open], MAX([Lot No_]) AS [Lot No_], MAX([Serial No_]) AS [Serial No_]' +
            ' FROM            [Efftronics Systems Pvt Ltd_,$Item Ledger Entry] AS ILE1 WITH (NOLOCK)' +
            ' WHERE        ([Open] = 1)' +
            ' GROUP BY [Item No_], [Document No_], [Open]) AS ILE ON ILE.[Document No_] = TBL1.PMI_NUM AND ' +
            ' ILE.[Item No_] = TBL1.[Item No_] AND ILE.[Open] = 1) AS derivedtbl_1) AS PPP ON PPP.[Prod_ Order No_] = DU.RPO' +
            ' where  DU.Status = ''No'' and DU.[Order No_] = ''' + BANKARRY[ForLOOP2] + '''';
             //MESSAGE(SQLQuery7);
             IF SQLQuery7 <> '' THEN BEGIN
                 SQLConnection.Execute(SQLQuery7);
                 //MESSAGE('Oredr Dumped -Ph-2 ');
             END;
         END;
         //MESSAGE('Data Dumped to Details Tables - phase 2');

         //****************************************************************************************************************
         // Process for BOUTS Insertion
         SQLQuery8 := 'insert into [Invoiced_18_19_RAW_MATERIALS] select * from V_BOUTS_FOR_SALESACUTUASL';
         //MESSAGE(SQLQuery8);
         IF SQLQuery8 <> '' THEN BEGIN
             SQLConnection.Execute(SQLQuery8);
             //MESSAGE('BOUTS are dumped to Detaisl Tables ');
         END;

         //*****************************************************************************************************************************************
         // updating the basic tables data with status = yes

         SQLQuery9 := 'update INVOICED_18_19_Orders_BASIC set Status = ''Yes'' where Status = ''No'' ';
         //MESSAGE(SQLQuery9);
         IF SQLQuery9 <> '' THEN BEGIN
             SQLConnection.Execute(SQLQuery9);
             MESSAGE('All are updated in base tables ');
         END; */
        //<< ORACLE UPG

        //TAMS_BASED_USERS_BLOCKING;

        //****************************************************************************************************************************************
    end;


    procedure IREPS_Tenders();
    begin
        //written by Vishnu Priya on March 1st 2019 for IREPS Tenders Alerts
        Sh.RESET;
        Sh.SETFILTER("Document Type", FORMAT(4));
        Sh.SETFILTER("Sell-to Customer No.", 'CUST02007');
        Sh.SETFILTER("Sale Order Total Amount", '>%1', 0);
        Sh.SETFILTER("Tender Due Date", '<>%1', 0D);
        IF Sh.FINDSET THEN BEGIN
            SL1.RESET;
            SL1.SETFILTER("Document No.", Sh."No.");
            SL1.SETFILTER("Outstanding Quantity", '>%1', 0);
            IF SL1.FINDSET THEN BEGIN
                Subject := 'Reg: IREPS Tenders List';
                /*Mail_To := 'mk@effe.in,anvesh@efftronics.com,sales@efftronics.com,erp@efftronics.com';
                SMTP_MAIL.CreateMessage('erp', 'erp@efftronics.com', Mail_To, Subject, Body, TRUE);*/   //B2BUPG
                Recipients.Add('mk@effe.in');
                Recipients.Add('anvesh@efftronics.com');
                Recipients.Add('sales@efftronics.com');
                Recipients.Add('erp@efftronics.com');
                EmailMessage.Create(Recipients, Subject, Body, true);
                Body += ('<html><head><style> divone{background-color: white; width: 1800px; padding: 8px; border-style:solid ; border-color:#E36015;  margin: 10px;} </style></head>');
                Body += ('<body><div style="border-color:#18BEAF;  margin: 8px; border-width:10px;   border-style:solid; padding: 8px; width: 1800px;">');
                Body += ('<label><font size="6">IREPS  Expected Orders List</font></label>');
                Body += ('<hr style=solid; color= #2C2EA8 >');
                Body += ('<h>Dear Sir/Mam  ,</h><br>');
                Body += ('<P>        Below are the List of Pre Expected Orders of IREPS Customer</P>');
                Body += ('<table border = "1" style="border-collapse:collapse; width:100%; fond-size:5pt;">');
                Body += ('<tr>');
                Body += ('<th> Order No </th>');
                Body += ('<th> Sales Person </th>');
                Body += ('<th> Tender No. </th>');
                Body += ('<th> Tender Floated by </th>');
                Body += ('<th>  Amount </th>');
                Body += ('<th> Item </th>');
                Body += ('<th> Quantity </th>');
                Body += ('<th> Tender Due Dt </th>');
                Body += ('<th> Deviated Days </th>');
                Body += ('<th>  Zone </th>');
                Body += ('<th>  Division </th>');
                Body += ('<th> Remarks </th>');
                Body += ('</th>');
                REPEAT
                BEGIN
                    IF Sh."Tender Due Date" < TODAY() THEN BEGIN
                        SalesPerson.RESET;
                        SalesPerson.SETFILTER(Code, Sh."Salesperson Code");
                        IF SalesPerson.FINDFIRST THEN
                            //Body += ('<td Style = "color:red">' + ' '+ FORMAT(SalesPerson.Name)+'</td>');
                            //Body += ('<td Style = "color:red">' + ' '+FORMAT(Sh."Customer OrderNo.")+'</td>');
                            // Body += ('<td Style = "color:red">' + ' '+FORMAT(Sh."Bill-to Name")+'</td>');  // added for Tender Floated by Field
                            SalesLine.RESET;
                        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::"Blanket Order");
                        SalesLine.SETFILTER("Document No.", Sh."No.");
                        SalesLine.SETFILTER("Outstanding Quantity", '>%1', 0);
                        //SalesLine.SETFILTER("Outstanding Amount (LCY)",'>%1',0);
                        NeedtoInvAmt := 0;
                        IF SalesLine.FINDSET THEN BEGIN
                            REPEAT
                                NeedtoInvAmt := 0;
                                //NeedtoInvAmt := NeedtoInvAmt + SalesLine."Amount To Customer"  //commented by vishnu on 12-04-19
                                NeedtoInvAmt := ROUND(NeedtoInvAmt + (SalesLine."Unitcost(LOA)" * SalesLine."Outstanding Quantity"), 2);
                                Body += ('<tr>');
                                Body += ('<td Style = "color:red">' + ' ' + FORMAT(COPYSTR(Sh."No.", 9, 10)) + '</td>');
                                Body += ('<td Style = "color:red">' + ' ' + FORMAT(SalesPerson.Name) + '</td>');
                                Body += ('<td Style = "color:red">' + ' ' + FORMAT(Sh."Customer OrderNo.") + '</td>');
                                Body += ('<td Style = "color:red">' + ' ' + FORMAT(Sh."Bill-to Name") + '</td>');


                                Body += ('<td Style = "color:red">' + ' ' + FORMAT(NeedtoInvAmt) + '</td>');
                                //Body += ('<td Style = "color:red">' + ' '+FORMAT(Sh."Tender Published Date")+'</td>');
                                Body += ('<td Style = "color:red">' + ' ' + FORMAT(SalesLine.Description) + '</td>');
                                Body += ('<td Style = "color:red">' + ' ' + FORMAT(SalesLine.Quantity) + '</td>');
                                Body += ('<td Style = "color:red">' + ' ' + FORMAT(Sh."Tender Due Date") + '</td>');
                                Body += ('<td Style = "color:red">' + ' ' + FORMAT(TODAY() - Sh."Tender Due Date") + '</td>');
                                Division.RESET;
                                Division.SETFILTER(Code, Sh."Railway Division");
                                IF Division.FINDFIRST THEN BEGIN
                                    Zone.RESET;
                                    Zone.SETFILTER(Code, Division.Code);
                                    IF Zone.FINDFIRST THEN BEGIN
                                        Body += ('<td Style = "color:red">' + ' ' + FORMAT(Zone.Description) + '</td>');
                                        Body += ('<td Style = "color:red">' + ' ' + FORMAT(Division."Division Name") + '</td>');
                                    END;
                                END;

                                //Body += ('<td Style = "color:red">' + ' '+FORMAT('Please convert it to Order')+'</td>');  // dynamic remarks removed and sale sheader remarks updated as per the Request of Sales
                                Body += ('<td Style = "color:red">' + ' ' + FORMAT(Sh.Remarks) + '</td>');
                                Body += ('</tr>');
                            UNTIL SalesLine.NEXT = 0;
                        END;
                    END
                    ELSE BEGIN


                        SalesPerson.RESET;
                        SalesPerson.SETFILTER(Code, Sh."Salesperson Code");
                        IF SalesPerson.FINDFIRST THEN
                            SalesLine.RESET;
                        SalesLine.SETFILTER("Document Type", FORMAT(4));
                        SalesLine.SETFILTER("Document No.", Sh."No.");
                        SalesLine.SETFILTER("Outstanding Quantity", '>%1', 0);
                        //SalesLine.SETFILTER("Outstanding Amount (LCY)",'>%1',0);
                        //NeedtoInvAmt := 0;
                        IF SalesLine.FINDSET THEN BEGIN
                            REPEAT
                                NeedtoInvAmt := 0;
                                //NeedtoInvAmt := NeedtoInvAmt + SalesLine."Amount To Customer";  //commented by vishnu on 12-04-19
                                NeedtoInvAmt := ROUND(NeedtoInvAmt + (SalesLine."Unitcost(LOA)" * SalesLine."Outstanding Quantity"), 2);
                                Body += ('<tr>');
                                Body += ('<td >' + ' ' + FORMAT(COPYSTR(Sh."No.", 9, 10)) + '</td>');
                                Body += ('<td >' + ' ' + FORMAT(SalesPerson.Name) + '</td>');
                                Body += ('<td >' + ' ' + FORMAT(Sh."Customer OrderNo.") + '</td>');
                                Body += ('<td >' + ' ' + FORMAT(Sh."Bill-to Name") + '</td>'); // added for Tender Floated by Field

                                Body += ('<td >' + ' ' + FORMAT(NeedtoInvAmt) + '</td>');
                                Body += ('<td >' + ' ' + FORMAT(SalesLine.Description) + '</td>');
                                Body += ('<td >' + ' ' + FORMAT(SalesLine.Quantity) + '</td>');
                                Body += ('<td >' + ' ' + FORMAT(Sh."Tender Due Date") + '</td>');
                                Body += ('<td >' + ' ' + FORMAT('') + '</td>');
                                Division.RESET;
                                Division.SETFILTER(Code, Sh."Railway Division");
                                IF Division.FINDFIRST THEN BEGIN
                                    Zone.RESET;
                                    Zone.SETFILTER(Code, Division.Code);
                                    IF Zone.FINDFIRST THEN BEGIN
                                        Body += ('<td >' + ' ' + FORMAT(Zone.Description) + '</td>');
                                        Body += ('<td>' + ' ' + FORMAT(Division."Division Name") + '</td>');
                                    END;
                                END;
                                //Body += ('<td>' + ' '+FORMAT('Make followups')+'</td>'); // dynamic remarks removed and sale sheader remarks updated as per the Request of Sales
                                Body += ('<td>' + ' ' + FORMAT(Sh.Remarks) + '</td>');
                                Body += ('</tr>');
                            UNTIL SalesLine.NEXT = 0;
                        END;
                    END;
                END;
                UNTIL Sh.NEXT = 0;
                Body += ('</table><br>');
                Body += ('<br/> <i><span Style = "color:red" >Red Color Orders are Tender Due Date need to Change Items</Span></i>');
                Body += ('For report: <a href =' + '"https://app.powerbi.com/view?r=eyJrIjoiNDk0ZjdjMjMtYzg5Ny00MGI5LWIzMmQtZTc1NzJiYzkxMWMzIiwidCI6IjZhZDY1ZDZkLWZkODctNDQ5OC04ZTkyLTUzNGM3YTA3ZjlmOCIsImMiOjEwfQ%3D%3D"' + '> click here </a><br>');
                Body += ('<br>Regards,<br>');
                Body += ('ERP.');
                Body += ('<br>');
                Body += ('<div style="Background-color:#F35317; color:#F0F1F5; "><p align= "center"> *****AUTO GENERATED MAIL FROM ERP**** </div><br/></div>');
                //SMTP_MAIL.Send;  //B2BUPG
                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
            END;
        END;


        /*
        //written by Vishnu Priya on March 1st 2019 for IREPS Tenders Alerts
        Sh.RESET;
        Sh.SETFILTER("Document Type",FORMAT(4));
        Sh.SETFILTER("Sell-to Customer No.",'CUST02007');
        Sh.SETFILTER("Sale Order Total Amount",'>%1',0);
        Sh.SETFILTER("Tender Due Date",'<>%1',0D);
         IF Sh.FINDSET THEN
         BEGIN
          SL1.RESET;
          SL1.SETFILTER("Document No.",Sh."No.");
          SL1.SETFILTER("Outstanding Quantity",'>%1',0);
          IF SL1.FINDSET THEN
          BEGIN
          Subject := 'Reg: IREPS Tenders List';
          Mail_To := 'mk@effe.in,anvesh@efftronics.com,sales@efftronics.com,erp@efftronics.com';
          SMTP_MAIL.CreateMessage('erp','erp@efftronics.com',Mail_To,Subject,Body,TRUE);
          Body += ('<html><head><style> divone{background-color: white; width: 1800px; padding: 8px; border-style:solid ; border-color:#E36015;  margin: 10px;} </style></head>');
          Body += ('<body><div style="border-color:#18BEAF;  margin: 8px; border-width:10px;   border-style:solid; padding: 8px; width: 1800px;">');
          Body += ('<label><font size="6">IREPS  Expected Orders List</font></label>');
          Body += ('<hr style=solid; color= #2C2EA8 >');
          Body += ('<h>Dear Sir/Mam  ,</h><br>');
          Body += ('<P>        Below are the List of Pre Expected Orders of IREPS Customer</P>');
          Body += ('<table border = "1" style="border-collapse:collapse; width:100%; fond-size:5pt;">');
          Body += ('<tr>');
          Body += ('<th> Order No </th>');
          Body += ('<th> Sales Person </th>');
          Body += ('<th> Tender No. </th>');
          Body += ('<th> Tender Floated by </th>');
          Body += ('<th>  Amount </th>');
          Body += ('<th> Item </th>');
          Body += ('<th> Quantity </th>');
          Body += ('<th> Tender Due Dt </th>');
          Body += ('<th> Deviated Days </th>');
          Body += ('<th>  Zone </th>');
          Body += ('<th>  Division </th>');
          Body += ('<th> Remarks </th>');
          Body += ('</th>');
              REPEAT
              BEGIN
                Body += ('<tr>');
              IF Sh."Tender Due Date" < TODAY() THEN
              BEGIN
                Body += ('<td Style = "color:red">'+' '+FORMAT(COPYSTR(Sh."No.",9,10))+'</td>');
                SalesPerson.RESET;
                SalesPerson.SETFILTER(Code,Sh."Salesperson Code");
                IF SalesPerson.FINDFIRST THEN
                  Body += ('<td Style = "color:red">' + ' '+ FORMAT(SalesPerson.Name)+'</td>');
                  Body += ('<td Style = "color:red">' + ' '+FORMAT(Sh."Customer OrderNo.")+'</td>');
                  Body += ('<td Style = "color:red">' + ' '+FORMAT(Sh."Bill-to Name")+'</td>');  // added for Tender Floated by Field
                  SalesLine.RESET;
                  SalesLine.SETRANGE("Document Type",SalesLine."Document Type"::"Blanket Order");
                  SalesLine.SETFILTER("Document No.",Sh."No.");
                  SalesLine.SETFILTER("Outstanding Quantity",'>%1',0);
                  //SalesLine.SETFILTER("Outstanding Amount (LCY)",'>%1',0);
                  NeedtoInvAmt := 0;
                  IF SalesLine.FINDSET THEN
                  BEGIN
                   // REPEAT
                    //NeedtoInvAmt := NeedtoInvAmt + SalesLine."Amount To Customer"  //commented by vishnu on 12-04-19
                    NeedtoInvAmt := ROUND(NeedtoInvAmt + ( SalesLine."Unitcost(LOA)"*SalesLine."Outstanding Quantity"),2);
        
                  Body += ('<td Style = "color:red">' + ' '+FORMAT(NeedtoInvAmt)+'</td>');
                  //Body += ('<td Style = "color:red">' + ' '+FORMAT(Sh."Tender Published Date")+'</td>');
                  Body += ('<td Style = "color:red">' + ' '+FORMAT(SalesLine.Description)+'</td>');
                  Body += ('<td Style = "color:red">' + ' '+FORMAT(SalesLine.Quantity)+'</td>');
                  Body += ('<td Style = "color:red">' + ' '+FORMAT(Sh."Tender Due Date")+'</td>');
                  Body += ('<td Style = "color:red">' + ' '+FORMAT(TODAY()-Sh."Tender Due Date")+'</td>');
                  Division.RESET;
                  Division.SETFILTER("Division Code",Sh."Railway Division");
                IF Division.FINDFIRST THEN
                  BEGIN
                    Zone.RESET;
                    Zone.SETFILTER("Zone Code",Division."Zone code");
                    IF Zone.FINDFIRST THEN
                      BEGIN
                        Body += ('<td Style = "color:red">' + ' '+FORMAT(Zone."Zone Name")+'</td>');
                        Body += ('<td Style = "color:red">' + ' '+FORMAT(Division."Division Name")+'</td>');
                      END;
                  END;
        
                  //Body += ('<td Style = "color:red">' + ' '+FORMAT('Please convert it to Order')+'</td>');  // dynamic remarks removed and sale sheader remarks updated as per the Request of Sales
                  Body += ('<td Style = "color:red">' + ' '+FORMAT(Sh.Remarks)+'</td>');
                  //UNTIL SalesLine.NEXT = 0;
                   END;
                END
                ELSE
                  BEGIN
                Body += ('<td >'+' '+FORMAT(COPYSTR(Sh."No.",9,10))+'</td>');
                SalesPerson.RESET;
                SalesPerson.SETFILTER(Code,Sh."Salesperson Code");
                IF SalesPerson.FINDFIRST THEN
                  Body += ('<td >' + ' '+ FORMAT(SalesPerson.Name)+'</td>');
                  Body += ('<td >' + ' '+FORMAT(Sh."Customer OrderNo.")+'</td>');
                  Body += ('<td >' + ' '+FORMAT(Sh."Bill-to Name")+'</td>');  // added for Tender Floated by Field
                  SalesLine.RESET;
                  SalesLine.SETFILTER("Document Type",FORMAT(4));
                  SalesLine.SETFILTER("Document No.",Sh."No.");
                  SalesLine.SETFILTER("Outstanding Quantity",'>%1',0);
                  //SalesLine.SETFILTER("Outstanding Amount (LCY)",'>%1',0);
                  NeedtoInvAmt := 0;
                  IF SalesLine.FINDSET THEN
                  BEGIN
                    //NeedtoInvAmt := NeedtoInvAmt + SalesLine."Amount To Customer";  //commented by vishnu on 12-04-19
                    NeedtoInvAmt := ROUND(NeedtoInvAmt + ( SalesLine."Unitcost(LOA)"*SalesLine."Outstanding Quantity"),2);
        
                  Body += ('<td >' + ' '+FORMAT(NeedtoInvAmt)+'</td>');
                  Body += ('<td >' + ' '+FORMAT(SalesLine.Description)+'</td>');
                  Body += ('<td >' + ' '+FORMAT(SalesLine.Quantity)+'</td>');
                  Body += ('<td >' + ' '+FORMAT(Sh."Tender Due Date")+'</td>');
                  Body += ('<td >' + ' '+FORMAT('')+'</td>');
                  Division.RESET;
                  Division.SETFILTER("Division Code",Sh."Railway Division");
                IF Division.FINDFIRST THEN
                  BEGIN
                    Zone.RESET;
                    Zone.SETFILTER("Zone Code",Division."Zone code");
                    IF Zone.FINDFIRST THEN
                      BEGIN
                        Body += ('<td >' + ' '+FORMAT(Zone."Zone Name")+'</td>');
                        Body += ('<td>' + ' '+FORMAT(Division."Division Name")+'</td>');
                      END;
                  END;
                 //Body += ('<td>' + ' '+FORMAT('Make followups')+'</td>'); // dynamic remarks removed and sale sheader remarks updated as per the Request of Sales
                 Body += ('<td>' + ' '+FORMAT(Sh.Remarks)+'</td>');
                  END;
                 END;
                 Body += ('</tr>');
               END;
            UNTIL Sh.NEXT = 0;
            Body += ('</table><br>');
            Body += ('<br/> <i><span Style = "color:red" >Red Color Orders are Tender Due Date need to Change Items</Span></i>');
            Body += ('For report: <a href ='+'"https://app.powerbi.com/view?r=eyJrIjoiNDk0ZjdjMjMtYzg5Ny00MGI5LWIzMmQtZTc1NzJiYzkxMWMzIiwidCI6IjZhZDY1ZDZkLWZkODctNDQ5OC04ZTkyLTUzNGM3YTA3ZjlmOCIsImMiOjEwfQ%3D%3D"'+'> click here </a><br>');
            Body += ('<br>Regards,<br>');
            Body += ('ERP.');
            Body += ('<br>');
            Body += ('<div style="Background-color:#F35317; color:#F0F1F5; "><p align= "center"> *****AUTO GENERATED MAIL FROM ERP**** </div><br/></div>');
            SMTP_MAIL.AddBCC('vishnupriya@efftronics.com');
            SMTP_MAIL.Send;
            END;
            END;
            */

    end;

    local procedure CalibrationAlerts();
    begin
        //********************************** Owners Mails ******************************************************
        // written by vishnu priya on 01-03-2019
        Day := 1;
        DateFilterCalbartion := CALCDATE('10D', TODAY());
        //MESSAGE(FORMAT(DateFilterCalbartion));
        CalibrationEntr.SETCURRENTKEY("Owner of the Equpmnt_empid");
        CalibrationEntr.SETFILTER("Next Calibration Due On", '<%1&<>%2', DateFilterCalbartion, 0D);
        //CalibrationEntr.SETFILTER("Next Calibration Due On",'<>%1',0D);
        CalibrationEntr.SETFILTER(Description, '<>%1', '');
        CalibrationEntr.SETRANGE(mailsent, FALSE);// Version 1.2 for making one time mail
        //CalibrationEntr.SETFILTER("Not an ERP Integrated",FORMAT(1));
        IF CalibrationEntr.FINDSET THEN
            REPEAT
            BEGIN
                IF Day > 1 THEN BEGIN
                    IF OwnersArr[Day - 1] <> CalibrationEntr."Owner of the Equpmnt_empid" THEN BEGIN
                        OwnersArr[Day] := CalibrationEntr."Owner of the Equpmnt_empid";
                        Day := Day + 1;
                    END;
                END
                ELSE BEGIN
                    OwnersArr[Day] := CalibrationEntr."Owner of the Equpmnt_empid";
                    Day := Day + 1;
                END;
            END;
            UNTIL CalibrationEntr.NEXT = 0;
        Mail_To := '';
        Subject := 'Reg: QA Calibration Need to be Done';
        FOR No_of_Managers := 1 TO Day - 1 DO BEGIN
            CalibrationEntr.RESET;
            CalibrationEntr.SETCURRENTKEY("Owner of the Equpmnt_empid");
            CalibrationEntr.SETFILTER("Next Calibration Due On", '<%1&<>%2', DateFilterCalbartion, 0D);
            //CalibrationEntr.SETFILTER("Next Calibration Due On",'<>%1',0D);
            CalibrationEntr.SETFILTER(Description, '<>%1', '');
            CalibrationEntr.SETRANGE(mailsent, FALSE); //Version 1.2 for making one time mail
                                                       //CalibrationEntr.SETFILTER("Not an ERP Integrated",FORMAT(1));
            CalibrationEntr.SETFILTER("Owner of the Equpmnt_empid", OwnersArr[No_of_Managers]);
            US.RESET;
            US.SETCURRENTKEY("User ID");
            US.SETRANGE(Blocked, FALSE);
            //added by vishnu priya for blocked users restriction on 02-07-2019
            if USER_TABLE.Get(US."User ID") then
                USER_TABLE.SETFILTER("Full Name", OwnersArr[No_of_Managers]);
            /* IF US.FINDLAST THEN
                Mail_To := US.MailID + ',calibration@efftronics.com'
            ELSE
                Mail_To := 'calibration@efftronics.com';
            //Mail_To := Mail_To + ',calibration@efftronics.com,erp@efftronics.com';
            SMTP_MAIL.CreateMessage('Calibration', 'calibration@efftronics.com', Mail_To, Subject, Body, TRUE); */  //B2BUPG

            IF US.FINDLAST THEN begin
                //Mail_To := US.MailID + ',calibration@efftronics.com';
                Recipients.Add(US.MailID);
                Recipients.Add('calibration@efftronics.com');
            end
            ELSE
                Recipients.Add('calibration@efftronics.com');
            EmailMessage.Create(Recipients, Subject, Body, true);
            Body += ('<html><head><style> divone{background-color: white; width: 1200px; padding: 8px; border-style:solid ; border-color:#E36015;  margin: 8px;} </style></head>');
            Body += ('<body><div style="border-color:#18BEAF;  margin: 8px; border-width:10px;   border-style:solid; padding: 8px; width: 1100px;">');
            Body += ('<label><font size="6">Calibration</font></label>');
            Body += ('<hr style=solid; color= #2C2EA8 >');
            Body += ('<h>Hi Mr./Ms. ' + FORMAT(OwnersArr[No_of_Managers]) + ' ,</h><br>');
            Body += ('<P>        These are the List of  Equipments that are going to be Calibrated</P>');
            Body += ('<table border = "1" style="border-collapse:collapse; width:100%; fond-size:5pt;">');
            Body += ('<tr>');
            Body += ('<th> Equipment Number(ERP) </th>');
            Body += ('<th> Description </th>');
            Body += ('<th> Model </th>');
            Body += ('<th> Serial Number </th>');
            Body += ('<th> Last Calibr Dt</th>');
            Body += ('<th> Next Calibr Dt</th>');
            Body += ('<th> Delay in Calibr(D)</th>');
            //Body += ('<th> Owner Name </th>');
            //Body += ('<th> Life Time of Equipment</th>');
            //Body += ('<th> Last Transaction Number</th>');
            //Body += ('<th> Current User </th>');
            Body += ('</tr>');

            IF CalibrationEntr.FINDSET THEN
                REPEAT
                BEGIN
                    Body += ('<tr>');
                    //Body += ('<td >'+' '+FORMAT(CalibrationEntr."Item No")+'</td>');
                    Body += ('<td >' + ' ' + FORMAT(CalibrationEntr."Equipment No") + '</td>');
                    Body += ('<td >' + ' ' + FORMAT(CalibrationEntr.Description) + '</td>');
                    Body += ('<td >' + ' ' + FORMAT(CalibrationEntr."Model No.") + '</td>');
                    Body += ('<td >' + ' ' + FORMAT(CalibrationEntr."Eqpt. Serial No.") + '</td>');
                    Body += ('<td >' + ' ' + FORMAT(CalibrationEntr."Last Calibration Date") + '</td>');
                    IF CalibrationEntr."Next Calibration Due On" < TODAY() THEN BEGIN
                        Body += ('<td Style = "color:red" >' + ' ' + FORMAT(CalibrationEntr."Next Calibration Due On") + '</td>');
                        Body += ('<td Style = "color:red" >' + ' ' + FORMAT(TODAY() - CalibrationEntr."Next Calibration Due On") + '</td>');
                    END
                    ELSE BEGIN
                        Body += ('<td >' + ' ' + FORMAT(CalibrationEntr."Next Calibration Due On") + '</td>');
                        //Body += ('<td >'+' '+FORMAT(TODAY()-CalibrationEntr."Next Calibration Due On")+'</td>');
                        Body += ('<td >' + ' ' + FORMAT(0) + '</td>');
                        CalibrationEntr.mailsent := TRUE;
                        CalibrationEntr.MailSentDate := TODAY;  //Version 1.2 for making one time mail
                        CalibrationEntr.MODIFY;  //Version 1.2 for making one time mail
                    END;
                    //Body += ('<td >'+' '+FORMAT(CalibrationEntr."Owner of the Equpmnt_empid")+'</td>');
                    //Body += ('<td >'+' '+FORMAT(CalibrationEntr."Life time in Yrs")+'</td>');
                    //commented by Vishnu on 09-03-2019
                    /*
                    ILE.RESET;
                    ILE.SETCURRENTKEY("Item No.","Lot No.","Serial No.");
                    ILE.SETFILTER("Item No.",CalibrationEntr."Item No");
                    ILE.SETFILTER("Lot No.",CalibrationEntr."MFG. Serial No.");
                    //ile.SETFILTER("Serial No.",CalibrationEntr."Eqpt. Serial No.");
                    ILE.SETFILTER(Open,FORMAT(1));
                    IF ILE.FINDFIRST THEN
                    BEGIN
                      //Body += ('<td >'+' '+FORMAT(ile."Document No.")+'</td>');
                      PMIH1.RESET;
                      PMIH1.SETCURRENTKEY("No.");
                      PMIH1.SETFILTER("No.",ILE."Document No.");
                      IF PMIH1.FINDFIRST THEN
                        BEGIN
                          Body += ('<td >'+' '+FORMAT(COPYSTR(PMIH1."User ID",12))+'</td>');
                        END;
                      END;
                      */
                    Body += ('</tr>');
                END;
                UNTIL CalibrationEntr.NEXT = 0;
            Body += ('</table><br>');

            Body += ('<br/> <i><span Style = "color:red" >Red Color Indicates Deviated Items</Span></i><br>');

            Body += ('<br/> <span  >For any Queries reply to  </Span>' + '<a href="calibration@efftronics.com"<b>calibration@efftronics.com</b></a></br>');

            Body += ('<br>Regards,<br>');
            Body += ('ERP.');
            Body += ('<br>');
            Body += ('<div style="Background-color:#F35317; color:#F0F1F5; "><p align= "center"> *****AUTO GENERATED MAIL FROM ERP**** </div><br/></div>');
            /* SMTP_MAIL.AddBCC('vishnupriya@efftronics.com');
            SMTP_MAIL.Send; */                      //B2BUPG
            Recipients.Add('vishnupriya@efftronics.com');
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        END;
        MESSAGE('Calibration mails sent Successfully');


        //************************************ end of owner mails *********************************************************************************

    end;

    procedure "BGS Expire mails"();
    begin
        bg.RESET;
        bg.SETFILTER(bg.Closed, 'No');
        bg.SETFILTER(bg."BG No.", '<>%1', 'F%');
        bg.SETFILTER(bg."Claim Date", '<%1', TODAY + 15);
        bg.SETFILTER(bg."Expiry Date", '<%1', TODAY + 15);
        /* IF bg.FINDFIRST THEN BEGIN
            REPORT.RUN(33000891, FALSE, FALSE, bg);
            REPORT.SAVEASPDF(33000891, '\\erpserver\ErpAttachments\bg1.pdf', bg);
            Attachment := '\\erpserver\ErpAttachments\bg1.pdf';
            Subject := 'ERP- Possible expire BG Details for the coming 15 Days';
            Body := '***** Auto Mail Generated From ERP *****';
            Mail_From := 'noreply@efftronics.com';
            IF FORMAT(bg."Transaction Type") = 'amc' THEN BEGIN
                Mail_To := 'rajani@efftronics.com,yesu@efftronics.com,susmithal@efftronics.com,erp@efftronics.com,';
                Mail_To += 'sales@efftronics.com';
            END
            ELSE BEGIN
                Mail_To := 'rajani@efftronics.com,';//dir
                Mail_To += 'sales@efftronics.com,yesu@efftronics.com,susmithal@efftronics.com,erp@efftronics.com';
            END;
            IF (Mail_From <> '') AND (Mail_To <> '') THEN BEGIN
                SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
                SMTP_MAIL.AddAttachment(Attachment, '');
                SMTP_MAIL.Send;
            END;
        END; */     //B2BUPG

        IF bg.FINDFIRST THEN BEGIN
            REPORT.RUN(33000891, FALSE, FALSE, bg);
            REPORT.SAVEASPDF(33000891, '\\erpserver\ErpAttachments\bg1.pdf', bg);
            Attachment := '\\erpserver\ErpAttachments\bg1.pdf';
            Subject := 'ERP- Possible expire BG Details for the coming 15 Days';
            Body := '***** Auto Mail Generated From ERP *****';
            IF FORMAT(bg."Transaction Type") = 'amc' THEN BEGIN
                Recipients.Add('rajani@efftronics.com');
                Recipients.Add('yesu@efftronics.com');
                Recipients.Add('susmithal@efftronics.com');
                Recipients.Add('erp@efftronics.com');
                Recipients.Add('sales@efftronics.com');
            END
            ELSE BEGIN
                Recipients.Add('rajani@efftronics.com');
                Recipients.Add('yesu@efftronics.com');
                Recipients.Add('susmithal@efftronics.com');
                Recipients.Add('erp@efftronics.com');
                Recipients.Add('sales@efftronics.com');
            END;
            IF (Mail_From <> '') AND (Mail_To <> '') THEN BEGIN
                EmailMessage.Create(Recipients, Subject, Body, true);
                EmailMessage.AddAttachment(Attachment, '', '');
                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
            END;
        END;
    end;

    local procedure Stk_Rearr();
    var
        loopingVari: Integer;
        Datevariable1: Date;
        Datevariable2: Date;
        Loopvar2: Integer;
        textvar: Text;
    begin
        // written by vishnu priya
        //>> ORACLE UPG
        /* IF ISCLEAR(SQLConnection) THEN
            CREATE(SQLConnection, FALSE, TRUE);

        IF ISCLEAR(RecordSet) THEN
            CREATE(RecordSet, FALSE, TRUE);

        IF ConnectionOpen <> 1 THEN BEGIN
            SQLConnection.ConnectionString := 'DSN=erpserver;UID=report;PASSWORD=Efftronics@eff;SERVER=erpserver;';
            SQLConnection.Open;
            SQLConnection.BeginTrans;
            ConnectionOpen := 1;
        END;

        //********************************************************************************************************

        SQLQuery := 'insert into [Newly_Added_Stock]  SELECT *  from V_Newly_Added_Stk_upto_LastDay';  //[INVOICED_18_19_Orders_BASIC_1]

        //MESSAGE(SQLQuery);
        IF SQLQuery <> '' THEN
            //SQLConnection.Execute(SQLQuery);
            MESSAGE(SQLQuery);


        Day := 1;
        FORLOOP1 := 1;
        SQLQuery5 := 'Select  max([Posting Date] ) as lowerdate from [Stock Analysis]  ';
        //MESSAGE(SQLQuery5);
        RecordSet1 := SQLConnection.Execute(SQLQuery5, RowCount);
        IF RowCount <> 0 THEN
            IF NOT ((RecordSet1.BOF) OR (RecordSet1.EOF)) THEN
                RecordSet1.MoveFirst;
        RowCount := 0;
        WHILE NOT RecordSet1.EOF DO BEGIN
            textvar := FORMAT(RecordSet1.Fields.Item('lowerdate').Value);
            //Datevariable1 := DMY2DATE(EVALUATE(Day,COPYSTR(textvar,9,2)),EVALUATE(month,COPYSTR(textvar,6,2)),EVALUATE(year,COPYSTR(textvar,1,4)));
            //MESSAGE(BANKARRY[Day]);
            RecordSet1.MoveNext;
        END;
        //MESSAGE(FORMAT(Day-1)+' len of Arr');
        MESSAGE(FORMAT(textvar));
        MESSAGE(FORMAT(Datevariable1)); */
        //<< ORACLE UPG
    end;


    local procedure TAMS_BASED_USERS_BLOCKING();
    begin
        // added by vishnu Priya on 23-07-2019 for Blocking the Users in TAMS to ERP
        //>> ORACLE UPG
        /* Updated_Cnt := 0;
        DateFilterCalbartion := CALCDATE('-40D', TODAY()); // To get the Last 20 Days Data
        IF ISCLEAR(SQLConnection) THEN
            CREATE(SQLConnection, FALSE, TRUE);

        IF ISCLEAR(RecordSet) THEN
            CREATE(RecordSet, FALSE, TRUE);

        IF ConnectionOpen <> 1 THEN BEGIN
            SQLConnection.ConnectionString := 'DSN=tams;UID=tams;PASSWORD=firewall123;SERVER=oracle_80;';
            SQLConnection.Open;
            SQLConnection.BeginTrans;
            ConnectionOpen := 1;
        END;
        // Oracle Query to get the Last 20 Days
        SQLQuery := '';
        SQLQuery := 'SELECT id_no,trunc(leftdate) as leftdate FROM V_EMP_DETAILS WHERE LEFTDATE IS NOT NULL  AND LEFTDATE >=to_date(''' + FORMAT(DateFilterCalbartion) + ''',''DD-MM-YY'')';
        //SQLQuery := 'SELECT id_no,trunc(leftdate) as leftdate FROM V_EMP_DETAILS WHERE LEFTDATE IS NOT NULL  AND LEFTDATE >=to_date('''+FORMAT(DateFilterCalbartion)+''',''DD-MM-YY'')';

        //MESSAGE(SQLQuery);
        IF SQLQuery <> '' THEN BEGIN
            SQLConnection.Execute(SQLQuery);
            //SQLConnection.CommitTrans;  commented by vishnu
        END;
        RecordSet1 := SQLConnection.Execute(SQLQuery, RowCount);
        IF RowCount <> 0 THEN
            IF NOT ((RecordSet1.BOF) OR (RecordSet1.EOF)) THEN
                RecordSet1.MoveFirst;
        RowCount := 0;
        WHILE NOT RecordSet1.EOF DO BEGIN
            EmployeeidNumber := FORMAT(RecordSet1.Fields.Item('id_no').Value);
            Empleftdate := RecordSet1.Fields.Item('leftdate').Value;
            UsersTable.RESET;
            UsersTable.SETFILTER(Blocked, FORMAT(0));
            UsersTable.SETFILTER(EmployeeID, EmployeeidNumber);
            IF UsersTable.FINDFIRST THEN BEGIN
                UsersTable.Blocked := TRUE;
                UsersTable.MODIFY;
                Updated_Cnt += 1;
                AccessControlTable.RESET;
                AccessControlTable.SETFILTER("User Name", UsersTable."User Name");
                IF AccessControlTable.FINDSET THEN BEGIN
                    AccessControlTable.SETFILTER("Role ID", 'SUPER-READ');
                    IF AccessControlTable.FINDFIRST THEN
                        AccessControlTable.DELETE;
                END;
                EmployeeTable.RESET;
                EmployeeTable.SETFILTER("No.", UsersTable.EmployeeID);
                IF EmployeeTable.FINDFIRST THEN BEGIN
                    EmployeeTable.Status := EmployeeTable.Status::Inactive;
                    EmployeeTable."Inactive Date" := DT2DATE(Empleftdate);
                    EmployeeTable.MODIFY;
                END;

            END;
            RecordSet1.MoveNext;
        END;
        MESSAGE('Over all Blocked Employees are: ' + FORMAT(Updated_Cnt));

        ////    ************************TAMS  DEPT Updation***********************************
        SQLQuery3 := '';
        SQLQuery3 := 'SELECT id_no,dept,desig FROM V_EMP_DETAILS WHERE LEFTDATE IS  NULL  and DESIG is not null and id_no not like ' + '''%OS%''' + 'order by 1';
        //MESSAGE(SQLQuery);
        IF SQLQuery <> '' THEN BEGIN
            SQLConnection.Execute(SQLQuery3);
            //SQLConnection.CommitTrans;
        END;
        RecordSet2 := SQLConnection.Execute(SQLQuery3, RowCount);
        IF RowCount <> 0 THEN
            IF NOT ((RecordSet2.BOF) OR (RecordSet2.EOF)) THEN
                RecordSet2.MoveFirst;
        RowCount := 0;
        WHILE NOT RecordSet2.EOF DO BEGIN
            EmployeeidNumber := FORMAT(RecordSet2.Fields.Item('id_no').Value);
            Employeedept := RecordSet2.Fields.Item('dept').Value;
            Desig := RecordSet2.Fields.Item('desig').Value;
            UsersTable.RESET;
            //temporarily commented
            UsersTable.SETFILTER(Blocked, FORMAT(0));
            UsersTable.SETFILTER(EmployeeID, EmployeeidNumber);
            IF UsersTable.FINDFIRST THEN BEGIN
                UsersTable.Tams_Dept := Employeedept;
                UsersTable.MODIFY;
                EmployeeTable.RESET;
                EmployeeTable.SETFILTER("No.", UsersTable.EmployeeID);
                IF EmployeeTable.FINDFIRST THEN BEGIN
                    EmployeeTable."Job Title" := Desig;
                END;
                Updated_Cnt += 1;
            END;

            RecordSet2.MoveNext;
        END;
        MESSAGE('Tams Dept Updated Employees : ' + FORMAT(Updated_Cnt)); */
        //<< ORACLE UPG
    end;


    local procedure TAMS_DEPT_UPDATION();
    begin
        //>> ORACLE UPG
        /* Updated_Cnt := 0;
        IF ISCLEAR(SQLConnection) THEN
            CREATE(SQLConnection, FALSE, TRUE);

        IF ISCLEAR(RecordSet) THEN
            CREATE(RecordSet, FALSE, TRUE);

        IF ConnectionOpen <> 1 THEN BEGIN
            SQLConnection.ConnectionString := 'DSN=tams;UID=tams;PASSWORD=firewall123;SERVER=oracle_80;';
            SQLConnection.Open;
            SQLConnection.BeginTrans;
            ConnectionOpen := 1;
        END;
        SQLQuery := '';
        SQLQuery := 'SELECT id_no,dept,desig FROM V_EMP_DETAILS WHERE LEFTDATE IS  NULL';
        //MESSAGE(SQLQuery);
        IF SQLQuery <> '' THEN BEGIN
            SQLConnection.Execute(SQLQuery);
            //SQLConnection.CommitTrans;
        END;
        RecordSet1 := SQLConnection.Execute(SQLQuery, RowCount);
        IF RowCount <> 0 THEN
            IF NOT ((RecordSet1.BOF) OR (RecordSet1.EOF)) THEN
                RecordSet1.MoveFirst;
        RowCount := 0;
        WHILE NOT RecordSet1.EOF DO BEGIN
            EmployeeidNumber := FORMAT(RecordSet1.Fields.Item('id_no').Value);
            Employeedept := RecordSet1.Fields.Item('dept').Value;
            Desig := RecordSet1.Fields.Item('desig').Value;
            UsersTable.RESET;
            //temporarily commented
            UsersTable.SETFILTER(Blocked, FORMAT(0));
            UsersTable.SETFILTER(EmployeeID, EmployeeidNumber);
            IF UsersTable.FINDFIRST THEN BEGIN
                UsersTable.Tams_Dept := Employeedept;
                UsersTable.MODIFY;
                EmployeeTable.RESET;
                EmployeeTable.SETFILTER("No.", UsersTable.EmployeeID);
                IF EmployeeTable.FINDFIRST THEN BEGIN
                    EmployeeTable."Job Title" := Desig;
                END;
                Updated_Cnt += 1;
            END;

            RecordSet1.MoveNext;
        END;
        MESSAGE('Tams Dept Updated Employees : ' + FORMAT(Updated_Cnt)); */
        //<< ORACLE UPG
    end;


    local procedure Stock_Analysis();
    begin
        //>> ORACLE UPG
        /* IF ISCLEAR(SQLConnection) THEN
            CREATE(SQLConnection, FALSE, TRUE);

        IF ISCLEAR(RecordSet) THEN
            CREATE(RecordSet, FALSE, TRUE);

        IF ConnectionOpen <> 1 THEN BEGIN
            SQLConnection.ConnectionString := 'DSN=erpserver;UID=report;PASSWORD=Efftronics@eff;SERVER=erpserver;';
            SQLConnection.Open;
            SQLConnection.BeginTrans;
            ConnectionOpen := 1;
        END;

        //MESSAGE('Hii');
        SQLQuery2 := 'Select ' +
        'Max([Posting Date]) as POSTINGDATE from ' +
        '[Newly_Added_Stock]   ';  //where [Posting Date] =''2019-08-02''
                                   //MESSAGE(SQLQuery2);
                                   //MESSAGE(SQLQuery5);
        RecordSet1 := SQLConnection.Execute(SQLQuery2, RowCount);
        IF RowCount <> 0 THEN
            IF NOT ((RecordSet1.BOF) OR (RecordSet1.EOF)) THEN
                RecordSet1.MoveFirst;
        RowCount := 0;
        WHILE NOT RecordSet1.EOF DO BEGIN
            t2 := FORMAT(RecordSet1.Fields.Item('POSTINGDATE').Value);
            //MESSAGE(t2);
            RowCount := RowCount + 1;
            RecordSet1.MoveNext;
        END;
        EVALUATE(Day1, COPYSTR(t2, 9, 2));
        EVALUATE(Month1, COPYSTR(t2, 6, 2));
        EVALUATE(Year1, COPYSTR(t2, 1, 4));
        //MESSAGE(FORMAT(DMY2DATE(Day1,Month,Year)));
        maxdate := DMY2DATE(Day1, Month1, Year1);
        UptoWhich := TODAY - 1;
        ItemCount := UptoWhich - maxdate;
        //MESSAGE(FORMAT(ItemCount));
        SQLConnection.CommitTrans;


        SQLQuery :=
        'Insert into [Newly_Added_Stock] Select ILE.[Item No_], ' +
        'ILE.[Posting Date],' +
        'sum(ILE.Quantity) as Newly_Added_Qty,' +
        'Getdate()  from ' +
        '[Efftronics Systems Pvt Ltd_,$Item Ledger Entry] as ILE With (NOLOCK) ' +
        'Where ILE.[Posting Date] > (' +
        'Select ' +
        'Max([Posting Date]) from ' +
        '[Newly_Added_Stock]) and ' +
        ' ILE.[Posting Date] <= getdate()-1 and ILE.[Location Code] like ''%STR'' and ILE.Quantity >0 ' +
        ' group by ILE.[Item No_], ILE.[Posting Date]';

        // MESSAGE(SQLQuery);

        IF SQLQuery <> '' THEN BEGIN
            SQLConnection.Execute(SQLQuery);
            //SQLConnection.CommitTrans;
        END;


        // ********************************************************************************************************************************************
        FOR loop_i := 1 TO ItemCount DO BEGIN
            maxdate := maxdate + 1;
            SQLQuery3 := 'insert into "Stock Analysis" ' +
    'select Total_Data.[Item No_],Total_Data.[Posting Date],Total_Data.Saved_time,Total_Data.Consumed_Qty,Total_Data.[Opening Calculted], ' +
    'isnull(Total_Data.Newlyaddedstk,0) as Newlyaddedstk from (select Part1.*,' +
    'case when STKDATA.Last_date is null then (select [Opeing Stock] from [Opening Stock of Items(2018 April)] as OSI with (NOLOCK) ' +
    'where  OSI.Closing_Date = ''2018-03-31'' and  Part1.[Item No_] = OSI.[Item Number] ) else STKDATA.Opening end as [Opening Calculted],case when STKDATA.Last_date is not  null then (' +
    'Select isnull(sum(AddedQty),0) from Newly_Added_Stock as NAS where (NAS.[Posting Date] >= STKDATA.Last_date  and NAS.[Posting Date] <=Part1.[Posting Date] )  and Part1.[Item No_] = NAS.[Item Number] group by NAS.[Item Number]) ' +
    'else ( Select isnull(sum(AddedQty),0) from  Newly_Added_Stock as NAS where (NAS.[Posting Date] >= ''2018-04-02''  and NAS.[Posting Date] <=Part1.[Posting Date] )  and Part1.[Item No_] = NAS.[Item Number]';
            // MESSAGE(SQLQuery3);

            SQLQuery4 := '  group by NAS.[Item Number] ) end as Newlyaddedstk from ' +
            '(Select ILE.[Item No_],ILE.[Posting Date],getdate() as Saved_time,-SUM(ILE.Quantity) as Consumed_Qty from [Efftronics Systems Pvt Ltd_,$Item Ledger Entry] as ILE with (NOLOCK)  ' +
            ' where ILE.[Location Code] in (''STR'') and convert(varchar,ILE.[Posting Date],5) = ''' + FORMAT(maxdate) + ''' AND ILE.Quantity < 0  Group by ILE.[Item No_],ILE.[Posting Date]) as Part1 ' +
            ' left outer join (select Alias2.[Item Number],LAST_VALUE("Closing Stock") over (partition by [Item Number],[Posting Date] order by [Posting Date]) as Opening, ' +
            ' dateadd(DAY,1,LAST_VALUE("Posting Date") over (partition by "Item Number" order by [Posting Date])) as Last_date' +
            ' from  "Stock Analysis" as Alias2 where [Posting Date] = ( select max([Posting Date]) from [Stock Analysis] as Alias1where Alias1.[Item Number] = Alias2.[Item Number] Group by [Item Number])) as STKDATA  ' +
            'on Part1.[Item No_] = STKDATA.[Item Number] ) as Total_Data ORDER BY [Posting Date],[Item No_] ';

            //MESSAGE(SQLQuery3+SQLQuery4);
            IF (SQLQuery3 + SQLQuery4) <> '' THEN BEGIN
                SQLConnection.Execute((SQLQuery3 + SQLQuery4));
                //SQLConnection.CommitTrans;
            END;
        END;
        MESSAGE('Stock Analysi Tables Updated'); */
        //<< ORACLE UPG

        // SQLConnection.CommitTrans;
    end;


    procedure CSIGCS_MAIL();
    begin
        //Added  by Vishnu Priya on 30-10-2019
        count1 := 0;
        DateFilterCalbartion := CALCDATE('-7D', TODAY());
        DCH1.RESET;
        DCH1.SETFILTER("Created Date", '>=%1', DateFilterCalbartion);
        DCH1.SETRANGE(Type, DCH1.Type::Site);
        DCH1.SETFILTER(StoreIncharge, '%1', '');
        //checks if the  list has the not configured items are not so that mail need to be send or not.
        /* IF DCH1.FINDSET THEN BEGIN
            Subject := 'Reg: CS IGC not Configired List';
            Mail_To := 'erp@efftronics.com,srivalli@efftronics.com';
            SMTPMAIL.CreateMessage('erp', 'erp@efftronics.com', Mail_To, Subject, Body, TRUE);
            SMTPMAIL.AppendBody('<html><head><style> divone{background-color: white; width: 1500px; padding: 8px; border-style:solid ; border-color:#E36015;  margin: 10px;} </style></head>');
            SMTPMAIL.AppendBody('<body><div style="border-color:#18BEAF;  margin: 8px; border-width:10px;   border-style:solid; padding: 8px; width: 1500px;">');
            SMTPMAIL.AppendBody('<label><font size="6">Effected Stock Due to Not configuration of CS IGC in Item Card </font></label>');
            SMTPMAIL.AppendBody('<hr style=solid; color= #2C2EA8 >');
            SMTPMAIL.AppendBody('<h>Dear Sir/Mam  ,</h><br>');
            SMTPMAIL.AppendBody('<P>        Below are the List of Cards/Items which does not have the CS IGC in Item Master</P>');
            SMTPMAIL.AppendBody('<table border = "1" style="border-collapse:collapse; width:100%; fond-size:5pt;">');
            SMTPMAIL.AppendBody('<tr>');
            SMTPMAIL.AppendBody('<th> DC Number </th>');
            SMTPMAIL.AppendBody('<th> Created Date </th>');
            SMTPMAIL.AppendBody('<th> Location Name </th>');
            SMTPMAIL.AppendBody('<th> Item Number </th>');
            SMTPMAIL.AppendBody('<th> Description </th>');
            SMTPMAIL.AppendBody('<th> Quantity </th> </tr>');
            REPEAT
                DCL1.RESET;
                DCL1.SETFILTER("Document No.", DCH1."No.");
                DCL1.SETFILTER(Quantity, '>%1', 0);
                DCL1.SETFILTER("No.", '<>%1', '');
                IF DCL1.FINDSET THEN BEGIN
                    REPEAT
                        item1.RESET;
                        item1.SETFILTER("No.", DCL1."No.");
                        item1.SETFILTER("Product Group Code", '<>%1', 'STATIONARY');
                        IF item1.FINDFIRST THEN
                            IF (item1."CS IGC" = '') THEN BEGIN
                                SMTPMAIL.AppendBody('<tr><td>' + ' ' + FORMAT(DCH1."No.") + '</td>');
                                SMTPMAIL.AppendBody('<td>' + ' ' + FORMAT(DCH1."Created Date") + '</td>');
                                SMTPMAIL.AppendBody('<td>' + ' ' + FORMAT(DCH1."Location Name") + '</td>');
                                SMTPMAIL.AppendBody('<td>' + ' ' + FORMAT(DCL1."No.") + '</td>');
                                SMTPMAIL.AppendBody('<td>' + ' ' + FORMAT(DCL1.Description) + '</td>');
                                SMTPMAIL.AppendBody('<td>' + ' ' + FORMAT(DCL1.Quantity) + '</td>');
                                SMTPMAIL.AppendBody('</tr>');
                            END;
                    UNTIL DCL1.NEXT = 0
                END;
            UNTIL DCH1.NEXT = 0;
            SMTPMAIL.AppendBody('</table><br>');
            SMTPMAIL.AppendBody('<div style="Background-color:#F35317; color:#F0F1F5; "><p align= "center"> *****AUTO GENERATED MAIL FROM ERP**** </div><br/></div>');
            //SMTPMAIL.AddBCC('vishnupriya@efftronics.com');
            SMTPMAIL.Send;
        END; */         //B2BUPG

        IF DCH1.FINDSET THEN BEGIN
            Subject := 'Reg: CS IGC not Configired List';

            Recipients.Add('erp@efftronics.com');
            Recipients.Add('srivalli@efftronics.com');
            EmailMessage.Create(Recipients, Subject, Body, true);
            Body += ('<html><head><style> divone{background-color: white; width: 1500px; padding: 8px; border-style:solid ; border-color:#E36015;  margin: 10px;} </style></head>');
            Body += ('<body><div style="border-color:#18BEAF;  margin: 8px; border-width:10px;   border-style:solid; padding: 8px; width: 1500px;">');
            Body += ('<label><font size="6">Effected Stock Due to Not configuration of CS IGC in Item Card </font></label>');
            Body += ('<hr style=solid; color= #2C2EA8 >');
            Body += ('<h>Dear Sir/Mam  ,</h><br>');
            Body += ('<P>        Below are the List of Cards/Items which does not have the CS IGC in Item Master</P>');
            Body += ('<table border = "1" style="border-collapse:collapse; width:100%; fond-size:5pt;">');
            Body += ('<tr>');
            Body += ('<th> DC Number </th>');
            Body += ('<th> Created Date </th>');
            Body += ('<th> Location Name </th>');
            Body += ('<th> Item Number </th>');
            Body += ('<th> Description </th>');
            Body += ('<th> Quantity </th> </tr>');
            REPEAT
                DCL1.RESET;
                DCL1.SETFILTER("Document No.", DCH1."No.");
                DCL1.SETFILTER(Quantity, '>%1', 0);
                DCL1.SETFILTER("No.", '<>%1', '');
                IF DCL1.FINDSET THEN BEGIN
                    REPEAT
                        item1.RESET;
                        item1.SETFILTER("No.", DCL1."No.");
                        item1.SETFILTER("Product Group Code Cust", '<>%1', 'STATIONARY');
                        IF item1.FINDFIRST THEN
                            IF (item1."CS IGC" = '') THEN BEGIN
                                Body += ('<tr><td>' + ' ' + FORMAT(DCH1."No.") + '</td>');
                                Body += ('<td>' + ' ' + FORMAT(DCH1."Created Date") + '</td>');
                                Body += ('<td>' + ' ' + FORMAT(DCH1."Location Name") + '</td>');
                                Body += ('<td>' + ' ' + FORMAT(DCL1."No.") + '</td>');
                                Body += ('<td>' + ' ' + FORMAT(DCL1.Description) + '</td>');
                                Body += ('<td>' + ' ' + FORMAT(DCL1.Quantity) + '</td>');
                                Body += ('</tr>');
                            END;
                    UNTIL DCL1.NEXT = 0
                END;
            UNTIL DCH1.NEXT = 0;
            Body += ('</table><br>');
            Body += ('<div style="Background-color:#F35317; color:#F0F1F5; "><p align= "center"> *****AUTO GENERATED MAIL FROM ERP**** </div><br/></div>');
            //SMTPMAIL.AddBCC('vishnupriya@efftronics.com');
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        END;


        //End  by Vishnu Priya on 30-10-2019
    end;

    local procedure QAFLAG();
    begin
        //added by vishnu priya on 29-11-2019
        Updated_Cnt := 0;
        //>> ORACLE UPG
        /* IF ISCLEAR(SQLConnection) THEN
            CREATE(SQLConnection, FALSE, TRUE);

        IF ISCLEAR(RecordSet) THEN
            CREATE(RecordSet, FALSE, TRUE);

        IF ConnectionOpen <> 1 THEN BEGIN
            SQLConnection.ConnectionString := 'DSN=erpserver;UID=report;PASSWORD=Efftronics@eff;SERVER=erpserver;';
            SQLConnection.Open;
            SQLConnection.BeginTrans;
            ConnectionOpen := 1;
        END;
        SQLQuery := '';
        SQLQuery := 'Select s.DeptNumber,s.DeptName,s.InchargeMailID from V_QA_FLAG_CONCENRS s';
        //MESSAGE(SQLQuery);
        IF SQLQuery <> '' THEN BEGIN
            SQLConnection.Execute(SQLQuery);
            //SQLConnection.CommitTrans;
        END;
        RecordSet1 := SQLConnection.Execute(SQLQuery, RowCount);
        IF RowCount <> 0 THEN
            IF NOT ((RecordSet1.BOF) OR (RecordSet1.EOF)) THEN
                RecordSet1.MoveFirst;
        RowCount := 0;
        WHILE NOT RecordSet1.EOF DO BEGIN
            DeptNumber := RecordSet1.Fields.Item('DeptNumber').Value;
            NewString := RecordSet1.Fields.Item('DeptName').Value;
            concern_person := RecordSet1.Fields.Item('InchargeMailID').Value; 
            IRHeader.RESET;
            IRHeader.SETCURRENTKEY("Posted Date");
            IRHeader.SETFILTER(Flag, FORMAT(1));
            IRHeader.SETRANGE("Concerned Dept", DeptNumber);
            IRHeader.SETFILTER("Action Required", FORMAT(1));
            /* IF IRHeader.FINDSET THEN BEGIN
                // MESSAGE('Id Number: '+FORMAT(NewString)+'Found with '+FORMAT(IRHeader.COUNT));
                Subject := 'Reg: QA Flagged';
                Mail_To := concern_person;
                SMTP_MAIL.CreateMessage('Calibration', 'calibration@efftronics.com', Mail_To, Subject, Body, TRUE);
                Body += ('<html><head><style> divone{background-color: white; width: 1500px; padding:3px; border-style:solid ; border-color:#12239E;  margin: 8px;} </style></head>');
                Body += ('<body><div style="border-color:#7B92BC;  margin: 8px; border-width:10px;   border-style:solid; padding: 8px; width: 1400px;">');
                Body += ('<label><font size="6">QC Flag</font></label>');
                Body += ('<hr style=solid; color= #E044A7 >');
                Body += ('<h>Dear Sir/Mam' + ' ,</h><br>');
                Body += ('<P>        Below are the QC Flagged Items which need to take proper action </P>');
                Body += ('<table border = "1" style="border-collapse:collapse; width:100%; fond-size:5pt;border: 3px solid black">');
                Body += ('<tr style ="border: 2px solid black" bgcolor="#7B92BC">');
                Body += ('<th> Item Number </th>');
                Body += ('<th> Description </th>');
                Body += ('<th> Posting Date </th>');
                Body += ('<th> Posting Date to Today(D) </th>');
                Body += ('<th> Concerned Dept</th>');
                Body += ('<th> Action To be Taken</th>');
                Body += ('<th> Item Grp </th>');
                Body += ('</tr>');
                REPEAT
                BEGIN
                    Body += ('<tr style = "border: 2px solid black">');
                    Body += ('<td>' + ' ' + FORMAT(IRHeader."Item No.") + '</td>');
                    Body += ('<td>' + ' ' + FORMAT(IRHeader."Item Description") + '</td>');
                    Body += ('<td>' + ' ' + FORMAT(IRHeader."Posted Date") + '</td>');
                    Body += ('<td align="right">' + ' ' + FORMAT(TODAY() - IRHeader."Posted Date") + '</td>');
                    Body += ('<td>' + ' ' + FORMAT(IRHeader."Concerned Dept") + '</td>');
                    Body += ('<td>' + ' ' + FORMAT(IRHeader."Action To Be Taken") + '</td>');
                    item1.RESET;
                    item1.SETFILTER("No.", IRHeader."Item No.");
                    IF item1.FINDFIRST THEN
                        Body += ('<td >' + ' ' + FORMAT(item1."Product Group Code") + '</td>');
                END;
                UNTIL IRHeader.NEXT = 0;
                Body += ('</table><br>');
                //Body += ('<br/> <i><span Style = "color:red" >Red Color Indicates Deviated Items</Span></i><br>');
                Body += ('<br/> <span  >For any Queries reply to  </Span>' + '<a href="calibration@efftronics.com"<b>calibration@efftronics.com</b></a></br>');
                Body += ('For report: <a href ="https://app.powerbi.com/view?r=eyJrIjoiOGQ0Mzk2MDEtMTRkNi00ZjA5LTkxMmUtZGZiZjYxYjQ2MmQyIiwidCI6IjZhZDY1ZDZkLWZkODctNDQ5OC04ZTkyLTUzNGM3YTA3ZjlmOCIsImMiOjEwfQ%3D%3D"> click here </a><br>');
                Body += ('<br>Regards,<br>');
                Body += ('ERP.');
                Body += ('<br>');
                Body += ('<div style="Background-color:#7B92BC; color:#F0F1F5; "><p align= "center"> *****AUTO GENERATED MAIL FROM ERP**** </div><br/></div>');
                SMTP_MAIL.AddCC('Calibration@efftronics.com,qainward@efftronics.com');
                SMTP_MAIL.AddBCC('vishnupriya@efftronics.com');
                SMTP_MAIL.Send;
            END; */ //B2BUPG


        /*IF IRHeader.FINDSET THEN BEGIN
            // MESSAGE('Id Number: '+FORMAT(NewString)+'Found with '+FORMAT(IRHeader.COUNT));
            Subject := 'Reg: QA Flagged';
            Mail_To := concern_person;
            Recipients.Add(concern_person);
            EmailMessage.Create(Recipients, Subject, Body, true);
            Body += ('<html><head><style> divone{background-color: white; width: 1500px; padding:3px; border-style:solid ; border-color:#12239E;  margin: 8px;} </style></head>');
            Body += ('<body><div style="border-color:#7B92BC;  margin: 8px; border-width:10px;   border-style:solid; padding: 8px; width: 1400px;">');
            Body += ('<label><font size="6">QC Flag</font></label>');
            Body += ('<hr style=solid; color= #E044A7 >');
            Body += ('<h>Dear Sir/Mam' + ' ,</h><br>');
            Body += ('<P>        Below are the QC Flagged Items which need to take proper action </P>');
            Body += ('<table border = "1" style="border-collapse:collapse; width:100%; fond-size:5pt;border: 3px solid black">');
            Body += ('<tr style ="border: 2px solid black" bgcolor="#7B92BC">');
            Body += ('<th> Item Number </th>');
            Body += ('<th> Description </th>');
            Body += ('<th> Posting Date </th>');
            Body += ('<th> Posting Date to Today(D) </th>');
            Body += ('<th> Concerned Dept</th>');
            Body += ('<th> Action To be Taken</th>');
            Body += ('<th> Item Grp </th>');
            Body += ('</tr>');
            REPEAT
            BEGIN
                Body += ('<tr style = "border: 2px solid black">');
                Body += ('<td>' + ' ' + FORMAT(IRHeader."Item No.") + '</td>');
                Body += ('<td>' + ' ' + FORMAT(IRHeader."Item Description") + '</td>');
                Body += ('<td>' + ' ' + FORMAT(IRHeader."Posted Date") + '</td>');
                Body += ('<td align="right">' + ' ' + FORMAT(TODAY() - IRHeader."Posted Date") + '</td>');
                Body += ('<td>' + ' ' + FORMAT(IRHeader."Concerned Dept") + '</td>');
                Body += ('<td>' + ' ' + FORMAT(IRHeader."Action To Be Taken") + '</td>');
                item1.RESET;
                item1.SETFILTER("No.", IRHeader."Item No.");
                IF item1.FINDFIRST THEN
                    Body += ('<td >' + ' ' + FORMAT(item1."Product Group Code") + '</td>');
            END;
            UNTIL IRHeader.NEXT = 0;
            Body += ('</table><br>');
            //Body += ('<br/> <i><span Style = "color:red" >Red Color Indicates Deviated Items</Span></i><br>');
            Body += ('<br/> <span  >For any Queries reply to  </Span>' + '<a href="calibration@efftronics.com"<b>calibration@efftronics.com</b></a></br>');
            Body += ('For report: <a href ="https://app.powerbi.com/view?r=eyJrIjoiOGQ0Mzk2MDEtMTRkNi00ZjA5LTkxMmUtZGZiZjYxYjQ2MmQyIiwidCI6IjZhZDY1ZDZkLWZkODctNDQ5OC04ZTkyLTUzNGM3YTA3ZjlmOCIsImMiOjEwfQ%3D%3D"> click here </a><br>');
            Body += ('<br>Regards,<br>');
            Body += ('ERP.');
            Body += ('<br>');
            Body += ('<div style="Background-color:#7B92BC; color:#F0F1F5; "><p align= "center"> *****AUTO GENERATED MAIL FROM ERP**** </div><br/></div>');

            Recipients.Add('Calibration@efftronics.com');
            Recipients.Add('qainward@efftronics.com');
            Recipients.Add('vishnupriya@efftronics.com');
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        END;
        RecordSet1.MoveNext;
        Updated_Cnt += 1;
    END;
    SQLQuery2 := 'insert into Invoiced_18_19_RAW_MATERIALS select * from V_CONSUMABLES_DUMPTO_ACTUALS';
    IF SQLQuery2 <> '' THEN
        SQLConnection.Execute(SQLQuery2);
    //ended by vishnu priya on 29-11-2019*/
        //<< ORACLE UPG

    end;


    procedure BG_TEST_MAILS();
    begin
        bg.RESET;
        bg.SETFILTER(bg.Closed, 'No');
        bg.SETFILTER(bg."BG No.", '<>%1', 'F%');
        bg.SETFILTER(bg."Claim Date", '<%1', TODAY + 15);
        bg.SETFILTER(bg."Expiry Date", '<%1', TODAY + 15);
        /* IF bg.FINDSET THEN BEGIN
            Subject := 'ERP- Possible expire BG Details for the coming 15 Days';
            Mail_From := 'erp@efftronics.com';
            IF FORMAT(bg."Transaction Type") = 'amc' THEN BEGIN
                Mail_To := 'rajani@efftronics.com,yesu@efftronics.com,erp@efftronics.com,';
            END
            ELSE BEGIN
                //Mail_To:='rajani@efftronics.com,';//dir
                Mail_To := 'rajani@efftronics.com,sales@efftronics.com,yesu@efftronics.com,erp@efftronics.com';
            END;
            IF (Mail_From <> '') AND (Mail_To <> '') THEN BEGIN
                SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
                Body += ('<table border = "1" style="border-collapse:collapse; width:100%; fond-size:5pt;border: 3px solid black">');
                Body += ('<tr style ="border: 2px solid black" bgcolor="#7B92BC">');
                Body += ('<th> BG Number </th>');
                Body += ('<th> Customer Name </th>');
                Body += ('<th> Customer Ord.No </th>');
                Body += ('<th> BG Value </th>');
                Body += ('<th> Expire Date </th>');
                Body += ('<th> Extension Date </th>');
                Body += ('<th> Department </th>');
                Body += ('<th> Order No </th>');
                Body += ('</tr>');
                //SMTP_MAIL.AddAttachment(Attachment,'');
                REPEAT
                    Body += ('<tr style = "border: 2px solid black">');
                    IF STRLEN(bg."BG No.") >= 15 THEN BEGIN
                        Body += ('<td>' + ' ' + FORMAT(bg."BG No.") + '</td>');
                        IF CUSTOMER.GET(bg."Issued to/Received from") THEN
                            Body += ('<td>' + ' ' + FORMAT(CUSTOMER.Name) + '</td>');
                        Body += ('<td>' + ' ' + FORMAT(bg."Customer Order No.") + '</td>');
                        Body += ('<td align="right">' + ' ' + FORMAT(bg."BG Value") + '</td>');
                        Body += ('<td>' + ' ' + FORMAT(bg."Expiry Date") + '</td>');
                        Body += ('<td>' + ' ' + FORMAT(bg."Claim Date") + '</td>');
                        Body += ('<td>' + ' ' + FORMAT(COPYSTR(bg."Doc No.", 5, 3)) + '</td>');
                        Body += ('<td>' + ' ' + FORMAT(bg."Doc No.") + '</td>');
                    END;
                UNTIL bg.NEXT = 0;
                Body += ('</table><br>');
                Body += ('<br>Regards,<br>');
                Body += ('ERP.');
                Body += ('<br>');
                Body += ('<div style="Background-color:#7B92BC; color:#F0F1F5; "><p align= "center"> *****AUTO GENERATED MAIL FROM ERP**** </div><br/></div>');
                SMTP_MAIL.Send;
            END; 
        END;*/          //B2BUPG

        IF bg.FINDSET THEN BEGIN
            Subject := 'ERP- Possible expire BG Details for the coming 15 Days';
            IF FORMAT(bg."Transaction Type") = 'amc' THEN BEGIN

                Recipients.Add('rajani@efftronics.com');
                Recipients.Add('yesu@efftronics.com');
                Recipients.Add('erp@efftronics.com');
            END
            ELSE BEGIN

                Recipients.Add('rajani@efftronics.com');
                Recipients.Add('yesu@efftronics.com');
                Recipients.Add('erp@efftronics.com');
                Recipients.Add('sales@efftronics.com');
            END;
            IF (Mail_From <> '') AND (Mail_To <> '') THEN BEGIN
                EmailMessage.Create(Recipients, Subject, Body, true);
                Body += ('<table border = "1" style="border-collapse:collapse; width:100%; fond-size:5pt;border: 3px solid black">');
                Body += ('<tr style ="border: 2px solid black" bgcolor="#7B92BC">');
                Body += ('<th> BG Number </th>');
                Body += ('<th> Customer Name </th>');
                Body += ('<th> Customer Ord.No </th>');
                Body += ('<th> BG Value </th>');
                Body += ('<th> Expire Date </th>');
                Body += ('<th> Extension Date </th>');
                Body += ('<th> Department </th>');
                Body += ('<th> Order No </th>');
                Body += ('</tr>');
                //SMTP_MAIL.AddAttachment(Attachment,'');
                REPEAT
                    Body += ('<tr style = "border: 2px solid black">');
                    IF STRLEN(bg."BG No.") >= 15 THEN BEGIN
                        Body += ('<td>' + ' ' + FORMAT(bg."BG No.") + '</td>');
                        IF CUSTOMER.GET(bg."Issued to/Received from") THEN
                            Body += ('<td>' + ' ' + FORMAT(CUSTOMER.Name) + '</td>');
                        Body += ('<td>' + ' ' + FORMAT(bg."Customer Order No.") + '</td>');
                        Body += ('<td align="right">' + ' ' + FORMAT(bg."BG Value") + '</td>');
                        Body += ('<td>' + ' ' + FORMAT(bg."Expiry Date") + '</td>');
                        Body += ('<td>' + ' ' + FORMAT(bg."Claim Date") + '</td>');
                        Body += ('<td>' + ' ' + FORMAT(COPYSTR(bg."Doc No.", 5, 3)) + '</td>');
                        Body += ('<td>' + ' ' + FORMAT(bg."Doc No.") + '</td>');
                    END;
                UNTIL bg.NEXT = 0;
                Body += ('</table><br>');
                Body += ('<br>Regards,<br>');
                Body += ('ERP.');
                Body += ('<br>');
                Body += ('<div style="Background-color:#7B92BC; color:#F0F1F5; "><p align= "center"> *****AUTO GENERATED MAIL FROM ERP**** </div><br/></div>');
                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
            END;
        End;
    end;

}

