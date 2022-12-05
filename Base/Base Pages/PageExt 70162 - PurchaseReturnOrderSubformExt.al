pageextension 70162 PurchaseReturnOrderSubformExt extends "Purchase Return Order Subform"
{


    layout
    {



        /*modify("Control1")
        {

           

            ShowCaption = false;
        }*/



        addafter(ShortcutDimCode8)
        {
            field("QC Enabled"; Rec."QC Enabled")
            {
                ApplicationArea = All;
            }
            field("Spec ID"; Rec."Spec ID")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {


    }
}

