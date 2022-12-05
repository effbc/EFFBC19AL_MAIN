pageextension 70295 RoutingLinesExt extends "Routing Lines"
{
    layout
    {
        addafter("Operation No.")
        {
            field("Operation Description"; Rec."Operation Description")
            {
                ApplicationArea = All;

            }
            field(Recalculate; Rec.Recalculate)
            {
                ApplicationArea = All;

            }
        }
        addafter("Next Operation No.")
        {
            field("Sub Assembly"; Rec."Sub Assembly")
            {
                ApplicationArea = All;

            }
            field("QAS/MPR"; Rec."QAS/MPR")
            {
                ApplicationArea = All;

            }
            field("Qty. Produced"; Rec."Qty. Produced")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("Sub Assembly Unit of Meas.Code"; Rec."Sub Assembly Unit of Meas.Code")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("Spec Id"; Rec."Spec Id")
            {
                ApplicationArea = All;

            }
            field("QC Enabled"; Rec."QC Enabled")
            {
                ApplicationArea = All;

            }
            field("Sub Assembly Description"; Rec."Sub Assembly Description")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field(Start_Day; Rec.Start_Day)
            {
                ApplicationArea = All;

            }
        }
        addafter("Unit Cost per")
        {
            field("Work Center Group Code"; Rec."Work Center Group Code")
            {
                ApplicationArea = All;

            }
            field("Main Group"; Rec."Main Group")
            {
                ApplicationArea = All;

            }
            field("Sub Group"; Rec."Sub Group")
            {
                ApplicationArea = All;

            }
            field("Operation Number"; Rec."Operation Number")
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin

        IF USERID <> 'EFFTRONICS\VISHNUPRIYA' THEN BEGIN
            Rec.SETCURRENTKEY("Routing No.", "Version Code", "Operation No.");
            Rec.SETFILTER("Operation No.", '<>%1', '');
            IF Rec.FINDSET THEN
                REPEAT
                BEGIN
                    IF FORMAT(Rec.Start_Day) = '' THEN
                        ERROR('Fill the Start day for the Activity');
                END
                UNTIL Rec.NEXT = 0;
        END
    end;

    var
        myInt: Integer;
}