pageextension 70165 PurchasingAgentRoleCenterExt extends "Purchasing Agent Role Center"
{

    layout
    {



        /*modify(Control1900724808)
        {

           
            ShowCaption = false;
        }

       

        modify(Control1900724708)
        {

         
            ShowCaption = false;
        }

       

        modify("Control 1903012608")
        {

            Enabled = FALSE;

           
        }*/

    }
    actions
    {


        modify("Purchase &Quote")
        {



            Promoted = false;


        }
        modify("Purchase &Invoice")
        {



            Promoted = false;



        }
        modify("Purchase &Order")
        {



            Promoted = false;


        }
        modify("Purchase &Return Order")
        {


            Promoted = false;



        }



    }
}

