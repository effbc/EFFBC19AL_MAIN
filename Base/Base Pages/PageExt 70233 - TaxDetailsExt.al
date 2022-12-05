pageextension 70233 TaxDetailsExt extends "Tax Details"
{


    layout
    {



        /* modify("Control1")
         {


             ShowCaption = false;
         }*/



        addafter("Effective Date")
        {
            /* field("Forms Not Applicable"; "Forms Not Applicable")
             {
                 ApplicationArea = All;
             }*/
        }
    }
    actions
    {



        modify("Ledger &Entries")
        {
            Promoted = false;



        }
    }



}

