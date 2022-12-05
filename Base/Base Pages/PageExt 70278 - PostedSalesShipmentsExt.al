pageextension 70278 PostedSalesShipmentsExt extends 142
{
    layout
    {
        addfirst(Control1)
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
        }
        addafter("Sell-to Customer Name")
        {
            field(Territory; Rec.Territory)
            {
                ApplicationArea = All;

            }
            field("Customer OrderNo."; Rec."Customer OrderNo.")
            {
                ApplicationArea = All;

            }
            field("Posting Description"; Rec."Posting Description")
            {
                ApplicationArea = All;

            }
        }
        addafter("Sell-to Country/Region Code")
        {
            field("RDSO Charges Paid By."; Rec."RDSO Charges Paid By.")
            {
                ApplicationArea = All;

            }
            field("RDSO Inspection Required"; Rec."RDSO Inspection Required")
            {
                ApplicationArea = All;

            }
            field("RDSO Inspection By"; Rec."RDSO Inspection By")
            {
                ApplicationArea = All;

            }
            field("RDSO Charges"; Rec."RDSO Charges")
            {
                ApplicationArea = All;

            }
        }
        addafter("Shipment Date")
        {
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;

            }
            field("Order Date"; Rec."Order Date")
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