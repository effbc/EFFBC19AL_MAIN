page 60051 "Stationary Items List"
{
    // version B2B1.0

    Editable = false;
    PageType = List;
    SourceTable = Make;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field(Make; Rec.Make)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Entry Date Time"; Rec."Entry Date Time")
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

