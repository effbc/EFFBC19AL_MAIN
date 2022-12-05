pageextension 70173 RevaluationJournalExt extends "Revaluation Journal"
{

    layout
    {



        /*  modify("Control1")
          {



              ShowCaption = false;
          }


          modify("Control22")
          {


              ShowCaption = false;
          }
          modify(Control1900669001)
          {


              ShowCaption = false;
          }*/



        addafter("Item Description")
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



        modify("Ledger E&ntries")
        {


            Promoted = false;



        }
        modify("Value Entries")
        {



            Promoted = true;



        }


        modify("Calculate Inventory Value - Test")
        {



            Promoted = true;
            PromotedIsBig = true;


        }
        modify("Calculate Inventory Value")
        {


            Promoted = true;
            PromotedIsBig = true;



        }



        modify("P&ost")
        {
            Promoted = true;
            PromotedIsBig = true;


        }
        modify("Post and &Print")
        {
            Promoted = true;
            PromotedIsBig = true;


        }
    }


}

