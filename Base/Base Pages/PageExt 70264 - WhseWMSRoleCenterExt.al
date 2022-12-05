pageextension 70264 WhseWMSRoleCenterExt extends "Whse. WMS Role Center"
{

    layout
    {



        /* modify("Control1900724808")
         {



             ShowCaption = false;
         }



         modify("Control 1900724708")
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


        modify("Shipping Agent")
        {



            Promoted = false;



        }
        modify("T&ransfer Order")
        {


            Promoted = false;



        }
        modify(PurchaseOrders)
        {


            Promoted = false;


        }
        modify("&Whse. Receipt")
        {



            Promoted = false;


        }



    }
}

