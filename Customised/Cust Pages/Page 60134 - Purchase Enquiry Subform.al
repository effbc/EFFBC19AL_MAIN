page 60134 "Purchase Enquiry Subform"
{
    // version POAU

    AutoSplitKey = true;
    Caption = 'Purchase Enquiry Subform';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = WHERE("Document Type" = FILTER('Enquiry'));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ShowShortcutDimCode(ShortcutDimCode);
                        //PoAutomation.CheckApprovedVendorInLine("Buy-from Vendor No.","No.");
                        NoOnAfterValidate;
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; "Description 2")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; "Expected Receipt Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("E&xplode BOM")
                {
                    Caption = 'E&xplode BOM';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60133. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        ExplodeBOM;

                    end;
                }
                action("Insert &Ext. Texts")
                {
                    Caption = 'Insert &Ext. Texts';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60133. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        _InsertExtendedText(TRUE);

                    end;
                }
                action("&Attachments")
                {
                    Caption = '&Attachments';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60133. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        OpenAttachments;

                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    action(Period)
                    {
                        Caption = 'Period';
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            //This functionality was copied from page #60133. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.FORM.*/
                            _ItemAvailability(0);

                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            //This functionality was copied from page #60133. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.FORM.*/
                            ItemAvailability(2);
                        end;
                    }
                    action(Location)
                    {
                        Caption = 'Location';
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            //This functionality was copied from page #60133. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.FORM.*/
                            _ItemAvailability(2);

                        end;
                    }
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Type := xRec.Type;
        CLEAR(ShortcutDimCode);
    end;

    var
        TransferExtendedText: Codeunit 378;
        ShortcutDimCode: array[8] of Code[20];
        PoAutomation: Codeunit "PO Automation";


    procedure ApproveCalcInvDisc();
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
    end;


    procedure CalcInvDisc();
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount", Rec);
    end;


    procedure ExplodeBOM();
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM", Rec);
    end;

    /*
        procedure GetPhaseTaskStep();
        begin
            CODEUNIT.RUN(CODEUNIT::Codeunit75, Rec);
        end;

    */
    procedure _InsertExtendedText(Unconditionally: Boolean);
    begin
        IF TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD;
            TransferExtendedText.InsertPurchExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
            UpdateForm(TRUE);
    end;


    procedure InsertExtendedText(Unconditionally: Boolean);
    begin
        IF TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD;
            TransferExtendedText.InsertPurchExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
            UpdateForm(TRUE);
    end;


    procedure _ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin);
    begin
        //Rec.InitType(AvailabilityType); //B2b1.0
    end;


    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin);
    begin
        //Rec.InitType(AvailabilityType); //B2b1.0
    end;


    /* procedure ShowDimensions();
     begin
         Rec.ShowDimensions;
     end;*/


    procedure ItemChargeAssgnt();
    begin
        Rec.ShowItemChargeAssgnt;
    end;


    /* procedure OpenItemTrackingLines();
     begin
         Rec.OpenItemTrackingLines;
     end;*/


    procedure UpdateForm(SetSaveRecord: Boolean);
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;


    procedure "---NAVIN---"();
    begin
    end;

    /*
        procedure ShowStrDetailsForm();
        var
            StrOrderLineDetails: Record "Structure Order Line Details";
            StrOrderLineDetailsForm: Page "Structure Order Line Details";
        begin
            StrOrderLineDetails.RESET;
            StrOrderLineDetails.SETRANGE(Type, StrOrderLineDetails.Type::Purchase);
            StrOrderLineDetails.SETRANGE("Document Type", "Document Type");
            StrOrderLineDetails.SETRANGE("Document No.", "Document No.");
            StrOrderLineDetails.SETRANGE("Item No.", "No.");
            StrOrderLineDetails.SETRANGE("Line No.", "Line No.");
            StrOrderLineDetailsForm.SETTABLEVIEW(StrOrderLineDetails);
            StrOrderLineDetailsForm.RUNMODAL;
        end;
        */


    procedure "---B2B---"();
    begin
    end;


    procedure OpenAttachments();
    begin
        /*Attachment.RESET;
        Attachment.SETRANGE("Table ID",DATABASE::"Purchase Header");
        Attachment.SETRANGE("Document No.","Document No.");
        Attachment.SETRANGE("Document Type","Document Type");
        
        FORM.RUN(FORM::Form60117,Attachment);
         */

    end;


    local procedure NoOnAfterValidate();
    begin
        InsertExtendedText(FALSE);
        IF (Type = Type::"Charge (Item)") AND ("No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
            CurrPage.SAVERECORD;
    end;
}

