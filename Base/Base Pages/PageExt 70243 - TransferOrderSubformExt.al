pageextension 70243 TransferOrderSubformExt extends "Transfer Order Subform"
{

    layout
    {



        /*  modify("Control1")
          {


              ShowCaption = false;
          }*/


        addbefore("Transfer-from Bin Code")
        {
            /* field("Excise Prod. Posting Group"; Rec."Excise Prod. Posting Group")
             {
                 ApplicationArea = All;
             }
             field("Excise Bus. Posting Group"; Rec."Excise Bus. Posting Group")
             {
                 ApplicationArea = All;
             }*/
        }
        addafter("Appl.-to Item Entry")
        {
            field("DL Model"; Rec."DL Model")
            {
                ApplicationArea = All;
            }
            field(Type; Rec.Type)
            {
                ApplicationArea = All;
            }
            field(Station; Rec.Station)
            {
                ApplicationArea = All;
            }
            field("Station Name"; Rec."Station Name")
            {
                ApplicationArea = All;
            }
            field("Requirement Reason"; Rec."Requirement Reason")
            {
                ApplicationArea = All;
            }
            field("Required Date"; Rec."Required Date")
            {
                ApplicationArea = All;
            }
            field(Priority; Rec.Priority)
            {
                ApplicationArea = All;
            }
            field("Promised Receipt Date"; Rec."Promised Receipt Date")
            {
                ApplicationArea = All;
            }
            field("Status."; Rec."Status.")
            {
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    StatusOnAfterValidate;
                end;
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
            field(Reason; Rec.Reason)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {


        addafter(Reserve)
        {
            action("Create Inspection Data &Sheets")
            {
                Caption = 'Create Inspection Data &Sheets';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //This functionality was copied from page #5740. Unsupported part was commented. Please check it.
                    /*CurrPage.TransferLines.Page.*/
                    _CreateInspectionDataSheets;

                end;
            }
        }
        addafter(Receipt)
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
                        //This functionality was copied from page #5740. Unsupported part was commented. Please check it.
                        /*CurrPage.TransferLines.Page.*/
                        Rec.ShowDataSheets();

                    end;
                }
                action("Posted Inspection Data Sheets")
                {
                    Caption = 'Posted Inspection Data Sheets';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #5740. Unsupported part was commented. Please check it.
                        /*CurrPage.TransferLines.Page.*/
                        Rec.ShowDataSheets();

                    end;
                }
                action("Inspection &Receipts")
                {
                    Caption = 'Inspection &Receipts';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #5740. Unsupported part was commented. Please check it.
                        /*CurrPage.TransferLines.Page.*/
                        Rec.ShowInspectReceipt();

                    end;
                }
                action("Posted I&nspection Receipts")
                {
                    Caption = 'Posted I&nspection Receipts';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #5740. Unsupported part was commented. Please check it.
                        /*CurrPage.TransferLines.Page.*/
                        Rec.ShowPostInspectReceipt();

                    end;
                }
            }
        }
    }




    var
    // StrOrderLineDetailsPage: Page "Structure Order Line Details";



    /* procedure StrOrderLineDetailsPage();
     begin
     end;*/






    procedure _CreateInspectionDataSheets();
    begin
        Rec.CreateInspectionDataSheets;
    end;


    /* procedure CreateInspectionDataSheets();
     begin
         Rec.CreateInspectionDataSheets;
     end;*/


    procedure _ShowDataSheets();
    var
        InspectDataSheet: Record "Inspection Datasheet Header";
    begin
        Rec.ShowDataSheets;
    end;


    /* procedure ShowDataSheets();
     var
         InspectDataSheet: Record "Inspection Datasheet Header";
     begin
         Rec.ShowDataSheets;
     end;*/

    procedure _ShowPostDataSheets();
    var
        PostInspectDataSheet: Record "Posted Inspect DatasheetHeader";
    begin
        Rec.ShowPostDataSheets;
    end;


    /*procedure ShowPostDataSheets();
    var
        PostInspectDataSheet: Record "Posted Inspect DatasheetHeader";
    begin
        Rec.ShowPostDataSheets;
    end;*/


    procedure _ShowInspectReceipt();
    var
        InspectionReceipt: Record "Inspection Receipt Header";
    begin
        Rec.ShowInspectReceipt;
    end;


    /*procedure ShowInspectReceipt();
    var
        InspectionReceipt: Record "Inspection Receipt Header";
    begin
        Rec.ShowInspectReceipt;
    end;*/


    procedure _ShowPostInspectReceipt();
    var
        InspectionReceipt: Record "Inspection Receipt Header";
    begin
        Rec.ShowPostInspectReceipt;
    end;


    /*procedure ShowPostInspectReceipt();
    var
        InspectionReceipt: Record "Inspection Receipt Header";
    begin
        Rec.ShowPostInspectReceipt;
    end;*/


    procedure CancelInspection(var QualityStatus: Text[50]);
    begin
        Rec.TESTFIELD("QC Enabled");
        Rec."Cancel Inspection"(QualityStatus);
    end;


    procedure CloseInspection(var QualityStatus: Text[50]);
    begin
        Rec.TESTFIELD("QC Enabled");
        Rec."Close Inspection"(QualityStatus);
    end;


    procedure "AssignSerialNo."();
    begin
        Rec.AssignSerialNo;
    end;


    procedure _QCOverride();
    begin
        Rec.QCOverride;
    end;


    procedure AllowExcessQty();
    begin
        IF USERID = 'SUPER' THEN
            IF Rec."Allow Excess Qty." = FALSE THEN BEGIN
                Rec."Allow Excess Qty." := TRUE;
                Rec.MODIFY;
            END;
    end;


    local procedure StatusOnAfterValidate();
    begin
        IF Rec."Status." = Rec."Status."::ToBePlanned THEN BEGIN
            Rec.TESTFIELD(Remarks);
        END;
    end;


    local procedure PromisedReceiptDateOnInputChan(var Text: Text[1024]);
    begin
        IF Rec."Promised Receipt Date" > 0D THEN
            Rec.TESTFIELD(Remarks);
    end;


    local procedure ReasonOnInputChange(var Text: Text[1024]);
    begin
        ERROR('Please Enter the Reason In "Required Reason Field"');
    end;



}

