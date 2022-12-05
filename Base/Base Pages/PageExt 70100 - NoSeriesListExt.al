pageextension 70100 NoSeriesListExt extends "No. Series List"
{

    layout
    {



        /*  modify("Control1")
          {



              ShowCaption = false;
          }*/


    }
    actions
    {


        modify(Lines)
        {



            Promoted = true;
            PromotedIsBig = true;



        }
        modify(Relationships)
        {



            Promoted = true;


        }
    }
    var
        Editable: Boolean;



}

