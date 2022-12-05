pageextension 70199 SalesReturnOrderExt extends 6630
{


    layout
    {



        modify("Sell-to Post Code")
        {


            CaptionML = ENU = 'Sell-to Post Code/City';



        }


        modify("Bill-to Post Code")
        {



            CaptionML = ENU = 'Bill-to Post Code/City';



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
            PromotedIsBig = true;
        }

        modify(Dimensions)
        {



            Promoted = false;
            // PromotedIsBig = false;


        }
        modify(Approvals)
        {
            Promoted = false;
            // PromotedIsBig = false;



        }
        modify("Co&mments")
        {



            Promoted = false;
            //PromotedIsBig= false;


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
        modify("Post and &Print")
        {



            Promoted = true;


        }



        modify("Apply Entries")
        {


            Promoted = true;



        }
        modify("Create Return-Related &Documents")
        {


            Promoted = true;


        }



        modify(CopyDocument)
        {



            Promoted = true;
        }



        modify(GetPostedDocumentLinesToReverse)
        {



            Promoted = true;
            PromotedIsBig = true;
        }



        /* modify("Update Reference Invoice No")
         {
             Promoted = true;
         }*/



        modify(Post)
        {



            Promoted = true;
            PromotedIsBig = true;
        }



        modify("Post &Batch")
        {


            Promoted = true;
            PromotedIsBig = true;


        }



        modify(SendApprovalRequest)
        {
            Promoted = true;
        }
        modify(CancelApprovalRequest)
        {
            Promoted = true;
        }
    }



}


