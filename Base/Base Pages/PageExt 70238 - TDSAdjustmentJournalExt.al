pageextension 70238 TDSAdjustmentJournalExt extends "TDS Adjustment Journal"
{


    layout
    {



        /*modify("Control 30")
        {


            ShowCaption = false;
        }*/




        addafter(Line)
        {
            group("Work Date")
            {
                Caption = 'Work Date';
                field(WorkDate; WORKDATE)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {


    }




}

