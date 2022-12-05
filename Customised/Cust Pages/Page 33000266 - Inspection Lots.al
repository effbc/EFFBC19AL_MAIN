page 33000266 "Inspection Lots"
{
    // version QC1.0,Rev01

    DelayedInsert = true;
    Editable = false;
    PageType = List;
    SourceTable = "Inspection Lot";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Rec.TESTFIELD("Lot No.");
                        PostPurchRcptLine.SETRANGE("Document No.", "Document No.");
                        PostPurchRcptLine.SETRANGE("Line No.", "Purch. Line No.");
                        IF PostPurchRcptLine.FINDFIRST THEN
                            Qty := PostPurchRcptLine.Quantity;

                        InspLot.SETRANGE("Document No.", Rec."Document No.");
                        InspLot.SETRANGE("Purch. Line No.", Rec."Purch. Line No.");
                        InspLot.SETFILTER("Lot No.", '<>%1', Rec."Lot No.");
                        InspLot.CALCSUMS(Quantity);
                        IF InspLot.Quantity + Rec.Quantity > Qty THEN
                            ERROR(Text001, InspLot.Quantity + Rec.Quantity, Qty);
                    end;
                }
                field("Spec Id"; Rec."Spec Id")
                {
                    ApplicationArea = All;
                }
                field("Inspect. Data sheet created"; Rec."Inspect. Data sheet created")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                Image = "Action";
                action("Inspection Data Sheets")
                {
                    Caption = 'Inspection Data Sheets';
                    Image = Worksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Inspection Data Sheet List";
                    ApplicationArea = All;
                    RunPageLink = "Receipt No." = FIELD("Document No."), "Purch Line No" = FIELD("Purch. Line No."), "Lot No." = FIELD("Lot No.");
                }
                action("Posted Inspection Data Sheets")
                {
                    Caption = 'Posted Inspection Data Sheets';
                    Image = PostedTimeSheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Posted Inspect Data Sheet List";
                    RunPageLink = "Receipt No." = FIELD("Document No."), "Purch Line No" = FIELD("Purch. Line No."), "Lot No." = FIELD("Lot No.");
                    ApplicationArea = All;
                }
                action("Inspection Receipt")
                {
                    Caption = 'Inspection Receipt';
                    Image = PickWorksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Inspection Receipt List";
                    RunPageLink = "Receipt No." = FIELD("Document No."), "Purch Line No" = FIELD("Purch. Line No."), "Lot No." = FIELD("Lot No.");
                    ApplicationArea = All;
                }
                action("Posted Inspection Receipt")
                {
                    Caption = 'Posted Inspection Receipt';
                    Image = PostedReceipt;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Posted Inspect. Receipt List";
                    RunPageLink = "Receipt No." = FIELD("Document No."), "Purch Line No" = FIELD("Purch. Line No."), "Lot No." = FIELD("Lot No."), Status = FILTER(<> false);
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        PostPurchRcptLine: Record "Purch. Rcpt. Line";
        InspLot: Record "Inspection Lot";
        Text001: Label 'Total Lots Quantity %1  should not more than Receipt Quantity %2';
        InspLotMgt: Codeunit "Inspection Data Sheets";
        Qty: Decimal;
        Text002: Label 'Inspection Data Sheets Created Sucessfully.';
        InspectDataSheets: Codeunit "Inspection Data Sheets";
}

