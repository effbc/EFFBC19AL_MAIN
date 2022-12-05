page 33000276 "Inspection Item Tracking Lines"
{
    // version QC1.0

    Caption = 'Inspection Item Tracking Lines';
    PageType = Worksheet;
    SourceTable = "Quality Item Ledger Entry";

    layout
    {
        area(content)
        {
            field("COUNT"; Rec.COUNT)
            {
                ApplicationArea = All;
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field("Serial No."; Rec."Serial No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Warranty Date"; Rec."Warranty Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Accept Under Deviation"; Rec."Accept Under Deviation")
                {
                    ApplicationArea = All;
                }
                field("Inspection Status"; Rec."Inspection Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Accept; Rec.Accept)
                {
                    ApplicationArea = All;
                }
                field(Rework; Rec.Rework)
                {
                    ApplicationArea = All;
                }
                field("Sending to Rework"; Rec."Sending to Rework")
                {
                    ApplicationArea = All;
                }
                field(Reject; Rec.Reject)
                {
                    ApplicationArea = All;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    var
        CaptionText1: Text[100];
        CaptionText2: Text[100];
    begin
        CaptionText1 := Rec."Item No.";
        IF CaptionText1 <> '' THEN BEGIN
            CaptionText2 := CurrPage.CAPTION;
            CurrPage.CAPTION := STRSUBSTNO(Text001, CaptionText1, CaptionText2);
        END;

        //CurrPage."Sending to Rework".VISIBLE := FALSE;
    end;

    var
        Text001: Label '%1 - %2';
}

