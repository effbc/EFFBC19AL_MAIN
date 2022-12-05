pageextension 70027 ChangeLogEntriesExt extends "Change Log Entries"
{

    layout
    {



        /*modify("Control1")
        {

          

            ShowCaption = false;
        }*/



    }
    actions
    {



        modify("&Print")
        {
            Promoted = true;



        }
        modify(Setup)
        {



            Promoted = true;
            PromotedIsBig = true;
        }
    }



    var
        ClEditable: Boolean;



}

