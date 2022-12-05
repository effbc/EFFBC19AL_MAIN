page 33000267 "Posted Inspect. Receipt List"
{
    // version QC1.0

    CardPageID = "Posted Inspection Receipt";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Inspection Receipt Header";
    SourceTableView = WHERE(Status = FILTER(<> false));
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            field("No of IRs"; xRec.COUNT)
            {
                Caption = 'No of IRs';
                ApplicationArea = All;
            }
            repeater(Control1000000000)
            {
                Editable = false;
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
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
                field("Rework Level"; Rec."Rework Level")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
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
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Stock Rcvd from QC"; Rec."Stock Rcvd from QC")
                {
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                }
                field("Nature Of Rejection"; Rec."Nature Of Rejection")
                {
                    ApplicationArea = All;
                }
                field("IDS Posted By"; Rec."IDS Posted By")
                {
                    ApplicationArea = All;
                }
                field("IDS creation Date"; Rec."IDS creation Date")
                {
                    ApplicationArea = All;
                }
                field("Item Sub Group Code"; Rec."Item Sub Group Code")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("IR Posted By"; Rec."IR Posted By")
                {
                    ApplicationArea = All;
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    ApplicationArea = All;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field(Make; Rec.Make)
                {
                    ApplicationArea = All;
                }
                field(BINAddress; BINAddress)
                {
                    Caption = 'BIN Address';
                    ApplicationArea = All;
                }
                field(UnitCost; UnitCost)
                {
                    Caption = 'UnitCost';
                    ApplicationArea = All;
                }
                field("Issues For Pending"; Rec."Issues For Pending")
                {
                    ApplicationArea = All;
                }
                field("Qty. Accepted Under Deviation"; Rec."Qty. Accepted Under Deviation")
                {
                    ApplicationArea = All;
                }
                field("Qty. Accepted UD Reason"; Rec."Qty. Accepted UD Reason")
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
                separator("---")
                {
                    Caption = '---';
                }
                action("Purchase Receipt")
                {
                    Caption = 'Purchase Receipt';
                    ApplicationArea = All;
                    RunObject = Page "Posted Purchase Receipt";
                    RunPageLink = "No." = FIELD("Receipt No.");
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        BINAddress := '';
        Item.RESET;
        Item.SETRANGE(Item."No.", "Item No.");
        IF Item.FINDFIRST THEN
            BINAddress := Item."BIN Address";

        UnitCost := 0;
        PRL.RESET;
        PRL.SETRANGE(PRL."Document No.", "Receipt No.");
        PRL.SETRANGE(PRL."No.", "Item No.");
        IF PRL.FINDFIRST THEN BEGIN
            PL.RESET;
            PL.SETRANGE(PL."Document Type", PL."Document Type"::Order);
            PL.SETRANGE(PL."Document No.", PRL."Order No.");
            PL.SETRANGE(PL."No.", PRL."No.");
            PL.SETRANGE(PL."Line No.", PRL."Order Line No.");
            IF PL.FINDFIRST THEN
                UnitCost := PL."Direct Unit Cost"
            ELSE
                UnitCost := PRL."Unit Cost";
        END;
    end;

    trigger OnOpenPage();
    begin
        BINAddress := '';
    end;

    var
        CopyDocMgt: Codeunit 6620;
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        DocType: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo","Posted Receipt","Posted Invoice","Posted Return Shipment","Posted Credit Memo";
        Text000: Label 'Receipt %1 has been converted to Return Order.';
        Text001: Label 'Return Order already created for the Inspection Report %1.';
        Text002: Label 'Inspection Report %1 status is Under Progress.';
        Text003: Label 'Return Order already created for the Inspection Report %1.';
        Text005: Label 'Do you want to create Return Order?';
        CreateOrder: Boolean;
        BINAddress: Code[20];
        Item: Record Item;
        PRL: Record "Purch. Rcpt. Line";
        UnitCost: Decimal;
        PL: Record "Purchase Line";
}

