pageextension 70156 PurchaseOrdersExt extends 56
{
    layout
    {
        /*  modify(Control1)
         {
             ShowCaption = false;
         } */
        addafter(Description)
        {
            field(Make; Rec.Make)
            {
                ApplicationArea = All;
            }
            field("Quantity Invoiced"; Rec."Quantity Invoiced")
            {
                ApplicationArea = All;
            }
        }
        addafter("Expected Receipt Date")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Buy-from Vendor No.")
        {
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = All;
            }
            field("Qty. to Receive"; Rec."Qty. to Receive")
            {
                ApplicationArea = All;
            }
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = All;
            }
            field("Deviated Receipt Date"; Rec."Deviated Receipt Date")
            {
                ApplicationArea = All;
            }
            field("Quantity Received"; Rec."Quantity Received")
            {
                ApplicationArea = All;
            }
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Reservation Entries")
        {
            action(Deviations)
            {
                Caption = 'Deviations';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    "Excepted Rcpt.Date Tracking".SETRANGE("Excepted Rcpt.Date Tracking"."Document No.", Rec."Document No.");
                    "Excepted Rcpt.Date Tracking".SETRANGE("Excepted Rcpt.Date Tracking"."Document Line No.", Rec."Line No.");
                    PAGE.RUNMODAL(60048, "Excepted Rcpt.Date Tracking");
                end;
            }
        }
    }

    var
        "Excepted Rcpt.Date Tracking": Record "Excepted Rcpt.Date Tracking";
}

