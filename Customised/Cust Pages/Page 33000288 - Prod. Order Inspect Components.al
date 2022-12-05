page 33000288 "Prod. Order Inspect Components"
{
    // version WIP1.0

    AutoSplitKey = true;
    Caption = 'Prod. Order Components';
    DataCaptionExpression = Rec.Caption;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Prod. Order Inspect Component";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Calculation Formula"; Rec."Calculation Formula")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Length; Rec.Length)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Width; Rec.Width)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Weight; Rec.Weight)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Depth; Rec.Depth)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Expected Quantity"; Rec."Expected Quantity")
                {
                    ApplicationArea = All;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Quantity Consumed"; Rec."Quantity Consumed")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Cost Amount"; Rec."Cost Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Position; Rec.Position)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Position 2"; Rec."Position 2")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Position 3"; Rec."Position 3")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Production Lead Time"; Rec."Production Lead Time")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        Text000: Label 'You cannot reserve components with status %1.';
        ShortcutDimCode: array[8] of Code[20];
}

