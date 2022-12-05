page 60152 "Measuring Parameters"
{
    AutoSplitKey = true;
    PageType = Worksheet;
    SourceTable = "Measuring Parameters";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("UOM Code"; Rec."UOM Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ApplicationArea = All;
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ApplicationArea = All;
                }
                field("Least Count"; Rec."Least Count")
                {
                    ApplicationArea = All;
                }
                field("Usage Subjective"; Rec."Usage Subjective")
                {
                    ApplicationArea = All;
                }
                field("Actual Lower Limit"; Rec."Actual Lower Limit")
                {
                    ApplicationArea = All;
                }
                field("Actual Upper Limit"; Rec."Actual Upper Limit")
                {
                    ApplicationArea = All;
                }
                field("Standard Reference"; Rec."Standard Reference")
                {
                    ApplicationArea = All;
                }
                field("Correction Value"; Rec."Correction Value")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

