pageextension 70208 ServiceItemListExt extends 5981
{


    layout
    {



        /*modify("Control1")
        {

          

            ShowCaption = false;
        }*/



        addafter("Item Description")
        {
            field("Present Location"; Rec."Present Location")
            {
                ApplicationArea = All;
            }
            field(Name; Rec.Name)
            {
                ApplicationArea = All;
            }
            field("Batch No."; Rec."Batch No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Serial No.")
        {
            field("Location of Service Item"; Rec."Location of Service Item")
            {
                ApplicationArea = All;
            }
        }
        addafter("Customer No.")
        {
            field("SO No."; Rec."SO No.")
            {
                ApplicationArea = All;
            }
            field("SO Line No."; Rec."SO Line No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Control1")
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {



        modify("Action59")
        {



            Promoted = true;



        }



        modify("Troubleshooting Setup")
        {


            Promoted = true;



        }


        modify("New Item")
        {



            Promoted = true;


        }



        modify("Service Item")
        {



            Promoted = true;



        }
        modify("Service Item Label")
        {



            Promoted = false;



        }
        modify("Service Item Resource usage")
        {


            Promoted = true;



        }
        modify("Service Item Out of Warranty")
        {



            Promoted = true;



        }
        addafter("Service Shi&pments")
        {
            separator(Action1102152000)
            {
            }
            action("Network Dataloger/Display Board")
            {
                Caption = 'Network Dataloger/Display Board';
                RunObject = Page "Item Wise Min. Req. Qty at Loc";
                ApplicationArea = All;
            }
        }
    }


}

