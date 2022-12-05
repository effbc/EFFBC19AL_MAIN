pageextension 70276 PostedSalesCreditMemoExt extends "Posted Sales Credit Memo"
{
    layout
    {
        modify("Sell-to Post Code")
        {
            Caption = 'Sell-to Post Code/City';
            Editable = true;
        }
        modify("Bill-to Post Code")
        {
            Caption = 'Bill-to Post Code/City';
            Editable = true;
        }
        modify("Ship-to Post Code")
        {
            Caption = 'Ship-to Post Code/City';
            Editable = true;
        }
        modify("Sell-to Address")
        {
            Editable = true;
        }
        modify("Sell-to Address 2")
        {
            Editable = true;
        }
        modify("Sell-to City")
        {
            Editable = true;
        }
        modify("Bill-to Address")
        {
            Editable = true;
        }
        modify("Bill-to Address 2")
        {
            Editable = true;
        }
       modify("Bill-to City")
       {
           Editable = true;
       }
        modify("Ship-to Name")
        {
            Editable = true;
        }
    modify("Ship-to Address")
    {
        Editable = true;
    }
    modify("Ship-to Address 2")
    {
        Editable = true;
    }
   modify("Ship-to City")
   {
       Editable = true;
   }
       
    }

    actions
    {
        addbefore(SendCustom)
        {
            group(Inspection)
            {
                Caption = 'Inspection';
                action("Inspection Data Sheets")
                {
                    Caption = 'Inspection Data Sheets';
                    RunObject = Page "Inspection Data Sheet List";
                    RunPageView = SORTING("Rework Level");
                    RunPageLink = "Posted Sales Order No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Posted Inspection Data Sheets")
                {
                    Caption = 'Posted Inspection Data Sheets';
                    RunObject = Page "Posted Inspect Data Sheet List";
                    RunPageView = SORTING("Rework Level");
                    RunPageLink = "Posted Sales Order No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("I&nspection Receipts")
                {
                    Caption = 'I&nspection Receipts';
                    RunObject = Page "Inspection Receipt List";
                    RunPageView = SORTING("Rework Level");
                    RunPageLink = "Posted Sales Order No." = FIELD("No."), Status = CONST(false);
                    ApplicationArea = All;
                }
                action("Posted I&nspection Receipts")
                {
                    Caption = 'Posted I&nspection Receipts';
                    RunObject = Page "Inspection Receipt List";
                    RunPageView = SORTING("Rework Level");
                    RunPageLink = "Posted Sales Order No." = FIELD("No."), Status = CONST(true);
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        myInt: Integer;
}