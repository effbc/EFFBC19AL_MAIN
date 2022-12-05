page 50000 "Location of service item"
{
    Caption = 'Location of service item';
    PageType = Worksheet;
    SourceTable = "Location of service item";
    SourceTableView = ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Control1000000009)
            {
                ShowCaption = false;
                field("Station No"; Rec."Station No")
                {
                    ApplicationArea = All;
                }
                field("Station name"; Rec."Station name")
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

