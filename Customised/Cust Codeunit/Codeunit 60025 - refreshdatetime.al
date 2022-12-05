codeunit 60025 refreshdatetime
{

    trigger OnRun();
    begin
        //ContinuosSupportWithEfftronics;
        //SurveyWithEfftronics;
        Efftronicsrepresentative;
        //prodorder."No.":=FORMAT('APV08AMC01');
        // refresh(prodorder."No.");

        //B2B  Vendor  mail for gst filling
        //VendorGstFillling;

        //VendorIntimationMessage;

        //VendorCarona;
        /*
        Vendor.RESET;
        Vendor.SETRANGE(Maintenacecommonmail,TRUE);
        IF Vendor.FINDSET THEN REPEAT
          Vendor.Maintenacecommonmail := FALSE;
          Vendor.MODIFY;
        UNTIL Vendor.NEXT = 0;
        MESSAGE('completed');
        */
        //TestMail

        //SurveyWithEfftronics;

    end;

    var
        prodorder: Record "Production Order";
        date: Date;
        datetime: DateTime;
        HtmlFormatted: Boolean;
        time: Time;
        item: Record Item;
        prodline: Record "Prod. Order Line";
        "-----b2b-----": Integer;
        Vendor: Record Vendor;
        ToMail: Text[250];
        FromMail: Text[250];
        // SMTPMail: Codeunit "SMTP Mail";

        MonthGvar: Text;
        YearGVar: Integer;
        totVendor: Integer;
        PurchaseHeader: Record "Purchase Header";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Recipients1: Text;

        Body: Text;
        Subject: Text;


    procedure refresh(var prodno: Code[20]);
    begin
        /*
            prodorder.SETRANGE(prodorder."No.",prodno);
            IF prodorder.FINDSET THEN
            REPEAT
            prodorder.Refreshdate:=TODAY;
          item.SETFILTER(item."No.",prodorder."Source No.");
          IF item.COUNT=1 THEN
          BEGIN
          item.GET(prodorder."Source No.");
          prodorder."Item Sub Group Code":=item."Item Sub Group Code";
          prodorder."Product Group Code":=item."Product Group Code";
          prodorder.MODIFY;
          END;
          UNTIL prodorder.NEXT=0;
        prodline.SETFILTER(prodline."Prod. Order No.",prodno);
        IF prodline.FINDSET THEN
        REPEAT
        prodline."Sales Order No":=prodorder."Sales Order No.";
        //MESSAGE(FORMAT(prodline."Sales Order No"));
        prodline.MODIFY;
        UNTIL prodline.NEXT=0;
        */

    end;


    local procedure VendorGstFillling();
    begin
        /*
        YearGVar := DATE2DMY(WORKDATE,3);
        MonthGvar := FORMAT(WORKDATE,0,'<Month text,3>');
        
        FromMail := 'purchaseaccounts@efftronics.com';
        Subject := 'Reminder for GST Returns Filling';
        
        Vendor.RESET;
        Vendor.SETRANGE("GST Vendor Type",Vendor."GST Vendor Type"::Registered);
        Vendor.SETFILTER("No Of POs",'>%1',0);
        Vendor.SETRANGE(Maintenacecommonmail,FALSE);
        IF Vendor.FINDSET THEN BEGIN
          REPEAT
            PurchaseHeader.RESET;
            PurchaseHeader.SETRANGE("Document Type",PurchaseHeader."Document Type"::Order);
            PurchaseHeader.SETFILTER("Order Date",'>=%1',010419D);
            PurchaseHeader.SETRANGE("Buy-from Vendor No.",Vendor."No.");
            IF PurchaseHeader.FINDFIRST THEN BEGIN
            CLEAR(ToMail);
            IF Vendor."E-Mail" <> '' THEN
              ToMail := Vendor."E-Mail";
             IF (ToMail <>'') AND (FromMail<>'')  THEN BEGIN
               SMTPMail.CreateMessage('ERP',FromMail,ToMail,Subject,'',TRUE);
               SMTPMail.AddBCC('purchaseaccounts@efftronics.com');
               SMTPMail.AppendBody('Dear Sir/Madam,');
               SMTPMail.AppendBody('<BR><BR>');
               SMTPMail.AppendBody('Please file the GST returns as per your terms wise.');
               SMTPMail.AppendBody('<BR><BR>');
               SMTPMail.AppendBody('Monthly returns supplies filing on or before'+' '+ MonthGvar +' 15th of '+ MonthGvar+ ' '+FORMAT(YearGVar));
               SMTPMail.AppendBody('<BR>');
               IF MonthGvar IN['Jan','Apr','Jul','Oct'] THEN
                 SMTPMail.AppendBody('Quarterly returns supplier filing on or before'+' '+ MonthGvar +' 30th of '+ MonthGvar+ ' '+FORMAT(YearGVar));
               SMTPMail.AppendBody('<BR><BR>');
               SMTPMail.AppendBody('Note : Please forget this mail,if you are filed Or Not applicable vendors.');
               SMTPMail.AppendBody('<BR><BR>');
               SMTPMail.AppendBody('Regards,');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('Padmasri D');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('Purchase');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('EfftronicsSystems Pvt. Ltd.,');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('40-15-9,Brundavan Colony,');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('Vijayawada - 520010,');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('Andhra Pradesh, India.');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('Ph No : 0866-2483375; Cell No : 08328698839');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('Website :<a href="http://www.effe.in/"><b>www.effe.in,</b></a><a href="https://www.efftronics.com/"><b>www.efftronics.com</b></a>');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.Send;
             END;
             Vendor.Maintenacecommonmail := TRUE;
             Vendor.MODIFY;
             END;
          UNTIL Vendor.NEXT = 0;
        END;
        
        MESSAGE('completed');
        */

    end;


    local procedure VendorIntimationMessage();
    begin
        /*
        FromMail := 'purchase@efftronics.com';
        Subject := 'Efftronics company representative';
        
        Vendor.RESET;
        Vendor.SETFILTER("No Of POs",'>%1',0);
        Vendor.SETRANGE("GST Vendor Type",Vendor."GST Vendor Type"::Registered);
        Vendor.SETRANGE("Information Mail",FALSE);
        IF Vendor.FINDSET THEN
          REPEAT
            CLEAR(ToMail);
            IF Vendor."E-Mail" <> '' THEN
              ToMail := Vendor."E-Mail";
             IF (ToMail <>'') AND (FromMail<>'')  THEN BEGIN
               SMTPMail.CreateMessage('ERP',FromMail,ToMail,Subject,'',TRUE);
               SMTPMail.AddBCC('purchaseaccounts@efftronics.com');
               SMTPMail.AppendBody('Dear Vendor,');
               SMTPMail.AppendBody('<BR><BR>');
               SMTPMail.AppendBody('Greetings of the day. We would like to inform that due to Mr. Chowdary’s sudden absence from office,  he is divested of his responsibilities until further notice and is not authorized to deal on behalf of the company');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('We request you to contact Ms. Renuka . Following are her contact details.');
               SMTPMail.AppendBody('<BR><BR>');
               SMTPMail.AppendBody('Email -renukach@efftronics.com');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('Mobile- +91-7036666132');
               SMTPMail.AppendBody('<BR><BR>');
               SMTPMail.AppendBody('Thanking you..');
               SMTPMail.AppendBody('<BR><BR>');
               SMTPMail.AppendBody('Regards,');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('Anvesh Dasari');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('Vice President');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('Cell No :+919849051177');
                SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('EfftronicsSystems Pvt. Ltd.,');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('40-15-9,Brundavan Colony,');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('Vijayawada - 520010,');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('Andhra Pradesh, India.');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('Ph No : 0866-2483375');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('Website :<a href="http://www.effe.in/"><b>www.effe.in,</b></a><a href="https://www.efftronics.com/"><b>www.efftronics.com</b></a>');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.Send;
             END;
             Vendor."Information Mail" := TRUE;
             Vendor.MODIFY;
          UNTIL Vendor.NEXT = 0;
             MESSAGE('Mail send');
        
        */

    end;


    local procedure VendorCarona();
    begin
        /*
        YearGVar := DATE2DMY(WORKDATE,3);
        MonthGvar := FORMAT(WORKDATE,0,'<Month text,3>');
        
        FromMail := 'purchase@efftronics.com';
        Subject := 'Important Message from Efftronics';
        
        Vendor.RESET;
        Vendor.SETFILTER("No Of POs",'>%1',0);
        Vendor.SETRANGE(Maintenacecommonmail,FALSE);
        IF Vendor.FINDSET THEN BEGIN
          REPEAT
            PurchaseHeader.RESET;
            PurchaseHeader.SETRANGE("Document Type",PurchaseHeader."Document Type"::Order);
            PurchaseHeader.SETFILTER("Order Date",'>=%1',010419D);
            PurchaseHeader.SETRANGE("Buy-from Vendor No.",Vendor."No.");
            IF PurchaseHeader.FINDFIRST THEN BEGIN
            CLEAR(ToMail);
            IF Vendor."E-Mail" <> '' THEN
              ToMail := Vendor."E-Mail";
             IF (ToMail <>'') AND (FromMail<>'')  THEN BEGIN
               SMTPMail.CreateMessage('ERP',FromMail,ToMail,Subject,'',TRUE);
               SMTPMail.AddBCC('purchaseaccounts@efftronics.com');
               SMTPMail.AppendBody('Dear Efftronics Valued Partner and Supplier,');
               SMTPMail.AppendBody('<BR><BR>');
               SMTPMail.AppendBody('Firstly, I would like to thank all suppliers who have supported us in achieving our business targets of FY19-20. Your continuous support is key to our growth.');
               SMTPMail.AppendBody('<BR><BR>');
               SMTPMail.AppendBody('Covid -19 is impacting the humanity across the globe. For Efftronics our biggest priority is the safety of all our stake holders.');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('We hope that everyone is taking required safety measures in house as well as in workplaces.');
               SMTPMail.AppendBody('<BR><BR>');
               SMTPMail.AppendBody('Covid-19 has created an unprecedented challenge to countries, Industries and individuals. This pandemic is going to impact each industry. The quantum of impact may differ from Industry to Industry.');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('In these challenging times, every business needs to transform itself to sustain. We need to re-engineer our business, processes and products.');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('We also need to rethink on our products as the customer preferences and priorities may also change.');
               SMTPMail.AppendBody('<BR><BR>');
               SMTPMail.AppendBody('For Efftronics, we have built strong foundation over the years with our values and principles. We always believed in win-win in all our collaborations.But still this global pandemic is going to hit every enterprise');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('profitability and future revenues.In these critical times, it is more important to work as a team. We all need to understand each other challenges and collaborate more efficiently.');
               SMTPMail.AppendBody('<BR><BR>');
               SMTPMail.AppendBody('In these challenging times, we all need to have a growth mindset and start using our time more productively. We need to learn various things like business tools, new technologies, productivity process and trends.');
               SMTPMail.AppendBody('<BR><BR>');
               SMTPMail.AppendBody('I would like reiterate Gartner’s simple formula.');
               SMTPMail.AppendBody('<BR><BR>');
               SMTPMail.AppendBody('(Mindsets + Practises) x Technology = Capabilities => Results');
               SMTPMail.AppendBody('<BR><BR>');
               SMTPMail.AppendBody('Changing mindsets lead to new practices, which are amplified by technology, leading to new capabilities and yielding new results.');
               SMTPMail.AppendBody('<BR><BR>');
               SMTPMail.AppendBody('We also commit to clear all pending dues of every supplier/ vendor. Our company is ensuring that all vendors get their payments at the earliest.');
               SMTPMail.AppendBody('<BR><BR>');
               SMTPMail.AppendBody('I request every supplier to well inform us on all kinds of developments. This helps us in better planning and better control of the situation. ');
               SMTPMail.AppendBody('<BR><BR>');
               SMTPMail.AppendBody('As lock downs are being implemented across the world, supply chains across the globe are going to impact. Semiconductor Foundries across the globe are also shut during these lock downs.');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('We request every dealer / distributor to inform us on all kinds of changes that has been developed due to this pandemic.');
               SMTPMail.AppendBody('<BR><BR>');
               SMTPMail.AppendBody('Our purchase team will be available for any kind of support. Our teams can be reached through all kinds of connectives during lock down period as well. ');
               SMTPMail.AppendBody('<BR><BR>');
               SMTPMail.AppendBody('As Henry Ford said, “Coming together is beginning, staying together is progress and working together is success”. In these challenging times we all need to collaborate more efficiently and combat this global crisis.');
               SMTPMail.AppendBody('<BR><BR>');
               SMTPMail.AppendBody('Stay Home, Stay Safe.');
               SMTPMail.AppendBody('<BR><BR>');
               SMTPMail.AppendBody('Regards,');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('D. Rama Krishna');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('Manging Director,');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('EfftronicsSystems Pvt. Ltd.,');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('40-15-9,Brundavan Colony,');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('Vijayawada - 520010,');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('Andhra Pradesh, India.');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.AppendBody('Website :<a href="http://www.effe.in/"><b>www.effe.in,</b></a><a href="https://www.efftronics.com/"><b>www.efftronics.com</b></a>');
               SMTPMail.AppendBody('<BR>');
               SMTPMail.Send;
             END;
             Vendor.Maintenacecommonmail := TRUE;
             Vendor.MODIFY;
             END;
          UNTIL Vendor.NEXT = 0;
          MESSAGE('completed');
        END;
        */

    end;

    local procedure SurveyWithEfftronics();
    var

    begin

        /*  YearGVar := DATE2DMY(WORKDATE, 3);
         MonthGvar := FORMAT(WORKDATE, 0, '<Month text,3>');

         FromMail := 'purchase@efftronics.com';
         Subject := 'Reg: Survey with Efftronics Systems Pvt ltd Suppliers -COVID-19 Period-Supply Chain Challenges';

         Vendor.RESET;
         Vendor.SETRANGE("GST Vendor Type", Vendor."GST Vendor Type"::Registered);
         Vendor.SETFILTER("No Of POs", '>%1', 0);
         Vendor.SETFILTER("E-Mail", '<>%1', ''); //added by vishnu
         Vendor.SETRANGE(Maintenacecommonmail, FALSE);
         IF Vendor.FINDSET THEN BEGIN
                                    REPEAT
                                        PurchaseHeader.RESET;
                                        PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
                                        PurchaseHeader.SETFILTER("Order Date", '>=%1', DMY2Date(04, 01, 19));
                                        PurchaseHeader.SETRANGE("Buy-from Vendor No.", Vendor."No.");
                                        IF PurchaseHeader.FINDFIRST THEN BEGIN
                                            CLEAR(Recipients);
                                            IF Vendor."E-Mail" <> '' THEN
                                                Recipients.Add(Vendor."E-Mail");
                                            IF (Recipients1 <> '') AND (FromMail <> '') THEN BEGIN
                                                // EmailMessage.Create('ERP', FromMail, ToMail, Subject, '', TRUE);

                                                Recipients.Add('purchaseaccounts@efftronics.com');
                                                //SMTP_MAIL.AddBCC('vishnupriya@efftronics.com');
                                                Body += ('Respected Sir/Madam,');
                                                Body += ('<BR><BR>');
                                                Body += ('Hope you all are fine ..your family & Staff  members also in safe position');
                                                Body += ('<BR><BR>');
                                                Body += ('As we all are know in this COVID-19 period , we need to face the all challenges(Raw material procurement and logistics) to sustain our business.');
                                                Body += ('<BR><BR>');
                                                Body += ('In this position , we are doing survey with our Suppliers. So please co-operate with us and fill this document and it is very helpful to plan our production');
                                                Body += ('<BR><BR>');
                                                Body += ('link');
                                                Body += ('<BR>');
                                                Body += ('Website :<a href="http://app.efftronics.org/vendorsurvey/App/Login"><b>app.efftronics.org/vendorsurvey/App/Login</b></a>');
                                                Body += ('<BR>');
                                                Body += ('Click this above link');
                                                Body += ('<BR>');
                                                Body += ('login with Your Company GST number');
                                                Body += ('<BR><BR>');
                                                Body += ('Thanking You.');
                                                Body += ('<BR><BR>');
                                                Body += ('Regards,');
                                                Body += ('<BR>');
                                                Body += ('Renuka.Ch');
                                                Body += ('<BR>');
                                                Body += ('Manager|ControlRoom (Planning & Purchase)');
                                                Body += ('<BR>');
                                                Body += ('EfftronicsSystems Pvt. Ltd.,');
                                                Body += ('<BR>');
                                                Body += ('40-15-9,Brundavan Colony,');
                                                Body += ('<BR>');
                                                Body += ('Vijayawada - 520010,');
                                                Body += ('<BR>');
                                                Body += ('Andhra Pradesh, India.');
                                                Body += ('<BR>');
                                                Body += ('Ph No : +91 866 2466699; Cell No : +91 7036666132');
                                                Body += ('<BR>');
                                                Body += ('Website :<a href="https://www.efftronics.com/"><b>www.efftronics.com</b></a>');
                                                Body += ('<BR>');
                                                EmailMessage.Create(Recipients, Subject, Body, true);
                                                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                                            END;
                                            Vendor.Maintenacecommonmail := TRUE;
                                            Vendor.MODIFY;
                                        END;
                                    UNTIL Vendor.NEXT = 0;
             MESSAGE('completed');
         END; */
    end;
    //.............................B2b UPG...................



    /*  local procedure TestMail();
      begin
          FromMail := 'purchase@efftronics.com';
          Subject := 'Reg: Efftronics Vendor Updates';
          ToMail := 'jagadeeshm@b2bsoftech.com';

          IF (ToMail <> '') AND (FromMail <> '') THEN BEGIN
              SMTPMail.CreateMessage('ERP', FromMail, ToMail, Subject, '', TRUE);

              SMTPMail.AppendBody('Dear Vendor,');
              SMTPMail.AppendBody('<BR><BR>');
              SMTPMail.AppendBody('<BR><BR>');
              SMTPMail.AppendBody('Greetings of the day. Thanks a lot for your continued support. We are concluding the financial statements for FY19-20.');
              SMTPMail.AppendBody('<BR>');
              SMTPMail.AppendBody('As per our books, all the payments to the vendors for FY19-20 are cleared. There are no pending payments related to the invoices raised in FY 19-20.');
              SMTPMail.AppendBody('<BR>');
              SMTPMail.AppendBody('Please send us statement of accounts for reconciliation. We also request your continuous support for the coming years.We also request you to upload the GST returns in timely manner.');
              SMTPMail.AppendBody('<BR>');
              SMTPMail.AppendBody('We also request you to inform us any challenges you are facing related to the pandemic or other external issues.Any  issues related');
              SMTPMail.AppendBody('<BR>');
              SMTPMail.AppendBody('to change in lead times,availability of raw material,obsolescence please inform us well in advance.');
              SMTPMail.AppendBody('<BR><BR>');
              SMTPMail.AppendBody('<BR><BR>');
              SMTPMail.AppendBody('Thanks a lot for your continuous Support.');
              SMTPMail.AppendBody('<BR><BR>');
              SMTPMail.AppendBody('<BR><BR>');
              SMTPMail.AppendBody('Regards,');
              SMTPMail.AppendBody('<BR>');
              SMTPMail.AppendBody('Anvesh Dasari');
              SMTPMail.AppendBody('<BR>');
              SMTPMail.AppendBody('Vice President');
              SMTPMail.AppendBody('<BR>');
              SMTPMail.AppendBody('Cell No :+919849051177');
              SMTPMail.AppendBody('<BR>');
              SMTPMail.AppendBody('EfftronicsSystems Pvt. Ltd.,');
              SMTPMail.AppendBody('<BR>');
              SMTPMail.AppendBody('40-15-9,Brundavan Colony,');
              SMTPMail.AppendBody('<BR>');
              SMTPMail.AppendBody('Vijayawada - 520010,');
              SMTPMail.AppendBody('<BR>');
              SMTPMail.AppendBody('Andhra Pradesh, India.');
              SMTPMail.AppendBody('<BR>');
              SMTPMail.AppendBody('Ph No : 0866-2483375');
              SMTPMail.AppendBody('<BR>');
              SMTPMail.AppendBody('Website :<a href="http://www.effe.in/"><b>www.effe.in,</b></a><a href="https://www.efftronics.com/"><b>www.efftronics.com</b></a>');
              SMTPMail.AppendBody('<BR>');
              SMTPMail.Send;
              MESSAGE('completed');
          END;
      end;*/




    local procedure TestMail();
    begin
        /*  // FromMail := 'purchase@efftronics.com';
         Subject := 'Reg: Efftronics Vendor Updates';
         Recipients1 := 'jagadeeshm@b2bsoftech.com';
         Recipients.Add('jagadeeshm@b2bsoftech.com');

         IF (Recipients1 <> '') AND (FromMail <> '') THEN BEGIN
             EmailMessage.Create(Recipients, Subject, Body, true);

             Body += ('Dear Vendor,');
             Body += ('<BR><BR>');
             Body += ('<BR><BR>');
             Body += ('Greetings of the day. Thanks a lot for your continued support. We are concluding the financial statements for FY19-20.');
             Body += ('<BR>');
             Body += ('As per our books, all the payments to the vendors for FY19-20 are cleared. There are no pending payments related to the invoices raised in FY 19-20.');
             Body += ('<BR>');
             Body += ('Please send us statement of accounts for reconciliation. We also request your continuous support for the coming years.We also request you to upload the GST returns in timely manner.');
             Body += ('<BR>');
             Body += ('We also request you to inform us any challenges you are facing related to the pandemic or other external issues.Any  issues related');
             Body += ('<BR>');
             Body += ('to change in lead times,availability of raw material,obsolescence please inform us well in advance.');
             Body += ('<BR><BR>');
             Body += ('<BR><BR>');
             Body += ('Thanks a lot for your continuous Support.');
             Body += ('<BR><BR>');
             Body += ('<BR><BR>');
             Body += ('Regards,');
             Body += ('<BR>');
             Body += ('Anvesh Dasari');
             Body += ('<BR>');
             Body += ('Vice President');
             Body += ('<BR>');
             Body += ('Cell No :+919849051177');
             Body += ('<BR>');
             Body += ('EfftronicsSystems Pvt. Ltd.,');
             Body += ('<BR>');
             Body += ('40-15-9,Brundavan Colony,');
             Body += ('<BR>');
             Body += ('Vijayawada - 520010,');
             Body += ('<BR>');
             Body += ('Andhra Pradesh, India.');
             Body += ('<BR>');
             Body += ('Ph No : 0866-2483375');
             Body += ('<BR>');
             Body += ('Website :<a href="http://www.effe.in/"><b>www.effe.in,</b></a><a href="https://www.efftronics.com/"><b>www.efftronics.com</b></a>');
             Body += ('<BR>');
             Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
             MESSAGE('completed');
         END; */
    end;

    //............B2BUPG..........................
    /* local procedure ContinuosSupportWithEfftronics();
     begin
         FromMail := 'purchase@efftronics.com';
         Subject := 'Reg: Efftronics Vendor Updates';

         Vendor.RESET;
         Vendor.SETRANGE("GST Vendor Type", Vendor."GST Vendor Type"::Registered);
         Vendor.SETFILTER("No Of POs", '>%1', 0);
         Vendor.SETRANGE(Maintenacecommonmail, FALSE);
         IF Vendor.FINDSET THEN BEGIN
             REPEAT
                 PurchaseHeader.RESET;
                 PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
                 PurchaseHeader.SETFILTER("Order Date", '>=%1', DMY2Date(04, 01, 19));
                 PurchaseHeader.SETRANGE("Buy-from Vendor No.", Vendor."No.");
                 IF PurchaseHeader.FINDFIRST THEN BEGIN
                     CLEAR(ToMail);
                     IF Vendor."E-Mail" <> '' THEN
                         ToMail := Vendor."E-Mail";
                     IF (ToMail <> '') AND (FromMail <> '') THEN BEGIN
                         SMTPMail.CreateMessage('ERP', FromMail, ToMail, Subject, '', TRUE);
                         SMTPMail.AddBCC('purchaseaccounts@efftronics.com');
                         SMTPMail.AppendBody('Dear Vendor,');
                         SMTPMail.AppendBody('<BR><BR>');
                         SMTPMail.AppendBody('<BR><BR>');
                         SMTPMail.AppendBody('Greetings of the day. Thanks a lot for your continued support. We are concluding the financial statements for FY19-20.');
                         SMTPMail.AppendBody('<BR>');
                         SMTPMail.AppendBody('As per our books, all the payments to the vendors for FY19-20 are cleared. There are no pending payments related to the invoices raised in FY 19-20.');
                         SMTPMail.AppendBody('<BR>');
                         SMTPMail.AppendBody('Please send us statement of accounts for reconciliation. We also request your continuous support for the coming years.We also request you to upload the GST returns in timely manner.');
                         SMTPMail.AppendBody('<BR>');
                         SMTPMail.AppendBody('We also request you to inform us any challenges you are facing related to the pandemic or other external issues.Any  issues related to change in lead times,');
                         SMTPMail.AppendBody('<BR>');
                         SMTPMail.AppendBody('availability of raw material,obsolescence please inform us well in advance.');
                         SMTPMail.AppendBody('<BR><BR>');
                         SMTPMail.AppendBody('<BR><BR>');
                         SMTPMail.AppendBody('Thanks a lot for your continuous Support.');
                         SMTPMail.AppendBody('<BR><BR>');
                         SMTPMail.AppendBody('<BR><BR>');
                         SMTPMail.AppendBody('Regards,');
                         SMTPMail.AppendBody('<BR>');
                         SMTPMail.AppendBody('Anvesh Dasari');
                         SMTPMail.AppendBody('<BR>');
                         SMTPMail.AppendBody('Vice President');
                         SMTPMail.AppendBody('<BR>');
                         SMTPMail.AppendBody('Cell No :+919849051177');
                         SMTPMail.AppendBody('<BR>');
                         SMTPMail.AppendBody('EfftronicsSystems Pvt. Ltd.,');
                         SMTPMail.AppendBody('<BR>');
                         SMTPMail.AppendBody('40-15-9,Brundavan Colony,');
                         SMTPMail.AppendBody('<BR>');
                         SMTPMail.AppendBody('Vijayawada - 520010,');
                         SMTPMail.AppendBody('<BR>');
                         SMTPMail.AppendBody('Andhra Pradesh, India.');
                         SMTPMail.AppendBody('<BR>');
                         SMTPMail.AppendBody('Ph No : 0866-2483375');
                         SMTPMail.AppendBody('<BR>');
                         SMTPMail.AppendBody('Website :<a href="http://www.effe.in/"><b>www.effe.in,</b></a><a href="https://www.efftronics.com/"><b>www.efftronics.com</b></a>');
                         SMTPMail.AppendBody('<BR>');
                         SMTPMail.Send;
                     END;
                     Vendor.Maintenacecommonmail := TRUE;
                     Vendor.MODIFY;
                 END;
             UNTIL Vendor.NEXT = 0;
             MESSAGE('completed');
         END;
     end;*/



    local procedure ContinuosSupportWithEfftronics();
    var

    begin
        /* FromMail := 'purchase@efftronics.com';
        Subject := 'Reg: Efftronics Vendor Updates';

        Vendor.RESET;
        Vendor.SETRANGE("GST Vendor Type", Vendor."GST Vendor Type"::Registered);
        Vendor.SETFILTER("No Of POs", '>%1', 0);
        Vendor.SETRANGE(Maintenacecommonmail, FALSE);
        IF Vendor.FINDSET THEN BEGIN
                                   REPEAT
                                       PurchaseHeader.RESET;
                                       PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
                                       PurchaseHeader.SETFILTER("Order Date", '>=%1', DMY2Date(04, 01, 19));
                                       PurchaseHeader.SETRANGE("Buy-from Vendor No.", Vendor."No.");
                                       IF PurchaseHeader.FINDFIRST THEN BEGIN
                                           CLEAR(Recipients1);
                                           IF Vendor."E-Mail" <> '' THEN
                                               // Recipients := Vendor."E-Mail";
                                               Recipients.Add(Vendor."E-Mail");
                                           IF (Recipients1 <> '') AND (FromMail <> '') THEN BEGIN

                                               Recipients.Add('purchaseaccounts@efftronics.com');
                                               Body += ('Dear Vendor,');
                                               Body += ('<BR><BR>');
                                               Body += ('<BR><BR>');
                                               Body += ('Greetings of the day. Thanks a lot for your continued support. We are concluding the financial statements for FY19-20.');
                                               Body += ('<BR>');
                                               Body += ('As per our books, all the payments to the vendors for FY19-20 are cleared. There are no pending payments related to the invoices raised in FY 19-20.');
                                               Body += ('<BR>');
                                               Body += ('Please send us statement of accounts for reconciliation. We also request your continuous support for the coming years.We also request you to upload the GST returns in timely manner.');
                                               Body += ('<BR>');
                                               Body += ('We also request you to inform us any challenges you are facing related to the pandemic or other external issues.Any  issues related to change in lead times,');
                                               Body += ('<BR>');
                                               Body += ('availability of raw material,obsolescence please inform us well in advance.');
                                               Body += ('<BR><BR>');
                                               Body += ('<BR><BR>');
                                               Body += ('Thanks a lot for your continuous Support.');
                                               Body += ('<BR><BR>');
                                               Body += ('<BR><BR>');
                                               Body += ('Regards,');
                                               Body += ('<BR>');
                                               Body += ('Anvesh Dasari');
                                               Body += ('<BR>');
                                               Body += ('Vice President');
                                               Body += ('<BR>');
                                               Body += ('Cell No :+919849051177');
                                               Body += ('<BR>');
                                               Body += ('EfftronicsSystems Pvt. Ltd.,');
                                               Body += ('<BR>');
                                               Body += ('40-15-9,Brundavan Colony,');
                                               Body += ('<BR>');
                                               Body += ('Vijayawada - 520010,');
                                               Body += ('<BR>');
                                               Body += ('Andhra Pradesh, India.');
                                               Body += ('<BR>');
                                               Body += ('Ph No : 0866-2483375');
                                               Body += ('<BR>');
                                               Body += ('Website :<a href="http://www.effe.in/"><b>www.effe.in,</b></a><a href="https://www.efftronics.com/"><b>www.efftronics.com</b></a>');
                                               Body += ('<BR>');
                                               EmailMessage.Create(Recipients, Subject, Body, true);
                                               Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

                                           END;
                                           Vendor.Maintenacecommonmail := TRUE;
                                           Vendor.MODIFY;
                                       END;
                                   UNTIL Vendor.NEXT = 0;
            MESSAGE('completed');
        END; */
    end;

    // B2B UPG >>>
    /*LOCAL PROCEDURE ContinuosSupportWithEfftronicsfrmmaheswari@1102152005();
    BEGIN

      FromMail := 'purchase@efftronics.com';
      Subject := 'Reg:Account Statement Required for Financial year 21-22(Apr-21 to Oct-21)';
      //names :='anilkumar@efftronics.com,renukach@efftronics.com,durgamaheswari@efftronics.com';
      //ToMail:=names;
      //ToMail:='durgamaheswari@efftronics.com';

      Vendor.RESET;
      //Vendor.SETRANGE("GST Vendor Type",Vendor."GST Vendor Type"::Registered);
      Vendor.SETFILTER("No Of POs",'>%1',0);
      //Vendor.SETFILTER("No.",'=%1','V00431');
      Vendor.SETRANGE("No.",'V05101','V05200');
      //Vendor.SETFILTER("E-Mail",'<>%1','');
      Vendor.SETRANGE(Maintenacecommonmail,FALSE);

      IF Vendor.FINDSET THEN BEGIN
        REPEAT

          CLEAR(ToMail);
          IF (Vendor."E-Mail" <> '') AND (Vendor."E-Mail" <> 'purchase@efftronics.com') THEN
            ToMail := Vendor."E-Mail";
           MESSAGE(ToMail);
           IF (ToMail <>'') AND (FromMail<>'')  THEN BEGIN

             SMTPMail.CreateMessage('ERP',FromMail,ToMail,Subject,'',TRUE);
             SMTPMail.AddCC('purchase@efftronics.com');
            // SMTPMail.AddBCC('erp@efftronics.com');
             SMTPMail.AppendBody('Dear Vendor,');
             SMTPMail.AppendBody('<BR><BR>');
            {
             SMTPMail.AppendBody('Thanks a lot for your continued support in the FY 20-21. We request you to continue your support in the financial year FY 21-22.');
             SMTPMail.AppendBody('<BR><BR>');
             SMTPMail.AppendBody('We are informing that FY 20-21, we cleared all the payments and we are closing accounts for FY 20-21.If any issues please revert back immediately.');
             SMTPMail.AppendBody('<BR><BR>');
            }
             SMTPMail.AppendBody(' Please provide Account statements for the period');
             SMTPMail.AppendBody('<b> Apr-21 to Oct-21.</b>');
             SMTPMail.AppendBody('<BR><BR>');
             //SMTPMail.AppendBody('<b> (Consignee and billing address is same)</b>');
            {
             SMTPMail.AppendBody('<BR><BR>');
             SMTPMail.AppendBody('2019-20<br>2020-21<br>');
             SMTPMail.AppendBody('<BR><BR>');

             SMTPMail.AppendBody('<b>Efftronics Systems (Pvt) Ltd</b>');
             SMTPMail.AppendBody('<BR>');
             SMTPMail.AppendBody('<b>Plot no 4, I.T. Park</b>');
             SMTPMail.AppendBody('<BR>');
             SMTPMail.AppendBody('<b>Mangalagiri 522503</b>');
             SMTPMail.AppendBody('<BR>');
             SMTPMail.AppendBody('<b>Phone number : 91 (8645) 666777</b>');
             SMTPMail.AppendBody('<BR>');
             SMTPMail.AppendBody('<b>Emailid: info@efftronics.com</b>');
             SMTPMail.AppendBody('<BR><BR>');
             }
             SMTPMail.AppendBody('Regards,<br>');
             SMTPMail.AppendBody('Renuka.ch<br>');
             SMTPMail.AppendBody('Manager|ControlRoom(Planning & Purchase)<br>');
             SMTPMail.AppendBody('Efftronics Systems Pvt. Ltd.<br>');
             SMTPMail.AppendBody('Phone: +91 866 2466699<br>');
             SMTPMail.AppendBody('Mobile: +91 7036666132<br>');
             SMTPMail.AppendBody('<a href="https://www.efftronics.com/">www.efftronics.com</a>');
             SMTPMail.Send;

           END;
           Vendor.Maintenacecommonmail := TRUE;

           Vendor.MODIFY

        UNTIL Vendor.NEXT = 0;
        MESSAGE('completed');
      END;
      {
      FromMail := 'durgamaheswari@efftronics.com';
      Subject := 'Reg: Efftronics Vendor Updates';
      ToMail := 'tpriyanka@efftronics.com';
      SMTPMail.CreateMessage('ERP',FromMail,ToMail,Subject,'',TRUE);
      SMTPMail.AppendBody('Dear Employees,');
      //SMTPMail.AppendBody('<BR><BR>');
      SMTPMail.AppendBody('<b>own premises in Mangalagiri from 5th April 2021.</b>');
      SMTPMail.AppendBody('<BR><BR>');
      SMTPMail.AppendBody('Greetings of the day. Thanks a lot for your continued support.');
      SMTPMail.Send;
      MESSAGE('completed');
       }
    END;*/
    //  B2B UPG <<<

    LOCAL PROCEDURE Efftronicsrepresentative();
    var

        VLE: Record "Vendor Ledger Entry";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Mail_Body: Text;

        ToMail: List of [Text];



    BEGIN
        FromMail := 'erp@efftronics.com';
        Subject := 'Efftronics company representative';
        //Tomail:= 'erp@efftronics.com';
        //ToMail:= 'anilkumar@efftronics.com';


        Vendor.RESET;
        Vendor.SETRANGE(Blocked, Vendor.Blocked::" ");
        Vendor.SETFILTER("No Of POs", '>%1', 0);
        IF Vendor.FINDSET THEN BEGIN
            REPEAT
                clear(ToMail);
                clear(Mail_Body);
                VLE.RESET;
                VLE.SETRANGE("Posting Date", Dmy2Date(01, 04, 2021), TODAY);
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                Vendor.SETRANGE("No.", 'V06401', 'V06691');
                IF VLE.FINDFIRST THEN BEGIN
                    CLEAR(ToMail);
                    IF (Vendor."E-Mail" <> '') AND (Vendor."E-Mail" <> 'purchase@efftronics.com') AND (Vendor."E-Mail" <> 'purchase1@efftronics.com') THEN
                        ToMail.add(Vendor."E-Mail");
                    MESSAGE('%1', ToMail);
                    //IF (ToMail <> '') AND (FromMail <> '') THEN BEGIN
                    //SMTPMail.CreateMessage('ERP', FromMail, ToMail, Subject, '', TRUE);
                  //  SMTPMail.AddCC('purchase@efftronics.com');
                    Mail_Body += 'Dear Supplier,';
                    //SMTPMail.AppendBody('<BR><BR>');
                    //SMTPMail.AppendBody('Greetings of the Day!!!');
                    Mail_Body += '<BR><BR>';
                    Mail_Body += 'I resigned to my job, today is my last working day in this organisation. Thank you so much for your valuable and excellent support in my 29 years journey in Efftronics systems Pvt. Ltd., .';
                    Mail_Body += '<BR><BR>';
                    Mail_Body += 'Please contact below for further communication. ';
                    Mail_Body += '<BR>';
                    Mail_Body += 'Ch.Renuka ';
                    Mail_Body += '<BR>';
                    Mail_Body += 'Contact no.: 7036666132';
                    Mail_Body += '<BR>';
                    Mail_Body += 'E-mail: purchase@efftronics.com ';
                    Mail_Body += '<BR><BR>';
                    Mail_Body += 'Regards,';
                    Mail_Body += '<BR>';
                    Mail_Body += '<b>Brahmaiah V</b>';
                    Mail_Body += '<BR>';
                    Mail_Body += '<b>Purchase Department</b>';
                    Mail_Body += '<BR>';
                    Mail_Body += '<b>Efftronics Systems Pvt. Ltd., </b>';
                    Mail_Body += '<BR>';
                    Mail_Body += 'Plot no 4, I.T. Park';
                    Mail_Body += '<BR>';
                    Mail_Body += 'Mangalagiri-522503';
                    Mail_Body += '<BR>';
                    Mail_Body += 'Phone number : 91 (8645) 666777';
                    Mail_Body += '<BR>';
                    Mail_Body += 'Mobile: 7036664791';
                    //SMTPMail.AppendBody('<BR><BR>');
                    EmailMessage.Create(ToMail, Subject, Mail_Body, true);

                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                    //SMTPMail.Send;
                END;
            //END;
            UNTIL Vendor.NEXT = 0;
            MESSAGE('Completed');
        END;
    END;









}

