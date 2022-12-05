pageextension 70087 ItemTrackingSummaryExt extends "Item Tracking Summary"
{


    layout
    {



        /*modify("Control1")
        {



            ShowCaption = false;
        }


        modify("Control50")
        {



            ShowCaption = false;
        }
        modify("Control1901775901")
        {



            ShowCaption = false;
        }*/



        addafter("Expiration Date")
        {
            field("External Dcument.no"; Rec."External Dcument.no")
            {
                ApplicationArea = All;
            }
        }
    }




    var
        BinContentPage: Page "Bin Content";



    /*  procedure BinContentPage();
      begin
      end;*/




}

