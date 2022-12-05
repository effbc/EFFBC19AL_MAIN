pageextension 70082 ItemReclassJournalExt extends 393
{
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        }
        modify(Control22)
        {
            ShowCaption = false;
        }
        modify(Control1900669001)
        {
            ShowCaption = false;
        } */
        addafter(Description)
        {
            field("Qty. At Location Code"; Rec."Qty. At Location Code")
            {
                ApplicationArea = All;
            }
            field("ITL Doc No."; Rec."ITL Doc No.")
            {
                Caption = 'Prod. Order No.';
                ApplicationArea = All;
            }
            field("ITL Doc Line No."; Rec."ITL Doc Line No.")
            {
                Caption = 'Prod. Order Line No.';
                ApplicationArea = All;
            }
            field("ITL Doc Ref Line No."; Rec."ITL Doc Ref Line No.")
            {
                Caption = 'Prod. Order Component Line No.';
                ApplicationArea = All;
            }
        }
        addafter("Reason Code")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("Ledger E&ntries")
        {
            Promoted = false;
        }
        modify(Post)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Post and &Print")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("&Print")
        {
            Promoted = true;
        }
        addafter("Get Bin Content")
        {
            separator(Action1102152000)
            {
            }
            action("Copy Prod.Orders")
            {
                Caption = 'Copy Prod.Orders';
                ApplicationArea = All;

                trigger OnAction();
                var
                    ItemJournalLine: Record "Item Journal Line";
                begin
                    CLEAR(CopyProdOrder);
                    CopyProdOrder.RUNMODAL;
                end;
            }
            separator(Action1102152002)
            {
            }
            action("Assign Item Tracking")
            {
                Caption = 'Assign Item Tracking';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    AssignItemTracking.AssignTrackingRCJ(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Document No.");
                    CurrPage.UPDATE(FALSE);
                    MESSAGE('Item Tracking Lines are Assigned');
                end;
            }
        }
    }



    var
        "--B2B--": Integer;
        CopyProdOrder: Report "Copy Pord. Order";
        ReclassJournalLine: Record "Item Journal Line";
        AssignItemTracking: Codeunit "Assigning Serial & Lot Numbers";



}

