pageextension 70200 SalespeoplePurchasersExt extends "Salespersons/Purchasers"
{
    Editable = false;
    layout
    {
        addafter("Privacy Blocked")
        {
            field("Salesperson/Purchaser"; Rec."Salesperson/Purchaser")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(Statistics)
        {
            Promoted = true;
        }
        modify(CreateInteraction)
        {
            Promoted = true;
        }
    }
}

