/*pageextension 70052 ExciseEntriesExt extends "Excise Entrirs"
{


    layout
    {


        modify("Control 1")
        {



            ShowCaption = false;
        }


        addfirst("Control 1")
        {
            field("Item No."; "Item No.")
            {
                Editable = true;
                ApplicationArea = All;
            }
        }
    }
    actions
    {


        modify("&Navigate")
        {
            Promoted = true;


        }
    }



}*/

