pageextension 70320 "BlanketSaleExt" extends 507
{
    layout
    {
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                SalesLine: Record "Sales Line";
            begin

                IF (xRec."Sell-to Customer No." = 'CUST02007') THEN BEGIN
                    //SHA.TRANSFERFIELDS(xRec);
                    // shl.TRANSFERFIELDS(SalesLine);
                    SHA.RESET;
                    SHA.TRANSFERFIELDS(xRec);
                    SHA.INSERT;
                    COMMIT;
                    shl.TRANSFERFIELDS(SalesLine);
                    shl.SETFILTER("Document No.", Rec."No.");
                    IF shl.FINDFIRST THEN
                        shl.MODIFY
                    ELSE
                        shl.INSERT;
                    COMMIT;
                END;
            end;
        }
        modify("Sell-to Contact No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                IF ("Sell-to Customer No." = 'CUST02007') THEN BEGIN
                    tender_date_flg := TRUE;
                    //   SHA.TRANSFERFIELDS(Rec);
                    // shl.TRANSFERFIELDS(SalesLine);
                END;
            end;
        }
        modify("Shortcut Dimension 1 Code")
        {
            trigger OnAfterValidate()
            var
                SalesLine: Record "Sales Line";
            begin
                SalesLine.RESET;
                SalesLine.SETFILTER(SalesLine."Document No.", Rec."No.");
                IF SalesLine.FINDSET THEN
                    SalesLine."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
            end;


        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var SalesLine: Record "Sales Line";
            begin
                SalesLine.RESET;
                SalesLine.SETFILTER(SalesLine."Document No.", Rec."No.");
                IF SalesLine.FINDSET THEN
                    SalesLine."Shortcut Dimension 1 Code" := 'PRD-010';
            end;
        }
        // Add changes to page layout here
        addafter("Campaign No.")
        {
            field("Customer OrderNo."; "Customer OrderNo.")
            {
                ApplicationArea = all;
            }
        }
        addafter(Status)
        {
            field("Order Released Date"; "Order Released Date")
            {
                ApplicationArea = all;
            }
            field("Sale Order Total Amount"; "Sale Order Total Amount")
            {
                ApplicationArea = all;
            }
            field("Sale Order Created"; "Sale Order Created")
            {
                ApplicationArea = all;
            }
            field("Order Verified"; "Order Verified")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    //Added by Pranavi on 31-Dec-2015 for order verification rights
                    IF NOT (USERID IN ['EFFTRONICS\JHANSI', 'EFFTRONICS\VSNGEETHA', 'EFFTRONICS\VANIDEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
                        ERROR('You Do Not Have Rights!');
                    //End by Pranavi
                end;

            }
            field("Verification Status"; "Verification Status")
            {
                ApplicationArea = all;
            }
            field(Remarks; Remarks)
            {
                ApplicationArea = all;
            }
            field("Order Confirmed"; "Order Confirmed")
            {
                ApplicationArea = all;
            }
            field(Vertical; Vertical)
            {
                ApplicationArea = all;
            }
            field("Shipment Type"; "Shipment Type")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Tender Published Date"; "Tender Published Date")
            {
                Editable = tender_date_flg;
                ApplicationArea = all;
            }
            field("Tender Due Date"; "Tender Due Date")
            {
                ApplicationArea = ALL;
                Editable = tender_date_flg;
            }
            field("Requested Delivery Date"; "Requested Delivery Date")
            {
                ApplicationArea = ALL;
            }
            field("Railway Division"; "Railway Division")
            {
                ApplicationArea = ALL;
                Editable = tender_date_flg;
            }

        }
        addafter("Area")
        {
            field("Sale Order No."; "Sale Order No.")
            {
                ApplicationArea = all;
            }
            group("Security Deposit")
            {
                Caption = 'Security Deposit';
                field("Security Deposit Amount"; "Security Deposit Amount")
                {
                    ApplicationArea = all;

                }
                field("EMD Amount"; "EMD Amount")
                {
                    ApplicationArea = all;
                }
                field("Tender No."; "Tender No.")
                {
                    ApplicationArea = all;
                }
                field("Deposit Payment Due Date"; "Deposit Payment Due Date")
                {
                    ApplicationArea = all;
                }
                field("Deposit Payment Date"; "Deposit Payment Date")
                {
                    ApplicationArea = ALL;
                }
                field("SD Requested Date"; "SD Requested Date")
                {
                    ApplicationArea = all;
                }
                field("SD Required Date"; "SD Required Date")
                {
                    ApplicationArea = all;
                }
                field("SecurityDeposit Exp. Rcpt Date"; "SecurityDeposit Exp. Rcpt Date")
                {
                    ApplicationArea = all;
                }
                field("Final Bill Date"; "Final Bill Date")
                {

                }
                field("SD Status"; "SD Status")
                {
                    ApplicationArea = all;
                }
                field("Warranty Period"; "Warranty Period")
                {
                    ApplicationArea = all;
                }
                field("Prepmt. Pmt. Discount Date"; "Prepmt. Pmt. Discount Date")
                {
                    ApplicationArea = all;
                }


            }

        }
        addafter("Bill-to Contact")
        {
            field("Order Assurance"; "Order Assurance")
            {
                ApplicationArea = all;
            }

        }
        addafter("Pmt. Discount Date")
        {
            field("Expecting Week"; "Expecting Week")
            {
                ApplicationArea = all;
            }
        }
        addafter("Ship-to Contact")
        {
            field("Order Status"; "Order Status")
            {
                ApplicationArea = all;
            }
        }
        addbefore("Location Code")
        {
            field(Product; Product)
            {

            }
        }
        addafter("Shipment Date")
        {
            field("Project Completion Date"; "Project Completion Date")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    IF ("Project Completion Date" < "Expecting Week") AND (FORMAT("Expecting Week") > 'OD') THEN
                        ERROR('Project Completion Date must not be less than Expecting Week');
                END;

            }

        }


    }


    actions
    {
        // Add changes to page actions here

        addafter("Co&mments")
        {

            action("Create Production Order for All")
            {
                Image = CreatePutawayPick;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction();
                var
                    SalesLine: Record 37;
                    ProductionOrder: Record 5405;
                    SalesLine3: Record 37;
                    Schedule2LRec: Record 60095;
                    SalesHeaderLRec: Record 36;
                    SalesPlanLineLRec: Record 99000800;
                    SOSchedule: Page 60125;
                    ItemUnitofMeasure: Record 5404;

                begin

                    ProductionOrder.RESET;      //Added by Suvarchala
                    ProductionOrder.SETRANGE(Status, ProductionOrder.Status::Released);
                    ProductionOrder.SETRANGE("Sales Order No.", Rec."No.");
                    IF ProductionOrder.FINDFIRST THEN
                        ERROR('RPO has been created for this order');

                    Window.OPEN('Action is under process.......');
                    IF "Order Assurance" = FALSE THEN
                        ERROR('Order Was not Assured By Sales Dept.')
                    ELSE BEGIN //B2BJM 06-Feb-2020 >>  creating rpo for all the lines in sales order
                        SalesLine2.RESET;
                        SalesLine2.SETRANGE("Document Type", Rec."Document Type");
                        SalesLine2.SETRANGE("Document No.", Rec."No.");
                        SalesLine2.SETRANGE(Type, SalesLine2.Type::Item);
                        SalesLine2.SETFILTER("Outstanding Quantity", '>%1', 0);
                        IF SalesLine2.FINDSET THEN BEGIN
                            REPEAT
                                SalesPlanLine.DELETEALL;
                                Quantity := CurrPage.SalesLines.PAGE.MakeLines(SalesLine2);
                                IF SalesLine2."Unit of Measure Code" <> 'NOS' THEN BEGIN
                                    IF ItemUnitofMeasure.GET(SalesLine2."No.", SalesLine2."Unit of Measure Code") THEN
                                        CreateOrders(Quantity * ItemUnitofMeasure."Qty. per Unit of Measure");
                                END ELSE
                                    CreateOrders(Quantity);
                            UNTIL SalesLine2.NEXT = 0;
                        END;
                        //For Schedule items
                        SalesLine3.RESET;
                        SalesLine3.SETRANGE("Document Type", Rec."Document Type");
                        SalesLine3.SETRANGE("Document No.", Rec."No.");
                        SalesLine3.SETRANGE(Type, SalesLine3.Type::Item);
                        SalesLine3.SETFILTER("Pending By", '%1', SalesLine3."Pending By"::" ");//need to confirm
                        IF SalesLine3.FINDSET THEN
                            REPEAT
                                Schedule2LRec.RESET;
                                Schedule2LRec.SETRANGE("Document Type", 4);
                                Schedule2LRec.SETRANGE("Document No.", SalesLine3."Document No.");
                                Schedule2LRec.SETRANGE("Document Line No.", SalesLine3."Line No.");
                                Schedule2LRec.SETFILTER("Line No.", '>%1', SalesLine3."Line No.");
                                Schedule2LRec.SETFILTER("Posting Group", '%1', '*MPBI*');
                                IF Schedule2LRec.FINDSET THEN BEGIN
                                    IF SalesHeaderLRec.GET(Rec."Document Type", Rec."No.") THEN
                                        IF SalesHeaderLRec."Order Assurance" = FALSE THEN
                                            ERROR('Order Was not Assured By Sales Dept.');
                                    REPEAT
                                        SalesPlanLineLRec.DELETEALL;
                                        ProdMakeQty := SOSchedule.MakeLinesForSchedules(Schedule2LRec);
                                        IF SalesLine3."Unit of Measure Code" <> 'NOS' THEN BEGIN
                                            IF ItemUnitofMeasure.GET(SalesLine3."No.", SalesLine3."Unit of Measure Code") THEN
                                                SOSchedule.CreateOrdersForSchedules(ProdMakeQty * ItemUnitofMeasure."Qty. per Unit of Measure")
                                        END ELSE
                                            SOSchedule.CreateOrdersForSchedules(ProdMakeQty);
                                    //       FOR i := 1 TO ProdMakeQty
                                    //         DO BEGIN
                                    //           Qty := 1;
                                    //           SOSchedule.CreateOrders(Qty);
                                    //         END;
                                    UNTIL Schedule2LRec.NEXT = 0;
                                END;
                            UNTIL SalesLine3.NEXT = 0;
                    END;
                    Window.CLOSE;   //End by Suvarchala

                end;
            }

        }

    }

    trigger OnClosePage()
    var
        myInt: Integer;
    begin
        IF ("Sell-to Customer No." = 'CUST02007') THEN BEGIN
            IF (("Tender Published Date" = 0D) AND ("Tender Due Date" = 0D)) THEN
                ERROR('Please fill the tender published date and tender due date ');

        END;
    end;

    trigger OnAfterGetRecord()
    begin
        CHANGELOGSETUP.RESET;
        CHANGELOGSETUP.SETFILTER(CHANGELOGSETUP."Primary Key Field 2 Value", FORMAT("No."));
        IF CHANGELOGSETUP.COUNT > 0 THEN
            forwordomsVisible := TRUE
        ELSE
            forwordomsVisible := FALSE;
        //Rec.SetControlAppearance;
        IF ("Sell-to Customer No." = 'CUST02007') THEN
            tender_date_flg := TRUE;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        TESTFIELD(Status, Status::Open);
    end;

    PROCEDURE CreateOrders(Qtyparam: Decimal) OrdersCreated: Boolean;
    VAR
        Item: Record 27;
        SalesLine: Record 37;

        ProdOrderFromSale: Codeunit "Event Handling Cust";//EFFUPG1.2
        NewStatus: Option Simulated,Planned,"Firm Planned",Released;//EFFUPG1.2
        NewOrderType: Option ItemOrder,ProjectOrder;//EFFUPG1.2
    BEGIN
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
                ProdOrderFromSale.CreateProdOrder2(
        SalesLine, NewStatus::Released, NewOrderType::ItemOrder, Qtyparam);
                IF NewOrderType = NewOrderType::ProjectOrder THEN
                    EXIT;
            END;
        //END;
        UNTIL (SalesPlanLine.NEXT = 0);

        /* {nextline:=10;
             "Mail-Id".SETRANGE("Mail-Id"."User ID",USERID);
             IF "Mail-Id".FINDFIRST THEN
             "from Mail":="Mail-Id".MailID;
            "to mail":='anilkumar@efftronics.com,padmaja@efftronics.com';
             Mail_Subject:='ERP- '+"No." +'  Expected Order Modified';    }*/
        /*{    Mail_Body+='SALE ORDER RELEASE :';
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
        }*/
        //IF ("from Mail"<>'')AND("to mail"<>'') THEN
        // mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');
    END;

    LOCAL PROCEDURE CurrencyCodeOnAfterValidate();
    BEGIN
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    END;

    PROCEDURE IREPS_CUST_CHK();
    BEGIN
        IF "Sell-to Customer No." IN ['CUST02007'] THEN
            ERROR('Change the Customer, you can"t make any transaction on IREPS Customer');
    END;

    PROCEDURE InputBox(): Text;
    VAR
        FormBorderStyle: DotNet FormBorderStyleD;
        Prompt: DotNet PromptD;


        FormStartPosition: DotNet FormStartPositionD;


        LblRows: DotNet LblRowsD;


        TxtRows: DotNet TxtRowsD;



        // System.Windows.Forms.TextBox" RUNONCLIENT;
        ButtonOk: DotNet confirmationD;

        ButtonCancel: DotNet ButtonCancelD;


        DialogResult: DotNet DialogResultD;



        //  System.Windows.Forms.DialogResult" RUNONCLIENT;
        NoOFRows_gInt: Integer;
        NoOFColumns_gInt: Integer;
        Result: Text;
        FindWhat: Text[2];
        ReplaceWith: Text[4];
        NewString: Text;
        i: Integer;
    BEGIN

        // ADDED BY VIJAYA ON 20-MAY-2016 for Changing Order Status

        Prompt := Prompt.Form();
        Prompt.Width := 400;
        Prompt.Height := 650;
        Prompt.FormBorderStyle := FormBorderStyle.FixedToolWindow;
        Prompt.Text := 'Remarks';
        Prompt.StartPosition := FormStartPosition.CenterParent;

        LblRows := LblRows.Label();
        LblRows.Text := 'Enter Remarks :: ';
        LblRows.Left := 20;
        LblRows.Top := 20;
        Prompt.Controls.Add(LblRows);

        TxtRows := TxtRows.TextBox();
        TxtRows.Left(20);
        TxtRows.Top(50);
        TxtRows.Width(350);
        TxtRows.Height(520);
        TxtRows.Multiline := TRUE;
        TxtRows.ScrollBars := 1;


        Prompt.Controls.Add(TxtRows);

        ButtonOk := ButtonOk.Button();
        ButtonOk.Text('Ok');
        ButtonOk.Left(215);
        ButtonOk.Top(580);
        ButtonOk.Width(75);
        ButtonOk.DialogResult := DialogResult.OK;
        Prompt.Controls.Add(ButtonOk);

        ButtonCancel := ButtonCancel.Button();
        ButtonCancel.Text('Cancel');
        ButtonCancel.Left(295);
        ButtonCancel.Top(580);
        ButtonCancel.Width(75);
        ButtonCancel.DialogResult := DialogResult.Cancel;
        Prompt.Controls.Add(ButtonCancel);

        IF (Prompt.ShowDialog().ToString() <> DialogResult.OK.ToString()) THEN BEGIN
            EXIT;
        END;
        Prompt.Dispose;
        Result := TxtRows.Text;   /*{
        FindWhat := format(13);
        ReplaceWith := 'xx';
        WHILE STRPOS(Result, FindWhat) > 0 DO
            Result := DELSTR(Result, STRPOS(Result, FindWhat)) + ReplaceWith + COPYSTR(Result, STRPOS(Result, FindWhat) + STRLEN(FindWhat));}*/

        //NewString := String;

        i := 1;
        NewString := '';
        WHILE i < STRLEN(Result) + 2 DO BEGIN
            IF (Result[i] = 13) THEN
                NewString := NewString + '<br>'
            ELSE
                NewString := NewString + FORMAT(Result[i]);
            i := i + 1;
        END;



        EXIT(NewString);

        //end by vijaya
    END;


    trigger OnOpenPage()
    begin
        Setfilter("Order Status", '<>%1', "Order Status"::"Temporary Close");
        Setfilter("No.", '%1', 'EFF/EXP*');
        setrange("Sale Order Created", false);
    end;



    var
        myInt: Integer;
        "Mail-Id": Record 2000000120;
        "from Mail": Text[100];
        "to mail": Text[1000];
        Mail_Subject: Text[250];
        Mail_Body: Text[250];
        mail: Codeunit 397;
        SalesPlanLine: Record 99000800;
        Quantity: Decimal;
        I: Integer;
        Qty: Integer;
        SalesLineRec: Record 37;
        NewStatus: Label 'Simulated,Planned,Firm Planned,Released';
        NewOrderType: Label 'ItemOrder,ProjectOrder';
        charline: Char;
        SH: Record 36;
        Attachment: Text[1000];
        SMTPSETUP: Record 50018;
        newline: Char;
        Text01: Label 'ENU=Do You want to Send the Document to Design?';
        SMTP_MAIL: Codeunit 400;
        user: Record 2000000120;
        SCHEDULEOMS: Record 60095;
        Attachment1: Text[1000];
        salesheader: Record 36;
        forwordtooms: Text[50];
        CHANGELOGSETUP: Record 405;
        //forwordomsVisible: Boolean INDATASET;
        SHA: Record 5107;
        username: Text;
        salesperson: Record 13;
        MailCC: Text;
        Mail_From: Text;
        Mail_To: Text;
        Subject: Text;
        Body: Text;
        TH: Record 60062;
        Quote: Label 'ENU=''';
        StringReplaceFunction: Codeunit 60029;
        attachments: Record 60098;
        tender_date_flg: Boolean;
        shl: Record 5108;
        Window: Dialog;
        SalesLine2: Record 37;
        ProdMakeQty: Integer;
        forwordomsVisible: Boolean;


}