pageextension 70163 PurchaseReturnOrderExt extends "Purchase Return Order"
{


    layout
    {


        modify("Buy-from Address 2")
        {



            CaptionML = ENU = 'Buy-from Post Code/City';


        }


        modify("Pay-to Post Code")
        {



            CaptionML = ENU = 'Pay-to Post Code/City';



        }


        modify("Ship-to Post Code")
        {



            CaptionML = ENU = 'Ship-to Post Code/City';



        }


    }
    actions
    {



        modify(Statistics)
        {
            Promoted = true;
        }



        modify(Approve)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Reject)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Delegate)
        {
            Promoted = true;
        }
        modify(Comment)
        {
            Promoted = true;
        }
        modify("&Print")
        {


            Promoted = true;



        }



        modify("Re&lease")
        {
            Promoted = true;


        }



        modify(GetPostedDocumentLinesToReverse)
        {



            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Apply Entries")
        {
            Promoted = true;



        }



        modify(CopyDocument)
        {


            Promoted = true;
        }


        modify(SendApprovalRequest)
        {
            Promoted = true;
        }
        modify(CancelApprovalRequest)
        {
            Promoted = true;
        }



        modify(Post)
        {


            Promoted = true;
            PromotedIsBig = true;
        }


        modify(PostAndPrint)
        {



            Promoted = true;
            PromotedIsBig = true;
        }


        addafter("Action135")
        {
            separator(Action1102152000)
            {
            }
            action("Copy Quality Rejected Items")
            {
                Caption = 'Copy Quality Rejected Items';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Rec.CreateReturnOrder;
                end;
            }
        }
    }




}

