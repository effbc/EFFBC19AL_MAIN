page 60206 Station
{
    PageType = Worksheet;
    SourceTable = Station;

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
                field("Station Name"; Rec."Station Name")
                {
                    ApplicationArea = All;
                }
                field("Station Code"; Rec."Station Code")
                {
                    ApplicationArea = All;
                }
                field("Division code"; Rec."Division code")
                {
                    ApplicationArea = All;
                }
                field(Zone; Rec.Zone)
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

