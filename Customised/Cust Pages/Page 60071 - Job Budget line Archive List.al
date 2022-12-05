page 60071 "Job Budget line Archive List"
{
    // version B2B1.0

    PageType = ListPart;
    SourceTable = "Item wise Requirement";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Required Quantity"; Rec."Required Quantity")
                {
                    ApplicationArea = All;
                }
                field("Qty. In Material Issues"; Rec."Qty. In Material Issues")
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

