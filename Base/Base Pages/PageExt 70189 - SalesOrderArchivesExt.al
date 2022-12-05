pageextension 70189 SalesOrderArchivesExt extends "Sales Order Archives"
{

    layout
    {





        addafter("Time Archived")
        {
            field("Sale Order Total Amount"; Rec."Sale Order Total Amount")
            {
                ApplicationArea = All;
            }
            field("First Released Date Time"; Rec."First Released Date Time")
            {
                ApplicationArea = All;
            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
            field("Customer Posting Group"; Rec."Customer Posting Group")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipment Date")
        {
            field("Security Deposit Amount"; Rec."Security Deposit Amount")
            {
                ApplicationArea = All;
            }
            field(Order_After_CF_Integration; Rec.Order_After_CF_Integration)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {


    }



}

