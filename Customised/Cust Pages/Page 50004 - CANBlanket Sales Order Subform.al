page 50004 "CANBlanket Sales Order Subform"
{
    // version NAVW13.60,NAVIN3.70.00.11,SH1.0

    AutoSplitKey = true;
    Caption = 'CANBlanket Sales Order Subform';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Sales Line";
    SourceTableView = WHERE("Document Type" = FILTER("Blanket Order"));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                    end;
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order Quantity"; Rec."Prod. Order Quantity")
                {
                    ApplicationArea = All;
                }
                field("Prod. Qty"; Rec."Prod. Qty")
                {
                    ApplicationArea = All;
                }
                field("Prod. Due Date"; Rec."Prod. Due Date")
                {
                    ApplicationArea = All;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }

                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        QuantityOnAfterValidate;
                    end;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        UnitofMeasureCodeOnAfterValida;
                    end;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(PriceExists; Rec.PriceExists)
                {
                    Caption = 'Sale Price Exists';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field(LineDiscExists; Rec.LineDiscExists)
                {
                    Caption = 'Sales Line Disc. Exists';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                /*field("Tax %"; "Tax %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Tax Amount"; "Tax Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Excise Amount"; "Excise Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }*/
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
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
                action("Calculate &Invoice Discount")
                {
                    Caption = 'Calculate &Invoice Discount';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #50003. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.FORM.*/
                        ApproveCalcInvDisc;

                    end;
                }
                action("Get &Price")
                {
                    Caption = 'Get &Price';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #50003. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.FORM.*/
                        ShowPrices

                    end;
                }
                action("Get Li&ne Discount")
                {
                    Caption = 'Get Li&ne Discount';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #50003. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.FORM.*/
                        ShowLineDisc

                    end;
                }
                action("E&xplode BOM")
                {
                    Caption = 'E&xplode BOM';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #50003. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.FORM.*/
                        ExplodeBOM;

                    end;
                }
                action("Insert &Ext. Texts")
                {
                    Caption = 'Insert &Ext. Texts';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #50003. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.FORM.*/
                        _InsertExtendedText(TRUE);

                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #50003. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.FORM.*/
                        _ShowDimensions;

                    end;
                }
                action("Structure Details")
                {
                    Caption = 'Structure Details';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #50003. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.FORM.*/
                        //ShowStrDetailsForm;

                    end;
                }
                action("Sc&hedule")
                {
                    Caption = 'Sc&hedule';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #50003. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.FORM.*/
                        ShowSchedule;

                    end;
                }
                action("Design WorkSheet")
                {
                    Caption = 'Design WorkSheet';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #50003. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.FORM.*/
                        ShowSalesOrderWorkSheet;

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec.Type := xRec.Type;
        CLEAR(ShortcutDimCode);
    end;

    var
        SalesHeader: Record "Sales Header";
        TransferExtendedText: Codeunit 378;
        SalesPriceCalcMgt: Codeunit 7000;
        ShortcutDimCode: array[8] of Code[20];
        SalesPlanLine: Record "Sales Planning Line";
        Text001: Label 'Prod. Order is already created against the Sales Order.';


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


    procedure _InsertExtendedText(Unconditionally: Boolean);
    begin
        IF TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD;
            TransferExtendedText.InsertSalesExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
            UpdateForm(TRUE);
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


    procedure _ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin);
    begin
        //Rec.ItemAvailability(AvailabilityType);// B2B1.0
    end;


    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin);
    begin
        //Rec.ItemAvailability(AvailabilityType);  // B2B1.0
    end;


    procedure _ShowDimensions();
    begin
        Rec.ShowDimensions;
    end;


    procedure ShowDimensions();
    begin
        Rec.ShowDimensions;
    end;


    procedure UpdateForm(SetSaveRecord: Boolean);
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;


    procedure ShowPrices();
    begin
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
    end;


    procedure ShowLineDisc();
    begin
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader, Rec);
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
            StrOrderLineDetails.SETRANGE(Rec.Type, StrOrderLineDetails.Type::Sale);
            StrOrderLineDetails.SETRANGE(Rec."Document Type", Rec."Document Type");
            StrOrderLineDetails.SETRANGE(Rec."Document No.", Rec."Document No.");
            StrOrderLineDetails.SETRANGE("Item No.", Rec."No.");
            StrOrderLineDetails.SETRANGE(Rec."Line No.", Rec."Line No.");
            StrOrderLineDetailsForm.SETTABLEVIEW(StrOrderLineDetails);
            StrOrderLineDetailsForm.RUNMODAL;
        end;
        */


    procedure "--B2B1.0--"();
    begin
    end;


    procedure ShowSchedule();
    var
        Schedule: Record Schedule2;
        SalesLine: Record "Sales Line";
    begin
        /*
        //IF ("Tender No." = '')  AND ("Tender Line No." =0) THEN BEGIN
          Schedule.RESET;
          Schedule.SETRANGE("Document Type",Schedule."Document Type" :: "Blanket Order");
          Schedule.SETRANGE("Document No.","Document No.");
          Schedule.SETRANGE("Document Line No.","Line No.");
          //Schedule.SETRANGE("Item No.","No.");
          //Schedule.SETRANGE(Quantity,Quantity);
          Page.RUN(60125,Schedule);
        
        //END ELSE BEGIN
          Schedule.RESET;
          Schedule.SETRANGE("Document Type",Schedule."Document Type" :: Tender);
          Schedule.SETRANGE("Document No.","Tender No.");
          Schedule.SETRANGE("Document Line No.","Tender Line No.");
          //Schedule.SETRANGE("Item No.","No.");
          //Schedule.SETRANGE(Quantity,Quantity);
          Schedule.FILTERGROUP(2);
          Page.RUN(60127,Schedule);
          Schedule.FILTERGROUP(0);
        END;
        */

        IF Rec.Type = Rec.Type::Item THEN BEGIN
            IF (Rec."Tender No." <> '') AND (Rec."Tender Line No." <> 0) THEN BEGIN
                Schedule.RESET;
                Schedule.SETRANGE("Document Type", Schedule."Document Type"::"Blanket Order");
                Schedule.SETRANGE("Document No.", Rec."Document No.");
                Schedule.SETRANGE("Document Line No.", Rec."Line No.");
                //Schedule.SETRANGE("Item No.","No.");
                //Schedule.SETRANGE(Quantity,Quantity);
                Schedule.FILTERGROUP(2);
                IF Schedule.FINDFIRST THEN BEGIN
                    PAGE.RUN(60125, Schedule);
                    Schedule.FILTERGROUP(0);
                END ELSE BEGIN
                    SalesLine.RESET;
                    SalesLine.SETRANGE("Document No.", Rec."Document No.");
                    SalesLine.SETRANGE("Line No.", Rec."Line No.");
                    IF SalesLine.FINDSET THEN
                        REPEAT
                            Schedule.INIT;
                            Schedule."Document Type" := Schedule."Document Type"::"Blanket Order";
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
                    Schedule.SETRANGE("Document Type", Schedule."Document Type"::"Blanket Order");
                    Schedule.SETRANGE("Document No.", Rec."Document No.");
                    Schedule.SETRANGE("Document Line No.", Rec."Line No.");
                    Schedule.FILTERGROUP(2);
                    PAGE.RUN(60125, Schedule);
                    Schedule.FILTERGROUP(0);
                END
            END ELSE BEGIN
                SalesLine.RESET;
                SalesLine.SETRANGE("Document No.", Rec."Document No.");
                SalesLine.SETRANGE("Line No.", Rec."Line No.");
                IF SalesLine.FINDSET THEN
                    REPEAT
                        Schedule.INIT;
                        Schedule."Document Type" := Schedule."Document Type"::"Blanket Order";
                        Schedule."Document No." := SalesLine."Document No.";
                        Schedule."Document Line No." := SalesLine."Line No.";
                        Schedule."Line No." := SalesLine."Line No.";
                        Schedule.Type := Schedule.Type::Item;
                        Schedule.VALIDATE("No.", SalesLine."No.");
                        Schedule.Quantity := SalesLine.Quantity;
                        Schedule."Estimated Total Unit Price" := Schedule."Estimated Unit Price" * Rec.Quantity;
                        //salesLine.CALCFIELDS("Estimated Unit Cost");
                        IF Schedule.INSERT THEN;
                    UNTIL SalesLine.NEXT = 0;
                COMMIT;

                Schedule.RESET;
                Schedule.SETRANGE("Document Type", Schedule."Document Type"::"Blanket Order");
                Schedule.SETRANGE("Document No.", Rec."Document No.");
                Schedule.SETRANGE("Document Line No.", Rec."Line No.");
                Schedule.FILTERGROUP(2);
                PAGE.RUN(60125, Schedule);
                Schedule.FILTERGROUP(0);
            END
        END ELSE
            IF Rec.Type = Rec.Type::"G/L Account" THEN BEGIN
                Schedule.RESET;
                Schedule.SETRANGE("Document Type", Schedule."Document Type"::"Blanket Order");
                Schedule.SETRANGE("Document No.", Rec."Document No.");
                Schedule.SETRANGE("Document Line No.", Rec."Line No.");
                Schedule.FILTERGROUP(2);
                PAGE.RUN(60125, Schedule);
                Schedule.FILTERGROUP(0);


            END;

    end;


    procedure ShowSalesOrderWorkSheet();
    var
        DesignWorksheetHeader: Record "Design Worksheet Header";
        DesignWorksheetLine: Record "Design Worksheet Line";
        Item: Record Item;
        ItemDesignWorksheetHeader: Record "Item Design Worksheet Header";
        ItemDesignWorksheetLine: Record "Item Design Worksheet Line";
    begin
        Rec.TESTFIELD("Document Type");
        Rec.TESTFIELD("Document No.");
        Rec.TESTFIELD("Line No.");
        ItemDesignWorksheetHeader.RESET;
        IF ItemDesignWorksheetHeader.GET(Rec."No.") THEN BEGIN
            DesignWorksheetHeader.INIT;
            DesignWorksheetHeader.TRANSFERFIELDS(ItemDesignWorksheetHeader);
            DesignWorksheetHeader."Document No." := Rec."Document No.";
            DesignWorksheetHeader."Document Line No." := Rec."Line No.";
            DesignWorksheetHeader."Document Type" := DesignWorksheetHeader."Document Type"::"Blanket Order";
            IF DesignWorksheetHeader.INSERT THEN;
            ItemDesignWorksheetLine.RESET;
            ItemDesignWorksheetLine.SETRANGE(ItemDesignWorksheetLine."Item No", ItemDesignWorksheetHeader."Item No.");
            IF ItemDesignWorksheetLine.FINDSET THEN
                REPEAT
                    DesignWorksheetLine.INIT;
                    DesignWorksheetLine.TRANSFERFIELDS(ItemDesignWorksheetLine);
                    DesignWorksheetLine."Item No" := Rec."No.";
                    DesignWorksheetLine."Document No." := Rec."Document No.";
                    DesignWorksheetLine."Document Line No." := Rec."Line No.";
                    DesignWorksheetLine."Document Type" := DesignWorksheetLine."Document Type"::"Blanket Order";
                    IF DesignWorksheetLine.INSERT THEN;
                UNTIL ItemDesignWorksheetLine.NEXT = 0;
        END;
        COMMIT;

        CLEAR(DesignWorksheetHeader);
        DesignWorksheetHeader.SETRANGE("Document Type", DesignWorksheetHeader."Document Type"::"Blanket Order");
        DesignWorksheetHeader.SETRANGE("Document No.", Rec."Document No.");
        DesignWorksheetHeader.SETRANGE("Document Line No.", Rec."Line No.");
        DesignWorksheetHeader.FILTERGROUP(2);
        IF DesignWorksheetHeader.FINDFIRST THEN
            PAGE.RUNMODAL(60122, DesignWorksheetHeader);
        DesignWorksheetHeader.FILTERGROUP(0);
    end;


    procedure MakeLines(var SalesLineparam: Record "Sales Line"): Decimal;
    var
        SalesLine: Record "Sales Line";
        ProdOrderLine: Record "Prod. Order Line";
        PurchLine: Record "Purchase Line";
        ReqLine: Record "Requisition Line";
        ReservEntry2: Record "Reservation Entry";
    begin
        SalesPlanLine.DELETEALL;
        ValidateProdOrder;
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::"Blanket Order");
        SalesLine.SETRANGE("Document No.", Rec."Document No.");
        //NSS 301207
        SalesLine.SETRANGE("Line No.", Rec."Line No.");
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


    procedure ValidateProdOrder();
    begin
        Rec.CALCFIELDS("Prod. Order Quantity");
        IF Rec."Prod. Order Quantity" > Rec.Quantity THEN
            ERROR(Text001);
    end;


    local procedure NoOnAfterValidate();
    begin
        InsertExtendedText(FALSE);
    end;


    local procedure QuantityOnAfterValidate();
    begin
        IF Rec.Reserve = Rec.Reserve::Always THEN BEGIN
            CurrPage.SAVERECORD;
            Rec.AutoReserve;
        END;
    end;


    local procedure UnitofMeasureCodeOnAfterValida();
    begin
        IF Rec.Reserve = Rec.Reserve::Always THEN BEGIN
            CurrPage.SAVERECORD;
            Rec.AutoReserve;
        END;
    end;
}

