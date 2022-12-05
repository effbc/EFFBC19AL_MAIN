pageextension 70113 PostedPurchaseCreditMemoExt extends "Posted Purchase Credit Memo"
{
    layout
    {
        modify("Buy-from Post Code")
        {
            CaptionML = ENU = 'Buy-from Post Code/City';
        }
        modify("Pay-to Post Code")
        {
            CaptionML = ENU = 'Pay-to Post Code/City';
        }
        modify("Ship-to Post Code")
        {
            CaptionML = ENU = 'Ship-to Post Code/City';
        }
        addafter("Location Code")
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
            }
            field("Excise Claimed Date"; Rec."Excise Claimed Date")
            {
                Caption = 'GST Claimed Date';
                Editable = false;
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
        /* modify("Posted Reference Invoice No.")
        {
            Promoted = true;
        } */
        modify("&Print")
        {
            Promoted = true;
        }
        modify("&Navigate")
        {
            Promoted = true;
        }
    }
}

