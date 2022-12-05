pageextension 70127 PostedTransferReceiptExt extends "Posted Transfer Receipt"
{


    layout
    {



        modify("Transfer-from Post Code")
        {


            CaptionML = ENU = 'Transfer-from Post Code/City';

        }



        modify("Transfer-to Post Code")
        {



            CaptionML = ENU = 'Transfer-to Post Code/City';



        }



        addbefore("Transfer Order No.")
        {
            field("Required Date"; Rec."Required Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
            }
        }
        addbefore(TransferReceiptLines)
        {
            field("Resource Name"; Rec."Resource Name")
            {
                ApplicationArea = All;
            }
            field("Prod. Order No."; Rec."Prod. Order No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Prod. Order Line No."; Rec."Prod. Order Line No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Operation No."; Rec."Operation No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Shipping Agent Code")
        {
            field("Due Date"; Rec."Due Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Receipt Date")
        {
            field("<Shortcut Dimension 1 Code2>"; Rec."Shortcut Dimension 1 Code")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("<Shortcut Dimension 2 Code2>"; Rec."Shortcut Dimension 2 Code")
            {
                Editable = false;
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

