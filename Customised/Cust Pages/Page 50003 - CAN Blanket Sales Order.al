page 50003 "CAN Blanket Sales Order"
{


    Caption = '" CAN Blanket Sales Order"';
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
                        SelltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
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
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Customer OrderNo."; Rec."Customer OrderNo.")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                /* field(Control1280004; Structure)
                 {
                     ApplicationArea = All;
                 }*/
                field("Sale Order Created"; Rec."Sale Order Created")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
            }
            part(SalesLines; "CANBlanket Sales Order Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        BilltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    Caption = 'Bill-to Post Code/City';
                    ApplicationArea = All;
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Order Assurance"; Rec."Order Assurance")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Order Completion Period"; Rec."Order Completion Period")
                {
                    ApplicationArea = All;
                }
                field("Expecting Week"; Rec."Expecting Week")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Expected Order Month"; Rec."Expected Order Month")
                {
                    ApplicationArea = All;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code/City';
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Order Status"; Rec."Order Status")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Tender No."; Rec."Tender No.")
                {
                    ApplicationArea = All;
                }
                field("Order Released Date"; Rec."Order Released Date")
                {
                    ApplicationArea = All;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WORKDATE);
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ApplicationArea = All;
                }
                field("Area"; Rec.Area)
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
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    ShortCutKey = 'F7';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        SalesSetup.GET;
                        IF SalesSetup."Calc. Inv. Discount" THEN BEGIN
                            CurrPage.SalesLines.PAGE.CalcInvDisc;
                            COMMIT;
                        END;
                        PAGE.RUNMODAL(PAGE::"Sales Order Statistics", Rec);
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
                    Image = ViewComments;
                    RunObject = Page 67;
                    RunPageLink = "Document Type" = CONST("Blanket Order"), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                /*
                action(Structure)
                {
                    Caption = 'Structure';
                    Image = CheckList;
                    RunObject = Page "Structure Order Details";
                                    RunPageLink = Type=CONST(Sale),"Document Type"=FIELD("Document Type"),"Document No."=FIELD("No."),"Structure Code"=FIELD(Structure);
                }
                */
            }
            group("&Line")
            {
                Caption = '&Line';
                group("Unposted Lines")
                {
                    Caption = 'Unposted Lines';
                    Image = PostedTaxInvoice;
                    action(Orders)
                    {
                        Caption = 'Orders';
                        Image = "Order";
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            CurrPage.SalesLines.PAGE.GETRECORD(CurrentSalesLine);
                            SalesLine.RESET;
                            SalesLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
                            SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
                            SalesLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
                            SalesLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
                            PAGE.RUNMODAL(PAGE::"Sales Lines", SalesLine);
                        end;
                    }
                    action(Invoices)
                    {
                        Caption = 'Invoices';
                        Image = Invoice;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            CurrPage.SalesLines.PAGE.GETRECORD(CurrentSalesLine);
                            SalesLine.RESET;
                            SalesLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
                            SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Invoice);
                            SalesLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
                            SalesLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
                            PAGE.RUNMODAL(PAGE::"Sales Lines", SalesLine);
                        end;
                    }
                    action("Return Orders")
                    {
                        Caption = 'Return Orders';
                        Image = ReturnOrder;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            CurrPage.SalesLines.PAGE.GETRECORD(CurrentSalesLine);
                            SalesLine.RESET;
                            SalesLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
                            SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::"Return Order");
                            SalesLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
                            SalesLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
                            PAGE.RUNMODAL(PAGE::"Sales Lines", SalesLine);
                        end;
                    }
                    action("Credit Memos")
                    {
                        Caption = 'Credit Memos';
                        Image = CreditMemo;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            CurrPage.SalesLines.PAGE.GETRECORD(CurrentSalesLine);
                            SalesLine.RESET;
                            SalesLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
                            SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::"Credit Memo");
                            SalesLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
                            SalesLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
                            PAGE.RUNMODAL(PAGE::"Sales Lines", SalesLine);
                        end;
                    }
                }
                group("Posted Lines")
                {
                    Caption = 'Posted Lines';
                    Image = PostedOrder;
                    action(Shipments)
                    {
                        Caption = 'Shipments';
                        Image = Shipment;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            CurrPage.SalesLines.PAGE.GETRECORD(CurrentSalesLine);
                            SaleShptLine.RESET;
                            SaleShptLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
                            SaleShptLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
                            SaleShptLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
                            PAGE.RUNMODAL(PAGE::"Posted Sales Shipment Lines", SaleShptLine);
                        end;
                    }
                    action(Action110)
                    {
                        Caption = 'Invoices';
                        Image = Invoice;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            CurrPage.SalesLines.PAGE.GETRECORD(CurrentSalesLine);
                            SalesInvLine.RESET;
                            SalesInvLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
                            SalesInvLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
                            SalesInvLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
                            PAGE.RUNMODAL(PAGE::"Posted Sales Invoice Lines", SalesInvLine);
                        end;
                    }
                    action("Return Receipts")
                    {
                        Caption = 'Return Receipts';
                        Image = ReturnReceipt;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            CurrPage.SalesLines.PAGE.GETRECORD(CurrentSalesLine);
                            ReturnRcptLine.RESET;
                            ReturnRcptLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
                            ReturnRcptLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
                            ReturnRcptLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
                            PAGE.RUNMODAL(PAGE::"Posted Return Receipt Lines", ReturnRcptLine);
                        end;
                    }
                    action(Action112)
                    {
                        Caption = 'Credit Memos';
                        Image = CreditMemo;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            CurrPage.SalesLines.PAGE.GETRECORD(CurrentSalesLine);
                            SalesCrMemoLine.RESET;
                            SalesCrMemoLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
                            SalesCrMemoLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
                            SalesCrMemoLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
                            PAGE.RUNMODAL(PAGE::"Posted Sales Credit Memo Lines", SalesCrMemoLine);
                        end;
                    }
                }
                action("Create Production Order")
                {
                    Caption = 'Create Production Order';
                    Image = Production;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        SalesPlanLine.DELETEALL;
                        Quantity := CurrPage.SalesLines.PAGE.MakeLines(SalesLineRec);

                        FOR I := 1 TO Quantity
                          DO BEGIN
                            Qty := 1;
                            CreateOrders(Qty);
                        END;
                    end;
                }
            }
        }
        area(processing)
        {

            group("F&unctions")
            {
                Caption = 'F&unctions';
                separator(Action134)
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
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Codeunit 414;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;
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
                        ReleaseSalesDoc.Reopen(Rec);
                    end;
                }
                separator(Action1280002)
                {
                }
                action("Calculate Structure Values")
                {
                    Caption = 'Calculate Structure Values';
                    Image = CalculateSalesTax;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        // NAVIN
                        /*SalesLine.CalculateStructures(Rec);
                        SalesLine.AdjustStructureAmounts(Rec);
                        SalesLine.UpdateSalesLines(Rec);*/
                        // NAVIN
                    end;
                }
            }
            action("Make &Order")
            {
                Caption = 'Make &Order';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Codeunit "Blnkt Sales Ord. to Ord. (Y/N)";
                ApplicationArea = All;
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
        CurrPage.SAVERECORD;
        EXIT(Rec.ConfirmDeletion);
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        Rec.TESTFIELD(Status, Rec.Status::Open);
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec."Responsibility Center" := UserMgt.GetSalesFilter();
    end;

    trigger OnOpenPage();
    begin
        IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetSalesFilter());
            Rec.FILTERGROUP(0);
        END;
    end;

    var
        CurrentSalesLine: Record "Sales Line";
        SalesLine: Record "Sales Line";
        SaleShptLine: Record "Sales Shipment Line";
        SalesInvLine: Record "Sales Invoice Line";
        ReturnRcptLine: Record "Return Receipt Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        CopySalesDoc: Report 292;
        DocPrint: Codeunit 229;
        SalesSetup: Record "Sales & Receivables Setup";
        UserMgt: Codeunit 5700;
        "Mail-Id": Record User;
        "from Mail": Text[100];
        "to mail": Text[1000];
        Mail_Subject: Text[250];
        Mail_Body: Text[250];
        //mail: Codeunit Mail;
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
        //objEmailConf: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000002-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Configuration";
        //  objEmail: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000001-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Message";
        //        flds: Automation "'{00000205-0000-0010-8000-00AA006D2EA4}' 2.5:'{00000564-0000-0010-8000-00AA006D2EA4}':''{00000205-0000-0010-8000-00AA006D2EA4}' 2.5'.Fields";
        //   fld: Automation "'{00000205-0000-0010-8000-00AA006D2EA4}' 2.5:'{00000569-0000-0010-8000-00AA006D2EA4}':''{00000205-0000-0010-8000-00AA006D2EA4}' 2.5'.Field";
        SMTPSETUP: Record "Product Customer's List";
        ChangeExchangeRate: Page 511;


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

