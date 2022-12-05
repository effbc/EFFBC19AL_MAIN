/*pageextension 70094 LCJournalExt extends "LC Journal"
{


    layout
    {



        modify("Control 1")
        {



            ShowCaption = false;
        }


        modify("Control 30")
        {



            ShowCaption = false;
        }
        modify("Control 1901776101")
        {



            ShowCaption = false;
        }


        addafter("Control 1901652501")
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



        modify("Action 50")
        {
            Promoted = true;
            PromotedIsBig = true;



        }
        modify("Action 51")
        {
            Promoted = true;
            PromotedIsBig = true;



        }
    }




}*/

