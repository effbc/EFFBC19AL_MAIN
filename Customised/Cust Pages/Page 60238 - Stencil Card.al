page 60238 "Stencil Card"
{
    PageType = Card;
    SourceTable = Stencil;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Fixed Asset no"; Rec."Fixed Asset no")
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

