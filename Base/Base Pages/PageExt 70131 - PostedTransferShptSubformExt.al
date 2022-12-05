pageextension 70131 PostedTransferShptSubformExt extends "Posted Transfer Shpt. Subform"
{


    layout
    {


        /* modify("Control1")
         {



             ShowCaption = false;
         }*/



        addbefore("Transfer-from Bin Code")
        {
            field("Reason Code"; Rec."Reason Code")
            {
                ApplicationArea = All;
            }
            field("Spec ID"; Rec."Spec ID")
            {
                ApplicationArea = All;
            }
            field("Quantity Accepted"; Rec."Quantity Accepted")
            {
                ApplicationArea = All;
            }
            field("Quantity Rejected"; Rec."Quantity Rejected")
            {
                ApplicationArea = All;
            }
            field("QC Enabled"; Rec."QC Enabled")
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
            field("Qty. Sending To Quality(R)"; Rec."Qty. Sending To Quality(R)")
            {
                ApplicationArea = All;
            }
            field("Position Reference No."; Rec."Position Reference No.")
            {
                ApplicationArea = All;
            }
        }
        addbefore("Unit of Measure Code")
        {
            field("Allow Excess Qty."; Rec."Allow Excess Qty.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Unit Price"; Rec."Unit Price")
            {
                ApplicationArea = All;
            }
            /*field("Excise Amount"; "Excise Amount")
            {
                ApplicationArea = All;
            }

            field("Amount Including Excise"; "Amount Including Excise")
            {
                ApplicationArea = All;
            }
            field("Assessable Value"; "Assessable Value")
            {
                ApplicationArea = All;
            }*/
        }
    }
    actions
    {



        addafter("Item &Tracking Lines")
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
                        //This functionality was copied from page #5743. Unsupported part was commented. Please check it.
                        /*CurrPage.TransferShipmentLines.Page.*/
                        ShowDataSheets;

                    end;
                }
                action("Posted Inspection Data Sheets")
                {
                    Caption = 'Posted Inspection Data Sheets';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #5743. Unsupported part was commented. Please check it.
                        /*CurrPage.TransferShipmentLines.Page.*/
                        ShowPostDataSheets;

                    end;
                }
                action("Inspection &Receipts")
                {
                    Caption = 'Inspection &Receipts';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #5743. Unsupported part was commented. Please check it.
                        /*CurrPage.TransferShipmentLines.Page.*/
                        ShowInspectReceipt;

                    end;
                }
                action("Posted I&nspection Receipts")
                {
                    Caption = 'Posted I&nspection Receipts';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #5743. Unsupported part was commented. Please check it.
                        /*CurrPage.TransferShipmentLines.Page.*/
                        ShowPostInspectReceipt;

                    end;
                }
            }
        }
    }




    var
    //StrOrderLineDetailsPage: Page "Posted Str Order Line Details";



    /*procedure StrOrderLineDetailsPage();
    begin
    end;*/





    procedure "----B2B---"();
    begin
    end;


    procedure ShowDataSheets();
    var
        InspectDataSheet: Record "Inspection Datasheet Header";
    begin
        InspectDataSheet.SETRANGE("Trans. Order No.", Rec."Transfer Order No.");
        InspectDataSheet.SETRANGE("Trans. Order Line", Rec."Transfer Order Line No.");
        InspectDataSheet.SETRANGE("Source Type", InspectDataSheet."Source Type"::"In Bound");
        PAGE.RUN(PAGE::"Inspection Data Sheet List", InspectDataSheet);
    end;


    procedure ShowPostDataSheets();
    var
        PostInspectDataSheet: Record "Posted Inspect DatasheetHeader";
    begin
        PostInspectDataSheet.SETRANGE("Trans. Order No.", Rec."Transfer Order No.");
        PostInspectDataSheet.SETRANGE("Trans. Order Line", Rec."Transfer Order Line No.");
        PostInspectDataSheet.SETRANGE("Source Type", PostInspectDataSheet."Source Type"::"In Bound");
        PAGE.RUN(PAGE::"Posted Inspect Data Sheet List", PostInspectDataSheet);
    end;


    procedure ShowInspectReceipt();
    var
        InspectionReceipt: Record "Inspection Receipt Header";
    begin
        InspectionReceipt.SETRANGE("Trans. Order No.", Rec."Transfer Order No.");
        InspectionReceipt.SETRANGE("Trans. Order Line", Rec."Transfer Order Line No.");
        InspectionReceipt.SETRANGE("Source Type", InspectionReceipt."Source Type"::"In Bound");
        InspectionReceipt.SETRANGE(Status, FALSE);
        PAGE.RUN(PAGE::"Inspection Receipt List", InspectionReceipt);
    end;


    procedure ShowPostInspectReceipt();
    var
        InspectionReceipt: Record "Inspection Receipt Header";
    begin
        InspectionReceipt.SETRANGE("Trans. Order No.", Rec."Transfer Order No.");
        InspectionReceipt.SETRANGE("Trans. Order Line", Rec."Transfer Order Line No.");
        InspectionReceipt.SETRANGE("Source Type", InspectionReceipt."Source Type"::"In Bound");
        InspectionReceipt.SETRANGE(Status, TRUE);
        PAGE.RUN(PAGE::"Inspection Receipt List", InspectionReceipt);
    end;



}

