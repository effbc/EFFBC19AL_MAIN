page 60042 Indent
{
    // version NAVW17.00,Rev01

    PageType = Document;
    SaveValues = true;
    SourceTable = "Indent Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    AssistEdit = true;
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(Rec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    ApplicationArea = All;
                }
                field("Delivery Location"; Rec."Delivery Location")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Location: REcord Location;
                    begin
                        Location.REset;
                        Location.setfilter(Code, '<>%1&<>%2', 'CS STR', 'R&D STR');
                        if Page.RunModal(0, Location) = action::LookupOK then
                            Rec."Delivery Location" := Location.Code;

                    end;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("Indent Reference"; Rec."Indent Reference")
                {
                    ApplicationArea = All;
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ApplicationArea = All;
                }
                field("Person Code"; Rec."Person Code")
                {
                    ApplicationArea = All;
                }
                field("Production Order No."; Rec."Production Order No.")
                {
                    Caption = 'Project Code';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        "Production Order".SETRANGE("Production Order".Status, "Production Order".Status::Released);
                        "Production Order".SETRANGE("Production Order"."No.", Rec."Production Order No.");
                        IF "Production Order".FINDFIRST THEN
                            Rec."Production Order Description" := "Production Order".Description;
                    end;
                }
                field("Production Order Description"; Rec."Production Order Description")
                {
                    Caption = 'Project Name';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Tender No."; Rec."Tender No.")
                {
                    ApplicationArea = All;
                }
                field("Production Start date"; Rec."Production Start date")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        indentlines.SETRANGE(indentlines."Document No.", Rec."No.");
                        IF indentlines.FINDSET THEN
                            REPEAT
                                indentlines."Production Order Description" := Rec."Production Order Description";
                                indentlines."Production Start date" := Rec."Production Start date";
                                indentlines.MODIFY;
                            UNTIL indentlines.NEXT = 0;
                    end;
                }
                field("Sale Order No."; Rec."Sale Order No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Order Description"; Rec."Sales Order Description")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Caption = 'Creation Date';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("User Id"; Rec."User Id")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Released By"; Rec."Released By")
                {
                    ApplicationArea = All;
                }
                field("Release Date Time"; Rec."Release Date Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Released Status"; Rec."Released Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ICN No."; Rec."ICN No.")
                {
                    ApplicationArea = All;
                }
                field("Tener Description"; Rec."Tener Description")
                {
                    ApplicationArea = All;
                }
                field("Type of Indent"; Rec."Type of Indent")
                {
                    ApplicationArea = All;
                }
                field("IR Number"; Rec."IR Number")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Material Request No."; Rec."Material Request No.")
                {
                    ApplicationArea = All;
                }
            }
            part(Control1102152030; "Indent Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
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
                separator(Action1102152047)
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
                separator(Action1102152052)
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
                separator(Action1102152053)
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
                separator(Action1102152037)
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
                separator(Action1102152056)
                {
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        test := 0;
                        "to mail" := '';
                        Rec.TESTFIELD("ICN No.");
                        Rec.TESTFIELD("Delivery Location");
                        Rec.TESTFIELD(Department);
                        indentlines.SETRANGE(indentlines."Document No.", Rec."No.");
                        IF indentlines.FINDSET THEN
                            REPEAT
                                IF (indentlines.Type = indentlines.Type::Item)/* OR (indentlines.Type=indentlines.Type::Description)*/ THEN BEGIN
                                    indentlines.TESTFIELD(indentlines."No.");
                                    indentlines.TESTFIELD(indentlines.Quantity);
                                    indentlines.TESTFIELD(indentlines."Delivery Location");
                                    item.RESET;        //Added by Pranavi on 27-07-2015 to restrict the item with PO Blocked
                                    item.SETFILTER(item."No.", indentlines."No.");
                                    IF item.FINDFIRST THEN BEGIN
                                        IF item."PO Blocked" = TRUE THEN
                                            ERROR('Indent Cannot be released beacause the Item: ' + item."No." + ' is blocked for PO!');
                                    END;            //End by Pranavi
                                END;
                            UNTIL indentlines.NEXT = 0;
                        Rec.TESTFIELD(Status, FALSE);      // added By santhosh kumar
                        IF (Rec.Department = 'PROD') AND (Rec."Production Order No." <> 'EFF08MCH01') AND (Rec."Production Order No." <> 'EFF08GEN01')
                           AND (Rec."Production Order No." <> 'EFF08TOL01') THEN BEGIN
                            IF (Rec."Sale Order No." = '') AND (Rec."Tender No." = '') THEN
                                ERROR('You Must Enter Tender or Sale Order No.');
                        END;

                        IF TODAY > Rec."Production Start date" THEN
                            //   ERROR('Release date is less then the Production start date');

                            IF Rec."Person Code" = '' THEN
                                ERROR('Enter the Person Code');

                        indent_req_person := Rec."Person Code";
                        user.RESET();
                        user.SETRANGE("User Id", indent_req_person); //B2BUPG
                        IF user.FINDFIRST THEN BEGIN
                            user_dept := COPYSTR(user.Dimension, 1, 2);
                            IF NOT (user_dept IN ['CU', 'RD'])
                              THEN BEGIN
                                user_dept := 'STR';
                            END;
                        END ELSE BEGIN
                            user.RESET();
                            user.SETRANGE(EmployeeID, indent_req_person);
                            IF user.FINDFIRST THEN BEGIN
                                user_dept := COPYSTR(user.Dimension, 1, 2);
                                IF NOT (user_dept IN ['CU', 'RD'])
                                  THEN
                                    user_dept := 'STR';
                            END;
                        END;


                        IF (UPPERCASE(USERID) IN ['EFFTRONICS\PADMAJA','EFFTRONICS\VENU','EFFTRONICS\DMADHAVI','EFFTRONICS\PADMASRI','EFFTRONICS\KRISHNARAO','EFFTRONICS\VAMSIKRISHNAS',
                                                 'EFFTRONICS\ANILKUMAR','EFFTRONICS\BALA','EFFTRONICS\RRAHUL','EFFTRONICS\SPURTHI','EFFTRONICS\GRAVI','EFFTRONICS\SUVARCHALADEVI','EFFTRONICS\DURGAMAHESWARI','EFFTRONICS\MARY','EFFTRONICS\TULASI','EFFTRONICS\ANVESH']) AND
                            ((user_dept = 'STR') AND ((Rec.Department <> 'SYS') AND (Rec.Department <> 'EAC'))) THEN
                        //(("Delivery Location"='STR') AND ((Department<>'SYS') AND (Department<>'EAC')))  THEN
                        BEGIN
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
                            "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);// Rev01
                            IF "Mail-Id".FINDFIRST THEN
                                IF "Mail-Id".MailID <> '' THEN
                                    "from Mail" := "Mail-Id".MailID
                                ELSE
                                    "from Mail" := 'erp@efftronics.com';
                            //"to mail" := 'padmaja@efftronics.com,purchase@efftronics.com,dmadhavi@efftronics.com,padmasri@efftronics.com,erp@efftronics,mary@efftronics.com,tulasi@efftronics.com';
                            // "to mail" += '.com';///B2BUPG
                            Recipients.Add('padmaja@efftronics.com');
                            Recipients.Add('purchase@efftronics.com');
                            Recipients.Add('dmadhavi@efftronics.com');
                            Recipients.Add('padmasri@efftronics.com');
                            Recipients.Add('mary@efftronics.com');
                            Recipients.Add('tulasi@efftronics.com');


                            //    mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');
                            // ADDED BY SUJANI BY ANVESH SIR ORDER TO RESTRICT MANUAL INDENTS RELEASE ON 25-NOV-19 // start begin
                            BEGIN
                                IF COPYSTR(Rec."No.", 1, 6) <> 'IND-AU' THEN BEGIN
                                    IF Manual_indent_release_rights(Rec."No.") THEN BEGIN
                                        Rec.ReleaseIndent;
                                    END
                                    ELSE
                                        ERROR('You are not allowed release manual Indents, Contact Anvesh Sir');
                                END
                                ELSE BEGIN
                                    Rec.ReleaseIndent;
                                    // CurrPage.UPDATE;
                                END;
                            END;
                            // ADDED BY SUJANI BY ANVESH SIR ORDER TO RESTRICT MANUAL INDENTS RELEASE ON 25-NOV-19 // end begin
                            //ReleaseIndent;
                            test := 10;
                            CurrPage.UPDATE;
                        END;

                        IF ( (USERID IN ['SUPER','EFFTRONICS\ANILKUMAR','EFFTRONICS\VENU','EFFTRONICS\PADMASRI','EFFTRONICS\GRAVI','EFFTRONICS\SPURTHI','EFFTRONICS\VISHNUPRIYA','EFFTRONICS\SUJANI',
                                   'EFFTRONICS\SHARMA','EFFTRONICS\PRAVITEJA','EFFTRONICS\MARY','EFFTRONICS\TULASI','EFFTRONICS\RRAHUL','EFFTRONICS\ANVESH','EFFTRONICS\SUVARCHALADEVI','EFFTRONICS\DURGAMAHESWARI'])) AND

                          ((user_dept = 'STR') AND ((Rec.Department = 'SYS') OR (Rec.Department = 'EAC'))) THEN
                        //(("Delivery Location"='STR') AND ((Department='SYS') OR (Department='EAC')))  THEN
                        BEGIN
                            charline := 10;
                            Mail_Body := '';
                            "tot value" := 0;
                            Location.SETRANGE(Location.Code, Rec.Department);
                            IF Location.FINDFIRST THEN
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
                            "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID); //B2BUPG
                            IF "Mail-Id".FINDFIRST THEN
                                /*  IF "Mail-Id".MailID <> '' THEN
                                      "from Mail" := "Mail-Id".MailID
                                  ELSE
                                      "from Mail" := 'erp@efftronics.com';*/ //B2BUPG
                                                                             // "to mail":='kbreddy@efftronics.com,purchase@efftronics.com,dmadhavi@efftronics.com,venu@efftronics.com,eac@efftronics.com';
                                IF (Rec.Department = 'SYS') THEN
                                    // "to mail" := 'sysadmin@efftronics.com,';
                                    // Recipients.Add('sysadmin@efftronics.com');

                                    //ELSE IF (Department='EAC') THEN
                                    // "to mail" := 'eac@efftronics.com,';
                                    //"to mail" += 'purchase@efftronics.com,dmadhavi@efftronics.com,padmasri@efftronics.com,venu@efftronics.com,mary@efftronics.com,tulasi@efftronics.com';//B2BUPG
                                    Recipients.Add('purchase@efftronics.com');
                            Recipients.Add('dmadhavi@efftronics.com');
                            Recipients.Add('padmasri@efftronics.com');
                            Recipients.Add('venu@efftronics.com');
                            Recipients.Add('mary@efftronics.com');
                            Recipients.Add('tulasi@efftronics.com');
                            //  "to mail":='anilkumar@efftronics.COM';
                            //ReleaseIndent;
                            // ADDED BY SUJANI BY ANVESH SIR ORDER TO RESTRICT MANUAL INDENTS RELEASE ON 25-NOV-19 // start begin
                            BEGIN
                                IF COPYSTR(Rec."No.", 1, 6) <> 'IND-AU' THEN BEGIN
                                    IF Manual_indent_release_rights(Rec."No.") THEN BEGIN
                                        Rec.ReleaseIndent;
                                        //CurrPage.UPDATE;
                                    END
                                    ELSE
                                        ERROR('You are not allowed release manual Indents, Contact Anvesh Sir');
                                END
                                ELSE BEGIN
                                    Rec.ReleaseIndent;
                                    // CurrPage.UPDATE;
                                END;
                            END;
                            // ADDED BY SUJANI BY ANVESH SIR ORDER TO RESTRICT MANUAL INDENTS RELEASE ON 25-NOV-19 // end begin
                            CurrPage.UPDATE;

                            // SMTP_MAIL.CreateMessage('INDENT', "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);//B2B UPG
                            EmailMessage.Create(Recipients, Mail_Subject, Mail_Body, FALSE);
                            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                            //  SMTP_MAIL.Send;//B2B UPG
                            //    mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');
                            test := 10;
                            CurrPage.UPDATE;
                        END;

                        IF (USERID IN ['EFFTRONICS\DMADHAVI', 'EFFTRONICS\PRASANTHI', 'EFFTRONICS\TULASI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\PADMASRI', 'EFFTRONICS\GRAVI', 'EFFTRONICS\SPURTHI', 'EFFTRONICS\VISHNUPRIYA',
                          'EFFTRONICS\SUJANI', 'EFFTRONICS\MARY', 'EFFTRONICS\RRAHUL', 'EFFTRONICS\ANVESH', 'EFFTRONICS\DURGAMAHESWARI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\SUVARCHALADEVI']) THEN //EFFUPG1.2
                            IF user_dept = 'CU' THEN
                            //IF "Delivery Location"='CS STR' THEN
                            BEGIN
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
                                "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                                IF "Mail-Id".FINDFIRST THEN
                                    "from Mail" := "Mail-Id".MailID;
                                //"to mail" := 'prasanthi@efftronics.com,purchase@efftronics.com,erp@efftronics.com,padmasri@efftronics.com,mary@efftronics.com,tulasi@efftronics.com';//B2B UPG
                                Recipients.Add('prasanthi@efftronics.com');
                                Recipients.Add('purchase@efftronics.com');
                                Recipients.Add('erp@efftronics.com');
                                Recipients.Add('padmasri@efftronics.com');
                                Recipients.Add('mary@efftronics.com');
                                Recipients.Add('tulasi@efftronics.com');

                                //  SMTP_MAIL.CreateMessage('CS INDENT', "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);
                                EmailMessage.Create(Recipients, Mail_Subject, Mail_Body, FALSE);
                                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                                // SMTP_MAIL.Send;

                                //mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');
                                //ReleaseIndent;
                                // ADDED BY SUJANI BY ANVESH SIR ORDER TO RESTRICT MANUAL INDENTS RELEASE ON 25-NOV-19 // start begin
                                BEGIN
                                    IF COPYSTR(Rec."No.", 1, 6) <> 'IND-AU' THEN BEGIN
                                        IF Manual_indent_release_rights(Rec."No.") THEN BEGIN
                                            Rec.ReleaseIndent;
                                            // CurrPage.UPDATE;
                                        END
                                        ELSE
                                            ERROR('You are not allowed release manual Indents, Contact Anvesh Sir');
                                    END
                                    ELSE BEGIN
                                        Rec.ReleaseIndent;
                                        // CurrPage.UPDATE;
                                    END;
                                END;
                                // ADDED BY SUJANI BY ANVESH SIR ORDER TO RESTRICT MANUAL INDENTS RELEASE ON 25-NOV-19 // end begin
                                test := 10;
                                CurrPage.UPDATE;
                            END;


                        IF USERID IN ['EFFTRONICS\UBEDULLA', 'EFFTRONICS\SOMU', 'EFFTRONICS\BALA', 'EFFTRONICS\PADMASRI', 'EFFTRONICS\GRAVI', 'EFFTRONICS\SBSHANKAR', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\DIVYALAKSHMI', 'EFFTRONICS\ANVESH',
                                      'EFFTRONICS\MARY', 'EFFTRONICS\ANVESH', 'EFFTRONICS\RATNA', 'EFFTRONICS\DMADHAVI', 'EFFTRONICS\TULASI', 'EFFTRONICS\ANANDA', 'EFFTRONICS\RAMASAMY', 'EFFTRONICS\SPURTHI', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\SUJANI', 'EFFTRONICS\RRAHUL', 'EFFTRONICS\DURGAMAHESWARI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\SUVARCHALADEVI'] THEN BEGIN//EFFUPG1.2
                            IF user_dept = 'RD' THEN
                            //IF "Delivery Location"='R&D STR' THEN
                            BEGIN
                                /*IF ("Material Request No."='') AND ((USERID='05PD012') OR (USERID='EFFTRONICS\MARY') OR (USERID='EFFTRONICS\RATNA')) THEN
                                   ERROR('INDENT MUST BE CONVERTED FROM MATERIAL REQUEST');*/

                                charline := 10;
                                Mail_Body := '';
                                "tot value" := 0;
                                Mail_Subject := 'R&D Indent Released';
                                "Mail-Id".RESET;
                                "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);// Rev01
                                IF "Mail-Id".FINDFIRST THEN BEGIN
                                    "from Mail" := "Mail-Id".MailID;
                                END;
                                "Mail-Id".RESET;
                                "Mail-Id".SETRANGE("Mail-Id"."User ID", Rec."Person Code");
                                IF "Mail-Id".FINDFIRST THEN BEGIN
                                    IF "Mail-Id".MailID <> '' THEN
                                        "to mail" := "Mail-Id".MailID;
                                END;
                                // "to mail" += 'anilkumar@efftronics.com,mary@efftronics.com,layouts1@efftronics.com,tulasi@efftronics.com';//B2B UPG
                                Recipients.Add('anilkumar@efftronics.com');
                                Recipients.Add('mary@efftronics.com');
                                Recipients.Add('layouts1@efftronics.com');
                                Recipients.Add('tulasi@efftronics.com');
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
                                // ReleaseIndent;
                                // ADDED BY SUJANI BY ANVESH SIR ORDER TO RESTRICT MANUAL INDENTS RELEASE ON 25-NOV-19 // start begin
                                BEGIN
                                    IF COPYSTR(Rec."No.", 1, 6) <> 'IND-AU' THEN BEGIN
                                        IF Manual_indent_release_rights(Rec."No.") THEN BEGIN
                                            Rec.ReleaseIndent;
                                            //CurrPage.UPDATE;
                                        END
                                        ELSE
                                            ERROR('You are not allowed release manual Indents, Contact Anvesh Sir');
                                    END
                                    ELSE BEGIN
                                        Rec.ReleaseIndent;
                                        //CurrPage.UPDATE;
                                    END;
                                END;
                                // ADDED BY SUJANI BY ANVESH SIR ORDER TO RESTRICT MANUAL INDENTS RELEASE ON 25-NOV-19 // end begin
                                // SMTP_MAIL.CreateMessage('R&D INDENT', "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);
                                //SMTP_MAIL.Send;

                                EmailMessage.Create(Recipients, Mail_Subject, Mail_Body, FALSE);
                                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                                test := 10;
                                CurrPage.UPDATE;
                                //mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');


                            END;
                        END;
                        //added by pranavi on 20-05-2015 for auto mail to TEMC for FILM Capacitors, Varistors
                        TCount := 0;
                        indentlines.RESET;
                        indentlines.SETFILTER(indentlines."Document No.", Rec."No.");
                        IF indentlines.FINDSET THEN
                            REPEAT
                                item.RESET;
                                item.SETFILTER(item."No.", indentlines."No.");
                                IF item.FINDFIRST THEN BEGIN
                                    IF (item."Item Sub Group Code" = 'FILM') OR (item."Product Group Code Cust" = 'VARIST') THEN BEGIN
                                        TCount := TCount + 1;
                                    END;
                                END;
                            UNTIL indentlines.NEXT = 0;
                        IF (TCount > 0) THEN BEGIN
                            charline := 10;
                            Mail_Subject := 'ERP - Indent Released for Film Capacitors, MOVS';
                            // "to mail" := 'temc@efftronics.com';
                            // "to mail" := ' erp@efftronics.com';
                            // "to mail" := 'anilkumar@efftronics.com';
                            //B2B UPG
                            Recipients.Add('temc@efftronics.com');
                            Recipients.Add('erp@efftronics.com');
                            Recipients.Add('anilkumar@efftronics.com');

                            // "from Mail" := 'erp@efftronics.com';
                            Mail_Body := '';
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
                                    item.SETRANGE(item."No.", indentlines."No.");
                                    IF item.FINDFIRST THEN BEGIN
                                        IF (item."Item Sub Group Code" = 'FILM') OR (item."Product Group Code Cust" = 'VARIST') THEN BEGIN
                                            IF STRLEN(Mail_Body) < 800 THEN BEGIN
                                                Mail_Body += indentlines.Description;
                                                space := 50 - STRLEN(indentlines.Description);
                                                FOR i := 1 TO space DO
                                                    Mail_Body += ' ';
                                                Mail_Body += FORMAT(indentlines.Quantity);
                                                Mail_Body += FORMAT(charline);
                                            END;
                                        END;
                                    END;
                                UNTIL indentlines.NEXT = 0;
                            Mail_Body += FORMAT(charline);
                            Mail_Body += '***** Auto Mail Generated From ERP *****';
                            //ReleaseIndent;
                            // ADDED BY SUJANI BY ANVESH SIR ORDER TO RESTRICT MANUAL INDENTS RELEASE ON 25-NOV-19 // start begin
                            BEGIN
                                IF COPYSTR(Rec."No.", 1, 6) <> 'IND-AU' THEN BEGIN
                                    IF Manual_indent_release_rights(Rec."No.") THEN BEGIN
                                        Rec.ReleaseIndent;
                                        // CurrPage.UPDATE;
                                    END
                                    ELSE
                                        ERROR('You are not allowed release manual Indents, Contact Anvesh Sir');
                                END
                                ELSE BEGIN
                                    Rec.ReleaseIndent;
                                    //  CurrPage.UPDATE;
                                END;
                            END;
                            // ADDED BY SUJANI BY ANVESH SIR ORDER TO RESTRICT MANUAL INDENTS RELEASE ON 25-NOV-19 // end begin

                            //SMTP_MAIL.CreateMessage(Rec."Delivery Location", "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);
                            EmailMessage.Create(Recipients, Mail_Subject, Mail_Body, true);
                            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                            //SMTP_MAIL.Send;
                            test := 10;
                            CurrPage.UPDATE;
                        END;
                        //end by pranavi

                        IF test = 0 THEN
                            MESSAGE('YOU DONT HAVE SUFFICIENT RIGHTS TO RELEASE THE INDENT');

                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        indentlines.SETRANGE(indentlines."Document No.", Rec."No.");
                        indentlines.SETRANGE(indentlines."Indent Status", indentlines."Indent Status"::Order);
                        IF NOT indentlines.FINDFIRST THEN BEGIN
                            Rec.ReopenIndent;
                            CurrPage.UPDATE;
                        END ELSE
                            IF USERID <> 'EFFTRONICS\VISHNUPRIYA' THEN
                                ERROR('SOME OF THE ITEMS ARE ALL READY ORDERED , SO YOU DONT REOPEN THE ORDER');
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
        Text000: Label 'Do U want Convert to Quote?';
        projectcode: Record "Reason Code";
        "Mail-Id": Record "User Setup";
        "from Mail": Text[1000];
        "to mail": Text;
        Mail_Subject: Text;
        Mail_Body: Text[1000];
        // mail: Codeunit Mail;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        indentlines: Record "Indent Line";
        charline: Char;
        space: Integer;
        i: Integer;
        item: Record Item;
        item_value: Decimal;
        "tot value": Decimal;
        user: Record "User Setup";
        Location: Record Location;
        "Production Order": Record "Production Order";
        //SMTP_MAIL: Codeunit "SMTP Mail";
        test: Integer;
        TCount: Integer;
        IndentHeader: Record "Indent Header";
        indent_req_person: Text[500];
        user_dept: Text[500];


    procedure Manual_indent_release_rights(IndentNo: Code[20]) Authorized: Boolean;
    begin
         IF USERID IN ['EFFTRONICS\ANVESH','EFFTRONICS\ANILKUMAR','EFFTRONICS\SUVARCHALADEVI','EFFTRONICS\DURGAMAHESWARI'] THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;
}

