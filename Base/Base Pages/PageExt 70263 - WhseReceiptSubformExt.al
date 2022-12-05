pageextension 70263 WhseReceiptSubformExt extends "Whse. Receipt Subform"
{


    layout
    {


        /* modify("Control1")
         {



             ShowCaption = false;
         }*/


        addafter(Description)
        {
            field("Quantity Accepted"; Rec."Quantity Accepted")
            {
                ApplicationArea = All;
            }
            field("Quantity Rework"; Rec."Quantity Rework")
            {
                ApplicationArea = All;
            }
            field("Quantity Rejected"; Rec."Quantity Rejected")
            {
                ApplicationArea = All;
            }
            field("Qty. Sending To Quality"; Rec."Qty. Sending To Quality")
            {
                ApplicationArea = All;
            }
            field("Qty. Sent To Quality"; Rec."Qty. Sent To Quality")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {


        addafter(ItemTrackingLines)
        {
            group(Inspection)
            {
                Caption = 'Inspection';
                action("Inspection Data Sheets")
                {
                    Caption = 'Inspection Data Sheets';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #5768. Unsupported part was commented. Please check it.
                        /*CurrPage.WhseReceiptLines.Page.*/
                        _ShowDataSheets;

                    end;
                }
                action(Action1901755704)
                {
                    Caption = 'Inspection Data Sheets';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #5768. Unsupported part was commented. Please check it.
                        /*CurrPage.WhseReceiptLines.Page.*/
                        _ShowPostDataSheets;

                    end;
                }
                action("Inspection &Receipts")
                {
                    Caption = 'Inspection &Receipts';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #5768. Unsupported part was commented. Please check it.
                        /*CurrPage.WhseReceiptLines.Page.*/
                        _ShowInspectReceipt;

                    end;
                }
                action("Posted I&nspection Receipts")
                {
                    Caption = 'Posted I&nspection Receipts';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #5768. Unsupported part was commented. Please check it.
                        /*CurrPage.WhseReceiptLines.Page.*/
                        _ShowPostInspectReceipt;

                    end;
                }
            }
        }
        addafter(ItemTrackingLines)
        {
            action("Create Inspection Data &Sheets")
            {
                Caption = 'Create Inspection Data &Sheets';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //This functionality was copied from page #5768. Unsupported part was commented. Please check it.
                    /*CurrPage.WhseReceiptLines.Page.*/
                    _CreateInspectionDataSheets;

                end;
            }
        }
    }





    procedure "--QC"();
    begin
    end;

    procedure _CreateInspectionDataSheets();
    begin
        Rec.CreateInspectionDataSheets;
    end;


    procedure _ShowDataSheets();
    var
        InspectDataSheet: Record "Inspection Datasheet Header";
    begin
        Rec.ShowDataSheets;
    end;





    procedure _ShowPostDataSheets();
    var
        PostInspectDataSheet: Record "Posted Inspect DatasheetHeader";
    begin
        Rec.ShowPostDataSheets;
    end;




    procedure _ShowInspectReceipt();
    var
        InspectionReceipt: Record "Inspection Receipt Header";
    begin
        Rec.ShowInspectReceipt;
    end;




    procedure _ShowPostInspectReceipt();
    var
        InspectionReceipt: Record "Inspection Receipt Header";
    begin
        Rec.ShowPostInspectReceipt;
    end;




}

