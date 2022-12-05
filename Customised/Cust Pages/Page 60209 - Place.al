page 60209 Place
{
    PageType = Worksheet;
    SourceTable = Place;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Place Code"; Rec."Place Code")
                {
                    Caption = '"Activity "';
                    ApplicationArea = All;
                }
                field("Place Name"; Rec."Place Name")
                {
                    Caption = 'Activity Name';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

