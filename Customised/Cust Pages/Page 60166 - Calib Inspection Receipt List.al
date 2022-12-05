page 60166 "Calib Inspection Receipt List"
{
    // version Cal1.0,Rev01

    Editable = false;
    PageType = List;
    SourceTable = "Inspection Receipt Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
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
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field(Results; Rec.Results)
                {
                    ApplicationArea = All;
                }
                field(Recommendations; Rec.Recommendations)
                {
                    ApplicationArea = All;
                }
                field("Calibration Status"; Rec."Calibration Status")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
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
                            PAGE.RUN(PAGE::"Calibration Inspection Receipt", Rec)
                        ELSE
                            PAGE.RUN(PAGE::CalibPostedInspReceipt, Rec);
                    end;
                }
                separator("----")
                {
                    Caption = '----';
                }
                action("Purchase Receipt")
                {
                    Caption = 'Purchase Receipt';
                    Image = ReturnReceipt;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Posted Purchase Receipt";
                    RunPageLink = "No." = FIELD("Receipt No.");
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        CopyDocMgt: Codeunit "Copy Document Mgt.";
        PurchHeader: Record "Purchase Header";
        DocType: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo","Posted Receipt","Posted Invoice","Posted Return Shipment","Posted Credit Memo";
        Text000: Label 'Receipt %1 has been converted to Return Order.';
        Text001: Label 'Return Order already created for the Inspection Report %1.';
        Text002: Label 'Inspection Report %1 status is Under Progress.';
        Text003: Label 'Return Order already created for the Inspection Report %1.';
        Text005: Label 'Do you want to create Return Order?';
        CreateOrder: Boolean;
}

