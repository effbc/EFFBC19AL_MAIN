page 60044 "Indent List"
{
    // version B2B1.0,POAU,Rev01

    CardPageID = Indent;
    Editable = false;
    PageType = List;
    SourceTable = "Indent Header";
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Production Order No."; Rec."Production Order No.")
                {
                    ApplicationArea = All;
                }
                field("ICN No."; Rec."ICN No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("Sale Order No."; Rec."Sale Order No.")
                {
                    ApplicationArea = All;
                }
                field("Delivery Location"; Rec."Delivery Location")
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    ApplicationArea = All;
                }
                field(Control1102152017; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("Enquiry No Series"; Rec."Enquiry No Series")
                {
                    ApplicationArea = All;
                }
                field("Indent Status"; Rec."Indent Status")
                {
                    ApplicationArea = All;
                }
                field("Delivery Place"; Rec."Delivery Place")
                {
                    ApplicationArea = All;
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Released Status"; Rec."Released Status")
                {
                    ApplicationArea = All;
                }
                field("Indent Type"; Rec."Indent Type")
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
            group("&Indent")
            {
                Caption = '&Indent';
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = Comment;
                    RunObject = Page 66;
                    ApplicationArea = All;
                }
                separator(Action1102152034)
                {
                }
                action("Consolidate Indents")
                {
                    Caption = 'Consolidate Indents';
                    Image = Totals;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        IndentHeader: Record "Indent Header";
                        IndentConsolidation: Record "Indent Consolidation";
                        IndentLine: Record "Indent Line";
                        IndentConsolidation1: Record "Indent Consolidation";
                        ItemVendor: Record "Item Vendor";
                    begin
                        Rec.TESTFIELD("No.");
                        Rec.TESTFIELD("ICN No.");
                        Rec.TESTFIELD("Indent Status", Rec."Indent Status"::Indent);
                        IndentConsolidation.DELETEALL;
                        IndentHeader.SETRANGE("ICN No.", Rec."ICN No.");
                        IF IndentHeader.FINDSET THEN
                            REPEAT
                                IndentLine.SETRANGE("Document No.", IndentHeader."No.");
                                IndentLine.SETRANGE(Type, IndentLine.Type::Item);
                                IF IndentLine.FINDSET THEN
                                    REPEAT
                                        IndentConsolidation.INIT;
                                        IndentConsolidation."ICN No." := Rec."ICN No.";
                                        IndentConsolidation."Indent No." := IndentLine."Document No.";
                                        IndentConsolidation."Item No." := IndentLine."No.";
                                        IndentConsolidation.Describtion := IndentLine.Description;
                                        IndentConsolidation.Quantity := IndentLine.Quantity;
                                        IndentConsolidation1.SETRANGE("Item No.", IndentConsolidation."Item No.");
                                        IF IndentConsolidation1.FINDSET THEN BEGIN
                                            REPEAT
                                                IndentConsolidation1.Quantity := IndentConsolidation1.Quantity + IndentConsolidation.Quantity;
                                                IndentConsolidation1.MODIFY;
                                            UNTIL IndentConsolidation1.NEXT = 0;
                                        END ELSE BEGIN
                                            ItemVendor.SETRANGE("Item No.", IndentConsolidation."Item No.");
                                            IF ItemVendor.FINDSET THEN
                                                REPEAT
                                                    IndentConsolidation."Vendor No." := ItemVendor."Vendor No.";
                                                    IndentConsolidation.INSERT;
                                                UNTIL ItemVendor.NEXT = 0;
                                        END;
                                    UNTIL IndentLine.NEXT = 0;
                            UNTIL IndentHeader.NEXT = 0;

                        IndentConsolidation.RESET;
                        IndentConsolidation.SETRANGE("ICN No.", Rec."ICN No.");
                        REPORT.RUN(60005);

                        //MESSAGE('Indents are Converted to Quote');

                        IndentHeader.SETRANGE("ICN No.", Rec."ICN No.");
                        IF IndentHeader.FINDSET THEN
                            REPEAT
                                IndentHeader."Indent Status" := IndentHeader."Indent Status"::Closed;
                                IndentHeader."Released Status" := IndentHeader."Released Status"::Released;
                                IndentHeader.MODIFY;
                                IndentLine.SETRANGE("Document No.", IndentHeader."No.");
                                IndentLine.SETRANGE(Type, IndentLine.Type::Item);
                                IF IndentLine.FINDSET THEN
                                    REPEAT
                                        IndentLine."Indent Status" := IndentLine."Indent Status"::Closed;
                                        IndentLine."Release Status" := IndentLine."Release Status"::Released;
                                        IndentLine.MODIFY;
                                    UNTIL IndentLine.NEXT = 0;
                            UNTIL IndentHeader.NEXT = 0;
                    end;
                }
                action("Make to Quote")
                {
                    Caption = 'Make to Quote';
                    Image = MakeAgreement;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        PurchaseHeader: Record "Purchase Header";
                        PurchaseLine: Record "Purchase Line";
                        PPSetup: Record "Purchases & Payables Setup";
                        NoSeriesMgt: Codeunit 396;
                        Vendor: Record Vendor;
                        IndentLine: Record "Indent Line";
                        IndentConsolidation: Record "Indent Consolidation";
                        IndentConsolidation1: Record "Indent Consolidation";
                    begin
                        Rec.TESTFIELD("ICN No.");
                        IF NOT CONFIRM(Text000, FALSE) THEN
                            EXIT;
                        PurchaseHeader.INIT;
                        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Quote;
                        PPSetup.GET;
                        PurchaseHeader."No." := NoSeriesMgt.GetNextNo(PPSetup."Quote Nos.", WORKDATE, TRUE);
                        PurchaseHeader."Buy-from Vendor No." := '1000';
                        PurchaseHeader.VALIDATE(PurchaseHeader."Buy-from Vendor No.");
                        PurchaseHeader.INSERT;
                        REPEAT
                            PurchaseLine.INIT;
                            PurchaseLine."Document Type" := PurchaseLine."Document Type"::Quote;
                            PurchaseLine."Document No." := PurchaseHeader."No.";
                            PurchaseLine."Line No." := PurchaseLine."Line No." + 10000;
                            PurchaseLine."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                            PurchaseLine.Type := PurchaseLine.Type::Item;
                            PurchaseLine."No." := IndentConsolidation."Item No.";
                            IF PurchaseLine."No." <> '' THEN BEGIN
                                PurchaseLine.VALIDATE(PurchaseLine."No.");
                                PurchaseLine.Quantity := IndentConsolidation.Quantity;
                                PurchaseLine.VALIDATE(PurchaseLine.Quantity);
                                PurchaseLine.INSERT;
                            END;
                        UNTIL IndentConsolidation.NEXT = 0;
                    end;
                }
            }
        }
        area(processing)
        {
            //Caption = '<Action1900000004>';
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Copy Indent")
                {
                    Caption = 'Copy Indent';
                    Image = CopyBudget;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.CopyIndent;
                    end;
                }
                separator(Action1102152024)
                {
                }
                action("Copy &Prod. Order Components")
                {
                    Caption = 'Copy &Prod. Order Components';
                    Image = CopyDocument;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.CopyProdComponents;
                    end;
                }
                separator(Action1102152020)
                {
                }
                action("Copy &Sale Order Lines")
                {
                    Caption = 'Copy &Sale Order Lines';
                    Image = Copy;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.CopySaleOrderLines;
                    end;
                }
                separator(Action1102152016)
                {
                }
                action("Copy &BOM Components")
                {
                    Caption = 'Copy &BOM Components';
                    Image = CopyBOM;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.TESTFIELD("Production BOM No.");
                        Rec.CopyBomComponents;
                    end;
                }
                separator(Action1102152012)
                {
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        test := 0;
                        Rec.TESTFIELD("ICN No.");
                        Rec.TESTFIELD("Delivery Location");
                        Rec.TESTFIELD(Department);
                        indentlines.SETRANGE(indentlines."Document No.", Rec."No.");
                        IF indentlines.FINDSET THEN
                            REPEAT
                                IF (indentlines.Type = indentlines.Type::Item) AND (indentlines.Type = indentlines.Type::Description) THEN BEGIN
                                    indentlines.TESTFIELD(indentlines."No.");
                                    indentlines.TESTFIELD(indentlines.Quantity);
                                    indentlines.TESTFIELD(indentlines."Delivery Location");
                                END;
                            UNTIL indentlines.NEXT = 0;
                        Rec.TESTFIELD(Status, FALSE);      // added By santhosh kumar
                        IF (Rec.Department = 'PROD') AND (Rec."Production Order No." <> 'EFF08MCH01') AND (Rec."Production Order No." <> 'EFF08GEN01')
                           AND (Rec."Production Order No." <> 'EFF08TOL01') THEN BEGIN
                            IF (Rec."Sale Order No." = '') AND (Rec."Tender No." = '') THEN
                                ERROR('You Must Enter Tender or Sale Order No.');
                        END;

                        IF TODAY > Rec."Production Start date" THEN
                            ERROR('Release date is less then the Production start date');

                        IF Rec."Person Code" = '' THEN
                            ERROR('Enter the Person Code');

                        IF ((USERID = '04DI002') OR (USERID = '86SR001') OR (USERID = '93FD001') OR (USERID = 'SUPER') OR (USERID = '05GA003')
                             OR (USERID = '06TE028') OR (USERID = '02DV001') OR (USERID = '10RD010')) AND
                           ((Rec."Delivery Location" = 'STR') AND ((Rec.Department <> 'SYS') AND (Rec.Department <> 'EAC'))) THEN BEGIN
                            charline := 10;
                            Mail_Body := '';
                            "tot value" := 0;
                            //B2B UPG <<<
                            /* Mail_Subject := 'Prod Indent Released';
                            Mail_Body := 'Indent No.            :' + Rec."No.";
                            Mail_Body += FORMAT(charline);
                            Mail_Body += 'Project Description   :' + Rec."Production Order Description";
                            Mail_Body += FORMAT(charline);
                            Mail_Body += 'Production Start Date :' + FORMAT(Rec."Production Start date");
                            Mail_Body += FORMAT(charline);
                            indentlines.SETRANGE(indentlines."Document No.", Rec."No.");
                            IF indentlines.FINDSET THEN
                                REPEAT
                                    item.SETRANGE(item."No.", indentlines."No.");
                                    IF item.FINDFIRST THEN
                                        item_value := item."Avg Unit Cost";
                                    "tot value" += item_value;
                                UNTIL indentlines.NEXT = 0;
                            Mail_Subject += ' Indent Value:' + FORMAT(ROUND("tot value", 0.01));
                            Mail_Body += FORMAT(charline);
                            Mail_Body += FORMAT(charline);
                            Mail_Body += '***** Auto Mail Generated From ERP *****';
                            "Mail-Id".SETRANGE("Mail-Id"."User Name", USERID);
                            IF "Mail-Id".FINDFIRST THEN
                                //"from Mail" := "Mail-Id".MailID;
                            //"to mail" := 'padmaja@efftronics.com,pur@efftronics.com,dmadhavi@efftronics.com,erp@efftronics';
                            "to mail".Add('padmaja@efftronics.com,pur@efftronics.com,dmadhavi@efftronics.com,erp@efftronics.com');
                          
                            //    mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');
                            Rec.ReleaseIndent;
                            test := 10;
                            CurrPage.UPDATE; */    //B2B UPG >>>

                            Mail_Subject := 'Prod Indent Released';
                            Mail_Body := 'Indent No.            :' + Rec."No.";
                            Mail_Body += FORMAT(charline);
                            Mail_Body += 'Project Description   :' + Rec."Production Order Description";
                            Mail_Body += FORMAT(charline);
                            Mail_Body += 'Production Start Date :' + FORMAT(Rec."Production Start date");
                            Mail_Body += FORMAT(charline);
                            indentlines.SETRANGE(indentlines."Document No.", Rec."No.");
                            IF indentlines.FINDSET THEN
                                REPEAT
                                    item.SETRANGE(item."No.", indentlines."No.");
                                    IF item.FINDFIRST THEN
                                        item_value := item."Avg Unit Cost";
                                    "tot value" += item_value;
                                UNTIL indentlines.NEXT = 0;
                            Mail_Subject += ' Indent Value:' + FORMAT(ROUND("tot value", 0.01));
                            Mail_Body += FORMAT(charline);
                            Mail_Body += FORMAT(charline);
                            Mail_Body += '***** Auto Mail Generated From ERP *****';
                            "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                            IF "Mail-Id".FINDFIRST THEN

                                //"to mail".Add('padmaja@efftronics.com,pur@efftronics.com,dmadhavi@efftronics.com,erp@efftronics.com');
                                Recipients.Add('padmaja@efftronics.com');
                            Recipients.Add('pur@efftronics.com');
                            Recipients.Add('dmadhavi@efftronics.com');
                            Recipients.Add('erp@efftronics.com');
                            //    mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');
                            Rec.ReleaseIndent;
                            test := 10;
                            CurrPage.UPDATE;
                        END;

                        IF ((USERID = 'SUPER') OR (USERID = '01RD020') OR (USERID = '10RD010')) AND
                           ((Rec."Delivery Location" = 'STR') AND ((Rec.Department = 'SYS') OR (Rec.Department = 'EAC'))) THEN BEGIN
                            charline := 10;
                            Mail_Body := '';
                            "tot value" := 0;
                            Location.SETRANGE(Location.Code, Rec.Department);
                            IF Location.FINDFIRST THEN
                                //B2B UPG <<<
                                /* Mail_Subject := Location.Name + ' Department Indent Released';
                                Mail_Body := 'Indent No.            :' + Rec."No.";
                                Mail_Body += FORMAT(charline);
                                Mail_Body += 'Project Description   :' + Rec."Production Order Description";
                                Mail_Body += FORMAT(charline);
                                Mail_Body += 'Production Start Date :' + FORMAT(Rec."Production Start date");
                                Mail_Body += FORMAT(charline);
                                indentlines.SETRANGE(indentlines."Document No.", Rec."No.");
                                IF indentlines.FINDSET THEN
                                    REPEAT
                                        item.SETRANGE(item."No.", indentlines."No.");
                                        IF item.FINDFIRST THEN
                                            item_value := item."Avg Unit Cost";
                                        "tot value" += item_value;
                                    UNTIL indentlines.NEXT = 0;
                                Mail_Subject += ' Indent Value:' + FORMAT(ROUND("tot value", 0.01));
                                Mail_Body += FORMAT(charline);
                                Mail_Body += FORMAT(charline);
                                Mail_Body += '***** Auto Mail Generated From ERP *****';
                                "Mail-Id".SETRANGE("Mail-Id"."User Name", USERID);
                                IF "Mail-Id".FINDFIRST THEN
                                    //"from Mail" := "Mail-Id".MailID;
                               // "to mail" := 'kbreddy@efftronics.com,purchase@efftronics.com,dmadhavi@efftronics.com';
                                //  "to mail":='anilkumar@efftronics.COM';
                                Rec.ReleaseIndent;

                                SMTP_MAIL.CreateMessage('INDENT', "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);
                               "to mail".Add('kbreddy@efftronics.com,purchase@efftronics.com,dmadhavi@efftronics.com');

                                SMTP_MAIL.Send;
                                //    mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');
                                test := 10;
                                CurrPage.UPDATE; */ //B2B UPG >>>

                                Mail_Subject := Location.Name + ' Department Indent Released';
                            Mail_Body := 'Indent No.            :' + Rec."No.";
                            Mail_Body += FORMAT(charline);
                            Mail_Body += 'Project Description   :' + Rec."Production Order Description";
                            Mail_Body += FORMAT(charline);
                            Mail_Body += 'Production Start Date :' + FORMAT(Rec."Production Start date");
                            Mail_Body += FORMAT(charline);
                            indentlines.SETRANGE(indentlines."Document No.", Rec."No.");
                            IF indentlines.FINDSET THEN
                                REPEAT
                                    item.SETRANGE(item."No.", indentlines."No.");
                                    IF item.FINDFIRST THEN
                                        item_value := item."Avg Unit Cost";
                                    "tot value" += item_value;
                                UNTIL indentlines.NEXT = 0;
                            Mail_Subject += ' Indent Value:' + FORMAT(ROUND("tot value", 0.01));
                            Mail_Body += FORMAT(charline);
                            Mail_Body += FORMAT(charline);
                            Mail_Body += '***** Auto Mail Generated From ERP *****';
                            "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                            IF "Mail-Id".FINDFIRST THEN
                                Rec.ReleaseIndent;


                            //"to mail".Add('kbreddy@efftronics.com,purchase@efftronics.com,dmadhavi@efftronics.com');
                            Recipients.Add('kbreddy@efftronics.com');
                            Recipients.Add('purchase@efftronics.com');
                            Recipients.Add('dmadhavi@efftronics.com');


                            EmailMessage.Create(Recipients, Mail_Subject, Mail_Body, FALSE);
                            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

                            test := 10;
                            CurrPage.UPDATE;
                        END;

                        IF (USERID = '99PR003') OR (USERID = '99ST005') OR (USERID = '89HW001') OR (USERID = 'SUPER') THEN
                            IF Rec."Delivery Location" = 'CS STR' THEN BEGIN
                                IF ((FORMAT(Rec."Type of Indent") = 'SALE ORDER') OR (FORMAT(Rec."Type of Indent") = 'AMC ORDER')) AND
                                   (Rec."Creation Date" > DMY2Date(04, 01, 10)) then
                                    charline := 10;
                                Mail_Body := '';
                                "tot value" := 0;
                                //B2B UPG >>> 
                                /* Mail_Subject := 'Prod Indent Released';
                                Mail_Body := 'Indent No.            :' + Rec."No.";
                                Mail_Body += FORMAT(charline);
                                Mail_Body += 'Project Description   :' + Rec."Production Order Description";
                                Mail_Body += FORMAT(charline);
                                Mail_Body += 'Production Start Date :' + FORMAT(Rec."Production Start date");
                                Mail_Body += FORMAT(charline);
                                indentlines.SETRANGE(indentlines."Document No.", Rec."No.");
                                IF indentlines.FINDSET THEN
                                    REPEAT
                                        item.SETRANGE(item."No.", indentlines."No.");
                                        IF item.FINDFIRST THEN
                                            item_value := item."Avg Unit Cost";
                                        "tot value" += item_value;
                                    UNTIL indentlines.NEXT = 0;
                                Mail_Subject += ' Indent Value:' + FORMAT(ROUND("tot value", 0.01));
                                Mail_Body += FORMAT(charline);
                                Mail_Body += FORMAT(charline);
                                Mail_Body += '***** Auto Mail Generated From ERP *****';
                                "Mail-Id".SETRANGE("Mail-Id"."User Name", USERID);
                                IF "Mail-Id".FINDFIRST THEN
                                    //"from Mail" := "Mail-Id".MailID;
                                //"to mail" := 'prasanthi@efftronics.com,pur@efftronics.com,ramadevi@efftronics.com,erp@efftronics.com,padmasri@efftronics.com';
                                "to mail".Add('prasanthi@efftronics.com,pur@efftronics.com,ramadevi@efftronics.com,erp@efftronics.com,padmasri@efftronics.com');
                                SMTP_MAIL.CreateMessage('CS INDENT', "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);
                                SMTP_MAIL.Send;

                                //mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');
                                Rec.ReleaseIndent;
                                test := 10;
                                CurrPage.UPDATE; */     //B2B UPG <<<<

                                Mail_Subject := 'Prod Indent Released';
                                Mail_Body := 'Indent No.            :' + Rec."No.";
                                Mail_Body += FORMAT(charline);
                                Mail_Body += 'Project Description   :' + Rec."Production Order Description";
                                Mail_Body += FORMAT(charline);
                                Mail_Body += 'Production Start Date :' + FORMAT(Rec."Production Start date");
                                Mail_Body += FORMAT(charline);
                                indentlines.SETRANGE(indentlines."Document No.", Rec."No.");
                                IF indentlines.FINDSET THEN
                                    REPEAT
                                        item.SETRANGE(item."No.", indentlines."No.");
                                        IF item.FINDFIRST THEN
                                            item_value := item."Avg Unit Cost";
                                        "tot value" += item_value;
                                    UNTIL indentlines.NEXT = 0;
                                Mail_Subject += ' Indent Value:' + FORMAT(ROUND("tot value", 0.01));
                                Mail_Body += FORMAT(charline);
                                Mail_Body += FORMAT(charline);
                                Mail_Body += '***** Auto Mail Generated From ERP *****';
                                "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                                IF "Mail-Id".FINDFIRST THEN

                                    /* "to mail".Add('prasanthi@efftronics.com,pur@efftronics.com,ramadevi@efftronics.com,erp@efftronics.com,padmasri@efftronics.com');
                                    SMTP_MAIL.CreateMessage('CS INDENT', "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);
                                    SMTP_MAIL.Send; */
                                Recipients.Add('prasanthi@efftronics.com');
                                Recipients.Add('pur@efftronics.com');
                                Recipients.Add('ramadevi@efftronics.com');
                                Recipients.Add('erp@efftronics.com');
                                Recipients.Add('padmasri@efftronics.com');
                                EmailMessage.Create(Recipients, Mail_Subject, Mail_Body, true);
                                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

                                Rec.ReleaseIndent;
                                test := 10;
                                CurrPage.UPDATE;
                            END;


                        IF (USERID = '04AN006') OR (USERID = '04AN017') OR (USERID = '05AN006') OR (USERID = '20FT004') OR (USERID = '01TD001') OR (USERID = '02DV001')
                             OR (USERID = 'SUPER') OR (USERID = '10RD010') OR (USERID = '06TE017') OR (USERID = '06TE028') OR (USERID = '05PD012')
                             OR (USERID = '99P2005') OR (USERID = '09RD001') OR (USERID = '07PD034') THEN BEGIN
                            IF Rec."Delivery Location" = 'R&D STR' THEN BEGIN
                                /*IF ("Material Request No."='') AND ((USERID='05PD012') OR (USERID='99P2005') OR (USERID='07PD034')) THEN
                                   ERROR('INDENT MUST BE CONVERTED FROM MATERIAL REQUEST');*/

                                charline := 10;
                                Mail_Body := '';
                                "tot value" := 0;
                                //B2B UPG >>>>
                                /* Mail_Subject := 'R&D Indent Released';
                                "Mail-Id".SETRANGE("Mail-Id"."User Name", USERID);
                                IF "Mail-Id".FINDFIRST THEN BEGIN
                                    "from Mail" := "Mail-Id".MailID;
                                END;
                                "Mail-Id".SETRANGE("Mail-Id"."User Name", Rec."Person Code");
                                IF "Mail-Id".FINDFIRST THEN BEGIN
                                    "to mail" := "Mail-Id".MailID + ',';
                                END;
                                "to mail".Add('anilkumar@efftronics.com,mary@efftronics.com,layouts1@efftronics.com'); 
                                Mail_Body += 'Indent No.  : ' + Rec."No.";
                                Mail_Body += FORMAT(charline);
                                Mail_Body += 'Project Name: ' + Rec."Production Order Description";
                                Mail_Body += FORMAT(charline);
                                Mail_Body += FORMAT(charline);
                                Mail_Body += 'Item Description';
                                FOR i := 1 TO 34 DO
                                    Mail_Body += ' ';
                                Mail_Body += 'Quantity';
                                Mail_Body += FORMAT(charline);
                                indentlines.SETRANGE(indentlines."Document No.", Rec."No.");
                                IF indentlines.FINDSET THEN
                                    REPEAT
                                        IF STRLEN(Mail_Body) < 800 THEN BEGIN
                                            Mail_Body += indentlines.Description;
                                            space := 50 - STRLEN(indentlines.Description);
                                            FOR i := 1 TO space DO
                                                Mail_Body += ' ';
                                            Mail_Body += FORMAT(indentlines.Quantity);
                                            Mail_Body += FORMAT(charline);
                                        END;
                                    UNTIL indentlines.NEXT = 0;
                                Mail_Body += FORMAT(charline);
                                Mail_Body += '***** Auto Mail Generated From ERP *****';
                                Rec.ReleaseIndent;
                                //SMTP_MAIL.CreateMessage('R&D INDENT', "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);
                                EmailMessage.Create("to mail", Mail_Subject, Mail_Body, FALSE);
                                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                                //SMTP_MAIL.Send;
                                test := 10;
                                CurrPage.UPDATE;
                                //mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');


                            END;
                        END;
                        IF test = 0 THEN
                            MESSAGE('YOU DONT HAVE SUFFICIENT RIGHTS TO RELEASE THE INDENT'); */
                                // B2B UPG <<<<

                                Mail_Subject := 'R&D Indent Released';
                                "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                                IF "Mail-Id".FINDFIRST THEN BEGIN
                                    //"from Mail" := "Mail-Id".MailID;
                                END;
                                "Mail-Id".SETRANGE("Mail-Id"."User ID", Rec."User Id");
                                IF "Mail-Id".FINDFIRST THEN BEGIN
                                    //"to mail" := "Mail-Id".MailID + ',';
                                    Recipients.Add("Mail-Id".MailID);
                                END;
                                //"to mail".Add('anilkumar@efftronics.com,mary@efftronics.com,layouts1@efftronics.com'); 
                                Recipients.Add('anilkumar@efftronics.com');
                                Recipients.Add('mary@efftronics.com');
                                Recipients.Add('layouts1@efftronics.com');
                                Mail_Body += 'Indent No.  : ' + Rec."No.";
                                Mail_Body += FORMAT(charline);
                                Mail_Body += 'Project Name: ' + Rec."Production Order Description";
                                Mail_Body += FORMAT(charline);
                                Mail_Body += FORMAT(charline);
                                Mail_Body += 'Item Description';
                                FOR i := 1 TO 34 DO
                                    Mail_Body += ' ';
                                Mail_Body += 'Quantity';
                                Mail_Body += FORMAT(charline);
                                indentlines.SETRANGE(indentlines."Document No.", Rec."No.");
                                IF indentlines.FINDSET THEN
                                    REPEAT
                                        IF STRLEN(Mail_Body) < 800 THEN BEGIN
                                            Mail_Body += indentlines.Description;
                                            space := 50 - STRLEN(indentlines.Description);
                                            FOR i := 1 TO space DO
                                                Mail_Body += ' ';
                                            Mail_Body += FORMAT(indentlines.Quantity);
                                            Mail_Body += FORMAT(charline);
                                        END;
                                    UNTIL indentlines.NEXT = 0;
                                Mail_Body += FORMAT(charline);
                                Mail_Body += '***** Auto Mail Generated From ERP *****';
                                Rec.ReleaseIndent;
                                //SMTP_MAIL.CreateMessage('R&D INDENT', "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);
                                EmailMessage.Create(Recipients, Mail_Subject, Mail_Body, FALSE);
                                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                                //SMTP_MAIL.Send;
                                test := 10;
                                CurrPage.UPDATE;
                                //mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');


                            END;
                        END;
                        IF test = 0 THEN
                            MESSAGE('YOU DONT HAVE SUFFICIENT RIGHTS TO RELEASE THE INDENT');

                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //indentlines.SETRANGE(indentlines."Document No.","No.");
                        //indentlines.SETRANGE(indentlines."Indent Status",indentlines."Indent Status"::Order);
                        //IF NOT indentlines.FINDFIRST THEN
                        //BEGIN
                        Rec.ReopenIndent;
                        CurrPage.UPDATE;
                        //END ELSE
                        //  ERROR('SOME OF THE ITEMS ARE ALL READY ORDERED , SO YOU DONT REOPEN THE ORDER');
                    end;
                }
                action("Ca&ncel")
                {
                    Caption = 'Ca&ncel';
                    Image = Cancel;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.CancelIndent;
                        CurrPage.UPDATE;
                    end;
                }
                action("Clo&se")
                {
                    Caption = 'Clo&se';
                    Image = Close;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.CloseIndent;
                        CurrPage.UPDATE;
                    end;
                }
            }
            action(Comment)
            {
                Caption = 'Comment';
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 66;
                ToolTip = 'Comment';
                ApplicationArea = All;
            }
        }
    }

    var

        Recipients: List of [Text];
        projectcode: Record "Reason Code";
        "Mail-Id": Record "User Setup";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        "from Mail": Text[1000];
        "to mail": List of [text];
        Mail_Subject: Text[1000];
        Mail_Body: Text[1000];
        // mail: Codeunit Mail;
        indentlines: Record "Indent Line";
        charline: Char;
        space: Integer;
        i: Integer;
        item: Record Item;
        item_value: Decimal;
        "tot value": Decimal;
        user: Record User;
        Location: Record Location;
        "Production Order": Record "Production Order";
        //SMTP_MAIL: Codeunit "SMTP Mail";
        test: Integer;
        Text000: Label 'Do U want Convert to Quote?';
}

