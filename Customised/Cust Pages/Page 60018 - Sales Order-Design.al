page 60018 "Sales Order-Design"
{
    // version B2B1.0,DIM1.0,Rev01

    // PROJECT : Efftronics
    // ********************************************************************************************************************************************
    // SIGN
    // ********************************************************************************************************************************************
    // B2B     : B2B Software Technologies
    // ********************************************************************************************************************************************
    // VER      SIGN   USERID                 DATE                          DESCRIPTION
    // ********************************************************************************************************************************************
    // 1.0       DIM   Sivaramakrishna.A      24-May-13            -> Code has been commented in ConvertOrdertoExportOrder() For Document Dimensions
    //                                                                Tables are does not exist in the NAV 2013 and added new Code to Modify the
    //                                                                Dimension Set ID in SalesExportOrderHeader and insert the Dimension Set ID in SalesExportorderLine

    Caption = 'Sales Order';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order), "Document Position" = CONST(Design));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("No."; "No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        SelltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Sell-to Contact No."; "Sell-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address"; "Sell-to Address")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address 2"; "Sell-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; "Sell-to Post Code")
                {
                    Caption = 'Sell-to Post Code/City';
                    ApplicationArea = All;
                }
                field("Sell-to City"; "Sell-to City")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Contact"; "Sell-to Contact")
                {
                    ApplicationArea = All;
                }
                field(State; State)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                /* field(Structure; Structure)
                 {
                 }
                 field("Free Supply"; "Free Supply")
                 {
                 }*/
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; "Order Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; "Requested Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Promised Delivery Date"; "Promised Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Campaign No."; "Campaign No.")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
            }
            part(SalesLines; "Sales Order Subform-Design")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            field("SalOrd Des Approval"; "SalOrd Des Approval")
            {
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    SalOrdDesApprovalOnPush;
                end;
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                Editable = false;
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        BilltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Bill-to Contact No."; "Bill-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Name"; "Bill-to Name")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address"; "Bill-to Address")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address 2"; "Bill-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; "Bill-to Post Code")
                {
                    Caption = 'Bill-to Post Code/City';
                    ApplicationArea = All;
                }
                field("Bill-to City"; "Bill-to City")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; "Bill-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Tax Area Code"; "Tax Area Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                /*field("Form Code"; "Form Code")
                {
                }
                field("Form No."; "Form No.")
                {
                }*/
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; "Payment Method Code")
                {
                    ApplicationArea = All;
                }
                /*field("LC No."; "LC No.")
                {
                }*/
                field("No. of Archived Versions"; "No. of Archived Versions")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    var
                        SalesHeaderArchive: Record "Sales Header Archive";
                    begin
                        CurrPage.SAVERECORD;
                        COMMIT;
                        SalesHeaderArchive.SETRANGE("Document Type", "Document Type"::Order);
                        SalesHeaderArchive.SETRANGE("No.", "No.");
                        SalesHeaderArchive.SETRANGE("Doc. No. Occurrence", "Doc. No. Occurrence");
                        IF SalesHeaderArchive.GET("Document Type"::Order, "No.", "Doc. No. Occurrence", "No. of Archived Versions") THEN;
                        PAGE.RUNMODAL(PAGE::"Sales List Archive", SalesHeaderArchive);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                Editable = false;
                field("Ship-to Code"; "Ship-to Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Name"; "Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; "Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; "Ship-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; "Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code/City';
                    ApplicationArea = All;
                }
                field("Ship-to City"; "Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; "Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                /*"field("Transi"t Docum"ent""; "Transit Document")
                {
                }*/
                field("Posting No. Series"; "Posting No. Series")
                {
                    ApplicationArea = All;
                }
                field("Shipping No. Series"; "Shipping No. Series")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Outbound Whse. Handling Time"; "Outbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; "Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; "Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Service Code"; "Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Time"; "Shipping Time")
                {
                    ApplicationArea = All;
                }
                field("Late Order Shipping"; "Late Order Shipping")
                {
                    ApplicationArea = All;
                }
                field("Package Tracking No."; "Package Tracking No.")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Shipping Advice"; "Shipping Advice")
                {
                    ApplicationArea = All;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                Editable = false;
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date");
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("EU 3-Party Trade"; "EU 3-Party Trade")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; "Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; "Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Exit Point"; "Exit Point")
                {
                    ApplicationArea = All;
                }
                field("Area"; Area)
                {
                    ApplicationArea = All;
                }
            }
            group(" Others")
            {
                Caption = '" Others"';
                Editable = false;
                field("RDSO Charges Paid By"; "RDSO Charges Paid By")
                {
                    ApplicationArea = All;
                }
                field("CA Number"; "CA Number")
                {
                    ApplicationArea = All;
                }
                field("CA Date"; "CA Date")
                {
                    ApplicationArea = All;
                }
                field("LD Amount"; "LD Amount")
                {
                    ApplicationArea = All;
                }
                field("Document Position"; "Document Position")
                {
                    ApplicationArea = All;
                }
                field("Tender No."; "Tender No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Release To Sales")
                {
                    Caption = 'Release To Sales';
                    Image = ReleaseDoc;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        Text01: Label 'Do You want to Send the Document to Sale?';
                    begin
                        //B2B UPG
                        /* IF NOT CONFIRM(Text01, FALSE) THEN
                            EXIT;
                        TESTFIELD("Document Position", "Document Position"::Design);
                        "Document Position" := "Document Position"::Sales;
                        MODIFY;
                        user.GET(USERID);
                        newline := 10;
                        Mail_Subject := 'Order released back to Sales';
                        Mail_Body := 'Order No      : ' + "No.";
                        Mail_Body += FORMAT(newline);
                        Mail_Body += 'Customer Name : ' + "Sell-to Customer Name";
                        Mail_Body += FORMAT(newline);
                        Mail_Body += FORMAT(newline);
                        Mail_Body += '***** Auto Mail Generated From ERP *****';

                        "Mail-Id".SETRANGE("Mail-Id"."User Security ID", USERID);
                        IF "Mail-Id".FINDFIRST THEN
                            "from Mail" := "Mail-Id".MailID;
                        //  "to mail":='sal@efftronics.com,erp@efftronics.com,cvmohan@efftronics.com';
                        salesheader.RESET;
                        salesheader.SETFILTER(salesheader."No.", "No.");
                        REPORT.RUN(60004, FALSE, FALSE, salesheader);
                        REPORT.SAVEASHTML(60004, '\\erpserver\ErpAttachments\SALEORDER2.html', FALSE, salesheader);
                        Attachment1 := '\\erpserver\ErpAttachments\SALEORDER2.html';
                        Mail_Subject := 'Design modifications of Sale order ' + xRec."No." + 'Transfer By ' + user."User Name";
                        "to mail" := 'jhansi@efftronics.com,anilkumar@efftronics.com,sal@efftronics.com';

                        IF ("from Mail" <> '') AND ("to mail" <> '') THEN BEGIN
                            SMTP_MAIL.CreateMessage('ERP', "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);
                            SMTP_MAIL.AddAttachment(Attachment1, '');//EFFUPG Added ('')
                            SMTP_MAIL.Send;
                        END; */   //B2B UPG

                        IF NOT CONFIRM(Text01, FALSE) THEN
                            EXIT;
                        TESTFIELD("Document Position", "Document Position"::Design);
                        "Document Position" := "Document Position"::Sales;
                        MODIFY;
                        user.GET(USERID);
                        newline := 10;
                        Mail_Subject := 'Order released back to Sales';
                        Mail_Body := 'Order No      : ' + "No.";
                        Mail_Body += FORMAT(newline);
                        Mail_Body += 'Customer Name : ' + "Sell-to Customer Name";
                        Mail_Body += FORMAT(newline);
                        Mail_Body += FORMAT(newline);
                        Mail_Body += '***** Auto Mail Generated From ERP *****';

                        "Mail-Id".SETRANGE("Mail-Id"."User Security ID", USERID);
                        IF "Mail-Id".FINDFIRST THEN
                            salesheader.RESET;
                        salesheader.SETFILTER(salesheader."No.", "No.");
                        REPORT.RUN(60004, FALSE, FALSE, salesheader);
                        REPORT.SAVEASHTML(60004, '\\erpserver\ErpAttachments\SALEORDER2.html', salesheader);
                        Attachment1 := '\\erpserver\ErpAttachments\SALEORDER2.html';
                        Mail_Subject := 'Design modifications of Sale order ' + xRec."No." + 'Transfer By ' + user."User Name";
                        //"to mail" := 'jhansi@efftronics.com,anilkumar@efftronics.com,sal@efftronics.com';
                        Recipient.Add('jhansi@efftronics.com');
                        Recipient.Add('anilkumar@efftronics.com');
                        Recipient.Add('sal@efftronics.com');

                        /* IF ("from Mail" <> '') AND ("to mail" <> '') THEN BEGIN
                            //  SMTP_MAIL.CreateMessage('ERP', "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);
                            EmailMessage.Create("to mail", Mail_Subject, Mail_Body, false);
                            SMTP_MAIL.AddAttachment(Attachment1, '');//EFFUPG Added ('')
                            Email.send(EmailMessage, Enum::"Email Scenario"::Default);

                            //  SMTP_MAIL.Send;
                        END; */
                        EmailMessage.Create(Recipient, Mail_Subject, Mail_Body, FALSE);
                        EmailMessage.AddAttachment(Attachment1, '', '');
                        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                    end;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean;
    begin
        CurrPage.UPDATE;
        MODIFY;
        EXIT(ConfirmDeletion);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        CheckCreditMaxBeforeInsert;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        "Responsibility Center" := UserMgt.GetSalesFilter();
    end;

    trigger OnOpenPage();
    begin
        IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Responsibility Center", UserMgt.GetSalesFilter());
            FILTERGROUP(0);
        END;

        SETRANGE("Date Filter", 0D, WORKDATE - 1);
    end;

    var
        EmailMessage: codeunit "Email Message";
        Recipient: List of [Text];
        Email: Codeunit Email;
        Text000: Label 'Unable to execute this function while in view only mode.';
        CopySalesDoc: Report 292;
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ReportPrint: Codeunit 228;
        DocPrint: Codeunit 229;
        ArchiveManagement: Codeunit 5063;
        SalesSetup: Record "Sales & Receivables Setup";
        UserMgt: Codeunit 5700;
        "-NAVIN-": Integer;
        SalesLine: Record "Sales Line";
        //"--NAVIN--": ;
        Text001: Label 'Do you want to convert the Order to an Export order?';
        Text002: Label 'Order number %1 has been converted to Export order number %2.';
        Text13000: Label 'No Setup exists for this Amount.';
        Text13001: Label 'Do you want to send the order for Authorization?';
        Text13002: Label 'The Order Is Authorized, You Cannot Resend For Authorization';
        Text13003: Label 'You Cannot Resend For Authorization';
        Text13004: Label 'This Order Has been Rejected. Please Create A New Order.';
        MLTransactionType: Option Purchase,Sale;
        "Mail-Id": Record User;
        "from Mail": Text[150];
        "to mail": Text[1000];
        Mail_Subject: Text[1000];
        Mail_Body: Text[1000];
        //mail: Codeunit Mail;
        newline: Char;
        //SMTP_MAIL: Codeunit "SMTP Mail";
        Attachment1: Text[1000];
        salesheader: Record "Sales Header";
        Subject: Text[1000];
        user: Record User;
        ChangeExchangeRate: Page 511;

    procedure UpdateAllowed(): Boolean;
    begin
        IF CurrPage.EDITABLE = FALSE THEN
            ERROR(Text000);
        EXIT(TRUE);
    end;


    procedure "---NAVIN---"();
    begin
    end;


    procedure ConvertOrdertoExportOrder(var Rec: Record "Sales Header");
    var
        OldSalesCommentLine: Record "Sales Comment Line";
        SalesExportOrderHeader: Record "Sales Header";
        SalesExportOrderLine: Record "Sales Line";
        SalesCommentLine: Record "Sales Comment Line";
        ItemChargeAssgntSales: Record "Item Charge Assignment (Sales)";
        ReserveSalesLine: Codeunit 99000832;
        SalesOrderLine: Record 37;
        FromDocDim: Record "Dimension Set Entry";
        ToDocDim: Record "Dimension Set Entry";
    begin
        IF NOT CONFIRM(Text001, FALSE) THEN
            EXIT;
        SalesExportOrderHeader := Rec;
        SalesExportOrderHeader."Document Type" := SalesExportOrderHeader."Document Type"::Order;
        //SalesExportOrderHeader."Export Document" := TRUE;//B2B
        SalesExportOrderHeader."No. Printed" := 0;
        SalesExportOrderHeader.Status := SalesExportOrderHeader.Status::Open;
        SalesExportOrderHeader."No." := '';

        SalesExportOrderLine.LOCKTABLE;
        SalesExportOrderHeader.INSERT(TRUE);
        //DIM1.0 Start
        //Code Commented
        /*
        FromDocDim.SETRANGE("Table ID",DATABASE::"Purchase Header");
        FromDocDim.SETRANGE("Document Type","Document Type");
        FromDocDim.SETRANGE("Document No.","No.");
        
        ToDocDim.SETRANGE("Table ID",DATABASE::"Purchase Header");
        ToDocDim.SETRANGE("Document Type",SalesExportOrderHeader."Document Type");
        ToDocDim.SETRANGE("Document No.",SalesExportOrderHeader."No.");
        ToDocDim.DELETEALL;
        
        IF FromDocDim.FINDSET THEN BEGIN
          REPEAT
            ToDocDim.INIT;
            ToDocDim."Table ID" := DATABASE::"Purchase Header";
            ToDocDim."Document Type" := SalesExportOrderHeader."Document Type";
            ToDocDim."Document No." := SalesExportOrderHeader."No.";
            ToDocDim."Line No." := 0;
            ToDocDim."Dimension Code" := FromDocDim."Dimension Code";
            ToDocDim."Dimension Value Code" := FromDocDim."Dimension Value Code";
            ToDocDim.INSERT;
          UNTIL FromDocDim.NEXT = 0;
        END;
        
        */
        //DIM1.0 End

        SalesExportOrderHeader."Order Date" := "Order Date";
        SalesExportOrderHeader."Posting Date" := "Posting Date";
        SalesExportOrderHeader."Document Date" := "Document Date";
        SalesExportOrderHeader."Shipment Date" := "Shipment Date";
        SalesExportOrderHeader."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
        SalesExportOrderHeader."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
        SalesExportOrderHeader."Dimension Set ID" := "Dimension Set ID";//DIM1.0
        //SalesExportOrderHeader."Date Received" := 0D; //B2b1.0
        //SalesExportOrderHeader."Time Received" := 0T; //B2b1.0
        //SalesExportOrderHeader."Date Sent" := 0D; //B2b1.0
        //SalesExportOrderHeader."Time Sent" := 0T; //B2b1.0
        SalesExportOrderHeader.MODIFY;

        SalesOrderLine.SETRANGE("Document Type", "Document Type");
        SalesOrderLine.SETRANGE("Document No.", "No.");

        //DIM1.0 Start
        //Code Commented
        /*
        FromDocDim.SETRANGE("Table ID",DATABASE::"Purchase Line");
        ToDocDim.SETRANGE("Table ID",DATABASE::"Purchase Line");
        */
        //DIM1.0 End


        IF SalesOrderLine.FINDSET THEN
            REPEAT
                SalesExportOrderLine := SalesOrderLine;
                SalesExportOrderLine."Document Type" := SalesExportOrderHeader."Document Type";
                SalesExportOrderLine."Document No." := SalesExportOrderHeader."No.";
                SalesExportOrderLine."Shipment Date" := SalesExportOrderHeader."Shipment Date";
                ReserveSalesLine.TransferSaleLineToSalesLine(
                  SalesOrderLine, SalesExportOrderLine, SalesOrderLine."Reserved Qty. (Base)");
                SalesExportOrderLine."Shortcut Dimension 1 Code" := SalesOrderLine."Shortcut Dimension 1 Code";
                SalesExportOrderLine."Shortcut Dimension 2 Code" := SalesOrderLine."Shortcut Dimension 2 Code";
                //DIM1.0 Start
                SalesExportOrderLine."Dimension Set ID" := SalesOrderLine."Dimension Set ID";
                //DIM1.0  End
                SalesExportOrderLine.INSERT;


            //DIM1.0 Start
            /*
            FromDocDim.SETRANGE("Line No.",SalesOrderLine."Line No.");
            ToDocDim.SETRANGE("Line No.",SalesExportOrderLine."Line No.");
            ToDocDim.DELETEALL;
            IF FromDocDim.FINDSET THEN BEGIN
              REPEAT
                ToDocDim.INIT;
                ToDocDim."Table ID" := DATABASE::"Purchase Line";
                ToDocDim."Document Type" := SalesExportOrderHeader."Document Type";
                ToDocDim."Document No." := SalesExportOrderHeader."No.";
                ToDocDim."Line No." := SalesExportOrderLine."Line No.";
                ToDocDim."Dimension Code" := FromDocDim."Dimension Code";
                ToDocDim."Dimension Value Code" := FromDocDim."Dimension Value Code";
                ToDocDim.INSERT;
              UNTIL FromDocDim.NEXT = 0;
            END;
            */
            //DIM1.0 End

            UNTIL SalesOrderLine.NEXT = 0;

        SalesCommentLine.SETRANGE("Document Type", "Document Type");
        SalesCommentLine.SETRANGE("No.", "No.");
        IF NOT SalesCommentLine.ISEMPTY THEN BEGIN
            SalesCommentLine.LOCKTABLE;
            IF SalesCommentLine.FINDSET THEN
                REPEAT
                    OldSalesCommentLine := SalesCommentLine;
                    SalesCommentLine.DELETE;
                    SalesCommentLine."Document Type" := SalesExportOrderHeader."Document Type";
                    SalesCommentLine."No." := SalesExportOrderHeader."No.";
                    SalesCommentLine.INSERT;
                    SalesCommentLine := OldSalesCommentLine;
                UNTIL SalesCommentLine.NEXT = 0;
        END;

        ItemChargeAssgntSales.RESET;
        ItemChargeAssgntSales.SETRANGE("Document Type", "Document Type");
        ItemChargeAssgntSales.SETRANGE("Document No.", "No.");

        WHILE ItemChargeAssgntSales.FINDFIRST DO BEGIN
            ItemChargeAssgntSales.DELETE;
            ItemChargeAssgntSales."Document Type" := SalesExportOrderHeader."Document Type";
            ItemChargeAssgntSales."Document No." := SalesExportOrderHeader."No.";
            IF NOT (ItemChargeAssgntSales."Applies-to Doc. Type" IN
              [ItemChargeAssgntSales."Applies-to Doc. Type"::Shipment,
               ItemChargeAssgntSales."Applies-to Doc. Type"::"Return Receipt"])
            THEN BEGIN
                ItemChargeAssgntSales."Applies-to Doc. Type" := SalesExportOrderHeader."Document Type";
                ItemChargeAssgntSales."Applies-to Doc. No." := SalesExportOrderHeader."No.";
            END;
            ItemChargeAssgntSales.INSERT;
        END;

        DELETE;
        SalesOrderLine.DELETEALL;
        //DIM1.0 Start
        /*
        FromDocDim.SETRANGE("Line No.");
        FromDocDim.DELETEALL;
        */
        //DIM1.0 End

        MESSAGE(
          Text002,
          "No.", SalesExportOrderHeader."No.");

    end;


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
        /*IF "Document Position"="Document Position"::Finance THEN
          ERROR(Text008);
        IF "Sales Order Created" = TRUE THEN
            ERROR(Text010)
        ELSE IF "Blanket Order Created" = TRUE THEN
          ERROR(Text007);
          IF Status=Status::Open THEN
          ERROR('TENDER MUST BE RELEASED');
        
        
        TESTFIELD("Customer No.");
        IF NOT CONFIRM(Text000,FALSE) THEN
          EXIT;
        SalesHeader.INIT;
        SalesHeader."Document Type" := SalesHeader."Document Type" :: Order;
        SRSetup.GET;
        SalesHeader."No." := NoSeriesMgt.GetNextNo(SRSetup."Order Nos.",WORKDATE,TRUE);
        Cust.GET("Customer No.");
        Cust.CheckBlockedCustOnDocs(Cust,SalesHeader."Document Type" ::Quote,TRUE,FALSE);
        SalesHeader.VALIDATE("Sell-to Customer No.","Customer No.");
        //SalesHeader."Document Date":=WORKDATE;
        SalesHeader.VALIDATE(SalesHeader."Sell-to Customer No.");
        SalesHeader."Tender No." := "Tender No.";
        "Sales Order Created" := TRUE;
        "Tender Status":="Tender Status"::Received;
        MODIFY(TRUE);
        MESSAGE('Order No is %1  created',SalesHeader."No.");
        SalesHeader.INSERT;
        
        TenderLine.SETRANGE("Document No.","Tender No.");
        IF TenderLine.FINDSET THEN
          REPEAT
            SalesLine.INIT;
            SalesLine."Document Type" := SalesLine."Document Type" :: Order;
            SalesLine."Document No." := SalesHeader."No.";
            SalesLine."Line No." := TenderLine."Line No.";
            SalesLine."Schedule No":=TenderLine."Schedule No";
            SalesLine."Type of Item":=TenderLine."Type of Item";
            SalesLine."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
            IF TenderLine.Type =TenderLine.Type::Item  THEN BEGIN
              SalesLine.Type :=SalesLine.Type::Item ;
              SalesLine.Description := TenderLine.Description;
              SalesLine."Description 2" := TenderLine."Description 2";
            END;
        
            IF TenderLine.Type = TenderLine.Type :: Item THEN BEGIN
              SalesLine.Type := SalesLine.Type :: Item;
            END;
        
            IF TenderLine.Type = TenderLine.Type :: Resource THEN BEGIN
              SalesLine.Type := SalesLine.Type :: Resource;
            END;
            IF TenderLine.Type = TenderLine.Type :: "G/L Account" THEN BEGIN
              SalesLine.Type := SalesLine.Type :: "G/L Account";
            END;
          Schedule3.RESET;
          Schedule3.SETRANGE("Document Type",Schedule3."Document Type" ::Tender);
          Schedule3.SETRANGE("Document No.",TenderLine."Document No.");
          Schedule3.SETRANGE("Document Line No.",TenderLine."Line No.");
          IF Schedule3.FINDFIRST THEN
        
            SalesLine."No." := TenderLine."No.";
            SalesLine.VALIDATE(SalesLine."No.");
            SalesLine.VALIDATE(Quantity,TenderLine.Quantity);
            SalesLine.VALIDATE("Unit Cost (LCY)",Schedule."Calcaulated Amont"/TenderLine.Quantity);
        
        
        
            IF SalesLine.Type > SalesLine.Type::" " THEN BEGIN
              SalesLine.VALIDATE("Sell-to Customer No.");
              SalesLine.VALIDATE(SalesLine.Quantity);
            END;
            SalesLine."Tender No." := "Tender No.";
            SalesLine."Tender Line No." := TenderLine."Line No.";
            {
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
            }
            Schedule.RESET;
            Schedule.SETRANGE("Document Type",Schedule."Document Type"::Tender);
            Schedule.SETRANGE("Document No.",TenderLine."Document No.");
            Schedule.SETRANGE("Document Line No.",TenderLine."Line No.");
            IF Schedule.FINDSET THEN
              REPEAT
                Schedule2.INIT;
                Schedule2.TRANSFERFIELDS(Schedule);
                Schedule2."Document Type":=Schedule2."Document Type"::Order;
                Schedule2."Document No.":=SalesLine."Document No.";
                Schedule2."Document Line No.":=SalesLine."Line No.";
                Schedule2.INSERT;
              UNTIL Schedule.NEXT=0;
            SalesLine.INSERT;
          UNTIL TenderLine.NEXT =0;
        
        
        
         //NSS 100907
          Attach.RESET;
          Attach.SETRANGE("Table ID",DATABASE:: "Tender Header");
          Attach.SETRANGE("Document No.","Tender No.");
          IF Attach.FINDSET THEN
            REPEAT
              PostAttach.INIT;
              Attach.CALCFIELDS(Attach.FileAttachment);
              PostAttach.TRANSFERFIELDS(Attach);
              PostAttach."Table ID" := DATABASE:: "Sales Header";
              PostAttach."Document No." := SalesHeader."No.";
              PostAttach."Document Type" := PostAttach."Document Type"::Order;
              PostAttach.INSERT;
            UNTIL Attach.NEXT = 0;
        
        CheckList.RESET;
        CheckList.SETRANGE("Document Type",CheckList."Document Type"::Tender);
        CheckList.SETRANGE("Document No.","Tender No.");
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
        TenderCommentLine.SETRANGE(TenderCommentLine."No.","Tender No.");
        IF TenderCommentLine.FINDSET THEN
          REPEAT
             SalesCommentLine.INIT;
             SalesCommentLine."Document Type":=SalesCommentLine."Document Type"::Order;
             SalesCommentLine."No.":=SalesHeader."No.";
             SalesCommentLine."Line No.":=TenderCommentLine."Line No.";
             SalesCommentLine.Date:=TenderCommentLine.Date;
             SalesCommentLine.Comment:=TenderCommentLine.Comment;
             SalesCommentLine.INSERT;
          UNTIL TenderCommentLine.NEXT=0;
        MESSAGE(Text001,"Tender No.",SalesHeader."No.");
        
           //**********************************Mail Code for Converting to Order*************************(swarupa)
        
        TH.SETRANGE(TH."Tender No.","Tender No.");
        IF TH.FINDFIRST THEN
        BEGIN
        IF (TH."Blanket Order Created"=TH."Blanket Order Created"::"1") THEN
        BEGIN
            Mail_Subject:='ERP- Tender Converted to Order';
            charline:=10;
            Mail_Body:='';
            Mail_Body+='TENDER CONVERTED TO ORDER DETAILS :';
            Mail_Body+=FORMAT(charline);
            Mail_Body+=FORMAT(charline);
            Mail_Body+='Tender No.         :'+"Tender No.";
            Mail_Body+=FORMAT(charline);
            Mail_Body+='Customer Tender No.:'+"Customer Tender No.";
            Mail_Body+=FORMAT(charline);
            Mail_Body+='Customer Name      :'+"Customer Name";
            Mail_Body+=FORMAT(charline);
            IF "Minimum Bid Amount"=0 THEN
            ERROR('Enter Bid Value');
            Mail_Body+='BID Value          :'+FORMAT(ROUND("Minimum Bid Amount",1));
            Mail_Body+=FORMAT(charline);
            Mail_Body+='EMD Value          :'+FORMAT(ROUND("EMD Amount",1));
            Mail_Body+=FORMAT(charline);
            Mail_Body+=FORMAT(charline);
            Mail_Body+='***** Auto Mail Generated from ERP *****';
        
           "Mail-Id".SETRANGE("Mail-Id"."User ID",USERID);
            IF "Mail-Id".FINDFIRST THEN
            "from Mail":="Mail-Id".MailID;
        TH.SETRANGE(TH."Tender No.","Tender No.");
        IF TH.FINDFIRST THEN
        REPORT.RUN(50095,FALSE,FALSE,TH);
        "g/l setup".FINDFIRST;
        //REPORT.SAVEASHTML(50095,'\\erpserver\ErpAttachments\Tender detail1.html',FALSE,TH);
        //Attachment1:='\\erpserver\ErpAttachments\Tender detail1.html';
        
        {   "to mail"+='dir@efftronics.com,padmaja@efftronics.com,chowdary@efftronics.com,renukach@efftronics.com,phani@efftronics.com,';
            "to mail"+='erp@efftronics.com,sal@efftronics.com,bharat@efftronics.com,cvmohan@efftronics.com,raju@efftronics.com';}
        {
        "to mail":='dir@efftronics.com,ravi@efftronics.com,samba@efftronics.com,cvmohan@efftronics.com,anilkumar@efftronics.com,';
            "to mail"+='renukach@efftronics.com,baji@efftronics.com,prasannat@efftronics.com,anuradhag@efftronics.com,padmaja@efftronics.com
        ,'
        ;
        "to mail"+='anulatha@efftronics.com,milind@efftronics.com,srasc@efftronics.com,chowdary@efftronics.com,';
        "to mail"+='sganesh@efftronics.com,rajani@efftronics.com,dsr@efftronics.com,sunil@efftronics.com,phani@efftronics.com,';
        "to mail"+='bharat@efftronics.com,mohang@efftronics.com,';
        "to mail":='SANTHOSHK@EFFTRONICS.COM';}
        
        
        
        //       IF ( "from Mail"<>'') AND ("to mail"<>'') THEN
        //       mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,Attachment1);
        END;
        END;
        COMMIT;
        */
        //OMS integration

        //IF (Status=Status::Open) THEN
        OMSIntegration.TendertoBlanketorOrder(SalesHeader."No.", 2, "Tender No.", 0);

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
        /*
        IF "Document Position"="Document Position"::Finance THEN
          ERROR(Text008);
          IF Status=Status::Open THEN
          ERROR('TENDER MUST BE RELEASED');
        IF "Sales Order Created" = TRUE THEN
          ERROR(Text010);
        IF  "Blanket Order Created" = TRUE THEN
          ERROR(Text007);
        
        TESTFIELD("Customer No.");
        IF NOT CONFIRM(Text005,FALSE) THEN
          EXIT;
        SalesHeader.INIT;
        SalesHeader."Document Type" := SalesHeader."Document Type" :: "Blanket Order";
        SRSetup.GET;
        SalesHeader."No." := NoSeriesMgt.GetNextNo(SRSetup."Blanket Order Nos.",WORKDATE,TRUE);
        Cust.GET("Customer No.");
        Cust.CheckBlockedCustOnDocs(Cust,SalesHeader."Document Type" ::"Blanket Order",TRUE,FALSE);
        SalesHeader."Sell-to Customer No." := "Customer No.";
        SalesHeader.VALIDATE(SalesHeader."Sell-to Customer No.");
        //MESSAGE('%1',SalesHeader."Gen. Bus. Posting Group");
        SalesHeader."Tender No." := "Tender No.";
        //SalesHeader."User ID":="USER ID";
        SalesHeader."Expected Order Month":="Expected Order month";
        "Blanket Order Created":= TRUE;
        MODIFY(TRUE);
        MESSAGE(' Blanket Order No is %1  created',SalesHeader."No.");
        SalesHeader.INSERT;
        
        TenderLine.SETRANGE("Document No.","Tender No.");
        IF TenderLine.FINDSET THEN
          REPEAT
            SalesLine.INIT;
            SalesLine."Document Type" := SalesLine."Document Type" :: "Blanket Order";
            SalesLine."Document No." := SalesHeader."No.";
            SalesLine."Line No." := SalesLine."Line No." + 10000;
            SalesLine."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
            SalesLine."Schedule No":=TenderLine."Schedule No";
            SalesLine."Type of Item":=TenderLine."Type of Item";
        
            IF TenderLine.Type = TenderLine.Type::Item THEN BEGIN
              SalesLine.Type := SalesLine.Type::Item;
              SalesLine.Description := TenderLine.Description;
              SalesLine."Description 2" := TenderLine."Description 2";
            END;
            IF TenderLine.Type = TenderLine.Type :: Item THEN BEGIN
              SalesLine.Type := SalesLine.Type :: Item;
              SalesLine.VALIDATE("Tax Group Code",TenderLine."Tax Group Code");
            END;
             IF TenderLine.Type = TenderLine.Type :: Resource THEN BEGIN
              SalesLine.Type := SalesLine.Type :: Resource;
            END;
            IF TenderLine.Type = TenderLine.Type :: "G/L Account" THEN BEGIN
              SalesLine.Type := SalesLine.Type :: "G/L Account";
            END;
            SalesLine."No." := TenderLine."No.";
            SalesLine.VALIDATE(SalesLine."No.");
            SalesLine.Quantity := TenderLine.Quantity;
            SalesLine.VALIDATE(SalesLine.Quantity);
            {
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
            }
            SalesLine.INSERT;
            Schedule.RESET;
            Schedule.SETRANGE("Document Type",Schedule."Document Type"::Tender);
            Schedule.SETRANGE("Document No.",TenderLine."Document No.");
            Schedule.SETRANGE("Document Line No.",TenderLine."Line No.");
            IF Schedule.FINDSET THEN
              REPEAT
                Schedule2.INIT;
                Schedule2.TRANSFERFIELDS(Schedule);
                Schedule2."Document Type":=Schedule2."Document Type"::"Blanket Order";
                Schedule2."Document No.":=SalesLine."Document No.";
                Schedule2."Document Line No.":=SalesLine."Line No.";
                Schedule2.INSERT;
              UNTIL Schedule.NEXT=0;
          UNTIL TenderLine.NEXT =0;
        
         //NSS 100907
          Attach.RESET;
          Attach.SETRANGE("Table ID",DATABASE:: "Tender Header");
          Attach.SETRANGE("Document No.","Tender No.");
          IF Attach.FINDSET THEN
            REPEAT
              PostAttach.INIT;
              Attach.CALCFIELDS(Attach.FileAttachment);
              PostAttach.TRANSFERFIELDS(Attach);
              PostAttach."Table ID" := DATABASE:: "Sales Header";
              PostAttach."Document No." := SalesHeader."No.";
              //PostAttach."Document Type" := PostAttach."Document Type"::blanket;
              PostAttach.INSERT;
            UNTIL Attach.NEXT = 0;
           //NSS 100907
        
        //Carrying the comments
        TenderCommentLine.RESET;
        TenderCommentLine.SETRANGE("No.","Tender No.");
        IF TenderCommentLine.FINDSET THEN
          REPEAT
             SalesCommentLine.INIT;
             SalesCommentLine."Document Type":=SalesCommentLine."Document Type"::"Blanket Order";
             SalesCommentLine."No.":=SalesHeader."No.";
             SalesCommentLine."Line No.":=TenderCommentLine."Line No.";
             SalesCommentLine.Date:=TenderCommentLine.Date;
             SalesCommentLine.Comment:=TenderCommentLine.Comment;
             SalesCommentLine.INSERT;
          UNTIL TenderCommentLine.NEXT=0;
        
        MESSAGE(Text006,"Tender No.",SalesHeader."No.");
        TH.SETRANGE(TH."Tender No.","Tender No.");
        IF TH.FINDFIRST THEN
        BEGIN
        IF (TH."Blanket Order Created"=TH."Blanket Order Created"::"1") THEN
        BEGIN
        charline:=10;
            Mail_Body:='';
            Mail_Subject:='ERP- Tender Converted to Blanket Order';
        Mail_Body+='TENDER CONVERTED TO  BLANKET ORDER DETAILS :';
        Mail_Body+=FORMAT(charline);
        
        Mail_Body+='Tender No            : '+"Tender No.";
        Mail_Body+=FORMAT(charline);
        Mail_Body+='Customer Name        : '+"Customer Name";
        Mail_Body+=FORMAT(charline);
        Mail_Body+='Cust. Tender No.     : '+"Customer Tender No.";
        Mail_Body+=FORMAT(charline);
        IF "Minimum Bid Amount"=0 THEN
        ERROR('Enter Bid Value');
        Mail_Body+='Tender Value         : '+FORMAT(ROUND("Minimum Bid Amount",1));
        Mail_Body+=FORMAT(charline);
        IF "Expected Order month" = "Expected Order month"::"  " THEN
        ERROR('Please provide Expected Order Month')
        ELSE
        Mail_Body+='Expected Order Month : '+FORMAT("Expected Order month");
        Mail_Body+=FORMAT(charline);
        Mail_Body+=FORMAT(charline);
        Mail_Body+='***** Auto Mail Generated from ERP*****';
           "Mail-Id".SETRANGE("Mail-Id"."User ID",USERID);
            IF "Mail-Id".FINDFIRST THEN
            "from Mail":="Mail-Id".MailID;
        TH.SETRANGE(TH."Tender No.","Tender No.");
        IF TH.FINDFIRST THEN
        REPORT.RUN(50095,FALSE,FALSE,TH);
        "g/l setup".FINDFIRST;
        REPORT.SAVEASHTML(50095,'\\erpserver\ErpAttachments\Tender detail1.html',FALSE,TH);
        Attachment1:='\\erpserver\ErpAttachments\Tender detail1.html';
        
        {   "to mail"+='dir@efftronics.com,padmaja@efftronics.com,chowdary@efftronics.com,renukach@efftronics.com,phani@efftronics.com,';
            "to mail"+='erp@efftronics.com,sal@efftronics.com,bharat@efftronics.com,cvmohan@efftronics.com,raju@efftronics.com';}
        
        
        "to mail":='dir@efftronics.com,ravi@efftronics.com,samba@efftronics.com,cvmohan@efftronics.com,anilkumar@efftronics.com,';
        "to mail"+='renukach@efftronics.com,baji@efftronics.com,prasannat@efftronics.com,anuradhag@efftronics.com,padmaja@efftronics.com,'
        ;
        "to mail"+='mohang@efftronics.com,anulatha@efftronics.com,milind@efftronics.com,srasc@efftronics.com,chowdary@efftronics.com,';
        "to mail"+='sganesh@efftronics.com,rajani@efftronics.com,dsr@efftronics.com,sunil@efftronics.com,phani@efftronics.com,';
        "to mail"+='bharat@efftronics.com';
        
        {       IF ( "from Mail"<>'') AND ("to mail"<>'') THEN
               mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,Attachment1);
        }
        END;
        END;
        
        //OMS integration
         */
        MESSAGE(SalesHeader."No.");
        OMSIntegration.TendertoBlanketorOrder(SalesHeader."No.", 1, "Tender No.", 0);

        //OMS integration

    end;


    local procedure SelltoCustomerNoOnAfterValidat();
    begin
        CurrPage.UPDATE;
    end;

    local procedure BilltoCustomerNoOnAfterValidat();
    begin
        CurrPage.UPDATE;
    end;


    local procedure ShortcutDimension1CodeOnAfterV();
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;


    local procedure ShortcutDimension2CodeOnAfterV();
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;


    local procedure SalOrdDesApprovalOnPush();
    begin
        MaketoOrder;
    end;
}

