pageextension 70259 WhseBasicRoleCenterExt extends "Whse. Basic Role Center"
{


    layout
    {


        /*modify("Control 1900724808")
         {


             ShowCaption = false;
         }*/



        /*   modify(Control1900724708)
           {



               ShowCaption = false;
           }*/



        modify(Control1906245608)
        {


            Enabled = FALSE;



        }


    }
    actions
    {



        modify("T&ransfer Order")
        {


            Promoted = false;

        }
        modify("&Purchase Order")
        {


            Promoted = false;



        }


        modify("Inventory Pi&ck")
        {


            Promoted = false;


        }
        modify("Inventory P&ut-away")
        {



            Promoted = false;



        }



    }
}

