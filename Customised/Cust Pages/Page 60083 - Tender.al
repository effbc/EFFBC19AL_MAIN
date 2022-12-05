page 60083 Tender
{
    // version B2B1.0,SH1.0,Rev01

    // 
    //       SalesLine.VALIDATE("Tax Group Code",TenderLine."Tax Group Code");

    PageType = Document;
    SourceTable = "Tender Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Tender No."; Rec."Tender No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(Rec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(TenderType; Rec.TenderType)
                {
                    Caption = 'TenderType*';
                    ApplicationArea = All;
                }
                field(Product; Rec.Product)
                {
                    Caption = 'Product*';
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        // Added by Pranavi on 22-Jun-2016
                        IF Rec."Customer No." <> '' THEN BEGIN
                            CUST.RESET;
                            CUST.SETRANGE(CUST."No.", Rec."Customer No.");
                            IF CUST.FINDFIRST THEN
                                Rec."Salesperson Code" := CUST."Salesperson Code";
                            Rec."Tender Posting Group" := 'GENERAL';
                        END;
                        // End by Pranavi
                    end;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Customer Tender No."; Rec."Customer Tender No.")
                {
                    Caption = 'Customer Tender No.*';
                    ApplicationArea = All;
                }
                field("Tender Source"; Rec."Tender Source")
                {
                    ApplicationArea = All;
                }
                field("Tender Source Name"; Rec."Tender Source Name")
                {
                    ApplicationArea = All;
                }
                field("Tender Source Date"; Rec."Tender Source Date")
                {
                    Caption = 'Tender Source Date*';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Tender Position"; Rec."Tender Position")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF (Rec."Tender Position" = Rec."Tender Position"::L1) AND (Rec."Supporting Tender" = TRUE) THEN
                            ERROR('Tender postion must not be L1 for supporting tender');
                    end;
                }
                field("Tender Relese Date Time"; Rec."Tender Relese Date Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Tender Dated"; Rec."Tender Dated")
                {
                    ApplicationArea = All;
                }
                field("Tender Application No."; Rec."Tender Application No.")
                {
                    ApplicationArea = All;
                }
                field("Tender Document Cost"; Rec."Tender Document Cost")
                {
                    Caption = 'Tender Document Cost*';
                    ApplicationArea = All;
                }
                field("Tender doc Issue From"; Rec."Tender doc Issue From")
                {
                    ApplicationArea = All;
                }
                field("Tender doc Issue To"; Rec."Tender doc Issue To")
                {
                    ApplicationArea = All;
                }
                field("Supporting Tender"; Rec."Supporting Tender")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF (Rec."Tender Position" = Rec."Tender Position"::L1) AND (Rec."Supporting Tender" = TRUE) THEN
                            ERROR('Tender postion must not be L1 for supporting tender');
                    end;
                }
                field("Tender Doc Cost in form of"; Rec."Tender Doc Cost in form of")
                {
                    ApplicationArea = All;
                }
                field("Payable At"; Rec."Payable At")
                {
                    Caption = 'Payable At*';
                    ApplicationArea = All;
                }
                field("Expected Order month"; Rec."Expected Order month")
                {
                    ApplicationArea = All;
                }
                field("Blanket Order Created"; Rec."Blanket Order Created")
                {
                    Editable = Editable_Bool;
                    ApplicationArea = All;
                }
                field("Sales Order Created"; Rec."Sales Order Created")
                {
                    Editable = Editable_Bool;
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
            part(TenderLines; "Tender Subform")
            {
                SubPageLink = "Document No." = FIELD("Tender No.");
                ApplicationArea = All;

            }
            group(Customer)
            {
                Caption = 'Customer';
                field("<Customer Name2>"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Customer Name 2"; Rec."Customer Name 2")
                {
                    ApplicationArea = All;
                }
                field("Customer Address"; Rec."Customer Address")
                {
                    ApplicationArea = All;
                }
                field("Customer Address 2"; Rec."Customer Address 2")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Telex No."; Rec."Telex No.")
                {
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = All;
                }
                field("Customer Contact"; Rec."Customer Contact")
                {
                    ApplicationArea = All;
                }
                field(Territory; Rec.Territory)
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Caption = 'Salesperson Code*';
                    ApplicationArea = All;
                }
            }
            group("Bid Details")
            {
                Caption = 'Bid Details';
                field("Tender Quote Value"; Rec."Tender Quote Value")
                {
                    ApplicationArea = All;
                }
                field("Minimum Bid Amount"; Rec."Minimum Bid Amount")
                {
                    Caption = 'Minimum Bid Amount*';
                    ApplicationArea = All;
                }
                field("Quote %"; Rec."Quote %")
                {
                    ApplicationArea = All;
                }
                field("Submission Due Date"; Rec."Submission Due Date")
                {
                    ApplicationArea = All;
                }
                field("Submission Due Time"; Rec."Submission Due Time")
                {
                    ApplicationArea = All;
                }
                field("Tech. Bid Opening Date"; Rec."Tech. Bid Opening Date")
                {
                    ApplicationArea = All;
                }
                field("Tech. Bid Opening Time"; Rec."Tech. Bid Opening Time")
                {
                    ApplicationArea = All;
                }
                field("Tender Status"; Rec."Tender Status")
                {
                    Caption = 'Tender Status*';
                    Editable = RecEditable;
                    Enabled = RecEditable;
                    ApplicationArea = All;
                }
                field("Schedule A Percentage"; Rec."Schedule A Percentage")
                {
                    ApplicationArea = All;
                }
                field("Schedule B Percentage"; Rec."Schedule B Percentage")
                {
                    ApplicationArea = All;
                }
                field("Tender Posting Group"; Rec."Tender Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Not Participated"; Rec."Not Participated")
                {
                    ApplicationArea = All;
                }
                field("Tender Submitted Date"; Rec."Tender Submitted Date")
                {
                    ApplicationArea = All;
                }
                field("Tender Dispatch Details"; Rec."Tender Dispatch Details")
                {
                    ApplicationArea = All;
                }
                field("Document Position"; Rec."Document Position")
                {
                    ApplicationArea = All;
                }
                field("<Sales Order Created2>"; Rec."Sales Order Created")
                {
                    ApplicationArea = All;
                }
                field("Order Completion Period"; Rec."Order Completion Period")
                {
                    Caption = 'Order Completion Period - in Days';
                    ApplicationArea = All;
                }
                field("Schedule C Percentage"; Rec."Schedule C Percentage")
                {
                    ApplicationArea = All;
                }
            }
            group(EMD)
            {
                Caption = 'EMD';
                field("EMD Amount"; Rec."EMD Amount")
                {
                    Caption = 'EMD Amount*';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Rec."EMD Satus" = Rec."EMD Satus"::NA THEN
                            ERROR('EMD Status Should not be NA!');
                    end;
                }
                field("EMD Payment Date"; Rec."EMD Payment Date")
                {
                    ApplicationArea = All;
                }
                field("EMD Received Date"; Rec."EMD Received Date")
                {
                    ApplicationArea = All;
                }
                field("EMD Requested Date"; Rec."EMD Requested Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("EMD Required Date"; Rec."EMD Required Date")
                {
                    Caption = 'EMD Required Date*';
                    ApplicationArea = All;
                }
                field("InFavour of"; Rec."InFavour of")
                {
                    Caption = 'InFavour of*';
                    ApplicationArea = All;
                }
                field("EMD Mode of Payment"; Rec."EMD Mode of Payment")
                {
                    Caption = 'EMD Mode of Payment*';
                    ApplicationArea = All;
                }
                field("EMD DD No."; Rec."EMD DD No.")
                {
                    Caption = 'EMD DD/FDR No.*';
                    ApplicationArea = All;
                }
                field("EMD Expected Date"; Rec."EMD Expected Date")
                {
                    Caption = 'EMD Expected Return Date*';
                    ApplicationArea = All;
                }
                field("EMD Paid Amount"; Rec."EMD Paid Amount")
                {
                    ApplicationArea = All;
                }
                field("EMD Received Amount"; Rec."EMD Received Amount")
                {
                    ApplicationArea = All;
                }
                field("EMD Adjusted Amount"; Rec."EMD Adjusted Amount")
                {
                    ApplicationArea = All;
                }
                field("EMD Satus"; Rec."EMD Satus")
                {
                    Caption = 'EMD Status*';
                    ApplicationArea = All;
                }
                field("EMD Status"; Rec."EMD Status")
                {
                    Caption = 'EMD Status1';
                    ApplicationArea = All;
                }
                field("Released to Finance"; Rec."Released to Finance")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Released to Sales"; Rec."Released to Sales")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sent For Auth"; Rec."Sent For Auth")
                {
                    Caption = 'Sent For Authurization';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Security Deposit Amount"; Rec."Security Deposit Amount")
                {
                    Caption = 'Security Deposit Amount*';
                    ApplicationArea = All;
                }
                field("Security Mode of Payment"; Rec."Security Mode of Payment")
                {
                    ApplicationArea = All;
                }
            }
            group(Details)
            {
                Caption = 'Details';
                field("Standard/Customize"; Rec."Standard/Customize")
                {
                    ApplicationArea = All;
                }
                field("Doc. No. Occurrence"; Rec."Doc. No. Occurrence")
                {
                    ApplicationArea = All;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ApplicationArea = All;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = All;
                }
                field("No. of Sales Order"; Rec."No. of Sales Order")
                {
                    ApplicationArea = All;
                }
                field("No. of Posted Sales Order"; Rec."No. of Posted Sales Order")
                {
                    ApplicationArea = All;
                }
                field("Released to Design User ID"; Rec."Released to Design User ID")
                {
                    ApplicationArea = All;
                }
                field("Released to Design Date"; Rec."Released to Design Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action("Sc&hedule")
                {
                    Caption = 'Sc&hedule';
                    Image = Planning;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //CurrForm.TenderLines.FORM.ShowSchedule2;   b2b-eff
                        CurrPage.TenderLines.PAGE.ShowSchedule;
                    end;
                }
            }
            group("&Tender")
            {
                Caption = '&Tender';
                action("&Comments")
                {
                    Caption = '&Comments';
                    Image = Comment;
                    RunObject = Page "Tender Comments";
                    RunPageLink = "No." = FIELD("Tender No.");
                    ApplicationArea = All;

                }
                action("L&edger Entries")
                {
                    Caption = 'L&edger Entries';
                    Image = LedgerEntries;
                    Promoted = true;
                    RunObject = Page "Tender Ledger Entries";
                    RunPageLink = "Tender No." = FIELD("Tender No.");
                    ApplicationArea = All;
                }
                separator(Action1102152176)
                {
                }
                action("Tender Posting Lines")
                {
                    Caption = 'Tender Posting Lines';
                    Image = PostBatch;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        TESTFIELD("Supporting Tender", FALSE);
                        TESTFIELD(Status, Status::Release);
                        TESTFIELD("Tender No.");
                        TESTFIELD("Tender Posting Group");
                        TESTFIELD("Customer No.");
                        TenderPostingLines.SETRANGE("Tender No.", "Tender No.");
                        TenderPostingLines.SETRANGE("Tender Posting Group", "Tender Posting Group");
                        PAGE.RUN(60097, TenderPostingLines);
                    end;
                }
                separator(Action1102152023)
                {
                }
                action("Ch&eck List")
                {
                    Caption = 'Ch&eck List';
                    Image = CheckList;
                    RunObject = Page "Check List";
                    RunPageLink = "Document Type" = CONST(Tender), "Document No." = FIELD("Tender No.");
                    ApplicationArea = All;
                }
                action("&Design Check List")
                {
                    Caption = '&Design Check List';
                    Image = Design;
                    Promoted = true;
                    RunObject = Page "Design Check List";
                    RunPageLink = "Tender No." = FIELD("Tender No.");
                    ApplicationArea = All;
                }
                separator(Action1102152026)
                {
                }
                action("&Tender Competitor's Details")
                {
                    Caption = '&Tender Competitor''s Details';
                    Image = ViewDetails;
                    RunObject = Page "Tender Competitor's Details";
                    RunPageLink = "Tender No." = FIELD("Tender No.");
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {

            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Attachments")
                {
                    Caption = '&Attachments';
                    Image = Attachments;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        TenderAttachments;
                    end;
                }
                action("&Archive Tenders")
                {
                    Caption = '&Archive Tenders';
                    Image = Archive;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Tender."ArichiveTender Document"(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                separator(Action1102152160)
                {
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit Tender;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        /*IF ISCLEAR(MAPIHandler) THEN
                          CREATE(MAPIHandler);
                        IF user.GET(user."User ID") THEN
                        eroorno:=0;
                        MAPIHandler.ToName := 'anilkumar@efftronics.net';
                        MAPIHandler.ToName := 'chowdary@efftronics.net';
                        MAPIHandler.ToName := 'jhansi@efftronics.net';
                        MAPIHandler.ToName := 'anulatha@efftronics.net';
                        MAPIHandler.ToName := 'sganesh@efftronics.net';
                        MAPIHandler.ToName := 'dir@efftronics.net';
                        MAPIHandler.ToName := 'prasanthi@efftronics.net';
                        MAPIHandler.CCName := 'anilkumar@efftronics.net';
                        MAPIHandler.Subject := xRec."Tender No."+'Tender Relesed';
                        //OpenNewMessage('anilkumar@efftronics.net');
                        //NewMessage('anilkumar@efftronics','swarupa@efftronics.net','hai','body','attachment',TRUE);
                        MAPIHandler.AddBodyText('Tender no in ERP'+ xRec."Tender No."+',');
                        MAPIHandler.AddBodyText(xRec."Customer Name"+' is Relesed');
                        MAPIHandler.Send;
                        eroorno:=MAPIHandler.ErrorStatus;*/

                        SCHEDULEOMS.SETFILTER(SCHEDULEOMS."No.", "Tender No.");
                        IF SCHEDULEOMS.FIND('-') THEN
                            REPEAT
                                IF SCHEDULEOMS.Type = SCHEDULEOMS.Type::Item THEN BEGIN
                                    IF SCHEDULEOMS."No." = '' THEN
                                        ERROR('salese line ' + FORMAT(SCHEDULEOMS."Document Line No.") + 'Schedules Must have  Item Numbers')
                                    ELSE
                                        IF SCHEDULEOMS."No." <> '' THEN
                                            IF FORMAT(SCHEDULEOMS.Quantity) = '' THEN
                                                ERROR('Sales line ' + FORMAT(SCHEDULEOMS."Document Line No.") + 'Schedule Must have  Item Number');
                                END;
                            UNTIL SCHEDULEOMS.NEXT = 0;

                        IF FORMAT("Expected Order month") = '' THEN
                            ERROR('PLEASE ENTER EXPECTED ORDER MONTH IN SALES HEADER');

                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        ReleaseTender: Codeunit Tender;
                    begin
                        ReleaseTender.ReopenTender(Rec);
                    end;
                }
                separator(Action1102152095)
                {
                }
                action("Update Quote%")
                {
                    Caption = 'Update Quote%';
                    Image = UpdateDescription;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CALCFIELDS("Tender Quote Value");
                        //"Quote %" := (("Minimum Bid Amount"-"Tender Quote Value") / "Minimum Bid Amount")* 100;
                        "Quote %" := (("Tender Quote Value" - "Minimum Bid Amount") / "Minimum Bid Amount") * 100;
                        MODIFY;
                    end;
                }
                separator(Action1000000004)
                {
                }
                action("Release To Finance")
                {
                    Caption = 'Release To Finance';
                    Image = CreateFinanceChargememo;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        Text01: Label 'Do You want to Send the Tender Document to Finance?';
                    begin
                        IF "Tender Relese Date Time" <> 0DT THEN                                //sreenivas
                        BEGIN
                            IF NOT CONFIRM(Text01, FALSE) THEN
                                EXIT;
                            //  TESTFIELD("Document Position","Document Position"::Design);
                            //"Document Position" := "Document Position"::CRM;
                            //TESTFIELD("Released to Finance","Released to Finance"::"0");
                            "Released to Finance" := TRUE;
                            "EMD Requested Date" := TODAY;
                            MODIFY;
                            Mail_Body := '';
                            charline := 10;
                            Mail_Subject := 'ERP- Tender Released to Finance for EMD';
                            Mail_Body += 'TENDER RELEASED FOR EMD';
                            Mail_Body += FORMAT(charline);
                            Mail_Body += FORMAT(charline);
                            Mail_Body += 'Tender No              : ' + "Tender No.";
                            Mail_Body += FORMAT(charline);
                            Mail_Body += 'Customer Name          : ' + FORMAT("Customer Name");
                            Mail_Body += FORMAT(charline);
                            IF "EMD Amount" = 0 THEN
                                ERROR('Enter EMD Amount');
                            Mail_Body += 'EMD Value              : ' + FORMAT(ROUND("EMD Amount", 1));
                            Mail_Body += FORMAT(charline);
                            IF ("Minimum Bid Amount" = 0) AND ("Minimum Bid Amount" < "EMD Amount") THEN
                                ERROR('Please Enter Minimun Bid Amount')
                            ELSE
                                Mail_Body += 'BID Amount             : ' + FORMAT(ROUND("Minimum Bid Amount", 1));
                            Mail_Body += FORMAT(charline);
                            IF "Product Type" = '' THEN
                                ERROR('Please Enter Product Type');
                            Mail_Body += 'Product Type           : ' + FORMAT(Product);
                            Mail_Body += FORMAT(charline);
                            IF ("EMD Requested Date" = 0D) THEN
                                ERROR('Please Enter the Requested Date');
                            Mail_Body += 'EMD Requested Date     : ' + FORMAT((TODAY), 0, 4);
                            Mail_Body += FORMAT(charline);
                            IF ("EMD Required Date" = 0D) THEN
                                ERROR('Please Enter the EMD Required Date');
                            IF ("EMD Required Date" < TODAY) THEN
                                ERROR('Required date must be greater than Till date');
                            Mail_Body += 'EMD Required Date      : ' + FORMAT(("EMD Required Date"), 0, 4);
                            Mail_Body += FORMAT(charline);
                            IF ("Tech. Bid Opening Date" = 0D) THEN
                                ERROR('Please Enter BID Opening Date');
                            Mail_Body += 'BID Opening Date       : ' + FORMAT(("Tech. Bid Opening Date"), 0, 4);
                            Mail_Body += FORMAT(charline);
                            CUST.SETRANGE(CUST."No.", "Customer No.");
                            IF CUST.FINDFIRST THEN
                                IF CUST."Salesperson Code" = '' THEN
                                    ERROR('Enter Sales Person Code in Customer Card')
                                ELSE
                                    "Mail-Id".SETRANGE("Mail-Id"."User ID", CUST."Salesperson Code");
                            IF "Mail-Id".FINDFIRST THEN
                                Mail_Body += 'Sales Excecutive       : ' + FORMAT("Mail-Id"."User ID");
                            Mail_Body += FORMAT(charline);
                            Mail_Body += FORMAT(charline);
                            Mail_Body += '***** Auto Mail Generated From ERP *****';
                            "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                            IF "Mail-Id".FINDFIRST THEN
                                "from Mail" := "Mail-Id".MailID;
                            //"to mail" := 'dir@efftronics.net,ravi@efftronics.com,samba@efftronics.com,cvmohan@efftronics.net,anilkumar@efftronics.net,';
                            Recipients.Add('dir@efftronics.net');
                            Recipients.Add('ravi@efftronics.com');

                            Recipients.add('cvmohan@efftronics.net');
                            Recipients.Add('anilkumar@efftronics.net');
                            Recipients.Add('renukach@efftronics.net');
                            Recipients.Add('baji@efftronics.com');
                            Recipients.Add('anuradhag@efftronics.com,');
                            Recipients.Add('anulatha@efftronics.com');
                            Recipients.Add('milind@efftronics.com');
                            Recipients.Add('srasc@efftronics.com');
                            Recipients.Add('mohang@efftronics.com');
                            Recipients.Add('sganesh@efftronics.com');
                            Recipients.Add(' rajani@efftronics.com');
                            Recipients.Add('dsr@efftronics.com');
                            Recipients.Add('sunil@efftronics.com');
                            Recipients.Add('samba@efftronics.com');
                            //B2BUPG
                            MODIFY;
                        END;
                        // IF ( "from Mail"<>'') AND ("to mail"<>'') THEN
                        // mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');
                        //END ELSE                                                         //sreenivas
                        //ERROR('you need to First Release the Tender');
                    end;
                }
                action("Release To Design")
                {
                    Caption = 'Release To Design';
                    Image = DesignCodeBehind;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        TESTFIELD(Status, Status::Open);
                        IF NOT CONFIRM(Text009, FALSE) THEN
                            EXIT;
                        IF ("Document Position" = "Document Position"::CRM) OR ("Document Position" = "Document Position"::Design) THEN BEGIN
                            "Document Position" := "Document Position"::Finance;
                            "Released to Design User ID" := USERID;
                            "Released to Design Date" := WORKDATE;
                            Mail_Subject := 'ERP- Tender Released to Design';
                            Mail_Body += 'TENDER TO DESIGN :';
                            Mail_Body += FORMAT(charline);
                            Mail_Body += 'Tender No.    : ' + "Tender No.";
                            Mail_Body += FORMAT(charline);
                            Mail_Body += 'Customer Name : ' + "Customer Name";
                            Mail_Body += FORMAT(charline);
                            Mail_Body += FORMAT(charline);
                            Mail_Body += '***** Auto mail Generated From ERP *****';
                            "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                            IF "Mail-Id".FINDFIRST THEN
                                "from Mail" := "Mail-Id".MailID;
                            //"to mail" := 'jhansi@efftronics.net,sal@efftronics.net,erp@efftronics.net,cvmohan@efftronics.net,renukach@efftronics.net,';
                            // "to mail" += 'phani@efftronics.net';
                            Recipients.Add('jhansi@efftronics.net');
                            Recipients.Add('sal@efftronics.net');
                            Recipients.Add('erp@efftronics.net');
                            Recipients.Add('cvmohan@efftronics.net');
                            Recipients.Add('renukach@efftronics.net');
                            //B2BUPG

                            MODIFY;
                            IF ("from Mail" <> '') AND ("to mail" <> '') THEN
                                // mail.NewCDOMessage("from Mail", "to mail", Mail_Subject, Mail_Body, '');
                                EmailMessage.Create(Recipients, Mail_Subject, Mail_Body, false);
                            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                            MESSAGE(Text012);
                        END;
                        /*MakeToBlanketOrder;
                        IF ISCLEAR(MAPIHandler) THEN
                          CREATE(MAPIHandler);
                        IF user.GET(user."User ID") THEN
                        eroorno:=0;
                        MAPIHandler.ToName := 'anilkumar@efftronics.net';
                        //MAPIHandler.ToName := 'chowdary@efftronics.net';
                        MAPIHandler.ToName := 'jhansi@efftronics.net';
                        MAPIHandler.ToName := 'dir@efftronics.net';
                        MAPIHandler.ToName := 'anulatha@efftronics.net';
                        //MAPIHandler.ToName := 'sganesh@efftronics.net';
                        //MAPIHandler.ToName := 'prasanthi@efftronics.net';
                        MAPIHandler.CCName := 'anilkumar@efftronics.net';
                        MAPIHandler.Subject := xRec."Tender No."+'Tender Relesed to Design';
                        //OpenNewMessage('anilkumar@efftronics.net');
                        //NewMessage('anilkumar@efftronics','swarupa@efftronics.net','hai','body','attachment',TRUE);
                        MAPIHandler.AddBodyText('Tender no in ERP'+ xRec."Tender No."+',');
                        MAPIHandler.AddBodyText(xRec."Customer Name"+' is Move to Design ');
                        MAPIHandler.Send;
                        eroorno:=MAPIHandler.ErrorStatus;*/

                    end;
                }
                action("Emd print")
                {
                    Caption = 'Emd print';
                    Image = ConfirmAndPrint;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        tenders.SETFILTER(tenders."Tender No.", "Tender No.");
                        REPORT.RUN(50100, TRUE, FALSE, tenders);
                    end;
                }
                action("Send For Authorization")
                {
                    Caption = 'Send For Authorization';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        SQLQuery: Text[1000];
                        RowCount: Integer;
                        ConnectionOpen: Integer;
                        //>> ORACLE UPG
                        /*  SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
                         RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset"; */
                        //<< ORACLE UPG
                        EMD_ID: Code[10];
                        EMDAmount: BigInteger;
                        TenderId: Code[10];
                        PlanChangeId: Code[10];
                        Inserted: Boolean;
                    begin
                        //>> ORACLE UPG
                        /*
                        // Added by Pranavi on 16-may-2015
                        MESSAGE('Send for Authorization!');
                        //Initialization start
                        IF "EMD Satus" <> "EMD Satus"::NA THEN BEGIN
                            IF "Sent For Auth" THEN
                                ERROR('You Have Already Sent for Authorization!');
                            IF CONFIRM('Do You Want To Send For Authorization?') = FALSE THEN
                                EXIT;
                            RowCount := 0;
                            PlanChangeId := '';
                            SQLQuery := '';
                            Inserted := FALSE;

                            //Initializations end

                            //  IF ISCLEAR(SQLConnection) THEN
                            //      CREATE(SQLConnection, FALSE, TRUE);

                            //  IF ISCLEAR(RecordSet) THEN
                            //      CREATE(RecordSet, FALSE, TRUE);

                            IF ConnectionOpen <> 1 THEN BEGIN
                                SQLConnection.ConnectionString := 'DSN=CASHFLOW;UID=cashflowuser;PASSWORD=firewall123;SERVER=oracle_80;';
                                SQLConnection.Open;
                                SQLConnection.BeginTrans;
                                ConnectionOpen := 1;
                            END;

                            SQLQuery := 'SELECT MAX(TENDER_ID) TENDER_ID FROM MRP_TENDER WHERE ERP_TENDER_NO = ''' + "Tender No." + '''';
                            RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
                            IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                                RecordSet.MoveFirst;

                            WHILE NOT RecordSet.EOF DO BEGIN
                                TenderId := FORMAT(RecordSet.Fields.Item('TENDER_ID').Value);
                                RowCount := RowCount + 1;
                                RecordSet.MoveNext;
                            END;
                            SQLQuery := 'SELECT * FROM MRP_EMD WHERE TENDER_ID = (SELECT MAX(TENDER_ID) TENDER_ID FROM MRP_TENDER WHERE ERP_TENDER_NO = ''' + "Tender No." + ''')';
                            //MESSAGE(SQLQuery);
                            RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
                            IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                                RecordSet.MoveFirst;

                            WHILE NOT RecordSet.EOF DO BEGIN
                                EMD_ID := FORMAT(RecordSet.Fields.Item('EMD_ID').Value);
                                RowCount := RowCount + 1;
                                RecordSet.MoveNext;
                            END;
                            EMDAmount := ROUND("EMD Amount", 1);
                            IF EMD_ID <> '' THEN BEGIN
                                SQLQuery := 'SELECT * FROM MRP_EMD_OUTFLOW_PLAN_CHANGES WHERE  EMD_ID = ' + EMD_ID + ' AND TENDOR_ID = ' + TenderId + ' AND ' +
                                            'PAYMENT_REALIZE_DATE =  to_date(''' + FORMAT(TODAY, 0, '<Day>-<Month Text,3>-<Year4>') + ''',''dd-mon-yyyy'')';
                                //MESSAGE(SQLQuery);
                                RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
                                IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                                    RecordSet.MoveFirst;
                                WHILE NOT RecordSet.EOF DO BEGIN
                                    PlanChangeId := FORMAT(RecordSet.Fields.Item('PLAN_CHANGE_ID').Value);
                                    RowCount := RowCount + 1;
                                    RecordSet.MoveNext;
                                END;
                                //MESSAGE(FORMAT('plan  change id:'+PlanChangeId));
                                IF PlanChangeId = '' THEN BEGIN
                                    SQLQuery := 'INSERT INTO MRP_EMD_OUTFLOW_PLAN_CHANGES (PLAN_CHANGE_ID,EMD_ID,TENDOR_ID,PLANNED_AMOUNT,PAYMENT_REALIZE_DATE,REMARKS,' +
                                                'CREATION_DATE,USERID,SL_NO,PAYMENT_ID,BASEPLAN,SPLITEDFROM) ' +
                                                'VALUES((SELECT NVL(MAX(PLAN_CHANGE_ID),0)+1 FROM MRP_EMD_OUTFLOW_PLAN_CHANGES), ' +
                                                EMD_ID + ', ' + TenderId + ', ' + FORMAT(EMDAmount) + ', to_date(''' + FORMAT(TODAY, 0, '<Day>-<Month Text,3>-<Year4>') + ''',''dd-mon-yyyy''), '''', ' +
                                                'SYSDATE, ''Auto'', 1,'''','''','''')';
                                    //MESSAGE(SQLQuery);
                                    SQLConnection.Execute(SQLQuery);
                                    Inserted := TRUE;
                                END
                                ELSE
                                    ERROR('You have already sent the EMD amount for Authorization!');
                            END
                            ELSE
                                ERROR('EMD not created in CashFlow.\Please release the tender to create EMD in Cashflow!');

                            IF Inserted THEN BEGIN
                                "Sent For Auth" := TRUE;
                                MODIFY;

                                SQLConnection.CommitTrans;
                                RecordSet.Close;
                                SQLConnection.Close;
                                ConnectionOpen := 0;
                            END;
                            MESSAGE('EMD amount sent for authorization in CashFlow!');
                        END;
                        // end by Pranavi
                        */
                        //<< ORACLE UPG
                    end;
                }
            }
            group("&Make To")
            {
                Caption = '&Make To';
                action("Make to &Quote")
                {
                    Caption = 'Make to &Quote';
                    Image = MakeAgreement;
                    Promoted = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        SalesHeader: Record "Sales Header";
                        SalesLine: Record "Sales Line";
                        SRSetup: Record "Sales & Receivables Setup";
                        Cust: Record Customer;
                        TenderLine: Record "Tender Line";
                        Text000: Label 'Do you want to convert the Tender to Quote?';
                        Text001: Label 'Tender %1 has been changed to Quote %2';
                    begin
                        TESTFIELD("Customer No.");
                        IF NOT CONFIRM(Text000, FALSE) THEN
                            EXIT;
                        SalesHeader.INIT;
                        SalesHeader."Document Type" := SalesHeader."Document Type"::Quote;
                        SRSetup.GET;
                        SalesHeader."No." := NoSeriesMgt.GetNextNo(SRSetup."Quote Nos.", WORKDATE, TRUE);
                        Cust.GET("Customer No.");
                        Cust.CheckBlockedCustOnDocs(Cust, SalesHeader."Document Type"::Quote, TRUE, FALSE);
                        SalesHeader."Sell-to Customer No." := "Customer No.";
                        SalesHeader.VALIDATE(SalesHeader."Sell-to Customer No.");
                        SalesHeader."Tender No." := "Tender No.";
                        SalesHeader.INSERT;

                        TenderLine.SETRANGE("Document No.", "Tender No.");
                        IF TenderLine.FINDSET THEN
                            REPEAT
                                SalesLine.INIT;
                                SalesLine."Document Type" := SalesLine."Document Type"::Quote;
                                SalesLine."Document No." := SalesHeader."No.";
                                SalesLine."Line No." := SalesLine."Line No." + 10000;
                                SalesLine."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                                IF TenderLine.Type = 1 THEN BEGIN
                                    SalesLine.Type := "Sales Line Type".FromInteger(1);
                                    SalesLine.Description := TenderLine.Description;
                                    SalesLine."Description 2" := TenderLine."Description 2";
                                END;
                                IF TenderLine.Type = TenderLine.Type::Item THEN BEGIN
                                    SalesLine.Type := SalesLine.Type::Item;
                                END;
                                IF TenderLine.Type = TenderLine.Type::Resource THEN BEGIN
                                    SalesLine.Type := SalesLine.Type::Resource;
                                END;
                                IF TenderLine.Type = TenderLine.Type::"G/L Account" THEN BEGIN
                                    SalesLine.Type := SalesLine.Type::"G/L Account";
                                END;
                                SalesLine."No." := TenderLine."No.";
                                SalesLine.VALIDATE(SalesLine."No.");
                                SalesLine.Quantity := TenderLine.Quantity;
                                SalesLine.VALIDATE(SalesLine.Quantity);
                                SalesLine.INSERT;
                            UNTIL TenderLine.NEXT = 0;

                        MESSAGE(Text001, "Tender No.", SalesHeader."No.");
                    end;
                }
                action("Make to &Order")
                {
                    Caption = 'Make to &Order';
                    Image = MakeOrder;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        IF "Tender Status" IN ["Tender Status"::Cancelled, "Tender Status"::Unsuccessfull, "Tender Status"::"Not Participated"] THEN
                            ERROR('You cannot make to order as tender status is ' + FORMAT("Tender Status"));     // Added by Pranavi on 18-May-2016

                        IF "EMD Satus" <> "EMD Satus"::NA THEN BEGIN
                            IF ("EMD Amount" = 0) OR (FORMAT("EMD Amount") = '') THEN
                                ERROR('Please enter EMD Amount!');
                            IF ("EMD Mode of Payment" = "EMD Mode of Payment"::FDR) AND ("EMD DD No." = '') THEN
                                ERROR('Please enter EMD FDR No.!')
                            ELSE
                                IF ("EMD Mode of Payment" = "EMD Mode of Payment"::DD) AND ("EMD DD No." = '') THEN
                                    ERROR('Please enter EMD DD No.!');
                        END;
                        IF ("Security Deposit Amount" = 0) OR (FORMAT("Security Deposit Amount") = '') THEN
                            ERROR('Please enter SD Amount!');

                        IF TenderType <> TenderType::AMC THEN
                            ERROR('You Can not Make Sale Order Directly! Please make Expected Order!');
                        IF TenderType <> TenderType::AMC THEN BEGIN
                            TL.RESET;
                            TL.SETFILTER(TL."Document No.", "Tender No.");
                            IF NOT TL.FINDSET THEN
                                ERROR('Please enter Tender Lines!');
                        END;
                        IF "EMD Satus" <> "EMD Satus"::NA THEN BEGIN
                            EMDPaidStatus := CheckEMDStatus;
                            IF EMDPaidStatus = '' THEN
                                IF NOT CONFIRM(Text014, FALSE) THEN
                                    EXIT;
                        END;
                        MaketoOrder;
                        IF "EMD Satus" <> "EMD Satus"::NA THEN
                            EMDStatusUpdate;    // Added by Pranavi on 18-May-2016

                        /*
                        IF ISCLEAR(MAPIHandler) THEN
                          CREATE(MAPIHandler);
                        IF user.GET(user."User ID") THEN
                        eroorno:=0;
                        MAPIHandler.ToName := 'anilkumar@efftronics.com';
                        MAPIHandler.ToName := 'chowdary@efftronics.com';
                        MAPIHandler.ToName := 'jhansi@efftronics.com';
                        MAPIHandler.ToName := 'dir@efftronics.com';
                        MAPIHandler.ToName := 'sganesh@efftronics.com';
                        MAPIHandler.ToName := 'anulatha@efftronics.com';
                        MAPIHandler.ToName := 'prasanthi@efftronics.com';
                        MAPIHandler.CCName := 'anilkumar@efftronics.com';
                        MAPIHandler.Subject := xRec."Tender No."+'Tender Relesed to Order';
                        //OpenNewMessage('anilkumar@efftronics.com');
                        //NewMessage('anilkumar@efftronics','swarupa@efftronics.com','hai','body','attachment',TRUE);
                        MAPIHandler.AddBodyText('Tender no in ERP'+ xRec."Tender No."+',');
                        MAPIHandler.AddBodyText(xRec."Customer Name"+' is Move To Order');
                        MAPIHandler.Send;
                        eroorno:=MAPIHandler.ErrorStatus;
                        */

                    end;
                }
                action("Make to Blanket Order")
                {
                    Caption = 'Make to Blanket Order';
                    Image = BlanketOrder;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin

                        IF "Tender Status" IN ["Tender Status"::Cancelled, "Tender Status"::Unsuccessfull, "Tender Status"::"Not Participated"] THEN
                            ERROR('You cannot make to Blanket order as tender status is ' + FORMAT("Tender Status"));   // Added by Pranavi on 18-May-2016
                        IF TenderType <> TenderType::AMC THEN BEGIN
                            TL.RESET;
                            TL.SETFILTER(TL."Document No.", "Tender No.");
                            IF NOT TL.FINDSET THEN
                                ERROR('Please enter Tender Lines!');
                        END;
                        IF "EMD Satus" <> "EMD Satus"::NA THEN BEGIN
                            IF ("EMD Amount" = 0) OR (FORMAT("EMD Amount") = '') THEN
                                ERROR('Please enter EMD Amount!');
                            IF ("EMD Mode of Payment" = "EMD Mode of Payment"::FDR) AND ("EMD DD No." = '') THEN
                                ERROR('Please enter EMD FDR No.!')
                            ELSE
                                IF ("EMD Mode of Payment" = "EMD Mode of Payment"::DD) AND ("EMD DD No." = '') THEN
                                    ERROR('Please enter EMD DD No.!');
                        END;
                        IF ("Security Deposit Amount" = 0) OR (FORMAT("Security Deposit Amount") = '') THEN
                            ERROR('Please enter SD Amount!');

                        IF "EMD Satus" <> "EMD Satus"::NA THEN BEGIN
                            EMDPaidStatus := CheckEMDStatus;
                            IF EMDPaidStatus = '' THEN
                                IF NOT CONFIRM(Text014, FALSE) THEN
                                    EXIT;
                        END;

                        MakeToBlanketOrder;
                        IF "EMD Satus" <> "EMD Satus"::NA THEN
                            EMDStatusUpdate;    // Added by Pranavi on 18-May-2016

                        /*
                        IF ISCLEAR(MAPIHandler) THEN
                          CREATE(MAPIHandler);
                        IF user.GET(user."User ID") THEN
                        eroorno:=0;
                        MAPIHandler.ToName := 'anilkumar@efftronics.net';
                        MAPIHandler.ToName := 'chowdary@efftronics.net';
                        MAPIHandler.ToName := 'jhansi@efftronics.net';
                        MAPIHandler.ToName := 'dir@efftronics.net';
                        MAPIHandler.ToName := 'anulatha@efftronics.net';
                        MAPIHandler.ToName := 'sganesh@efftronics.net';
                        MAPIHandler.ToName := 'prasanthi@efftronics.net';
                        MAPIHandler.CCName := 'anilkumar@efftronics.net';
                        MAPIHandler.Subject := xRec."Tender No."+'Tender Relesed to Blanket Order';
                        //OpenNewMessage('anilkumar@efftronics.net');
                        //NewMessage('anilkumar@efftronics','swarupa@efftronics.net','hai','body','attachment',TRUE);
                        MAPIHandler.AddBodyText('Tender no in ERP'+ xRec."Tender No."+',');
                        MAPIHandler.AddBodyText(xRec."Customer Name"+' is Move to Blanket Order ');
                        MAPIHandler.Send;
                        eroorno:=MAPIHandler.ErrorStatus;
                        */

                    end;
                }
                action("Cancel/Close Tender")
                {
                    Caption = 'Cancel/Close Tender';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        EMD_ID: Code[10];
                        Selection: Integer;
                        SQLQuery: Text[1000];
                        RowCount: Integer;
                        ConnectionOpen: Integer;
                        //>> ORACLE UPG
                        /*  SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
                         RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset"; */
                        //<< ORACLE UPG
                        TenderId: Code[10];
                        EMDAmount: BigInteger;
                        OutFlwPaymentId: Code[10];
                        InFlwPlanChngId: Code[10];
                    begin
                        // Added by Pranavi on 17-May-2016 for tender cancellation integration
                        /*
                        IF "Sales Order Created" = TRUE THEN
                        ERROR('You cannot cancel tender as Sale order created for this tender!');
                    IF "Blanket Order Created" = TRUE THEN
                        ERROR('You cannot cancel tender as Blanket order created for this tender!');
                    IF "Tender Status" IN ["Tender Status"::Cancelled, "Tender Status"::Unsuccessfull, "Tender Status"::"Not Participated"] THEN
                        ERROR('You cannot cancel tender as tender status is already ' + FORMAT("Tender Status"));
                    IF "EMD Satus" <> "EMD Satus"::NA THEN
                        IF "EMD Expected Date" = 0D THEN
                            ERROR('Please enter EMD Expected Date in EMD Tab!');

                    Selection := STRMENU(Text013, 1);
                    IF Selection = 0 THEN BEGIN
                        EXIT;
                    END
                    ELSE BEGIN
                        //Initialization start
                        RowCount := 0;
                        SQLQuery := '';
                        InFlwPlanChngId := '';
                        OutFlwPaymentId := '';
                        //Initializations end

                        IF ISCLEAR(SQLConnection) THEN
                            CREATE(SQLConnection, FALSE, TRUE);

                        IF ISCLEAR(RecordSet) THEN
                            CREATE(RecordSet, FALSE, TRUE);

                        IF ConnectionOpen <> 1 THEN BEGIN
                            SQLConnection.ConnectionString := 'DSN=CASHFLOW;UID=cashflowuser;PASSWORD=firewall123;SERVER=oracle_80;';
                            SQLConnection.Open;
                            SQLConnection.BeginTrans;
                            ConnectionOpen := 1;
                        END;

                        SQLQuery := 'SELECT TENDER_ID FROM MRP_TENDER WHERE ERP_TENDER_NO = ''' + "Tender No." + '''';
                        // MESSAGE(SQLQuery);
                        RecordSet := SQLConnection.Execute(SQLQuery);
                        IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                            RecordSet.MoveFirst;

                        WHILE NOT RecordSet.EOF DO BEGIN
                            TenderId := FORMAT(RecordSet.Fields.Item('TENDER_ID').Value);
                            RowCount := RowCount + 1;
                            RecordSet.MoveNext;
                        END;
                        IF "EMD Satus" <> "EMD Satus"::NA THEN BEGIN
                            SQLQuery := 'SELECT * FROM MRP_EMD WHERE TENDER_ID = (SELECT MAX(TENDER_ID) TENDER_ID FROM MRP_TENDER WHERE ERP_TENDER_NO = ''' + "Tender No." + ''')';
                            // MESSAGE(SQLQuery);
                            RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
                            IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                                RecordSet.MoveFirst;

                            WHILE NOT RecordSet.EOF DO BEGIN
                                EMD_ID := FORMAT(RecordSet.Fields.Item('EMD_ID').Value);
                                RowCount := RowCount + 1;
                                RecordSet.MoveNext;
                            END;
                        END ELSE
                            EMD_ID := '0';

                        IF TenderId <> '' THEN BEGIN
                            IF EMD_ID <> '' THEN BEGIN
                                IF Selection = 1 THEN BEGIN
                                    SQLQuery := 'UPDATE MRP_TENDER SET STATUS = ''Y'', ERP_TENDER_STATUS = ''Cancelled'' WHERE ERP_TENDER_NO = ''' + "Tender No." + '''';
                                    "Tender Status" := "Tender Status"::Cancelled;
                                END
                                ELSE
                                    IF Selection = 2 THEN BEGIN
                                        SQLQuery := 'UPDATE MRP_TENDER SET STATUS = ''Y'', ERP_TENDER_STATUS = ''Unsuccessfull'' WHERE ERP_TENDER_NO = ''' + "Tender No." + '''';
                                        "Tender Status" := "Tender Status"::Unsuccessfull;
                                    END
                                    ELSE
                                        IF Selection = 3 THEN BEGIN
                                            SQLQuery := 'UPDATE MRP_TENDER SET STATUS = ''Y'', ERP_TENDER_STATUS = ''Not Participated'' WHERE ERP_TENDER_NO = ''' + "Tender No." + '''';
                                            "Tender Status" := "Tender Status"::"Not Participated";
                                        END;
                                // MESSAGE(SQLQuery);
                                IF SQLQuery <> '' THEN
                                    SQLConnection.Execute(SQLQuery);
                                IF EMD_ID <> '0' THEN BEGIN
                                    SQLQuery := 'SELECT * FROM MRP_EMD_OUTFLOW_PAYMENT WHERE EMD_ID =' + EMD_ID;
                                    //  MESSAGE(SQLQuery);
                                    RecordSet := SQLConnection.Execute(SQLQuery);
                                    IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                                        RecordSet.MoveFirst;
                                    WHILE NOT RecordSet.EOF DO BEGIN
                                        OutFlwPaymentId := FORMAT(RecordSet.Fields.Item('PAYMENT_ID').Value);
                                        RowCount := RowCount + 1;
                                        RecordSet.MoveNext;
                                    END;
                                    IF OutFlwPaymentId <> '' THEN BEGIN
                                        SQLQuery := 'SELECT * FROM MRP_EMD_INFLOW_PLAN_CHANGES WHERE EMD_ID =' + EMD_ID;
                                        // MESSAGE(SQLQuery);
                                        InFlwPlanChngId := '';
                                        RecordSet := SQLConnection.Execute(SQLQuery);
                                        IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                                            RecordSet.MoveFirst;
                                        WHILE NOT RecordSet.EOF DO BEGIN
                                            InFlwPlanChngId := FORMAT(RecordSet.Fields.Item('PLAN_CHANGE_ID').Value);
                                            RowCount := RowCount + 1;
                                            RecordSet.MoveNext;
                                        END;
                                        IF InFlwPlanChngId = '' THEN BEGIN
                                            SQLQuery := 'INSERT INTO MRP_EMD_OUTFLOW_PLAN_CHANGES (PLAN_CHANGE_ID,EMD_ID,TENDOR_ID,PLANNED_AMOUNT,PAYMENT_REALIZE_DATE,REMARKS, ' +
                                                        'CREATION_DATE,USERID,SL_NO,PAYMENT_ID,BASEPLAN,SPLITEDFROM) ' +
                                                        'VALUES((SELECT NVL(MAX(PLAN_CHANGE_ID),0)+1 FROM MRP_EMD_OUTFLOW_PLAN_CHANGES), ' +
                                                        EMD_ID + ', ' + TenderId + ', 0' +
                                                        ', SYSDATE, '''', SYSDATE, ''Auto'', (SELECT MAX(SL_NO)+1 FROM MRP_EMD_OUTFLOW_PLAN_CHANGES WHERE EMD_ID = ' + EMD_ID + ' AND TENDOR_ID = ' + TenderId + '),'''','''','''')';
                                            //MESSAGE(SQLQuery);
                                            SQLConnection.Execute(SQLQuery);
                                            EMDAmount := ROUND("EMD Amount", 1);
                                            SQLQuery := 'INSERT INTO MRP_EMD_INFLOW_PLAN_CHANGES (PLAN_CHANGE_ID,EMD_ID,TENDOR_ID,PLANNED_AMOUNT,PAYMENT_REALIZE_DATE,REMARKS,' +
                                                        'CREATION_DATE,USERID,SL_NO,PAYMENT_ID,BASEPLAN,SPLITEDFROM) ' +
                                                        'VALUES((SELECT NVL(MAX(PLAN_CHANGE_ID),0)+1 FROM MRP_EMD_INFLOW_PLAN_CHANGES), ' + EMD_ID + ', ' + TenderId + ', ' + FORMAT(EMDAmount) +
                                                        ', to_date(''' + FORMAT("EMD Expected Date", 0, '<Day>-<Month Text,3>-<Year4>') + ''',''dd-mon-yyyy''), '''', SYSDATE, ''Auto'', 1,'''','''','''')';
                                            //MESSAGE(SQLQuery);
                                            SQLConnection.Execute(SQLQuery);
                                        END;
                                    END;
                                END;
                            END
                            ELSE
                                ERROR('EMD Details not present in CashFLow.\Please Release the Tender to create EMD details in CashFLow!');
                        END
                        ELSE
                            ERROR('Tender: ' + "Tender No." + ' not created in CashFlow.\Please release the Tender to create tender in Cashflow!');
                        SQLConnection.CommitTrans;
                        RecordSet.Close;
                        SQLConnection.Close;
                        ConnectionOpen := 0;
                        MODIFY;
                    END;
                    //B2B UPG >>>
                    /* Mail_To := 'rajani@efftronics.com,erp@efftronics.com';
                    Mail_Body := '';
                    Mail_Subject := 'Tender No: ' + "Tender No." + ' for the Customer ' + "Customer Name" + ' is Cancelled due to reason:' + FORMAT("Tender Status");
                    ROMail.CreateMessage('erp', 'erp@efftronics.com', Mail_To, 'ERP - ' + Mail_Subject, Mail_Body, TRUE);
                    ROMail.AppendBody('<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>');
                    ROMail.AppendBody('<body><div style="border-color:#025E4D;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;">');
                    ROMail.AppendBody('<label><font size="6"> Tender Information</font></label>');
                    ROMail.AppendBody('<hr style=solid; color= #3333CC>');
                    ROMail.AppendBody('<h>Dear Sir/Madam,</h><br>');
                    ROMail.AppendBody('<P>TENDER DETAILS</P>');
                    ROMail.AppendBody('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><td width="40%"><b>Tender No  </b></td><td>' + "Tender No." + '</td></tr>');
                    Customer.RESET;
                    Customer.SETRANGE(Customer."No.", "Customer No.");
                    IF Customer.FINDFIRST THEN BEGIN
                        ROMail.AppendBody('<tr><td><b>Customer Name   </b> </td><td>' + Customer.Name + '</td></tr>');
                        ROMail.AppendBody('<tr><td><b>Customer Type  </b></td><td>' + Customer."Customer Posting Group" + '</td></tr>');
                    END;
                    ROMail.AppendBody('<tr><td><b>Tender Type  </b></td><td>' + FORMAT(TenderType) + '</td></tr>');
                    ROMail.AppendBody('<tr><td><b>Product  </b></td><td>' + Product + '</td></tr>');
                    ROMail.AppendBody('<tr><td><b>Customer Tender No.  </b></td><td>' + "Customer Tender No." + '</td></tr>');
                    ROMail.AppendBody('<tr><td><b>BID Value  </b></td><td>' + formataddress.ChangeCurrency(ROUND("Minimum Bid Amount", 1)) + '</td></tr>');
                    ROMail.AppendBody('<tr><td><b>BID Opening Date  </b></td><td>' + FORMAT(("Tech. Bid Opening Date"), 0, 4) + '</td></tr>');
                    ROMail.AppendBody('<tr><td><b>EMD Status  </b></td><td>' + FORMAT("EMD Satus") + '</td></tr>');
                    IF "EMD Satus" <> "EMD Satus"::NA THEN BEGIN
                        ROMail.AppendBody('<tr><td><b>EMD Value  </b></td><td>' + formataddress.ChangeCurrency(ROUND("EMD Amount", 1)) + '</td></tr>');
                        ROMail.AppendBody('<tr><td><b>EMD Expected Return Date  </b></td><td>' + FORMAT("EMD Required Date", 0, 4) + '</td></tr>');
                    END;
                    "Mail-Id".RESET;
                    "Mail-Id".SETRANGE("Mail-Id".EmployeeID, "Salesperson Code");//B2B
                    IF "Mail-Id".FINDFIRST THEN
                        ROMail.AppendBody('<tr><td><b>Sales Executive  </b></td><td>' + FORMAT("Mail-Id"."Full Name") + '</td></tr>');
                    ROMail.AppendBody('</Table>');
                    ROMail.AppendBody('<BR><p align ="left"> Regards,<br>ERP Team </p>');
                    ROMail.AppendBody('<br><p align = "center">::::Note: Auto Generated mail from ERP:::: </b></P></div></body></html>');
                    IF (Mail_To <> '') THEN
                        ROMail.Send;     //B2B UPG <<<



                    Recipients.Add('rajani@efftronics.com');
                    Recipients.Add('erp@efftronics.com');
                    Mail_Body := '';
                    Mail_Subject := 'Tender No: ' + "Tender No." + ' for the Customer ' + "Customer Name" + ' is Cancelled due to reason:' + FORMAT("Tender Status");
                    //ROMail.CreateMessage('erp', 'erp@efftronics.com', Mail_To, 'ERP - ' + Mail_Subject, Mail_Body, TRUE);
                    EmailMessage.Create(Recipients, Mail_Subject, Body, true);
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
                    Body += ('<tr><td><b>EMD Status  </b></td><td>' + FORMAT("EMD Satus") + '</td></tr>');
                    IF "EMD Satus" <> "EMD Satus"::NA THEN BEGIN
                        Body += ('<tr><td><b>EMD Value  </b></td><td>' + formataddress.ChangeCurrency(ROUND("EMD Amount", 1)) + '</td></tr>');
                        Body += ('<tr><td><b>EMD Expected Return Date  </b></td><td>' + FORMAT("EMD Required Date", 0, 4) + '</td></tr>');
                    END;
                    "Mail-Id".RESET;
                    "Mail-Id".SETRANGE("Mail-Id".EmployeeID, "Salesperson Code");//B2B
                    IF "Mail-Id".FINDFIRST THEN
                        Body += ('<tr><td><b>Sales Executive  </b></td><td>' + FORMAT("Mail-Id"."Full Name") + '</td></tr>');
                    Body += ('</Table>');
                    Body += ('<BR><p align ="left"> Regards,<br>ERP Team </p>');
                    Body += ('<br><p align = "center">::::Note: Auto Generated mail from ERP:::: </b></P></div></body></html>');
                    //IF (Mail_To <> '') THEN
                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

                    MESSAGE('Tender and EMD details Updated in CashFlow!');
                    RecEditable := FALSE;
                    CurrPage.UPDATE;
                    // End by Pranavi
                    */
                    end;
                }
            }
            action(Comment)
            {
                Caption = 'Comment';
                Image = Comment;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Tender Comments";
                RunPageLink = "No." = FIELD("Tender No.");
                ToolTip = 'Comment';
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        IF "Tender Status" IN ["Tender Status"::Cancelled, "Tender Status"::Unsuccessfull, "Tender Status"::"Not Participated"] THEN
            RecEditable := FALSE
        ELSE
            RecEditable := TRUE;
    end;

    trigger OnOpenPage();
    begin
        IF USERID IN ['EFFTRONICS\PRANAVI'] THEN
            Editable_Bool := TRUE
        ELSE
            Editable_Bool := FALSE;
    end;

    var
        NoSeriesMgt: Codeunit 396;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        SRSetup: Record "Sales & Receivables Setup";
        Tender: Codeunit Tender;
        DesignWorksheetHeader: Record "Design Worksheet Header";
        DesignWorksheetLine: Record "Design Worksheet Line";
        DesignWorksheetTender: Record "Design Worksheet Header";
        DesignWorksheetLineTender: Record "Design Worksheet Line";
        TenderPostingLines: Record "Tender Posting Lines";
        Attach: Record Attachments;
        PostAttach: Record Attachments;
        Text010: Label '"Sales Order already Created "';
        CheckList: Record "Check List";
        PostCheckList: Record "Check List";
        Text007: Label 'Blanket Order already created';
        Text009: Label 'Do You want to Send the Document to Design?';
        Text012: Label 'Document has been converted to Design';
        Text008: Label 'Tender is in Design Stage';
        TenderCommentLine: Record "Tender Comment Line";
        SalesCommentLine: Record "Sales Comment Line";
        "Mail-Id": Record "User Setup";
        "from Mail": Text[100];
        "to mail": Text[1000];
        Mail_Subject: Text[1000];
        Mail_Body: Text[1000];
        mail: Codeunit Mail;
        charline: Char;
        "g/l setup": Record "General Ledger Setup";
        Attachment1: Text[1000];
        TH: Record "Tender Header";
        CUST: Record Customer;
        tenders: Record "Tender Header";
        SCHEDULEOMS: Record Schedule2;
        TL: Record "Tender Line";
        Text013: Label '&Cancelled,&Unsuccessfull,&Not Participated';
        EMDPaidStatus: Code[10];
        Text014: Label 'EMD is not Paid in Cashflow, Do You Want to Continue to Create Sale Order?';
        RecEditable: Boolean;
        Mail_To: Text;
        //ROMail: Codeunit "SMTP Mail";
        formataddress: Codeunit "Correct Dimension Values Cust";
        Customer: Record Customer;
        SalHdr: Record "Sales Header";
        Editable_Bool: Boolean;
        Recipients: List of [Text];


    procedure MaketoOrder();
    var
        Text000: Label 'Do you want to convert the Tender to Order?';
        Text001: Label 'Tender %1 has been Converted to order %2';
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Cust: Record Customer;
        TenderLine: Record "Tender Line";
        Schedule: Record Schedule2;
        Schedule2: Record Schedule2;
        Schedule3: Record Schedule2;
        OMSIntegration: Codeunit SQLIntegration;
    begin
        IF "Document Position" = "Document Position"::Finance THEN
            ERROR(Text008);
        IF "Sales Order Created" = TRUE THEN
            ERROR(Text010)
        ELSE
            IF "Blanket Order Created" = TRUE THEN
                ERROR(Text007);
        IF Status = Status::Open THEN
            ERROR('TENDER MUST BE RELEASED');


        TESTFIELD("Customer No.");
        IF NOT CONFIRM(Text000, FALSE) THEN
            EXIT;
        SalesHeader.INIT;
        CASE TenderType OF
            TenderType::AMC:
                BEGIN
                    SalesHeader."Document Type" := SalesHeader."Document Type"::Order;//EFFUPG1.5
                    SalesHeader.SaleDocType := SalesHeader.SaleDocType::Amc;//EFFUPG1.5
                    SRSetup.GET;
                    SalesHeader."No." := NoSeriesMgt.GetNextNo('AMC', WORKDATE, TRUE);
                END;
            TenderType::Sale:
                BEGIN
                    SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
                    SRSetup.GET;
                    SalesHeader."No." := NoSeriesMgt.GetNextNo('SAL ORD', WORKDATE, TRUE);
                END;
            TenderType::LMD:
                BEGIN
                    SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
                    SRSetup.GET;
                    SalesHeader."No." := NoSeriesMgt.GetNextNo('SAL LED', WORKDATE, TRUE);
                END;
        /* TenderType::LMD:
             BEGIN
                 SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
                 SRSetup.GET;
                 SalesHeader."No." := NoSeriesMgt.GetNextNo('EFFE-TS', WORKDATE, TRUE);
             END;*/
        END;
        Cust.GET("Customer No.");
        Cust.CheckBlockedCustOnDocs(Cust, SalesHeader."Document Type"::Quote, TRUE, FALSE);
        SalesHeader.VALIDATE("Sell-to Customer No.", "Customer No.");
        //SalesHeader."Document Date":=WORKDATE;
        SalesHeader.VALIDATE(SalesHeader."Sell-to Customer No.");
        SalesHeader."Tender No." := "Tender No.";
        SalesHeader.Product := Product;
        SalesHeader."EMD Amount" := "EMD Amount";
        SalesHeader."Security Deposit Amount" := "Security Deposit Amount";
        "Sales Order Created" := TRUE;
        "Tender Status" := "Tender Status"::Received;
        MODIFY(TRUE);
        MESSAGE('Order No is %1  created', SalesHeader."No.");
        SalesHeader.INSERT;

        TenderLine.SETRANGE("Document No.", "Tender No.");
        IF TenderLine.FINDSET THEN
            REPEAT
                SalesLine.INIT;
                IF TenderType = TenderType::AMC THEN begin
                    SalesLine."Document Type" := SalesLine."Document Type"::order;//EFFUPG1.5
                    SalesLine.SaleDocType := SalesLine.SaleDocType::Amc;//EFFUPG1.5
                end ELSE
                    SalesLine."Document Type" := SalesLine."Document Type"::Order;
                SalesLine."Document No." := SalesHeader."No.";
                SalesLine."Line No." := TenderLine."Line No.";
                SalesLine."Schedule No" := TenderLine."Schedule No";
                SalesLine."Type of Item" := TenderLine."Type of Item";
                SalesLine."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                IF TenderLine.Type = TenderLine.Type::Item THEN BEGIN
                    SalesLine.Type := SalesLine.Type::Item;
                    SalesLine.Description := TenderLine.Description;
                    SalesLine."Description 2" := TenderLine."Description 2";
                END;

                IF TenderLine.Type = TenderLine.Type::Item THEN BEGIN
                    SalesLine.Type := SalesLine.Type::Item;
                END;

                IF TenderLine.Type = TenderLine.Type::Resource THEN BEGIN
                    SalesLine.Type := SalesLine.Type::Resource;
                END;
                IF TenderLine.Type = TenderLine.Type::"G/L Account" THEN BEGIN
                    SalesLine.Type := SalesLine.Type::"G/L Account";
                END;
                // added by pranavi on 01-sep-2016 for payment terms
                IF SalesLine."Document Type" = SalesLine."Document Type"::Order THEN BEGIN
                    SalHdr.RESET;
                    SalHdr.SETRANGE(SalHdr."No.", SalesLine."Document No.");
                    IF SalHdr.FINDFIRST THEN
                        IF SalHdr."Customer Posting Group" IN ['PRIVATE', 'OTHERS'] THEN
                            IF SalesLine.Type = SalesLine.Type::Item THEN BEGIN
                                SalesLine."Supply Portion" := 100;
                                SalesLine."Retention Portion" := 0;
                            END ELSE BEGIN
                                SalesLine."Supply Portion" := 0;
                                SalesLine."Retention Portion" := 100;
                            END;
                END;
                // end by pranavi
                Schedule3.RESET;
                Schedule3.SETRANGE("Document Type", Schedule3."Document Type"::Tender);
                Schedule3.SETRANGE("Document No.", TenderLine."Document No.");
                Schedule3.SETRANGE("Document Line No.", TenderLine."Line No.");
                IF Schedule3.FINDFIRST THEN
                    SalesLine."No." := TenderLine."No.";
                SalesLine.VALIDATE(SalesLine."No.");
                SalesLine.VALIDATE(Quantity, TenderLine.Quantity);
                SalesLine.VALIDATE("Unit Cost (LCY)", Schedule."Calcaulated Amont" / TenderLine.Quantity);



                IF SalesLine.Type > SalesLine.Type::" " THEN BEGIN
                    SalesLine.VALIDATE("Sell-to Customer No.");
                    SalesLine.VALIDATE(SalesLine.Quantity);
                END;
                SalesLine."Tender No." := "Tender No.";
                SalesLine."Tender Line No." := TenderLine."Line No.";
                /*
                DesignWorksheetTender.SETRANGE("Document Type",DesignWorksheetTender."Document Type"::Tender);
                DesignWorksheetTender.SETRANGE("Document No.",TenderLine."Document No.");
                DesignWorksheetTender.SETRANGE("Document Line No.",TenderLine."Line No.");
                IF DesignWorksheetTender.FINDFIRST THEN BEGIN
                  DesignWorksheetHeader.INIT;
                  DesignWorksheetHeader."Document Type" := DesignWorksheetHeader."Document Type"::Order;
                  DesignWorksheetHeader."Document No." := SalesLine."Document No.";
                  DesignWorksheetHeader."Document Line No." := SalesLine."Line No.";
                  DesignWorksheetHeader."Item No." := DesignWorksheetTender."Item No.";
                  DesignWorksheetHeader.Description := DesignWorksheetTender.Description;
                  DesignWorksheetHeader.Quantity := DesignWorksheetTender.Quantity;
                  DesignWorksheetHeader."Unit of Measure" := DesignWorksheetTender."Unit of Measure";
                  DesignWorksheetHeader."Soldering Time for SMD" := DesignWorksheetTender."Soldering Time for SMD";
                  DesignWorksheetHeader."Soldering time for DIP" := DesignWorksheetTender."Soldering time for DIP";
                  DesignWorksheetHeader."Total time in Hours" := DesignWorksheetTender."Total time in Hours";
                  DesignWorksheetHeader."Soldering Cost Perhour" := DesignWorksheetTender."Soldering Cost Perhour";
                  DesignWorksheetHeader."Development Cost" := DesignWorksheetTender."Development Cost";
                  DesignWorksheetHeader."Development Time in hours" := DesignWorksheetTender."Development Time in hours";
                  DesignWorksheetHeader."Development Cost per hour" := DesignWorksheetTender."Development Cost per hour";
                  DesignWorksheetHeader."Additional Cost" := DesignWorksheetTender."Additional Cost";
                  DesignWorksheetHeader."Production Bom No." := DesignWorksheetTender."Production Bom No.";
                  DesignWorksheetHeader."Production Bom Version No." := DesignWorksheetTender."Production Bom Version No.";
                  DesignWorksheetHeader."Total Cost" := DesignWorksheetTender."Total Cost";
                  DesignWorksheetTender.CALCFIELDS(DesignWorksheetTender."Components Cost",DesignWorksheetTender."Manufacturing Cost",
                        DesignWorksheetTender."Resource Cost",DesignWorksheetTender."Installation Cost");
                  DesignWorksheetHeader."Components Cost" := DesignWorksheetTender."Components Cost";
                  DesignWorksheetHeader."Manufacturing Cost" := DesignWorksheetTender."Manufacturing Cost";
                  DesignWorksheetHeader."Resource Cost" := DesignWorksheetTender."Resource Cost";
                  DesignWorksheetHeader."Installation Cost" := DesignWorksheetTender."Installation Cost";
                  DesignWorksheetHeader."Total Cost (From Line)" := DesignWorksheetTender."Total Cost (From Line)";
                  IF DesignWorksheetHeader."Document No." <> '' THEN
                    DesignWorksheetHeader.INSERT;
                  DesignWorksheetLicomender.SETRANGE("Document Type",DesignWorksheetLicomender."Document Type"::Tender);
                  DesignWorksheetLicomender.SETRANGE("Document No.",DesignWorksheetTender."Document No.");
                  DesignWorksheetLicomender.SETRANGE("Document Line No.",DesignWorksheetTender."Document Line No.");
                  IF DesignWorksheetLicomender.FINDSET THEN
                    REPEAT
                      DesignWorksheetLine."Document No." := DesignWorksheetHeader."Document No.";
                      DesignWorksheetLine."Document Type" := DesignWorksheetLine."Document Type"::Order;
                      DesignWorksheetLine."Document Line No." := DesignWorksheetHeader."Document Line No.";
                      DesignWorksheetLine."Line No." := DesignWorksheetLicomender."Line No.";
                      DesignWorksheetLine."Line No." := DesignWorksheetLine."Line No." + 10000;
                      DesignWorksheetLine.Type := DesignWorksheetLicomender.Type;
                      DesignWorksheetLine."No." := DesignWorksheetLicomender."No.";
                      DesignWorksheetLine.Description := DesignWorksheetLicomender.Description;
                      DesignWorksheetLine."Description 2" := DesignWorksheetLicomender."Description 2";
                      DesignWorksheetLine."No.of SMD Points" := DesignWorksheetLicomender."No.of SMD Points";
                      DesignWorksheetLine."No.of DIP Points" := DesignWorksheetLicomender."No.of DIP Points";
                      DesignWorksheetLine."Unit of Measure" := DesignWorksheetLicomender."Unit of Measure";
                      DesignWorksheetLine.Quantity := DesignWorksheetLicomender.Quantity;
                      DesignWorksheetLine."Unit Cost" := DesignWorksheetLicomender."Unit Cost";
                      DesignWorksheetLine.Amount := DesignWorksheetLicomender.Amount;
                      DesignWorksheetLine."Total time in Hours" := DesignWorksheetLicomender."Total time in Hours";
                      DesignWorksheetLine."Manufacturing Cost" := DesignWorksheetLicomender."Manufacturing Cost";
                      DesignWorksheetLine.INSERT;
                    UNTIL DesignWorksheetLicomender.NEXT = 0;
                END;
                */
                Schedule.RESET;
                Schedule.SETRANGE("Document Type", Schedule."Document Type"::Tender);
                Schedule.SETRANGE("Document No.", TenderLine."Document No.");
                Schedule.SETRANGE("Document Line No.", TenderLine."Line No.");
                IF Schedule.FINDSET THEN
                    REPEAT
                        Schedule2.INIT;
                        Schedule2.TRANSFERFIELDS(Schedule);
                        Schedule2."Document Type" := Schedule2."Document Type"::Order;
                        Schedule2."Document No." := SalesLine."Document No.";
                        Schedule2."Document Line No." := SalesLine."Line No.";
                        Schedule2.INSERT;
                    UNTIL Schedule.NEXT = 0;
                SalesLine.INSERT;
            UNTIL TenderLine.NEXT = 0;



        //NSS 100907
        Attach.RESET;
        Attach.SETRANGE("Table ID", DATABASE::"Tender Header");
        Attach.SETRANGE("Document No.", "Tender No.");
        IF Attach.FINDSET THEN
            REPEAT
                PostAttach.INIT;
                Attach.CALCFIELDS(Attach.FileAttachment);
                PostAttach.TRANSFERFIELDS(Attach);
                PostAttach."Table ID" := DATABASE::"Sales Header";
                PostAttach."Document No." := SalesHeader."No.";
                PostAttach."Document Type" := PostAttach."Document Type"::Order;
                PostAttach.INSERT;
            UNTIL Attach.NEXT = 0;

        CheckList.RESET;
        CheckList.SETRANGE("Document Type", CheckList."Document Type"::Tender);
        CheckList.SETRANGE("Document No.", "Tender No.");
        IF CheckList.FINDSET THEN
            REPEAT
                PostCheckList.INIT;
                PostCheckList.TRANSFERFIELDS(CheckList);
                PostCheckList."Document Type" := PostCheckList."Document Type"::Sales;
                PostCheckList."Document No." := SalesHeader."No.";
                PostCheckList.INSERT;
            UNTIL CheckList.NEXT = 0;
        //NSS 100907
        //Carrying the comments
        TenderCommentLine.RESET;
        TenderCommentLine.SETRANGE(TenderCommentLine."No.", "Tender No.");
        IF TenderCommentLine.FINDSET THEN
            REPEAT
                SalesCommentLine.INIT;
                SalesCommentLine."Document Type" := SalesCommentLine."Document Type"::Order;
                SalesCommentLine."No." := SalesHeader."No.";
                SalesCommentLine."Line No." := TenderCommentLine."Line No.";
                SalesCommentLine.Date := TenderCommentLine.Date;
                SalesCommentLine.Comment := TenderCommentLine.Comment;
                SalesCommentLine.INSERT;
            UNTIL TenderCommentLine.NEXT = 0;
        MESSAGE(Text001, "Tender No.", SalesHeader."No.");

        //**********************************Mail Code for Converting to Order*************************(swarupa)

        TH.SETRANGE(TH."Tender No.", "Tender No.");
        IF TH.FINDFIRST THEN BEGIN
            IF (TH."Blanket Order Created" = true) THEN BEGIN
                Mail_Subject := 'ERP- Tender Converted to Order';
                charline := 10;
                Mail_Body := '';
                Mail_Body += 'TENDER CONVERTED TO ORDER DETAILS :';
                Mail_Body += FORMAT(charline);
                Mail_Body += FORMAT(charline);
                Mail_Body += 'Tender No.         :' + "Tender No.";
                Mail_Body += FORMAT(charline);
                Mail_Body += 'Customer Tender No.:' + "Customer Tender No.";
                Mail_Body += FORMAT(charline);
                Mail_Body += 'Customer Name      :' + "Customer Name";
                Mail_Body += FORMAT(charline);
                IF "Minimum Bid Amount" = 0 THEN
                    ERROR('Enter Bid Value');
                Mail_Body += 'BID Value          :' + FORMAT(ROUND("Minimum Bid Amount", 1));
                IF "EMD Satus" <> "EMD Satus"::NA THEN BEGIN
                    Mail_Body += FORMAT(charline);
                    Mail_Body += 'EMD Value          :' + FORMAT(ROUND("EMD Amount", 1));
                END;
                Mail_Body += FORMAT(charline);
                Mail_Body += FORMAT(charline);
                Mail_Body += '***** Auto Mail Generated from ERP *****';

                "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                IF "Mail-Id".FINDFIRST THEN
                    "from Mail" := "Mail-Id".MailID;
                TH.SETRANGE(TH."Tender No.", "Tender No.");
                IF TH.FINDFIRST THEN
                    REPORT.RUN(50095, FALSE, FALSE, TH);
                "g/l setup".FINDFIRST;
                //REPORT.SAVEASHTML(50095,'\\erpserver\ErpAttachments\Tender detail1.html',FALSE,TH);
                //Attachment1:='\\erpserver\ErpAttachments\Tender detail1.html';

                /*   "to mail"+='dir@efftronics.com,padmaja@efftronics.com,chowdary@efftronics.com,renukach@efftronics.com,phani@efftronics.com,';
                    "to mail"+='erp@efftronics.com,sal@efftronics.com,bharat@efftronics.com,cvmohan@efftronics.com,raju@efftronics.com';*/
                /*
                "to mail":='dir@efftronics.com,ravi@efftronics.com,samba@efftronics.com,cvmohan@efftronics.com,anilkumar@efftronics.com,';
                    "to mail"+='renukach@efftronics.com,baji@efftronics.com,prasannat@efftronics.com,anuradhag@efftronics.com,padmaja@efftronics.com
                ,'
                ;
                "to mail"+='anulatha@efftronics.com,milind@efftronics.com,srasc@efftronics.com,chowdary@efftronics.com,';
                "to mail"+='sganesh@efftronics.com,rajani@efftronics.com,dsr@efftronics.com,sunil@efftronics.com,phani@efftronics.com,';
                "to mail"+='bharat@efftronics.com,mohang@efftronics.com,';
                "to mail":='SANTHOSHK@EFFTRONICS.COM';*/



                //       IF ( "from Mail"<>'') AND ("to mail"<>'') THEN
                //       mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,Attachment1);
            END;
        END;
        COMMIT;

        //OMS integration

        //IF (Status=Status::Open) THEN
        // coments by anil
        //OMSIntegration.TendertoBlanketorOrder(SalesHeader."No." ,2,"Tender No.",0);

        //OMS integration

    end;


    procedure MakeToBlanketOrder();
    var
        Text005: Label 'Do you want to convert the Tender to Blanket Order?';
        Text006: Label 'Tender %1 has been Converted to Blanket order %2';
        Text007: Label 'Blanket Order already created';
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Cust: Record Customer;
        TenderLine: Record "Tender Line";
        Schedule: Record Schedule2;
        Schedule2: Record Schedule2;
        OMSIntegration: Codeunit SQLIntegration;
    begin
        IF "Document Position" = "Document Position"::Finance THEN
            ERROR(Text008);
        /*  IF Status=Status::Open THEN
          ERROR('TENDER MUST BE RELEASED');
        */
        IF "Sales Order Created" = TRUE THEN
            ERROR(Text010);
        IF "Blanket Order Created" = TRUE THEN
            ERROR(Text007);

        TESTFIELD("Customer No.");
        IF NOT CONFIRM(Text005, FALSE) THEN
            EXIT;
        SalesHeader.INIT;
        SalesHeader."Document Type" := SalesHeader."Document Type"::"Blanket Order";
        SRSetup.GET;
        SalesHeader."No." := NoSeriesMgt.GetNextNo(SRSetup."Blanket Order Nos.", WORKDATE, TRUE);
        Cust.GET("Customer No.");
        Cust.CheckBlockedCustOnDocs(Cust, SalesHeader."Document Type"::"Blanket Order", TRUE, FALSE);
        SalesHeader."Sell-to Customer No." := "Customer No.";
        SalesHeader.VALIDATE(SalesHeader."Sell-to Customer No.");
        //MESSAGE('%1',SalesHeader."Gen. Bus. Posting Group");
        SalesHeader."Tender No." := "Tender No.";
        SalesHeader.Product := Product;
        SalesHeader."EMD Amount" := "EMD Amount";
        SalesHeader."Security Deposit Amount" := "Security Deposit Amount";

        //SalesHeader."User ID":="USER ID";
        SalesHeader."Expected Order Month" := "Expected Order month";
        "Blanket Order Created" := TRUE;
        MODIFY(TRUE);
        MESSAGE(' Blanket Order No is %1  created', SalesHeader."No.");
        SalesHeader.INSERT;

        TenderLine.SETRANGE("Document No.", "Tender No.");
        IF TenderLine.FINDSET THEN
            REPEAT
                SalesLine.INIT;
                SalesLine."Document Type" := SalesLine."Document Type"::"Blanket Order";
                SalesLine."Document No." := SalesHeader."No.";
                SalesLine."Line No." := SalesLine."Line No." + 10000;
                SalesLine."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                SalesLine."Schedule No" := TenderLine."Schedule No";
                SalesLine."Type of Item" := TenderLine."Type of Item";

                IF TenderLine.Type = TenderLine.Type::Item THEN BEGIN
                    SalesLine.Type := SalesLine.Type::Item;
                    SalesLine.Description := TenderLine.Description;
                    SalesLine."Description 2" := TenderLine."Description 2";
                END;
                IF TenderLine.Type = TenderLine.Type::Item THEN BEGIN
                    SalesLine.Type := SalesLine.Type::Item;
                    SalesLine.VALIDATE("Tax Group Code", TenderLine."Tax Group Code");
                END;
                IF TenderLine.Type = TenderLine.Type::Resource THEN BEGIN
                    SalesLine.Type := SalesLine.Type::Resource;
                END;
                IF TenderLine.Type = TenderLine.Type::"G/L Account" THEN BEGIN
                    SalesLine.Type := SalesLine.Type::"G/L Account";
                END;
                // added by pranavi on 01-sep-2016 for payment terms
                IF SalesLine."Document Type" = SalesLine."Document Type"::Order THEN BEGIN
                    SalHdr.RESET;
                    SalHdr.SETRANGE(SalHdr."No.", SalesLine."Document No.");
                    IF SalHdr.FINDFIRST THEN
                        IF SalHdr."Customer Posting Group" IN ['PRIVATE', 'OTHERS'] THEN
                            IF SalesLine.Type = SalesLine.Type::Item THEN BEGIN
                                SalesLine."Supply Portion" := 100;
                                SalesLine."Retention Portion" := 0;
                            END ELSE BEGIN
                                SalesLine."Supply Portion" := 0;
                                SalesLine."Retention Portion" := 100;
                            END;
                END;
                // end by pranavi

                SalesLine."No." := TenderLine."No.";
                SalesLine.VALIDATE(SalesLine."No.");
                SalesLine.Quantity := TenderLine.Quantity;
                SalesLine.VALIDATE(SalesLine.Quantity);
                /*
                DesignWorksheetTender.SETRANGE("Document Type",DesignWorksheetTender."Document Type"::Tender);
                DesignWorksheetTender.SETRANGE("Document No.",TenderLine."Document No.");
                DesignWorksheetTender.SETRANGE("Document Line No.",TenderLine."Line No.");
                IF DesignWorksheetTender.FINDFIRST THEN BEGIN
                  DesignWorksheetHeader.INIT;
                  DesignWorksheetHeader."Document Type" := DesignWorksheetHeader."Document Type"::"Blanket Order";
                  DesignWorksheetHeader."Document No." := SalesLine."Document No.";
                  DesignWorksheetHeader."Document Line No." := SalesLine."Line No.";
                  DesignWorksheetHeader."Item No." := DesignWorksheetTender."Item No.";
                  DesignWorksheetHeader.Description := DesignWorksheetTender.Description;
                  DesignWorksheetHeader.Quantity := DesignWorksheetTender.Quantity;
                  DesignWorksheetHeader."Unit of Measure" := DesignWorksheetTender."Unit of Measure";
                  DesignWorksheetHeader."Soldering Time for SMD" := DesignWorksheetTender."Soldering Time for SMD";
                  DesignWorksheetHeader."Soldering time for DIP" := DesignWorksheetTender."Soldering time for DIP";
                  DesignWorksheetHeader."Total time in Hours" := DesignWorksheetTender."Total time in Hours";
                  DesignWorksheetHeader."Soldering Cost Perhour" := DesignWorksheetTender."Soldering Cost Perhour";
                  DesignWorksheetHeader."Development Cost" := DesignWorksheetTender."Development Cost";
                  DesignWorksheetHeader."Development Time in hours" := DesignWorksheetTender."Development Time in hours";
                  DesignWorksheetHeader."Development Cost per hour" := DesignWorksheetTender."Development Cost per hour";
                  DesignWorksheetHeader."Additional Cost" := DesignWorksheetTender."Additional Cost";
                  DesignWorksheetHeader."Production Bom No." := DesignWorksheetTender."Production Bom No.";
                  DesignWorksheetHeader."Production Bom Version No." := DesignWorksheetTender."Production Bom Version No.";
                  DesignWorksheetHeader."Total Cost" := DesignWorksheetTender."Total Cost";
                  DesignWorksheetTender.CALCFIELDS(DesignWorksheetTender."Components Cost",DesignWorksheetTender."Manufacturing Cost",
                        DesignWorksheetTender."Resource Cost",DesignWorksheetTender."Installation Cost");
                  DesignWorksheetHeader."Components Cost" := DesignWorksheetTender."Components Cost";
                  DesignWorksheetHeader."Manufacturing Cost" := DesignWorksheetTender."Manufacturing Cost";
                  DesignWorksheetHeader."Resource Cost" := DesignWorksheetTender."Resource Cost";
                  DesignWorksheetHeader."Installation Cost" := DesignWorksheetTender."Installation Cost";
                  DesignWorksheetHeader."Total Cost (From Line)" := DesignWorksheetTender."Total Cost (From Line)";
                  IF DesignWorksheetHeader."Document No." <> '' THEN
                    DesignWorksheetHeader.INSERT;
                  DesignWorksheetLicomender.SETRANGE("Document Type",DesignWorksheetLicomender."Document Type"::Tender);
                  DesignWorksheetLicomender.SETRANGE("Document No.",DesignWorksheetTender."Document No.");
                  DesignWorksheetLicomender.SETRANGE("Document Line No.",DesignWorksheetTender."Document Line No.");
                  IF DesignWorksheetLicomender.FINDSET THEN
                    REPEAT
                      DesignWorksheetLine."Document No." := DesignWorksheetHeader."Document No.";
                      DesignWorksheetLine."Document Type" := DesignWorksheetLine."Document Type"::"Blanket Order";
                      DesignWorksheetLine."Document Line No." := DesignWorksheetHeader."Document Line No.";
                      DesignWorksheetLine."Line No." := DesignWorksheetLicomender."Line No.";
                      DesignWorksheetLine."Line No." := DesignWorksheetLine."Line No." + 10000;
                      DesignWorksheetLine.Type := DesignWorksheetLicomender.Type;
                      DesignWorksheetLine."No." := DesignWorksheetLicomender."No.";
                      DesignWorksheetLine.Description := DesignWorksheetLicomender.Description;
                      DesignWorksheetLine."Description 2" := DesignWorksheetLicomender."Description 2";
                      DesignWorksheetLine."No.of SMD Points" := DesignWorksheetLicomender."No.of SMD Points";
                      DesignWorksheetLine."No.of DIP Points" := DesignWorksheetLicomender."No.of DIP Points";
                      DesignWorksheetLine."Unit of Measure" := DesignWorksheetLicomender."Unit of Measure";
                      DesignWorksheetLine.Quantity := DesignWorksheetLicomender.Quantity;
                      DesignWorksheetLine."Unit Cost" := DesignWorksheetLicomender."Unit Cost";
                      DesignWorksheetLine.Amount := DesignWorksheetLicomender.Amount;
                      DesignWorksheetLine."Total time in Hours" := DesignWorksheetLicomender."Total time in Hours";
                      DesignWorksheetLine."Manufacturing Cost" := DesignWorksheetLicomender."Manufacturing Cost";
                      DesignWorksheetLine.INSERT;
                    UNTIL DesignWorksheetLicomender.NEXT = 0;
                END;
                */
                SalesLine.INSERT;
                Schedule.RESET;
                Schedule.SETRANGE("Document Type", Schedule."Document Type"::Tender);
                Schedule.SETRANGE("Document No.", TenderLine."Document No.");
                Schedule.SETRANGE("Document Line No.", TenderLine."Line No.");
                IF Schedule.FINDSET THEN
                    REPEAT
                        Schedule2.INIT;
                        Schedule2.TRANSFERFIELDS(Schedule);
                        Schedule2."Document Type" := Schedule2."Document Type"::"Blanket Order";
                        Schedule2."Document No." := SalesLine."Document No.";
                        Schedule2."Document Line No." := SalesLine."Line No.";
                        Schedule2.INSERT;
                    UNTIL Schedule.NEXT = 0;
            UNTIL TenderLine.NEXT = 0;

        //NSS 100907
        Attach.RESET;
        Attach.SETRANGE("Table ID", DATABASE::"Tender Header");
        Attach.SETRANGE("Document No.", "Tender No.");
        IF Attach.FINDSET THEN
            REPEAT
                PostAttach.INIT;
                Attach.CALCFIELDS(Attach.FileAttachment);
                PostAttach.TRANSFERFIELDS(Attach);
                PostAttach."Table ID" := DATABASE::"Sales Header";
                PostAttach."Document No." := SalesHeader."No.";
                //PostAttach."Document Type" := PostAttach."Document Type"::blanket;
                PostAttach.INSERT;
            UNTIL Attach.NEXT = 0;
        //NSS 100907

        //Carrying the comments
        TenderCommentLine.RESET;
        TenderCommentLine.SETRANGE("No.", "Tender No.");
        IF TenderCommentLine.FINDSET THEN
            REPEAT
                SalesCommentLine.INIT;
                SalesCommentLine."Document Type" := SalesCommentLine."Document Type"::"Blanket Order";
                SalesCommentLine."No." := SalesHeader."No.";
                SalesCommentLine."Line No." := TenderCommentLine."Line No.";
                SalesCommentLine.Date := TenderCommentLine.Date;
                SalesCommentLine.Comment := TenderCommentLine.Comment;
                SalesCommentLine.INSERT;
            UNTIL TenderCommentLine.NEXT = 0;

        MESSAGE(Text006, "Tender No.", SalesHeader."No.");
        TH.SETRANGE(TH."Tender No.", "Tender No.");
        IF TH.FINDFIRST THEN BEGIN
            //B2B UPG >>>
            /* IF (TH."Blanket Order Created" = TH."Blanket Order Created"::"1") THEN BEGIN
                charline := 10;
                Mail_Body := '';
                Mail_Subject := 'ERP- Tender Converted to Blanket Order';
                Mail_Body += 'TENDER CONVERTED TO  BLANKET ORDER DETAILS :';
                Mail_Body += FORMAT(charline);

                Mail_Body += 'Tender No            : ' + "Tender No.";
                Mail_Body += FORMAT(charline);
                Mail_Body += 'Customer Name        : ' + "Customer Name";
                Mail_Body += FORMAT(charline);
                Mail_Body += 'Cust. Tender No.     : ' + "Customer Tender No.";
                Mail_Body += FORMAT(charline);
                IF "Minimum Bid Amount" = 0 THEN
                    ERROR('Enter Bid Value');
                Mail_Body += 'Tender Value         : ' + FORMAT(ROUND("Minimum Bid Amount", 1));
                Mail_Body += FORMAT(charline);
                IF "Expected Order month" = "Expected Order month"::"  " THEN
                    ERROR('Please provide Expected Order Month')
                ELSE
                    Mail_Body += 'Expected Order Month : ' + FORMAT("Expected Order month");
                Mail_Body += FORMAT(charline);
                Mail_Body += FORMAT(charline);
                Mail_Body += '***** Auto Mail Generated from ERP*****';
                "Mail-Id".SETRANGE("Mail-Id"."User Name", USERID);
                IF "Mail-Id".FINDFIRST THEN
                    "from Mail" := "Mail-Id".MailID;
                TH.SETRANGE(TH."Tender No.", "Tender No.");
                IF TH.FINDFIRST THEN
                    REPORT.RUN(50095, FALSE, FALSE, TH);
                "g/l setup".FINDFIRST;
                REPORT.SAVEASPDF(50095, '\\erpserver\ErpAttachments\Tender detail1.pdf', TH);
                Attachment1 := '\\erpserver\ErpAttachments\Tender detail1.pdf';

                  //"to mail"+='dir@efftronics.com,padmaja@efftronics.com,chowdary@efftronics.com,renukach@efftronics.com,phani@efftronics.com,';
                    //"to mail"+='erp@efftronics.com,sal@efftronics.com,bharat@efftronics.com,cvmohan@efftronics.com,raju@efftronics.com';


                "to mail" := 'dir@efftronics.com,ravi@efftronics.com,samba@efftronics.com,cvmohan@efftronics.com,anilkumar@efftronics.com,';
                "to mail" += 'renukach@efftronics.com,baji@efftronics.com,prasannat@efftronics.com,anuradhag@efftronics.com,padmaja@efftronics.com,'
                ;
                "to mail" += 'mohang@efftronics.com,anulatha@efftronics.com,milind@efftronics.com,srasc@efftronics.com,chowdary@efftronics.com,';
                "to mail" += 'sganesh@efftronics.com,rajani@efftronics.com,dsr@efftronics.com,sunil@efftronics.com,phani@efftronics.com,';
                "to mail" += 'bharat@efftronics.com';

                     //IF ( "from Mail"<>'') AND ("to mail"<>'') THEN
                       //mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,Attachment1);
                
            END; */  //B2B UPG

            IF (TH."Blanket Order Created" = true) THEN BEGIN
                charline := 10;
                Mail_Body := '';
                Mail_Subject := 'ERP- Tender Converted to Blanket Order';
                Mail_Body += 'TENDER CONVERTED TO  BLANKET ORDER DETAILS :';
                Mail_Body += FORMAT(charline);

                Mail_Body += 'Tender No            : ' + "Tender No.";
                Mail_Body += FORMAT(charline);
                Mail_Body += 'Customer Name        : ' + "Customer Name";
                Mail_Body += FORMAT(charline);
                Mail_Body += 'Cust. Tender No.     : ' + "Customer Tender No.";
                Mail_Body += FORMAT(charline);
                IF "Minimum Bid Amount" = 0 THEN
                    ERROR('Enter Bid Value');
                Mail_Body += 'Tender Value         : ' + FORMAT(ROUND("Minimum Bid Amount", 1));
                Mail_Body += FORMAT(charline);
                IF "Expected Order month" = "Expected Order month"::"  " THEN
                    ERROR('Please provide Expected Order Month')
                ELSE
                    Mail_Body += 'Expected Order Month : ' + FORMAT("Expected Order month");
                Mail_Body += FORMAT(charline);
                Mail_Body += FORMAT(charline);
                Mail_Body += '***** Auto Mail Generated from ERP*****';
                "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                IF "Mail-Id".FINDFIRST THEN
                    "from Mail" := "Mail-Id".MailID;
                TH.SETRANGE(TH."Tender No.", "Tender No.");
                IF TH.FINDFIRST THEN
                    REPORT.RUN(50095, FALSE, FALSE, TH);
                "g/l setup".FINDFIRST;
                REPORT.SAVEASPDF(50095, '\\erpserver\ErpAttachments\Tender detail1.pdf', TH);
                Attachment1 := '\\erpserver\ErpAttachments\Tender detail1.pdf';
                Recipients.Add('dir@efftronics.com');
                Recipients.Add('ravi@efftronics.com');
                Recipients.Add('samba@efftronics.com');
                Recipients.Add('cvmohan@efftronics.com');
                Recipients.Add('anilkumar@efftronics.com');
                Recipients.Add('renukach@efftronics.com');
                Recipients.Add('baji@efftronics.com');
                Recipients.Add('prasannat@efftronics.com');
                Recipients.Add('anuradhag@efftronics.com');
                Recipients.Add('padmaja@efftronics.com');
                Recipients.Add('mohang@efftronics.com');
                Recipients.Add('anulatha@efftronics.com');
                Recipients.Add('milind@efftronics.com');
                Recipients.Add('srasc@efftronics.com');
                Recipients.Add('chowdary@efftronics.com');
                Recipients.Add('sganesh@efftronics.com');
                Recipients.Add('rajani@efftronics.com');
                Recipients.Add('dsr@efftronics.com');
                Recipients.Add('sunil@efftronics.com');
                Recipients.Add('phani@efftronics.com');
                Recipients.Add('bharat@efftronics.com');
                /* EmailMessage.Create(Recipients, Mail_Subject,Mail_Body, false);
                EmailMessage.AddAttachment(Attachment1,'','');
                Email.Send(EmailMessage, Enum::"Email Scenario"::Default); */

            END;
        END;

        //OMS integration

        MESSAGE(SalesHeader."No.");
        //comented by anil120411
        //OMSIntegration.TendertoBlanketorOrder(SalesHeader."No." ,1,"Tender No.",0);

        //OMS integration

    end;


    procedure EMDStatusUpdate();
    var
        EMD_ID: Code[10];
        Selection: Integer;
        SQLQuery: Text[1000];
        RowCount: Integer;
        //>> ORACLE UPG
        /*  ConnectionOpen: Integer;
         SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
         RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset"; */
        //<< ORACLE UPG
        TenderId: Code[10];
        EMDAmount: BigInteger;
    begin
        // Added by Pranavi on 18-May-2016
        //MESSAGE('EMD Status Update!');
        //Initialization start
        RowCount := 0;
        SQLQuery := '';
        //Initializations end
        /*
    IF ISCLEAR(SQLConnection) THEN
        CREATE(SQLConnection, FALSE, TRUE);

    IF ISCLEAR(RecordSet) THEN
        CREATE(RecordSet, FALSE, TRUE);

    IF ConnectionOpen <> 1 THEN BEGIN
        SQLConnection.ConnectionString := 'DSN=CASHFLOW;UID=cashflowuser;PASSWORD=firewall123;SERVER=oracle_80;';
        SQLConnection.Open;
        SQLConnection.BeginTrans;
        ConnectionOpen := 1;
    END;

    SQLQuery := 'SELECT TENDER_ID FROM MRP_TENDER WHERE ERP_TENDER_NO = ''' + "Tender No." + '''';
    RecordSet := SQLConnection.Execute(SQLQuery);
    IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
        RecordSet.MoveFirst;

    WHILE NOT RecordSet.EOF DO BEGIN
        TenderId := FORMAT(RecordSet.Fields.Item('TENDER_ID').Value);
        RowCount := RowCount + 1;
        RecordSet.MoveNext;
    END;
    IF TenderId <> '' THEN BEGIN
        SQLQuery := 'SELECT EMD_ID FROM MRP_EMD WHERE TENDER_ID = ' + DELCHR(TenderId, '=', ',');
        RecordSet := SQLConnection.Execute(SQLQuery);
        IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
            RecordSet.MoveFirst;

        WHILE NOT RecordSet.EOF DO BEGIN
            EMD_ID := FORMAT(RecordSet.Fields.Item('EMD_ID').Value);
            RowCount := RowCount + 1;
            RecordSet.MoveNext;
        END;
        IF EMD_ID <> '' THEN BEGIN
            SQLQuery := 'UPDATE MRP_EMD SET EMD_STATUS = ''Y'', DD_CHEQUE_NO = ''' + "EMD DD No." + ''' WHERE EMD_ID = ' + DELCHR(EMD_ID, '=', ',') + ' AND TENDER_ID = ' + DELCHR(TenderId, '=', ',');
            SQLConnection.Execute(SQLQuery);
        END;
    END;
    SQLConnection.CommitTrans;
    RecordSet.Close;
    SQLConnection.Close;
    ConnectionOpen := 0;
    MESSAGE('EMD Status is Updated in Cashflow!');
    // End by Pranavi
    */
    end;


    procedure CheckEMDStatus() PaymentId: Code[10];
    var
        RowCount: Integer;
        SQLQuery: Text;
        EMD_ID: Code[10];
        Selection: Integer;
        ConnectionOpen: Integer;
        //>> ORACLE UPG
        /*  SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
         RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset"; */
        //<< ORACLE UPG
        TenderId: Code[10];
        EMDAmount: BigInteger;
        PlanChangeId: Code[10];
    begin
        // Added by Pranavi on 18-May-2016
        //MESSAGE('EMD Status Checking!');
        //Initialization start
        RowCount := 0;
        SQLQuery := '';
        /*
        Initializations end
        
        IF "Sent For Auth" = FALSE THEN
            ERROR('EMD might not be paid in Cashflow. Please send for Authorization!');
        IF ISCLEAR(SQLConnection) THEN
            CREATE(SQLConnection, FALSE, TRUE);

        IF ISCLEAR(RecordSet) THEN
            CREATE(RecordSet, FALSE, TRUE);

        IF ConnectionOpen <> 1 THEN BEGIN
            SQLConnection.ConnectionString := 'DSN=CASHFLOW;UID=cashflowuser;PASSWORD=firewall123;SERVER=oracle_80;';
            SQLConnection.Open;
            SQLConnection.BeginTrans;
            ConnectionOpen := 1;
        END;

        SQLQuery := 'SELECT TENDER_ID FROM MRP_TENDER WHERE ERP_TENDER_NO = ''' + "Tender No." + '''';
        RecordSet := SQLConnection.Execute(SQLQuery);
        IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
            RecordSet.MoveFirst;

        WHILE NOT RecordSet.EOF DO BEGIN
            TenderId := FORMAT(RecordSet.Fields.Item('TENDER_ID').Value);
            RowCount := RowCount + 1;
            RecordSet.MoveNext;
        END;
        IF TenderId <> '' THEN BEGIN
            SQLQuery := 'SELECT EMD_ID FROM MRP_EMD WHERE TENDER_ID = ' + DELCHR(TenderId, '=', ',');
            RecordSet := SQLConnection.Execute(SQLQuery);
            IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                RecordSet.MoveFirst;

            WHILE NOT RecordSet.EOF DO BEGIN
                EMD_ID := FORMAT(RecordSet.Fields.Item('EMD_ID').Value);
                RowCount := RowCount + 1;
                RecordSet.MoveNext;
            END;
            IF EMD_ID <> '' THEN BEGIN
                SQLQuery := 'SELECT * FROM MRP_EMD_OUTFLOW_PLAN_CHANGES WHERE EMD_ID =' + DELCHR(EMD_ID, '=', ',');
                RecordSet := SQLConnection.Execute(SQLQuery);
                IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                    RecordSet.MoveFirst;
                WHILE NOT RecordSet.EOF DO BEGIN
                    PlanChangeId := FORMAT(RecordSet.Fields.Item('PLAN_CHANGE_ID').Value);
                    RowCount := RowCount + 1;
                    RecordSet.MoveNext;
                END;
                IF PlanChangeId <> '' THEN BEGIN
                    SQLQuery := 'SELECT * FROM MRP_EMD_OUTFLOW_PAYMENT WHERE EMD_ID =' + DELCHR(EMD_ID, '=', ',');
                    RecordSet := SQLConnection.Execute(SQLQuery);
                    IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                        RecordSet.MoveFirst;
                    WHILE NOT RecordSet.EOF DO BEGIN
                        PaymentId := FORMAT(RecordSet.Fields.Item('PAYMENT_ID').Value);
                        RowCount := RowCount + 1;
                        RecordSet.MoveNext;
                    END;
                END ELSE
                    PaymentId := 'temp';
            END
            ELSE
                ERROR('EMD is not created in Cashflow.\Please release the tender again to create EMD in Cashflow!');
        END
        ELSE
            ERROR('Tender is not created in ERP.\Please release the tender again to create Tender in Cashflow!');

        SQLConnection.CommitTrans;
        RecordSet.Close;
        SQLConnection.Close;
        ConnectionOpen := 0;
        */
    end;
}

