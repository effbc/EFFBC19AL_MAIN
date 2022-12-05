pageextension 70274 SalesCommentSheetExt extends 67
{
    layout
    {
        modify(Date)
        {
            Editable = Editable;
        }
        modify(Comment)
        {
            Editable = Editable;
            trigger OnBeforeValidate()
            begin
                Rec."User ID" := USERID;
            end;
        }
        addafter(Code)
        {
            field("User ID"; Rec."User ID")
            {
                Editable = FALSE;
                ApplicationArea = All;
            }
            field("Responsible Person"; Rec."Responsible Person")
            {
                Editable = Editable;
                ApplicationArea = All;
            }
            field(Status; Rec.Status)
            {
                Editable = Editable;
                ApplicationArea = All;
            }
            field("Exp Completion Date"; Rec."Exp Completion Date")
            {
                Editable = Editable;
                ApplicationArea = All;
            }
            field(Priority; Rec.Priority)
            {
                Editable = Editable;
                ApplicationArea = All;
            }
            field(Product; Rec.Product)
            {
                Editable = Editable;
                ApplicationArea = All;
            }
            field("Customer Number"; Rec."Customer Number")
            {
                Editable = Editable;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    Cust.GET(Rec."Customer Number");
                    Rec."Customer Name" := Cust.Name;
                end;
            }
            field("Customer Name"; Rec."Customer Name")
            {
                Editable = Editable;
                ApplicationArea = All;
            }
            field("Remainder Date"; Rec."Remainder Date")
            {
                Editable = Editable;
                ApplicationArea = All;
            }
            field("Quote Status"; Rec."Quote Status")
            {
                Editable = Editable;
                ApplicationArea = All;
            }
            field(Convert; Rec.Convert)
            {
                Editable = Editable;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    IF Rec.Convert THEN BEGIN
                        CheckAlreadyconverted_Order;
                        IF Rec."Quote Status" <> Rec."Quote Status"::Win THEN
                            ERROR('First select the Quote Status');
                        MakeToBlanketOrder;
                        //MESSAGE('Enabled');

                    END
                    ELSE
                        ERROR('You can''t disable the already converted Order');
                end;
            }
            field("Converted Order Number"; Rec."Converted Order Number")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }

    }

    actions
    {

    }

    trigger OnOpenPage()
    begin
        SalesComment.RESET;
        SalesComment.SETRANGE("No.", Rec."No.");
        SalesComment.SETRANGE(Convert, TRUE);
        IF SalesComment.FINDFIRST THEN
            Editable := FALSE
        ELSE
            Editable := TRUE;
    end;

    trigger OnAfterGetRecord()
    begin
        SalesComment.RESET;
        SalesComment.SETRANGE("No.", Rec."No.");
        SalesComment.SETRANGE(Convert, TRUE);
        IF SalesComment.FINDFIRST THEN
            Editable := FALSE
        ELSE
            Editable := TRUE;
    end;

    var
        Editable: Boolean;
        Cust: Record Customer;
        NoSeriesMgt: Codeunit 396;
        SRSetup: Record "Sales & Receivables Setup";
        SalesLine2: Record "Sales Line";
        SalHdr: Record "Sales Header";
        Attach: Record Attachment;
        "Mail-Id": Record User;
        "from Mail": Text[100];
        "to mail": Text[1000];
        Mail_Subject: Text[1000];
        Mail_Body: Text[1000];
       // mail: Codeunit 397;
        charline: Char;
        SalesComment: Record "Sales Comment Line";
        SalesHeadRec: Record "Sales Header";
        Text050: Label 'Do you want to Short Close the Order No. %1';
        OrderStatusValue: Text[30];
        ArchiveManagement: Codeunit 5063;

    PROCEDURE MakeToBlanketOrder();
    VAR
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
    BEGIN
        Rec.TESTFIELD("Customer Number");
        IF NOT CONFIRM(Text005, FALSE) THEN
            EXIT;
        SalesHeader.INIT;
        SalesHeader."Document Type" := SalesHeader."Document Type"::"Blanket Order";
        SRSetup.GET;
        SalesHeader."No." := NoSeriesMgt.GetNextNo(SRSetup."Blanket Order Nos.", WORKDATE, TRUE);
        Cust.GET(Rec."Customer Number");
        Cust.CheckBlockedCustOnDocs(Cust, SalesHeader."Document Type"::"Blanket Order", TRUE, FALSE);
        SalesHeadRec.RESET;
        SalesHeadRec.SETRANGE("No.", Rec."No.");
        IF SalesHeadRec.FINDFIRST THEN BEGIN
            SalesHeader."Customer OrderNo." := SalesHeadRec."Customer OrderNo.";
            SalesHeader.Vertical := SalesHeadRec.Vertical;
            SalesHeader."Railway Division" := SalesHeadRec."Railway Division";
            SalesHeader."Requested Delivery Date" := SalesHeadRec."Requested Delivery Date";
            SalesHeader.Remarks := 'IREPS ORDER-' + FORMAT(SalesHeadRec."No.");
        END;
        SalesHeader."Sell-to Customer No." := Rec."Customer Number";
        SalesHeader.VALIDATE(SalesHeader."Sell-to Customer No.");
        SalesHeader.Product := Rec.Product;
        MESSAGE('Blanket Order No is %1  created', SalesHeader."No.");
        SalesHeader.INSERT;
        Rec."Converted Order Number" := SalesHeader."No.";
        Rec.MODIFY;
        SalesLine2.SETRANGE("Document No.", Rec."No.");
        IF SalesLine2.FINDSET THEN
            REPEAT
                SalesLine.INIT;
                SalesLine."Document Type" := SalesLine2."Document Type"::"Blanket Order";
                SalesLine."Document No." := SalesHeader."No.";
                SalesLine."Line No." := SalesLine."Line No." + 10000;
                SalesLine."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                SalesLine."Schedule No" := SalesLine2."Schedule No";
                SalesLine."Type of Item" := SalesLine2."Type of Item";

                IF SalesLine.Type = SalesLine2.Type::Item THEN BEGIN
                    SalesLine.Type := SalesLine.Type::Item;
                    SalesLine.Description := SalesLine2.Description;
                    SalesLine."Description 2" := SalesLine2."Description 2";
                END;
                IF SalesLine2.Type = SalesLine2.Type::Item THEN BEGIN
                    SalesLine.Type := SalesLine.Type::Item;
                    SalesLine.VALIDATE("Tax Group Code", SalesLine2."Tax Group Code");
                END;
                IF SalesLine2.Type = SalesLine2.Type::Resource THEN BEGIN
                    SalesLine.Type := SalesLine.Type::Resource;
                END;
                IF SalesLine2.Type = SalesLine2.Type::"G/L Account" THEN BEGIN
                    SalesLine.Type := SalesLine.Type::"G/L Account";
                END;
                IF SalesLine."Document Type" = SalesLine."Document Type"::Order THEN BEGIN
                    SalHdr.RESET;
                    SalHdr.SETRANGE(SalHdr."No.", SalesLine."Document No.");
                    IF SalHdr.FINDFIRST THEN
                        IF SalHdr."Customer Posting Group" IN ['PRIVATE', 'OTHERS'] THEN
                            IF SalesLine.Type = SalesLine.Type::Item THEN BEGIN
                                SalesLine."Supply Portion" := 100;
                                SalesLine."Retention Portion" := 0;
                            END ELSE BEGIN
                                SalesLine."Supply Portion" := 0;
                                SalesLine."Retention Portion" := 100;
                            END;
                END;

                SalesLine."No." := SalesLine2."No.";
                SalesLine.VALIDATE(SalesLine."No.");
                SalesLine.Quantity := SalesLine2.Quantity;
                SalesLine.VALIDATE(SalesLine.Quantity);
                SalesLine."Unitcost(LOA)" := SalesLine2."Unitcost(LOA)";
                SalesLine."Line Amount" := SalesLine2."Line Amount";
                SalesLine."Unit Cost (LCY)" := SalesLine2."Unit Cost (LCY)";
                SalesLine.INSERT;

            UNTIL SalesLine2.NEXT = 0;
        SalesHeader.RESET;
        SalesHeader.SETRANGE("No.", Rec."No.");
        IF SalesHeader.FINDFIRST THEN BEGIN
            SalesHeader.Status := SalesHeader.Status::Closed;
            SalesHeader.MODIFY;
        END;

        IF CONFIRM(Text050, FALSE, Rec."No.") THEN BEGIN
            OrderStatusValue := 'Close';
            CancelCloseOrder(OrderStatusValue, SalesHeader);
            CurrPage.UPDATE(FALSE);
        END;

        //comented by anil120411
        //OMSIntegration.TendertoBlanketorOrder(SalesHeader."No." ,1,"Tender No.",0);

        //OMS integration
    END;


    PROCEDURE CheckAlreadyconverted_Order();
    VAR
        SalesCmt: Record "Sales Comment Line";
    BEGIN
        SalesCmt.RESET;
        SalesCmt.SETRANGE("No.", Rec."No.");
        IF SalesCmt.FINDSET THEN
            REPEAT
                IF SalesCmt.Convert = TRUE THEN
                    ERROR('Already converted for this balnket order');
            UNTIL SalesCmt.NEXT = 0;
    END;


    LOCAL PROCEDURE ShortClose();
    BEGIN
    END;


    PROCEDURE CancelCloseOrder(VAR OrderStatus: Text[50]; VAR SalesHeader: Record "Sales Header");
    VAR
        CancelShortClose: Text[50];
        SalesLine: Record "Sales Line";
        SalesShipLine: Record "Sales Shipment Line";
        Text050: Label 'You cannot Canel/Short Close the order,Invoice is pending for Line No. %1 and Item No. %2';
    BEGIN

        SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(SalesLine."Document Type", SalesHeader."Document Type");
        IF SalesLine.FIND('-') THEN BEGIN
            REPEAT
                SalesLine.INIT;
                SalesShipLine.SETCURRENTKEY("Order No.", "Order Line No."); //anil added 30-07-12
                SalesShipLine.SETRANGE(SalesShipLine."Order No.", SalesLine."Document No.");
                SalesShipLine.SETRANGE(SalesShipLine."Order Line No.", SalesLine."Line No.");
                IF SalesShipLine.FIND('-') THEN BEGIN
                    IF (SalesShipLine."Qty. Shipped Not Invoiced" <> 0) AND (Rec.Product <> 'SPARES') THEN
                        ERROR(Text050, SalesShipLine."Order Line No.", SalesShipLine."No.");
                END;
            UNTIL SalesLine.NEXT = 0;  //anil added this line
                                       // UNTIL SalesShipLine.NEXT=0;
        END;

        // Code for the Short close
        IF OrderStatus = 'Close' THEN BEGIN
            SalesHeader."Cancel Short Close" := SalesHeader."Cancel Short Close"::"Short Closed";
            Rec.MODIFY;
        END;
        IF OrderStatus = 'Cancel' THEN BEGIN
            SalesHeader."Cancel Short Close" := SalesHeader."Cancel Short Close"::Cancelled;
            Rec.MODIFY;
        END;
        ArchiveManagement.ArchiveSalesDocument(SalesHeader);

        SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(SalesLine."Document Type", SalesHeader."Document Type");
        IF SalesLine.FIND('-') THEN BEGIN
            REPEAT
                SalesLine.DELETE;
            UNTIL SalesLine.NEXT = 0;
        END;
        SalesHeader.DELETE;
        // Code for the Short close
    END;
}