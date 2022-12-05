page 60235 "Issue Track Detailed Desc."
{
    // version TRACK

    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = Worksheet;
    ShowFilter = false;
    SourceTable = "Issue Tracker Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Detailed Descrption"; Rec."Detailed Descrption")
                {
                    ApplicationArea = All;
                }
                field("Logged DateTime"; Rec."Logged DateTime")
                {
                    ApplicationArea = All;
                }
                field("Logged By"; Rec."Logged By")
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

