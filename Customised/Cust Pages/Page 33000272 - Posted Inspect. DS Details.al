page 33000272 "Posted Inspect. DS Details"
{
    // version QC1.0,Rev01

    Editable = false;
    PageType = List;
    SourceTable = "Posted Inspect DatasheetHeader";
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
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    ApplicationArea = All;
                }
                field("Posted Time"; Rec."Posted Time")
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
            action("&Show")
            {
                Caption = '&Show';
                Image = ShowSelected;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page "Posted Inspection Data Sheet";
                RunPageLink = "No." = FIELD("No.");
            }
        }
    }
}

