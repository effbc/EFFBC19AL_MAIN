pageextension 70244 TransferOrderExt extends "Transfer Order"
{


    layout
    {



        modify("Transfer-from Post Code")
        {


            CaptionML = ENU = 'Transfer-from Post Code/City';


        }


        modify("Transfer-to Post Code")
        {



            CaptionML = ENU = 'Transfer-to Post Code/City';



        }



        addafter("Transfer-to Code")
        {
            field("Customer No."; Rec."Customer No.")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        addbefore("Posting Date")
        {
            field("Sales Order No."; Rec."Sales Order No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Posting Date")
        {
            field("User ID"; Rec."User ID")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Released Date"; Rec."Released Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Released By"; Rec."Released By")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Released Time"; Rec."Released Time")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Created Date Time"; Rec."Created Date Time")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Assigned User ID")
        {
            field("External Document No."; Rec."External Document No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Way Bill No."; Rec."Way Bill No.")
            {
                Caption = 'Way Bill No.';
                ApplicationArea = All;
            }
            field("<Mode of Transport 2>"; Rec."Mode of Transport")
            {
                CaptionML = ENU = 'Mode of Transport',
                            ENN = 'Mode of Transport';
                ApplicationArea = All;
            }
            field("<Vehicle No. 2>"; Rec."Vehicle No.")
            {
                CaptionML = ENU = 'Vehicle No.',
                            ENN = 'Vehicle No.';
                ApplicationArea = All;
            }
        }
        addafter("Transfer-from Contact")
        {
            field("Due Date"; Rec."Due Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipping Advice")
        {
            field("Required Date"; Rec."Required Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Receipt Date")
        {
            /* field("<Structure2>"; Structure)
             {
                 ApplicationArea = All;
             }
             field("Form Code"; "Form Code")
             {
                 ApplicationArea = All;
             }
             field("Form No."; "Form No.")
             {
                 ApplicationArea = All;
             }*/
            field("<Shortcut Dimension 1 Code2>"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("<Shortcut Dimension 2 Code3>"; Rec."Shortcut Dimension 2 Code")
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



        modify("&Print")
        {



            Promoted = true;


        }

        modify("Reo&pen")
        {
            Promoted = true;


        }



        modify(Post)
        {


            Promoted = true;
            PromotedIsBig = true;
        }
        modify(PostAndPrint)
        {
            Promoted = true;
            PromotedIsBig = true;
        }



        modify("Inventory - Inbound Transfer")
        {


            Promoted = true;


        }



        addafter("Reo&pen")
        {
            separator(Action1102152043)
            {
            }
            action("Assign Serial No's")
            {
                Caption = 'Assign Serial No''s';
                Visible = false;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //B2B
                    CurrPage.TransferLines.PAGE."AssignSerialNo.";
                    //B2B
                end;
            }
            separator(Action1102152010)
            {
            }
            group(Inspection)
            {
                Caption = 'Inspection';
                action("Cancel Inspection")
                {
                    Caption = 'Cancel Inspection';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        QualityStatusValue: Text[50];
                    begin
                        IF CONFIRM(Text33000260, FALSE) THEN BEGIN
                            QualityStatusValue := 'Cancel';
                            CurrPage.TransferLines.PAGE.CancelInspection(QualityStatusValue);
                            CurrPage.UPDATE(FALSE);
                        END;
                    end;
                }
                action("Short Clost Inspection")
                {
                    Caption = 'Short Clost Inspection';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        QualityStatusValue: Text[50];
                    begin
                        IF CONFIRM(Text33000261, FALSE) THEN BEGIN
                            QualityStatusValue := 'Close';
                            CurrPage.TransferLines.PAGE.CloseInspection(QualityStatusValue);
                            CurrPage.UPDATE(FALSE);
                        END;
                    end;
                }
            }
            separator(Action1102152044)
            {
            }
            action("QC Override")
            {
                Caption = 'QC Override';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    CurrPage.TransferLines.PAGE._QCOverride();
                    CurrPage.UPDATE(FALSE);
                end;
            }
            separator(Action1102152046)
            {
            }
            action("Allow Excess Qty.")
            {
                Caption = 'Allow Excess Qty.';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    CurrPage.TransferLines.PAGE.AllowExcessQty;
                    CurrPage.UPDATE(FALSE);
                end;
            }
        }
        addafter("Get Bin Content")
        {
            separator(Action1102152018)
            {
            }
            action("Copy &Prod. Order Components")
            {
                Caption = 'Copy &Prod. Order Components';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Rec.CheckOperationNo;
                    CurrPage.UPDATE;
                end;
            }
            action("Copy &Sale Order Components")
            {
                Caption = 'Copy &Sale Order Components';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Rec.TESTFIELD("Sales Order No.");
                    Rec.CopySalesOrderComponents;
                end;
            }
            separator(Action1102152020)
            {
            }
            action("Assign Itemtracking Lines")
            {
                Caption = 'Assign Itemtracking Lines';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Rec.TESTFIELD("No.");
                    AssignItemtracking.AssignTracking(Rec);
                    CurrPage.UPDATE(FALSE);
                    /*
                    TESTFIELD("No.");
                    AssignItemtracking.CheckInventory(Rec);
                    CurrPage.UPDATE(FALSE);
                    */

                end;
            }
        }
    }




    var
        ItemTrackingLine: Page "Item Tracking Lines";
        Text33000260: Label 'Do you want to Cancel Quality Inspection?';
        Text33000261: Label 'Do you want to Close Quality Inspection?';
        TransferHeader: Record "Transfer Header";
        AssignItemtracking: Codeunit "Assigning Serial & Lot Numbers";
        TransLine: Record "Transfer Line";


}

