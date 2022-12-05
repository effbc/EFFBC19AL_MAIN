pageextension 70183 SalesInvoiceExt extends 43
{
    layout
    {
        modify("Sell-to Post Code")
        {
            Caption = 'Sell-to Post Code/City';
        }
        addafter(Status)
        {
            field("Insurance Applicable"; Rec."Insurance Applicable")
            {
                ApplicationArea = All;

            }
        }
        modify("Bill-to Post Code")
        {
            Caption = 'Bill-to Post Code/City';
        }
        addafter("VAT Bus. Posting Group")
        {
            field("Sale Order Total Amount"; Rec."Sale Order Total Amount")
            {
                ApplicationArea = All;

            }
            field("Customer OrderNo."; Rec."Customer OrderNo.")
            {
                ApplicationArea = All;

            }
        }
        modify("Ship-to Post Code")
        {
            Caption = 'Ship-to Post Code/City';
        }
        addafter("Ship-to Contact")
        {
            /*  field("LC No."; "LC No.")
              {
                  ApplicationArea = All;

              }
              field("Transit Document"; "Transit Document")
              {
                  ApplicationArea = All;

              }*/
        }
        addafter("Shipment Date")
        {
            /* field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
            {
                ApplicationArea = All;

            }
            field("Applies-to ID"; Rec."Applies-to ID")
            {
                ApplicationArea = All;

            } */
            field(WayBillNo; Rec.WayBillNo)
            {
                ApplicationArea = All;

            }
            field("Sale Order No."; Rec."Sale Order No.")
            {
                ApplicationArea = All;

            }
        }
        addafter("Area")
        {
            field("MSPT Date"; Rec."MSPT Date")
            {
                ApplicationArea = All;

            }
            field("MSPT Code"; Rec."MSPT Code")
            {
                ApplicationArea = All;

            }
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;

            }
            field("Shipping No."; Rec."Shipping No.")
            {
                ApplicationArea = All;

            }
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;

            }
            field("Shipping No. Series"; Rec."Shipping No. Series")
            {
                ApplicationArea = All;

            }
        }
    }
    actions
    {
        addafter("Co&mments")
        {
            action("&MSPT Order Detials")
            {
                Caption = '&MSPT Order Detials';
                RunObject = Page "MSPT Order Details";
                RunPageLink = Type = CONST(Sale), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "MSPT Header Code" = FIELD("MSPT Code"), "Party No." = FIELD("Sell-to Customer No.");
                ApplicationArea = All;
            }

        }
    }
}

