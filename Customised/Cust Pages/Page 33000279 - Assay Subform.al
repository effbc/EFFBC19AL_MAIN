page 33000279 "Assay Subform"
{
    // version QC1.0

    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Assay Line";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Character Code"; Rec."Character Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Normal Value (Num)"; Rec."Normal Value (Num)")
                {
                    ApplicationArea = All;
                }
                field("Min. Value (Num)"; Rec."Min. Value (Num)")
                {
                    ApplicationArea = All;
                }
                field("Max. Value (Num)"; Rec."Max. Value (Num)")
                {
                    ApplicationArea = All;
                }
                field("Normal Value (Char)"; Rec."Normal Value (Char)")
                {
                    ApplicationArea = All;
                }
                field("Min. Value (Char)"; Rec."Min. Value (Char)")
                {
                    ApplicationArea = All;
                }
                field("Max. Value (Char)"; Rec."Max. Value (Char)")
                {
                    ApplicationArea = All;
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Qualitative; Rec.Qualitative)
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

