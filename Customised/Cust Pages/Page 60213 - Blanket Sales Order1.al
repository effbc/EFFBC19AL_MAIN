page 60213 "Blanket Sales Order1"
{
    // version NAVW16.00.01,NAVIN6.00.01,B2B1.0,Rev01

    Caption = 'Blanket Sales Order';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = FILTER("Blanket Order"));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
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
                /*field(Structure; Structure)
                {
                }*/
                field(Control80; Comment)
                {
                    Editable = false;
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
                field("Salesperson Code"; "Salesperson Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        SalespersonCodeOnAfterValidate;
                    end;
                }
                field("Customer OrderNo."; "Customer OrderNo.")
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
                field("Assigned User ID"; "Assigned User ID")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("Sale Order Created"; "Sale Order Created")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Order Released Date"; "Order Released Date")
                {
                    Caption = '"Released On "';
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("OMS Details")
            {
                Visible = forwordomsVisible;
                field(forwordoms; forwordtooms)
                {
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
            }
            part(SalesLines; "Blanket Sales Order Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
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
                field("Order Assurance"; "Order Assurance")
                {
                    ApplicationArea = All;
                }
                field("Payment Discount %"; "Payment Discount %")
                {
                    ApplicationArea = All;
                }
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
                field("Order Completion Period"; "Order Completion Period")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; "Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Expecting Week"; "Expecting Week")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; "Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Expected Order Month"; "Expected Order Month")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
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
                field("Order Status"; "Order Status")
                {
                    ApplicationArea = All;
                }
                /* field("Transit Document"; "Transit Document")
                 {
                 }*/
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; "Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Tender No."; "Tender No.")
                {
                    ApplicationArea = All;
                }
                field("<Order Released Date2>"; "Order Released Date")
                {
                    ApplicationArea = All;
                }
                field("Sale Order Total Amount"; "Sale Order Total Amount")
                {
                    ApplicationArea = All;
                }
                field("Project Completion Date"; "Project Completion Date")
                {
                    ApplicationArea = All;
                }
                field("<Expecting Week2>"; "Expecting Week")
                {
                    ApplicationArea = All;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        CLEAR(ChangeExchangeRate);
                        ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", WORKDATE);
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate();
                    begin
                        CurrencyCodeOnAfterValidate;
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
                field("Sale Order No."; "Sale Order No.")
                {
                    ApplicationArea = All;
                }
            }
            group("Tax Information")
            {
                Caption = 'Tax Information';
                /* field("LC No."; "LC No.")
                 {
                 }
                 field("Form Code"; "Form Code")
                 {
                 }
                 field("Form No."; "Form No.")
                 {
                 }
                 field("<Transit Document2>"; "Transit Document")
                 {
                 }
                 field("Free Supply"; "Free Supply")
                 {
                 }*/
                field("TDS Certificate Receivable"; "TDS Certificate Receivable")
                {
                    ApplicationArea = All;
                }
                /* field("Calc. Inv. Discount (%)"; "Calc. Inv. Discount (%)")
                 {
                 }
                 field("Export or Deemed Export"; "Export or Deemed Export")
                 {
                 }
                 field("VAT Exempted"; "VAT Exempted")
                 {
                 }*/
                field(Trading; Trading)
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
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    ShortCutKey = 'F7';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        SalesCalcDiscByType: Codeunit "Sales - Calc Discount By Type";
                    begin

                        //EFFUPG>>
                        OpenSalesOrderStatistics;
                        SalesCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                        //EFFUPG<<


                        /*  IF Rec.Structure <> '' THEN BEGIN
                              SalesLine.CalculateStructures(Rec);
                              SalesLine.AdjustStructureAmounts(Rec);
                              SalesLine.UpdateSalesLines(Rec);
                              SalesLine.CalculateTCS(Rec);
                          END ELSE BEGIN
                              SalesLine.CalculateTCS(Rec);
                          END;
                        COMMIT;
                        PAGE.RUNMODAL(PAGE::"Sales Order Statistics", Rec);
                        */
                    end;
                }
                action(Card)
                {
                    Caption = 'Card';
                    Image = Card;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = Comment;
                    RunObject = Page 67;
                    RunPageLink = "Document Type" = CONST("Blanket Order"), "No." = FIELD("No."), "Document Line No." = CONST(0);
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approve;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        ApprovalEntries: Page 658;
                    begin
                        ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No.");
                        ApprovalEntries.RUN;
                    end;
                }
                /*action("St&ructure")
                {
                    Caption = 'St&ructure';
                    Image = Hierarchy;
                    RunObject = Page "Structure Order Details";
                    RunPageLink = Type = CONST(Sale), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "Structure Code" = FIELD(Structure), "Document Line No." = FILTER(0);
                }*/
            }
        }
        area(processing)
        {

            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Calculate &Invoice Discount")
                {
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ApproveCalcInvDisc;
                    end;
                }
                /*
                action("Get &Price")
                {
                    Caption = 'Get &Price';
                    Ellipsis = true;
                    Image = CustomerCode;

                    trigger OnAction();
                    begin
                        CurrPage.SalesLines.PAGE.ShowPrices
                    end;
                }
                
                action("Get Li&ne Discount")
                {
                    Caption = 'Get Li&ne Discount';
                    Ellipsis = true;
                    Image = LineDiscount;

                    trigger OnAction();
                    begin
                        CurrPage.SalesLines.PAGE.ShowLineDisc
                    end;
                }
                    
                separator(Action134)
                {
                }
                action("E&xplode BOM")
                {
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;

                    trigger OnAction();
                    begin
                        CurrPage.SalesLines.PAGE.ExplodeBOM;
                    end;
                }
                */
                action("Insert &Ext. Texts")
                {
                    Caption = 'Insert &Ext. Texts';
                    Image = Text;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CurrPage.SalesLines.PAGE.InsertExtendedText(TRUE);
                    end;
                }
                separator(Action129)
                {
                }
                action("Copy Document")
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RUNMODAL;
                        CLEAR(CopySalesDoc);
                    end;
                }
                separator(Action131)
                {
                }
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        ApprovalMgt: Codeunit 439;
                    begin
                        //IF ApprovalMgt.SendSalesApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelAllLines;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        ApprovalMgt: Codeunit 439;
                    begin
                        //  IF ApprovalMgt.CancelSalesApprovalRequest(Rec, TRUE, TRUE) THEN;
                    end;
                }
                action("&Attachment")
                {
                    Caption = '&Attachment';
                    Image = Attach;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CurrPage.SalesLines.PAGE.CustAttachments;
                    end;
                }
                separator(Action138)
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
                    var
                        ReleaseSalesDoc: Codeunit 414;
                    begin
                        //IF ("Sell-to Customer No."<>'CS INT') OR ("Sell-to Customer No."<>'R&D INT')THEN
                        /*IF NOT(("Sell-to Customer No."='CS INT') OR ("Sell-to Customer No."='R&D INT'))THEN
                        TESTFIELD("Bktord Des Approval");*/
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                        IF Status = Status::Released THEN BEGIN
                            SHA.RESET;
                            SHA.SETFILTER(SHA."No.", "No.");
                            IF NOT SHA.FINDFIRST THEN BEGIN
                                "First Released Date Time" := CURRENTDATETIME;
                                MODIFY;
                            END;
                        END;

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
                    var
                        ReleaseSalesDoc: Codeunit 414;
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
                separator(Action1500019)
                {
                }
                action("Calc&ulate Structure Values")
                {
                    Caption = 'Calc&ulate Structure Values';
                    Image = CalculateHierarchy;
                    ApplicationArea = All;

                    /*   trigger OnAction();
                       begin
                           CALCFIELDS("Price Inclusive of Taxes");
                           IF "Price Inclusive of Taxes" THEN BEGIN
                               SalesLine.InitStrOrdDetail(Rec);
                               SalesLine.GetSalesPriceExclusiveTaxes(Rec);
                               SalesLine.UpdateSalesLinesPIT(Rec);
                           END;
                           SalesLine.CalculateStructures(Rec);
                           SalesLine.AdjustStructureAmounts(Rec);
                           SalesLine.UpdateSalesLines(Rec);
                       end;*/
                }
                action("Release to Design")
                {
                    Caption = 'Release to Design';
                    Image = Design;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        IF ("Sell-to Customer No." = 'CS INT') OR ("Sell-to Customer No." = 'R&D INT') THEN
                            ERROR('These are internal department orders no need to send for DESIGN Approval');
                        IF Status = 1 THEN
                            ERROR('This is released order Not possible to release to Design');
                        IF "Bktord Des Approval" = TRUE THEN
                            ERROR('This blanket Order already approved');

                        /*IF NOT CONFIRM(Text01, FALSE) THEN
                            EXIT;
                        newline := 10;
                        TESTFIELD("Document Position", "Document Position"::Sales);
                        "Document Position" := "Document Position"::Design;
                        MODIFY;
                        Mail_Subject := 'Blanker Order Released to Design';
                        Mail_Body := 'Order No        : ' + "No.";
                        Mail_Body += FORMAT(newline);
                        Mail_Body += 'Customer Name   : ' + "Sell-to Customer Name";
                        Mail_Body += FORMAT(newline);
                        Mail_Body += FORMAT(newline);
                        Mail_Body += '***** Auto Mail Generated From ERP *****';
                        "Mail-Id".SETRANGE("Mail-Id"."User Security ID", USERID);
                        IF "Mail-Id".FINDFIRST THEN
                            "from Mail" := "Mail-Id".MailID;
                        "to mail" := 'jhansi@efftronics.com,sal@efftronics.com,erp@efftronics.com,cvmohan@efftronics.com';
                        MODIFY;
                        IF ("from Mail" <> '') AND ("to mail" <> '') THEN BEGIN
                            SMTP_MAIL.CreateMessage('ERP', "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);
                            SMTP_MAIL.Send;
                        END;*/  //B2B UPG

                        IF NOT CONFIRM(Text01, FALSE) THEN
                            EXIT;
                        newline := 10;
                        TESTFIELD("Document Position", "Document Position"::Sales);
                        "Document Position" := "Document Position"::Design;
                        MODIFY;
                        Mail_Subject := 'Blanker Order Released to Design';
                        Mail_Body := 'Order No        : ' + "No.";
                        Mail_Body += FORMAT(newline);
                        Mail_Body += 'Customer Name   : ' + "Sell-to Customer Name";
                        Mail_Body += FORMAT(newline);
                        Mail_Body += FORMAT(newline);
                        Mail_Body += '***** Auto Mail Generated From ERP *****';
                        "Mail-Id".SETRANGE("Mail-Id"."User Security ID", USERID);
                        IF "Mail-Id".FINDFIRST THEN
                            //"from Mail" := "Mail-Id".MailID;
                            //"to mail" := 'jhansi@efftronics.com,sal@efftronics.com,erp@efftronics.com,cvmohan@efftronics.com';
                            Recipient.Add('jhansi@efftronics.com,');
                        Recipient.Add('sal@efftronics.com');
                        Recipient.Add('erp@efftronics.com');
                        Recipient.Add('cvmohan@efftronics.com');
                        MODIFY;
                        IF ("from Mail" <> '') AND ("to mail" <> '') THEN BEGIN
                            //SMTP_MAIL.CreateMessage('ERP', "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);
                            EmailMessage.Create(Recipient, Mail_Subject, Mail_Body, false);
                            EmailMessage.AddAttachment(Attachment, '', '');//EFFUPG Added ('')
                            Email.send(EmailMessage, Enum::"Email Scenario"::Default);
                            // SMTP_MAIL.Send;
                        END;
                    end;
                }
                action("Short Close Order")
                {
                    Caption = 'Short Close Order';
                    Image = Close;
                    ToolTip = 'Short Close Order';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        OrderStatusValue: Text[50];
                        Text050: Label 'Do you want to Short Close the Order No. %1';
                    begin
                        IF NOT (USERID IN ['EFFTRONICS\PRANAVI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
                            ERROR('You Do not have Right to Short Close!');
                        IF CONFIRM(Text050, FALSE, "No.") THEN BEGIN
                            OrderStatusValue := 'Close';
                            CancelCloseOrder(OrderStatusValue, Rec);
                            CurrPage.UPDATE(FALSE);
                        END;
                    end;
                }
            }
            action("Make &Order")
            {
                Caption = 'Make &Order';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                var
                    PurchaseHeader: Record "Purchase Header";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    //TESTFIELD("Sale Order Total Amount");
                    if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then
                        CODEUNIT.Run(CODEUNIT::"Blnkt Sales Ord. to Ord. (Y/N)", Rec);
                end;
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    DocPrint.PrintSalesHeader(Rec);
                end;
            }
            action("Forward to OMS")
            {
                Caption = 'Forward to OMS';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                var
                    OMSIntegrateCode: Codeunit SQLIntegration;
                    SalesLine: Record "Sales Line";
                begin
                    IF Status = Status::Released THEN BEGIN
                        //MESSAGE('Today OMS Integration Stopped');
                        MESSAGE("No.");
                        SalesLine.SETRANGE("Document Type", "Document Type");
                        SalesLine.SETRANGE("Document No.", "No.");
                        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                        IF SalesLine.FINDFIRST THEN BEGIN
                            IF "Document Type" = "Document Type"::"Blanket Order" THEN BEGIN
                                IF (OMSIntegrateCode.SaleOrderCreationinOMS(Rec)) = FALSE THEN BEGIN
                                    MESSAGE('Error occured in OMS integration and record is not posted');
                                END;
                            END;
                        END;
                    END ELSE
                        ERROR('Order in Open State');
                end;
            }
            action(Comment)
            {
                Caption = 'Comment';
                Image = Comment;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 67;
                RunPageLink = "Document Type" = CONST("Blanket Order"), "No." = FIELD("No."), "Document Line No." = CONST(0);
                ToolTip = 'Comment';
                ApplicationArea = All;
            }
            action(Action1102152004)
            {
                Caption = 'Short Close Order';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Short Close Order';
                ApplicationArea = All;

                trigger OnAction();
                var
                    OrderStatusValue: Text[50];
                    Text050: Label 'Do you want to Short Close the Order No. %1';
                begin
                    IF NOT (USERID IN ['EFFTRONICS\PRANAVI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\GRAVI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
                        ERROR('You Do not have Right to Short Close!');
                    IF CONFIRM(Text050, FALSE, "No.") THEN BEGIN
                        OrderStatusValue := 'Close';
                        CancelCloseOrder(OrderStatusValue, Rec);
                        CurrPage.UPDATE(FALSE);
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        CHANGELOGSETUP.SETFILTER(CHANGELOGSETUP."Primary Key Field 2 Value", FORMAT("No."));
        IF CHANGELOGSETUP.COUNT > 0 THEN
            forwordomsVisible := TRUE
        ELSE
            forwordomsVisible := FALSE;
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        CurrPage.SAVERECORD;
        EXIT(ConfirmDeletion);
    end;

    trigger OnInit();
    begin
        forwordomsVisible := TRUE;
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        TESTFIELD(Status, Status::Open);
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        "Responsibility Center" := UserMgt.GetSalesFilter;
    end;

    trigger OnOpenPage();
    begin
        IF UserMgt.GetSalesFilter <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Responsibility Center", UserMgt.GetSalesFilter);
            FILTERGROUP(0);
        END;
        forwordtooms := 'Need To Press FORWARD OMS Button';
    end;

    var
        EmailMessage: Codeunit "Email Message";
        Recipient: List of [Text];
        Email: Codeunit Email;
        CurrentSalesLine: Record "Sales Line";
        SalesLine: Record "Sales Line";
        SaleShptLine: Record "Sales Shipment Line";
        SalesInvLine: Record "Sales Invoice Line";
        ReturnRcptLine: Record "Return Receipt Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        ChangeExchangeRate: Page 511;
        CopySalesDoc: Report 292;
        DocPrint: Codeunit 229;
        SalesSetup: Record "Sales & Receivables Setup";
        UserMgt: Codeunit "User Setup Management";
        Text16500: TextConst ENU = 'To calculate invoice discount, check Cal. Inv. Discount on header when Price Inclusive of Tax = Yes.\This option cannot be used to calculate invoice discount when Price Inclusive Tax = Yes.';
        "Mail-Id": Record User;
        "from Mail": Text[100];
        "to mail": Text[1000];

        Mail_Subject: Text[250];
        Mail_Body: Text[250];
        mail: Codeunit Mail;
        SalesPlanLine: Record "Sales Planning Line";
        Quantity: Decimal;
        I: Integer;
        Qty: Integer;
        SalesLineRec: Record "Sales Line";
        NewStatus: Option Simulated,Planned,"Firm Planned",Released;
        NewOrderType: Option ItemOrder,ProjectOrder;
        charline: Char;
        SH: Record "Sales Header";
        Attachment: Text[1000];
        /* objEmailConf: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000002-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Configuration";
        objEmail: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000001-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Message";
        flds: Automation "'{00000205-0000-0010-8000-00AA006D2EA4}' 2.5:'{00000564-0000-0010-8000-00AA006D2EA4}':''{00000205-0000-0010-8000-00AA006D2EA4}' 2.5'.Fields";
        fld: Automation "'{00000205-0000-0010-8000-00AA006D2EA4}' 2.5:'{00000569-0000-0010-8000-00AA006D2EA4}':''{00000205-0000-0010-8000-00AA006D2EA4}' 2.5'.Field"; */
        SMTPSETUP: Record "Product Customer's List";
        newline: Char;
        Text01: Label 'Do You want to Send the Document to Design?';
        //  SMTP_MAIL: Codeunit "SMTP Mail";
        forwordtooms: Text[50];
        CHANGELOGSETUP: Record "Change Log Entry";

        forwordomsVisible: Boolean;
        SHA: Record "Sales Header Archive";

    local procedure ApproveCalcInvDisc();
    begin
        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
    end;

    procedure CreateOrders(Qtyparam: Decimal) OrdersCreated: Boolean;
    var
        Item: Record Item;
        SalesLine: Record "Sales Line";
        ProdOrderFromSale: Codeunit "Event Handling Cust";
    begin
        IF NOT SalesPlanLine.FINDSET THEN
            EXIT;

        REPEAT
            SalesLine.GET(
              SalesLine."Document Type"::"Blanket Order",
              SalesPlanLine."Sales Order No.",
              SalesPlanLine."Sales Order Line No.");
            //SalesLine.TESTFIELD("Shipment Date");
            SalesLine.CALCFIELDS("Reserved Qty. (Base)");
            //IF SalesLine."Outstanding Qty. (Base)" > SalesLine."Reserved Qty. (Base)" THEN BEGIN
            Item.GET(SalesLine."No.");

            IF Item."Replenishment System" = Item."Replenishment System"::"Prod. Order" THEN BEGIN
                OrdersCreated := TRUE;
                ProdOrderFromSale.CreateProdOrder2(SalesLine, NewStatus::Released, NewOrderType::ItemOrder, 1);
                IF NewOrderType = NewOrderType::ProjectOrder THEN
                    EXIT;
            END;
        //END;
        UNTIL (SalesPlanLine.NEXT = 0);

        /*nextline:=10;
            "Mail-Id".SETRANGE("Mail-Id"."User ID",USERID);
            IF "Mail-Id".FINDFIRST THEN
            "from Mail":="Mail-Id".MailID;
           "to mail":='anilkumar@efftronics.com,padmaja@efftronics.com';
            Mail_Subject:='ERP- '+"No." +'  Expected Order Modified';    */
        /*    Mail_Body+='SALE ORDER RELEASE :';
            Mail_Body+=FORMAT(nextline);
            Mail_Body+=FORMAT(nextline);
            Mail_Body+='Sale Order No          : '+"No.";
            Mail_Body+=FORMAT(nextline);
            Mail_Body+='Customer Name          : '+"Sell-to Customer Name";
            Mail_Body+=FORMAT(nextline);
            Mail_Body+='Customer Place         : '+"Sell-to City";
            Mail_Body+=FORMAT(nextline);
            Mail_Body+='Customer Type          : '+"Customer Posting Group";
            Mail_Body+=FORMAT(nextline);
            Mail_Body+='Product                : '+Product;
            Mail_Body+=FORMAT(nextline);
            Mail_Body+='Customer LOA No.       : '+"Customer OrderNo.";
            SH.SETFILTER(SH."No.","No.");
        REPORT.RUN(50096,FALSE,FALSE,SH);
        REPORT.SAVEASHTML(50096,'\\erpserver\ErpAttachments\Order.html',FALSE,SH);
        Attachment:='\\erpserver\ErpAttachments\Order.html';
        */
        //IF ("from Mail"<>'')AND("to mail"<>'') THEN
        // mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');

    end;

    local procedure SelltoCustomerNoOnAfterValidat();
    begin
        CurrPage.UPDATE;
    end;

    local procedure SalespersonCodeOnAfterValidate();
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
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

    local procedure CurrencyCodeOnAfterValidate();
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;
}

