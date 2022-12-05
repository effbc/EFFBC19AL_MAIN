pageextension 70020 BinTypesExt extends "Bin Types"
{


    layout
    {



        /* modify("Control1")
         {



             ShowCaption = false;
         }


         modify("Control 2")
         {
             Visible = false;
         }*/
        addfirst("Control1")
        {
            field("Item No"; Rec."Item No")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field(QTY; Rec.QTY)
            {
                ApplicationArea = All;
            }
            field("Material Required Day"; Rec."Material Required Day")
            {
                ApplicationArea = All;
            }
        }
    }



}

