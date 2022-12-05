pageextension 70139 PurchCrMemoSubformExt extends "Purch. Cr. Memo Subform"
{
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        }
        modify(Control47)
        {
            ShowCaption = false;
        }
        modify(Control41)
        {
            ShowCaption = false;
        }
        modify(Control23)
        {
            ShowCaption = false;
        }
        modify(RefreshTotals)
        {
            ShowCaption = false;
        } */
        addafter("Variant Code")
        {
            /*field("Excise Bus. Posting Group"; "Excise Bus. Posting Group")
             {
                 ApplicationArea = All;
             }
             field("VAT Calculation Type"; Rec.AT Calculation Type")
             {
                 ApplicationArea = All;
             }*/
        }
        addafter("VAT Prod. Posting Group")
        {

            /* field("Excise Prod. Posting Group"; "Excise Prod. Posting Group")
             {
                 ApplicationArea = All;
             }
         }
         addafter("Qty. Assigned")
         {
           /*  field("GST Jurisdiction Type"; "GST Jurisdiction Type")
             {
                 ApplicationArea = All;
             }
             field("GST %"; "GST %")
             {
                 ApplicationArea = All;
             }*/
        }
        addafter(ShortcutDimCode8)
        {
            /*field("Tax %"; "Tax %")
            {
                Editable = true;
                ApplicationArea = All;
            }*/
            /*field("Service Tax Group"; "Service Tax Group")
            {
                ApplicationArea = All;
            }
            field("Service Tax Registration No."; "Service Tax Registration No.")
            {
                ApplicationArea = All;
            }
            field("Service Tax Amount"; "Service Tax Amount")
            {
                ApplicationArea = All;
            }
            field("Service Tax SBC Amount"; "Service Tax SBC Amount")
            {
                ApplicationArea = All;
            }
            field("KK Cess Amount"; "KK Cess Amount")
            {
                ApplicationArea = All;
            }*/
            field("QC Enabled"; Rec."QC Enabled")
            {
                ApplicationArea = All;
            }
            field("Spec ID"; Rec."Spec ID")
            {
                ApplicationArea = All;
            }
            field("Qty. to Invoice"; Rec."Qty. to Invoice")
            {
                ApplicationArea = All;
            }
            field("Qty. to Receive"; Rec."Qty. to Receive")
            {
                ApplicationArea = All;
            }
            field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
            {
                ApplicationArea = All;
            }
            field("Return Qty. to Ship"; Rec."Return Qty. to Ship")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {


    }
}
