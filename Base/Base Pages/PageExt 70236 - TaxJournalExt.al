/*pageextension 70236 TaxJournalExt extends "Tax Journal"
{
            object id 16351
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
        modify("Control 36")
        {


            ShowCaption = false;
        }



        addafter("Control 30")
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
    }



}*/

