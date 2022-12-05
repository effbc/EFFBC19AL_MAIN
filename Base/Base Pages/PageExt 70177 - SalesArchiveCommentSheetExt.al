pageextension 70177 SalesArchiveCommentSheetExt extends "Sales Archive Comment Sheet"
{


    layout
    {



        /* modify("Control1")
         {



             ShowCaption = false;
         }*/



        addafter(Comment)
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
            }
            field("Responsible Person"; Rec."Responsible Person")
            {
                ApplicationArea = All;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
            }
            field("Exp Completion Date"; Rec."Exp Completion Date")
            {
                ApplicationArea = All;
            }
            field(Priority; Rec.Priority)
            {
                ApplicationArea = All;
            }
            field(Product; Rec.Product)
            {
                ApplicationArea = All;
            }
            field("Customer Number"; Rec."Customer Number")
            {
                ApplicationArea = All;
            }
            field("Customer Name"; Rec."Customer Name")
            {
                ApplicationArea = All;
            }
            field("Remainder Date"; Rec."Remainder Date")
            {
                ApplicationArea = All;
            }
            field("Quote Status"; Rec."Quote Status")
            {
                ApplicationArea = All;
            }
            field(Convert; Rec.Convert)
            {
                ApplicationArea = All;
            }
            field("Converted Order Number"; Rec."Converted Order Number")
            {
                ApplicationArea = All;
            }
        }
    }

    var
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
        //mail: Codeunit Mail;
        charline: Char;
        Editable: Boolean;
        SalesComment: Record "Sales Comment Line";


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
        Rec.TESTFIELD("Customer Number");
        IF NOT CONFIRM(Text005, FALSE) THEN
            EXIT;
        SalesHeader.INIT;
        SalesHeader."Document Type" := SalesHeader."Document Type"::"Blanket Order";
        SRSetup.GET;
        SalesHeader."No." := NoSeriesMgt.GetNextNo(SRSetup."Blanket Order Nos.", WORKDATE, TRUE);
        Cust.GET(Rec."Customer Number");
        Cust.CheckBlockedCustOnDocs(Cust, SalesHeader."Document Type"::"Blanket Order", TRUE, FALSE);
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


        //comented by anil120411
        //OMSIntegration.TendertoBlanketorOrder(SalesHeader."No." ,1,"Tender No.",0);

        //OMS integration
    end;


    procedure CheckAlreadyconverted_Order();
    var
        SalesCmt: Record "Sales Comment Line";
    begin
        SalesCmt.RESET;
        SalesCmt.SETRANGE("No.", Rec."No.");
        IF SalesCmt.FINDSET THEN
            REPEAT
                IF SalesCmt.Convert = TRUE THEN
                    ERROR('Already converted for this balnket order');
            UNTIL SalesCmt.NEXT = 0;
    end;



}

