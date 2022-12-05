pageextension 70136 ProductionJournalExt extends "Production Journal"
{


    layout
    {



        /*modify("Control1")
        {

          

            ShowCaption = false;
        }


        modify("Control1902114901")
        {

           

            ShowCaption = false;
        }*/



    }
    actions
    {



        modify(Post)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Post and &Print")
        {
            Promoted = true;
            PromotedIsBig = true;


        }
        modify("&Print")
        {



            Promoted = true;



        }
    }

}

