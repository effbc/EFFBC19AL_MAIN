page 33000285 "Sub Assembly List"
{
    // version WIP1.0

    CardPageID = "Sub Assembly Card";
    Editable = false;
    PageType = List;
    SourceTable = "Sub Assembly";
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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Search Name"; Rec."Search Name")
                {
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
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Block; Rec.Block)
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

