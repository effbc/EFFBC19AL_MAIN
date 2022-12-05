pageextension 70155 PurchaseOrderExt extends 50
{
    layout
    {
        /*  modify("Pay-to Address")
          {
              Enabled = TRUE;
          }
          modify("Ship-to Post Code")
          {
              CaptionML = ENU = 'Ship-to Post Code/City';
          }
          modify("Order Date")
          {
              Visible = false;
          }
          modify("Quote No.")
          {
              Visible = false;
          }
          modify("Shortcut Dimension 1 Code")
          {
              Visible = false;
          }
          modify("Shortcut Dimension 2 Code")
          {
              Visible = false;
          }
          modify("Requested Receipt Date")
          {
              Visible = false;
          }*/
        addafter("No. of Archived Versions")
        {

            /* field("C Form"; Rec."C Form")
             {
                 ApplicationArea = All;
             }
             field("<Form Code 2 >"; Rec."Form Code")
             {
                 ApplicationArea = All;
             }*/
            field("First Release DateTime"; Rec."First Release DateTime")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Release Date Time"; Rec."Release Date Time")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Tender No"; Rec."Tender No")
            {
                ApplicationArea = All;
            }
            field("Sale Order No"; Rec."Sale Order No")
            {
                ApplicationArea = All;
            }
        }
        addafter("Posting Date")
        {
            field("First Release By"; Rec."First Release By")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Released By"; Rec."Released By")
            {
                Editable = false;
                ApplicationArea = All;
            }

        }
        addafter("Document Date")
        {
            field("Inclusive of All Taxes"; Rec."Inclusive of All Taxes")
            {
                ApplicationArea = All;
            }
        }
        addafter("Purchaser Code")
        {
            field("Quotation Date"; Rec."Quotation Date")
            {
                ApplicationArea = All;
            }
            field("Quotation No."; Rec."Quotation No.")
            {
                ApplicationArea = All;
            }

            field("<Expected Receipt Date 2>"; Rec."Expected Receipt Date")
            {
                Importance = Promoted;
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    /*PurchLine.SETRANGE(PurchLine."Document No.","No.");
                   IF PurchLine.FINDSET THEN
                   REPEAT
                     PurchLine."Expected Receipt Date":="Expected Receipt Date";
                     PurchLine."Deviated Receipt Date":="Expected Receipt Date";
                     PurchLine.MODIFY;
                   UNTIL PurchLine.NEXT=0;*/
                    //  commented by sujani on 27-jul-18

                end;
            }
        }

        addafter("Job Queue Status")
        {
            field("Way bill"; Rec."Way bill")
            {
                ApplicationArea = All;
            }
            field(Mail_Sent; Mail_Sent)
            {
                Editable = mail_send_editable;
                ApplicationArea = All;
            }
            field(Mail_count; Mail_count)
            {
                Caption = 'Mail Sent count';
                DecimalPlaces = 0 : 0;
                Editable = mail_send_editable;
                ApplicationArea = All;
            }
            field("Purchaser Code1"; Rec."Purchaser Code")
            {
                CaptionML = ENU = 'Purchaser Code1',
                            ENN = 'Purchaser Code';
                ApplicationArea = All;
            }
            field("Acknowledge Given by"; Rec."Acknowledge Given by")
            {
                ApplicationArea = All;
            }
            field("Acknowledged Dt"; Rec."Acknowledged Dt")
            {
                ApplicationArea = All;
            }
        }
        addafter("Pay-to City")
        {
            field(State; State)
            {
                ApplicationArea = All;
            }
        }
        addafter("Pay-to Contact")
        {
            field("OrderCreated by"; Rec."OrderCreated by")
            {
                Editable = false;
                ApplicationArea = All;
            }

        }
        addafter("Payment Terms Code")
        {
            field("Do not Consider GST"; Rec."Do not Consider GST")
            {
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    TESTFIELD(Status, Status::Open);
                    IF "Payment Terms Code" <> 'TOTADV' THEN
                        ERROR('This is only applicable for TOTAL ADVANCE payment terms');
                end;
            }
        }
        addafter("VAT Bus. Posting Group")
        {
            field(QA_Auth_Status; QA_Auth_Status)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(QA_Auth_Date; QA_Auth_Date)
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Ship-to City")
        {
            field("Packing Type"; Rec."Packing Type")
            {
                ApplicationArea = All;
            }
            field("Vendor Excise Invoice No."; Rec."Vendor Excise Invoice No.")
            {
                ApplicationArea = All;
            }
            field("Vend. Excise Inv. Date"; Rec."Vend. Excise Inv. Date")
            {
                ApplicationArea = All;
            }
        }

        addafter("Area")
        {
            field("MSPT Date"; Rec."MSPT Date")
            {
                ApplicationArea = All;
            }
            field("MSPT Code"; Rec."MSPT Code")
            {
                ApplicationArea = All;
            }
            field("Receiving No."; Rec."Receiving No.")
            {
                ApplicationArea = All;
            }
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
            }
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
            }
            field("Receiving No. Series"; Rec."Receiving No. Series")
            {
                ApplicationArea = All;
            }
            //EFFUPG>>
            Field(Reason; Reason)
            {

                ApplicationArea = All;
            }
            //EFFUPG<<
        }

    }

    actions
    {
        /* modify(Dimensions)
         {
             Promoted = false;
             PromotedIsBig = false;
         }*/
        modify(Statistics)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        /*modify(Card)
        {
            Promoted = false;
            PromotedIsBig = false;
        }
        modify(Invoices)
        {
            Promoted = false;
            PromotedIsBig = false;
        }*/
        modify(Approve)
        {
            Promoted = true;
            PromotedIsBig = true;
        }

        modify(Reject)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Delegate)
        {
            Promoted = true;
        }
        modify(Comment)
        {
            Promoted = true;
        }
        modify(Release)
        {
            Promoted = true;
        }
        modify(Reopen)
        {
            ShortCutKey = 'Ctrl+Alt+O';
            trigger OnBeforeAction()
            begin
                IF Rec."No." = 'EFF/18-19/P/O/01802' THEN
                    ERROR('You Do not have rights to reopen this order');
                IF NOT (UPPERCASE(USERID) IN ['EFFTRONICS\CHOWDARY', 'EFFTRONICS\PADMASRI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\GRAVI', 'EFFTRONICS\PKOTESWARARAO', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\SPURTHI', 'EFFTRONICS\ANVESH', 'EFFTRONICS\RENUKACH'
                                    , 'EFFTRONICS\ANANDA', 'EFFTRONICS\NSUDHEER', 'EFFTRONICS\RAVIKIRAN', 'EFFTRONICS\PARDHU', 'EFFTRONICS\DURGAMAHESWARI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\RRAHUL', 'EFFTRONICS\B2BOTS', 'EFFTRONICS\LAKSHMIKANTH']) THEN
                    ERROR('You have No Rights to reopen a Released order. Contact Purchase Manager.')
                ELSE
                    ;
            end;

            trigger OnAfterAction()
            begin
                "G\L".GET;
                /* "G\L".FINDFIRST THEN BEGIN
                    "Calculate Tax Structure" := FALSE;
                    MODIFY;
                    //cashflow integration
                    CashFlowConnection.ExecInOracle('Update Purchase_line Set Actinact=0 Where   OrderNo=''' + "No." + '''');
                END;*/
            end;
        }
        modify(CopyDocument)
        {
            Promoted = true;
        }

        /* modify("Calc&ulate Structure Values")
         {
             ShortCutKey = 'Ctrl+F7';
             trigger OnBeforeAction()
             begin
                 IF (Structure = 'PURCH_GST') THEN BEGIN
                     IF ("GST Vendor Type" = "GST Vendor Type"::" ") THEN
                         ERROR('GST Vendor Type Not Defined. Please check Vendor GST Details');
                     IF ("GST Vendor Type" <> "GST Vendor Type"::Import) THEN BEGIN
                         PL.RESET;
                         PL.SETFILTER(PL."Document No.", "No.");
                         PL.SETFILTER("Qty. to Receive", '>%1', 0);
                         IF PL.FINDSET THEN
                             REPEAT
                                 IF PL."No." <> '' THEN BEGIN
                                     IF (PL."HSN/SAC Code" = '') AND (UPPERCASE(USERID) <> 'EFFTRONICS\VIJAYA') THEN
                                         ERROR('Please Enter HSN/SAC Details for Line No :: ' + FORMAT(PL."Line No."));
                                     IF (PL."GST Group Code" = '') AND (UPPERCASE(USERID) <> 'EFFTRONICS\VIJAYA') THEN
                                         ERROR('Please Enter GST Group Code Details for Line No :: ' + FORMAT(PL."Line No."));
                                 END;
                             UNTIL PL.NEXT = 0;
                     END;
                 END;
                 Location_Mismatch_Not;
                 // added by vishnu priya for Vendor Minimum Order Value Checking on 18-12-2018
                 checkminimumordervalue;

                 "G\L".GET;
                 IF "G\L"."Active ERP-CF Connection" THEN BEGIN
                     Rec.TESTFIELD(Status, Rec.Status::Open);
                     Rec.TESTFIELD(Structure);
                     Rec.TESTFIELD("Order Date");
                     Rec."Calculate Tax Structure" := TRUE;
                     Rec.MODIFY;
                 END;
             end;
         }*/ //B2B UPG
        modify(SendApprovalRequest)
        {
            Promoted = true;
        }
        modify(CancelApprovalRequest)
        {
            Promoted = true;
        }
        modify("Create Inventor&y Put-away/Pick")
        {
            Promoted = true;
        }
        modify(Post)
        {
            Promoted = true;
            PromotedIsBig = true;
            trigger OnBeforeAction()
            begin
                TESTFIELD(Status, Status::Released);
                // TESTFIELD(Structure);
                TESTFIELD("Payment Terms Code");
            end;
        }
        modify("Post and &Print")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("&Print")
        {
            Promoted = true;
        }
        addfirst(Action13)
        {
            separator(Action1102152027)
            {
            }
            action("Short Close Order")
            {
                Caption = 'Short Close Order';
                Image = CloseDocument;
                ApplicationArea = All;

                trigger OnAction();
                var
                    OrderStatusValue: Text[50];
                    Text050: Label 'Do you want to Short Close the Order No. %1';
                begin
                    IF NOT (USERID IN ['EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\ANVESH', 'EFFTRONICS\SPURTHI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN    //Added by Pranavi on 03-Dec-2015
                        ERROR('You Do Not Have Rights to Short Close the Order!');
                    IF CONFIRM(Text050, FALSE, "No.") THEN BEGIN
                        OrderStatusValue := 'Close';
                        CancelCloseOrder(OrderStatusValue, Rec);
                        CurrPage.UPDATE(FALSE);
                    END;
                end;
            }
            action("Cancel Order")
            {
                Caption = 'Cancel Order';
                Image = Closed;
                ApplicationArea = All;

                trigger OnAction();
                var
                    OrderStatusValue: Text[50];
                    Text051: Label 'Do you want to Cancel the Order No. %1';
                begin
                    IF NOT (USERID IN ['EFFTRONICS\PRANAVI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\ANVESH', 'EFFTRONICS\SPURTHI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN    //Added by Pranavi on 03-Dec-2015
                        ERROR('You Do Not Have Rights to Cancel Order!');
                    IF CONFIRM(Text051, FALSE, "No.") THEN BEGIN
                        OrderStatusValue := 'Cancel';
                        CancelCloseOrder(OrderStatusValue, Rec);
                        CurrPage.UPDATE(FALSE);
                    END;
                end;
            }
        }

        addafter(Reopen)
        {
            separator(Action1102152013)
            {
            }
            action("MSPT Order Details")
            {
                Caption = 'MSPT Order Details';
                Image = ViewDetails;
                RunObject = Page "MSPT Order Details";
                RunPageLink = Type = CONST(Purchase), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            action("Send For QC Approval")
            {
                ApplicationArea = All;

                trigger OnAction();
                var
                    Body: Text;
                    Mail_From: Text[250];
                    Mail_To: Text[250];
                    // Mail: Codeunit 397;
                    Subject: Text[250];
                    //SMTP_MAIL: Codeunit "SMTP Mail";
                    AuthorizedID: Text[50];
                    ReqUserGRec: Record "User Setup";
                    AuthUserGRec: Record User;
                    Auth_User: Text[50];
                    Req_User: Text[50];
                    Req_Person_Id: Code[10];
                    SH: Record "Sales Header";
                    customername: Text[100];
                    PurchaseHeader: Record "Purchase Header";
                    Attachment1: Text[50];
                    //EmailMessage: Codeunit 8904;
                    //Email: Codeunit 8901;
                    Recipients: List of [Text];
                begin
                    // Added by Pranavi on 03-Dec-2016 for B-Out Material QC Approval
                    /* IF "Sale Order No" = '' THEN
                        ERROR('Sale Order No. should not be null!');
                    IF QA_Auth_Status = QA_Auth_Status::Authorized THEN
                        ERROR('Already authorized by the QA!')
                    ELSE
                        IF QA_Auth_Status = QA_Auth_Status::"Sent For Auth" THEN
                            ERROR('Already sent for Authorization!');
                    SH.RESET;
                    SH.SETRANGE(SH."No.", "Sale Order No");
                    SH.SETRANGE(SH."Document Type", SH."Document Type"::Order);
                    IF SH.FINDFIRST THEN
                        customername := SH."Sell-to Customer Name";

                    Body := '';
                    Mail_From := '';
                    Mail_To := '';
                    Req_Person_Id := '';
                    ReqUserGRec.RESET;
                    ReqUserGRec.SETRANGE(ReqUserGRec."User Name", USERID);
                    IF ReqUserGRec.FINDFIRST THEN BEGIN
                        Req_User := ReqUserGRec."User Name";
                        Req_Person_Id := ReqUserGRec.EmployeeID;
                        IF ReqUserGRec.MailID <> '' THEN
                            Mail_From := ReqUserGRec.MailID
                        ELSE
                            Mail_From := 'erp@efftronics.com';
                    END ELSE
                        Mail_From := 'erp@efftronics.com';
                    Req_User := COPYSTR(USERID, 12, STRLEN(USERID));
                    Auth_User := 'BHARAT V';
                    Mail_To := 'qainward@efftronics.com,erp@efftronics.com,sysadmin@efftronics.com';
                    //Mail_To := 'pranavi@efftronics.com';
                    Subject := 'ERP-QA Conformation Required for purchase of Bought Out Items in P.O.: ' + "No." + ' for (' + customername + '--' + "Sale Order No" + ')';
                    Body := '<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>';
                    Body += '<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;"><label><font size="6">P.O. Details</font></label>';
                    Body += '<hr style=solid; color= #3333CC>';
                    Body += '<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;">';
                    Body += '<tr><td>Purchase Order</td><td>' + "No." + '</td></tr><br>';
                    Body += '<tr><td>Vendor</td><td>' + "Buy-from Vendor Name" + '</td></tr><br>';
                    Body += '<tr><td>Sales Order</td><td>' + "Sale Order No" + '</td></tr><br>';
                    Body += '<tr><td>Customer</td><td>' + customername + '</td></tr><br>';
                    Body += '<tr><td bgcolor="green">';
                    Body += '<a Href="http://app.efftronics.org:8567/erp_reports/Purch_BOI_QA_Auth.aspx?PO_NO=' + FORMAT("No.");
                    Body += '&AUTHPERSON=' + FORMAT(Auth_User);
                    Body += '&REQPERSON=' + FORMAT(Req_User);
                    Body += '&REQPERSONMAIL=' + Mail_From;
                    Body += '&REQID=' + Req_Person_Id;
                    Body += '&SALE_ORDER_NO=' + "Sale Order No";
                    Rec.
Body += '&CUSTOMER=' + customername;
                    Body += '&AUTHSTATUS=1"target="_blank">';
                    Body += '<font face="arial" color="#ffffff">ACCEPT</font></a>';

                    Body += '</td><td bgcolor="red">';
                    Body += '<a Href="http://app.efftronics.org:8567/erp_reports/Purch_BOI_QA_Auth.aspx?PO_NO=' + FORMAT("No.");
                    Body += '&AUTHPERSON=' + FORMAT(Auth_User);
                    Body += '&REQPERSON=' + FORMAT(Req_User);
                    Body += '&REQPERSONMAIL=' + Mail_From;
                    Body += '&REQID=' + Req_Person_Id;
                    Body += '&SALE_ORDER_NO=' + "Sale Order No";
                    Rec.
Body += '&CUSTOMER=' + customername;
                    Body += '&AUTHSTATUS=0"target="_blank">';
                    Body += '<font face="arial" color="#ffffff">REJECT</font></a></td></tr>';

                    Body += '</table><br>';
                    Body += '<p align = "left"></b>Please go through the attached P.O.</b></P>';
                    Body += '<br><p align = "center">:: Note: Auto Generated mail from ERP</b> :: </b></P></div></body></html>';
                    SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);

                    PurchaseHeader.SETRANGE(PurchaseHeader."No.", "No.");
                    REPORT.RUN(50058, FALSE, FALSE, PurchaseHeader);
                    REPORT.SAVEASPDF(50058, '\\erpserver\ERPattachments\podetails.PDF', PurchaseHeader);
                    Attachment1 := '\\erpserver\ERPattachments\podetails.PDF';
                    SMTP_MAIL.AddAttachment(Attachment1, ''); //EFFUPG


                    SMTP_MAIL.Send;

                    QA_Auth_Status := QA_Auth_Status::"Sent For Auth";
                    Rec.
QA_Auth_Date := TODAY;
                    MODIFY; */  //B2BUPG

                    IF "Sale Order No" = '' THEN
                        ERROR('Sale Order No. should not be null!');
                    IF QA_Auth_Status = QA_Auth_Status::Authorized THEN
                        ERROR('Already authorized by the QA!')
                    ELSE
                        IF QA_Auth_Status = QA_Auth_Status::"Sent For Auth" THEN
                            ERROR('Already sent for Authorization!');
                    SH.RESET;
                    SH.SETRANGE(SH."No.", "Sale Order No");
                    SH.SETRANGE(SH."Document Type", SH."Document Type"::Order);
                    IF SH.FINDFIRST THEN
                        customername := SH."Sell-to Customer Name";

                    Body := '';
                    Mail_From := '';
                    Mail_To := '';
                    Req_Person_Id := '';
                    ReqUserGRec.RESET;
                    ReqUserGRec.SETRANGE(ReqUserGRec."User ID", USERID);
                    IF ReqUserGRec.FINDFIRST THEN BEGIN
                        Req_User := ReqUserGRec."User ID";
                        Req_Person_Id := ReqUserGRec.EmployeeID;
                        /*IF ReqUserGRec.MailID <> '' THEN
                            Mail_From := ReqUserGRec.MailID
                        ELSE
                            Mail_From := 'erp@efftronics.com';
                    END ELSE
                        Mail_From := 'erp@efftronics.com'; */
                        Req_User := COPYSTR(USERID, 12, STRLEN(USERID));
                        Auth_User := 'BHARAT V';
                        //Recipients.Add('qainward@efftronics.com');
                        Recipients.Add('erp@efftronics.com');
                        //Recipients.Add('sysadmin@efftronics.com');
                        Subject := 'ERP-QA Conformation Required for purchase of Bought Out Items in P.O.: ' + "No." + ' for (' + customername + '--' + "Sale Order No" + ')';
                        Body := '<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>';
                        Body += '<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;"><label><font size="6">P.O. Details</font></label>';
                        Body += '<hr style=solid; color= #3333CC>';
                        Body += '<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;">';
                        Body += '<tr><td>Purchase Order</td><td>' + "No." + '</td></tr><br>';
                        Body += '<tr><td>Vendor</td><td>' + "Buy-from Vendor Name" + '</td></tr><br>';
                        Body += '<tr><td>Sales Order</td><td>' + "Sale Order No" + '</td></tr><br>';
                        Body += '<tr><td>Customer</td><td>' + customername + '</td></tr><br>';
                        Body += '<tr><td bgcolor="green">';
                        Body += '<a Href="http://app.efftronics.org:8567/erp_reports/Purch_BOI_QA_Auth.aspx?PO_NO=' + FORMAT("No.");
                        Body += '&AUTHPERSON=' + FORMAT(Auth_User);
                        Body += '&REQPERSON=' + FORMAT(Req_User);
                        Body += '&REQPERSONMAIL=' + Mail_From;
                        Body += '&REQID=' + Req_Person_Id;
                        Body += '&SALE_ORDER_NO=' + Rec."Sale Order No";

                        Body += '&CUSTOMER=' + customername;
                        Body += '&AUTHSTATUS=1"target="_blank">';
                        Body += '<font face="arial" color="#ffffff">ACCEPT</font></a>';

                        Body += '</td><td bgcolor="red">';
                        Body += '<a Href="http://app.efftronics.org:8567/erp_reports/Purch_BOI_QA_Auth.aspx?PO_NO=' + FORMAT("No.");
                        Body += '&AUTHPERSON=' + FORMAT(Auth_User);
                        Body += '&REQPERSON=' + FORMAT(Req_User);
                        Body += '&REQPERSONMAIL=' + Mail_From;
                        Body += '&REQID=' + Req_Person_Id;
                        Body += '&SALE_ORDER_NO=' + Rec."Sale Order No";

                        Body += '&CUSTOMER=' + customername;
                        Body += '&AUTHSTATUS=0"target="_blank">';
                        Body += '<font face="arial" color="#ffffff">REJECT</font></a></td></tr>';

                        Body += '</table><br>';
                        Body += '<p align = "left"></b>Please go through the attached P.O.</b></P>';
                        Body += '<br><p align = "center">:: Note: Auto Generated mail from ERP</b> :: </b></P></div></body></html>';
                        EmailMessage.Create(Recipients, Subject, Body, true);

                        PurchaseHeader.SETRANGE(PurchaseHeader."No.", "No.");
                        REPORT.RUN(50058, FALSE, FALSE, PurchaseHeader);
                        REPORT.SAVEASPDF(50058, '\\erpserver\ERPattachments\podetails.PDF', PurchaseHeader);
                        Attachment1 := '\\erpserver\ERPattachments\podetails.PDF';
                        EmailMessage.AddAttachment(Attachment1, '', ''); //EFFUPG


                        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

                        QA_Auth_Status := QA_Auth_Status::"Sent For Auth";
                        Rec.
                        QA_Auth_Date := TODAY;
                        MODIFY;
                    end;
                end;
            }
        }
        addafter("Archive Document")
        {
            action("Send Request for Release")
            {
                Caption = 'Send Request for Release';
                Image = SendApprovalRequest;
                ToolTip = 'Send Request for Release';
                ApplicationArea = All;

                trigger OnAction();
                begin

                    "G\L".GET;

                    IF "G\L"."Active ERP-CF Connection" THEN BEGIN
                        TESTFIELD(Status, Status::Open);
                        TESTFIELD("Payment Terms Code");
                        IF "Payment Terms".GET("Payment Terms Code") THEN BEGIN
                            IF NOT "Payment Terms"."Update In Cashflow" THEN
                                ERROR('PAYMENT TERMS CODE MUST BE UPDATED IN CASH FLOW');
                        END;
                        /* IF (NOT "Calculate Tax Structure") AND (Structure <> '') THEN
                             ERROR('PLEASE CALCULATE THE TAX STRUCTURE');*/ //B2BUPG
                    END;
                    IF "Order Date" = 0D THEN
                        MESSAGE('PLEASE ENTER THE ORDER DATE ');

                    /* IF (Structure = '') AND (NOT "Inclusive of All Taxes") AND ("Order Date" > DMY2Date(12, 17, 09)) THEN //Rev01
                         ERROR('PLEASE ENTER THE TAX STRUCTRE & CALCULATE THE TAX STRUCTURE');*/ //B2BUPG

                    IF ("Location Code" = 'R&D STR') AND (COPYSTR("Shortcut Dimension 1 Code", 1, 2) <> 'RD') THEN
                        ERROR('Please Pick R&D Dimension Code');

                    IF ("Location Code" = 'CS STR') AND (COPYSTR("Shortcut Dimension 1 Code", 1, 3) <> 'CUS') THEN
                        ERROR('Please Pick CS Dimension Code');

                    IF ("Location Code" = 'STR') AND (COPYSTR("Shortcut Dimension 1 Code", 1, 3) <> 'PRD') THEN
                        ERROR('Please Pick PRD Dimension Code');

                    PurchLine.SETRANGE(PurchLine."Document No.", "No.");
                    PurchLine.SETFILTER(PurchLine.Quantity, '>%1', 0);
                    IF PurchLine.FINDSET THEN
                        REPEAT
                            IF PurchLine."Buy-from Vendor No." <> "Buy-from Vendor No." THEN
                                ERROR('VENDOR MUST BE SAME IN PURCHASE LINES & HEADER');
                            IF (PurchLine.Type = PurchLine.Type::Item) OR (PurchLine.Type = PurchLine.Type::"G/L Account") THEN BEGIN
                                IF (("Sale Order No" = '') AND (PurchLine.Type = PurchLine.Type::Item)) AND ("Order Date" > DMY2Date(06, 01, 09)) THEN BEGIN
                                    IF (PurchLine."Indent No." = '') AND (PurchLine."Qty. to Receive" > 0) THEN
                                        ERROR(' THERE IS NO INDENT FOR THE ITEM  ' + PurchLine.Description);
                                END;
                                PurchLine.TESTFIELD(PurchLine."Expected Receipt Date");

                                IF PurchLine."Gen. Prod. Posting Group" = '' THEN
                                    ERROR(' THERE IS NO "Gen. Prod. Posting Group" FOR ' + PurchLine.Description);
                                IF (PurchLine."Location Code" = 'SITE') AND ("Order Date" > DMY2Date(08, 11, 09)) THEN BEGIN
                                    IF PurchLine."Shortcut Dimension 2 Code" = '' THEN
                                        ERROR('Please Enter the Site Information');
                                    IF ("Sale Order No" = '') THEN
                                        ERROR('Please Enter the Sale Order Information');
                                END ELSE
                                    IF (PurchLine."Location Code" = 'SITE') AND ("Order Date" < DMY2Date(08, 11, 09)) THEN BEGIN
                                        IF ("Sale Order No" = '') THEN
                                            ERROR('Please Enter the Sale Order Information');
                                    END;

                                IF (PurchLine."Direct Unit Cost" = 0) AND NOT (PurchLine.Sample) THEN
                                    ERROR('THERE IS NO COST FOR THE ITEM  ' + PurchLine.Description);

                                IF (PurchLine.Type <> PurchLine.Type::"G/L Account") THEN
                                    PurchLine.TESTFIELD(PurchLine."QC Enabled");

                                IF "Location Code" <> PurchLine."Location Code" THEN
                                    ERROR('location code not matching in both line and header');
                            END;
                        UNTIL PurchLine.NEXT = 0;

                    TESTFIELD(Status, Status::Open);
                    USER.SETRANGE(USER."User ID", USERID);//Rev01
                    IF USER.FIND('-') THEN BEGIN
                        Body := '';
                        Subject := '';
                        attachment := '';
                        FileDirectory := '';
                        FileName := '';
                        if user1.Get(USER."User ID") then
                            Subject := user1."Full Name" + ' Requesting to Release the Purchase Order ' + "No.";

                        Body += '<body><strong><form><table style="WIDTH:500px; HEIGHT: 20px; "';
                        Body += 'border="1" align="center">';
                        // Body+='<tr><td align="center" ><img src="http://eff-cpu-178/pur%20Auth/Default.aspx?"  /></TD></TR>';
                        Body += '<tr><td>PURCHASE ORDER NO. :</td><td>' + "No.";

                        Body += '<tr><td>VENDOR :</td><td>' + "Buy-from Vendor Name";

                        Body += '<tr><td>ORDER VALUE :</td><td>' + FORMAT(Order_Value("No."));
                        Body += '<tr><td bgcolor=#99FF66 color=#FFFFFF  align="center" ><a href="';
                        // Body+='http://localhost:8080/Purchase/Default.aspx?';
                        Body += 'http://eff-cpu-178/pur%20auth/Default.aspx?';
                        Body += 'val1=' + FORMAT(USERID);
                        Body += '&val2=' + FORMAT("No.");
                        Body += '&val3=1';
                        Body += '&val4=Chowdary@efftronics.com';
                        Body += '&val5=' + USER.MailID;
                        Body += '&val6=Release';
                        if user1.Get(USER."User ID") then
                            Body += '&val7=' + user1."Full Name";

                        Body += '&val8=' + "Buy-from Vendor Name";

                        Body += '&val9=' + FORMAT(Order_Value("No."));
                        Body += '" target="_blank"><b>Accepted</b></a></td>';
                        Body += '<td bgcolor=#FF3300 color=#FFFFFF  align="center" ><a href="';
                        // Body+='http://localhost:8080/Purchase/Default.aspx?';
                        Body += 'http://eff-cpu-178/pur%20Auth/Default.aspx?';
                        Body += 'val1=' + FORMAT(USERID);
                        Body += '&val2=' + FORMAT("No.");
                        Body += '&val3=0';
                        Body += '&val4=Chowdary@efftronics.com';
                        Body += '&val5=' + USER.MailID;
                        Body += '&val6=Release';
                        if user1.Get(USER."User ID") then
                            Body += '&val7=' + user1."Full Name";

                        Body += '&val8=' + "Buy-from Vendor Name";

                        Body += '&val9=' + FORMAT(Order_Value("No."));
                        Body += '" target="_blank"><b>Rejected</b></a></td>';
                        Body += '</table></form></font></strong></body>';
                        /*
                          IF ISCLEAR(BullZipPDF) THEN
                          CREATE(BullZipPDF);
                          FileDirectory := '\\eff-cpu-222\erp\';
                          Window.OPEN('processing  Order ######################1##');
                          Window.UPDATE(1,"No.");
                          filname:=COPYSTR("No.",15,4);
                          filesub:=COPYSTR("No.",5,5);
                          FileName :='Purchase Order'+filesub+'-'+filname+ '.pdf';
                          BullZipPDF.Init;
                          BullZipPDF.LoadSettings;
                          RunOnceFile := BullZipPDF.GetSettingsFileName(TRUE);
                          BullZipPDF.SetValue('Output',FileDirectory+FileName);
                          BullZipPDF.SetValue('Showsettings', 'never');
                          BullZipPDF.SetValue('ShowPDF', 'no');
                          BullZipPDF.SetValue('ShowProgress', 'no');
                          BullZipPDF.SetValue('ShowProgressFinished', 'no');
                          BullZipPDF.SetValue('SuppressErrors', 'yes');
                          BullZipPDF.SetValue('ConfirmOverwrite', 'no');
                          BullZipPDF.WriteSettings(TRUE);
                          PurchaseHeader.SETRANGE(PurchaseHeader."No.","No.");
                          REPORT.RUNMODAL(50058,FALSE,FALSE,PurchaseHeader);   */

                        TimeOut := 0;
                        WHILE EXISTS(RunOnceFile) AND (TimeOut < 10) DO BEGIN
                            SLEEP(2000);
                            TimeOut := TimeOut + 1;
                        END;
                        Window.CLOSE;
                        attachment := FileDirectory + FileName;

                        /* Mail.CreateMessage(USER."Full Name", USER.MailID, 'chowdary@efftronics.com', Subject, Body, TRUE);//Rev01
                                                                                                                          // Mail.CreateMessage(USER.Name,USER.MailID,'santhoshk@efftronics.com',Subject,Body,TRUE);
                        Mail.AddAttachment(attachment, ''); //EFFUPG
                        Mail.Send; */           //B2BUPG
                                                // Recipients.Add('chowdary@efftronics.com');
                        EmailMessage.Create(Recipients, Subject, Body, true);
                        EmailMessage.AddAttachment(attachment, '', '');
                        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                    END;

                end;
            }
            action("Send Request for Reopen")
            {
                Caption = 'Send Request for Reopen';
                Image = ReopenCancelled;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    TESTFIELD(Status, Status::Released);
                    //EFFUPG>>
                    if Reason = '' then
                        Error(ReasonErr);
                    //EFFUPG<<
                    USER.SETRANGE(USER."User ID", USERID);  //Rev01
                    IF USER.FIND('-') THEN BEGIN
                        Body := '';
                        Subject := '';
                        attachment := '';
                        FileDirectory := '';
                        FileName := '';
                        if user1.Get(USER."User ID") then
                            Subject := user1."Full Name" + ' Requesting to Reopen the Purchase Order ' + "No.";
                        //Rev01
                        Body += '<body><strong><form><table style="WIDTH:500px; HEIGHT: 20px; "';
                        Body += 'border="1" align="center">';
                        Reason_window.OPEN(T1);
                        //Reason_window.INPUT(1, Reason);//EFFUPG
                        Reason_window.CLOSE;
                        Body += '<tr><td><b>PURCHASE ORDER NO. :</b></td><td>' + "No.";

                        Body += '<tr><td><b>VENDOR :</b></td><td>' + "Buy-from Vendor Name";

                        Body += '<tr><td><b>REASON :</b></td><td>' + Reason;
                        Body += '<tr><td bgcolor=#99FF66 color=#FFFFFF  align="center" colspan="2"><a href=';
                        // Body+='"http://localhost:8080/Purchase/Default.aspx?';
                        Body += '"http://eff-cpu-178/pur%20Auth//Default.aspx?';
                        Body += 'val1=' + FORMAT(USERID);
                        Body += '&val2=' + FORMAT("No.");
                        Body += '&val3=0';
                        Body += '&val4=Chowdary@efftronics.com';
                        Body += '&val5=' + USER.MailID;
                        Body += '&val6=Open';
                        if user1.Get(USER."User ID") then
                            Body += '&val7=' + user1."Full Name";

                        Body += '&val8=' + "Buy-from Vendor Name";

                        Body += '&val9=' + FORMAT(Order_Value("No."));

                        Body += '" target="_blank"><b>Open</b></a></td>';
                        Body += '</table></form></font></strong></body>';

                        /*  IF ISCLEAR(BullZipPDF) THEN
                          CREATE(BullZipPDF);
                          FileDirectory := '\\eff-cpu-222\erp\';
                          Window.OPEN('processing  Order ######################1##');
                          Window.UPDATE(1,"No.");
                          filname:=COPYSTR("No.",15,4);
                          filesub:=COPYSTR("No.",5,5);
                          FileName :='Purchase Order'+filesub+'-'+filname+ '.pdf';
                          BullZipPDF.Init;
                          BullZipPDF.LoadSettings;
                          RunOnceFile := BullZipPDF.GetSettingsFileName(TRUE);
                          BullZipPDF.SetValue('Output',FileDirectory+FileName);
                          BullZipPDF.SetValue('Showsettings', 'never');
                          BullZipPDF.SetValue('ShowPDF', 'no');
                          BullZipPDF.SetValue('ShowProgress', 'no');
                          BullZipPDF.SetValue('ShowProgressFinished', 'no');
                          BullZipPDF.SetValue('SuppressErrors', 'yes');
                          BullZipPDF.SetValue('ConfirmOverwrite', 'no');
                          BullZipPDF.WriteSettings(TRUE);
                          PurchaseHeader.SETRANGE(PurchaseHeader."No.","No.");
                          REPORT.RUNMODAL(50058,FALSE,FALSE,PurchaseHeader);  */

                        TimeOut := 0;
                        WHILE EXISTS(RunOnceFile) AND (TimeOut < 10) DO BEGIN
                            SLEEP(2000);
                            TimeOut := TimeOut + 1;
                        END;
                        Window.CLOSE;
                        attachment := FileDirectory + FileName;
                        // Mail.CreateMessage(USER.Name,USER.MailID,'chowdary@efftronics.com',Subject,Body,TRUE);

                        /* Mail.CreateMessage(USER."Full Name", USER.MailID, 'ERP@efftronics.com', Subject, Body, TRUE); //Rev01
                        Mail.AddAttachment(attachment, ''); //EFFUPG
                        Mail.Send; */   //B2BUPG

                        Recipients.Add('ERP@efftronics.com');
                        EmailMessage.Create(Recipients, Subject, Body, true);
                        EmailMessage.AddAttachment(attachment, '', '');
                        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                    END;

                end;
            }
        }
        addafter("Create Inventor&y Put-away/Pick")
        {
            action("Update Customs Value in Flow")
            {
                Caption = 'Update Customs Value in Flow';
                Image = CalculatePlan;
                ToolTip = 'Update Customs Value in Flow';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    "G\L".GET;
                    IF "G\L"."Active ERP-CF Connection" THEN BEGIN
                        //  IF (Structure = 'FORIEGN') THEN BEGIN
                        // PurchLine.CALCFIELDS(PurchLine."Document Date"); commnted in Code Review
                        PurchLine.RESET;
                        PurchLine.SETRANGE(PurchLine."Document No.", "No.");
                        IF PurchLine.FINDSET THEN
                            REPEAT
                                PurchLine.CALCFIELDS(PurchLine."Document Date");//above commented  code moved here in code review
                                IF PurchLine."Customs Duty Value" > 0 THEN BEGIN
                                    PurchLine.TESTFIELD(PurchLine."Customs Duty Paid to");
                                    PurchLine.TESTFIELD(PurchLine."Customs To be Paid on");
                                    CashFlowConnection.ExecInOracle('insert into Purchase_line' +
                                                                  '(PURCHASE_ID,ORDERNO,ITEMNO,VENDORID,DEVIATED_DATE,ORDER_RELEASE_DATE,' +
                                                                  'ORDER_VALUE,ORDER_LINE_NO,PAYMENT_TERMS_CODE,ACTINACT)' +
                                                                 'values (seq_Purchase_ID.nextval,''' + PurchLine."Document No." + ''', ''' + PurchLine."No." + ''',''' +
                                                                   PurchLine."Customs Duty Paid to" + ''',''' +
                                                                   FORMAT(PurchLine."Customs To be Paid on", 0, '<Day>-<Month Text,3>-<Year4>') + ''',''' +
                                                                  FORMAT("Order Date", 0, '<Day>-<Month Text,3>-<Year4>') + ''',''' +
                                                                  CommaRemovalcust(FORMAT(ROUND(PurchLine."Customs Duty Value", 0.001))) + ''','''
                                                                  + FORMAT(PurchLine."Line No.") + ''',100,1)');
                                END;
                            UNTIL PurchLine.NEXT = 0;
                        //END;
                    END;
                end;
            }
            action("Print & Send Mail to supplier")
            {
                Caption = 'Print & Send Mail to supplier';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                var
                    Item: Record Item;
                    DescriptionString: Text[100];
                    InputFile: File;
                    AttachmentInStream: InStream;
                begin
                    // Added by Rakesh to send auto mail from Purchase Order on 23-Sep-14
                     IF (USERID IN ['EFFTRONICS\NSUDHEER','EFFTRONICS\CHOWDARY','ERPSERVER\ADMINISTRATOR','EFFTRONICS\BRAHMAIAH','EFFTRONICS\RENUKACH','EFFTRONICS\ANANDA','EFFTRONICS\PARDHU','EFFTRONICS\ANILKUMAR',
                                     'EFFTRONICS\GRAVI','EFFTRONICS\ANVESH','EFFTRONICS\SPURTHI','EFFTRONICS\RAVIKIRAN','EFFTRONICS\SUJANI','EFFTRONICS\TPRIYANKA','EFFTRONICS\DURGAMAHESWARI','EFFTRONICS\RATNA','EFFTRONICS\PKOTESWARARAO']) AND (Status=Status::Released) THEN
                                 BEGIN
                        no_atch_items := '';
                        PurchLine.RESET();
                        PurchLine.SETRANGE("Document No.", "No.");
                        IF PurchLine.FINDSET THEN
                            REPEAT
                            BEGIN
                                MECH_ITEM := '';
                                IF Item.GET(PurchLine."No.") THEN BEGIN
                                    IF (Item."Item Category Code" = 'MECH') AND (NOT (Item."Product Group Code Cust" IN ['SHEET', 'SCREW', 'NUT', 'WASHER', 'BOLT', 'SHT', 'GENERAL', 'SPACER', 'HING', 'CLAMP', 'STUD', 'LWASHER'])) THEN
                                        MECH_ITEM := 'MECH'
                                END;
                                //MECH_ITEM := COPYSTR(PurchLine."No.",1,4);
                                MECH_ITEM_NO := PurchLine."No.";
                                IF MECH_ITEM = 'MECH' THEN BEGIN
                                    Attachements_Table.RESET();
                                    Attachements_Table.SETRANGE("Document No.", MECH_ITEM_NO);
                                    Attachements_Table.SETRANGE("Attachment Status", TRUE);
                                    IF Attachements_Table.FINDSET THEN BEGIN
                                        no_atch_items := '';
                                        IF Attachements_Table."Attachment Status" = FALSE THEN
                                            no_atch_items := no_atch_items + Attachements_Table."Document No." + '-' + PurchLine.Description + '<br/>'
                                    END
                                    ELSE
                                        //no_atch_items:= no_atch_items + PurchLine."No." +'-'+Attachements_Table.Description+'<br/>';
                                        no_atch_items := no_atch_items + PurchLine."No." + '-' + PurchLine.Description + '<br/>';


                                END;
                            END;
                            UNTIL PurchLine.NEXT = 0;

                        VENDOR.RESET;
                        VENDOR.SETRANGE(VENDOR."No.", "Buy-from Vendor No.");
                        IF VENDOR.FINDFIRST THEN BEGIN
                            IF ((VENDOR."E-Mail" <> '') AND (VENDOR.Contact <> '')) THEN BEGIN
                                FileDirectory := '\\erpserver\ErpAttachments\Purchase Orders\';
                                filname := COPYSTR("No.", 15, 5);
                                filesub := COPYSTR("No.", 5, 5);
                                FileName := 'Purchase Order' + filesub + '-' + filname + '.pdf';
                                PurchaseHeader.RESET;
                                PurchaseHeader.SETRANGE(PurchaseHeader."No.", "No.");
                                REPORT.RUN(50058, FALSE, FALSE, PurchaseHeader);
                                REPORT.SAVEASPDF(50058, FileDirectory + FileName, PurchaseHeader);

                                USER.RESET;
                                USER.SETRANGE(USER."User ID", USERID);
                                IF USER.FINDFIRST THEN
                                    user1.Reset;
                                user1.Setrange("User Name", userid);
                                if user1.findfirst then
                                    username := user1."Full Name"
                                ELSE
                                    username := 'Brahmaiah V';

                                /* VENDOR.RESET;
                                VENDOR.SETRANGE(VENDOR."No.", "Buy-from Vendor No.");
                                IF VENDOR.FINDSET THEN
                                    Mail_To := VENDOR."E-Mail";
                                IF no_atch_items = '' THEN BEGIN
                                    IF Mail_count = 0 THEN
                                        Subject := ' Purchase Order: ' + "No."
                                    ELSE
                                        Subject := 'Amendment to Purchase Order: ' + "No.";
                                    attachment := FileDirectory + FileName;
                                    // SMTP_MAIL.CreateMessage('Efftronics Systems Pvt. Ltd - Purchase order','erp@efftronics.com','sujani@efftronics.com',Subject,Body,TRUE);
                                    SMTP_MAIL.CreateMessage('Efftronics Systems Pvt. Ltd - Purchase order', 'purchase@efftronics.com', Mail_To, Subject, Body, TRUE);
                                END
                                ELSE BEGIN
                                    Subject := ' Mechanical Items Requires the Attachements ' + 'Purchase Order: ' + "No.";
                                    attachment := FileDirectory + FileName;

                                    // SMTP_MAIL.CreateMessage('Efftronics Systems Pvt. Ltd - Purchase order','erp@efftronics.com','sujani@efftronics.com',Subject,Body,TRUE);
                                    SMTP_MAIL.CreateMessage('Efftronics Systems Pvt. Ltd - Purchase order', 'purchase@efftronics.com', 'mech@efftronics.com', Subject, Body, TRUE);
                                END;


                                PurchLine.RESET();
                                PurchLine.SETRANGE("Document No.", "No.");
                                IF PurchLine.FINDSET THEN
                                    REPEAT
                                    BEGIN
                                        MECH_ITEM := '';
                                        IF Item.GET(PurchLine."No.") THEN BEGIN
                                            IF (Item."Item Category Code" = 'MECH') AND (NOT (Item."Product Group Code" IN ['SHEET', 'SCREW', 'NUT', 'WASHER', 'BOLT', 'SHT', 'GENERAL', 'SPACER', 'HING', 'CLAMP', 'STUD'])) THEN
                                                MECH_ITEM := 'MECH'
                                        END;
                                        //MECH_ITEM := COPYSTR(PurchLine."No.",1,4);
                                        MECH_ITEM_NO := PurchLine."No.";
                                        IF MECH_ITEM = 'MECH' THEN BEGIN
                                            Attachements_Table.RESET();
                                            Attachements_Table.SETRANGE("Document No.", MECH_ITEM_NO);
                                            Attachements_Table.SETRANGE("Attachment Status", TRUE);
                                            IF Attachements_Table.FINDSET THEN BEGIN
                                                no_atch_items := '';
                                                IF Attachements_Table."Attachment Status" = FALSE THEN
                                                    no_atch_items := no_atch_items + Attachements_Table."Document No." + '-' + PurchLine.Description + '<br/>'
                                                ELSE BEGIN
                                                    Attachements_Table.ReadFilePath(FileName);
                                                    FileDirectory_mech := '\\erpserver\ErpAttachments\Mechanical_Items\';
                                                    DescriptionString := '';
                                                    DescriptionString := CONVERTSTR(Attachements_Table.Description, '/', ' ');
                                                    DescriptionString := CONVERTSTR(DescriptionString, '\', ' ');
                                                    mech_filename := FileDirectory_mech + MECH_ITEM_NO + '-' + DescriptionString + '.' + Attachements_Table."File Extension";
                                                    //mech_filename := FileDirectory_mech + MECH_ITEM_NO+'-'+DescriptionString+'.pdf';
                                                    //mech_filename := FileName ;
                                                    //Attachements_Table.ReadFilePath(mech_filename);
                                                    SMTP_MAIL.AddAttachment(mech_filename, '');
                                                END;
                                            END
                                            ELSE
                                                no_atch_items := no_atch_items + PurchLine."No." + '-' + PurchLine.Description + '<br/>';
                                        END;
                                    END;

                                    UNTIL PurchLine.NEXT = 0;

                                SMTP_MAIL.AddAttachment(attachment, ''); //EFFUPG
                                IF no_atch_items = '' THEN // having attachements
                                  BEGIN
                                    Body := 'Dear Sir/Madam,';//+VENDOR.Contact;
                                    Body += '<br><br><br>';
                                    Body += 'Please see the attachment for purchase order and arrange the material at the earliest.<br>';
                                    Body += 'Please send the order acknowledgment by return mail.<br><br><br>';
                                    Body += 'Regards,<br>';
                                    Body += '<b>' + username + '<br> Purchase Department<BR>' + 'Efftronics Systems Pvt. Ltd.,</b><BR>';
                                    Body += '40-15-9,Brundavan Colony,<br>Vijayawada - 520010,<br>Andhra Pradesh, India.<br>';
                                    Body += 'Ph No : 0866-2466679(Direct)/2466699/75<br>';
                                    Body += '<br><br><b>Note: This is System generated Automail.</b><br>';
                                    SMTP_MAIL.AppendBody(Body);
                                    // SMTP_MAIL.AddRecipients('sujani@efftronics.com');//MAIL TO VENDOR

                                    SMTP_MAIL.AddRecipients(Mail_To);//MAIL TO VENDOR
                                    SMTP_MAIL.AddBCC('purchase@efftronics.com,erp@efftronics.com');
                                    SMTP_MAIL.Send;
                                    PurchaseHeader.RESET;
                                    PurchaseHeader.SETRANGE(PurchaseHeader."No.", "No.");
                                    IF PurchaseHeader.FINDFIRST THEN
                                        PurchaseHeader.Mail_Sent := CURRENTDATETIME;
                                    PurchaseHeader.Mail_count += 1;
                                    PurchaseHeader.MODIFY;
                                    //MESSAGE('Mail Has Been Sent to '+Mail_To);
                                END ELSE
                                 // ERROR('Mechanical Items '+no_atch_items+' Does not have Attachement');
                                 BEGIN
                                    Body := 'Dear Sir/Madam,';//+VENDOR.Contact;
                                    Body += '<br/>';
                                    Body += 'PO' + PurchaseHeader."No." + ' having the Mech Items with out attachemnts so PO is not sent to Vendor<br>';
                                    Body += 'Add the Required attachments for the Following Items and after this acknowledge the Purchase Department to send the PO to Vendor <br>';
                                    Body += 'Items List<br><br/>';
                                    Body += no_atch_items + '<br/>';
                                    Body += 'Regards,<br>';
                                    Body += '<b>' + username + '<br> Purchase Department<BR>' + 'Efftronics Systems Pvt. Ltd.,</b><BR>';
                                    Body += '40-15-9,Brundavan Colony,<br>Vijayawada - 520010,<br>Andhra Pradesh, India.<br>';
                                    Body += 'Ph No : 0866-2466679(Direct)/2466699/75<br>';
                                    Body += '<br><br><b>Note: This is System generated Automail.</b><br>';
                                    SMTP_MAIL.AppendBody(Body);
                                    SMTP_MAIL.AddRecipients('mech@efftronics.com');
                                    //    SMTP_MAIL.AddRecipients('sujani@efftronics.com');
                                    SMTP_MAIL.AddBCC('purchase@efftronics.com,erp@efftronics.com');
                                    SMTP_MAIL.Send;

                                    // MESSAGE('Mail Has Been Sent to '+Mail_To);

                                END;*/  //B2BUPG

                                /* VENDOR.RESET;
                                 VENDOR.SETRANGE(VENDOR."No.", "Buy-from Vendor No.");
                                 IF VENDOR.FINDSET THEN
                                     Recipients.Add(VENDOR."E-Mail");*/
                                IF no_atch_items = '' THEN BEGIN
                                    IF Mail_count = 0 THEN
                                        Subject := ' Purchase Order: ' + "No."
                                    ELSE
                                        Subject := 'Amendment to Purchase Order: ' + "No.";
                                    attachment := FileDirectory + FileName;
                                    //Recipients.Add('purchase@efftronics.com');
                                    Recipients.Add('erp@efftronics.com');
                                    //EmailMessage.Create(Recipients, Subject, Body, true);
                                END
                                ELSE BEGIN
                                    Subject := ' Mechanical Items Requires the Attachements ' + 'Purchase Order: ' + "No.";
                                    attachment := FileDirectory + FileName;
                                    /*Recipients.Add('purchase@efftronics.com');
                                    Recipients.Add('mech@efftronics.com');*/
                                    Recipients.Add('erp@efftronics.com');
                                    //EmailMessage.Create(Recipients, Subject, Body, true);
                                END;


                                PurchLine.RESET();
                                PurchLine.SETRANGE("Document No.", "No.");
                                IF PurchLine.FINDSET THEN
                                    REPEAT
                                    BEGIN
                                        MECH_ITEM := '';
                                        IF Item.GET(PurchLine."No.") THEN BEGIN
                                            IF (Item."Item Category Code" = 'MECH') AND (NOT (Item."Product Group Code Cust" IN ['SHEET', 'SCREW', 'NUT', 'WASHER', 'BOLT', 'SHT', 'GENERAL', 'SPACER', 'HING', 'CLAMP', 'STUD'])) THEN
                                                MECH_ITEM := 'MECH'
                                        END;
                                        //MECH_ITEM := COPYSTR(PurchLine."No.",1,4);
                                        MECH_ITEM_NO := PurchLine."No.";
                                        IF MECH_ITEM = 'MECH' THEN BEGIN
                                            Attachements_Table.RESET();
                                            Attachements_Table.SETRANGE("Document No.", MECH_ITEM_NO);
                                            Attachements_Table.SETRANGE("Attachment Status", TRUE);
                                            IF Attachements_Table.FINDSET THEN BEGIN
                                                no_atch_items := '';
                                                IF Attachements_Table."Attachment Status" = FALSE THEN
                                                    no_atch_items := no_atch_items + Attachements_Table."Document No." + '-' + PurchLine.Description + '<br/>'
                                                ELSE BEGIN
                                                    Attachements_Table.ReadFilePath(FileName);
                                                    FileDirectory_mech := '\\erpserver\ErpAttachments\Mechanical_Items\';
                                                    DescriptionString := '';
                                                    DescriptionString := CONVERTSTR(Attachements_Table.Description, '/', ' ');
                                                    DescriptionString := CONVERTSTR(DescriptionString, '\', ' ');
                                                    mech_filename := FileDirectory_mech + MECH_ITEM_NO + '-' + DescriptionString + '.' + Attachements_Table."File Extension";
                                                    //EmailMessage.AddAttachment(mech_filename, '', '');
                                                END;
                                            END
                                            ELSE
                                                no_atch_items := no_atch_items + PurchLine."No." + '-' + PurchLine.Description + '<br/>';
                                        END;
                                    END;

                                    UNTIL PurchLine.NEXT = 0;

                                //EmailMessage.AddAttachment(attachment, '', '');
                                IF no_atch_items = '' THEN BEGIN
                                    Body := 'Dear Sir/Madam,';
                                    Body += '<br><br><br>';
                                    Body += 'Please see the attachment for purchase order and arrange the material at the earliest.<br>';
                                    Body += 'Please send the order acknowledgment by return mail.<br><br><br>';
                                    Body += 'Regards,<br>';
                                    Body += '<b>' + username + '<br> Purchase Department<BR>' + 'Efftronics Systems Pvt. Ltd.,</b><BR>';
                                    Body += '40-15-9,Brundavan Colony,<br>Vijayawada - 520010,<br>Andhra Pradesh, India.<br>';
                                    Body += 'Ph No : 0866-2466679(Direct)/2466699/75<br>';
                                    Body += '<br><br><b>Note: This is System generated Automail.</b><br>';
                                    Body += (Body);
                                    // Recipients.Add('purchase@efftronics.com');
                                    Recipients.Add('erp@efftronics.com');
                                    EmailMessage.Create(Recipients, Subject, Body, true);
                                    if attachment <> '' then begin
                                        InputFile.Open(Attachment);
                                        InputFile.CreateInStream(AttachmentInStream);
                                        EmailMessage.AddAttachment(attachment, 'PDF', AttachmentInStream);
                                    end;
                                    if mech_filename <> '' then begin
                                        InputFile.Open(mech_filename);
                                        InputFile.CreateInStream(AttachmentInStream);
                                        EmailMessage.AddAttachment(mech_filename, 'PDF', AttachmentInStream);
                                    end;
                                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

                                    PurchaseHeader.RESET;
                                    PurchaseHeader.SETRANGE(PurchaseHeader."No.", "No.");
                                    IF PurchaseHeader.FINDFIRST THEN
                                        PurchaseHeader.Mail_Sent := CURRENTDATETIME;
                                    PurchaseHeader.Mail_count += 1;
                                    PurchaseHeader.MODIFY;

                                END ELSE BEGIN
                                    Body := 'Dear Sir/Madam,';
                                    Body += '<br/>';
                                    Body += 'PO' + PurchaseHeader."No." + ' having the Mech Items with out attachemnts so PO is not sent to Vendor<br>';
                                    Body += 'Add the Required attachments for the Following Items and after this acknowledge the Purchase Department to send the PO to Vendor <br>';
                                    Body += 'Items List<br><br/>';
                                    Body += no_atch_items + '<br/>';
                                    Body += 'Regards,<br>';
                                    Body += '<b>' + username + '<br> Purchase Department<BR>' + 'Efftronics Systems Pvt. Ltd.,</b><BR>';
                                    Body += '40-15-9,Brundavan Colony,<br>Vijayawada - 520010,<br>Andhra Pradesh, India.<br>';
                                    Body += 'Ph No : 0866-2466679(Direct)/2466699/75<br>';
                                    Body += '<br><br><b>Note: This is System generated Automail.</b><br>';
                                    Body += (Body);
                                    /*Recipients.Add('mech@efftronics.com');
                                    Recipients.Add('purchase@efftronics.com');*/
                                    Recipients.Add('erp@efftronics.com');
                                    EmailMessage.Create(Recipients, Subject, Body, true);
                                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

                                END;


                                /* Body:='Dear Sir/Madam,';//+VENDOR.Contact;
                                 Body+='<br><br><br>';
                                 Body+='Please see the attachment for purchase order and arrange the material at the earliest.<br>';
                                 Body+='Please send the order acknowledgment by return mail.<br><br><br>';

                                 Body+='Regards,<br>';
                                 Body+='<b>'+username+'<br> Purchase Department<BR>'+'Efftronics Systems Pvt. Ltd.,</b><BR>';
                                 Body+='40-15-9,Brundavan Colony,<br>Vijayawada - 520010,<br>Andhra Pradesh, India.<br>';
                                 Body+='Ph No : 0866-2466679(Direct)/2466699/75<br>';
                                 Body+='<br><br><b>Note: This is System generated Automail.</b><br>';
                                 IF Mail_count = 0 THEN
                                   Subject:=' Purchase Order: '+"No."
                                 ELSE
                                   Subject:='Amendment to Purchase Order: '+"No.";
                                 attachment:=FileDirectory+FileName;
                                 SMTP_MAIL.CreateMessage('Efftronics Systems Pvt. Ltd - Purchase order','purchase@efftronics.com',Mail_To,Subject,Body,TRUE);
                                 SMTP_MAIL.AddBCC('purchase@efftronics.com,erp@efftronics.com');

                                 SMTP_MAIL.AddAttachment(attachment,''); //EFFUPG
                                 SMTP_MAIL.Send;
                                 MESSAGE('Mail Has Been Sent to '+Mail_To);
                                 PurchaseHeader.RESET;
                                 PurchaseHeader.SETRANGE(PurchaseHeader."No.","No.");
                                 IF PurchaseHeader.FINDFIRST THEN
                                   PurchaseHeader.Mail_Sent := CURRENTDATETIME;
                                 PurchaseHeader.Mail_count+=1;
                                 PurchaseHeader.MODIFY;*/

                            END ELSE
                                ERROR('Supplier E-mail id/Supplier Name is not there to send the Order Details');
                        END;
                    END ELSE
                        ERROR('You Have No Rights to Send the order Details/Order May not be in the Released Mode');
                    // end by Rakesh

                    // commented by rakesh after adding new code
                    /*
                    IF (((USERID='EFFTRONICS\CHOWDARY') OR (USERID='EFFTRONICS\BRAHMAIAH')OR (USERID='EFFTRONICS\ANILKUMAR'))AND(Status=Status::Released))THEN
                    BEGIN
                    VENDOR.RESET;
                    VENDOR.SETRANGE(VENDOR."No.","Buy-from Vendor No.");
                    IF VENDOR.FINDFIRST THEN
                    BEGIN
                    IF ((VENDOR."E-Mail"<>'') AND (VENDOR.Contact<>'')) THEN
                    BEGIN
                    user1.RESET;
                    IF "OrderCreated by"<>'' THEN
                    user1.SETRANGE(user1."User Name","OrderCreated by")//Rev01
                    ELSE
                    user1.SETRANGE(user1."User Name","OrderCreated by");//Rev01
                    IF user1.FINDFIRST THEN
                    username:=user1."Full Name";Rec.//Rev01
                    BEGIN
                         // IF ISCLEAR(BullZipPDF) THEN
                         //   CREATE(BullZipPDF);
                    
                          ReportID := REPORT::"PO-with Authorised Sign";
                       //   FileDirectory := '\\eff-cpu-211\srinivas\';
                          FileDirectory := '\\erpserver\ErpAttachments\Purchase Orders\';
                    
                          Window.OPEN('processing  Order ######################1##');
                    
                          Object.GET(Object.Type::Report,'',ReportID);
                            purch1.SETRANGE(purch1."No.","No.");
                            IF purch1.FINDSET THEN REPEAT
                            Window.UPDATE(1,purch1."No.");
                            filname:=COPYSTR(purch1."No.",15,4);
                            filesub:=COPYSTR(purch1."No.",5,5);
                            FileName :='Purchase Order'+filesub+'-'+filname+ '.pdf';
                            {BullZipPDF.Init;
                            BullZipPDF.LoadSettings;
                            RunOnceFile := BullZipPDF.GetSettingsFileName(TRUE);
                            BullZipPDF.SetValue('Output',FileDirectory+FileName);
                            BullZipPDF.SetValue('Showsettings', 'never');
                            BullZipPDF.SetValue('ShowPDF', 'no');
                            BullZipPDF.SetValue('ShowProgress', 'no');
                            BullZipPDF.SetValue('ShowProgressFinished', 'no');
                            BullZipPDF.SetValue('SuppressErrors', 'yes');
                            BullZipPDF.SetValue('ConfirmOverwrite', 'no');
                            BullZipPDF.WriteSettings(TRUE);
                            purch:=purch1;
                            purch.SETRECFILTER;
                            REPORT.RUNMODAL(ReportID,FALSE,FALSE,purch);
                            TimeOut := 0;
                            WHILE EXISTS(RunOnceFile) AND (TimeOut < 10) DO BEGIN
                                SLEEP(2000);
                                TimeOut := TimeOut + 1;
                            END;               }
                          UNTIL purch1.NEXT=0;
                    
                          Window.CLOSE;
                        END;
                    {"Mail-Id".SETRANGE("Mail-Id"."User ID",USERID);
                    IF "Mail-Id".FINDFIRST THEN
                    Mail_From:="Mail-Id".MailID
                    ELSE
                    ERROR('You Do not Have the Mail Id,please Contact Administrator to create your Mail id');}
                    
                    IF "OrderCreated by"<>'' THEN
                    "Mail-Id".SETRANGE("Mail-Id"."User Name","OrderCreated by")//Rev01
                    ELSE
                    "Mail-Id".SETRANGE("Mail-Id"."User Name",USERID); //Rev01
                    IF "Mail-Id".FINDFIRST THEN
                    Mail_To:="Mail-Id".MailID
                    ELSE
                    ERROR('You Do not Have the Mail Id,please Contact Administrator to create your Mail id');
                    
                    Body:='Dear '+VENDOR.Contact;
                    Body+='<br><Br> EMail-id: '+VENDOR."E-Mail";Rec.
                    Body+='<br><br><br>';
                    Body+='Please see the attachment for purchase order and arrange the material at the earliest.<br>';
                    Body+='Please send the order acknowledgment by return mail.<br><br><br>';
                    
                    Body+='Regards,<br>';
                    Body+=username+'<br>Efftronics Systems Pvt. Ltd.,<BR>';
                    Body+='Phone No.:+91-866-2493375<br>';
                    Body+='Mobile No.:+09392110072<br>';
                    Body+='C.S.T No.:VJ2-07-1-1976/02-05-1988<br>';
                    Body+='T.I.N. No.:28350166764 <br>';
                    Body+='E.C.C. NO.:AAACE4879QST001 <br>';
                    //MESSAGE(FORMAT(VENDOR."E-Mail"));
                         Mail_From:='erp@efftronics.com';
                    //    Mail_To:='sreenu@efftronics.com';
                    //     Mail_To:='sreenu@efftronics.com,anilkumar@efftronics.com,chowdary@efftronics.com';
                    //     Mail_To:=vendor."E-Mail";Rec.
                         Subject:=' Purchase Order: '+purch1."No."+' Order Created By: '+username;
                         attachment:=FileDirectory+FileName;
                         SMTP_MAIL.CreateMessage('Efftronics Systems Pvt. Ltd','purchase@efftronics.com','santhoshk@efftronics.com',Subject,Body,TRUE)
                    ;
                         SMTP_MAIL.AddAttachment(attachment);
                         SMTP_MAIL.Send;
                        // NewCDOMessage(Mail_From,Mail_To,Subject,Body,attachment);
                         MESSAGE('Mail Has Been Sent');
                    END ELSE
                    ERROR('Supplier E-mail id/Supplier Name is not there to send the Order Details');
                    END;
                    END ELSE
                    ERROR('You Have No Rights to Send the order Detials/Order May Not be in the Released Mode');
                    */

                end;
            }
            action("Copy Indent")
            {
                Caption = 'Copy Indent';
                Image = CopyItem;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    CopyIndent;
                end;
            }
            action("Resend Mail")
            {
                Caption = 'Resend Mail';
                Image = SendAsPDF;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    IF UPPERCASE(USERID) IN ['EFFTRONICS\PARDHU', 'EFFTRONICS\BRAHMAIAH', 'EFFTRONICS\CHOWDARY', 'EFFTRONICS\PADMASRI', 'EFFTRONICS\RENUKACH', 'SUPER', 'EFFTRONICS\SUJANI', 'EFFTRONICS\SPURTHI', 'EFFTRONICS\ANVESH'] THEN BEGIN
                        IF Status = Status::Released THEN
                            Mails
                        ELSE
                            ERROR('Release the Order');
                    END
                    ELSE
                        ERROR('You have no Rights to perform this operation');
                end;
            }
        }
        addafter("&Print")
        {
            action(Refresh)
            {
                Caption = 'Refresh';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                var
                    ReleasePurchDoc: Codeunit 415;
                begin

                    /* IF ISCLEAR(SQLConnection) THEN
                         CREATE(SQLConnection, FALSE, TRUE); //Rev01
                                                             //CREATE(SQLConnection);
                     IF ISCLEAR(RecordSet) THEN
                         CREATE(RecordSet, FALSE, TRUE);*/ //Rev01
                                                           //CREATE(RecordSet);

                    WebRecStatus := Quotes + Text50001 + Quotes;
                    OldWebStatus := Quotes + Text50002 + Quotes;
                    //SQLConnection.ConnectionString := 'DSN=PUR_AUT;UID=cashflowuser;PASSWORD=firewall123;SERVER=oracle_80;';
                    // SQLConnection.Open;
                    SQLQuery := 'select TO_CHAR(Status) STATUS from PURCHASE_ORDER where Purchase_order_No=''' + "No." + ''' and trans_no=';
                    SQLQuery += '(select Max(Trans_no) from Purchase_Order where purchase_order_no=''' + "No." + ''')';
                    /*
                   RecordSet := SQLConnection.Execute(SQLQuery);
                   IF NOT (RecordSet.EOF OR RecordSet.BOF) THEN BEGIN


                       IF FORMAT(RecordSet.Fields.Item('STATUS').Value) = '1' THEN
                           CODEUNIT.RUN(415, Rec)
                       ELSE
                           ReleasePurchDoc.Reopen(Rec);
                       SQLConnection.Close;
                   END ELSE BEGIN
                       SQLConnection.Close;
                       ERROR('THERE IS NO REQUEST (OR) NO APPROVAL FOR THIS PURCHASE ORDER');

                   END;
*/
                    // added by vishnu priya for 18-12-2018 for the Minimum Order value checking.
                end;
            }
            action(minimumordervaluecheck)
            {
                Caption = 'moa';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    VENDOR.RESET;
                    VENDOR.SETCURRENTKEY("No.");
                    VENDOR.SETFILTER("No.", Rec."Buy-from Vendor No.");
                    IF VENDOR.FINDFIRST THEN BEGIN
                        PL.RESET;
                        PL.SETFILTER("Document No.", Rec."No.");
                        ORDER_VAL := 0;
                        IF PL.FINDSET THEN
                            REPEAT
                            BEGIN
                                ORDER_VAL := ORDER_VAL + PL.Amount;
                            END
                            UNTIL PL.NEXT = 0;
                        IF VENDOR."Minimum Order Value" > ORDER_VAL THEN
                            ERROR('Purchase Order value %2 < Vendor Minimum Order Value is %1 So You can''' + 't Raise the PO', VENDOR."Minimum Order Value", ORDER_VAL);
                    END;

                    MESSAGE('Vendor Minimum Order Value= %1 , Purchase Order Value = %2', VENDOR."Minimum Order Value", ORDER_VAL);
                end;
            }
            action(IndentExistedOrnotcheck)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //ADDED BY VISHNU PRIYA ON 06-07-2019
                    PL.RESET;
                    PL.SETRANGE("Document No.", Rec."No.");
                    PL.SETRANGE(PL.Type, PL.Type::"G/L Account", PL.Type::Item);
                    IF PL.FINDSET THEN
                        REPEAT
                            IF PL."Indent No." = '' THEN
                                ERROR('There is No Indent to Line Number: ' + FORMAT(PL."Line No."));
                        UNTIL PL.NEXT = 0;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if (UserId = 'EFFTRONICS\DURGAMAHESWARI') then
            mail_send_editable := True
        else
            mail_send_editable := false;


        DocNoVisible := TRUE;   // Pranavi on 19-Apr-2017
        //IF (Structure = 'PURCH_GST') AND 
        if (USERID = 'EFFTRONICS\VIJAYA') THEN BEGIN
            IF "Buy-from Vendor No." <> '' THEN BEGIN

                IF (Status = Status::Open) THEN BEGIN
                    VENDOR.RESET;
                    VENDOR.SETFILTER(VENDOR."No.", "Buy-from Vendor No.");
                    IF VENDOR.FINDFIRST THEN
                        "GST Vendor Type" := VENDOR."GST Vendor Type";
                    MODIFY;
                    PL.RESET;
                    PL.SETFILTER(PL."Document No.", "No.");
                    IF PL.FINDSET THEN
                        REPEAT
                            IF (PL.Type = PL.Type::Item) AND (PL."No." <> '') THEN BEGIN
                                item.GET(PL."No.");
                                IF (PL."HSN/SAC Code" = '') THEN
                                    PL."HSN/SAC Code" := item."HSN/SAC Code";
                                IF (PL."GST Group Code" = '') THEN
                                    PL."GST Group Code" := item."GST Group Code";

                                //PL.VALIDATE(Quantity, PL.Quantity);
                            END;
                        UNTIL PL.NEXT = 0;
                END;
            END;
        END;

        /* PL.RESET;
        PL.SETFILTER(PL."Document No.", "No.");
        IF PL.FINDSET THEN
          REPEAT
          IF ( PL."No." <> '') THEN
        BEGIN
         IF Rec."Location Code" ='CONSTRUCTI' THEN
             BEGIN
               IF (PL."Location Code" ='') OR (PL."Location Code" <> Rec."Location Code") THEN
                  BEGIN
                     PL."Location Code" := Rec."Location Code";Rec.
                     MODIFY;
                   END;
            END;
        END;
        UNTIL PL.NEXT=0; */

        // added by vishnu priya on 06-07-2019 to update purchase order number and line number to indent lines

        /* indentline.RESET;
        indentline.SETCURRENTKEY("Document No.","Line No.");
        PL.RESET;
        PL.SETFILTER("Document No.","No.");
        PL.SETFILTER("Indent No.",'<>%1','');
        IF PL.FINDSET THEN
        REPEAT
          indentline.SETFILTER("Base Indent Number",PL."Indent No.");
          indentline.SETRANGE("Base Indent Line Number",PL."Indent Line No.");
          IF indentline.FINDFIRST THEN BEGIN
          indentline."Purchase Order Number" := PL."Document No.";
          indentline."Purchase Order Line Number" := PL."Line No.";
          indentline.MODIFY;
          END;
        UNTIL PL.NEXT = 0; */

        // end by vishnu priya on 06-07-2019 to update purchase order number and line number to indent lines
    end;

    trigger OnAfterGetRecord()
    begin
        /* IF Structure = 'FORIEGN' THEN BEGIN
             CurrPage.PurchLines.PAGE.Show_Custom_Charges(TRUE);*/
        //CurrPage.PurchLines.PAGE.UPDATE; //Rev01

        CurrPage.PurchLines.PAGE.Show_Custom_Charges(FALSE);
        //CurrPage.PurchLines.PAGE.UPDATE;//Rev01
    END;

    //UpdateInfoPanel; // Rev01 //EFFUPG Function doesn't exist in NAV 2016 Base


    trigger OnNewRecord(BelowxRec: Boolean)
    var
        ResultSteps: Integer;
    begin
        TESTFIELD(Status, Status::Open);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        /* IF NOT (USERID IN ['EFFTRONICS\PRANAVI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\ANVESH', 'EFFTRONICS\SPURTHI', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\VSUSMITHA']) THEN    //Added by Pranavi on 03-Dec-2015
            ERROR('You Do Not Have Rights to Delete!'); */
    end;



    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        MLTransactionType: Option Purchase,Sale;
        Text33000260: Label 'Do you want to Cancel Quality Inspection?';
        Text33000261: Label 'Do you want to Close Quality Inspection?';
        PurchaseHeader: Record "Purchase Header";
        "Excepted Rcpt.Date Tracking": Record "Excepted Rcpt.Date Tracking";
        VENDOR: Record Vendor;
        FileDirectory: Text[100];
        FileName: Text[100];
        ReportID: Integer;
        "Object": Record "Object";
        Window: Dialog;
        RunOnceFile: Text[1000];
        TimeOut: Integer;
        Customer: Record Customer;
        Customer2: Record Customer;
        purch: Record "Purchase Header";
        purch1: Record "Purchase Header";
        attachment: Text[1000];
        SMTPSETUP: Record "SMTP SETUP";
        AttachFileName: Text[1000];
        DocNoVisible: Boolean;
        /* objEmailConf: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000002-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Configuration";

        objEmail: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000001-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Message";

        flds: Automation "'{00000205-0000-0010-8000-00AA006D2EA4}' 2.5:'{00000564-0000-0010-8000-00AA006D2EA4}':''{00000205-0000-0010-8000-00AA006D2EA4}' 2.5'.Fields";

        fld: Automation "'{00000205-0000-0010-8000-00AA006D2EA4}' 2.5:'{00000569-0000-0010-8000-00AA006D2EA4}':''{00000205-0000-0010-8000-00AA006D2EA4}' 2.5'.Field";
 */
        bodies: Integer;
        Mail_Body: Text[1000];
        body1: Text[1000];
        filname: Text[100];
        filesub: Text[30];
        "Mail-Id": Record User;
        "from Mail": Text[500];
        "to mail": Text[1000];
        username: Text[50];
        user1: Record User;
        Body: Text[1024];
        Mail_From: Text[250];
        Mail_To: Text[250];
        //Mail: Codeunit "SMTP Mail";
        Subject: Text[250];
        j: Integer;
        Prev_Indent: Code[20];
        PL: Record "Purchase Line";
        INDENT_HEADER: Record "Indent Header";
        noofdays: Text[100];
        dateofit: Date;
        USER: Record "User Setup";
        CashFlowConnection: Codeunit "Cash Flow Connection";
        //StructureOrderLineDetails: Record "Structure Order Line Details";
        "Packing Value": Decimal;
        "Payment Terms": Record "Payment Terms";
        Frieght_Value: Decimal;
        Insurance_Value: Decimal;
        Additional_Duty: Decimal;
        Service_Amount: Decimal;
        //Structure_Order_Details: Record "Structure Order Details";
        Packing_Calculation: Boolean;
        Unit_Cost: Decimal;
        Line_Amount: Decimal;
        "G\L": Record "General Ledger Setup";

        //>> ORACLE UPG
        /*  SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";

         RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
  */
        //<< ORACLE UPG
        SQLQuery: Text[1000];
        //LRecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";

        LineSQLQuery: Text[250];
        HeadID: Text[30];
        UpdateWebHead: Text[250];
        WebRecStatus: Text[30];
        OldWebStatus: Text[30];
        Reason_window: Dialog;
        Reason: Text[100];
        T1: Label 'Please Enter the Reason to Reopen the Order #1######################';
        Quotes: Label '''';
        Text50001: Label 'NEW';
        Text50002: Label 'OLD';
        //SMTP_MAIL: Codeunit "SMTP Mail";
        VAT_AMOUNT: Decimal;
        CST_AMOUNT: Decimal;
        Dept: Code[10];
        fname: Text[30];
        flag: Boolean;
        str: Text[30];
        Text19023272: Label 'Buy-from Vendor';
        Text19005663: Label 'Pay-to Vendor';
        "--Rev01": Integer;
        [InDataSet]
        PurchHistoryBtnVisible: Boolean;
        [InDataSet]
        PurchHistoryBtn1Visible: Boolean;
        [InDataSet]
        PayToCommentBtnVisible: Boolean;
        [InDataSet]
        PayToCommentPictVisible: Boolean;
        PurchInfoPaneMgmt: Codeunit "Purchases Info-Pane Management";

        Text001: Label 'Cashflow connection does not exist. Do you want to Continue?';
        item: Record Item;
        Vndr: Record Vendor;
        GST_AMOUNT: Decimal;
        PurchLine: Record "Purchase Line";
        Text022: Label 'MECH_ITEM.';
        MECH_ITEM: Text[500];
        MECH_ITEM_NO: Text[500];
        Attachements_Table: Record Attachments;
        Mech_item_file_name: Text[500];
        mech_filename: Text[500];
        no_atch_items: Text;
        FileDirectory_mech: Text[100];
        moa: Page "Purchase Order Statistics";
        ORDER_VAL: Decimal;
        Pur_line: Record "Purchase Line";
        ten_percent_cost: Decimal;
        items_list_cost: array[100, 3] of Code[30];
        LoopVar: Integer;
        options_itm_cost: Text;
        itm_loop: Integer;
        indentline: Record "Indent Line";
        tds_amt: Decimal;
        PurchHead: Record "Purchase Header";
        ReasonErr: Label 'Fill the reason value in page control';

        mail_send_editable: Boolean;




    procedure CommaRemovalcust(Base: Text[30]) Converted: Text[30];
    var
        i: Integer;
    begin
        FOR i := 1 TO STRLEN(Base) DO BEGIN
            IF COPYSTR(Base, i, 1) <> ',' THEN
                Converted += COPYSTR(Base, i, 1);
        END;
        EXIT(Converted);
    end;

    procedure Order_Value("Order_No.": Code[20]) Value: Decimal;
    begin
        PL.SETRANGE(PL."Document No.", "Order_No.");
        IF PL.FINDSET THEN
            REPEAT
                IF PL."Currency Code" = '' THEN
                    Value += PL."Direct Unit Cost" * PL.Quantity
                ELSE
                    Value += PL."Unit Cost (LCY)" * PL.Quantity;
            /*
        StructureOrderLineDetails.RESET;
        StructureOrderLineDetails.SETRANGE(StructureOrderLineDetails.Type, StructureOrderLineDetails.Type::Purchase);
        StructureOrderLineDetails.SETRANGE(StructureOrderLineDetails."Document No.", PurchLine."Document No.");
        StructureOrderLineDetails.SETRANGE(StructureOrderLineDetails."Line No.", PurchLine."Line No.");
        StructureOrderLineDetails.SETRANGE(StructureOrderLineDetails.Type, StructureOrderLineDetails.Type::Purchase);
        IF StructureOrderLineDetails.FINDSET THEN
            REPEAT
                Value += StructureOrderLineDetails."Amount (LCY)";

            UNTIL StructureOrderLineDetails.NEXT = 0;
            */
            UNTIL PL.NEXT = 0;
    end;

    procedure Mails();
    var
        Lpurchase: Record "Purchase Header";

    begin



        /*Mail_From:='ERP@efftronics.com';
        
        Mail_To:='sujani@efftronics.com';
        SMTP_MAIL.CreateMessage('EFF',Mail_From,Mail_To,'PO ISSUE','PO ISSUE'+ "USER ID" + Rec."No.",TRUE);
        SMTP_MAIL.Send;*/
        /*
        
        IF UPPERCASE(USERID) IN ['EFFTRONICS\MNRAJU','EFFTRONICS\RAKESHT'] THEN
        Mail_To:='mnraju@efftronics.com,rakesht@efftronics.com'
        ELSE
        Mail_To:='purchase@efftronics.com,ramkumarl@efftronics.com,anilkumar@efftronics.com';
        
        //Mail_To:=VENDOR."E-Mail";Rec.
        fname:='';
        str:='';
        
        flag:=FALSE;
        
        IF (Mail_Sent=FALSE) THEN
        BEGIN
          IF (DIALOG.CONFIRM('Send Mail to: '+Mail_To)) THEN
            flag:=TRUE;
        END
        ELSE IF(Mail_Sent=TRUE) THEN
        BEGIN
          IF  (DIALOG.CONFIRM('Resend Mail to: '+Mail_To)) THEN
          BEGIN
            flag:=TRUE;
          END;
        END;
        
        
        IF flag=TRUE THEN
        BEGIN
          str:="No.";Rec.
          PurchaseHeader.SETFILTER(PurchaseHeader."No.","No.");
          WHILE STRPOS(str,'/') > 1 DO BEGIN
            fname:=fname+COPYSTR(str,1,STRPOS(str,'/')-1)+'_';
            str := COPYSTR(str,STRPOS(str,'/') + 1);
          END;
          fname:=fname+str;
        
          IF ISCLEAR(Bullzippdf) THEN
          CREATE(Bullzippdf,FALSE,TRUE); //Rev01
          //CREATE(Bullzippdf); //Rev01
        
          FileDirectory :='\\erpserver\ErpAttachments\PurchaseOrders\';
          Window.OPEN('PREPARING THE REPORT');
          FileName :=fname+'.pdf';
          Bullzippdf.Init;
          Bullzippdf.LoadSettings;
          RunOnceFile := Bullzippdf.GetSettingsFileName(TRUE);
          Bullzippdf.SetValue('Output',FileDirectory+FileName);
          Bullzippdf.SetValue('Showsettings', 'never');
          Bullzippdf.SetValue('ShowPDF', 'no');
          Bullzippdf.SetValue('ShowProgress', 'no');
          Bullzippdf.SetValue('ShowProgressFinished', 'no');
          Bullzippdf.SetValue('SuppressErrors', 'yes');
          Bullzippdf.SetValue('ConfirmOverwrite', 'no');
          Bullzippdf.WriteSettings(TRUE);
        
          REPORT.RUNMODAL(50058,FALSE,FALSE,PurchaseHeader);
          TimeOut := 0;
        
          WHILE EXISTS(RunOnceFile) AND (TimeOut < 10) DO
          BEGIN
            SLEEP(2000);
            TimeOut := TimeOut + 1;
          END;
          Window.CLOSE;
        
          attachment:=FileDirectory+FileName;
          Subject:='Reg : Purchase order - '+str;
          Body:='<HTML><BODY>Dear Sir,<BR>';
          Body+='<BR><PRE>  Please find the attachment for purchase order and arrange the material at the earliest</PRE>';
          Body+='<PRE><B>and send the order acknowledgment by return mail (without fail ).</B></PRE>';
          Body+='<PRE>             ****  Automatic Mail Generated From ERP  ****</PRE></BODY></HTML>';
        
          SMTP_MAIL.CreateMessage('EFF',Mail_From,Mail_To,Subject,Body,TRUE);
          SMTP_MAIL.AddAttachment(attachment);
          SMTP_MAIL.Send;
          //SLEEP(5000);
        
        
          IF PurchaseHeader.FINDFIRST THEN
          REPEAT
            PurchaseHeader.Mail_Sent:=TRUE;
            PurchaseHeader.MODIFY;
          UNTIL PurchaseHeader.NEXT=0;
        
          MESSAGE('Mail has been Sent');
        END;
        */

    end;


    procedure "...........Rev01............."();
    begin
    end;


    procedure Testing(Purchase_Order_No: Text);
    var
        "Count": Integer;
    begin
        Count := 0;
        SETFILTER("No.", Purchase_Order_No);
        IF FINDFIRST THEN
            REPEAT
                Count := Count + 1;
            UNTIL NEXT = 0;
        MESSAGE('No.of Orders Relesed is :: %1', Purchase_Order_No);
        RESET;
    end;


    procedure Testing1(PurchHdrGRec: Record "Purchase Header");
    begin
        MESSAGE('Testing Calc Structure!');
        "G\L".GET;
        IF "G\L"."Active ERP-CF Connection" THEN BEGIN
            PurchHdrGRec.TESTFIELD(Status, Status::Open);
            // PurchHdrGRec.TESTFIELD(Structure);//EFFUPG
            PurchHdrGRec.TESTFIELD("Order Date");
            //PurchHdrGRec."Calculate Tax Structure" := TRUE; //EFFUPG
            PurchHdrGRec.MODIFY;
        END;

        /*  PurchLine.CalculateStructures(PurchHdrGRec);
          PurchLine.AdjustStructureAmounts(PurchHdrGRec);
          PurchLine.UpdatePurchLines(PurchHdrGRec);*/  //EFFUPG
    end;


    procedure StructureDetails(PurchaseHeader: Record "Purchase Header"; Is_Release: Boolean);
    begin
        "G\L".GET;
        IF "G\L"."Active ERP-CF Connection" THEN BEGIN
            PurchaseHeader.TESTFIELD(Status, Status::Open);
            //  PurchaseHeader.TESTFIELD(Structure);//EFFUPG
            PurchaseHeader.TESTFIELD("Order Date");
            // PurchaseHeader."Calculate Tax Structure" := TRUE; //EFFUPG
            PurchaseHeader.MODIFY;
        END;

        //PurchLine.CalculateStructures(PurchaseHeader);//EFFUPG
        // PurchLine.AdjustStructureAmounts(PurchaseHeader);//EFFUPG
        // PurchLine.UpdatePurchLines(PurchaseHeader);//EFFUPG
        IF Is_Release = TRUE THEN
            Releasing(PurchaseHeader);
    end;


    procedure Releasing(PurchaseHeader: Record "Purchase Header");
    var
        ReleasePurchDoc: Codeunit 415;
        vendorRec: Record Vendor;
    begin
        /*
        // Added by Rakesh to restrict items with unit cost zero on 15-Oct-14
        PurchLine.RESET;
        PurchLine.SETRANGE(PurchLine."Document No.", PurchaseHeader."No.");
        PurchLine.SETRANGE(PurchLine.Type, PurchLine.Type::Item);
        IF PurchLine.FINDSET THEN
            REPEAT
                IF (PurchLine."Unit Cost (LCY)" = 0) AND (PurchLine.Sample = FALSE) THEN     //Added by Pranavi on 07-08-2015 for if item is sample then allow without unit cost
                    ERROR('Enter the unit cost for ' + PurchLine."No.");

                IF PurchLine."Gen. Prod. Posting Group" = '' THEN      //added by Pranavi on 07-07-2015 to restrict items without Gen.Prod.posting grp
                    ERROR('Please Enter General Prod. Posting Group for ' + PurchLine."No.");
                item.RESET;                                   //Added by Pranavi to restrict items with PO Blocked is true on 27-07-2015
                item.SETFILTER(item."No.", PurchLine."No.");
                IF item.FINDFIRST THEN BEGIN
                    IF item."PO Blocked" = TRUE THEN
                        ERROR('Purch Order Cannot be released beacause of Item: ' + item."No." + ' is blocked for PO!');
                END;                                      //End by Pranavi
            UNTIL PurchLine.NEXT = 0;

        // end by Rakesh

        vendorRec.RESET;
        vendorRec.SETFILTER(vendorRec."No.", PurchaseHeader."Buy-from Vendor No.");
        vendorRec.SETFILTER(vendorRec."Way bill Required", '%1', TRUE);
        IF vendorRec.FINDFIRST THEN BEGIN
            IF PurchaseHeader."Way bill" = '' THEN
                ERROR('Please enter way bill No.');
        END;



        "G\L".GET;
        IF "G\L"."Active ERP-CF Connection" THEN BEGIN
            PurchaseHeader.TESTFIELD(Status, Status::Open);
            PurchaseHeader.TESTFIELD(Structure);
            PurchaseHeader.TESTFIELD("Payment Terms Code");
            IF "Payment Terms".GET(PurchaseHeader."Payment Terms Code") THEN BEGIN
                IF NOT "Payment Terms"."Update In Cashflow" THEN
                    ERROR('PAYMENT TERMS CODE MUST BE UPDATED IN CASH FLOW');
            END;
            IF (NOT PurchaseHeader."Calculate Tax Structure") AND (PurchaseHeader.Structure <> '') THEN
                ERROR('PLEASE CALCULATE THE TAX STRUCTURE');
        END
        //Added by sundar for resolving records missing in Cashflow
        ELSE BEGIN
            IF UPPERCASE(USERID) IN ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\PRANAVI'] THEN BEGIN
                IF NOT CONFIRM(Text001, FALSE, PurchaseHeader."No.") THEN
                    EXIT;
            END
            ELSE
                ERROR('Cash Flow connection is not active Contact ERP Team');
        END;
        //Added by sundar for resolving records missing in Cashflow
        IF (PurchaseHeader."Order Date" = 0D) OR (PurchaseHeader."Order Date" > "G\L"."Allow Posting To") THEN
            MESSAGE('PLEASE ENTER THE ORDER DATE ');

        IF (PurchaseHeader.Structure = '') AND (NOT PurchaseHeader."Inclusive of All Taxes") AND (PurchaseHeader."Order Date" > DMY2Date(12, 17, 09)) THEN //Rev01
            ERROR('PLEASE ENTER THE TAX STRUCTRE & CALCULATE THE TAX STRUCTURE');

        IF NOT ((PurchaseHeader."Location Code" = 'R&D STR') OR (PurchaseHeader."Location Code" = 'CS STR') OR (PurchaseHeader."Location Code" = 'STR') OR (PurchaseHeader."Location Code" = 'SITE')) THEN
            ERROR('Location Code Must be In R&D STR,CS STR,STR,SITE');//sundar

        IF PurchaseHeader."Location Code" = 'R&D STR' THEN BEGIN
            IF (COPYSTR(PurchaseHeader."Shortcut Dimension 1 Code", 1, 2) <> 'RD') THEN
                ERROR('Please Pick R&D Dimension Code')
        END;
        IF PurchaseHeader."Location Code" = 'CS STR' THEN BEGIN
            IF (COPYSTR(PurchaseHeader."Shortcut Dimension 1 Code", 1, 3) <> 'CUS') THEN
                ERROR('Please Pick CS Dimension Code')
        END;
        IF PurchaseHeader."Location Code" = 'STR' THEN BEGIN
            IF (COPYSTR(PurchaseHeader."Shortcut Dimension 1 Code", 1, 3) <> 'PRD') THEN
                ERROR('Please Pick PRD Dimension Code')
        END;
        PurchLine.SETRANGE(PurchLine."Document No.", PurchaseHeader."No.");
        PurchLine.SETFILTER(PurchLine.Quantity, '>%1', 0);
        IF PurchLine.FINDSET THEN
            REPEAT
                IF PurchLine."Buy-from Vendor No." <> PurchaseHeader."Buy-from Vendor No." THEN
                    ERROR('VENDOR MUST BE SAME IN PURCHASE LINES & HEADER');
                IF (PurchLine.Type = PurchLine.Type::Item) OR (PurchLine.Type = PurchLine.Type::"G/L Account") THEN BEGIN
                    IF (PurchLine.Type = PurchLine.Type::Item) AND (PurchLine.Make = '') THEN
                        ERROR('Enter Make for Item ' + PurchLine.Description);
                    IF ((PurchaseHeader."Sale Order No" = '') AND (PurchLine.Type = PurchLine.Type::Item)) AND (PurchaseHeader."Order Date" > DMY2Date(06, 01, 09)) THEN;
                    // PurchLine.TESTFIELD(PurchLine."Expected Receipt Date");

                    IF PurchLine."Gen. Prod. Posting Group" = '' THEN
                        ERROR(' THERE IS NO "Gen. Prod. Posting Group" FOR ' + PurchLine.Description);
                    IF (PurchLine."Location Code" = 'SITE') AND (PurchaseHeader."Order Date" > DMY2Date(08, 11, 09)) THEN BEGIN
                        IF PurchLine."Shortcut Dimension 2 Code" = '' THEN
                            ERROR('Please Enter the Site Information');
                        // IF (PurchaseHeader."Sale Order No"='') THEN
                        //  ERROR('Please Enter the Sale Order Information');
                        // END
                        // ELSE  IF (PurchLine."Location Code"='SITE') AND (PurchaseHeader."Order Date"<110809D)   THEN
                        //BEGIN 
                        //IF (PurchaseHeader."Sale Order No"='') THEN
                        //ERROR('Please Enter the Sale Order Information');//anil comented for closed sale orders details
                    END;


                    IF (PurchLine."Direct Unit Cost" = 0) AND NOT (PurchLine.Sample) THEN
                        ERROR('THERE IS NO COST FOR THE ITEM  ' + PurchLine.Description);
                    "Excepted Rcpt.Date Tracking".RESET;
                    "Excepted Rcpt.Date Tracking".SETRANGE("Excepted Rcpt.Date Tracking"."Document No.", PurchLine."Document No.");
                    "Excepted Rcpt.Date Tracking".SETRANGE("Excepted Rcpt.Date Tracking"."Document Line No.", PurchLine."Line No.");
                    /// IF NOT ("Excepted Rcpt.Date Tracking".FINDFIRST) THEN
                    //  BEGIN
                    //  IF(PurchLine."Expected Receipt Date"<>PurchLine."Deviated Receipt Date")  AND ("Order Date">010609D) THEN
                    //  ERROR('Expected Receipt Date is not equal to Deviated Receipt Date for '+PurchLine."No.");
                    //MESSAGE('');
                    //END;   
                    IF (PurchLine.Type <> PurchLine.Type::"G/L Account") THEN
                        PurchLine.TESTFIELD(PurchLine."QC Enabled");
                    IF PurchaseHeader."Location Code" <> PurchLine."Location Code" THEN
                        ERROR('location code not matching in both line and header');
                END;
            UNTIL PurchLine.NEXT = 0;
        //comment by anil
        // MAIL CODE FOR ORDERING THE R&D INDENTS

        IF (USERID <> 'EFFTRONICS\CHOWDARY') AND (USERID <> 'EFFTRONICS\BRAHMAIAH') AND (USERID <> 'EFFTRONICS\ANILKUMAR') AND (USERID <> 'SUPER') AND (USERID <> 'EFFTRONICS\PRANAVI') THEN
            ERROR('You have No Rights')
        ELSE BEGIN

            IF (PurchaseHeader."Location Code" = 'R&D STR') AND (PurchaseHeader.Status = Status::Open) THEN BEGIN
                j := 0;
                Prev_Indent := '';
                PurchLine.RESET;
                PurchLine.SETRANGE(PurchLine."Document No.", PurchaseHeader."No.");
                PurchLine.SETCURRENTKEY(PurchLine."Indent No.");
                PurchLine.SETRANGE(PurchLine."Location Code", 'R&D STR');
                IF PurchLine.FINDSET THEN
                    REPEAT

                        IF PurchLine."Indent No." <> '' THEN BEGIN
                            IF (Prev_Indent = '') OR (Prev_Indent <> PurchLine."Indent No.") THEN BEGIN
                                IF j <= 0 THEN
                                    j := 1
                                ELSE
                                    j := j;
                                Body := '';
                                Mail_From := '';
                                Mail_To := '';
                                Subject := '';
                                attachment := '';
                                Prev_Indent := PurchLine."Indent No.";
                                Rec.
PL.RESET;
                                PL.SETRANGE(PL."Document No.", PurchLine."Document No.");
                                PL.SETRANGE(PL."Indent No.", Prev_Indent);
                                IF PL.FINDFIRST THEN BEGIN
                                    REPORT.RUN(50157, FALSE, FALSE, PL);
                                    attachment := '\\erpserver\ErpAttachments\ErpAttachments1\p_int_details' + FORMAT(j) + '.html';
                                    REPORT.SAVEASHTML(50157, attachment, FALSE, PL);
                                END;
                                INDENT_HEADER.RESET;
                                INDENT_HEADER.SETRANGE(INDENT_HEADER."No.", Prev_Indent);
                                INDENT_HEADER.SETRANGE(INDENT_HEADER."Delivery Location", 'R&D STR');
                                IF INDENT_HEADER.FINDFIRST THEN BEGIN
                                    dateofit := DT2DATE(INDENT_HEADER."Release Date Time");
                                    noofdays := FORMAT(TODAY - dateofit);
                                    USER.RESET;
                                    USER.SETRANGE(USER."User ID", USERID);
                                    IF USER.FINDFIRST THEN
                                        Mail_From := USER.MailID;
                                    USER.RESET;
                                    USER.SETRANGE(USER."User ID", INDENT_HEADER."Person Code");
                                    IF USER.FINDFIRST THEN
                                        Mail_To := USER.MailID;
                                    Subject := 'YOUR INDENT (' + Prev_Indent + ' ) FOR "' + INDENT_HEADER."Production Order Description" + '" HAS BEEN ORDERED ';
                                    //         Body+=FORMAT(NEW_LINE);
                                    Body += '****testing  Auto Mail Generated From ERP  ****';
                                    //         Mail_From:='sreenu@efftronics.com';
                                    //         Mail_To:='sreenu@efftronics.com';
                                    IF ((Mail_From <> '') AND (Mail_To <> '')) THEN BEGIN
                                        SMTP_MAIL.CreateMessage('PURCHASE ORDER', Mail_From, Mail_To, Subject, Body, FALSE);
                                        SMTP_MAIL.AddAttachment(attachment);
                                    END;
                                    //            SLEEP(2000);
                                    j := j + 1;
                                END;
                            END;
                        END;
                    UNTIL PurchLine.NEXT = 0;
            END;
        END;

        IF NOT (UPPERCASE(USERID) IN ['EFFTRONICS\CHOWDARY', 'EFFTRONICS\BRAHMAIAH', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\RENUKACH', 'EFFTRONICS\SPURTHI', 'EFFTRONICS\ANVESH']) THEN
            ERROR('You have No Rights to release. Contact Purchase Dept Manager')
        ELSE
            ReleasePurchDoc.PerformManualRelease(PurchaseHeader);

        "Packing Value" := 0;
        //PurchLine.CALCFIELDS(PurchLine."Document Date");
        PurchLine.RESET;
        PurchLine.SETRANGE(PurchLine."Document No.", PurchaseHeader."No.");
        PurchLine.SETFILTER(PurchLine."No.", '<>%1', '');
        IF PurchLine.FINDSET THEN
            REPEAT
                PurchLine.CALCFIELDS(PurchLine."Document Date");

                "G\L".GET;
                IF "G\L"."Active ERP-CF Connection" AND (PurchaseHeader."Order Date" >= DMY2Date(02, 01, 10)) THEN //
                BEGIN

                    "Packing Value" := 0;
                    Frieght_Value := 0;
                    Insurance_Value := 0;
                    Additional_Duty := 0;
                    Service_Amount := 0;
                    Line_Amount := 0;
                    Unit_Cost := 0;

                    StructureOrderLineDetails.RESET;
                    StructureOrderLineDetails.SETRANGE(StructureOrderLineDetails.Type, StructureOrderLineDetails.Type::Purchase);
                    StructureOrderLineDetails.SETRANGE(StructureOrderLineDetails."Document No.", PurchLine."Document No.");
                    StructureOrderLineDetails.SETRANGE(StructureOrderLineDetails."Line No.", PurchLine."Line No.");
                    StructureOrderLineDetails.SETRANGE(StructureOrderLineDetails.Type, StructureOrderLineDetails.Type::Purchase);
                    IF StructureOrderLineDetails.FINDSET THEN
                        REPEAT
                            IF ((StructureOrderLineDetails."Tax/Charge Group" = 'PACKING') OR
                               (StructureOrderLineDetails."Tax/Charge Group" = 'FORWARDING')) THEN BEGIN

                                "Packing Value" += StructureOrderLineDetails."Amount (LCY)";

                            END ELSE
                                IF StructureOrderLineDetails."Tax/Charge Group" = 'FREIGHT' THEN BEGIN
                                    Frieght_Value += StructureOrderLineDetails."Amount (LCY)";

                                END ELSE
                                    IF StructureOrderLineDetails."Tax/Charge Group" = 'CUSTOMS DU' THEN BEGIN
                                        Frieght_Value += StructureOrderLineDetails."Amount (LCY)";

                                    END ELSE

                                        IF StructureOrderLineDetails."Tax/Charge Group" = 'INSURANCE' THEN BEGIN
                                            Insurance_Value += StructureOrderLineDetails."Amount (LCY)";

                                        END ELSE
                                            IF StructureOrderLineDetails."Tax/Charge Group" = 'ADD.DUTY' THEN
                                                Additional_Duty += StructureOrderLineDetails."Amount (LCY)"
                                            ELSE
                                                IF StructureOrderLineDetails."Tax/Charge Type" = StructureOrderLineDetails."Tax/Charge Type"::"Service Tax" THEN
                                                    Service_Amount += StructureOrderLineDetails."Amount (LCY)";


                        UNTIL StructureOrderLineDetails.NEXT = 0;

                    // END;
                    IF PurchLine."Currency Code" = '' THEN BEGIN
                        Unit_Cost := PurchLine."Direct Unit Cost";

                        Line_Amount := PurchLine."Line Amount";

                    END ELSE BEGIN
                        Unit_Cost := PurchLine."Direct Unit Cost" / PurchaseHeader."Currency Factor";

                        Line_Amount := (PurchLine.Quantity * PurchLine."Direct Unit Cost") / PurchaseHeader."Currency Factor";


                    END;
                    IF PurchLine."Line Discount Amount" > 0 THEN
                        Additional_Duty -= PurchLine."Line Discount Amount";

                    IF (PurchLine."Frieght Charges" > 0) THEN BEGIN
                        IF PurchLine."Currency Code" = '' THEN
                            Frieght_Value := PurchLine."Frieght Charges"
                        ELSE
                            Frieght_Value := PurchLine."Frieght Charges" / PurchaseHeader."Currency Factor";

                    END;
                    IF (PurchLine."Tax Area Code" = 'PURH VAT') THEN
                        VAT_AMOUNT := PurchLine."Tax Amount"
                    ELSE
                        CST_AMOUNT := PurchLine."Tax Amount";

                    IF PurchLine."Location Code" = 'CS STR' THEN
                        Dept := 'CS'
                    ELSE
                        Dept := 'NORMAL';

                    IF (PurchLine.Sample = FALSE) AND (UPPERCASE(USERID) <> 'EFFTRONICS\RAJANI') THEN
                        CashFlowConnection.ExecInOracle('insert into Purchase_line' +
                                                        '(PURCHASE_ID,ORDERNO,ITEMNO,VENDORID,UNIT_COST,UNITS_REQ,DEVIATED_DATE,ORDER_RELEASE_DATE,' +
                                                        ' VAT,EXCISE,CST,PAYMENT_TERMS_CODE,ORDER_VALUE,PACKING_COST,ORDER_LINE_NO,SERVICE_AMOUNT,' +
                                                        'INSURANCE_VALUE,FRIEGHT_CHARGES,ADD_DUTY,LOCATION_CODE,DEPT_WISE,ACTINACT)' +
                                                        'values (seq_Purchase_ID.nextval,''' + PurchLine."Document No." + ''', ''' + PurchLine."No." + ''',''' +
                                                        PurchaseHeader."Buy-from Vendor No." + ''',''' +
                                                        CommaRemoval(FORMAT(ROUND(Unit_Cost, 0.001))) + ''',''' +
                                                        CommaRemoval(FORMAT(PurchLine.Quantity)) + ''',''' +
                                                        FORMAT(PurchLine."Deviated Receipt Date", 0, '<Day>-<Month Text,3>-<Year4>') + ''',''' +
                                                        FORMAT(DT2DATE(PurchaseHeader."Release Date Time"), 0, '<Day>-<Month Text,3>-<Year4>') + ''',''' +
                                                        CommaRemoval(FORMAT(ROUND(VAT_AMOUNT, 0.01))) + ''',''' +
                                                        CommaRemoval(FORMAT(ROUND(PurchLine."Excise Amount", 0.01))) + ''',''' +
                                                        CommaRemoval(FORMAT(ROUND(CST_AMOUNT, 0.01))) + ''',''' +
                                                        FORMAT(PurchaseHeader."Payment Terms Code") + ''',''' +
                                                        CommaRemoval(FORMAT(ROUND(Line_Amount, 0.001))) + ''',''' +
                                                        CommaRemoval(FORMAT(ROUND("Packing Value", 0.001))) + ''',''' +
                                                        FORMAT(PurchLine."Line No.") + ''',''' +
                                                        CommaRemoval(FORMAT(ROUND(Service_Amount, 0.01))) + ''',''' +
                                                        CommaRemoval(FORMAT(ROUND(Insurance_Value, 0.01))) + ''',''' +
                                                        CommaRemoval(FORMAT(ROUND(Frieght_Value, 0.01))) + ''',''' +
                                                        CommaRemoval(FORMAT(ROUND(Additional_Duty, 0.01))) + ''',''' +
                                                        PurchLine."Location Code" + ''',''' +
                                                        Dept + ''',1)');
                    //  MESSAGE(FORMAT(ROUND(Line_Amount,0.001)));
                END;
            UNTIL PurchLine.NEXT = 0;


        Mail_From := 'ERP@efftronics.com';

        Mail_To := 'erp@efftronics.com';
        SMTP_MAIL.CreateMessage('EFF', Mail_From, Mail_To, 'PO ISSUE', 'PO ISSUE' + "USER ID" + Rec."No.", TRUE);
        SMTP_MAIL.Send;

        Mails;                  //B2BUPG

        Recipients.Add('erp@efftronics.com');
        EmailMessage.Create(Recipients, 'PO ISSUE', 'PO ISSUE' + "USER ID" + Rec."No.", true);
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        */

    end;



    local procedure UpdateInfoPanel();
    var
        DifferBuyFromPayTo: Boolean;
    begin
        //EFFUPG DocExist function doesn't exist as globally in NAV 2016 Base
        /*
        DifferBuyFromPayTo := "Buy-from Vendor No." <> "Pay-to Vendor No.";Rec.
        PurchHistoryBtnVisible := DifferBuyFromPayTo;
        PurchHistoryBtn1Visible := PurchInfoPaneMgmt.DocExist(Rec,"Buy-from Vendor No.");
        IF DifferBuyFromPayTo THEN
          PurchHistoryBtnVisible := PurchInfoPaneMgmt.DocExist(Rec,"Pay-to Vendor No.")
        */
        //EFFUPG

    end;

    local procedure checkminimumordervalue();
    begin
        //added by Vishnu Priya for Vendor minimum order value checking on 18-12-2018

        VENDOR.RESET;
        VENDOR.SETCURRENTKEY("No.");
        VENDOR.SETFILTER("No.", Rec."Buy-from Vendor No.");
        IF VENDOR.FINDFIRST THEN BEGIN
            PL.RESET;
            PL.SETFILTER("Document No.", Rec."No.");
            ORDER_VAL := 0;
            IF PL.FINDSET THEN
                REPEAT
                BEGIN
                    ORDER_VAL := ORDER_VAL + PL.Amount;
                END
                UNTIL PL.NEXT = 0;
            IF VENDOR."Minimum Order Value" > ORDER_VAL THEN
                ERROR('Purchase Order value %2 < Vendor Minimum Order Value is %1 So You can''' + 't Raise the PO', VENDOR."Minimum Order Value", ORDER_VAL);
        END;
    end;


    procedure ten_percent_item_Cost_high_chk() CNTNUE: Boolean;
    begin
        LoopVar := 1;
        itm_loop := 1;
        PL.RESET;
        PL.SETRANGE("Document No.", Rec."No.");
        PL.SETFILTER("Outstanding Quantity", '>%1', 0);
        PL.SETRANGE(Type, PL.Type::Item);
        IF PL.FINDSET THEN
            REPEAT
            BEGIN
                Pur_line.RESET;
                Pur_line.SETFILTER("Document No.", '<%1', PL."Document No.");
                Pur_line.SETRANGE("No.", PL."No.");
                Pur_line.SETRANGE(Type, PL.Type::Item);
                Pur_line.SETFILTER("Outstanding Quantity", '>%1', 0);
                IF Pur_line.FINDLAST THEN
                    REPEAT
                    BEGIN
                        ten_percent_cost := (Pur_line."Direct Unit Cost" * 0.1);
                        ten_percent_cost := ten_percent_cost + Pur_line."Direct Unit Cost";

                        IF PL."Direct Unit Cost" > ten_percent_cost THEN BEGIN
                            items_list_cost[LoopVar] [1] := Pur_line."Document No.";

                            items_list_cost[LoopVar] [2] := FORMAT(Pur_line."No.");
                            items_list_cost[LoopVar] [3] := FORMAT(Pur_line."Direct Unit Cost");
                            LoopVar := LoopVar + 1;
                        END

                        ELSE
                            EXIT(TRUE);
                    END;

                    UNTIL Pur_line.NEXT = 0
                ELSE
                    EXIT(TRUE);


            END;
            UNTIL PL.NEXT = 0
        ELSE
            EXIT(TRUE);
        options_itm_cost := '';
        IF (ARRAYLEN(items_list_cost) > 2) THEN BEGIN
            FOR itm_loop := 1 TO LoopVar - 1 DO BEGIN
                options_itm_cost := options_itm_cost + items_list_cost[itm_loop] [2] + ':' + items_list_cost[itm_loop] [1] + ',';
            END;
        END;
        IF (ARRAYLEN(items_list_cost) > 2) THEN BEGIN

            IF ((DIALOG.STRMENU(options_itm_cost, LoopVar + 5, 'This order having 10% more unit cost than the below orders, Click OK Continue')) = 1) THEN
                EXIT(TRUE)
            ELSE
                EXIT(FALSE);
        END;
        EXIT(TRUE);
    end;


    local procedure IndentExistedOrnot();
    begin
        //ADDED BY VISHNU PRIYA ON 06-07-2019
        IF //((Rec."First Release By" = '') AND   // commented by vishnu on 04-01-2020
          NOT (USERID IN ['EFFTRONICS\SUJANI']) THEN  //,'EFFTRONICS\VISHNUPRIYA'
        BEGIN
            PL.RESET;
            PL.SETRANGE("Document No.", Rec."No.");
            PL.SETFILTER(PL.Type, '<>%1', PL.Type::" ");  //,PL.Type::"Fixed Asset"
            IF PL.FINDSET THEN
                REPEAT
                    IF (PL."Indent No." = '') AND (PL.Type = PL.Type::Item) AND (Rec."Order Date" < DMY2Date(11, 12, 20)) THEN
                        ERROR('There is No Indent to Line Number: ' + FORMAT(PL."Line No."))
                    ELSE
                        IF (PL."Indent No." = '') AND (Rec."Order Date" >= DMY2Date(11, 12, 20)) THEN
                            ERROR('There is No Indent to Line Number: ' + FORMAT(PL."Line No."));
                UNTIL PL.NEXT = 0;
        END;
    end;


    local procedure UpdationtoIndentLines();
    begin
        //ADDED BY VISHNU PRIYA ON 06-07-2019
        indentline.RESET;
        indentline.SETCURRENTKEY("Document No.", "Line No.");
        PL.RESET;
        PL.SETFILTER("Document No.", Rec."No.");
        PL.SETFILTER("Indent No.", '<>%1', '');
        IF PL.FINDSET THEN
            REPEAT
                indentline.SETFILTER("Base Indent Number", PL."Indent No.");
                indentline.SETRANGE("Base Indent Line Number", PL."Indent Line No.");
                IF indentline.FINDFIRST THEN BEGIN
                    indentline."Purchase Order Number" := PL."Document No.";

                    indentline."Purchase Order Line Number" := PL."Line No.";

                    indentline.MODIFY;
                END;
            UNTIL PL.NEXT = 0;
    end;


    procedure Vendor_approved_or_Not();
    begin
        PurchHead.RESET;
        PurchHead.SETFILTER("Buy-from Vendor No.", Rec."Buy-from Vendor No.");
        PurchHead.SETRANGE("Document Type", PurchHead."Document Type"::Order);
        IF NOT PurchHead.FINDFIRST THEN BEGIN
            IF Vndr.GET("Buy-from Vendor No.") THEN BEGIN
                IF Vndr."Maanager Approved" = FALSE THEN
                    ERROR('Ensure the vendor to be Approved by the Manager.');
            END;
        END;
    end;


    procedure Location_Mismatch_Not();
    begin
        // Added by Vishnu Priya on 03-12-2020
        PurchLine.RESET;
        PurchLine.SETFILTER("Document No.", Rec."No.");
        PurchLine.SETFILTER(Quantity, '>%1', 0);
        IF PurchLine.FINDSET THEN
            REPEAT
                IF Rec."Location Code" <> PurchLine."Location Code" THEN
                    ERROR('Select the same Location code in both Header and Line. In Line Number %1 is  different with Header Location', FORMAT(PurchLine."Line No."));
            UNTIL PurchLine.NEXT = 0;
        // Added by Vishnu Priya on 03-12-2020
    end;
}

