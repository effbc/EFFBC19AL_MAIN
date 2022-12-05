page 60231 "Sales Amc Subform"
{
    AutoSplitKey = true;
    Caption = 'Sales Order Subform';
    DelayedInsert = true;
    DeleteAllowed = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Sales Line";
    SourceTableView = WHERE("Document Type" = FILTER(Order));//EFFUPG1.5

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
                field("Schedule No"; "Schedule No")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    Editable = ship;
                    ApplicationArea = All;
                }
                field("Tax Liable"; "Tax Liable")
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                    end;
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                }
                field("Dummy Unit Cost"; "Dummy Unit Cost")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Amt := "Dummy Unit Cost";
                        DummyAmt := Amt / 1.103;
                        "Unit Price" := ROUND(DummyAmt, 0.01);
                        //MODIFY;
                    end;
                }
                field("Unitcost(LOA)"; "Unitcost(LOA)")
                {
                    ApplicationArea = All;
                }
                /* field("Charges To Customer"; "Charges To Customer")
                {
                }
                field("Service Tax Registration No."; "Service Tax Registration No.")
                {
                }
                field("Service Tax Group"; "Service Tax Group")
                {
                } */
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Type of Item"; "Type of Item")
                {
                    ApplicationArea = All;
                }
                field("To Be Shipped Qty"; "To Be Shipped Qty")
                {
                    ApplicationArea = All;
                }
                field("Packet No"; "Packet No")
                {
                    ApplicationArea = All;
                }
                field("RDSO Inspection Required"; "RDSO Inspection Required")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Description 2"; "Description 2")
                {
                    ApplicationArea = All;
                }
                /* field("Service Tax Amount"; "Service Tax Amount")
                {
                } */
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    BlankZero = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        QuantityOnAfterValidate;
                    end;
                }
                field("Unit Price"; "Unit Price")
                {
                    BlankZero = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*item.SETRANGE(item."No.","No.");
                        IF item.FINDFIRST THEN
                        BEGIN
                        IF "Qty. to Ship">0 THEN
                        BEGIN
                        IF ("Unit Price"<item."Avg Unit Cost")THEN
                        ERROR('Unit Price must be greater than item unit Cost');
                        END;
                        END;*/


                        IF ("Unit Price" > 0) THEN
                            "Dummy Unit Cost" := "Unit Price";

                    end;
                }
                field("Qty. to Ship"; "Qty. to Ship")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Qty. to Invoice"; "Qty. to Invoice")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Quantity Shipped"; "Quantity Shipped")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; "Quantity Invoiced")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line Amount"; "Line Amount")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Service Tax Amount"; "Service Tax Amount")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                    Editable = true;
                }
                /*
                field("Excise Amount"; "Excise Amount")
                {
                    Visible = false;
                }
                field("Tax %"; "Tax %")
                {
                    Visible = true;
                }
                field("Tax Amount"; "Tax Amount")
                {
                    Visible = false;
                }
                */
                field("Outstanding Amount"; "Outstanding Amount")
                {
                    ApplicationArea = All;
                }
                field("Tax Group Code"; "Tax Group Code")
                {
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                /*
                field("Excise Bus. Posting Group"; "Excise Bus. Posting Group")
                {
                }
                field("Excise Prod. Posting Group"; "Excise Prod. Posting Group")
                {
                }
                */
                field("Unit of Measure"; "Unit of Measure")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                /* field("eCess Amount"; "eCess Amount")
                {
                    Editable = true;
                } */
                field("Prod. Order Quantity"; "Prod. Order Quantity")
                {
                    ApplicationArea = All;
                }
                field("Prod. Due Date"; "Prod. Due Date")
                {
                    ApplicationArea = All;
                }
                field("Prod. Qty"; "Prod. Qty")
                {
                    ApplicationArea = All;
                }
                field("Production BOM No."; "Production BOM No.")
                {
                    ApplicationArea = All;
                }
                field("Qty. Invoiced (Base)"; "Qty. Invoiced (Base)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. Shipped (Base)"; "Qty. Shipped (Base)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; "Outstanding Quantity")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Outstanding Qty. (Base)"; "Outstanding Qty. (Base)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("GST Place of Supply"; "GST Place of Supply")
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
                /* field("GST Base Amount"; "GST Base Amount")
                {
                }
                field("GST %"; "GST %")
                {
                }
                field("Total GST Amount"; "Total GST Amount")
                {
                } */
                field("HSN/SAC Code"; "HSN/SAC Code")
                {
                    ApplicationArea = All;
                }
                field("GST Jurisdiction Type"; "GST Jurisdiction Type")
                {
                    ApplicationArea = All;
                }
                field(Exempted; Exempted)
                {
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; "Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. Shipped Not Invoiced"; "Qty. Shipped Not Invoiced")
                {
                    Editable = false;
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

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                            /*CurrPage.SalesLines.Page.*/
                            _ItemAvailability(0);

                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        Image = ItemVariant;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                            /*CurrPage.SalesLines.Page.*/
                            _ItemAvailability(1);

                        end;
                    }
                    action(Location)
                    {
                        Caption = 'Location';
                        Image = Allocations;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                            /*CurrPage.SalesLines.Page.*/
                            _ItemAvailability(2);

                        end;
                    }
                }
                action("Reservation Entries")
                {
                    Caption = 'Reservation Entries';
                    Image = ReservationLedger;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        _ShowReservationEntries;

                    end;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTracking;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        _OpenItemTrackingLines;

                    end;
                }
                action("Select Item Substitution")
                {
                    Caption = 'Select Item Substitution';
                    Image = ItemSubstitution;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        _ShowItemSub;

                    end;
                }
                action("Packing Details")
                {
                    Caption = 'Packing Details';
                    Image = ItemGroup;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        ShowPackingDetails;

                    end;
                }
                action("Delivery &Challan")
                {
                    Caption = 'Delivery &Challan';
                    Image = Delivery;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        ShowDeliveryChallan;

                    end;
                }
                action("&Line Attachments")
                {
                    Caption = '&Line Attachments';
                    Image = Attachments;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        SalesLineAttachments;

                    end;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        _ShowDimensions;

                    end;
                }
                action("Item Charge &Assignment")
                {
                    Caption = 'Item Charge &Assignment';
                    Image = ItemCosts;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        ItemChargeAssgnt;

                    end;
                }
                action("Structure Details")
                {
                    Caption = 'Structure Details';
                    Image = ViewDetails;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        ShowStrDetailsForm;  // NAVIN

                    end;
                }
                action("Design Worksheet")
                {
                    Caption = 'Design Worksheet';
                    Image = ItemWorksheet;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        ShowSalesOrderWorkSheet;

                    end;
                }
                action("Sc&hedule")
                {
                    Caption = 'Sc&hedule';
                    Image = Workdays;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        ShowSchedule;

                    end;
                }
                action("Prod. Order Details")
                {
                    Caption = 'Prod. Order Details';
                    Image = Production;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        ShowPODetails;

                    end;
                }
                action("Create Prod. Order")
                {
                    Caption = 'Create Prod. Order';
                    Image = Production;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        NewStatus2: Option Simulated,Planned,"Firm Planned",Released;
                        NewOrderType2: Option ItemOrder,ProjectOrder;
                    begin
                        /*SalesPlanPage.SetSalesOrder("No.");
                        SalesPlanPage.RUNMODAL;
                        */

                        //IF CreateOrderPage.RUNMODAL <> ACTION::Yes THEN
                        //EXIT;

                        SalesPlanLine.DELETEALL;
                        Quantity := MakeLines(SalesLineRec);

                        NewStatus2 := NewStatus2::Released;
                        NewOrderType2 := NewOrderType2::ItemOrder;
                        //CreateOrderPage.ReturnPostingInfo(NewStatus2,NewOrderType2);
                        IF "Order Assurance" = FALSE THEN
                            ERROR('Order Was not Assured By Sales Dept.')
                        ELSE BEGIN
                            FOR I := 1 TO Quantity
                              DO BEGIN
                                Qty := 1;
                                CreateOrders(Qty);
                            END;
                        END;

                        //IF NOT CreateOrders THEN
                        //MESSAGE(Text001);

                        //SalesPlanLine.SETRANGE("Planning Status");

                        //BuildForm;

                        //CurrPage.UPDATE;

                    end;
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

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        ApproveCalcInvDisc;

                    end;
                }
                action("Get Price")
                {
                    Caption = 'Get Price';
                    Ellipsis = true;
                    Image = PriceAdjustment;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        ShowPrices

                    end;
                }
                action("Get Li&ne Discount")
                {
                    Caption = 'Get Li&ne Discount';
                    Ellipsis = true;
                    Image = LineDiscount;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        ShowLineDisc

                    end;
                }
                action("E&xplode BOM")
                {
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        ExplodeBOM;

                    end;
                }
                action("Insert &Ext. Texts")
                {
                    Caption = 'Insert &Ext. Texts';
                    Image = Text;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        _InsertExtendedText(TRUE);

                    end;
                }
                action("&Reserve")
                {
                    Caption = '&Reserve';
                    Ellipsis = true;
                    Image = Reserve;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        _ShowReservation;

                    end;
                }
                action("Order &Tracking")
                {
                    Caption = 'Order &Tracking';
                    Image = OrderTracking;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        ShowTracking;

                    end;
                }
                action("&Attachments")
                {
                    Caption = '&Attachments';
                    Image = Attachments;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        CustAttachments;

                    end;
                }
                action("Pre Site Visit")
                {
                    Caption = 'Pre Site Visit';
                    Image = Bank;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        _Presite;

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
                    action("Purchase &Order")
                    {
                        Caption = 'Purchase &Order';
                        Image = Purchase;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                            /*CurrPage.SalesLines.Page.*/
                            OpenPurchOrderForm;

                        end;
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Image = "Order";
                    action(Action1903192904)
                    {
                        Caption = 'Purchase &Order';
                        Image = Purchase;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #60080. Unsupported part was commented. Please check it.
                            /*CurrPage.SalesLines.Page.*/
                            OpenSpecialPurchOrderForm;

                        end;
                    }
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        User.RESET;
        IF SaleDocType = SaleDocType::Amc THEN BEGIN //EFFUPG1.5
            IF NOT (USERID IN ['EFFTRONICS\MBNAGAMANI']) THEN
                ERROR('You Dont have permissions to delete');
        END;

        /*  IF "Quantity Shipped" = 1 THEN
              ERROR('You can not modify the Line as it is Invoiced!');*/


    end;

    trigger OnModifyRecord(): Boolean
    begin
        //IF "Quantity Shipped" = 1 THEN   // Condition changed  by vishnu Priya on 30-09-2020
        IF ("Quantity Shipped" = "Quantity (Base)") AND (USERID <> 'EFFTRONICS\TPRIYANKA') THEN
            ERROR('You can not modify the Line as it is Invoiced!');

        IF STRPOS(Description, Apostrophe) <> 0 THEN   // Added by Pranavi on 13-OCt-2016 for Cashflow Integration
            ERROR('Do not enter ' + Apostrophe + ' symbol in Description!');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := xRec.Type;
        CLEAR(ShortcutDimCode);
    end;

    trigger OnOpenPage()
    begin
        IF USERID IN ['EFFTRONICS\RISHIANVESH', 'EFFTRONICS\MBNAGAMANI'] THEN
            ship := TRUE
        ELSE
            ship := FALSE;
    end;

    var
        SalesHeader: Record "Sales Header";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        ShortcutDimCode: array[8] of Code[20];
        "-NAVIN-": Integer;
        Check: Boolean;
        SalesPlanLine: Record "Sales Planning Line";
        Text001: Label 'Prod. Order is already created against the Sales Order.';
        item: Record Item;
        Amt: Decimal;
        SL: Record "Sales Line";
        DummyAmt: Decimal;
        "Order Assurance": Boolean;
        I: Integer;
        Qty: Decimal;
        NewStatus: Option Simulated,Planned,"Firm Planned",Released;
        NewOrderType: Option ItemOrder,ProjectOrder;
        SalesLineRec: Record "Sales Line";
        Apostrophe: Label '''';
        SalesLine2: Record "Sales Line";
        User: Record User;
        ship: Boolean;


    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Disc. (Yes/No)", Rec);
    end;


    procedure CalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Calc. Discount", Rec);
    end;


    procedure ExplodeBOM()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Explode BOM", Rec);
    end;


    procedure OpenPurchOrderForm()
    var
        PurchHeader: Record "Purchase Header";
        PurchOrder: Page "Purchase Order";
    begin
        PurchHeader.SETRANGE("No.", "Purchase Order No.");
        PurchOrder.SETTABLEVIEW(PurchHeader);
        PurchOrder.EDITABLE := FALSE;
        PurchOrder.RUN;
    end;


    procedure OpenSpecialPurchOrderForm()
    var
        PurchHeader: Record "Purchase Header";
        PurchOrder: Page "Purchase Order";
    begin
        PurchHeader.SETRANGE("No.", "Special Order Purchase No.");
        PurchOrder.SETTABLEVIEW(PurchHeader);
        PurchOrder.EDITABLE := FALSE;
        PurchOrder.RUN;
    end;


    procedure _InsertExtendedText(Unconditionally: Boolean)
    begin
        IF TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD;
            TransferExtendedText.InsertSalesExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
            UpdateForm(TRUE);
    end;


    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        IF TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD;
            TransferExtendedText.InsertSalesExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
            UpdateForm(TRUE);
    end;


    procedure _ShowReservation()
    begin
        FIND;
        Rec.ShowReservation;
    end;


    /*procedure ShowReservation()
    begin
        FIND;
        Rec.ShowReservation;
    end;*/ //b2bupg


    procedure _ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        //Rec.ItemAvailability(AvailabilityType); //B2b1.0
    end;


    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        //Rec.ItemAvailability(AvailabilityType); //B2b1.0
    end;


    procedure _ShowReservationEntries()
    begin
        Rec.ShowReservationEntries(TRUE);
    end;


    procedure ShowReservationEntries()
    begin
        Rec.ShowReservationEntries(TRUE);
    end;


    procedure _ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;


    /* procedure ShowDimensions()
     begin
         Rec.ShowDimensions;
     end;*/


    procedure _ShowItemSub()
    begin
        Rec.ShowItemSub;
    end;


    /*procedure ShowItemSub()
    begin
        Rec.ShowItemSub;
    end;*/


    procedure ShowNonstockItems()
    begin
        Rec.ShowNonstock;
    end;


    procedure _OpenItemTrackingLines()
    begin
        Rec.OpenItemTrackingLines;
    end;


    /* procedure OpenItemTrackingLines()
     begin
         Rec.OpenItemTrackingLines;
     end;*/


    procedure ShowTracking()
    var
        TrackingForm: Page "Order Tracking";
    begin
        TrackingForm.SetSalesLine(Rec);
        TrackingForm.RUNMODAL;
    end;


    procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt;
    end;


    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;


    procedure ShowPrices()
    begin
        SalesHeader.GET("Document Type", "Document No.");
        SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
    end;


    procedure ShowLineDisc()
    begin
        SalesHeader.GET("Document Type", "Document No.");
        SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader, Rec);
    end;


    procedure "---NAVIN---"()
    begin
    end;


    procedure ShowStrDetailsForm()
    var
    // StrOrderLineDetails: Record "Structure Order Line Details";
    //StrOrderLineDetailsForm: Page "Structure Order Line Details";
    begin
        /*  StrOrderLineDetails.RESET;
         StrOrderLineDetails.SETRANGE(Type, StrOrderLineDetails.Type::Sale);
         StrOrderLineDetails.SETRANGE("Document Type", "Document Type");
         StrOrderLineDetails.SETRANGE("Document No.", "Document No.");
         StrOrderLineDetails.SETRANGE("Item No.", "No.");
         StrOrderLineDetails.SETRANGE("Line No.", "Line No.");
         StrOrderLineDetailsForm.SETTABLEVIEW(StrOrderLineDetails);
         StrOrderLineDetailsForm.RUNMODAL; */
    end;


    procedure "---B2B--"()
    begin
    end;


    procedure CustAttachments()
    var
        CustAttach: Record Attachments;
    begin
        CustAttach.RESET;
        CustAttach.SETRANGE("Table ID", DATABASE::"Sales Header");
        CustAttach.SETRANGE("Document No.", Rec."Document No.");
        CustAttach.SETRANGE("Document Type", "Document Type");

        PAGE.RUN(PAGE::"ESPL Attachments", CustAttach);
    end;


    procedure _Presite()
    var
        PreSiteCheckList: Record "Inst. PreSite Check List";
    begin
        PreSiteCheckList.RESET;
        PreSiteCheckList.SETRANGE("Sales Order No.", "Document No.");
        PreSiteCheckList.SETRANGE("Sales Order Line No.", "Line No.");
        PAGE.RUN(PAGE::"Inst. PreSite Check List", PreSiteCheckList);
    end;


    procedure Presite()
    var
        PreSiteCheckList: Record "Inst. PreSite Check List";
    begin
        PreSiteCheckList.RESET;
        PreSiteCheckList.SETRANGE("Sales Order No.", "Document No.");
        PreSiteCheckList.SETRANGE("Sales Order Line No.", "Line No.");
        PAGE.RUN(PAGE::"Inst. PreSite Check List", PreSiteCheckList);
    end;


    procedure ShowPackingDetails()
    var
        PackingDetails: Record "Shortage Management Audit Data";
    begin
        PackingDetails.SETRANGE(Week, 0);
        PackingDetails.SETRANGE("Sale Order", "Document No.");
        //PackingDetails.SETRANGE(Customer,"Line No.");
        PAGE.RUNMODAL(PAGE::"Shortage Mng Audit Data", PackingDetails);
    end;


    procedure SalesLineAttachments()
    var
        CustAttach: Record Attachments;
    begin
        CustAttach.RESET;
        CustAttach.SETRANGE("Table ID", DATABASE::"Sales Header");
        CustAttach.SETRANGE("Document No.", Rec."Document No.");
        CustAttach.SETRANGE("Document Type", "Document Type"::Order);
        CustAttach.SETRANGE("Document Line No.", "Line No.");

        PAGE.RUN(PAGE::"ESPL Attachments", CustAttach);
    end;


    procedure ShowSalesOrderWorkSheet()
    var
        DesignWorksheetHeader: Record "Design Worksheet Header";
        DesignWorksheetLine: Record "Design Worksheet Line";
        Item: Record Item;
        ItemDesignWorksheetHeader: Record "Item Design Worksheet Header";
        ItemDesignWorksheetLine: Record "Item Design Worksheet Line";
    begin
        /*
        TESTFIELD("Document Type");
        TESTFIELD("Document No.");
        TESTFIELD("Line No.");
        
        CLEAR(DesignWorksheetHeader);
        DesignWorksheetHeader.SETRANGE("Document Type",DesignWorksheetHeader."Document Type"::Order);
        DesignWorksheetHeader.SETRANGE("Document No.","Document No.");
        DesignWorksheetHeader.SETRANGE("Document Line No.","Line No.");
        DesignWorksheetHeader.FILTERGROUP(2);
        IF DesignWorksheetHeader.FINDFIRST THEN
          Page.RUNMODAL(60122,DesignWorksheetHeader);
        DesignWorksheetHeader.FILTERGROUP(0);
        */
        TESTFIELD("Document Type");
        TESTFIELD("Document No.");
        TESTFIELD("Line No.");
        ItemDesignWorksheetHeader.RESET;
        IF ItemDesignWorksheetHeader.GET("No.") THEN BEGIN
            DesignWorksheetHeader.INIT;
            DesignWorksheetHeader.TRANSFERFIELDS(ItemDesignWorksheetHeader);
            DesignWorksheetHeader."Document No." := "Document No.";
            DesignWorksheetHeader."Document Line No." := "Line No.";
            DesignWorksheetHeader."Document Type" := DesignWorksheetHeader."Document Type"::Order;
            IF DesignWorksheetHeader.INSERT THEN;
            ItemDesignWorksheetLine.RESET;
            ItemDesignWorksheetLine.SETRANGE(ItemDesignWorksheetLine."Item No", ItemDesignWorksheetHeader."Item No.");
            IF ItemDesignWorksheetLine.FINDSET THEN
                REPEAT
                    DesignWorksheetLine.INIT;
                    DesignWorksheetLine.TRANSFERFIELDS(ItemDesignWorksheetLine);
                    DesignWorksheetLine."Document No." := "Document No.";
                    DesignWorksheetLine."Document Line No." := "Line No.";
                    DesignWorksheetLine."Document Type" := DesignWorksheetLine."Document Type"::Order;
                    IF DesignWorksheetLine.INSERT THEN;
                UNTIL ItemDesignWorksheetLine.NEXT = 0;
        END;
        COMMIT;

        CLEAR(DesignWorksheetHeader);
        DesignWorksheetHeader.SETRANGE("Document Type", DesignWorksheetHeader."Document Type"::Order);
        DesignWorksheetHeader.SETRANGE("Document No.", "Document No.");
        DesignWorksheetHeader.SETRANGE("Document Line No.", "Line No.");
        DesignWorksheetHeader.FILTERGROUP(2);
        IF DesignWorksheetHeader.FINDFIRST THEN
            PAGE.RUNMODAL(60122, DesignWorksheetHeader);
        DesignWorksheetHeader.FILTERGROUP(0);

    end;


    procedure ShowDeliveryChallan()
    var
        DeliveryChallan: Record "DC Header";
    begin
        DeliveryChallan.SETRANGE(Status, DeliveryChallan.Status::Open);
        DeliveryChallan.SETRANGE("Sales Order No.", "Document No.");
        //DeliveryChallan.SETRANGE("Document Line No.","Line No.");
        PAGE.RUNMODAL(PAGE::"DC Header", DeliveryChallan);
    end;


    procedure ShowSchedule2()
    var
        Schedule: Record Schedule2;
    begin
        IF ("Tender No." = '') AND ("Tender Line No." = 0) THEN BEGIN
            Schedule.RESET;
            Schedule.SETRANGE("Document Type", Schedule."Document Type"::Order);
            Schedule.SETRANGE("Document No.", "Document No.");
            Schedule.SETRANGE("Document Line No.", "Line No.");
            //Schedule.SETRANGE("Item No.","No.");
            //Schedule.SETRANGE(Quantity,Quantity);
            Schedule.FILTERGROUP(2);
            PAGE.RUN(60125, Schedule);
            Schedule.FILTERGROUP(0);
        END ELSE BEGIN
            Schedule.RESET;
            Schedule.SETRANGE("Document Type", Schedule."Document Type"::Tender);
            Schedule.SETRANGE("Document No.", "Tender No.");
            Schedule.SETRANGE("Document Line No.", "Tender Line No.");
            //Schedule.SETRANGE("Item No.","No.");
            //Schedule.SETRANGE(Quantity,Quantity);
            Schedule.FILTERGROUP(2);
            PAGE.RUN(60127, Schedule);
            Schedule.FILTERGROUP(0);
        END;
    end;


    procedure ShowPODetails()
    var
        SOPodetails: Record "SO Prod.Order Details";
    begin
        SOPodetails.SETRANGE("Sales Order No.", "Document No.");
        SOPodetails.SETRANGE("Sales Order Line No.", "Line No.");
        PAGE.RUNMODAL(60126, SOPodetails);
    end;


    procedure MakeLines(var SalesLineparam: Record "Sales Line"): Decimal
    var
        SalesLine: Record "Sales Line";
        ProdOrderLine: Record "Prod. Order Line";
        PurchLine: Record "Purchase Line";
        ReqLine: Record "Requisition Line";
        ReservEntry2: Record "Reservation Entry";
    begin
        SalesPlanLine.DELETEALL;
        ValidateProdOrder;
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE("Document No.", "Document No.");
        //NSS 301207
        SalesLine.SETRANGE("Line No.", "Line No.");
        //NSS
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);

        IF SalesLine.FINDFIRST THEN BEGIN
            //REPEAT
            SalesLine.TESTFIELD("Prod. Qty");
            SalesLine.TESTFIELD("Prod. Due Date");
            SalesPlanLine.INIT;
            SalesPlanLine."Sales Order No." := SalesLine."Document No.";
            SalesPlanLine."Sales Order Line No." := SalesLine."Line No.";
            SalesPlanLine."Item No." := SalesLine."No.";

            SalesPlanLine."Variant Code" := SalesLine."Variant Code";
            SalesPlanLine.Description := SalesLine.Description;
            SalesPlanLine."Shipment Date" := SalesLine."Shipment Date";
            SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::Released;
            SalesLine.CALCFIELDS("Reserved Qty. (Base)");
            SalesPlanLine."Planned Quantity" := SalesLine."Reserved Qty. (Base)";
            /*ReservEngineMgt.InitFilterAndSortingLookupFor(ReservEntry,FALSE);
            ReserveSalesline.FilterReservFor(ReservEntry,SalesLine);
            ReservEntry.SETRANGE("Reservation Status",ReservEntry."Reservation Status"::Reservation);
            IF ReservEntry.FINDSET THEN
              REPEAT
                IF ReservEntry2.GET(ReservEntry."Entry No.",NOT ReservEntry.Positive) THEN
                  CASE ReservEntry2."Source Type" OF
                    DATABASE::"Item Ledger Entry":
                      BEGIN
                        SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::Inventory;
                      END;
                    DATABASE::"Requisition Line":
                      BEGIN
                        ReqLine.GET(
                          ReservEntry2."Source ID",
                          ReservEntry2."Source Batch Name",
                          ReservEntry2."Source Ref. No.");
                        SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::Planned;
                        SalesPlanLine."Expected Delivery Date" := ReqLine."Due Date";
                      END;
                    DATABASE::"Purchase Line":
                      BEGIN
                        PurchLine.GET(
                          ReservEntry2."Source Subtype",
                          ReservEntry2."Source ID",
                          ReservEntry2."Source Ref. No.");
                        SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::"Firm Planned";
                        SalesPlanLine."Expected Delivery Date" := PurchLine."Expected Receipt Date";
                      END;
                    DATABASE::"Prod. Order Line":
                      BEGIN
                        ProdOrderLine.GET(
                          ReservEntry2."Source Subtype",
                          ReservEntry2."Source ID",
                          ReservEntry2."Source Prod. Order Line");
                        IF ProdOrderLine."Ending Date" > SalesPlanLine."Expected Delivery Date" THEN
                          SalesPlanLine."Expected Delivery Date" := ProdOrderLine."Ending Date";
                        IF ((ProdOrderLine.Status + 1) < SalesPlanLine."Planning Status") OR
                           (SalesPlanLine."Planning Status" = SalesPlanLine."Planning Status"::None)
                        THEN
                          SalesPlanLine."Planning Status" := ProdOrderLine.Status + 1;
                      END;
                  END;
              UNTIL ReservEntry.NEXT = 0;*/
            SalesPlanLine."Needs Replanning" :=
              (SalesPlanLine."Planned Quantity" <> SalesLine."Outstanding Qty. (Base)") OR
              (SalesPlanLine."Expected Delivery Date" > SalesPlanLine."Shipment Date");
            /*CalculateDisposalPlan(
              SalesLine."Variant Code",
              SalesLine."Location Code",SalesLine."Bin Code");*/
            SalesPlanLine.INSERT;
            EXIT(SalesLine."Prod. Qty");
            //UNTIL SalesLine.NEXT = 0;
        END;

    end;


    procedure ValidateProdOrder()
    begin
        CALCFIELDS("Prod. Order Quantity");
        IF "Prod. Order Quantity" > Quantity THEN
            ERROR(Text001);
    end;


    procedure ShowSchedule()
    var
        Schedule: Record Schedule2;
        SalesLine: Record "Sales Line";
    begin
        IF Type = Type::Item THEN BEGIN
            IF (("Tender No." <> '') AND ("Tender Line No." <> 0)) THEN BEGIN
                Schedule.RESET;
                Schedule.SETRANGE("Document Type", Schedule."Document Type"::Order);
                Schedule.SETRANGE("Document No.", "Document No.");
                Schedule.SETRANGE("Document Line No.", "Line No.");
                //Schedule.SETRANGE("Item No.","No.");
                //Schedule.SETRANGE(Quantity,Quantity);
                Schedule.FILTERGROUP(2);
                IF Schedule.FINDFIRST THEN BEGIN
                    PAGE.RUN(60125, Schedule);
                    Schedule.FILTERGROUP(0);
                END ELSE BEGIN
                    SalesLine.RESET;
                    SalesLine.SETRANGE("Document No.", "Document No.");
                    SalesLine.SETRANGE("Line No.", "Line No.");
                    IF SalesLine.FINDSET THEN
                        REPEAT
                            Schedule.INIT;
                            Schedule."Document Type" := Schedule."Document Type"::Order;
                            Schedule."Document No." := SalesLine."Document No.";
                            Schedule."Document Line No." := SalesLine."Line No.";
                            Schedule."Line No." := SalesLine."Line No.";
                            Schedule.Type := Schedule.Type::Item;
                            Schedule.VALIDATE("No.", SalesLine."No.");
                            Schedule.Quantity := SalesLine.Quantity;
                            //salesLine.CALCFIELDS("Estimated Unit Cost");
                            IF Schedule.INSERT THEN;
                        UNTIL SalesLine.NEXT = 0;
                    COMMIT;
                    Schedule.RESET;
                    Schedule.SETRANGE("Document Type", Schedule."Document Type"::Order);
                    Schedule.SETRANGE("Document No.", "Document No.");
                    Schedule.SETRANGE("Document Line No.", "Line No.");
                    Schedule.FILTERGROUP(2);
                    PAGE.RUN(60125, Schedule);
                    Schedule.FILTERGROUP(0);
                END
            END ELSE
                IF (("Blanket Order No." <> '') AND ("Blanket Order Line No." <> 0)) THEN BEGIN
                    Schedule.RESET;
                    Schedule.SETRANGE("Document Type", Schedule."Document Type"::Order);
                    Schedule.SETRANGE("Document No.", "Document No.");
                    Schedule.SETRANGE("Document Line No.", "Line No.");
                    Schedule.FILTERGROUP(2);
                    PAGE.RUN(60125, Schedule);
                    Schedule.FILTERGROUP(0);
                END ELSE BEGIN
                    SalesLine.RESET;
                    SalesLine.SETRANGE("Document No.", "Document No.");
                    SalesLine.SETRANGE("Line No.", "Line No.");
                    IF SalesLine.FINDSET THEN
                        REPEAT
                            Schedule.INIT;
                            Schedule."Document Type" := Schedule."Document Type"::Order;
                            Schedule."Document No." := SalesLine."Document No.";
                            Schedule."Document Line No." := SalesLine."Line No.";
                            Schedule."Line No." := SalesLine."Line No.";
                            Schedule.Type := Schedule.Type::Item;
                            Schedule.VALIDATE("No.", SalesLine."No.");
                            Schedule.Quantity := SalesLine.Quantity;
                            Schedule."Estimated Total Unit Price" := Schedule."Estimated Unit Price" * Quantity;
                            //salesLine.CALCFIELDS("Estimated Unit Cost");
                            IF Schedule.INSERT THEN;
                        UNTIL SalesLine.NEXT = 0;
                    COMMIT;
                    Schedule.RESET;
                    Schedule.SETRANGE("Document Type", Schedule."Document Type"::Order);
                    Schedule.SETRANGE("Document No.", "Document No.");
                    Schedule.SETRANGE("Document Line No.", "Line No.");
                    Schedule.FILTERGROUP(2);
                    PAGE.RUN(60125, Schedule);
                    Schedule.FILTERGROUP(0);
                END
        END ELSE
            IF Type = Type::"G/L Account" THEN BEGIN
                Schedule.RESET;
                Schedule.SETRANGE("Document Type", Schedule."Document Type"::Order);
                Schedule.SETRANGE("Document No.", "Document No.");
                Schedule.SETRANGE("Document Line No.", "Line No.");
                Schedule.FILTERGROUP(2);
                PAGE.RUN(60125, Schedule);
                Schedule.FILTERGROUP(0);
            END;
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);
        IF (Type = Type::"Charge (Item)") AND ("No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
            CurrPage.SAVERECORD;
    end;

    local procedure QuantityOnAfterValidate()
    begin
        IF Reserve = Reserve::Always THEN BEGIN
            CurrPage.SAVERECORD;
            AutoReserve;
            CurrPage.UPDATE(FALSE);
        END;
    end;


    procedure "--Rev01"()
    begin
    end;


    procedure CreateOrders(Qtyparam: Decimal) OrdersCreated: Boolean
    var
        Item: Record Item;
        SalesLine: Record "Sales Line";
        ProdOrderFromSale: Codeunit "Event Handling Cust";
    begin
        IF NOT SalesPlanLine.FINDSET THEN
            EXIT;

        REPEAT
            SalesLine.GET(
              SalesLine."Document Type"::Order,
              SalesPlanLine."Sales Order No.",
              SalesPlanLine."Sales Order Line No.");
            //SalesLine.TESTFIELD("Shipment Date");
            MESSAGE('anil');//anil
            SalesLine.CALCFIELDS("Reserved Qty. (Base)");
            //IF SalesLine."Outstanding Qty. (Base)" > SalesLine."Reserved Qty. (Base)" THEN BEGIN
            Item.GET(SalesLine."No.");

            IF Item."Replenishment System" = Item."Replenishment System"::"Prod. Order" THEN BEGIN
                OrdersCreated := TRUE;
                ProdOrderFromSale.CreateProdOrder2(
                  SalesLine, NewStatus::Released, NewOrderType::ItemOrder, 1);
                IF NewOrderType = NewOrderType::ProjectOrder THEN
                    EXIT;
            END;
        //END;
        UNTIL (SalesPlanLine.NEXT = 0);
    end;

    local procedure "---B2B----"()
    begin
    end;


    procedure CopyAmcLines()
    var
        SalesLineLRec: Record "Sales Line";
        LineNoLVar: Integer;
        AmcDate: Date;
        SalesHeaderLRec: Record "Sales Header";
        NoOfQuaters: Integer;
        i: Integer;
        NoofQuattoRun: Integer;
        TempSalesLine: Record "Sales Line" temporary;
        TotDays: Integer;
        PaymentTerms: Record "Payment Terms";
        "----DateCal----": Integer;
        // DateAndTime: DotNet DateAndTime;
        //DayOfWeekInput: DotNet FirstDayOfWeek;
        //WeekOfYearInput: DotNet FirstWeekOfYear;
        ResultDay: Integer;
        ResultDayOfYear: Integer;
        ResultHour: Integer;
        LinesEdit: Boolean;
    begin
        CurrPage.SETSELECTIONFILTER(SalesLineLRec);
        TempSalesLine.DELETEALL;
        IF SalesLineLRec.FINDSET THEN
            REPEAT
                TempSalesLine.INIT;
                TempSalesLine.TRANSFERFIELDS(SalesLineLRec);
                TempSalesLine.INSERT;
            UNTIL SalesLineLRec.NEXT = 0;

        SalesHeaderLRec.GET(SalesLineLRec."Document Type", SalesLineLRec."Document No.");
        AmcDate := CALCDATE('3M', SalesHeaderLRec."Requested Delivery Date");
        TotDays := ABS(SalesHeaderLRec."Requested Delivery Date" - SalesHeaderLRec."Promised Delivery Date");

        PaymentTerms.GET(SalesHeaderLRec."Payment Terms Code");
        IF PaymentTerms.Code = 'QUARTER' THEN BEGIN
            NoOfQuaters := ROUND((TotDays / 90), 1, '>');
            AmcDate := CALCDATE('3M', SalesHeaderLRec."Requested Delivery Date");
        END ELSE
            IF PaymentTerms.Code = 'YEAR' THEN BEGIN
                NoOfQuaters := ROUND((TotDays / 365), 1, '=');
                AmcDate := CALCDATE('1Y', SalesHeaderLRec."Requested Delivery Date");
            END ELSE
                IF PaymentTerms.Code = 'HALFYEARLY' THEN BEGIN
                    NoOfQuaters := ROUND((TotDays / 183), 1, '>');
                    AmcDate := CALCDATE('6M', SalesHeaderLRec."Requested Delivery Date");
                END;
        //MESSAGE('%1',TotDays,NoOfQuaters);
        SalesLine2.RESET;
        SalesLine2.SETRANGE("Document No.", SalesLineLRec."Document No.");
        SalesLine2.SETRANGE("Document Type", SalesLineLRec."Document Type");
        IF SalesLine2.FINDLAST THEN
            LineNoLVar := SalesLine2."Line No." + 10000
        ELSE
            LineNoLVar := 10000;

        FOR i := 1 TO (NoOfQuaters - 1) DO BEGIN
            IF TempSalesLine.FINDSET THEN
                REPEAT
                    TempSalesLine.TESTFIELD("Quantity Shipped", 0);
                    SalesLine2.INIT;
                    SalesLine2.TRANSFERFIELDS(TempSalesLine);
                    SalesLine2."Line No." := LineNoLVar;
                    SalesLine2.INSERT(TRUE);
                    IF SalesHeaderLRec."Payment Terms Code" = 'QUARTER' THEN
                        SalesLine2."Shipment Date" := CALCDATE('3M', AmcDate)
                    ELSE
                        IF SalesHeaderLRec."Payment Terms Code" = 'HALFYEARLY' THEN
                            SalesLine2."Shipment Date" := CALCDATE('6M', AmcDate)
                        ELSE
                            IF SalesHeaderLRec."Payment Terms Code" = 'YEAR' THEN
                                SalesLine2."Shipment Date" := CALCDATE('1Y', AmcDate);
                    SalesLine2.MODIFY;
                    LineNoLVar += 10000;
                UNTIL TempSalesLine.NEXT = 0;
            AmcDate := SalesLine2."Shipment Date";
            LinesEdit := FALSE;
        END;
    end;
}

