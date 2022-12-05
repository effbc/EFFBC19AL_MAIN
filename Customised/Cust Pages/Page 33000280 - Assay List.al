page 33000280 "Assay List"
{
    // version QC1.0

    CardPageID = Assay;
    Editable = false;
    PageType = List;
    SourceTable = "Assay Header";
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
                field("Sampling Plan Code"; Rec."Sampling Plan Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Inspection Group Code"; Rec."Inspection Group Code")
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

