pageextension 70093 JournalVoucherExt extends "Journal Voucher"
{

    layout
    {



        /* modify("Control 1")
         {



             ShowCaption = false;
         }


         modify("Control 1500010")
         {


             ShowCaption = false;
         }
         modify("Control 1905841301")
         {


             ShowCaption = false;
         }*/

        addafter(Control1)
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



        /* modify("Action 91")
         {


             Promoted = false;



         }



         modify("Action 1502039")
         {
             Promoted = true;
             PromotedIsBig = true;


         }


         modify("Action 1500035")
         {
             Promoted = false;


         }
         modify("Action 1500036")
         {
             Promoted = false;


         }



         modify("Action 50")
         {
             Promoted = true;
             PromotedIsBig = true;


         }
         modify("Action 51")
         {
             Promoted = true;
             PromotedIsBig = true;


         }*/
        modify(Preview)
        {
            Promoted = false;
        }


        modify(Approve)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Reject)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Delegate)
        {
            Promoted = true;
        }

    }




}

