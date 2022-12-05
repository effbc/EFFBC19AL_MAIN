pageextension 70178 SalesCrMemoSubformExt extends "Sales Cr. Memo Subform"
{
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        }
        modify(Control39)
        {
            ShowCaption = false;
        }
        modify(Control35)
        {
            ShowCaption = false;
        }
        modify(Control17)
        {  
            ShowCaption = false;
        }
        modify(RefreshTotals)
        {
            ShowCaption = false;
        } */
        /* addbefore("IC Partner Code")
         {
             field("Service Tax Group"; "Service Tax Group")
             {
                 ApplicationArea = All;
             }
         }*/ //B2BUPG
        addafter("IC Partner Reference")
        {
            /*field("Excise Prod. Posting Group"; "Excise Prod. Posting Group")
            {
                ApplicationArea = All;
            }*/
        }
        addafter(Description)
        {
            field("Spec ID"; rec."Spec ID")
            {
                ApplicationArea = All;
            }
            field("Quantity Accepted"; rec."Quantity Accepted")
            {
                ApplicationArea = All;
            }
            field("Quantity Rework"; rec."Quantity Rework")
            {
                ApplicationArea = All;
            }
            field("QC Enabled"; rec."QC Enabled")
            {
                ApplicationArea = All;
            }
            field("Quantity Rejected"; rec."Quantity Rejected")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            /* field("Service Tax SBC %"; "Service Tax SBC %")
             {
                 ApplicationArea = All;
             }
             field("Service Tax SBC Amount"; "Service Tax SBC Amount")
             {
                 ApplicationArea = All;
             }
             field("KK Cess%"; "KK Cess%")
             {
                 ApplicationArea = All;
             }
             field("KK Cess Amount"; "KK Cess Amount")
             {
                 ApplicationArea = All;
             }*/
        }
    }
    actions
    {

        addafter("Get Return &Receipt Lines")
        {
            action("Create Inspection Data Sheets")
            {
                Caption = 'Create Inspection Data Sheets';
                Visible = false;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //This functionality was copied from page #44. Unsupported part was commented. Please check it.
                    /*CurrPage.SalesLines.Page.*/
                    CreateInspectionDataSheetForm;

                end;
            }
        }
        addafter(Dimensions)
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
                        //This functionality was copied from page #44. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        ShowDataSheetsForm;

                    end;
                }
                action("Posted Inspection Data Sheets")
                {
                    Caption = 'Posted Inspection Data Sheets';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #44. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        ShowPostDataSheetsForm;

                    end;
                }
                action("Inspection &Receipts")
                {
                    Caption = 'Inspection &Receipts';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #44. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        ShowInspectReceiptForm;

                    end;
                }
                action("Posted I&nspection Receipts")
                {
                    Caption = 'Posted I&nspection Receipts';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #44. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        ShowPostInspectReceiptForm;

                    end;
                }
            }
        }
    }



    procedure StrOrderLineDetailsPage();
    begin
    end;





 

    procedure ShowDataSheetsForm();
    var
        InspectDataSheet: Record "Inspection Datasheet Header";
    begin
        Rec.ShowDataSheets;
    end;


    procedure ShowPostDataSheetsForm();
    var
        PostInspectDataSheet: Record "Posted Inspect DatasheetHeader";
    begin
        Rec.ShowPostDataSheets;
    end;


    procedure ShowInspectReceiptForm();
    var
        InspectionReceipt: Record "Inspection Receipt Header";
    begin
        Rec.ShowInspectReceipt;
    end;


    procedure ShowPostInspectReceiptForm();
    var
        InspectionReceipt: Record "Inspection Receipt Header";
    begin
        Rec.ShowPostInspectReceipt;
    end;


    procedure CreateInspectionDataSheetForm();
    begin
        Rec.CreateInspectionDataSheets;
    end;


    procedure _CancelInspection(var QualityStatus: Text[50]);
    begin
        Rec.TESTFIELD("No.");
        Rec.TESTFIELD("QC Enabled");
        Rec.CancelInspection(QualityStatus);
    end;


    procedure _CloseInspection(var QualityStatus: Text[50]);
    begin
        Rec.TESTFIELD("No.");
        Rec.TESTFIELD("QC Enabled");
        Rec.CloseInspection(QualityStatus);
    end;



}

