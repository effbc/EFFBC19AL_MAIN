pageextension 70102 NoSeriesExt extends 456
{


    layout
    {



        /* modify("Control1")
          {



              ShowCaption = false;
          }*/



        /*modify("Control11")
        {
            Visible = false;
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
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //Added by sujani on Dec 11 2019
        IF USERID IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\B2BOTS', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'] THEN
            CurrPage.EDITABLE := TRUE
        ELSE
            CurrPage.EDITABLE := FALSE;
    end;




}

