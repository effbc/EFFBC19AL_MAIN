page 60046 "Partial  IDS QLE"
{
    // version QC1.0

    PageType = List;
    SourceTable = "Quality Item Ledger Entry";
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
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Purch.Rcpt Line"; Rec."Purch.Rcpt Line")
                {
                    ApplicationArea = All;
                }
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                }
                field("Child Ids"; Rec."Child Ids")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Invoiced Quantity"; Rec."Invoiced Quantity")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Applies-to Entry"; Rec."Applies-to Entry")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Open; Rec.Open)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Originally Ordered No."; Rec."Originally Ordered No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Originally Ordered Var. Code"; Rec."Originally Ordered Var. Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Warranty Date"; Rec."Warranty Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Declared Goods"; Rec."Declared Goods")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Inspection Status"; Rec."Inspection Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quality Ledger Entry No."; Rec."Quality Ledger Entry No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Accept; Rec.Accept)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Rework; Rec.Rework)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Reject; Rec.Reject)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Accept Under Deviation"; Rec."Accept Under Deviation")
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
    begin
        QualityILE.SETRANGE(QualityILE."Document No.", IDS."Receipt No.");
        QualityILE.SETRANGE(QualityILE."Item No.", IDS."Item No.");
        QualityILE.SETRANGE(QualityILE."Purch.Rcpt Line", IDS."Purch Line No");
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        /*QualityILE.SETRANGE("Document No.","Document No.");
        QualityILE.SETRANGE("Child Ids",'');
        QualityILE.SETRANGE(Select,TRUE);
        IF NOT QualityILE.FINDFIRST THEN
          ERROR(Text001);      */

        IDS.RESET;
        IDS.SETRANGE(IDS."Receipt No.", Rec."Document No.");
        IDS.SETRANGE(IDS."Item No.", Rec."Item No.");
        IF IDS.FINDFIRST THEN BEGIN

            IF IDS."Parent IDS No" = '' THEN BEGIN
                Rec.SETRANGE(Select, TRUE);
                IF (IDS."Qty in IDS" <> Rec.COUNT) AND (IDS."Qty in IDS" > 0) THEN BEGIN
                    Rec.RESET;

                    Rec.SETRANGE("Document No.", IDS."Receipt No.");
                    Rec.SETRANGE("Item No.", IDS."Item No.");
                    Rec.SETRANGE("Child Ids", ' ');
                    Rec.SETRANGE("Lot No.", IDS."Lot No.");

                    ERROR('You must select ' + FORMAT(IDS."Qty in IDS"));
                END;
            END
        END

        ELSE
            EXIT;

    end;

    var
        QualityILE: Record "Quality Item Ledger Entry";
        Text001: Label 'Select the Tracking Lines.';
        Flag: Boolean;
        IDS: Record "Inspection Datasheet Header";
}

