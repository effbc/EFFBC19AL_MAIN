page 60078 "Deveation Master"
{
    // version B2B1.0

    AutoSplitKey = true;
    PageType = Worksheet;
    SourceTable = "Item Lot Numbers1";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Item No"; Rec."Item No")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
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

