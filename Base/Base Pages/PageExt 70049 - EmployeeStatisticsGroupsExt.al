pageextension 70049 EmployeeStatisticsGroupsExt extends "Employee Statistics Groups"
{


    layout
    {


        /*modify("Control1")
        {

           
            ShowCaption = false;
        }*/



        addafter("Code")
        {
            field("Division Name"; Rec."Division Name")
            {
                ApplicationArea = All;
            }
        }
    }



}

