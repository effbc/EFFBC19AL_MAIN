pageextension 70142 PurchaseCreditMemoExt extends "Purchase Credit Memo"
{
    layout
    {
        modify("Buy-from Post Code")
        {
            Caption = 'Buy-from Post Code/City';
        }
        modify("Pay-to Post Code")
        {
            CaptionML = ENU = 'Pay-to Post Code/City';
        }
        modify("Ship-to Post Code")
        {
            CaptionML = ENU = 'Ship-to Post Code/City';
        }
        /* modify("Reference Invoice No.")
        {
            HideValue = FALSE;
        } */
        addafter("Vendor Authorization No.")
        {
            field(InvoiceNos; InvoiceNos)
            {
                Caption = 'Debit Note/Invoice No. Series';
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    IF Rec."Posting Date" = 0D THEN
                        ERROR('Enter posting date');
                    Rec.ExtenalDocNo(InvoiceNos, Rec."Posting Date");
                end;
            }
        }
        addafter(Status)
        {
            field("Tarrif Heading No"; Rec."Tarrif Heading No")
            {
                ApplicationArea = All;
            }
        }
        addafter("VAT Bus. Posting Group")
        {
            /*field("Form Code"; "Form Code")
            {
                ApplicationArea = All;
            }*/
            field("Vend. Excise Inv. Date"; Rec."Vend. Excise Inv. Date")
            {
                ApplicationArea = All;
            }
            field("Vendor Excise Invoice No."; Rec."Vendor Excise Invoice No.")
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
        modify(Comment)
        {
            Promoted = true;
        }
        modify(Release)
        {
            Promoted = true;
        }
        modify(ApplyEntries)
        {
            Promoted = true;
        }
        modify("Copy Document")
        {
            Promoted = true;
        }
        /* modify("Update Reference Invoice No")
        {
            Promoted = true;
        } */
        modify(Post)
        {
            Promoted = true;

            trigger OnBeforeAction()
            begin
                IF Rec."Applies-to Doc. No." = '' THEN
                    ERROR('The field Applies to doc no should not be null');
            end;
        }
        modify(PostAndPrint)
        {
            Promoted = true;

        }
        addafter(Post)
        {
            separator(Action1102152000)
            {
            }
            action("Copy Quality Rejected Items")
            {
                Caption = 'Copy Quality Rejected Items';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Rec.CreateCreditmemo;
                end;
            }
        }
    }
    var
        InvoiceNos: Option " ","Debit Note/Invoice No. Series";
}

