pageextension 70273 PurchaseListExt extends "Purchase List"
{
    layout
    {
        addfirst(content)
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
        }
        addafter("No.")
        {
            field("Packing Type"; Rec."Packing Type")
            {
                ApplicationArea = All;

            }
        }
        addafter("Buy-from Vendor No.")
        {
            field("Sale Order No"; Rec."Sale Order No")
            {
                ApplicationArea = All;

            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;

            }
            /*
             field(Structure; Structure)
             {
                 ApplicationArea = All;

             }
             */
            field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
            {
                ApplicationArea = All;

            }
            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = All;

            }
        }
        addafter("Buy-from Vendor Name")
        {
            field("Receiving No. Series"; Rec."Receiving No. Series")
            {
                ApplicationArea = All;

            }
            field("RFQ No."; Rec."RFQ No.")
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}