/*pageextension 70218 ServiceTaxEntriesExt extends "Service Tax Entries"
{


    layout
    {



        modify("Control 1280000")
        {


            ShowCaption = false;
        }


        modify("Control 1500012")
        {
            Visible = false;
        }
        addafter("Control 1500010")
        {
         field("Service Tax SBC Amount"; "Service Tax SBC Amount")
            {
                Editable = true;
                ApplicationArea = All;
            }
        }
    }
    actions
    {



        modify("Action 1280033")
        {
            Promoted = true;


        }
        modify("Action 1280024")
        {


            Promoted = true;


        }
    }



}*/

