pageextension 70128 PostedTransferReceiptsExt extends "Posted Transfer Receipts"
{

    layout
    {



        /*modify("Control1")
        {

            
            ShowCaption = false;
        }*/


        addafter("Transfer-to Code")
        {
            field("Prod. Order No."; Rec."Prod. Order No.")
            {
                ApplicationArea = All;
            }
            field("Prod. Order Line No."; Rec."Prod. Order Line No.")
            {
                ApplicationArea = All;
            }
            field("Machine Center No."; Rec."Machine Center No.")
            {
                Caption = 'Resource';
                ApplicationArea = All;
            }
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
            }
            field("Due Date"; Rec."Due Date")
            {
                ApplicationArea = All;
            }
            field("Required Date"; Rec."Required Date")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {


        modify(Statistics)
        {


            Promoted = true;

        }


        modify("&Print")
        {


            Promoted = true;


        }
        modify("&Navigate")
        {
            Promoted = true;



        }
    }



}

