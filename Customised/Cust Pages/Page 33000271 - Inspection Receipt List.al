page 33000271 "Inspection Receipt List"
{
    // version C1.0,Rev01

    CardPageID = "Inspection Receipt";
    Editable = false;
    PageType = List;
    SaveValues = true;
    SourceTable = "Inspection Receipt Header";
    SourceTableView = SORTING("No.") WHERE(Status = FILTER(false), "Source Type" = CONST("In Bound"));
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Parent IDS"; Rec."Parent IDS")
                {
                    ApplicationArea = All;
                }
                field("Ids Reference No."; Rec."Ids Reference No.")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Rejection Category"; Rec."Rejection Category")
                {
                    ApplicationArea = All;
                }
                field("Rejection Reason"; Rec."Rejection Reason")
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field("Nature Of Rejection"; Rec."Nature Of Rejection")
                {
                    ApplicationArea = All;
                }
                field("Trans. Order No."; Rec."Trans. Order No.")
                {
                    ApplicationArea = All;
                }
                field("Stock Rcvd from QC"; Rec."Stock Rcvd from QC")
                {
                    ApplicationArea = All;
                }
                field("OutPut Jr Serial No."; Rec."OutPut Jr Serial No.")
                {
                    ApplicationArea = All;
                }
                field("IDS creation Date"; Rec."IDS creation Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Qty. To Vendor (Rejected)"; Rec."Qty. To Vendor (Rejected)")
                {
                    ApplicationArea = All;
                }
                field("Qty. To Receive(Rework)"; Rec."Qty. To Receive(Rework)")
                {
                    ApplicationArea = All;
                }
                field("Qty. Received(Rework)"; Rec."Qty. Received(Rework)")
                {
                    ApplicationArea = All;
                }
                field("Qty. Sent To Vendor (Rejected)"; Rec."Qty. Sent To Vendor (Rejected)")
                {
                    ApplicationArea = All;
                }
                field("Qty. Rework"; Rec."Qty. Rework")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order Line"; Rec."Prod. Order Line")
                {
                    ApplicationArea = All;
                }
                field("IDS Posted By"; Rec."IDS Posted By")
                {
                    ApplicationArea = All;
                }
                field("IR Posted By"; Rec."IR Posted By")
                {
                    ApplicationArea = All;
                }
                field("Prod. Description"; Rec."Prod. Description")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Reason for Pending"; Rec."Reason for Pending")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Operation Description"; Rec."Operation Description")
                {
                    ApplicationArea = All;
                }
                field(Resource; Rec.Resource)
                {
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                }
                field("Item Sub Group Code"; Rec."Item Sub Group Code")
                {
                    ApplicationArea = All;
                }
                field("Item Sub Sub Group Code"; Rec."Item Sub Sub Group Code")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Rework Level"; Rec."Rework Level")
                {
                    ApplicationArea = All;
                }
                field("Rework Reference No."; Rec."Rework Reference No.")
                {
                    ApplicationArea = All;
                }
                field("Rework Inspect DS Created"; Rec."Rework Inspect DS Created")
                {
                    ApplicationArea = All;
                }
                field("Last Rework Level"; Rec."Last Rework Level")
                {
                    ApplicationArea = All;
                }
                field("Item Ledger Entry No."; Rec."Item Ledger Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Purch Line No"; Rec."Purch Line No")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Qty. Accepted"; Rec."Qty. Accepted")
                {
                    ApplicationArea = All;
                }
                field("Qty. Rejected"; Rec."Qty. Rejected")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Issues For Pending"; Rec."Issues For Pending")
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
            group("&Receipt")
            {
                Caption = '&Receipt';
                action(Card)
                {
                    Caption = 'Card';
                    Image = Card;
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        IF NOT Rec.Status THEN
                            PAGE.RUN(PAGE::"Inspection Receipt", Rec)
                        ELSE
                            PAGE.RUN(PAGE::"Posted Inspection Receipt", Rec);
                    end;
                }
                separator("----")
                {
                    Caption = '----';
                }
                action("Purchase Receipt")
                {
                    Caption = 'Purchase Receipt';
                    Image = Receipt;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 136;
                    RunPageLink = "No." = FIELD("Receipt No.");
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        // CopyDocMgt: Codeunit "Copy Document Mgt.";
        PurchHeader: Record "Purchase Header";
        DocType: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo","Posted Receipt","Posted Invoice","Posted Return Shipment","Posted Credit Memo";
        Text000: Label 'Receipt %1 has been converted to Return Order.';
        Text001: Label 'Return Order already created for the Inspection Report %1.';
        Text002: Label 'Inspection Report %1 status is Under Progress.';
        Text003: Label 'Return Order already created for the Inspection Report %1.';
        Text005: Label 'Do you want to create Return Order?';
        CreateOrder: Boolean;
        InspectJnlLine: Codeunit "Inspection Jnl.-Post Line";
        QualityType: Option Accepted,"Accepted Under Deviation",Rework,Rejected;
        UndefinedQty: Decimal;
}

