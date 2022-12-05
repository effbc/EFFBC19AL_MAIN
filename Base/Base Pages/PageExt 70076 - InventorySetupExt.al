pageextension 70076 InventorySetupExt extends "Inventory Setup"
{


    layout
    {


        addafter("Prevent Negative Inventory")
        {
            field("Packing Charge Group"; Rec."Packing Charge Group")
            {
                ApplicationArea = All;
            }
        }
        addafter("Item Group Dimension Code")
        {
            field("RGP Out No."; Rec."RGP Out No.")
            {
                ApplicationArea = All;
            }
            field("RGP In No."; Rec."RGP In No.")
            {
                ApplicationArea = All;
            }
            field("DC Nos."; Rec."DC Nos.")
            {
                ApplicationArea = All;
            }
            field("Material Issues No."; Rec."Material Issues No.")
            {
                ApplicationArea = All;
            }
            field("Posted Issue No."; Rec."Posted Issue No.")
            {
                ApplicationArea = All;
            }
            field("Material Issue Nos."; Rec."Material Issue Nos.")
            {
                ApplicationArea = All;
            }
            field("Posted Material Issue Nos."; Rec."Posted Material Issue Nos.")
            {
                ApplicationArea = All;
            }
        }
    }



}

