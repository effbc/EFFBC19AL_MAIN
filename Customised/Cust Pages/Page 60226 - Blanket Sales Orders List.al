page 60226 "Blanket Sales Orders List"
{
    // version Rev01

    Caption = 'Blanket Sales Order';
    CardPageID = "Blanket Sales Order1";
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = FILTER("Blanket Order"), "Sale Order Created" = CONST(false));
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    ApplicationArea = All;
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
                /*
                field(Structure; Structure)
                {
                }*/
                field(Comment; Comment)
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
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                /* Caption = 'O&rder';
                 action(Statistics)
                 {
                     Caption = 'Statistics';
                     Image = Statistics;
                     ShortCutKey = 'F7';

                     trigger OnAction();
                     begin
                         CalcInvDiscForHeader;
                         SalesSetup.GET;
                         CALCFIELDS("Price Inclusive of Taxes");
                         IF SalesSetup."Calc. Inv. Discount" AND (NOT "Price Inclusive of Taxes") THEN BEGIN
                             CalcInvDiscForHeader;
                             COMMIT
                         END;
                         IF "Price Inclusive of Taxes" THEN BEGIN
                             SalesLine.InitStrOrdDetail(Rec);
                             SalesLine.GetSalesPriceExclusiveTaxes(Rec);
                             SalesLine.UpdateSalesLinesPIT(Rec);
                             COMMIT;
                         END;

                         IF Rec.Structure <> '' THEN BEGIN
                             SalesLine.CalculateStructures(Rec);
                             SalesLine.AdjustStructureAmounts(Rec);
                             SalesLine.UpdateSalesLines(Rec);
                             SalesLine.CalculateTCS(Rec);
                         END ELSE BEGIN
                             SalesLine.CalculateTCS(Rec);
                         END;
                         COMMIT;
                         PAGE.RUNMODAL(PAGE::"Sales Order Statistics", Rec);
                     end;
                 }*/
                action(Card)
                {
                    Caption = 'Card';
                    Image = Card;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = All;
                }
                action(Comments)
                {
                    Caption = 'Comments';
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
                    Image = Approvals;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        ApprovalEntries: Page 658;
                    begin
                        ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No.");
                        ApprovalEntries.RUN;
                    end;
                }
                /* action("St&ructure")
                 {
                     Caption = 'St&ructure';
                     Image = ItemVariant;
                     RunObject = Page "Structure Order Details";
                     RunPageLink = Type = CONST(Sale), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "Structure Code" = FIELD(Structure), "Document Line No." = FILTER(0);
                 }*/  //B2BUPG
            }
        }
    }

    trigger OnOpenPage();
    begin
        IF UserMgt.GetSalesFilter <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Responsibility Center", UserMgt.GetSalesFilter);
            FILTERGROUP(0);
        END;
    end;

    var
        CurrentSalesLine: Record "Sales Line";
        SalesLine: Record "Sales Line";
        SaleShptLine: Record "Sales Shipment Line";
        SalesInvLine: Record "Sales Invoice Line";
        ReturnRcptLine: Record "Return Receipt Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        ChangeExchangeRate: Page 511;
        CopySalesDoc: Report 292;
        DocPrint: Codeunit "Document-Print";
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
    //SMTP_MAIL: Codeunit "SMTP Mail";


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
}

