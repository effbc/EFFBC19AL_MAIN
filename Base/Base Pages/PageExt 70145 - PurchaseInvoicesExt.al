pageextension 70145 PurchaseInvoicesExt extends "Purchase Invoices"
{


    layout
    {



        addbefore(Control1)
        {

            field("xRec.COUNT"; xRec.COUNT)
            {
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
        }
        addafter("Buy-from Vendor Name")
        {
            field("USER ID"; rec."USER ID")
            {
                ApplicationArea = All;
            }
        }
        addafter("Job Queue Status")
        {

            field("Vendor Invoice Date"; rec."Vendor Invoice Date")
            {
                ApplicationArea = All;
            }
            /* field(Structure; Rec.structure)
             {
                 ApplicationArea = All;
             }*/
            field("Sales Order Ref No."; rec."Sales Order Ref No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {


        modify(Statistics)
        {
            Promoted = true;
        }


        modify(PostAndPrint)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(PostBatch)
        {
            Promoted = true;
        }
    }



}

