page 60137 "RFQ Numbers"
{
    // version POAU

    PageType = Worksheet;
    SourceTable = "Mech & Wirning Items";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Production Order No."; Rec."Production Order No.")
                {
                    ApplicationArea = All;
                }
                field("BOM Type"; Rec."BOM Type")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Production Order Line No."; Rec."Production Order Line No.")
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

