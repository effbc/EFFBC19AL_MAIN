pageextension 70146 PurchaseJournalExt extends "Purchase Journal"
{


    layout
    {


        /*   modify("Control28")
           {



               ShowCaption = false;
           }
           modify("Control1902205001")
           {



               ShowCaption = false;
           }*/


        /*modify("Control 1000")
        {
            Visible = false;
        }
        modify("Control 1001")
        {
            Visible = false;
        }*/
        addafter("Document No.")
        {
            /*field("Excise Charge"; Rec."Excise Charge")
            {
                ApplicationArea = All;
            }
            field("Form Code"; Rec."Form Code")
            {
                ApplicationArea = All;
            }
            field("Form No."; Rec."Form No.")
            {
                ApplicationArea = All;
            }
            field("Tax %"; Rec."Tax %")
            {
                ApplicationArea = All;
            }*/ //B2BUPG
        }

        addafter("Total Balance")
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



        modify(Dimensions)
        {


            Promoted = true;


        }


        modify("Ledger E&ntries")
        {


            Promoted = false;


        }


        modify("Apply Entries")
        {


            Promoted = true;


        }


        /* modify("Action 1500040")
         {
             Promoted = true;
             PromotedIsBig = true;


         }*/
        /* modify("Update Reference Invoice No")
         {
             Promoted = true;
         }*/



        /* modify(Post)
         {
             Promoted = true;

         }
         modify("Post and &Print")
         {
             Promoted = true;



         }*/


        /*modify(Approve)
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
        modify(Comment)
        {


            Promoted = true;
        }*/
    }




}

