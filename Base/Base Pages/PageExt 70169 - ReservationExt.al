pageextension 70169 ReservationExt extends Reservation
{


    layout
    {



        /* modify("Control1")
         {



             ShowCaption = false;
         }*/


    }
    actions
    {

        modify(AvailableToReserve)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("&Reservation Entries")
        {



            Promoted = true;
            PromotedIsBig = true;



        }



        modify("Auto Reserve")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Reserve from Current Line")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(CancelReservationCurrentLine)
        {



            Promoted = true;
            PromotedIsBig = true;
        }
    }


}

