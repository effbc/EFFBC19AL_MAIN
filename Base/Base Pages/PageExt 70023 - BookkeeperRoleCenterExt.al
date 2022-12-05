pageextension 70023 BookkeeperRoleCenterExt extends "Bookkeeper Role Center"
{


    layout
    {


        /*  modify(Control1900724808)
          {



              ShowCaption = false;
          }*/



        /*modify(Control1900724708)
        {

          

            ShowCaption = false;
        }*/


        modify(Control1901377608)
        {


            Enabled = false;



        }



    }
    actions
    {



        modify("C&ustomer")
        {



            Promoted = false;



        }
        modify("Sales &Invoice")
        {


            Promoted = false;


        }
        modify("Sales Credit &Memo")
        {



            Promoted = false;



        }
        modify("Sales &Fin. Charge Memo")
        {



            Promoted = false;


        }
        modify("Sales &Reminder")
        {



            Promoted = false;


        }


        modify("&Vendor")
        {


            Promoted = false;



        }
        modify("&Purchase Invoice")
        {



            Promoted = false;


        }



    }
}

