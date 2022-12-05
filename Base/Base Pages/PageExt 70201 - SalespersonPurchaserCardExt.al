pageextension 70201 SalespersonPurchaserCardExt extends "Salesperson/Purchaser Card"
{

    layout
    {


        addafter("Next Task Date")
        {
            field("Sales Person Signature"; Rec."Sales Person Signature")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {



        modify(Statistics)
        {


            Promoted = true;


        }



        modify("Create &Interaction")
        {



            Promoted = true;



        }
    }


}

