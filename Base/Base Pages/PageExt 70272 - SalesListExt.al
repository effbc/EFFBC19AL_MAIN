pageextension 70272 SalesListExt extends "Sales List"
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
        addafter("Sell-to Customer No.")
        {
            field("Installation Amount"; Rec."Installation Amount")
            {
                ApplicationArea = All;

            }

            field("Bought out Items Amount"; Rec."Bought out Items Amount")
            {
                ApplicationArea = All;

            }
            field("Order Released Date"; Rec."Order Released Date")
            {
                ApplicationArea = All;

            }
            field("Blanket Order No"; Rec."Blanket Order No")
            {
                ApplicationArea = All;

            }
            field("Software Amount"; Rec."Software Amount")
            {
                ApplicationArea = All;

            }
            field("Payment Terms Code"; Rec."Payment Terms Code")
            {
                ApplicationArea = All;

            }
            field("Order Status"; Rec."Order Status")
            {
                ApplicationArea = All;

            }
            field("Expecting Week"; Rec."Expecting Week")
            {
                ApplicationArea = All;

            }
            field("Total Order(LOA)Value"; Rec."Total Order(LOA)Value")
            {
                Visible = FALSE;
                ApplicationArea = All;
            }
            field(Reserve; Rec.Reserve)
            {
                ApplicationArea = All;

            }
            field("Pending(LOA)Value"; Rec."Pending(LOA)Value")
            {
                ApplicationArea = All;

            }
            field(Territory; Rec.Territory)
            {
                ApplicationArea = All;

            }
            field("Promised Delivery Date"; Rec."Promised Delivery Date")
            {
                ApplicationArea = All;

            }
            field("Shipment Date"; Rec."Shipment Date")
            {
                ApplicationArea = All;

            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;

            }
            field("Assured Date"; Rec."Assured Date")
            {
                ApplicationArea = All;

            }
            field("Security Deposit Status"; Rec."Security Deposit Status")
            {
                ApplicationArea = All;

            }
            field("Sell-to Address 2"; Rec."Sell-to Address 2")
            {
                ApplicationArea = All;

            }
            field("Sale Order Total Amount"; Rec."Sale Order Total Amount")
            {
                ApplicationArea = All;

            }
            field("Tender No."; Rec."Tender No.")
            {
                ApplicationArea = All;

            }
            field("Requested Delivery Date"; Rec."Requested Delivery Date")
            {
                ApplicationArea = All;

            }
            field("Customer OrderNo."; Rec."Customer OrderNo.")
            {
                ApplicationArea = All;

            }
            field("Customer Order Date"; Rec."Customer Order Date")
            {
                ApplicationArea = All;

            }
            field("Customer Posting Group"; Rec."Customer Posting Group")
            {
                ApplicationArea = All;

            }
        }
        modify("Document Date")
        {
            Caption = 'Enquiry Date';
        }
        addafter("Sell-to Customer Name")
        {

            field("Enquiry Status"; Rec."Enquiry Status")
            {
                ApplicationArea = All;

            }
            field("Type of Product"; Rec."Type of Product")
            {
                ApplicationArea = All;

            }
            field("Type of Enquiry"; Rec."Type of Enquiry")
            {
                ApplicationArea = All;

            }
            field("Project Completion Date"; Rec."Project Completion Date")
            {
                ApplicationArea = All;

            }
            field("Extended Date"; Rec."Extended Date")
            {
                ApplicationArea = All;

            }
        }
        addafter("Sell-to Contact")
        {
            field("RDSO Charges Paid By"; Rec."RDSO Charges Paid By")
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
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}