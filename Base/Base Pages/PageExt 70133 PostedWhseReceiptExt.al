pageextension 70133 PostedWhseReceiptExt extends "Posted Whse. Receipt"
{


    layout
    {


    }
    actions
    {

        modify("Create Put-away")
        {



            Promoted = true;
            PromotedIsBig = true;



        }
        modify("&Print")
        {


            Promoted = true;


        }



        modify("Put-away List")
        {



            Promoted = true;


        }
    }

}

