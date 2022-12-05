pageextension 70212 ServiceMgtSetupExt extends "Service Mgt. Setup"
{


    layout
    {

        addafter("Service Credit Memo Nos.")
        {
            field("Last DC No."; Rec."Last DC No.")
            {
                ApplicationArea = All;
            }
        }
    }


    var
        CF: Codeunit "Cash Flow Connection";


}

