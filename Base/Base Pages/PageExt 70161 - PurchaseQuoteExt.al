pageextension 70161 PurchaseQuoteExt extends "Purchase Quote"
{
    layout
    {
        modify("Buy-from Post Code")
        {
            Caption = 'Buy-from Post Code/City';
        }
        modify("Pay-to Post Code")
        {
            Caption = 'Pay-to Post Code/City';
        }
        modify("Ship-to Post Code")
        {
            CaptionML = ENU = 'Ship-to Post Code/City';
        }
        addafter("Responsibility Center")
        {
            field("RFQ No."; Rec."RFQ No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Ship-to Contact")
        {
            field("MSPT Date"; Rec."MSPT Date")
            {
                ApplicationArea = All;
            }
            field("MSPT Code"; Rec."MSPT Code")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(Statistics)
        {
            Promoted = true;
        }
        modify(Approve)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Reject)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Delegate)
        {
            Promoted = true;
        }
        modify(Comment)
        {
            Promoted = true;
        }
        modify(Print)
        {
            Promoted = true;
            trigger OnAfterAction()
            begin
                PurchHeader.SETRANGE(PurchHeader."No.", Rec."No.");
                REPORT.RUN(50059, TRUE, FALSE, PurchHeader);
            end;
        }

        modify(CopyDocument)
        {

            Promoted = true;
        }
        addafter(Approvals)
        {
            separator(Action1102152007)
            {
            }
            action("&MSPT Order Details")
            {
                Caption = '&MSPT Order Details';
                RunObject = Page "MSPT Order Details";
                RunPageLink = Type = CONST(Purchase), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "MSPT Header Code" = FIELD("MSPT Code"), "Party Type" = CONST(Vendor), "Party No." = FIELD("Buy-from Vendor No.");
                ApplicationArea = All;
            }
        }
        addfirst("Make Order")
        {
            separator(Action1102152003)
            {
            }
            action("Quotation Comparision Statement")
            {
                Caption = 'Quotation Comparision Statement';
                ApplicationArea = All;

                trigger OnAction();
                var
                    PurchaseLine: Record "Purchase Line";
                    PurchaseHeader: Record "Purchase Header";
                    Quotation: Record "Delivery Ratings";
                    //Structure: Record "Structure Order Line Details";
                    InventorySetup: Record "Inventory Setup";
                    Comment: Record "Purch. Comment Line";
                    Window: Dialog;
                    QCSHeader: Record "QCS Header";
                    QCSLine: Record "QCS Line";
                    PurchCommentLine: Record "Purch. Comment Line";
                    PurchLine: Record "Purchase Line";
                begin
                    /*
                    TESTFIELD("RFQ No.");
                    Window.OPEN('#1###########################');
                    InventorySetup.FINDFIRST;
                    
                    Quotation.DELETEALL;
                    QCSHeader.DELETEALL;
                    QCSLine.DELETEALL;
                    
                    PurchaseHeader.SETRANGE(PurchaseHeader."Document Type",PurchaseHeader."Document Type"::Quote);
                    PurchaseHeader.SETRANGE(PurchaseHeader."RFQ No.","RFQ No.");
                    IF PurchaseHeader.FINDSET THEN
                      REPEAT
                        QCSHeader.INIT;
                        QCSHeader."RFQ No." := "RFQ No.";
                        QCSHeader."Quote No." := PurchaseHeader."No.";
                        QCSHeader."RFQ Date" :=PurchaseHeader."Document Date";
                        QCSHeader."Vendor No.":=PurchaseHeader."Buy-from Vendor No.";
                        QCSHeader."Vendor Name":=PurchaseHeader."Buy-from Vendor Name";
                    
                        //KNR
                        PurchCommentLine.SETRANGE(PurchCommentLine."Document Type",PurchaseHeader."Document Type");
                        PurchCommentLine.SETRANGE(PurchCommentLine."No.",PurchaseHeader."No.");
                        IF PurchCommentLine.FINDSET THEN
                          REPEAT
                           QCSHeader."PD Comment" := QCSHeader."PD Comment" + PurchCommentLine.Comment;
                          UNTIL (PurchCommentLine.NEXT=0) AND (STRLEN(QCSHeader."PD Comment")<=200);
                        //KNR
                    
                        QCSHeader.INSERT;
                    
                      PurchLine.SETRANGE("Document Type","Document Type");
                      PurchLine.SETRANGE("Document No.","No.");
                      PurchLine.SETFILTER(Type,'%1|%2|%3',PurchLine.Type::Item,PurchLine.Type::"G/L Account",PurchLine.Type::"Fixed Asset");
                      IF PurchLine.FINDFIRST THEN BEGIN
                    
                        PurchaseLine.SETRANGE(PurchaseLine."Document Type",PurchaseHeader."Document Type");
                        PurchaseLine.SETRANGE(PurchaseLine."Document No.",PurchaseHeader."No.");
                        IF PurchaseLine.FINDSET THEN
                          REPEAT
                            Quotation.INIT;
                            QCSLine.INIT;
                            Window.UPDATE(1,PurchaseLine."No.");
                            //Quotation."Minumum Value":="RFQ No.";
                    //        Quotation."Quote No.":=PurchaseHeader."No.";
                            Quotation."Line No.":=PurchaseLine."Line No.";
                            Quotation."Maximum Value":=PurchaseHeader."Document Date";
                            Quotation.Rating:=PurchaseHeader."Buy-from Vendor No.";
                            Quotation."Vendor Name":=PurchaseHeader."Buy-from Vendor Name";
                    
                            Quotation."Item No.":=PurchaseLine."No.";
                            Quotation.Desicription:=PurchaseLine.Description;
                            Quotation.Quantity:=PurchaseLine.Quantity;
                            Quotation.Rate:=PurchaseLine."Direct Unit Cost";
                            Quotation.Amount:=PurchaseLine."Direct Unit Cost"*PurchaseLine.Quantity;
                            Quotation."Payment Terms":=PurchaseHeader."Payment Terms Code";
                            Quotation."Delivery Date":=PurchaseLine."Promised Receipt Date";
                            {
                            Structure.RESET;
                            Structure.SETRANGE(Structure.Type,Structure.Type::Purchase);
                            Structure.SETRANGE(Structure."Document Type",PurchaseLine."Document Type"::Quote);
                            Structure.SETRANGE(Structure."Line No.",PurchaseLine."Line No.");
                            Structure.SETRANGE(Structure."Tax/Charge Group",InventorySetup."Packing Charge Group");
                            Structure.SETRANGE(Structure."Document No.",PurchaseHeader."No.");
                            IF Structure.FINDSET THEN
                              REPEAT
                                 Quotation."P & F" := Structure.Amount
                              UNTIL Structure.NEXT=0;
                            }
                            Structure.RESET;
                            Structure.SETRANGE(Structure.Type,Structure.Type::Purchase);
                            Structure.SETRANGE(Structure."Document Type",PurchaseLine."Document Type"::Quote);
                            Structure.SETRANGE(Structure."Line No.",PurchaseLine."Line No.");
                            Structure.SETRANGE(Structure."Tax/Charge Type",Structure."Tax/Charge Type"::Excise);
                            Structure.SETRANGE(Structure."Document No.",PurchaseHeader."No.");
                            IF Structure.FINDSET THEN
                              REPEAT
                                Quotation."Excise Duty" := Structure.Amount;
                              UNTIL Structure.NEXT=0;
                    
                            Structure.RESET;
                            Structure.SETRANGE(Structure.Type,Structure.Type::Purchase);
                            Structure.SETRANGE(Structure."Document Type",PurchaseLine."Document Type"::Quote);
                            Structure.SETRANGE(Structure."Line No.",PurchaseLine."Line No.");
                            Structure.SETRANGE(Structure."Tax/Charge Type",Structure."Tax/Charge Type"::"Sales Tax");
                            Structure.SETRANGE(Structure."Document No.",PurchaseHeader."No.");
                            IF Structure.FINDSET THEN
                              REPEAT
                                   Quotation."Sales Tax" := Structure.Amount
                              UNTIL Structure.NEXT=0;
                    
                            Structure.RESET;
                            Structure.SETRANGE(Structure.Type,Structure.Type::Purchase);
                            Structure.SETRANGE(Structure."Document Type",PurchaseLine."Document Type"::Quote);
                            Structure.SETRANGE(Structure."Line No.",PurchaseLine."Line No.");
                            Structure.SETRANGE(Structure."Charge Type",Structure."Charge Type"::Insurance);
                            Structure.SETRANGE(Structure."Document No.",PurchaseHeader."No.");
                            IF Structure.FINDSET THEN
                              REPEAT
                                Quotation.Insurance := Structure.Amount;
                              UNTIL Structure.NEXT=0;
                    
                            Structure.RESET;
                            Structure.SETRANGE(Structure.Type,Structure.Type::Purchase);
                            Structure.SETRANGE(Structure."Document Type",PurchaseLine."Document Type"::Quote);
                            Structure.SETRANGE(Structure."Line No.",PurchaseLine."Line No.");
                            Structure.SETRANGE(Structure."Charge Type",Structure."Charge Type"::Freight);
                            Structure.SETRANGE(Structure."Document No.",PurchaseHeader."No.");
                            IF Structure.FINDSET THEN
                              REPEAT
                                Quotation.Freight := Structure.Amount;
                             UNTIL Structure.NEXT=0;
                    
                            Structure.RESET;
                            Structure.SETRANGE(Structure.Type,Structure.Type::Purchase);
                            Structure.SETRANGE(Structure."Document Type",PurchaseLine."Document Type"::Quote);
                            Structure.SETRANGE(Structure."Document No.",PurchaseHeader."No.");
                            Structure.SETRANGE(Structure."Line No.",PurchaseLine."Line No.");
                            Structure.SETRANGE(Structure."Tax/Charge Type",Structure."Tax/Charge Type"::VAT);
                            IF Structure.FINDSET THEN
                              REPEAT
                                   Quotation.VAT := Structure.Amount;
                              UNTIL Structure.NEXT=0;
                    
                            Structure.RESET;
                            Structure.SETRANGE(Structure.Type,Structure.Type::Purchase);
                            Structure.SETRANGE(Structure."Document Type",PurchaseLine."Document Type"::Quote);
                            Structure.SETRANGE(Structure."Document No.",PurchaseHeader."No.");
                            Structure.SETRANGE(Structure."Line No.",PurchaseLine."Line No.");
                            Structure.SETRANGE(Structure."Tax/Charge Type",Structure."Tax/Charge Type"::"Other Taxes");
                            IF Structure.FINDSET THEN
                              REPEAT
                                   Quotation.VAT := Structure.Amount;
                              UNTIL Structure.NEXT=0;
                           Quotation."Total Basic Value" := Quotation.Amount + Quotation."P & F" + Quotation."Excise Duty" + Quotation."Sales Tax" +
                                                   Quotation.Freight + Quotation.Insurance + Quotation.VAT;
                    
                           Quotation.INSERT;
                        UNTIL PurchaseLine.NEXT=0;
                    END;
                    UNTIL PurchaseHeader.NEXT=0;
                    Quotation.RESET;
                    Quotation.SETRANGE("Minumum Value","RFQ No.");
                    REPORT.RUN(60008);
                    QCSHeader.SETRANGE("RFQ No.","RFQ No.");
                    REPORT.RUN(60007,TRUE,FALSE,QCSHeader);
                     */

                end;
            }
            separator(Action1102152005)
            {
            }
            action("Copy Indent")
            {
                Caption = 'Copy Indent';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Rec.CopyIndent;
                end;
            }
        }
    }



    var
        MLTransactionType: Option Purchase,Sale;
        ReportSelection: Record "Report Selections";
        PurchHeader: Record "Purchase Header";
}

