pageextension 70217 ServiceTasksExt extends "Service Tasks"
{


    layout
    {



        /* modify("Control1")
         {



             ShowCaption = false;
         }


         modify("Control44")
         {

             ShowCaption = false;
         }*/



        addafter("Document No.")
        {
            field(Tested; Rec.Tested)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {



        modify("&Show Document")
        {
            Promoted = true;
            PromotedIsBig = true;



        }
        modify("&Item Worksheet")
        {


            Promoted = true;
            PromotedIsBig = true;



        }



    }



}

