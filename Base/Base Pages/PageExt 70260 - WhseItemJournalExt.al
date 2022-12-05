pageextension 70260 WhseItemJournalExt extends "Whse. Item Journal"
{


    layout
    {


        /*modify("Control1")
        {

           

            ShowCaption = false;
        }

        

        modify("Control22")
        {

          

            ShowCaption = false;
        }
        modify("Control1900669001")
        {

          

            ShowCaption = false;
        }*/



        addafter("Item Description")
        {
            group("Work Date")
            {
                Caption = 'Work Date';
                field(WorkDate; WORKDATE)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {


        modify("Ledger E&ntries")
        {


            Promoted = false;



        }



        modify("&Register")
        {
            Promoted = true;


        }
        modify("Register and &Print")
        {
            Promoted = true;


        }
    }




}

