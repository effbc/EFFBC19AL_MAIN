report 50108 "Update TCS Opening Balances"
{
    Caption = 'Update TCS Opening Balances';
    Permissions = TableData "TCS Entry" = rim;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE("Tax Liable" = CONST(true), Blocked = CONST(" "));
            RequestFilterFields = "No.", "Customer Posting Group";

            trigger OnAfterGetRecord()
            begin
                CLEAR(TCSOpeningBal);
                /*NODLines.RESET;
                NODLines.SETRANGE(NODLines.Type, NODLines.Type::Customer);
                NODLines.SETRANGE("No.", Customer."No.");
                IF NOT NODLines.FINDFIRST THEN BEGIN
                    NonNODCustoemer := TRUE;
                    CurrReport.SKIP;

                END;*/

                TCSEntryExists.RESET;
                //TCSEntryExists.SETRANGE(TCSEntryExists."Party Type", TCSEntryExists."Party Type"::Customer);//B2BUpg
                TCSEntryExists.SETRANGE(TCSEntryExists."Customer No.", Customer."No.");
                TCSEntryExists.SETRANGE("Document No.", 'OB');
                IF TCSEntryExists.FINDFIRST THEN
                    CurrReport.SKIP;

                SalesInvoiceLine.RESET;
                SalesInvoiceLine.SETRANGE("Sell-to Customer No.", Customer."No.");
                SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::Item);
                SalesInvoiceLine.SETRANGE("Posting Date", DMY2DATE(1, 4, DATE2DMY(PostingDate, 3)), PostingDate);
                IF SalesInvoiceLine.FINDSET THEN BEGIN
                    SalesInvoiceLine.CALCSUMS("Amount Including VAT");
                    TCSOpeningBal := SalesInvoiceLine."Amount Including VAT";
                END;
                IF TCSOpeningBal > 0 THEN
                    InsertTCSEntry(Customer."No.", TCSOpeningBal);
            end;

            trigger OnPostDataItem()
            begin
                IF NonNODCustoemer THEN
                    MESSAGE('Customer without NOD/NOC Lines exists which are not updated')
                ELSE
                    MESSAGE('TCS Opening Balances updated');
            end;

            trigger OnPreDataItem()
            begin
                IF (PostingDate = 0D) OR (TCSNature = '') OR (AssessCode = '') OR (GLAccount = '') THEN
                    ERROR('Provide Mandatory values in the Request page');
                CLEAR(NonNODCustoemer);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Choose)
                {
                    field("TCS Closing Date"; PostingDate)
                    {
                        Importance = Promoted;
                        ApplicationArea = All;
                    }
                    field("G/L Account"; GLAccount)
                    {
                        TableRelation = "G/L Account"."No.";
                        ApplicationArea = All;
                    }
                    field("Assessee Code"; AssessCode)
                    {
                        TableRelation = "Assessee Code".Code;
                        ApplicationArea = All;
                    }
                    field("TCS Nature Of Collection"; TCSNature)
                    {
                        TableRelation = "TCS Nature Of Collection".Code;
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        //NODLines: Record "NOD/NOC Lines";//B2BUpg
        TCSOpeningBal: Decimal;
        PostingDate: Date;
        GLAccount: Code[20];
        AssessCode: Code[20];
        TCSNature: Code[20];
        Location: Record Location;
        TCSEntryExists: Record "TCS Entry";
        NonNODCustoemer: Boolean;

    local procedure InsertTCSEntry(CustomerCode: Code[20]; OpeningBal: Decimal)
    var
        InitTCSEntry: Record "TCS Entry";
        LastTCSEntry: Record "TCS Entry";
    begin
        LastTCSEntry.RESET;
        IF LastTCSEntry.FINDLAST THEN;
        IF Location.GET(Customer."Location Code") THEN;

        InitTCSEntry.INIT;
        InitTCSEntry."Entry No." := LastTCSEntry."Entry No." + 1;
        InitTCSEntry."Posting Date" := PostingDate;
        InitTCSEntry."Account Type" := InitTCSEntry."Account Type"::"G/L Account";
        InitTCSEntry.VALIDATE("Account No.", GLAccount);
        InitTCSEntry.VALIDATE("Assessee Code", AssessCode);
        InitTCSEntry.VALIDATE("T.C.A.N. No.", Location."T.C.A.N. No.");
        InitTCSEntry.VALIDATE("Account No.", GLAccount);
        InitTCSEntry.VALIDATE("TCS Nature of Collection", TCSNature);
        //InitTCSEntry.VALIDATE("TCS Type", InitTCSEntry."TCS Type"::"1H");//B2BUpg
        InitTCSEntry.VALIDATE("Document Type", InitTCSEntry."Document Type"::Invoice);
        InitTCSEntry.VALIDATE("Document No.", 'OB');
        InitTCSEntry.VALIDATE(Description, 'TCS Opening Balance Till ' + FORMAT(PostingDate));
        InitTCSEntry.VALIDATE("TCS Base Amount", OpeningBal);
        //InitTCSEntry.VALIDATE("Party Type", InitTCSEntry."Party Type"::Customer);
        InitTCSEntry.VALIDATE("Customer No.", CustomerCode);
        InitTCSEntry.VALIDATE("Invoice Amount", OpeningBal);
        InitTCSEntry.VALIDATE("Surcharge Base Amount", OpeningBal);
        InitTCSEntry.VALIDATE("Invoice Amount", OpeningBal);
        InitTCSEntry.INSERT(TRUE);
    end;
}

