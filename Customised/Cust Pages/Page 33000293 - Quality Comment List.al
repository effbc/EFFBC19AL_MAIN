page 33000293 "Quality Comment List"
{
    // version QC1.0

    AutoSplitKey = true;
    Caption = 'Comment List';
    DelayedInsert = true;
    Editable = false;
    PageType = List;
    SourceTable = "Quality Comment Line";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
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

