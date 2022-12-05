page 60019 "Sales Order Subform-Design"
{


    AutoSplitKey = true;
    Caption = 'Sales Order Subform';
    DelayedInsert = true;
    Editable = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Sales Line";
    SourceTableView = WHERE("Document Type" = FILTER(Order | "Blanket Order"));

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
                        NoOnAfterValidate;
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Schedule Type"; "Schedule Type")
                {
                    ApplicationArea = All;
                }
                field("Schedule No"; "Schedule No")
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

                    trigger OnValidate();
                    begin
                        QuantityOnAfterValidate;
                    end;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        UnitofMeasureCodeOnAfterValida;
                    end;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("RDSO Unit Charges"; "RDSO Unit Charges")
                {
                    ApplicationArea = All;
                }
                field("RDSO Charges Paid By"; "RDSO Charges Paid By")
                {
                    ApplicationArea = All;
                }
                field("RDSO Inspection Required"; "RDSO Inspection Required")
                {
                    ApplicationArea = All;
                }
                field("RDSO Inspection By"; "RDSO Inspection By")
                {
                    ApplicationArea = All;
                }
                field("RDSO Charges"; "RDSO Charges")
                {
                    ApplicationArea = All;
                }
                field("Quantity Shipped"; "Quantity Shipped")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Qty. to Invoice"; "Qty. to Invoice")
                {
                    BlankZero = true;
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
                action("&Attachments")
                {
                    Caption = '&Attachments';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60018. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        CustAttachments;

                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                action("Design Worksheet")
                {
                    Caption = 'Design Worksheet';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60018. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        ShowSalesOrderWorkSheet;

                    end;
                }
                action(Schedule)
                {
                    Caption = 'Schedule';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60018. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        ShowSchedule;

                    end;
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
        SalesHeader: Record "Sales Header";
        SalesPriceCalcMgt: Codeunit 7000;
        TransferExtendedText: Codeunit 378;
        ShortcutDimCode: array[8] of Code[20];
        "-NAVIN-": Integer;
        Check: Boolean;


    procedure ApproveCalcInvDisc();
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Disc. (Yes/No)", Rec);
    end;


    procedure CalcInvDisc();
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Calc. Discount", Rec);
    end;


    procedure ExplodeBOM();
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Explode BOM", Rec);
    end;


    procedure OpenPurchOrderForm();
    var
        PurchHeader: Record "Purchase Header";
        PurchOrder: Page 50;
    begin
        PurchHeader.SETRANGE("No.", "Purchase Order No.");
        PurchOrder.SETTABLEVIEW(PurchHeader);
        PurchOrder.EDITABLE := FALSE;
        PurchOrder.RUN;
    end;


    procedure OpenSpecialPurchOrderForm();
    var
        PurchHeader: Record "Purchase Header";
        PurchOrder: Page 50;
    begin
        PurchHeader.SETRANGE("No.", "Special Order Purchase No.");
        PurchOrder.SETTABLEVIEW(PurchHeader);
        PurchOrder.EDITABLE := FALSE;
        PurchOrder.RUN;
    end;


    procedure InsertExtendedText(Unconditionally: Boolean);
    begin
        IF TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD;
            TransferExtendedText.InsertSalesExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
            UpdateForm(TRUE);
    end;


    procedure ShowReservation();
    begin
        FIND;
        Rec.ShowReservation;
    end;


    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin);
    begin
        //Rec.ItemAvailability(AvailabilityType); //B2b1.0
    end;


    procedure ShowReservationEntries();
    begin
        Rec.ShowReservationEntries(TRUE);
    end;


    procedure ShowDimensions();
    begin
        Rec.ShowDimensions;
    end;


    procedure ShowItemSub();
    begin
        Rec.ShowItemSub;
    end;


    procedure ShowNonstockItems();
    begin
        Rec.ShowNonstock;
    end;


    procedure OpenItemTrackingLines();
    begin
        Rec.OpenItemTrackingLines;
    end;


    procedure ShowTracking();
    var
        TrackingForm: Page 99000832;
    begin
        //TrackingForm.SetSalesLine(Rec);
        TrackingForm.RUNMODAL;
    end;


    procedure ItemChargeAssgnt();
    begin
        Rec.ShowItemChargeAssgnt;
    end;


    procedure UpdateForm(SetSaveRecord: Boolean);
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;


    procedure ShowPrices();
    begin
        SalesHeader.GET("Document Type", "Document No.");
        SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
    end;


    procedure ShowLineDisc();
    begin
        SalesHeader.GET("Document Type", "Document No.");
        SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader, Rec);
    end;


    procedure "---NAVIN---"();
    begin
    end;


    /*  procedure ShowStrDetailsForm();
      var
          StrOrderLineDetails: Record "Structure Order Line Details";
          StrOrderLineDetailsForm: Record "Structure Order Line Details";
      begin
          StrOrderLineDetails.RESET;
          StrOrderLineDetails.SETRANGE(Type, StrOrderLineDetails.Type::Sale);
          StrOrderLineDetails.SETRANGE("Document Type", "Document Type");
          StrOrderLineDetails.SETRANGE("Document No.", "Document No.");
          StrOrderLineDetails.SETRANGE("Item No.", "No.");
          StrOrderLineDetails.SETRANGE("Line No.", "Line No.");
          StrOrderLineDetailsForm.SETTABLEVIEW(StrOrderLineDetails);
          StrOrderLineDetailsForm.RUNMODAL;
      end;*/


    procedure "---B2B--"();
    begin
    end;


    procedure CustAttachments();
    var
        CustAttach: Record Attachments;
    begin
        CustAttach.RESET;
        CustAttach.SETRANGE("Table ID", DATABASE::"Sales Header");
        CustAttach.SETRANGE("Document No.", Rec."Document No.");
        CustAttach.SETRANGE("Document Type", "Document Type");

        PAGE.RUN(PAGE::"ESPL Attachments", CustAttach);
    end;


    procedure Presite();
    var
        PreSiteCheckList: Record "Inst. PreSite Check List";
    begin
        PreSiteCheckList.RESET;
        PreSiteCheckList.SETRANGE("Sales Order No.", "Document No.");
        PreSiteCheckList.SETRANGE("Sales Order Line No.", "Line No.");
        PAGE.RUN(PAGE::"Inst. PreSite Check List", PreSiteCheckList);
    end;


    procedure ShowPackingDetails();
    var
        PackingDetails: Record "Shortage Management Audit Data";
    begin
        PackingDetails.SETRANGE(Week, PackingDetails.Week);
        PackingDetails.SETRANGE("Sale Order", "Document No.");
        //PackingDetails.SETRANGE(Customer,"Line No.");
        PAGE.RUNMODAL(PAGE::"Shortage Mng Audit Data", PackingDetails);
    end;


    procedure SalesLineAttachments();
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


    procedure ShowSalesOrderWorkSheet();
    var
        DesignWorksheetHeader: Record "Design Worksheet Header";
        DesignWorksheetLine: Record "Design Worksheet Line";
        Item: Record Item;
        ItemDesignWorksheetHeader: Record "Item Design Worksheet Header";
        ItemDesignWorksheetLine: Record "Item Design Worksheet Line";
    begin
        /*TESTFIELD("Document Type");
        TESTFIELD("Document No.");
        TESTFIELD("Line No.");
        
        CLEAR(DesignWorksheetHeader);
        DesignWorksheetHeader.SETRANGE("Document Type",DesignWorksheetHeader."Document Type"::Order);
        DesignWorksheetHeader.SETRANGE("Document No.","Document No.");
        DesignWorksheetHeader.FILTERGROUP(2);
        DesignWorksheetHeader.SETRANGE("Document Line No.","Line No.");
        Page.RUNMODAL(Page::"Design Worksheet",DesignWorksheetHeader);
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
        DesignWorksheetHeader.FILTERGROUP(2);
        DesignWorksheetHeader.SETRANGE("Document Line No.", "Line No.");
        PAGE.RUNMODAL(PAGE::"Design Worksheet", DesignWorksheetHeader);
        DesignWorksheetHeader.FILTERGROUP(0);

    end;


    procedure ShowDeliveryChallan();
    var
        DeliveryChallan: Record "DC Header";
    begin
        DeliveryChallan.SETRANGE(Status, DeliveryChallan.Status::Open);
        DeliveryChallan.SETRANGE("Sales Order No.", "Document No.");
        //DeliveryChallan.SETRANGE("Document Line No.","Line No.");
        PAGE.RUNMODAL(PAGE::"DC Header", DeliveryChallan);
    end;


    procedure ShowSchedule2();
    var
        Schedule: Record Schedule2;
    begin
        Schedule.SETRANGE("Document Type", Schedule."Document Type"::Order);
        Schedule.SETRANGE("Document No.", "Document No.");
        Schedule.SETRANGE("Document Line No.", "Line No.");
        PAGE.RUNMODAL(60125, Schedule);
    end;


    procedure ShowPODetails();
    var
        SOPodetails: Record "SO Prod.Order Details";
    begin
        SOPodetails.SETRANGE("Sales Order No.", "Document No.");
        SOPodetails.SETRANGE("Sales Order Line No.", "Line No.");
        PAGE.RUNMODAL(60126, SOPodetails);
    end;


    procedure ShowSchedule();
    var
        Schedule: Record Schedule2;
    begin
        //Schedule.SETRANGE("Document Type",Schedule."Document Type" :: Order);
        Schedule.SETRANGE("Document No.", "Document No.");
        Schedule.SETRANGE("Document Line No.", "Line No.");
        PAGE.RUNMODAL(60129, Schedule);
    end;


    local procedure NoOnAfterValidate();
    begin
        InsertExtendedText(FALSE);
        IF (Type = Type::"Charge (Item)") AND ("No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
            CurrPage.SAVERECORD;
    end;


    local procedure QuantityOnAfterValidate();
    begin
        IF Reserve = Reserve::Always THEN BEGIN
            CurrPage.SAVERECORD;
            AutoReserve;
            CurrPage.UPDATE(FALSE);
        END;
    end;


    local procedure UnitofMeasureCodeOnAfterValida();
    begin
        IF Reserve = Reserve::Always THEN BEGIN
            CurrPage.SAVERECORD;
            AutoReserve;
            CurrPage.UPDATE(FALSE);
        END;
    end;
}

