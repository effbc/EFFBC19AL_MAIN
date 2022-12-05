/*pageextension 70234 TaxEntriesExt extends "Tax Entries"
{
   
            //object id =13716
    layout
    {


        modify("Control 1")
        {


            ShowCaption = false;
        }



        modify("Control 58")
        {
            Visible = false;
        }
        addafter("Control 16")
        {
            field("Account No."; "Account No.")
            {
                ApplicationArea = All;
            }
            field("Tax Group Code"; "Tax Group Code")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {



        modify("Action 1280049")
        {
            Promoted = true;



        }
    }




}*/

