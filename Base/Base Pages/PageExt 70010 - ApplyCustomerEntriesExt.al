pageextension 70010 ApplyCustomerEntriesExt extends "Apply Customer Entries"
{
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        }
        modify(Control41)
        {
            ShowCaption = false;
        }
        modify(Control1903222401)
        {
            ShowCaption = false;
        } */
        addfirst(Control1)
        {
            field("Entry No."; Rec."Entry No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Posting Date")
        {
            field("Sale Order no"; Rec."Sale Order no")
            {
                ApplicationArea = All;
            }
        }
        addafter("Document Type")
        {
            field("Payment Type"; Rec."Payment Type")
            {
                ApplicationArea = All;
            }
            field("Customer ord No"; Rec."Customer ord No")
            {
                ApplicationArea = All;
            }
        }
        addafter("Document No.")
        {
            field("invoice no"; Rec."invoice no")
            {
                ApplicationArea = All;
            }
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Global Dimension 2 Code")
        {
            field("Payment Through"; Rec."Payment Through")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("Set Applies-to ID")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Post Application")
        {
            Promoted = true;
        }
        modify("&Navigate")
        {
            Promoted = true;
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SETRANGE("Posting Date", (DMY2Date(04, 01, 08)), (DMY2Date(31, 03, 2035)));
    end;
}

