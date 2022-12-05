pageextension 70316 FinishedProductionOrderExt extends "Finished Production Order"
{
    Editable = true;
    layout
    {
        addafter("Source No.")
        {
            field("Sales Order Line No."; Rec."Sales Order Line No.")
            {
                Enabled = TRUE;
                Editable = FieldEditable;
                ApplicationArea = All;
            }
            field("Schedule Line No."; Rec."Schedule Line No.")
            {
                Editable = FieldEditable;
                ApplicationArea = All;
            }
            field("Product Group Code"; Rec."Product Group Code")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Item Sub Group Code"; Rec."Item Sub Group Code")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Production Order Status"; Rec."Production Order Status")
            {
                Editable = true;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    Rec.MODIFY;
                end;
            }
            field("Service Order No."; Rec."Service Order No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Sales Order No."; Rec."Sales Order No.")
            {
                Editable = FieldEditable;
                ApplicationArea = All;
            }
        }
        addafter("Last Date Modified")
        {
            field("Prod Start date"; Rec."Prod Start date")
            {
                Editable = true;
                ApplicationArea = All;
            }
            field("Finished Date"; Rec."Finished Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("User Id"; Rec."User Id")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("RDSO No"; Rec."RDSO No")
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        addafter("Registered P&ick Lines")
        {
            action(Convert)
            {
                Caption = 'Convert Order';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //MESSAGE('Under Implementation!');
                    PAGE.RUN(PAGE::"Convert Sale Order", Rec);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF USERID IN['EFFTRONICS\TPRIYANKA','EFFTRONICS\GRAVI'] THEN
            FieldEditable := TRUE
        ELSE
            FieldEditable := FALSE;
    end;

    var
        FieldEditable: Boolean;
}