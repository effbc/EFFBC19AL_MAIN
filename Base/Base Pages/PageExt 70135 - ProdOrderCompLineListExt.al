pageextension 70135 ProdOrderCompLineListExt extends "Prod. Order Comp. Line List"
{


    layout
    {


        /*  modify("Control1")
          {



              ShowCaption = false;
          }*/



        addafter("Item No.")
        {
            field("Source No."; Rec."Source No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Variant Code")
        {
            field("Product Group Code"; Rec."Product Group Code")
            {
                ApplicationArea = All;
            }
            field("Production Plan Date"; Rec."Production Plan Date")
            {
                ApplicationArea = All;
            }
            field("Type of Solder"; Rec."Type of Solder")
            {
                ApplicationArea = All;
            }
        }
        addafter("Lead-Time Offset")
        {
            field(ProductGroup; ProductGroup)
            {
                Caption = 'Product Group';
                ApplicationArea = All;
            }
        }
    }
    actions
    {



    }

    var
        Item: Record Item;
        ProductGroup: Code[20];
        ProductionOrder: Record "Production Order";



}

