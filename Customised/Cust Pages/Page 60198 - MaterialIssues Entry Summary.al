page 60198 "MaterialIssues Entry Summary"
{
    // version MI1.0

    Editable = false;
    PageType = List;
    SourceTable = "Mat.Issue Entry Summary";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            field("COUNT"; Rec.COUNT)
            {
                ApplicationArea = All;
            }
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Total Quantity"; Rec."Total Quantity")
                {
                    ApplicationArea = All;
                }
                field("Total Reserved Quantity"; Rec."Total Reserved Quantity")
                {
                    ApplicationArea = All;
                }
                field("Total Available Quantity"; Rec."Total Available Quantity")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(USERID; Rec.USERID)
                {
                    ApplicationArea = All;
                }
                field(SalorderNo; SalorderNo)
                {
                    Caption = 'Sales order No';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        CLEAR(SalorderNo);
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETRANGE("Item No.", Rec."Item No.");
        ItemLedgerEntry.SETRANGE("Document Type", ItemLedgerEntry."Document Type"::"Purchase Receipt");
        ItemLedgerEntry.SETRANGE("Lot No.", Rec."Lot No.");
        ItemLedgerEntry.SETRANGE("Serial No.", Rec."Serial No.");
        IF ItemLedgerEntry.FINDFIRST THEN BEGIN
            IF PurchRcptHeader.GET(ItemLedgerEntry."Document No.") THEN
                IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, PurchRcptHeader."Order No.") THEN
                    SalorderNo := PurchaseHeader."Sale Order No";
        END;
    end;

    trigger OnClosePage();
    begin
        //EFFMatIssue>>

        /*
         MIEntrySummary.RESET;
         IF MIEntrySummary.FINDFIRST THEN
             MIEntrySummary.DELETEALL;
             */
        //EFFMatIssue<<

    end;

    trigger OnOpenPage();
    begin
        //  SETFILTER("Total Available Quantity",'>%1',0);
        Rec.SETCURRENTKEY("Lot No.", "Serial No.");
    end;

    var
        MIEntrySummary: Record "Mat.Issue Entry Summary";
        ItemLedgerEntry: Record "Item Ledger Entry";
        SalorderNo: Code[30];
        SalesShipmentHeader: Record "Sales Shipment Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchaseHeader: Record "Purchase Header";
}

