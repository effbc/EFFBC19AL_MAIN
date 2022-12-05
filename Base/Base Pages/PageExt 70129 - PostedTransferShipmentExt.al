pageextension 70129 PostedTransferShipmentExt extends "Posted Transfer Shipment"
{


    layout
    {


        modify("Transfer-from Post Code")
        {



            CaptionML = ENU = 'Transfer-from Post Code/City';



        }



        addafter("Posting Date")
        {
            field("External Document No."; Rec."External Document No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Way Bill No."; Rec."Way Bill No.")
            {
                ApplicationArea = All;
            }
            field("Prod. Order No."; Rec."Prod. Order No.")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
            }
            field("Prod. Order Line No."; Rec."Prod. Order Line No.")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
            }
        }
        addbefore(TransferShipmentLines)
        {
            field("Resource Name"; Rec."Resource Name")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("Machine Center No."; Rec."Machine Center No.")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
            }
        }
        addafter("Shipping Agent Code")
        {
            field("Required Date"; Rec."Required Date")
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



        modify("&Navigate")
        {
            Promoted = true;


        }
    }



}

