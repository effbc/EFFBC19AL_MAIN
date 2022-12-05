pageextension 70180 SalesCreditMemosExt extends "Sales Credit Memos"
{


    layout
    {







        addafter("Job Queue Status")
        {
            field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
            {
                ApplicationArea = All;
            }
            field("Applies-to ID"; Rec."Applies-to ID")
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
        modify("Co&mments")
        {



            Promoted = true;



        }
        modify(Dimensions)
        {



            Promoted = true;



        }



        modify("Re&lease")
        {
            Promoted = true;
            PromotedIsBig = true;


        }
        modify("Re&open")
        {
            Promoted = true;
            PromotedIsBig = true;


        }



        modify(Post)
        {
            Promoted = true;
            PromotedIsBig = true;


        }



        modify(PostAndSend)
        {



            Promoted = true;
            PromotedIsBig = true;
        }
        /*  modify("Action 53") //post and  print
          {
              PromotedIsBig = true;


          }*/



        modify("Post &Batch")
        {


            Promoted = true;
            PromotedIsBig = true;


        }



    }



}

