pageextension 70005 AnalysisViewEntriesExt extends "Analysis View Entries"
{


    layout
    {


        /*modify("Control1")
        {

           

            ShowCaption = false;
        }*/



        addafter("Dimension 2 Value Code")
        {
            field("Entry No."; Rec."Entry No.")
            {
                ApplicationArea = All;
            }
        }
    }



}

