page 60173 "To Be Released Indents List"
{
    // version Rev01

    CardPageID = "To Be Released Indents";
    Editable = false;
    PageType = List;
    SourceTable = "Indent Header";
    SourceTableView = SORTING("No.") ORDER(Ascending) WHERE("Released Status" = CONST(Open));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field(Make; Rec.Make)
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Delivery Location"; Rec."Delivery Location")
                {
                    ApplicationArea = All;
                }
                field(Equipment; Rec.Equipment)
                {
                    ApplicationArea = All;
                }
                field("Drawing No."; Rec."Drawing No.")
                {
                    ApplicationArea = All;
                }
                field("Person Code"; Rec."Person Code")
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
                    RunObject = Page "Purch. Comment Sheet";
                    ApplicationArea = All;
                }
                separator(Action1102152027)
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
                separator(Action1102152021)
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
                separator(Action1102152019)
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
                separator(Action1102152017)
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
                separator(Action1102152015)
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
                        Rec.TESTFIELD("ICN No.");
                        Rec.TESTFIELD("Delivery Location");
                        Rec.TESTFIELD(Department);
                        indentlines.SETRANGE(indentlines."Document No.", Rec."No.");
                        indentlines.SETFILTER(indentlines.Type, '<>%1', indentlines.Type::Description);
                        IF indentlines.FINDSET THEN
                            REPEAT
                                indentlines.TESTFIELD(indentlines.Quantity);
                                indentlines.TESTFIELD(indentlines."Delivery Location");
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
                                               OR (USERID = '10RD010')) AND
                           ((Rec."Delivery Location" = 'STR') AND ((Rec.Department <> 'SYS') AND (Rec.Department <> 'EAC'))) THEN BEGIN
                            Rec.ReleaseIndent;
                            CurrPage.UPDATE;
                        END;

                        IF ((USERID = 'SUPER') OR (USERID = '01RD020') OR (USERID = '10RD010')) AND
                           ((Rec."Delivery Location" = 'STR') AND ((Rec.Department = 'SYS') OR (Rec.Department = 'EAC'))) THEN BEGIN
                            charline := 10;
                            Mail_Body := '';
                            "tot value" := 0;
                            Location.SETRANGE(Location.Code, Rec.Department);
                            IF Location.FINDFIRST THEN
                                Mail_Subject := 'ERP - ' + Location.Name + ' Department Indent Released';
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
                            //Rev01 Start
                            //Code Commented
                            /*
                            "Mail-Id".SETRANGE("Mail-Id"."User Security ID",USERID);
                            */
                            "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                            //Rev01 End

                            //B2B UPG >>>
                            /*IF "Mail-Id".FINDFIRST THEN
                                "from Mail" := "Mail-Id".MailID;
                            "to mail" := 'kbreddy@efftronics.com,purchase@efftronics.com,dmadhavi@efftronics.com';
                            //  "to mail":='anilkumar@efftronics.COM';
                            Rec.ReleaseIndent;
                            SMTP_MAIL.CreateMessage('INDENT', "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);

                            SMTP_MAIL.Send; */
                            //B2B UPG <<<

                            IF "Mail-Id".FINDFIRST THEN
                                //"from Mail" := "Mail-Id".MailID;
                                Recipient.Add('kbreddy@efftronics.com');
                            Recipient.Add('purchase@efftronics.com');
                            Recipient.Add('dmadhavi@efftronics.com');
                            //Recipients.Add('anilkumar@efftronics.COM');
                            Rec.ReleaseIndent;
                            EmailMessage.Create(Recipient, Mail_Subject, Mail_Body, FALSE);
                            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);


                            //    mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');

                            CurrPage.UPDATE;
                        END;

                        IF (USERID = '99PR003') OR (USERID = '99ST005') OR (USERID = '89HW001') OR (USERID = '10RD010') THEN
                            IF Rec."Delivery Location" = 'CS STR' THEN BEGIN
                                IF ((FORMAT(Rec."Type of Indent") = 'SALE ORDER') OR (FORMAT(Rec."Type of Indent") = 'AMC ORDER')) AND
                                   (Rec."Creation Date" > DMY2Date(04, 01, 10)) THEN
                                    Rec.TESTFIELD("Sale Order No.");

                                charline := 10;
                                Mail_Body := '';
                                "tot value" := 0;
                                Mail_Subject := 'ERP - Prod Indent Released';
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
                                //Rev01 Start
                                //Code Commented
                                /*
                                "Mail-Id".SETRANGE("Mail-Id"."User Security ID",USERID);
                                */
                                "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                                //Rev01 End
                                IF "Mail-Id".FINDFIRST THEN
                                    "from Mail" := "Mail-Id".MailID;
                                /*  "to mail" := 'prasanthi@efftronics.com,purchase@efftronics.com,ramadevi@efftronics.com,erp@efftronics.com,';
                                  "to mail" += 'padmasri@efftronics.com';*/

                                //B2BUPG
                                Recipient.Add('prasanthi@efftronics.com');
                                Recipient.Add('purchase@efftronics.com');
                                Recipient.Add('ramadevi@efftronics.com');
                                Recipient.Add('erp@efftronics.com');
                                //   SMTP_MAIL.CreateMessage('CS INDENT', "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);
                                EmailMessage.Create(Recipient, Mail_Subject, Mail_Body, FALSE);
                                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                                //B2BUPG

                                //mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');
                                Rec.ReleaseIndent;
                                CurrPage.UPDATE;
                            END;


                        IF (USERID = '04AN006') OR (USERID = '04AN017') OR (USERID = '05AN006') OR (USERID = '20FT004') OR (USERID = '01TD001') OR (USERID = '02DV001')
                             OR (USERID = 'SUPER') OR (USERID = '10RD010') OR (USERID = '06TE017') OR (USERID = '06TE028') OR (USERID = '05PD012')
                             OR (USERID = '99P2005') OR (USERID = '01QC001') THEN BEGIN
                            IF Rec."Delivery Location" = 'R&D STR' THEN BEGIN
                                /* IF ("Material Request No."='') AND (USERID='99P2005') THEN
                                    ERROR('INDENT MUST BE CONVERTED FROM MATERIAL REQUEST');*/

                                charline := 10;
                                Mail_Body := '';
                                "tot value" := 0;
                                Mail_Subject := 'ERP - R&D Indent Released';
                                // MESSAGE(USERID);
                                //Rev01 Start
                                //Code Commented
                                /*
                                "Mail-Id".SETRANGE("Mail-Id"."User Security ID",USERID);
                                */
                                "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                                //Rev01 End
                                IF "Mail-Id".FINDFIRST THEN BEGIN
                                    "from Mail" := "Mail-Id".MailID;
                                END;
                                //    MESSAGE("from Mail");
                                //Rev01 Start
                                //Code Commented
                                /*
                                "Mail-Id".SETRANGE("Mail-Id"."User Security ID","Person Code");
                                */
                                "Mail-Id".SETRANGE("Mail-Id"."User ID", Rec."Person Code");
                                //Rev01 End
                                "Mail-Id".SETRANGE("Mail-Id"."User ID", Rec."Person Code");
                                IF "Mail-Id".FINDFIRST THEN BEGIN
                                    //"to mail" := "Mail-Id".MailID + ','; //B2B UPG
                                    Recipient.Add("Mail-Id".MailID);
                                END;
                                //"to mail" += 'anilkumar@efftronics.com,mary@efftronics.com,layouts1@efftronics.com'; //B2B UPG
                                Recipient.Add('anilkumar@efftronics.com');
                                Recipient.Add('mary@efftronics.com');
                                Recipient.Add('layouts1@efftronics.com');
                                charline := 10;
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
                                EmailMessage.Create(Recipient, Mail_Subject, Mail_Body, FALSE);
                                // SMTP_MAIL.Send;
                                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                                CurrPage.UPDATE;
                                //mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');


                            END;
                        END;

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
                RunObject = Page "Purch. Comment Sheet";
                ToolTip = 'Comment';
                ApplicationArea = All;
            }
            action("<CS Stock Indents>")
            {
                Caption = 'CS Stock Indents';
                ApplicationArea = All;

                trigger OnAction();
                var
                    Items: Record Item;
                    IH: Record "Indent Header";
                    IL: Record "Indent Line";
                    PH: Record "Purchase Header";
                    PL: Record "Purchase Line";
                    IndentQuantity: Integer;
                    PurchaseQuantity: Integer;
                    StockStatus: Integer;
                    User: Record User;
                    NoSeriesMgt: Codeunit 396;
                    Indent_No: Code[20];
                    UserName: Code[100];
                    Line_No: Integer;
                    "No. Series": Record "No. Series";
                    "No. Series Line": Record "No. Series Line";
                    Qty: Integer;
                    IL1: Record "Indent Line";
                    OrderQty: Integer;
                    NO: Text;
                    ProdOrder: Record "Production Order";
                    WINDOW: Dialog;
                    T1: Label '#1##################  FOR Minimum Stock';
                begin
                    // Added by Vijaya on 02-Mar-17
                    NoSeriesMgt.InitSeries('P-INDENT', 'P-INDENT', TODAY, Indent_No, IH."No. Series");
                    User.RESET;
                    User.SETRANGE(User."User Name", USERID);
                    IF User.FINDFIRST THEN
                        UserName := User."Full Name";
                    IndentQuantity := 0;
                    WINDOW.OPEN(T1);
                    IH.RESET;
                    IH.INIT;
                    IH."No." := Indent_No;
                    IH.Description := 'Created for CS Minimum Stock';
                    IH."Contact Person" := UserName;
                    IH."Delivery Location" := 'CS STR';
                    IH.Department := 'SITE';
                    IH."Indent Reference" := UserName;
                    IH."Person Code" := USERID;
                    IH."User Id" := USERID;
                    IH."ICN No." := ICNNO(TODAY);
                    IH."Creation Date" := TODAY;
                    IH."Production Order No." := 'EFF12CST01';
                    IH."Production Order Description" := 'ALL DEPARTMENTS GENERALPURPOSE';
                    IH.VALIDATE(IH."Production Order No.", 'EFF12CST01');
                    IH.INSERT;
                    Line_No := 0;

                    Qty := 0;
                    Items.RESET;
                    Items.SETFILTER(Items."Safety Stock Qty (CS)", '> %1', 1);
                    Items.SETRANGE(Items.Blocked, FALSE);
                    IF Items.FINDSET THEN
                        REPEAT
                            Items.CALCFIELDS(Items."Stock at CS Stores");
                            IF Items."Stock at CS Stores" < Items."Safety Stock Qty (CS)" THEN BEGIN
                                PurchaseQuantity := 0;
                                PL.RESET;
                                PL.SETRANGE(PL."No.", Items."No.");
                                PL.SETFILTER(PL."Qty. to Receive", '> %1', 0);
                                PL.SETRANGE(PL."Location Code", 'CS STR');
                                IF PL.FINDFIRST THEN
                                    REPEAT
                                        PurchaseQuantity += PL."Qty. to Receive";
                                    UNTIL PL.NEXT = 0;
                                IF (Items."Stock at CS Stores" + PurchaseQuantity) < Items."Safety Stock Qty (CS)" THEN BEGIN
                                    IndentQuantity := 0;
                                    IL1.RESET;
                                    IL1.SETRANGE(IL1."No.", Items."No.");
                                    IL1.SETRANGE(IL1."Indent Status", 0);
                                    IL1.SETRANGE(IL1."Delivery Location", 'CS STR');
                                    IF IL1.FINDSET THEN
                                        REPEAT
                                            IndentQuantity += IL1."Quantity To Be Ordered";
                                        UNTIL IL1.NEXT = 0;
                                    IF (Items."Stock at CS Stores" + PurchaseQuantity + IndentQuantity) < Items."Safety Stock Qty (CS)" - 1 THEN BEGIN
                                        WINDOW.UPDATE(1, Items."No.");
                                        IL.RESET;
                                        IL.INIT;
                                        IL."Document No." := Indent_No;
                                        Line_No += 10000;
                                        IL."Line No." := Line_No;
                                        NO := Items."No.";
                                        IL."No." := NO;
                                        IL.VALIDATE(IL."No.", NO);
                                        IL."Delivery Location" := 'CS STR';
                                        IL."ICN No." := ICNNO(TODAY);
                                        IL.Description := Items.Description;
                                        OrderQty := ROUND(Items."Safety Stock Qty (CS)" - (Items."Stock at CS Stores" + PurchaseQuantity + IndentQuantity), 1);
                                        IL.Quantity := OrderQty;
                                        IL."Quantity To Be Ordered" := OrderQty;
                                        IL.INSERT;
                                        Qty += 1;
                                    END;
                                END;
                            END;
                        UNTIL Items.NEXT = 0;
                    WINDOW.CLOSE;
                    CurrPage.UPDATE(FALSE);
                    //end by Vijaya
                end;
            }
        }
    }

    var
        Recipient: List of [Text];
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        projectcode: Record "Reason Code";
        "Mail-Id": Record "User Setup";
        "from Mail": Text[1000];
        "to mail": Text[1000];
        Mail_Subject: Text[1000];
        Mail_Body: Text[1000];
        mail: Codeunit Mail;
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
        Text000: Label 'Do U want Convert to Quote?';


    procedure ICNNO(DT: Date) ICN: Code[10];
    var
        Dat: Code[10];
        Mon: Code[10];
        Yer: Code[10];
    begin
        IF DATE2DMY(DT, 1) < 10 THEN
            Dat := '0' + FORMAT(DATE2DMY(DT, 1))
        ELSE
            Dat := FORMAT(DATE2DMY(DT, 1));

        IF DATE2DMY(DT, 2) < 10 THEN
            Mon := '0' + FORMAT(DATE2DMY(DT, 2))
        ELSE
            Mon := FORMAT(DATE2DMY(DT, 2));

        //IF DATE2DMY(DT,2) < 10 THEN
        Yer := COPYSTR(FORMAT(DATE2DMY(DT, 3)), 3, 2);
        ICN := Dat + Mon + Yer;
        EXIT(ICN);
    end;
}

