pageextension 70090 ItemVendorCatalogExt extends 114
{
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        } */
        addafter("Vendor Item No.")
        {
            field("Minimum Order Quantity"; Rec."Minimum Order Quantity")
            {
                ApplicationArea = All;
            }
            field(Priority; Rec.Priority)
            {
                ApplicationArea = All;
            }
            field("Total Qty. Supplied"; Rec."Total Qty. Supplied")
            {
                ApplicationArea = All;
            }
            field("Qty. Supplied With in DueDate"; Rec."Qty. Supplied With in DueDate")
            {
                ApplicationArea = All;

                trigger OnDrillDown();
                var
                    PurchRcptHeader1: Record "Purch. Rcpt. Header";
                    PurchRcptLine1: Record "Purch. Rcpt. Line";
                begin
                    /*
                    PurchRcptHeader1.RESET;
                    PurchRcptHeader1.SETRANGE("Buy-from Vendor No.","Vendor No.");
                    IF PurchRcptHeader1.FINDFIRST THEN BEGIN
                      PurchRcptLine1.RESET;
                      PurchRcptLine1.SETRANGE("Document No.",PurchRcptHeader1."No.");
                      PurchRcptLine1.SETRANGE(Type,PurchRcptLine1.Type::Item);
                      PurchRcptLine1.SETRANGE("No.","Item No.");
                      IF PurchRcptLine1.FINDSET THEN BEGIN
                        REPEAT
                          IF PurchRcptHeader1."Posting Date" < PurchRcptLine1."Expected Receipt Date" THEN
                            PurchRcptLine1.MARK(TRUE);
                        UNTIL PurchRcptLine1.NEXT = 0;
                      END;
                      PurchRcptLine1.MARKEDONLY(TRUE);
                      Page.RUNMODAL(0,PurchRcptLine1);
                    END;
                    */
                    PurchRcptLine.MARKEDONLY(TRUE);
                    PAGE.RUNMODAL(0, PurchRcptLine);

                end;
            }
            field("Sampling Plan Code"; Rec."Sampling Plan Code")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {


    }

    trigger OnAfterGetRecord()
    begin
        Rec."Qty. Supplied With in DueDate" := 0;
        PurchRcptHeader.SETRANGE("Buy-from Vendor No.", Rec."Vendor No.");
        IF PurchRcptHeader.FINDSET THEN
            REPEAT
                PurchRcptLine.SETRANGE("Document No.", PurchRcptHeader."No.");
                PurchRcptLine.SETRANGE(Type, PurchRcptLine.Type::Item);
                PurchRcptLine.SETRANGE("No.", Rec."Item No.");
                IF PurchRcptLine.FINDSET THEN
                    REPEAT
                        IF PurchRcptHeader."Posting Date" < PurchRcptLine."Expected Receipt Date" THEN BEGIN
                            Rec."Qty. Supplied With in DueDate" := Rec."Qty. Supplied With in DueDate" + PurchRcptLine.Quantity;
                            PurchRcptLine.MARK(TRUE);
                        END;
                    UNTIL PurchRcptLine.NEXT = 0;
            UNTIL PurchRcptHeader.NEXT = 0;
    end;

    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
}

