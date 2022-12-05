page 60050 "QCS From"
{
    // version B2B1.0

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

