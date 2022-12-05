page 60257 "Sales Due SD List"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    Permissions = TableData "Sales Invoice Header" = rm;
    SourceTable = "Sales Invoice Header";
    SourceTableTemporary = true;
    SourceTableView = SORTING("Order No.", "Posting Date") ORDER(Ascending);

    layout
    {
        area(content)
        {
            field("TotCaption+FORMAT(Rec.COUNT)"; TotCaption + FORMAT(Rec.COUNT))
            {
                ApplicationArea = All;
            }
            field(Color_Desc; Color_Desc)
            {
                ShowCaption = false;
                Style = Favorable;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field(Color_Desc1; Color_Desc1)
            {
                ShowCaption = false;
                Style = Ambiguous;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            repeater(Group)
            {
                field("SD Fin Verification"; Rec."SD Fin Verification")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF NOT (USERID IN ['EFFTRONICS\RAJANI', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\SUSMITHAL']) THEN BEGIN
                            ERROR('You Do Not Have a rights');
                        END;
                        IF Rec."Consignee Name" = 'New Running Order' THEN BEGIN
                            SH.RESET;
                            SH.SETRANGE(SH."No.", Rec."Order No.");
                            IF SH.FINDFIRST THEN BEGIN
                                SH."SD Fin Verification" := Rec."SD Fin Verification";
                                SH."BG Fin Status" := Rec."BG Fin Status";
                                SH.MODIFY;
                            END
                        END
                        ELSE BEGIN
                            SIH.RESET;
                            SIH.SETRANGE(SIH."Order No.", Rec."Order No.");
                            IF SIH.FINDSET THEN
                                REPEAT
                                    SIH."SD Fin Verification" := Rec."SD Fin Verification";
                                    SIH."BG Fin Status" := Rec."BG Fin Status";
                                    SIH.MODIFY;
                                UNTIL SIH.NEXT = 0;
                        END;

                        //'New Running Order'
                    end;
                }
                field("BG Fin Status"; Rec."BG Fin Status")
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    Editable = false;
                    StyleExpr = Color;
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    Editable = false;
                    StyleExpr = ColorFinlRlyBillDt;
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sales Person Name"; Rec."Posting Description")
                {
                    CaptionML = ENU = 'Sales Person Name',
                                ENN = 'Posting Description';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Warranty Period"; Rec."Warranty Period")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customer OrderNo."; Rec."Customer OrderNo.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customer Order Date"; Rec."Customer Order Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sale Order Total Amount"; Rec."Sale Order Total Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Security Deposit Amount"; Rec."Security Deposit Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("EMD Amount"; Rec."EMD Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("SD Paid Amount"; Rec."SD Paid Amount")
                {
                    ApplicationArea = All;
                }
                field("SD Received Amount"; Rec."SD Received Amount")
                {
                    ApplicationArea = All;
                }
                field("Security Deposit"; Rec."Security Deposit")
                {
                    Caption = 'SD Mode';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(SecDepStatus; Rec.SecDepStatus)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("SD Status"; Rec."SD Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Final Railway Bill Date"; Rec."Final Railway Bill Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    CaptionML = ENU = 'Remarks',
                                ENN = 'Reason Code';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        SIH.RESET;
                        SIH.SETCURRENTKEY("Order No.", "Posting Date");
                        SIH.SETRANGE(SIH."Order No.", Rec."Order No.");
                        IF SIH.FINDSET THEN
                            REPEAT
                                SIH.Remarks := Rec.Remarks;
                                SIH.MODIFY;
                            UNTIL SIH.NEXT = 0;
                        CurrPage.UPDATE;
                    end;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102152025; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Control1102152002; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        IF Rec.Remarks <> '' THEN
            Color := 'Favorable'
        ELSE
            Color := '';
        IF Rec."Final Railway Bill Date" = 0D THEN
            ColorFinlRlyBillDt := 'Ambiguous'
        ELSE
            ColorFinlRlyBillDt := '';
    end;

    trigger OnOpenPage();
    begin
        CurrPage.EDITABLE := TRUE;
        //DELETEALL;
        Rec.RESET;
        Rec.SETCURRENTKEY("Order No.");
        OrdersCount := 0;
        NextOrdersCnt := 0;
        LastOrder := '';
        SalesInvHdr.RESET;
        SalesInvHdr.SETCURRENTKEY("Order No.", "Posting Date");
        //SalesInvHdr.SETRANGE(SalesInvHdr.SecDepStatus,SalesInvHdr.SecDepStatus::Due);  Comment by vijaya on 03-Feb-2017
        //SalesInvHdr.SETFILTER(SalesInvHdr."SD Status",'Not Received');
        SalesInvHdr.SETFILTER(SalesInvHdr."Order No.", '<>%1', '');
        SalesInvHdr.SETFILTER(SalesInvHdr.SecDepStatus, '<>%1', SalesInvHdr.SecDepStatus::Received);
        SalesInvHdr.SETFILTER(SalesInvHdr."SD Status", '<>%1', SalesInvHdr."SD Status"::NA);
        IF SalesInvHdr.FINDSET THEN BEGIN
            REPEAT
                LastOrder := '';
                OrdersCount := 0;
                NextOrdersCnt := 0;

                SIH.RESET;
                SIH.SETCURRENTKEY("Order No.", "Posting Date");
                SIH.SETRANGE(SIH."Order No.", SalesInvHdr."Order No.");
                IF SIH.FINDLAST THEN
                    LastOrder := SIH."No.";

                IF SalesInvHdr."No." = LastOrder THEN BEGIN
                    Rec := SalesInvHdr;
                    Rec.INSERT;
                    IF COPYSTR(Rec."Order No.", 5, 3) = 'AMC' THEN BEGIN
                        Customer.RESET;
                        IF Customer.GET(Rec."Sell-to Customer No.") THEN BEGIN
                            ServiceZone.RESET;
                            ServiceZone.SETRANGE(ServiceZone.Code, Customer."Service Zone Code");
                            IF ServiceZone.FINDFIRST THEN BEGIN
                                Rec."Salesperson Code" := ServiceZone."Project Manager";
                                Rec.MODIFY;
                            END;
                        END;
                    END;
                    IF SP.GET(Rec."Salesperson Code") THEN BEGIN
                        Rec."Posting Description" := SP.Name;
                        Rec.MODIFY;
                    END;
                    Tot := Tot + 1;
                END;
            UNTIL SalesInvHdr.NEXT = 0;
        END;
        // added by vijaya on 04-May-2017

        Rec.RESET;
        SH.RESET;
        SH.SETRANGE(SH.Status, SH.Status::Released);
        SH.SETFILTER(SH."SD Status", '<>%1', SH."SD Status"::NA);
        //SH.SETFILTER(SH."Document Type", '%1|%2', SH."Document Type"::Amc, SH."Document Type"::Order);
        SH.SETFILTER(SH."Document Type", '%1', SH."Document Type"::Order);//EFFUPG1.5
        IF SH.FINDSET THEN
            REPEAT
                SIH.RESET;
                SIH.SETRANGE(SIH."Order No.", SH."No.");
                IF NOT (SIH.FINDFIRST) THEN BEGIN
                    Rec."SD Fin Verification" := SH."SD Fin Verification";
                    Rec."BG Fin Status" := SH."BG Fin Status";
                    Rec."No." := SH."No.";
                    Rec."Order No." := SH."No.";
                    Rec."Sell-to Customer No." := SH."Sell-to Customer No.";
                    Rec."Sell-to Customer Name" := SH."Sell-to Customer Name";
                    Rec."Customer Posting Group" := SH."Customer Posting Group";
                    //"Warranty Period" := "0Y";
                    Rec."Customer OrderNo." := SH."Customer OrderNo.";
                    Rec."Sale Order Total Amount" := SH."Sale Order Total Amount";
                    Rec."Consignee Name" := 'New Running Order';
                    Rec."Security Deposit Amount" := SH."Security Deposit Amount";
                    Rec."EMD Amount" := Rec."EMD Amount";
                    Rec."Security Deposit" := SH."Security Deposit";
                    Rec.SecDepStatus := SH.SecDepStatus;
                    Rec."SD Status" := SH."SD Status";
                    Rec."Final Railway Bill Date" := 0D;
                    Rec.Remarks := '';
                    Rec.INSERT;
                    IF COPYSTR(Rec."Order No.", 5, 3) = 'AMC' THEN BEGIN
                        Customer.RESET;
                        IF Customer.GET(Rec."Sell-to Customer No.") THEN BEGIN
                            ServiceZone.RESET;
                            ServiceZone.SETRANGE(ServiceZone.Code, Customer."Service Zone Code");
                            IF ServiceZone.FINDFIRST THEN BEGIN
                                Rec."Salesperson Code" := ServiceZone."Project Manager";
                                Rec.MODIFY;
                            END;
                        END;
                    END;
                    IF SP.GET(Rec."Salesperson Code") THEN BEGIN
                        Rec."Posting Description" := SP.Name;
                        Rec.MODIFY;
                    END;
                    Tot := Tot + 1;
                END;
            UNTIL SH.NEXT = 0;

        // end by vijaya on 04-May-2017
    end;

    var
        Tot: Integer;
        LastOrder: Code[20];
        SIH: Record "Sales Invoice Header";
        OrdersCount: Integer;
        NextOrdersCnt: Integer;
        SalesInvHdr: Record "Sales Invoice Header";
        Color: Text[20];
        TotCaption: Label '"Total Orders : "';
        ColorFinlRlyBillDt: Text[20];
        Color_Desc: Label 'Remarks Updated!';
        Color_Desc1: Label 'Final Railway Bill Date Not Updated!';
        Customer: Record Customer;
        ServiceZone: Record "Service Zone";
        SP: Record "Salesperson/Purchaser";
        SH: Record "Sales Header";
}

