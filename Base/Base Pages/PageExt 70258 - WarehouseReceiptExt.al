pageextension 70258 WarehouseReceiptExt extends "Warehouse Receipt"
{


    layout
    {


    }
    actions
    {



        modify("Posted &Whse. Receipts")
        {



            Promoted = true;



        }



        modify("Use Filters to Get Src. Docs.")
        {


            Promoted = true;



        }
        modify("Get Source Documents")
        {



            Promoted = true;


        }



        modify("Autofill Qty. to Receive")
        {
            Promoted = true;
            PromotedIsBig = true;


        }


        modify(CalculateCrossDock)
        {
            Promoted = true;
        }



        modify("Post Receipt")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Post and &Print")
        {
            Promoted = true;
            PromotedIsBig = true;


        }
        modify("Post and Print P&ut-away")
        {
            Promoted = true;
            PromotedIsBig = true;



        }
        modify("&Print")
        {



            Promoted = true;


        }
        addafter(CalculateCrossDock)
        {
            separator(Action1102152000)
            {
            }
        }
    }




}

