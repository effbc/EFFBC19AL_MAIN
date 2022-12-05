pageextension 70001 AccManageRoleCenterExt extends "Accounting Manager Role Center"
{
    // version NAVW19.00.00.45778,NAVIN9.00.00.45778

    layout
    {



        /*modify(Control1900724808)
        {

          

            ShowCaption = false;
        }

       
        modify(Control1900724708)
        {

           
            ShowCaption = false;
        }*/



        modify(Control1901377608)
        {


            Enabled = FALSE;


        }


    }
    actions
    {


        modify("Sales &Credit Memo")
        {



            Promoted = false;


        }
        modify("P&urchase Credit Memo")
        {


            Promoted = false;


        }


    }
}

