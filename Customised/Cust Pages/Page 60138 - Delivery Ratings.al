page 60138 "Delivery Ratings"
{
    // version POAU

    PageType = Worksheet;
    SourceTable = "Delivery Ratings";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Minumum Value"; Rec."Minumum Value")
                {
                    ApplicationArea = All;
                }
                field("Maximum Value"; Rec."Maximum Value")
                {
                    ApplicationArea = All;
                }
                field(Rating; Rec.Rating)
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

