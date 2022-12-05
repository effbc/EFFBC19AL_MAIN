pageextension 70150 PurchaseOrderArchiveExt extends "Purchase Order Archive"
{


    layout
    {


        addafter("Buy-from Contact")
        {
            field("Cancel / Short Close"; Rec."Cancel / Short Close")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {



    }




}

