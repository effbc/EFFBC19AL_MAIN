pageextension 70048 EmployeeCardExt extends "Employee Card"
{


    layout
    {


        modify("Post Code")
        {



            CaptionML = ENU = 'Post Code/City';


        }


        addafter("Phone No.2")
        {
            field("Sanctioning Incharge"; Rec."Sanctioning Incharge")
            {
                ApplicationArea = All;
            }
        }
        addafter("Resource No.")
        {
            field("Manager No."; Rec."Manager No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {






    }

}
