page 60128 "Routing Line Movement"
{
    // version Rev01

    PageType = Worksheet;
    SourceTable = "Prod. Order Routing Line";

    layout
    {
        area(content)
        {
            field("COUNT"; Rec.COUNT)
            {
                ApplicationArea = All;
            }
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Starting Date"; Rec."Starting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Routing Reference No."; Rec."Routing Reference No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Operation No."; Rec."Operation No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Operation Description"; Rec."Operation Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Run Time"; Rec."Run Time")
                {
                    ApplicationArea = All;
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    ApplicationArea = All;
                }
                field("Ending Time"; Rec."Ending Time")
                {
                    ApplicationArea = All;
                }
                field("Work Center No."; Rec."Work Center No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Move; Rec.Move)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("APPLY ALL")
            {
                Caption = 'APPLY ALL';
                Image = Apply;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    IF Rec.FINDSET THEN
                        REPEAT
                            Rec.Move := TRUE;
                            Rec.MODIFY;
                        UNTIL Rec.NEXT = 0;
                end;
            }
            action("CANCEL ALL")
            {
                Caption = 'CANCEL ALL';
                Image = UnApply;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    IF Rec.FINDSET THEN
                        REPEAT
                            Rec.Move := FALSE;
                            Rec.MODIFY;
                        UNTIL Rec.NEXT = 0;
                end;
            }
        }
    }
}

