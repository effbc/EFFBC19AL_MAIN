pageextension 70255 VendorDetailsFactBoxExt extends "Vendor Details FactBox"
{


    layout
    {


        addafter("Phone No.")
        {
            field("Phone No2"; Rec."Phone No2")
            {
                ApplicationArea = All;
            }
            field("Phone No3"; Rec."Phone No3")
            {
                ApplicationArea = All;
            }
            field("Mobile No."; Rec."Mobile No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {


    }


}

