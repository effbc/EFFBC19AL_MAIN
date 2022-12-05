pageextension 70143 PurchaseCreditMemosExt extends "Purchase Credit Memos"
{


    layout
    {



        /* modify("Control1")
         {



             ShowCaption = false;
         }*/



        addafter("Applies-to Doc. Type")
        {
            field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
            {
                ApplicationArea = All;
            }

        }
        addafter("Job Queue Status")
        {
            /* field(Structure; Structure)
             {
                 ApplicationArea = All;
             }*/
            field("Tarrif Heading No"; Rec."Tarrif Heading No")
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
        modify(PostBatch)
        {



            Promoted = true;
        }
    }




}

