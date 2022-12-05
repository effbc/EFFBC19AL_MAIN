pageextension 70137 ProductionPlannerRoleCenterExt extends "Production Planner Role Center"
{


    layout
    {


        /*modify(Control1905113808)
        {

            

            ShowCaption = false;
        }*/


        /*modify(Control1900724708)
        {

         

            ShowCaption = false;
        }*/



        modify(Control1905989608)
        {


            Enabled = FALSE;


        }


    }
    actions
    {


        modify("&Item")
        {


            Promoted = false;



        }
        modify("Production &Order")
        {


            Promoted = false;



        }
        modify("Production &BOM")
        {



            Promoted = false;



        }
        modify("&Routing")
        {



            Promoted = false;

        }
        modify("&Purchase Order")
        {


            Promoted = false;


        }


    }
}

