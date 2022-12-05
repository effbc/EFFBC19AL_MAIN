page 60205 Division
{
    Editable = false;
    PageType = List;
    SourceTable = 5212;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                ApplicationArea = All;
            }
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Zone code"; Code)
                {
                    ApplicationArea = All;
                }
                field("Division Code"; Code)
                {
                    ApplicationArea = All;
                }
                field("Division Name"; "Division Name")
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

