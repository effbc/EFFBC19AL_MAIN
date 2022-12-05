page 60212 "Sales Blanket Order-Design"
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
    SourceTableView = WHERE("Document Type" = FILTER("Blanket Order"), "Document Position" = CONST(Design));

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
                /*field(Structure)
                {
                }
                field("Free Supply";"Free Supply")
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
            field("Bktord Des Approval"; "Bktord Des Approval")
            {
                ApplicationArea = All;
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
                /* field("LC No."; "LC No.")
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
                /*  field("Transit Document"; "Transit Document")
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
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action("Design Worksheet")
                {
                    Caption = 'Design Worksheet';
                    Image = Worksheet;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CurrPage.SalesLines.PAGE.ShowSalesOrderWorkSheet;
                    end;
                }
                action(Schedule)
                {
                    Caption = 'Schedule';
                    Image = Planning;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CurrPage.SalesLines.PAGE.ShowSchedule;
                    end;
                }
            }
        }
        area(processing)
        {
            //Caption = '<Action1102152001>';
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Release To Sales")
                {
                    Caption = 'Release To Sales';
                    Image = ReleaseShipment;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        Text01: Label 'Do You want to Send the Document to Sale?';
                    begin
                        /*IF NOT CONFIRM(Text01, FALSE) THEN
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

                        "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                        IF "Mail-Id".FINDFIRST THEN
                            "from Mail" := "Mail-Id".MailID;
                        //  "to mail":='sal@efftronics.com,erp@efftronics.com,cvmohan@efftronics.com';
                        salesheader.RESET;
                        salesheader.SETFILTER(salesheader."No.", "No.");
                        REPORT.RUN(60004, FALSE, FALSE, salesheader);
                        REPORT.SAVEASHTML(60004, '\\erpserver\ErpAttachments\SALEORDER2.html', FALSE, salesheader);
                        Attachment1 := '\\erpserver\ErpAttachments\SALEORDER2.html';
                        Mail_Subject := 'Design modifications of Sale order ' + xRec."No." + 'Transfer By ' + user."User Name";
                        "to mail" := 'jhansi@efftronics.com,anilkumar@efftronics.com,sal@efftronics.com,pmurali@efftronics.com';

                        IF ("from Mail" <> '') AND ("to mail" <> '') THEN BEGIN
                            SMTP_MAIL.CreateMessage('ERP', "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);
                            SMTP_MAIL.AddAttachment(Attachment1, '');//EFFUPG Added('')
                            SMTP_MAIL.Send;
                        END;*/ //B2B UPG
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

                        "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                        IF "Mail-Id".FINDFIRST THEN
                            //  "from Mail" := "Mail-Id".MailID;
                            //  "to mail":='sal@efftronics.com,erp@efftronics.com,cvmohan@efftronics.com';
                            salesheader.RESET;
                        salesheader.SETFILTER(salesheader."No.", "No.");
                        REPORT.RUN(60004, FALSE, FALSE, salesheader);
                        REPORT.SAVEASHTML(60004, '\\erpserver\ErpAttachments\SALEORDER2.html', salesheader);
                        Attachment1 := '\\erpserver\ErpAttachments\SALEORDER2.html';
                        Mail_Subject := 'Design modifications of Sale order ' + xRec."No." + 'Transfer By ' + user."User Name";
                        //"to mail" := 'jhansi@efftronics.com,anilkumar@efftronics.com,sal@efftronics.com,pmurali@efftronics.com';
                        Recipients.Add('jhansi@efftronics.com');
                        Recipients.Add('anilkumar@efftronics.com');
                        Recipients.Add('sal@efftronics.com');
                        Recipients.Add('pmurali@efftronics.com');
                        IF ("from Mail" <> '') AND ("to mail" <> '') THEN BEGIN
                            // SMTP_MAIL.CreateMessage('ERP', "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);
                            EmailMessage.Create(Recipients, Mail_Subject, Mail_Body, False);
                            EmailMessage.AddAttachment(Attachment1, '', '');//EFFUPG Added('')

                            Email.send(EmailMessage, Enum::"Email Scenario"::Default);
                            //SMTP_MAIL.Send;
                        END;
                    end;
                }
                action("&Attachments")
                {
                    Caption = '&Attachments';
                    Image = Attachments;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CurrPage.SalesLines.PAGE.CustAttachments;
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
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit email;
        Recipients: List of [Text];
        UserMgt: Codeunit "User Setup Management";
        Text000: Label 'Unable to execute this function while in view only mode.';
        CopySalesDoc: Report 292;
        ChangeExchangeRate: Page "Change Exchange Rate";
        Text001: Label 'Do you want to convert the Order to an Export order?';
        /* MoveNegSalesLines : Report "Move Negative Sales Lines";
         ReportPrint : Codeunit "Test Report-Print";
         DocPrint : Codeunit "Document-Print";
         ArchiveManagement : Codeunit ArchiveManagement;
         SalesSetup : Record "Sales & Receivables Setup";
         ChangeExchangeRate : Page "Change Exchange Rate";
         
         "-NAVIN-" : Integer;
         //SalesLine : Record "Sales Line";
         "--NAVIN--" : ;
         Text001 : Label 'Do you want to convert the Order to an Export order?';*/ // UPGrFF 
        Text002: Label 'Order number %1 has been converted to Export order number %2.';
        Text13000: Label 'No Setup exists for this Amount.';
        Text13001: Label 'Do you want to send the order for Authorization?';
        Text13002: Label 'The Order Is Authorized, You Cannot Resend For Authorization';
        Text13003: Label 'You Cannot Resend For Authorization';
        Text13004: Label 'This Order Has been Rejected. Please Create A New Order.';
        MLTransactionType: Option Purchase,Sale;
        "Mail-Id": Record "User Setup";
        "from Mail": Text[150];
        "to mail": Text[1000];
        Mail_Subject: Text[1000];
        Mail_Body: Text[1000];
        mail: Codeunit Mail;
        newline: Char;
        // SMTP_MAIL: Codeunit "SMTP Mail";
        Attachment1: Text[1000];
        salesheader: Record "Sales Header";
        Subject: Text[1000];
        user: Record User;

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
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
        SalesOrderLine: Record "Sales Line";
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
        //DIM1.0 Start
        SalesExportOrderHeader."Dimension Set ID" := "Dimension Set ID";
        //DIM1.0  End

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
                //DIM1.0
                SalesExportOrderLine."Dimension Set ID" := SalesOrderLine."Dimension Set ID";
                //DIM1.0
                SalesExportOrderLine.INSERT;

            //DIM1.0 Start
            //Code Commented
            /*
            //FromDocDim.SETRANGE("Line No.",SalesOrderLine."Line No.");

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
        //DIM1.0 Strat
        //Code Commented
        /*
        FromDocDim.SETRANGE("Line No.");
        FromDocDim.DELETEALL;
        */
        //DIM1.0 End

        MESSAGE(
          Text002,
          "No.", SalesExportOrderHeader."No.");

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
}

