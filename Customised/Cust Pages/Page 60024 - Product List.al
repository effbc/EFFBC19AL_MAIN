page 60024 "Product List"
{
    // version B2B1.0

    CardPageID = "Product Card";
    Editable = false;
    PageType = List;
    SourceTable = Products;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Technology; Rec.Technology)
                {
                    ApplicationArea = All;
                }
                field("Key Features"; Rec."Key Features")
                {
                    ApplicationArea = All;
                }
                field("Launched Year"; Rec."Launched Year")
                {
                    ApplicationArea = All;
                }
                field(Segment; Rec.Segment)
                {
                    ApplicationArea = All;
                }
                field(Price; Rec.Price)
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

