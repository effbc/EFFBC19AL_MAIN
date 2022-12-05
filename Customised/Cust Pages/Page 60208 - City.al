page 60208 City
{
    PageType = Worksheet;
    SourceTable = City;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("City Code"; Rec."City Code")
                {
                    ApplicationArea = All;
                }
                field("City Name"; Rec."City Name")
                {
                    ApplicationArea = All;
                }
                field("District Code"; Rec."District Code")
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

