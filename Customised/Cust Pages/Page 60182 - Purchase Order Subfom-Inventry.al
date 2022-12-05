page 60182 "Purchase Order Subfom-Inventry"
{
    // version NAVW13.70,NAVIN3.70.01.13,QC1.0,Rev01

    AutoSplitKey = true;
    Caption = 'Purchase Order Subfom-Inventry';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Type; Type)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                    end;
                }
                field(Description; Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Depreciation Book Code"; "Depreciation Book Code")
                {
                    ApplicationArea = All;
                }
                field("Description 2"; "Description 2")
                {
                    ApplicationArea = All;
                }
                field("Deviated Receipt Date"; "Deviated Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Part Number"; "Part Number")
                {
                    ApplicationArea = All;
                }
                field(Make; Make)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Package; Package)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. to Receive"; "Qty. to Receive")
                {
                    BlankZero = true;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        "G|L".GET;
                        IF "G|L"."Active ERP-CF Connection" THEN BEGIN
                            IF (Quantity <> "Qty. to Receive") AND ("Qty. to Receive" > 0) AND ("Order Date" > DMY2Date(31, 01, 10)) THEN BEGIN
                                PurchaseHeader.SETRANGE(PurchaseHeader."No.", "Document No.");
                                IF PurchaseHeader.FINDFIRST THEN BEGIN
                                    IF PAYMENT_TERMS.GET(PurchaseHeader."Payment Terms Code") THEN BEGIN
                                        IF (PAYMENT_TERMS."Stage 1" = PAYMENT_TERMS."Stage 1"::Delivery) OR
                                          (PAYMENT_TERMS."Stage 2" = PAYMENT_TERMS."Stage 2"::Delivery) THEN
                                            ERROR(' THERE IS NO PROVISION TO PARTIAL INWARDS FOR "COD" TYPE OF PAYMENT TERMS');
                                    END;
                                END;
                            END;
                        END;
                    end;
                }
                field("Quantity Received"; "Quantity Received")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quantity Rejected"; "Quantity Rejected")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; "Direct Unit Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line Amount"; "Line Amount")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; "Expected Receipt Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Order Date"; "Order Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Indent No."; "Indent No.")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("GST Credit"; "GST Credit")
                {
                    ApplicationArea = All;
                }
                field("GST Group Code"; "GST Group Code")
                {
                    ApplicationArea = All;
                }
                field("GST Group Type"; "GST Group Type")
                {
                    ApplicationArea = All;
                }
                field("HSN/SAC Code"; "HSN/SAC Code")
                {
                    ApplicationArea = All;
                }
                /* field("GST Base Amount";"GST Base Amount")
                 {
                 }
                 field("GST %";"GST %")
                 {
                 }
                 field("Total GST Amount";"t")
                 {
                 }*/
                field(Exempted; Exempted)
                {
                    ApplicationArea = All;
                }
                field("GST Jurisdiction Type"; "GST Jurisdiction Type")
                {
                    ApplicationArea = All;
                }
                field("GST Reverse Charge"; "GST Reverse Charge")
                {
                    ApplicationArea = All;
                }
                field("GST Assessable Value"; "GST Assessable Value")
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
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = AnalysisView;
                    action(Period)
                    {
                        Caption = 'Period';
                        Image = Period;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            //This functionality was copied from page #60183. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.FORM.*/
                            _ItemAvailability(0);

                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        Image = ItemVariant;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            //This functionality was copied from page #60183. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.FORM.*/
                            _ItemAvailability(1);

                        end;
                    }
                    action(Location)
                    {
                        Caption = 'Location';
                        Image = Allocations;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            //This functionality was copied from page #60183. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.FORM.*/
                            _ItemAvailability(2);

                        end;
                    }
                }
                action("Reservation Entries")
                {
                    Caption = 'Reservation Entries';
                    Image = EntriesList;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60183. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        _ShowReservationEntries;

                    end;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60183. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        _OpenItemTrackingLines;

                    end;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60183. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        _ShowDimensions;

                    end;
                }
                action("Item Charge &Assignment")
                {
                    Caption = 'Item Charge &Assignment';
                    Image = FinChargeMemo;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60183. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        ItemChargeAssgnt;

                    end;
                }
                /* action("Structure Details")
                 {
                     Caption = 'Structure Details';
                     Image = TaxDetail;

                     trigger OnAction();
                     begin
                         //This functionality was copied from page #60183. Unsupported part was commented. Please check it.
                         /*CurrPage.PurchLines.FORM.*/
                //ShowStrDetailsForm;  // NAVIN

                // end;}

                group("I&nspection")
                {
                    Caption = 'I&nspection';
                    Image = CheckList;
                    action("Inspection Data Sheets")
                    {
                        Caption = 'Inspection Data Sheets';
                        Image = CheckList;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            //This functionality was copied from page #60183. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.FORM.*/
                            _ShowDataSheets;

                        end;
                    }
                    action("Posted Inspection Data Sheets")
                    {
                        Caption = 'Posted Inspection Data Sheets';
                        Image = CheckRulesSyntax;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            //This functionality was copied from page #60183. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.FORM.*/
                            _ShowPostDataSheets;

                        end;
                    }
                    action("Inspection &Receipts")
                    {
                        Caption = 'Inspection &Receipts';
                        Image = ReceivableBill;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            //This functionality was copied from page #60183. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.FORM.*/
                            _ShowInspectReceipt;

                        end;
                    }
                    action("Posted I&nspection Receipts")
                    {
                        Caption = 'Posted I&nspection Receipts';
                        Image = PostedReceivableVoucher;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            //This functionality was copied from page #60183. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.FORM.*/
                            _ShowPostInspectReceipt;

                        end;
                    }
                    action("Sample Lot Inspection")
                    {
                        Caption = 'Sample Lot Inspection';
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            //This functionality was copied from page #60183. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.FORM.*/
                            _SampleLotInspection;

                        end;
                    }
                    action("Cancel Inspection")
                    {
                        Caption = 'Cancel Inspection';
                        Image = VoidAllChecks;
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            QualityStatusValue: Text[50];
                        begin
                            IF CONFIRM(Text33000260, FALSE) THEN BEGIN
                                QualityStatusValue := 'Cancel';
                                /*CurrPage.PurchLines.PAGE.*/
                                _CancelInspection1(QualityStatusValue);
                                CurrPage.UPDATE(FALSE);
                            END;

                        end;
                    }
                    action("Short Close Inspection")
                    {
                        Caption = 'Short Close Inspection';
                        Image = VoidExpiredCheck;
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            QualityStatusValue: Text[50];
                        begin
                            IF CONFIRM(Text33000261, FALSE) THEN BEGIN
                                QualityStatusValue := 'Close';
                                /*CurrPage.PurchLines.PAGE.*/
                                _CloseInspection1(QualityStatusValue);
                                CurrPage.UPDATE(FALSE);
                            END;

                        end;
                    }
                    separator(Action1102152002)
                    {
                    }
                    action("QC Override")
                    {
                        Caption = 'QC Override';
                        Image = Overdue;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            /*CurrPage.PurchLines.PAGE.*/
                            _QCOverride;
                            CurrPage.UPDATE(FALSE);

                        end;
                    }
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Calculate &Invoice Discount")
                {
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60183. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        ApproveCalcInvDisc;

                    end;
                }
                action("E&xplode BOM")
                {
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60183. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        ExplodeBOM;

                    end;
                }
                action("Insert &Ext. Texts")
                {
                    Caption = 'Insert &Ext. Texts';
                    Image = Text;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60183. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        _InsertExtendedText(TRUE);

                    end;
                }
                /*
                action("Get &Phase/Task/Step")
                {
                    Caption = 'Get &Phase/Task/Step';
                    Ellipsis = true;
                    Image = Task;

                    trigger OnAction();
                    begin
                       
                        GetPhaseTaskStep;

                    end;
                    
                }
                */
                //EFFUPG
                action("&Reserve")
                {
                    Caption = '&Reserve';
                    Ellipsis = true;
                    Image = Reserve;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60183. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        _ShowReservation;

                    end;
                }
                action("Order &Tracking")
                {
                    Caption = 'Order &Tracking';
                    Image = OrderTracking;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60183. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        ShowTracking;

                    end;
                }
                action("&Attachments")
                {
                    Caption = '&Attachments';
                    Image = Attachments;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60183. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        OpenAttachments;

                    end;
                }
                action("Create Inspection Data &Sheets")
                {
                    Caption = 'Create Inspection Data &Sheets';
                    Image = CreateInventoryPickup;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60183. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        _CreateInspectionDataSheets;

                    end;
                }
            }
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    Image = Shipment;
                    action("Sales &Order")
                    {
                        Caption = 'Sales &Order';
                        Image = Sales;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            //This functionality was copied from page #60183. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.FORM.*/
                            OpenSpecOrderSalesOrderForm;

                        end;
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Image = "Order";
                    action(Action1901038504)
                    {
                        Caption = 'Sales &Order';
                        Image = Sales;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            //This functionality was copied from page #60183. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.FORM.*/
                            OpenSpecOrderSalesOrderForm;

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
        "G|L": Record "General Ledger Setup";
        PurchaseHeader: Record "Purchase Header";
        PAYMENT_TERMS: Record "Payment Terms";
        Text33000260: Label 'Do you want to Cancel Quality Inspection?';
        Text33000261: Label 'Do you want to Close Quality Inspection?';


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
            CODEUNIT.RUN(CODEUNIT::75, Rec);
        end;
    */  //EFFUPG

    procedure OpenSalesOrderForm();
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
    begin
        SalesHeader.SETRANGE("No.", "Sales Order No.");
        SalesOrder.SETTABLEVIEW(SalesHeader);
        SalesOrder.EDITABLE := FALSE;
        SalesOrder.RUN;
    end;


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


    procedure _ShowReservation();
    begin
        FIND;
        Rec.ShowReservation;
    end;


    /* procedure ShowReservation();
     begin
         FIND;
         Rec.ShowReservation;
     end;*/


    procedure _ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin);
    begin
        //Rec.InitType(AvailabilityType); //B2b1.0
    end;


    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin);
    begin
        //Rec.InitType(AvailabilityType); //B2b1.0
    end;


    procedure _ShowReservationEntries();
    begin
        Rec.ShowReservationEntries(TRUE);
    end;


    procedure ShowReservationEntries();
    begin
        Rec.ShowReservationEntries(TRUE);
    end;


    procedure ShowTracking();
    var
        TrackingForm: Page "Order Tracking";
    begin
        TrackingForm.SetPurchLine(Rec);
        TrackingForm.RUNMODAL;
    end;


    procedure _ShowDimensions();
    begin
        Rec.ShowDimensions;
    end;


    /*procedure ShowDimensions();
     begin
         Rec.ShowDimensions;
     end;*/


    procedure ItemChargeAssgnt();
    begin
        Rec.ShowItemChargeAssgnt;
    end;


    procedure _OpenItemTrackingLines();
    begin
        Rec.OpenItemTrackingLines;
    end;


    /*procedure OpenItemTrackingLines();
    begin
        Rec.OpenItemTrackingLines;
    end;*/


    procedure OpenSpecOrderSalesOrderForm();
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
    begin
        SalesHeader.SETRANGE("No.", "Special Order Sales No.");
        SalesOrder.SETTABLEVIEW(SalesHeader);
        SalesOrder.EDITABLE := FALSE;
        SalesOrder.RUN;
    end;


    procedure UpdateForm(SetSaveRecord: Boolean);
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;


    procedure "---NAVIN---"();
    begin
    end;


    /*procedure ShowStrDetailsForm();
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
    end;*/


    procedure "--SubCon--"();
    begin
    end;


    procedure ShowSubOrderDetailsForm();
    var
        PurchaseLine: Record "Purchase Line";
        SubOrderDetails: Page "Order Subcon. Details Delivery";
    begin
        PurchaseLine.RESET;
        PurchaseLine.SETRANGE("Document Type", "Document Type"::Order);
        PurchaseLine.SETRANGE("Document No.", "Document No.");
        PurchaseLine.SETRANGE("No.", "No.");
        PurchaseLine.SETRANGE("Line No.", "Line No.");
        SubOrderDetails.SETTABLEVIEW(PurchaseLine);
        SubOrderDetails.RUNMODAL;
    end;


    procedure "--QC--"();
    begin
    end;


    procedure _CreateInspectionDataSheets();
    begin
        CreateInspectionDataSheets;
    end;


    /* procedure CreateInspectionDataSheets();
     begin
         CreateInspectionDataSheets;
     end;*/


    procedure _ShowDataSheets();
    var
        InspectDataSheet: Record "Inspection Datasheet Header";
    begin
        ShowDataSheets;
    end;


    /*procedure ShowDataSheets();
    var
        InspectDataSheet: Record "Inspection Datasheet Header";
    begin
        ShowDataSheets;
    end;*/


    procedure _ShowPostDataSheets();
    var
        PostInspectDataSheet: Record "Posted Inspect DatasheetHeader";
    begin
        ShowPostDataSheets;
    end;


    /*procedure ShowPostDataSheets();
    var
        PostInspectDataSheet: Record "Posted Inspect DatasheetHeader";
    begin
        ShowPostDataSheets;
    end;*/


    procedure _ShowInspectReceipt();
    var
        InspectionReceipt: Record "Inspection Receipt Header";
    begin
        ShowInspectReceipt;
    end;


    /*procedure ShowInspectReceipt();
    var
        InspectionReceipt: Record "Inspection Receipt Header";
    begin
        ShowInspectReceipt;
    end;*/


    procedure _ShowPostInspectReceipt();
    var
        InspectionReceipt: Record "Inspection Receipt Header";
    begin
        ShowPostInspectReceipt;
    end;


    /*procedure ShowPostInspectReceipt();
    var
        InspectionReceipt: Record "Inspection Receipt Header";
    begin
        ShowPostInspectReceipt;
    end;*/


    procedure "---B2B---"();
    begin
    end;


    procedure OpenAttachments();
    var
        Attachment: Record Attachments;
    begin
        Attachment.RESET;
        Attachment.SETRANGE("Table ID", DATABASE::"Purchase Header");
        Attachment.SETRANGE("Document No.", "Document No.");
        Attachment.SETRANGE("Document Type", "Document Type");

        PAGE.RUN(PAGE::"ESPL Attachments", Attachment);
    end;


    procedure _CancelInspection1(var QualityStatus: Text[50]);
    begin
        TESTFIELD("No.");
        TESTFIELD("QC Enabled");
        CancelInspection(QualityStatus);
    end;


    procedure _CloseInspection1(var QualityStatus: Text[50]);
    begin
        TESTFIELD("No.");
        TESTFIELD("QC Enabled");
        CloseInspection(QualityStatus);
    end;


    procedure _SampleLotInspection();
    var
        SampleLotInspection: Record "Sample Lot Inspection";
    begin
        TESTFIELD("QC Enabled");
        //TESTFIELD("Quality Before Receipt");
        //"Sample Lot Inspection" := TRUE;
        SampleLotInspection.SETRANGE("Purchase Order No.", "Document No.");
        SampleLotInspection.SETRANGE("Purchase Line No.", "Line No.");
        SampleLotInspection.SETRANGE(Quantity, Quantity);
        PAGE.RUN(60072, SampleLotInspection);
    end;


    procedure SampleLotInspection();
    var
        SampleLotInspection: Record "Sample Lot Inspection";
    begin
        TESTFIELD("QC Enabled");
        //TESTFIELD("Quality Before Receipt");
        //"Sample Lot Inspection" := TRUE;
        SampleLotInspection.SETRANGE("Purchase Order No.", "Document No.");
        SampleLotInspection.SETRANGE("Purchase Line No.", "Line No.");
        SampleLotInspection.SETRANGE(Quantity, Quantity);
        PAGE.RUN(60072, SampleLotInspection);
    end;


    procedure _QCOverride();
    begin
        QCOverride;
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

