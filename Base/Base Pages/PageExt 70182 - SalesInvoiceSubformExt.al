pageextension 70182 SalesInvoiceSubformExt extends "Sales Invoice Subform"
{
    layout
    {
        /*  modify(Control1)
         {
             ShowCaption = false;
         } */
         modify("Unit Cost (LCY)")
         {
            Editable = true;
         }
        addafter("Deferral Code")
        {
            field("Assessee Code"; Rec."Assessee Code")
            {
                ApplicationArea = All;
            }
            /*field("TCS Type"; "TCS Type")
            {
                ApplicationArea = All;
            }
            field("Total TDS/TCS Incl. SHE CESS"; "Total TDS/TCS Incl. SHE CESS")
            {
                ApplicationArea = All;
            }
            field("TDS/TCS Amount"; "TDS/TCS Amount")
            {
                ApplicationArea = All;
            }
            field("TDS/TCS %"; "TDS/TCS %")
            {
                ApplicationArea = All;
            }*/  //B2BUPG
        }
        addafter(ShortcutDimCode8)
        {
            /* field("Excise Bus. Posting Group"; "Excise Bus. Posting Group")
             {
                 ApplicationArea = All;
             }
             field("Excise Prod. Posting Group"; "Excise Prod. Posting Group")
             {
                 ApplicationArea = All;
             }
             field("Tax Base Amount"; "Tax Base Amount")
             {
                 ApplicationArea = All;
             }*/ //B2B UPG
        }
    }
    actions
    {

    }
}

