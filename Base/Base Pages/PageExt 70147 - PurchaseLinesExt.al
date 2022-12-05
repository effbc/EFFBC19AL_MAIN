pageextension 70147 PurchaseLinesExt extends "Purchase Lines"
{
    layout
    {

        addafter("Document No.")
        {
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = All;

            }

        }
        addafter("Buy-from Vendor No.")
        {

            field("Qty. Invoiced (Base)"; Rec."Qty. Invoiced (Base)")
            {
                ApplicationArea = All;

            }
        }
        addafter(Type)
        {
            field(Make; Rec.Make)
            {
                ApplicationArea = All;

            }
            field("Qty. Received (Base)"; Rec."Qty. Received (Base)")
            {
                ApplicationArea = All;

            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;

            }
        }
        addafter("No.")
        {
            field(gst_group_code_reverse_charge; Rec.gst_group_code_reverse_charge)
            {
                ApplicationArea = All;

            }

        }
        addafter("Outstanding Amount (LCY)")
        {
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;

            }
        }
        addafter("Amt. Rcd. Not Invoiced (LCY)")
        {
            field("Sales Order No."; Rec."Sales Order No.")
            {
                ApplicationArea = All;

            }
            field("Sales Order Line No."; Rec."Sales Order Line No.")
            {
                ApplicationArea = All;

            }
            field("Product Group Code Cust";Rec."Product Group Code Cust")
            {
                ApplicationArea = All;
            }
        }



    }

}

