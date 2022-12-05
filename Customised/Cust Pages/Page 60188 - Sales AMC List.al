page 60188 "Sales AMC List"
{
    // version Rev01

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

    Caption = 'Sales AMC';
    CardPageID = "Sales AMC1";
    Editable = false;
    PageType = List;
    SourceTable = "Sales Header";
    SourceTableView = SORTING("Document Type", "No.") ORDER(Ascending) WHERE(SaleDocType = CONST(Amc));//EFFUPG1.5
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        CUS.SETRANGE(CUS."No.", Rec."Sell-to Customer No.");
                        IF CUS.FINDFIRST THEN
                            Rec.Territory := CUS."Territory Code";
                        SelltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    Caption = 'Sell-to Post Code/City';
                    ApplicationArea = All;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                /*field(Control1280009; Structure)
                {
                    ApplicationArea = All;
                }*/
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Installation Amount"; Rec."Installation Amount")
                {
                    ApplicationArea = All;
                }
                field("Bought out Items Amount"; Rec."Bought out Items Amount")
                {
                    ApplicationArea = All;
                }
                field(Product; Rec.Product)
                {
                    ApplicationArea = All;
                }
                field("Pending(LOA)Value"; Rec."Pending(LOA)Value")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    Caption = 'Amc Period  Start Date';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Rec."Order Date" > Rec."Requested Delivery Date" THEN
                            ERROR('Requested Delivery Date Must be Greater than Order Date');
                    end;
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    Caption = 'Amc Period  End  Date';
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Caption = 'Invoice Number';
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Project Completion Date"; Rec."Project Completion Date")
                {
                    ApplicationArea = All;
                }
                field("Extended Date"; Rec."Extended Date")
                {
                    ApplicationArea = All;
                }
                field("Order Assurance"; Rec."Order Assurance")
                {
                    Editable = "Order AssuranceEditable";
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin

                        /*IF (USERID='SUPER') OR (USERID='02IS001') THEN BEGIN
                        Mail_Subject:='Order Assurance';
                        newline:=10;
                        SHA.SETRANGE(SHA."No.","No.");
                        IF SHA.FINDFIRST THEN
                        BEGIN
                        Mail_Body:='Sale Order No.                   : '+FORMAT("No.");
                        Mail_Body+=FORMAT(newline);
                        Mail_Body+='Customer Name                    : '+FORMAT("Sell-to Customer Name");
                        Mail_Body+=FORMAT(newline);
                        Mail_Body+='Customer Order No.               : '+FORMAT("Customer OrderNo.");
                        Mail_Body+=FORMAT(newline);
                        Mail_Body+='Customer Requested Date          : '+FORMAT(("Requested Delivery Date"),0,4);
                        Mail_Body+=FORMAT(newline);
                        Mail_Body+='Assured Date                     : '+FORMAT((TODAY),0,4);
                        Mail_Body+=FORMAT(newline);
                        Mail_Body+='Days Between Release & Assurance : '+FORMAT(TODAY-"Expiration Date");
                        Mail_Body+=FORMAT(newline);
                        "Mail-Id".SETRANGE("Mail-Id"."User ID","Salesperson Code");
                        IF "Mail-Id".FINDFIRST THEN
                        Mail_Body+='Sales Executive                  : '+"Mail-Id".Name;
                        Mail_Body+=FORMAT(newline);
                        Mail_Body+=FORMAT(newline);
                        Mail_Body+='***** Auto Mail Generated From ERP *****';
                        "Mail-Id".SETRANGE("Mail-Id"."User ID",USERID);
                        IF "Mail-Id".FINDFIRST THEN
                        "from Mail":="Mail-Id".MailID;
                        "to mail":='swarupa@efftronics.net';
                        IF ("from Mail"<>'')AND("to mail"<>'') THEN
                        mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,''); */
                        Rec.MODIFY(TRUE);
                        //END;
                        //END
                        //ELSE
                        //ERROR('You Do not Have Permission to Assure');

                        IF Rec."Order Assurance" = TRUE AND (Rec.Status = Rec.Status::Open) THEN BEGIN
                            "Order AssuranceEditable" := FALSE;
                            Rec."Assured Date" := TODAY;
                        END ELSE
                            "Order AssuranceEditable" := TRUE;

                    end;
                }
                field("Security Deposit Status"; Rec."Security Deposit Status")
                {
                    Caption = 'Status';
                    ApplicationArea = All;
                }
                field("Sale Order Total Amount"; Rec."Sale Order Total Amount")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Customer OrderNo."; Rec."Customer OrderNo.")
                {
                    ApplicationArea = All;
                }
                field("Customer Order Date"; Rec."Customer Order Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Security Deposit Amount"; Rec."Security Deposit Amount")
                {
                    ApplicationArea = All;
                }
                field("SD Status"; Rec."SD Status")
                {
                    ApplicationArea = All;
                }
                field(SecDepStatus; Rec.SecDepStatus)
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
                action(Card)
                {
                    Caption = 'Card';
                    Image = Customer;
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
                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("S&hipments")
                {
                    Caption = 'S&hipments';
                    Image = Shipment;
                    RunObject = Page 142;
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ApplicationArea = All;
                }
                action(Invoices)
                {
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page 143;
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ApplicationArea = All;
                }
                separator(Action1102152056)
                {
                }
                /* action("Transit Documents")
                 {
                     Caption = 'Transit Documents';
                     Image = Documents;
                     RunObject = Page "Transit Document Order Details";
                     RunPageLink = Type = CONST(Sale), "PO / SO No." = FIELD("No."), "Vendor / Customer Ref." = FIELD("Sell-to Customer No.");
                 }
                action(Structure)
                 {
                     Caption = 'Structure';
                     Image = TaxDetail;
                     RunObject = Page "Structure Order Details";
                     RunPageLink = Type = CONST(Sale), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "Structure Code" = FIELD(Structure);
                 }
                 action("Authorization Information")
                 {
                     Caption = 'Authorization Information';
                     Image = AuthorizeCreditCard;
                     RunObject = Page 16344;
                     RunPageLink = "Transaction Type" = CONST(Sale), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                 }*/
                separator(Action1102152051)
                {
                }
                action("Whse. Shipment Lines")
                {
                    Caption = 'Whse. Shipment Lines';
                    Image = WarehouseRegisters;
                    RunObject = Page 7341;
                    RunPageLink = "Source Type" = CONST(37), "Source Subtype" = FIELD("Document Type"), "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    Visible = false;
                    ApplicationArea = All;
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PutawayLines;
                    RunObject = Page 5774;
                    RunPageLink = "Source Document" = CONST("Sales Order"), "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                    Visible = false;
                    ApplicationArea = All;
                }
                separator(Action1102152048)
                {
                }
                action("Pla&nning")
                {
                    Caption = 'Pla&nning';
                    Image = Planning;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        SalesPlanForm: Page 99000883;
                    begin
                        SalesPlanForm.SetSalesOrder("No.");
                        SalesPlanForm.RUNMODAL;
                    end;
                }
                action("Order &Promising")
                {
                    Caption = 'Order &Promising';
                    Image = OrderPromising;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        OrderPromisingLine: Record "Order Promising Line" temporary;
                    begin
                        OrderPromisingLine.SETRANGE("Source Type", "Document Type");
                        OrderPromisingLine.SETRANGE("Source ID", "No.");
                        PAGE.RUNMODAL(PAGE::"Order Promising Lines", OrderPromisingLine);
                    end;
                }
                separator(Action1102152044)
                {
                }
                action("Check List")
                {
                    Caption = 'Check List';
                    Image = CheckList;
                    RunObject = Page "Check List";
                    RunPageLink = "Document Type" = CONST(Sales), "Document No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("&MSPT Order Details")
                {
                    Caption = '&MSPT Order Details';
                    Image = "Order";
                    RunObject = Page "MSPT Order Details";
                    RunPageLink = Type = CONST(Sale), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "MSPT Header Code" = FIELD("MSPT Code"), "Party No." = FIELD("Sell-to Customer No.");
                    ApplicationArea = All;
                }
                action(Schedule)
                {
                    Caption = 'Schedule';
                    Image = Timesheet;
                    RunObject = Page Schedule;
                    RunPageLink = "Document No." = FIELD("Tender No."), "Document Type" = CONST(Order);
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            //Caption = '<Action1900000004>';
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                separator(Action1102152035)
                {
                }
                action("Get St&d. Cust. Sales Codes")
                {
                    Caption = 'Get St&d. Cust. Sales Codes';
                    Ellipsis = true;
                    Image = CodesList;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        StdCustSalesCode: Record "Standard Customer Sales Code";
                    begin
                        StdCustSalesCode.InsertSalesLines(Rec);
                    end;
                }
                separator(Action1102152033)
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
                action("Archi&ve Document")
                {
                    Caption = 'Archi&ve Document';
                    Image = Archive;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ArchiveManagement.ArchiveSalesDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Move Negative Lines")
                {
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CLEAR(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RUNMODAL;
                        MoveNegSalesLines.ShowDocument;
                    end;
                }
                separator(Action1102152027)
                {
                }
                action("Cancel Order")
                {
                    Caption = 'Cancel Order';
                    Enabled = false;
                    Image = CancelLine;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        OrderStatusValue: Text[50];
                        Text051: Label 'Do you want to Cancel the Order No. %1';
                    begin
                        IF CONFIRM(Text051, FALSE, "No.") THEN BEGIN
                            OrderStatusValue := 'Cancel';
                            CancelCloseOrder(OrderStatusValue, Rec);
                            CurrPage.UPDATE(FALSE);
                        END;
                    end;
                }
                action("Short Close Order")
                {
                    Caption = 'Short Close Order';
                    Image = Closed;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        OrderStatusValue: Text[50];
                        Text050: Label 'Do you want to Short Close the Order No. %1';
                    begin
                        IF CONFIRM(Text050, FALSE, "No.") THEN BEGIN
                            OrderStatusValue := 'Close';
                            CancelCloseOrder(OrderStatusValue, Rec);
                            CurrPage.UPDATE(FALSE);
                        END;
                    end;
                }
                separator(Action1102152024)
                {
                }
                action("Create &Whse. Shipment")
                {
                    Caption = 'Create &Whse. Shipment';
                    Image = UpdateShipment;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        GetSourceDocOutbound: Codeunit 5752;
                    begin
                        GetSourceDocOutbound.CreateFromSalesOrder(Rec);
                    end;
                }
                action("Create Inventor&y Put-away / Pick")
                {
                    Caption = 'Create Inventor&y Put-away / Pick';
                    Ellipsis = true;
                    Image = PutawayLines;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CreateInvtPutAwayPick;
                    end;
                }
                separator(Action1102152021)
                {
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    RunObject = Codeunit 414;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        ReleaseSalesDoc: Codeunit 414;
                    begin
                        ReleaseSalesDoc.Reopen(Rec);
                        /*IF ISCLEAR(MAPIHandler) THEN
                          CREATE(MAPIHandler);
                        IF user.GET(user."User ID") THEN
                        eroorno:=0;
                        MAPIHandler.ToName := 'bharat@efftronics.net';
                        MAPIHandler.ToName := 'chowdary@efftronics.net';
                        MAPIHandler.ToName := 'jhansi@efftronics.net';
                        MAPIHandler.ToName := 'anulatha@efftronics.net';
                        MAPIHandler.ToName := 'sganesh@efftronics.net';
                        MAPIHandler.ToName := 'dir@efftronics.net';
                        MAPIHandler.ToName := 'prasanthi@efftronics.net';
                        MAPIHandler.CCName := 'padmaja@efftronics.net';
                        MAPIHandler.Subject :=xRec."No."+'ORDER Reopen';
                        //OpenNewMessage('anilkumar@efftronics.net');
                        //NewMessage('anilkumar@efftronics','swarupa@efftronics.net','hai','body','attachment',TRUE);
                        MAPIHandler.AddBodyText('ORDER number in ERP'+xRec."No."+',');
                        MAPIHandler.AddBodyText(xRec."Sell-to Customer Name"+' is Reopen');
                        MAPIHandler.Send;
                        eroorno:=MAPIHandler.ErrorStatus;
                        */

                    end;
                }
                separator(Action1102152018)
                {
                }
                /*  action("Calculate Structure Values")
                  {
                      Caption = 'Calculate Structure Values';
                      Image = Calculate;

                      trigger OnAction();
                      begin
                          // NAVIN
                          SalesLine.CalculateStructures(Rec);
                          SalesLine.AdjustStructureAmounts(Rec);
                          SalesLine.UpdateSalesLines(Rec);
                          //calcamt;
                          // NAVIN
                      end;
                  }*/
                separator(Action1102152016)
                {
                }
                action("&Send BizTalk Sales Order Cnfmn.")
                {
                    Caption = '&Send BizTalk Sales Order Cnfmn.';
                    Image = SendEmailPDFNoAttach;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //B2b1.0>> Since BizTalkManagement CU doesn't exist in Nav 2013
                        //BizTalkManagement.SendSalesOrderConf(Rec);
                        //B2b1.0<<
                    end;
                }
                separator(Action1102152014)
                {
                }
                action("Release To Design")
                {
                    Caption = 'Release To Design';
                    Image = ReleaseShipment;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        Text01: Label 'Do You want to Send the Document to Design?';
                    begin
                        IF NOT CONFIRM(Text01, FALSE) THEN
                            EXIT;
                        TESTFIELD("Document Position", "Document Position"::Sales);
                        "Document Position" := "Document Position"::Design;
                        MODIFY;
                        Mail_Subject := 'Order Released to Design';
                        Mail_Body := 'Order No        : ' + "No.";
                        Mail_Body += FORMAT(newline);
                        Mail_Body += 'Customer Name   : ' + "Sell-to Customer Name";
                        Mail_Body += FORMAT(newline);
                        Mail_Body += FORMAT(newline);
                        Mail_Body += '***** Auto Mail Generated From ERP *****';
                        "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                        IF "Mail-Id".FINDFIRST THEN
                            //B2B UPG >>>
                            /*  "from Mail" := "Mail-Id".MailID;
                         "to mail" := 'jhansi@efftronics.net,sal@efftronics.net,erp@efftronics.net,cvmohan@efftronics.net';
                         MODIFY;
                         //   IF ( "from Mail"<>'') AND ("to mail"<>'') THEN
                         // mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,''); */  //B2B UPG <<<


                            Recipients.Add('jhansi@efftronics.net');
                        Recipients.Add('sal@efftronics.net');
                        Recipients.Add('erp@efftronics.net');
                        Recipients.Add('cvmohan@efftronics.net');
                        MODIFY;
                        //   IF ( "from Mail"<>'') AND ("to mail"<>'') THEN
                        // mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');
                        /* EmailMessage.Create(Recipients, Mail_Subject,Mail_Body,'');
                        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);*/

                        /*IF ISCLEAR(MAPIHandler) THEN
                          CREATE(MAPIHandler);
                        IF user.GET(user."User ID") THEN
                        eroorno:=0;
                        //MAPIHandler.ToName := 'anilkumar@efftronics.net';
                        MAPIHandler.ToName := 'chowdary@efftronics.net';
                        MAPIHandler.ToName := 'jhansi@efftronics.net';
                        MAPIHandler.ToName := 'anulatha@efftronics.net';
                        MAPIHandler.ToName := 'sganesh@efftronics.net';
                        MAPIHandler.ToName := 'dir@efftronics.net';
                        MAPIHandler.ToName := 'prasanthi@efftronics.net';
                        MAPIHandler.CCName := 'anilkumar@efftronics.net';
                        MAPIHandler.Subject :=xRec."No."+'ORDER Relesed to design';
                        //OpenNewMessage('anilkumar@efftronics.net');
                        //NewMessage('anilkumar@efftronics','swarupa@efftronics.net','hai','body','attachment',TRUE);
                        MAPIHandler.AddBodyText('ORDER number in ERP'+xRec."No."+',');
                        MAPIHandler.AddBodyText(xRec."Sell-to Customer Name"+' is Relesed to Design');
                        MAPIHandler.Send;
                        eroorno:=MAPIHandler.ErrorStatus;*/

                    end;
                }
                action("Update RDSO Details")
                {
                    Caption = 'Update RDSO Details';
                    Image = UpdateUnitCost;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        SalesLine: Record "Sales Line";
                    begin
                        SalesLine.SETRANGE(SalesLine."Document Type", "Document Type");
                        SalesLine.SETRANGE(SalesLine."Document No.", "No.");
                        IF SalesLine.FINDSET THEN
                            REPEAT
                                SalesLine."RDSO Charges Paid By" := "RDSO Charges Paid By";
                                SalesLine."RDSO Inspection Required" := "RDSO Inspection Required";
                                SalesLine."RDSO Inspection By" := "RDSO Inspection By";
                                SalesLine."RDSO Charges" := "RDSO Charges";
                                SalesLine.MODIFY;
                            UNTIL SalesLine.NEXT = 0;
                    end;
                }
                separator(Action1102152011)
                {
                }
                action("Release To Finance")
                {
                    Caption = 'Release To Finance';
                    Image = SendAsPDF;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        Text01: Label 'Do You want to Send the Document to Finance?';
                    begin
                        IF NOT CONFIRM(Text01, FALSE) THEN
                            EXIT;
                        TESTFIELD("Document Position", "Document Position"::Sales);
                        "Document Position" := "Document Position"::CRM;
                        MODIFY;
                    end;
                }
                action("Get invoice number")
                {
                    Caption = 'Get invoice number';
                    Image = SuggestNumber;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        salhed.SETFILTER(salhed."Document Type", 'AMC|ORDER');
                        salhed.SETFILTER(salhed."External Document No.", '<>%1', '');
                        IF salhed.COUNT > 0 THEN
                            IF salhed.FINDSET THEN
                                REPEAT
                                    ERROR(salhed."No." + '  Sale Have the Invoice Number');
                                UNTIL salhed.NEXT = 0;

                        //ERROR('Invoice Number Already Assign to Another Sale Order');
                        POSTEDINVOICE.SETCURRENTKEY(POSTEDINVOICE."External Document No.");  //sreenivas modified this line
                        POSTEDINVOICE.ASCENDING;      //this line too
                        POSTEDINVOICE.SETRANGE(POSTEDINVOICE."Posting Date", (DMY2Date(04, 01, 12)), (DMY2Date(03, 31, 13)));
                        POSTEDINVOICE.SETFILTER(POSTEDINVOICE."External Document No.", 'SI*');
                        //MESSAGE(FORMAT(POSTEDINVOICE.COUNT));
                        IF POSTEDINVOICE.FINDLAST THEN BEGIN
                            y := '0';
                            y := POSTEDINVOICE."External Document No.";
                            temp := 1;
                        END;
                        IF temp = 0 THEN
                            "External Document No." := 'SI-001'
                        ELSE
                            "External Document No." := INCSTR(y);

                        MODIFY;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = Post;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    /*  trigger OnAction();
                      begin
                          servicetaxamt := 0;
                          IF Structure = 'SERVICE' THEN BEGIN
                              SL.RESET;
                              SL.SETRANGE(SL."Document No.", "No.");
                              IF SL.FINDSET THEN
                                  REPEAT
                                      servicetaxamt := servicetaxamt + SL."Service Tax Amount";
                                  UNTIL SL.NEXT = 0;
                              IF servicetaxamt = 0 THEN
                                  ERROR('You are not calculated the Service Tax Amount, first calculate the Structure Values then post the invoice');
                          END;
                          CODEUNIT.RUN(81, Rec);

                          // NAVIN
                      end;*/
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    ShortCutKey = 'Shift+F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        // NAVIN
                        /*IF Structure <> '' THEN BEGIN
                            SalesLine.CalculateStructures(Rec);
                            SalesLine.AdjustStructureAmounts(Rec);
                            SalesLine.UpdateSalesLines(Rec);
                            COMMIT;
                        END;*/

                        CODEUNIT.RUN(82, Rec);

                        // NAVIN
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Orders", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Invoice Preview")
                {
                    Caption = 'Invoice Preview';
                    Image = PreviewChecks;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        "sales header".SETRANGE("sales header"."No.", "No.");
                        REPORT.RUN(50114, TRUE, FALSE, "sales header");
                    end;
                }
                action("Dispatch Note")
                {
                    Caption = 'Dispatch Note';
                    Image = Note;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        "sales header".SETRANGE("sales header"."No.", "No.");
                        //REPORT.RUN(90000,TRUE,FALSE,SalesHeader);
                        REPORT.RUN(50107, TRUE, FALSE, "sales header");
                    end;
                }
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
        }
    }

    trigger OnDeleteRecord(): Boolean;
    begin
        CurrPage.UPDATE;
        MODIFY;
        EXIT(ConfirmDeletion);
    end;

    trigger OnInit();
    begin
        PostingfromWhseRefEditable := TRUE;
        "Order AssuranceEditable" := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        CheckCreditMaxBeforeInsert;
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        TESTFIELD(Status, Status::Open);
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
        "sales header".SETRANGE("sales header"."No.", "No.");
        IF "sales header".FINDFIRST THEN BEGIN
            IF "sales header"."Order Assurance" = FALSE THEN
                "Order AssuranceEditable" := TRUE
            ELSE
                "Order AssuranceEditable" := FALSE;
        END;

        "sales header".SETRANGE("sales header"."No.", "No.");
        IF "sales header".FINDFIRST THEN;


        SETRANGE("Date Filter", 0D, WORKDATE - 1);
    end;


    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit email;
        Recipients: List of [Text];
        Text000: Label 'Unable to execute this function while in view only mode.';
        CopySalesDoc: Report 292;
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit 229;
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesSetup: Record "Sales & Receivables Setup";
        UserMgt: Codeunit "User Setup Management";
        "-NAVIN-": Integer;
        SalesLine: Record "Sales Line";
        Text001: Label 'Do you want to convert the Order to an Export order?';
        Text002: Label 'Order number %1 has been converted to Export order number %2.';
        Text13000: Label 'No Setup exists for this Amount.';
        Text13001: Label 'Do you want to send the order for Authorization?';
        Text13002: Label 'The Order Is Authorized, You Cannot Resend For Authorization';
        Text13003: Label 'You Cannot Resend For Authorization';
        Text13004: Label 'This Order Has been Rejected. Please Create A New Order.';
        MLTransactionType: Option Purchase,Sale;
        SalesPlanLine: Record "Sales Planning Line";
        Quantity: Decimal;
        SalesLineRec: Record "Sales Line";
        I: Integer;
        Qty: Decimal;
        NewStatus: Option Simulated,Planned,"Firm Planned",Released;
        NewOrderType: Option ItemOrder,ProjectOrder;
        eroorno: Integer;
        user: Record User;
        "Mail-Id": Record "User Setup";
        "from Mail": Text[1000];
        "to mail": Text[1000];
        Mail_Subject: Text[1000];
        Mail_Body: Text[1000];
        mail: Codeunit Mail;
        amt: Decimal;
        vatamt: Decimal;
        taxamt: Decimal;
        exciseamt: Decimal;
        pendingamt: Decimal;
        ecessamt: Decimal;
        shecessamt: Decimal;
        "sales header": Record "Sales Header";
        newline: Char;
        GenJnlManagement: Codeunit GenJnlManagement;
        CurrentJnlBatchName: Code[10];
        SHA: Record "Sales Header Archive";
        CUS: Record Customer;
        Body: Text[1000];
        Subject: Text[1000];
        SMTPSETUP: Record "SMTP SETUP";
        AttachFileName: Text[1000];
        /*  objEmailConf: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000002-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Configuration";
         objEmail: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000001-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Message";
         flds: Automation "'{00000205-0000-0010-8000-00AA006D2EA4}' 2.5:'{00000564-0000-0010-8000-00AA006D2EA4}':''{00000205-0000-0010-8000-00AA006D2EA4}' 2.5'.Fields";
         fld: Automation "'{00000205-0000-0010-8000-00AA006D2EA4}' 2.5:'{00000569-0000-0010-8000-00AA006D2EA4}':''{00000205-0000-0010-8000-00AA006D2EA4}' 2.5'.Field"; */
        servicetaxamt: Decimal;
        SL: Record "Sales Line";
        //SMTP_Mail: Codeunit "SMTP Mail";
        salhed: Record "Sales Header";
        POSTEDINVOICE: Record "Sales Invoice Header";
        y: Code[10];
        temp: Integer;
        [InDataSet]
        "Order AssuranceEditable": Boolean;
        [InDataSet]
        PostingfromWhseRefEditable: Boolean;

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
        FromDocDim: Record "Dimension Set Entry";
        ToDocDim: Record "Dimension Set Entry";
        SalesExportOrderHeader: Record "Sales Header";
        SalesExportOrderLine: Record "Sales Line";
        SalesCommentLine: Record "Sales Comment Line";
        ItemChargeAssgntSales: Record "Item Charge Assignment (Sales)";
        ReserveSalesLine: Codeunit 99000832;
        SalesOrderLine: Record "Sales Line";
    begin
        IF NOT CONFIRM(Text001, FALSE) THEN
            EXIT;
        SalesExportOrderHeader := Rec;
        SalesExportOrderHeader."Document Type" := SalesExportOrderHeader."Document Type"::Order;
        //SalesExportOrderHeader."Export Document" := TRUE;
        // CODE WAS COMMENTED FOR NAVISION UPGRADATION
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
        //DIM1.0
        SalesExportOrderHeader."Dimension Set ID" := "Dimension Set ID";
        //DIM1.0
        //SalesExportOrderHeader."Date Received" := 0D; //B2b1.0
        //SalesExportOrderHeader."Time Received" := 0T; //B2b1.0
        //SalesExportOrderHeader."Date Sent" := 0D; //B2b1.0
        //SalesExportOrderHeader."Time Sent" := 0T; //B2b1.0
        SalesExportOrderHeader."posting time" := TIME;
        SalesExportOrderHeader.MODIFY;

        SalesOrderLine.SETRANGE("Document Type", "Document Type");
        SalesOrderLine.SETRANGE("Document No.", "No.");

        //DIM1.0 Start
        //Code Commented
        /*
        FromDocDim.SETRANGE("Table ID",DATABASE::"Purchase Line");
        ToDocDim.SETRANGE("Table ID",DATABASE::"Purchase Line");
        */
        //DIM1.0 ENd

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
            //DIM 1.0 Start
            //Code Commented
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


    procedure "---B2B---"();
    begin
    end;


    procedure DocumentPosition();
    begin
        /*
        IF "Document Position" = "Document Position" :: Design THEN
          CurrPage.EDITABLE := FALSE
        ELSE
          CurrPage.EDITABLE := TRUE;
        */

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
              SalesLine."Document Type"::Order,
              SalesPlanLine."Sales Order No.",
              SalesPlanLine."Sales Order Line No.");
            //SalesLine.TESTFIELD("Shipment Date");
            MESSAGE('anil');//anil
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
    end;

    procedure calcamt();
    begin
        "Sale Order Total Amount" := 0;
        SalesLine.SETRANGE(SalesLine."Document No.", "No.");
        IF SalesLine.FINDSET THEN
            REPEAT
            //"Sale Order Total Amount"+=SalesLine."Line Amount"+SalesLine."Excise Amount"+SalesLine."VAT Amount"+SalesLine."Tax Amount";
            // CODE WAS COMMENTED FOR NAVISION UPGRADATION
            UNTIL SalesLine.NEXT = 0;
        MODIFY;
    end;

    local procedure SelltoCustomerNoOnAfterValidat();
    begin
        CurrPage.UPDATE;
    end;

    local procedure BilltoCustomerNoOnAfterValidat();
    begin
        CurrPage.UPDATE;
    end;

    local procedure PostingfromWhseRefOnActivate();
    begin
        IF "Posting from Whse. Ref." > 0 THEN
            PostingfromWhseRefEditable := FALSE
        ELSE
            PostingfromWhseRefEditable := TRUE;
    end;
}

