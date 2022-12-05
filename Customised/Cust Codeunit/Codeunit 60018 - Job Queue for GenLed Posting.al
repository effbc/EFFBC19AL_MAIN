codeunit 60018 "Job Queue for GenLed Posting"
{
    // version B2BJM


    trigger OnRun();
    begin

        User.RESET;
        User.SETRANGE(Blocked, FALSE);
        IF User.FINDSET THEN
            REPEAT
                USER_SETUP.RESET;
                USER_SETUP.SETFILTER("User ID", User."User ID");
                IF USER_SETUP.FINDSET THEN
                    REPEAT
                        IF NOT (USER_SETUP."User ID" IN ['EFFTRONICS\RAJANI', 'EFFTRONICS\ASWINI', 'EFFTRONICS\YESU', 'EFFTRONICS\SUJITH', 'EFFTRONICS\BLAVANYA']) THEN BEGIN
                            USER_SETUP."Allow Posting To" := TODAY;
                            USER_SETUP.MODIFY;
                        END
                        ELSE
                            IF (USER_SETUP."User ID" IN ['EFFTRONICS\ASWINI', 'EFFTRONICS\BLAVANYA', 'EFFTRONICS\SUJITH']) THEN BEGIN
                                USER_SETUP."Allow Posting To" := CALCDATE('92D', TODAY);
                                USER_SETUP.MODIFY;
                            END
                            ELSE
                                IF (USER_SETUP."User ID" IN ['EFFTRONICS\RAJANI', 'EFFTRONICS\YESU', 'EFFTRONICS\MBNAGAMANI']) THEN BEGIN
                                    USER_SETUP."Allow Posting To" := CALCDATE('31D', TODAY);
                                    USER_SETUP.MODIFY;
                                END;
                    UNTIL USER_SETUP.NEXT = 0;
            UNTIL User.NEXT = 0;


        //Daily Mail Postings

        //dcMails.MailDC;


        //dcMails.MailDC;
        //GeneralLedgerSetup.Stock_Alert_On_Threshold;
        //GeneralLedgerSetup.Open_Orders_Allert;
        //GeneralLedgerSetup.RD_Mail_for_SalesOrders;
        GeneralLedgerSetup.CSIGCS_MAIL;
        GeneralLedgerSetup.IREPS_Tenders;
        GeneralLedgerSetup.BG_TEST_MAILS;
        //GeneralLedgerSetup.New_Vendor_Mail;
        //GeneralLedgerSetup.New_Customer_Mail;
        //GeneralLedgerSetup.Pending_PO;
        //GeneralLedgerSetup.Pending_QA;
        //GeneralLedgerSetup."E-Invoicing";
        //GeneralLedgerSetup.CreditNote_IRN;


        /*
        // MAIN STORES SHORTAGE MATERIAL AUTOMATIC REPORT
        //Item.CALCFIELDS(Item."Stock at PROD Stores");
        //Item.SETFILTER(Item."Safety Stock Quantity",'>%1',(Item."Stock at Stores"+Item."Stock at PROD Stores"));
        //Cs_Shortage_QTY:=Item.COUNT;
        Body += '****  Automatic Mail Generated From ERP  ****';
        //REPORT.RUN(33000892,FALSE,FALSE,Item);
        //"g/l setup".FINDFIRST;
        REPORT.SAVEASPDF(33000892, FORMAT('\\erpserver\ErpAttachments\' + 'STR Shortage' + '.PDF'));

        Mail_From := 'noreply@efftronics.com';
        //Mail_To:='Store@efftronics.com,Padmaja@efftronics.com,';
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
        END;
        // End of MAIN STORES SHORTAGE MATERIAL AUTOMATIC REPORT

        // temporarily commented by Vishnu Priya on 20-07-2019 as there is an error in the SMS Tables Triggers

        //REPORT.RUN(50023,FALSE,FALSE);
        //MESSAGE('hi');*/   //UPG

        Body += '****  Automatic Mail Generated From ERP  ****';
        REPORT.SAVEASPDF(33000892, FORMAT('\\erpserver\ErpAttachments\' + 'STR Shortage' + '.PDF'));

        Mail_From := 'noreply@efftronics.com';
        Recipients.Add('erp@efftronics.com');
        Subject := ' Shortage at Main Stores ';

        Attachment := '\\erpserver\ErpAttachments\' + 'STR Shortage.PDF';
        EmailMessage.Create(Recipients, Subject, Body, true);
        IF EXISTS(Attachment) THEN BEGIN
            //SMTP_MAIL.AddAttachment(Attachment, '');
            EmailMessage.AddAttachment(CompanyName, '', Attachment);
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        END;

    end;

    var
        User: Record "User Setup";
        USER_SETUP: Record "User Setup";
        dcMails: Page "DC List";
        GeneralLedgerSetup: Page "General Ledger Setup";
        Item: Record Item;
        Cs_Shortage_QTY: Integer;
        "g/l setup": Record "General Ledger Setup";
        Mail_From: Text;
        Mail_To: Text;
        Subject: Text;
        Attachment: Text;
        //SMTP_MAIL: Codeunit "SMTP Mail";
        Body: Text;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
}

