codeunit 80810 "Transfer Vat Data To Main Tab."
{
    // version B2Bupg


    trigger OnRun();
    begin
        Window.OPEN('Table Name#1####################');
        //UpdateSalesLine;
        //UpdatePurchLine;
        UpdatePurchInvLine;
        UpdateSalesInvLine;
        UpdatePurchCredmLine;
        UpdateSalesCredmLine;
        MESSAGE('finished');
    end;

    var
        Window: Dialog;


    procedure UpdateSalesLine();
    var
        SalesLineVat: Record "Sales Line Vat";
        SalesLine: Record "Sales Line";
    begin
        Window.UPDATE(1, 'Sales Line');
        SalesLineVat.RESET;
        SalesLineVat.SETFILTER("Vat Amount", '>0');
        IF SalesLineVat.FINDSET THEN
            REPEAT
                IF SalesLine.GET(SalesLineVat."Document Type",
                    SalesLineVat."Document No.", SalesLineVat."Line No.")
                THEN BEGIN
                    //SalesLine.TESTFIELD("Tax Amount", 0);
                    //SalesLine."Tax %" := SalesLineVat."Vat %age";
                    // SalesLine."Tax Base Amount" := SalesLineVat."Vat Base";
                    // SalesLine."Tax Amount" := SalesLineVat."Vat Amount";
                    SalesLine."Tax Area Code" := 'SALES VAT';
                    SalesLine.MODIFY;
                END;
            UNTIL SalesLineVat.NEXT = 0;
    end;


    procedure UpdatePurchLine();
    var
        PurchLineVat: Record "Purch Line Vat";
        PurchLine: Record "Purchase Line";
    begin
        Window.UPDATE(1, 'Purchase Line');
        PurchLineVat.RESET;
        PurchLineVat.SETFILTER("Vat Amount", '>0');
        IF PurchLineVat.FINDSET THEN
            REPEAT
                IF PurchLine.GET(PurchLineVat."Document Type",
                    PurchLineVat."Document No.", PurchLineVat."Line No.")
                THEN BEGIN
                    // PurchLine.TESTFIELD("Tax Amount", 0);
                    // PurchLine."Tax %" := PurchLineVat."Vat %age";
                    // PurchLine."Tax Base Amount" := PurchLineVat."Vat Base";
                    // PurchLine."Tax Amount" := PurchLineVat."Vat Amount";
                    PurchLine."Tax Area Code" := 'PUCH VAT';
                    PurchLine.MODIFY;
                END;
            UNTIL PurchLineVat.NEXT = 0;
    end;


    procedure UpdatePurchInvLine();
    var
        PurchInvLineVat: Record "PurchInvLine Vat";
        PurchInvLine: Record "Purch. Inv. Line";
    begin
        Window.UPDATE(1, 'Purchase Invoice Line');
        PurchInvLineVat.RESET;
        PurchInvLineVat.SETFILTER("Vat Amount", '>0');
        IF PurchInvLineVat.FINDSET THEN
            REPEAT
                IF PurchInvLine.GET(PurchInvLineVat."Document No.", PurchInvLineVat."Line No.") THEN BEGIN
                    //PurchInvLine.TESTFIELD("Tax Amount",0);
                    //PurchInvLine."Tax %" := PurchInvLineVat."Vat %age";
                    //PurchInvLine."Tax Base Amount" := PurchInvLineVat."Vat Base";
                    // PurchInvLine."Tax Amount" := PurchInvLineVat."Vat Amount";
                    PurchInvLine."Tax Area Code" := 'PUCH VAT';
                    PurchInvLine.MODIFY;
                END;
            UNTIL PurchInvLineVat.NEXT = 0;
    end;


    procedure UpdateSalesInvLine();
    var
        SalesInvLineVat: Record "SalesInvLine Vat";
        SalesInvLine: Record "Sales Invoice Line";
    begin
        Window.UPDATE(1, 'Sales Invoice Line');
        SalesInvLineVat.RESET;
        SalesInvLineVat.SETFILTER("Vat Amount", '>0');
        IF SalesInvLineVat.FINDSET THEN
            REPEAT
                IF SalesInvLine.GET(SalesInvLineVat."Document No.", SalesInvLineVat."Line No.") THEN BEGIN
                    //SalesInvLine.TESTFIELD("Tax Amount", 0);
                    //SalesInvLine."Tax %" := SalesInvLineVat."Vat %age";
                    //SalesInvLine."Tax Base Amount" := SalesInvLineVat."Vat Base";
                    // SalesInvLine."Tax Amount" := SalesInvLineVat."Vat Amount";
                    SalesInvLine."Tax Area Code" := 'SALES VAT';
                    SalesInvLine.MODIFY;
                END;
            UNTIL SalesInvLineVat.NEXT = 0;
    end;


    procedure UpdatePurchCredmLine();
    var
        PurchCredmLineVat: Record "PurchCredmLine Vat";
        PurchCredmLine: Record "Purch. Cr. Memo Line";
    begin
        Window.UPDATE(1, 'Purchase Credit Memo Line');
        PurchCredmLineVat.RESET;
        PurchCredmLineVat.SETFILTER("Vat Amount", '>0');
        IF PurchCredmLineVat.FINDSET THEN
            REPEAT
                IF PurchCredmLine.GET(PurchCredmLineVat."Document No.", PurchCredmLineVat."Line No.") THEN BEGIN
                    // PurchCredmLine.TESTFIELD("Tax Amount", 0);
                    // PurchCredmLine."Tax %" := PurchCredmLineVat."Vat %age";
                    // PurchCredmLine."Tax Base Amount" := PurchCredmLineVat."Vat Base";
                    //  PurchCredmLine."Tax Amount" := PurchCredmLineVat."Vat Amount";
                    PurchCredmLine."Tax Area Code" := 'PUCH VAT';
                    PurchCredmLine.MODIFY;
                END;
            UNTIL PurchCredmLineVat.NEXT = 0;
    end;


    procedure UpdateSalesCredmLine();
    var
        SalesCredmLineVat: Record "SalesCredmLine Vat";
        SalesCredmLine: Record "Sales Cr.Memo Line";
    begin
        Window.UPDATE(1, 'Sales Credit Memo Line');
        SalesCredmLineVat.RESET;
        SalesCredmLineVat.SETFILTER("Vat Amount", '>0');
        IF SalesCredmLineVat.FINDSET THEN
            REPEAT
                IF SalesCredmLine.GET(SalesCredmLineVat."Document No.", SalesCredmLineVat."Line No.") THEN BEGIN
                    // SalesCredmLine."Tax %" := SalesCredmLineVat."Vat %age";
                    // SalesCredmLine."Tax Base Amount" := SalesCredmLineVat."Vat Base";
                    // SalesCredmLine."Tax Amount" := SalesCredmLineVat."Vat Amount";
                    SalesCredmLine."Tax Area Code" := 'SALES VAT';
                    SalesCredmLine.MODIFY;
                END;
            UNTIL SalesCredmLineVat.NEXT = 0;
    end;
}

