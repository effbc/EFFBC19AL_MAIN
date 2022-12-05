pageextension 70223 ServiceZonesExt extends "Service Zones"
{
    // version NAVW17.00

    layout
    {


        /* modify("Control1")
         {


             ShowCaption = false;
         }*/


        addafter(Description)
        {
            field("Project Manager"; Rec."Project Manager")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {


    }



}

