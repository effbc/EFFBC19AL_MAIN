page 60204 "Zones-cs"
{
    PageType = Worksheet;
    SourceTable = "Cause of Inactivity";

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
                field("Zone Code"; Code)
                {
                    ApplicationArea = All;
                }
                field("Zone Name"; Description)
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

