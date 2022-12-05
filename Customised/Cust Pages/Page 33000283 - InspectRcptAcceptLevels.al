page 33000283 "Inspect. Rcpt. Accept Levels"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Inspect. Recpt. Accept Level";

    layout
    {
        area(content)
        {
            field(ReceiptQty; ReceiptQty)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(AssignedQty; AssignedQty)
            {
                Editable = false;
                ApplicationArea = All;
            }
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Acceptance Code"; "Acceptance Code")
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; "Reason Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        UpdateQtyBalance();
                        QuantityOnAfterValidate;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        UpdateQtyBalance;
    end;

    var
        ReceiptQty: Decimal;
        AssignedQty: Decimal;


    procedure UpdateQtyBalance()
    var
        InspectRcpt: Record "Inspection Receipt Header";
        InpectRcptAcptLevels: Record "Inspect. Recpt. Accept Level";
    begin
        IF InspectRcpt.GET("Inspection Receipt No.") THEN BEGIN
            //IF Quantity MOD (InspectRcpt.Quantity/InspectRcpt."Quantity(Base)") = 0 THEN BEGIN
            ReceiptQty := InspectRcpt.Quantity;
            InpectRcptAcptLevels.SETRANGE("Inspection Receipt No.", "Inspection Receipt No.");
            AssignedQty := 0;
            IF InpectRcptAcptLevels.FIND('-') THEN
                REPEAT
                    AssignedQty := AssignedQty + InpectRcptAcptLevels.Quantity;
                UNTIL InpectRcptAcptLevels.NEXT = 0;
            //END ELSE
            //ERROR('Enter Quantity equivalent to Pieces');
        END;
    end;

    local procedure QuantityOnAfterValidate()
    begin

        CurrPage.UPDATE();
    end;
}

