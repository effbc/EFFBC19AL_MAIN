page 60125 "SO Schedule"
{
    // version Rev01

    // No. sign   Description
    // ---------------------------------------------------
    // 1.3 UPG    BOM Replacement process changes Function UpdateItemNo and
    //            action Update New Item added.

    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = Schedule2;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    ApplicationArea = All;
                }
                field("Design Conclusions1"; Rec."Design Conclusions1")
                {
                    ApplicationArea = All;
                }
                field("Design Conclusion2"; Rec."Design Conclusion2")
                {
                    ApplicationArea = All;
                }
                field("M/S Item"; Rec."M/S Item")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        TestDocStatus;
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        TestDocStatus;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        TestDocStatus;
                    end;
                }
                field("Quantity(Base)"; Rec."Quantity(Base)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prod. Order Quantity"; Rec."Prod. Order Quantity")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prod. Due Date"; Rec."Prod. Due Date")
                {
                    ApplicationArea = All;
                }
                field("Prod. Qty"; Rec."Prod. Qty")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        TestDocStatus;
                    end;
                }
                field("Qty. Per"; Rec."Qty. Per")
                {
                    Caption = 'Qty. Per Unit';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        // Pranavi
                        SL.RESET;
                        SL.SETRANGE(SL."Document No.", Rec."Document No.");
                        SL.SETRANGE(SL."Line No.", Rec."Document Line No.");
                        IF SL.FINDFIRST THEN BEGIN
                            
                            Quantity := ROUND("Qty. Per"* SL.Quantity,1,'>');
                               "Qty. to Ship" := Quantity;
                               "Qty. to ship (Base)" := "Qty. to Ship";
                        END;
                        // Pranavi
                    end;
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                         "Qty. to ship (Base)" := "Qty. to Ship";
                    end;
                }
                field("Qty. to ship (Base)"; Rec."Qty. to ship (Base)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. Shipped"; Rec."Qty. Shipped")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty.Shipped (Base)"; Rec."Qty.Shipped (Base)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Outstanding Qty."; Rec."Outstanding Qty.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Outstanding Qty.(Base)"; Rec."Outstanding Qty.(Base)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("To be Shipped Qty"; Rec."To be Shipped Qty")
                {
                    ApplicationArea = All;
                }
                field("Material Required Date"; Rec."Material Required Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        /*
                        Schedule.RESET;
                        Schedule.SETFILTER(Schedule."Document No.","Document No.");
                        Schedule.SETFILTER(Schedule."No.",'<>%1',' ');
                        //MESSAGE(FORMAT(Schedule.COUNT));
                        IF Schedule.FINDSET THEN BEGIN
                        REPEAT
                        Schedule."Material Required Date":="Material Required Date";
                        Schedule.MODIFY;
                        UNTIL Schedule.NEXT=0;
                        END;
                        *///Commented by Pranavi on 20-Jan-2016

                    end;
                }
                field("Plan Shifting Date"; Rec."Plan Shifting Date")
                {
                    ApplicationArea = All;
                }
                field("Change To Specified Plan Date"; Rec."Change To Specified Plan Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ChangeToSpecifiedPlanDatOnPush;
                    end;
                }
                field("Estimated Total Unit Cost"; Rec."Estimated Total Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Estimated Unit Price"; Rec."Estimated Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Estimated Total Unit Price"; Rec."Estimated Total Unit Price")
                {
                    ApplicationArea = All;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = All;
                }
                field("Calcaulated Amont"; Rec."Calcaulated Amont")
                {
                    ApplicationArea = All;
                }
                field("RDSO Required"; Rec."RDSO Required")
                {
                    ApplicationArea = All;
                }
                field("Purchase Expected Receipt Date"; Rec."Purchase Expected Receipt Date")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Tender Schedule"; Rec."Tender Schedule")
                {
                    ApplicationArea = All;
                }
                field("Sales Description"; Rec."Sales Description")
                {
                    ApplicationArea = All;
                }
                field(Dispatched; Rec.Dispatched)
                {
                    ApplicationArea = All;
                }
                field(SetSelection; Rec.SetSelection)
                {
                    ApplicationArea = All;
                }
                field("RPO Completion Date"; Rec."RPO Completion Date")
                {
                    ApplicationArea = All;
                }
                field("Packet No"; Rec."Packet No")
                {
                    ApplicationArea = All;
                }
                field("Insp. Letter Sent"; Rec."Insp. Letter Sent")
                {
                    ApplicationArea = All;
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Visible = true;
                action("Change the Plan")
                {
                    Caption = 'Change the Plan';
                    Image = Replan;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        "G/L".GET;

                        Schedule.RESET;
                        Schedule.SETCURRENTKEY(Schedule."Material Required Date", Schedule."No.");
                        Schedule.SETFILTER(Schedule."Material Required Date", '>%1', "G/L"."Shortage. Calc. Date");
                        Schedule.SETRANGE(Schedule."Change To Specified Plan Date", TRUE);
                        IF Schedule.FINDSET THEN
                            REPEAT
                                Plan_Change."Schedule_Plan Change"(Schedule."Document No.", Schedule."Document Line No.", Schedule."Line No.");
                            UNTIL Schedule.NEXT = 0;

                        Rec.RESET;
                        Rec.SETCURRENTKEY("Material Required Date", "No.");
                        Rec.SETFILTER("Material Required Date", '>%1', "G/L"."Shortage. Calc. Date");
                        Rec.SETFILTER("Plan Shifting Date", '>%1', 0D);
                    end;
                }
                action("Item Tracking Line")
                {
                    Image = ItemTrackingLines;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        ScheduleTracking: Record "Schedule Tracking Specificatio";
                        ItemTracking: Page "Item Tracking Summary";
                    begin
                        Rec.TESTFIELD(Type, Rec.Type::Item);
                        Rec.TESTFIELD("No.");
                        Rec.TESTFIELD(Quantity);
                        IF "Line No." <> 10000 THEN
                            TESTFIELD("Qty. to Ship");
                        OpenItemTrackingLines;
                        //InitTrackingSpecification(ScheduleTracking);//B2BSP
                    end;
                }
                action(CreateProdOrder)
                {
                    Caption = 'Create Prod Order';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        NewStatus2: Option Simulated,Planned,"Firm Planned",Released;
                        NewOrderType2: Option ItemOrder,ProjectOrder;
                        SalesLine: Record "Sales Line";
                        ProdMakeQty: Integer;
                        ProductionOrder: Record "Production Order";
                        ItemUnitofMeasure: Record "Item Unit of Measure";
                    begin
                        /*
                        IF NOT (USERID IN ['EFFTRONICS\PRANAVI','EFFTRONICS\ANILKUMAR']) THEN
                          ERROR('You Do Not Have Rights!');
                        */
                        ProductionOrder.RESET;
                        ProductionOrder.SETRANGE(Status, ProductionOrder.Status::Released);
                        ProductionOrder.SETRANGE("Sales Order No.", Rec."Document No.");
                        ProductionOrder.SETFILTER("Schedule Line No.", '<>%1', 0);
                        IF ProductionOrder.FINDFIRST THEN
                            ERROR('RPO has been created for this order');

                        IF Rec."Document Line No." <> Rec."Line No." THEN BEGIN
                            SalesLine.RESET;
                            SalesLine.SETRANGE(SalesLine."Document No.", Rec."Document No.");
                            SalesLine.SETRANGE(SalesLine."Line No.", Rec."Document Line No.");
                            IF SalesLine.FINDFIRST THEN
                                IF FORMAT(SalesLine."Pending By") <> ' ' THEN             //Added By Pranavi on 23-09-2015 to restrict create RPO if item is Pending by
                                    ERROR('You Can not Create Production order for Item: ' + Rec."No." + '\ As it Pending By ' + FORMAT(SalesLine."Pending By"));

                        END
                        ELSE
                            ERROR('Can Not Create Prod. Order for Default Line!');
                        SalesPlanLine.DELETEALL;
                        ProdMakeQty := MakeLines(ScheduleLineRec);        //Added by Pranavi on 13-10-215 for quantity correction
                        NewStatus2 := NewStatus2::Released;
                        NewOrderType2 := NewOrderType2::ItemOrder;
                        IF Rec."Unit of Measure Code" <> 'NOS' THEN BEGIN
                            IF ItemUnitofMeasure.GET(Rec."No.", Rec."Unit of Measure Code") THEN
                                ProdMakeQty := ProdMakeQty * ItemUnitofMeasure."Qty. per Unit of Measure";
                        END;
                        Saleshdr.RESET;
                        Saleshdr.SETFILTER(Saleshdr."Document Type", '%1', Saleshdr."Document Type"::Order);
                        Saleshdr.SETFILTER(Saleshdr."No.", Rec."Document No.");
                        IF Saleshdr.FINDFIRST THEN
                            IF Saleshdr."Order Assurance" = FALSE THEN
                                ERROR('Order Was not Assured By Sales Dept.')
                            ELSE BEGIN
                                FOR I := 1 TO ProdMakeQty
                                  DO BEGIN
                                    Qty := 1;
                                    CreateOrders(Qty);
                                END;
                            END;
                        Rec."Prod. Qty" := 0;


                        //BuildForm;

                        //CurrForm.UPDATE;

                    end;
                }
                action("Update New Item")
                {
                    Caption = 'Update New Item';
                    Description = 'UPG1.3 06Feb2019 Updates Item No. in Current Sales Line and in RPO if exist';
                    Image = Change;
                    ApplicationArea = All;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";

                    trigger OnAction();
                    begin
                        //>>UPG1.3 06Feb2019
                        UpdateItemNo;
                        //<<UPG1.3 06Feb2019
                    end;
                }
                action(CreateSingleProdOrder)
                {
                    Caption = 'Create Single  Prod Order';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        NewStatus2: Option Simulated,Planned,"Firm Planned",Released;
                        NewOrderType2: Option ItemOrder,ProjectOrder;
                        SalesLine: Record "Sales Line";
                        ProdMakeQty: Integer;
                        Schedule2: Record Schedule2;
                        ProductionOrder: Record "Production Order";
                        ItemUnitofMeasure: Record "Item Unit of Measure";
                    begin
                        ProductionOrder.RESET;
                        ProductionOrder.SETRANGE(Status, ProductionOrder.Status::Released);
                        ProductionOrder.SETRANGE("Sales Order No.", Rec."Document No.");
                        ProductionOrder.SETFILTER("Schedule Line No.", '<>%1', 0);
                        //ProductionOrder.SETFILTER("Schedule Line No.",'<>%1',0);
                        ProductionOrder.SETRANGE("Schedule Line No.", "Line No.");
                        IF ProductionOrder.FINDFIRST THEN
                            ERROR('RPO has been created for this order');

                        IF "Document Line No." <> "Line No." THEN BEGIN
                            SalesLine.RESET;
                            SalesLine.SETRANGE(SalesLine."Document No.", "Document No.");
                            SalesLine.SETRANGE(SalesLine."Line No.", "Document Line No.");
                            IF SalesLine.FINDFIRST THEN
                                IF FORMAT(SalesLine."Pending By") <> ' ' THEN             //Added By Pranavi on 23-09-2015 to restrict create RPO if item is Pending by
                                    ERROR('You Can not Create Production order for Item: ' + "No." + '\ As it Pending By ' + FORMAT(SalesLine."Pending By"));

                        END
                        ELSE
                            ERROR('Can Not Create Prod. Order for Default Line!');
                        SalesPlanLine.DELETEALL;
                        ProdMakeQty := MakeLines(ScheduleLineRec);        //Added by Pranavi on 13-10-215 for quantity correction
                        NewStatus2 := NewStatus2::Released;
                        NewOrderType2 := NewOrderType2::ItemOrder;
                        IF "Unit of Measure Code" <> 'NOS' THEN BEGIN
                            IF ItemUnitofMeasure.GET("No.", "Unit of Measure Code") THEN
                                ProdMakeQty := ProdMakeQty * ItemUnitofMeasure."Qty. per Unit of Measure";
                        END;
                        Window.OPEN('Action under Progress');
                        Saleshdr.RESET;
                        Saleshdr.SETFILTER(Saleshdr."Document Type", '%1', Saleshdr."Document Type"::Order);
                        Saleshdr.SETFILTER(Saleshdr."No.", "Document No.");
                        SalesLine.SETRANGE(SalesLine."Line No.", "Document Line No.");
                        IF Saleshdr.FINDFIRST THEN
                            IF Saleshdr."Order Assurance" = FALSE THEN
                                ERROR('Order Was not Assured By Sales Dept.')
                            ELSE BEGIN
                                FOR I := 1 TO ProdMakeQty
                                  DO BEGIN
                                    Qty := 1;
                                    CreateOrders(Qty);
                                END;
                            END;
                        "Prod. Qty" := 0;
                        Window.CLOSE;
                        MESSAGE('RPOs Created for Single Quantity : ' + FORMAT(Quantity));

                        //BuildForm;

                        //CurrForm.UPDATE;
                    END;
                    /*

                    IF "Document Line No." <> "Line No." THEN
                    BEGIN
                      SalesLine.RESET;
                      SalesLine.SETRANGE(SalesLine."Document No.","Document No.");
                      SalesLine.SETRANGE(SalesLine."Line No.","Document Line No.");
                      IF SalesLine.FINDFIRST THEN
                        IF FORMAT(SalesLine."Pending By") <> ' ' THEN             //Added By Pranavi on 23-09-2015 to restrict create RPO if item is Pending by
                          ERROR('You Can not Create Production order for Item: '+"No."+'\ As it Pending By '+FORMAT(SalesLine."Pending By"));

                    END
                    ELSE ERROR('Can Not Create Prod. Order for Default Line!');
                    SalesPlanLine.DELETEALL;
                    ProdMakeQty := MakeLines(ScheduleLineRec);        //Added by Pranavi on 13-10-215 for quantity correction
                    NewStatus2 := NewStatus2 :: Released;
                    NewOrderType2 := NewOrderType2 :: ItemOrder;

                    Saleshdr.RESET;
                    Saleshdr.SETFILTER(Saleshdr."Document Type",'%1',Saleshdr."Document Type"::Order);
                    Saleshdr.SETFILTER(Saleshdr."No.","Document No.");
                    IF Saleshdr.FINDFIRST THEN
                      IF Saleshdr."Order Assurance"=FALSE THEN
                        ERROR('Order Was not Assured By Sales Dept.')
                      ELSE
                      BEGIN
                      FOR I := 1 TO ProdMakeQty
                        DO BEGIN
                          Qty := 1;
                          CreateOrders(Qty);
                        END;
                      END;
                    "Prod. Qty" := 0;
                    */


                }

            }
        }
    }

    trigger OnClosePage();
    begin
        Schedule.RESET;
        Schedule.SETRANGE("Document Type", Schedule."Document Type"::Tender);
        Schedule.SETRANGE("Document No.", Rec."Document No.");
        Schedule.SETRANGE("Document Line No.", Rec."Document Line No.");
        IF Schedule.FINDSET THEN
            REPEAT
                TotAmt += Schedule."Calcaulated Amont";
            UNTIL Schedule.NEXT = 0;
        TenderLine.RESET;
        TenderLine.SETRANGE("Document No.", Rec."Document No.");
        TenderLine.SETRANGE("Line No.", Rec."Document Line No.");
        IF TenderLine.FINDFIRST THEN BEGIN
            TenderLine."Total Amount" := TotAmt;
            TenderLine.MODIFY;
        END;
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        rpoQty := 0;
        PrdOrder.RESET;
        PrdOrder.SETFILTER(PrdOrder."Sales Order No.", Rec."Document No.");
        PrdOrder.SETFILTER(PrdOrder."Sales Order Line No.", '%1', Rec."Document Line No.");
        PrdOrder.SETFILTER(PrdOrder."Schedule Line No.", '%1', Rec."Line No.");
        IF PrdOrder.FINDSET THEN
            REPEAT
                rpoQty := rpoQty + PrdOrder.Quantity;
            UNTIL PrdOrder.NEXT = 0;

        IF rpoQty > 0 THEN
            ERROR('Already ' + FORMAT(rpoQty) + ' Production Orders was released on this Product. Please contact Production manager for further actions');

        IF Rec."Document Line No." <> Rec."Line No." THEN
            IF SalesHeader.FINDFIRST THEN
                IF SalesHeader."Order Verified" = TRUE THEN
                    ERROR('Schedule item cannot be inserted when sale order is verified');
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        /*IF (USERID='EFFTRONICS\PADMAJA') OR (USERID='EFFTRONICS\VSNGEETHA') THEN
        BEGIN
        END ELSE IF (USERID='06PD012') OR (USERID='EFFTRONICS\JYOTHSNA')OR(USERID='EFFTRONICS\PRASANNAT')OR(USERID='07GA002') THEN  //sreenivas
        MESSAGE('You are Modifying the Record')
        ELSE
        ERROR('You Cannot Modify The Record');
        */
        IF NOT (USERID IN ['EFFTRONICS\VSNGEETHA', 'EFFTRONICS\SARDHAR', 'EFFTRONICS\PKOTESWARARAO']) THEN BEGIN
            TestDocStatus;
        END;
        IF Rec."Document Line No." = Rec."Line No." THEN BEGIN
            //Added by Pranavi on 12-11-2015
            SL.RESET;
            SL.SETFILTER(SL."Document No.", Rec."Document No.");
            SL.SETFILTER(SL."Line No.", '%1', Rec."Document Line No.");
            IF SL.FINDFIRST THEN BEGIN
                IF xRec."No." = SL."No." THEN
                    ERROR('Not Possible to edit This Schedule Item');
            END;
        END;

    end;

    trigger OnOpenPage();
    begin
        //RESET;
        //SETCURRENTKEY("M/S Item");
        ProdOrder.RESET;
        ProdOrder.SETRANGE(Status, ProdOrder.Status::Released);
        ProdOrder.SETRANGE("Sales Order No.", Rec."Document No.");
        IF ProdOrder.FINDLAST THEN;
        Schedule.RESET;
        //Schedule.SETRANGE("Document Type",Schedule."Document Type"::Tender);
        Schedule.SETRANGE("Document No.", Rec."Document No.");
        Schedule.SETRANGE("Document Line No.", Rec."Document Line No.");
        IF Schedule.FINDFIRST THEN BEGIN
            Schedule."RPO Completion Date" := ProdOrder."Due Date";
            Schedule.MODIFY;
        END;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var

    begin
        rec.Type := rec.type::Item

    end;

    var
        TenderLine: Record "Tender Line";
        TotAmt: Decimal;
        Schedule: Record Schedule2;
        ProdOrder: Record "Production Order";
        "G/L": Record "General Ledger Setup";
        Plan_Change: Codeunit "Plan Change";
        SL: Record "Sales Line";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        ScheduleGrec: Record Schedule2;
        "-B2BSP-": Integer;
        ReserveScheduleComp: Codeunit "Schedule Line Reserve1";
        SalesPlanLine: Record "Sales Planning Line";
        Text001: TextConst ENU = 'You cannot use the Explode BOM function because a prepayment of the sales order has been invoiced.', ENN = 'You cannot use the Explode BOM function because a prepayment of the sales order has been invoiced.';
        ScheduleLineRec: Record Schedule2;
        Saleshdr: Record "Sales Header";
        I: Integer;
        Qty: Integer;
        NewOrderType: Option ItemOrder,ProjectOrder;
        NewStatus: Option Simulated,Planned,"Firm Planned",Released;
        SalesHeader: Record "Sales Header";
        PrdOrder: Record "Production Order";
        rpoQty: Decimal;
        AssignDateGVar: Boolean;
        Window: Dialog;

    local procedure TobeShippedQtyOnAfterInput(var Text: Text[1024]);
    begin
        IF (USERID <> 'EFFTRONICS\PADMAJA') AND (USERID <> '07TE024') AND (USERID <> 'EFFTRONICS\VSNGEETHA') THEN
            ERROR('You dont have rights to chage');
    end;

    local procedure MaterialRequiredDateOnAfterInp(var Text: Text[1024]);
    begin
        IF (USERID <> 'EFFTRONICS\PADMAJA') AND (USERID <> 'SUPER') AND (USERID <> 'EFFTRONICS\VSNGEETHA') THEN
            ERROR('You dont have rights to chage');
    end;

    local procedure PlanShiftingDateOnAfterInput(var Text: Text[1024]);
    begin
        IF (USERID <> 'EFFTRONICS\PADMAJA') AND (USERID <> '07TE024') THEN
            ERROR('You dont have rights to chage');
    end;

    local procedure ChangeToSpecifiedPlanDatOnPush();
    begin
        IF (USERID <> 'EFFTRONICS\PADMAJA') AND (USERID <> '07TE024') THEN
            ERROR('You dont have rights to chage');
    end;

    procedure InitTrackingSpecification(var TrackingSpecification: Record "Schedule Tracking Specificatio");
    begin
        TrackingSpecification.INIT;
        TrackingSpecification."Item No." := Rec."No.";
        TrackingSpecification.Description := Rec.Description;
        TrackingSpecification."Quantity (Base)" := Rec.Quantity;
    end;



    procedure OpenItemTrackingLines();
    var
        Item: Record Item;
        TrackingSpecificationsFrm: Page 30;
        Text001: TextConst ENU = 'You must specify Item Tracking Code in Item No. =''%1''.', FRA = 'Code Traçabilité doit avoir une valeur sur la fiche de l''article = %1';
    begin
        Rec.TESTFIELD("No.");
        Rec.TESTFIELD(Quantity);
        Rec.TESTFIELD("Location Code");
        ReserveScheduleComp.CallItemTracking(Rec);
    end;

    procedure TestDocStatus();
    var
        SH: Record "Sales Header";
    begin
        // Pranavi
        SH.RESET;
        SH.SETRANGE(SH."No.", Rec."Document No.");
        IF SH.FINDFIRST THEN
            SH.TESTFIELD(SH.Status, SH.Status::Open);
        // Pranavi
    end;

    PROCEDURE PartialMakeLines(VAR ScheduleLineparam: Record 60095): Decimal;
    VAR
        SalesLine: Record 37;
        ProdOrderLine: Record 5406;
        PurchLine: Record 39;
        ReqLine: Record 246;
        ReservEntry2: Record 337;
        ScheduleLine: Record 60095;
    BEGIN
        SalesPlanLine.DELETEALL;
        ValidateProdOrder;
        SalesLine.GET(SalesLine."Document Type"::Order, "Document No.", "Document Line No.");
        ScheduleLine.RESET;
        ScheduleLine.SETRANGE(ScheduleLine."Document Type", "Document Type"::Order);
        ScheduleLine.SETRANGE(ScheduleLine."Document No.", "Document No.");
        ScheduleLine.SETRANGE(ScheduleLine."Document Line No.", "Document Line No.");
        ScheduleLine.SETRANGE(ScheduleLine."Line No.", "Line No.");
        ScheduleLine.SETRANGE(ScheduleLine.Type, ScheduleLine.Type::Item);
        IF ScheduleLine.FINDFIRST THEN BEGIN
            ScheduleLine.TESTFIELD(ScheduleLine."Prod. Qty");
            ScheduleLine.TESTFIELD(ScheduleLine."Prod. Due Date");
            SalesPlanLine.INIT;
            SalesPlanLine."Sales Order No." := ScheduleLine."Document No.";
            SalesPlanLine."Sales Order Line No." := ScheduleLine."Document Line No.";
            SalesPlanLine."Schedule Line No." := ScheduleLine."Line No.";
            SalesPlanLine."Item No." := ScheduleLine."No.";
            SalesPlanLine."Variant Code" := SalesLine."Variant Code";
            SalesPlanLine.Description := ScheduleLine.Description;
            SalesPlanLine."Shipment Date" := SalesLine."Shipment Date";
            SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::Released;
            ScheduleLine.CALCFIELDS("Reserved Qty. (Base)");
            SalesPlanLine."Planned Quantity" := ScheduleLine."Reserved Qty. (Base)";
            SalesPlanLine."Needs Replanning" :=
              (SalesPlanLine."Planned Quantity" <> ScheduleLine."Outstanding Qty.(Base)") OR
              (SalesPlanLine."Expected Delivery Date" > SalesPlanLine."Shipment Date");
            SalesPlanLine.INSERT;
            EXIT(ScheduleLine."Prod. Qty");
        END;
    END;

    procedure MakeLines(var ScheduleLineparam: Record Schedule2): Decimal;
    var
        SalesLine: Record "Sales Line";
        ProdOrderLine: Record "Prod. Order Line";
        PurchLine: Record "Purchase Line";
        ReqLine: Record "Requisition Line";
        ReservEntry2: Record "Reservation Entry";
        ScheduleLine: Record Schedule2;
    begin
        SalesPlanLine.DELETEALL;
        ValidateProdOrder;
        SalesLine.GET(SalesLine."Document Type"::Order, Rec."Document No.", Rec."Document Line No.");
        ScheduleLine.RESET;
        ScheduleLine.SETRANGE(ScheduleLine."Document Type", Rec."Document Type"::Order);
        ScheduleLine.SETRANGE(ScheduleLine."Document No.", Rec."Document No.");
        ScheduleLine.SETRANGE(ScheduleLine."Document Line No.", Rec."Document Line No.");
        ScheduleLine.SETRANGE(ScheduleLine."Line No.", Rec."Line No.");
        ScheduleLine.SETRANGE(ScheduleLine.Type, ScheduleLine.Type::Item);
        IF ScheduleLine.FINDFIRST THEN BEGIN
            ScheduleLine.TESTFIELD(ScheduleLine."Prod. Qty");
            ScheduleLine.TESTFIELD(ScheduleLine."Prod. Due Date");
            SalesPlanLine.INIT;
            SalesPlanLine."Sales Order No." := ScheduleLine."Document No.";
            SalesPlanLine."Sales Order Line No." := ScheduleLine."Document Line No.";
            SalesPlanLine."Schedule Line No." := ScheduleLine."Line No.";
            SalesPlanLine."Item No." := ScheduleLine."No.";
            SalesPlanLine."Variant Code" := SalesLine."Variant Code";
            SalesPlanLine.Description := ScheduleLine.Description;
            SalesPlanLine."Shipment Date" := SalesLine."Shipment Date";
            SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::Released;
            ScheduleLine.CALCFIELDS("Reserved Qty. (Base)");
            SalesPlanLine."Planned Quantity" := ScheduleLine."Reserved Qty. (Base)";
            SalesPlanLine."Needs Replanning" :=
              (SalesPlanLine."Planned Quantity" <> ScheduleLine."Outstanding Qty.(Base)") OR
              (SalesPlanLine."Expected Delivery Date" > SalesPlanLine."Shipment Date");
            SalesPlanLine.INSERT;
            EXIT(ScheduleLine."Prod. Qty");
        END;
    end;

    procedure ValidateProdOrder();
    begin
        Rec.CALCFIELDS("Prod. Order Quantity");
        IF Rec."Prod. Order Quantity" > Rec.Quantity THEN
            ERROR(Text001);
    end;

    procedure CreateOrders(Qtyparam: Decimal) OrdersCreated: Boolean;
    var
        Item: Record Item;
        SalesLine: Record "Sales Line";
        ProdOrderFromSale: Codeunit "Event Handling Cust";
        ScheduleLine: Record Schedule2;
    begin
        IF NOT SalesPlanLine.FINDSET THEN
            EXIT;

        REPEAT
            ScheduleLine.GET(
            ScheduleLine."Document Type"::Order,
            SalesPlanLine."Sales Order No.",
            SalesPlanLine."Sales Order Line No.", SalesPlanLine."Schedule Line No.");
            SalesLine.GET(
              SalesLine."Document Type"::Order,
              SalesPlanLine."Sales Order No.",
              SalesPlanLine."Sales Order Line No.");
            SalesLine.TESTFIELD("Shipment Date");
            ScheduleLine.CALCFIELDS("Reserved Qty. (Base)");
            //IF ScheduleLine."Outstanding Qty.(Base)" > ScheduleLine."Reserved Qty. (Base)" THEN BEGIN
            Item.GET(ScheduleLine."No.");
            IF Item."Replenishment System" = Item."Replenishment System"::"Prod. Order" THEN BEGIN
                OrdersCreated := TRUE;
                IF AssignDateGVar THEN
                    ProdOrderFromSale.ProdStartDate(TRUE);
                ProdOrderFromSale.CreateProdOrder2ForSchedule(ScheduleLine, NewStatus::Released, NewOrderType::ItemOrder, 1);
                IF NewOrderType = NewOrderType::ProjectOrder THEN
                    EXIT;
            END;
        //END;
        UNTIL (SalesPlanLine.NEXT = 0);
    end;

    local procedure UpdateItemNo();
    var
        UpdateScheduleItem: Report 32000000;
    begin
        //>>UPG1.3 06Feb2019
        Rec.TESTFIELD(Type, Rec.Type::Item);
        Rec.TESTFIELD("No.");
        CLEAR(UpdateScheduleItem);
        UpdateScheduleItem.USEREQUESTPAGE(TRUE);
        UpdateScheduleItem.SetValues(Rec."Document No.", Rec."Document Line No.", Rec."Line No.");
        UpdateScheduleItem.RUN;
        CurrPage.UPDATE(FALSE);
        //<<UPG1.3 06Feb2019
    end;

    procedure MakeLinesForSchedules(var ScheduleLineparam: Record Schedule2): Decimal;
    var
        SalesLine: Record "Sales Line";
        ProdOrderLine: Record "Prod. Order Line";
        PurchLine: Record "Purchase Line";
        ReqLine: Record "Requisition Line";
        ReservEntry2: Record "Reservation Entry";
        ScheduleLine: Record Schedule2;
    begin
        SalesPlanLine.DELETEALL;
        ValidateProdOrderForSchedules(ScheduleLineparam);
        SalesLine.GET(SalesLine."Document Type"::Order, ScheduleLineparam."Document No.", ScheduleLineparam."Document Line No.");
        ScheduleLine.RESET;
        ScheduleLine.SETRANGE(ScheduleLine."Document Type", Rec."Document Type"::Order);
        ScheduleLine.SETRANGE(ScheduleLine."Document No.", ScheduleLineparam."Document No.");
        ScheduleLine.SETRANGE(ScheduleLine."Document Line No.", ScheduleLineparam."Document Line No.");
        ScheduleLine.SETRANGE(ScheduleLine."Line No.", ScheduleLineparam."Line No.");
        ScheduleLine.SETRANGE(ScheduleLine.Type, ScheduleLine.Type::Item);
        IF ScheduleLine.FINDFIRST THEN BEGIN
            //ScheduleLine.TESTFIELD(ScheduleLine."Prod. Qty");
            //ScheduleLine.TESTFIELD(ScheduleLine."Prod. Due Date");
            SalesPlanLine.INIT;
            SalesPlanLine."Sales Order No." := ScheduleLine."Document No.";
            SalesPlanLine."Sales Order Line No." := ScheduleLine."Document Line No.";
            SalesPlanLine."Schedule Line No." := ScheduleLine."Line No.";
            SalesPlanLine."Item No." := ScheduleLine."No.";
            SalesPlanLine."Variant Code" := SalesLine."Variant Code";
            SalesPlanLine.Description := ScheduleLine.Description;
            SalesPlanLine."Shipment Date" := SalesLine."Shipment Date";
            SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::Released;
            ScheduleLine.CALCFIELDS("Reserved Qty. (Base)");
            SalesPlanLine."Planned Quantity" := ScheduleLine."Reserved Qty. (Base)";
            SalesPlanLine."Needs Replanning" :=
              (SalesPlanLine."Planned Quantity" <> ScheduleLine."Outstanding Qty.(Base)") OR
              (SalesPlanLine."Expected Delivery Date" > SalesPlanLine."Shipment Date");
            SalesPlanLine.INSERT;
            EXIT(ScheduleLine."Outstanding Qty.");
        END;
    end;

    procedure ValidateProdOrderForSchedules(var ScheduleLineLPar: Record Schedule2);
    begin
        ScheduleLineLPar.CALCFIELDS("Prod. Order Quantity");
        IF ScheduleLineLPar."Prod. Order Quantity" > ScheduleLineLPar.Quantity THEN
            ERROR(Text001);
    end;

    procedure CreateOrdersForSchedules(Qtyparam: Decimal) OrdersCreated: Boolean;
    var
        Item: Record Item;
        SalesLine: Record "Sales Line";
        ProdOrderFromSale: Codeunit "Event Handling Cust";
        ScheduleLine: Record Schedule2;
    begin
        IF NOT SalesPlanLine.FINDSET THEN
            EXIT;

        REPEAT
            ScheduleLine.GET(
            ScheduleLine."Document Type"::Order,
            SalesPlanLine."Sales Order No.",
            SalesPlanLine."Sales Order Line No.", SalesPlanLine."Schedule Line No.");
            SalesLine.GET(
              SalesLine."Document Type"::Order,
              SalesPlanLine."Sales Order No.",
              SalesPlanLine."Sales Order Line No.");
            SalesLine.TESTFIELD("Shipment Date");
            ScheduleLine.CALCFIELDS("Reserved Qty. (Base)");
            //IF ScheduleLine."Outstanding Qty.(Base)" > ScheduleLine."Reserved Qty. (Base)" THEN BEGIN
            Item.GET(ScheduleLine."No.");
            IF Item."Replenishment System" = Item."Replenishment System"::"Prod. Order" THEN BEGIN
                OrdersCreated := TRUE;
                ProdOrderFromSale.CreateProdOrder2ForSchedule(ScheduleLine, NewStatus::Released, NewOrderType::ItemOrder, Qtyparam);
                IF NewOrderType = NewOrderType::ProjectOrder THEN
                    EXIT;
            END;
        //END;
        UNTIL (SalesPlanLine.NEXT = 0);
    end;

    local procedure AssignDate(AssignProdDateLpar: Boolean);
    begin
        AssignDateGVar := AssignProdDateLpar;
    end;

    procedure MakeLinesForAll(var ScheduleLineparam: Record Schedule2): Decimal;
    var
        SalesLine: Record "Sales Line";
        ProdOrderLine: Record "Prod. Order Line";
        PurchLine: Record "Purchase Line";
        ReqLine: Record "Requisition Line";
        ReservEntry2: Record "Reservation Entry";
        ScheduleLine: Record Schedule2;
    begin
        SalesPlanLine.DELETEALL;
        ValidateProdOrderForAll(ScheduleLineparam);
        SalesLine.GET(SalesLine."Document Type"::Order, Rec."Document No.", Rec."Document Line No.");
        ScheduleLine.RESET;
        ScheduleLine.SETRANGE(ScheduleLine."Document Type", Rec."Document Type"::Order);
        ScheduleLine.SETRANGE(ScheduleLine."Document No.", Rec."Document No.");
        ScheduleLine.SETRANGE(ScheduleLine."Document Line No.", Rec."Document Line No.");
        ScheduleLine.SETRANGE(ScheduleLine."Line No.", Rec."Line No.");
        ScheduleLine.SETRANGE(ScheduleLine.Type, ScheduleLine.Type::Item);
        IF ScheduleLine.FINDFIRST THEN BEGIN
            SalesPlanLine.INIT;
            SalesPlanLine."Sales Order No." := ScheduleLine."Document No.";
            SalesPlanLine."Sales Order Line No." := ScheduleLine."Document Line No.";
            SalesPlanLine."Schedule Line No." := ScheduleLine."Line No.";
            SalesPlanLine."Item No." := ScheduleLine."No.";
            SalesPlanLine."Variant Code" := SalesLine."Variant Code";
            SalesPlanLine.Description := ScheduleLine.Description;
            SalesPlanLine."Shipment Date" := SalesLine."Shipment Date";
            SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::Released;
            ScheduleLine.CALCFIELDS("Reserved Qty. (Base)");
            SalesPlanLine."Planned Quantity" := ScheduleLine."Reserved Qty. (Base)";
            SalesPlanLine."Needs Replanning" :=
              (SalesPlanLine."Planned Quantity" <> ScheduleLine."Outstanding Qty.(Base)") OR
              (SalesPlanLine."Expected Delivery Date" > SalesPlanLine."Shipment Date");
            SalesPlanLine.INSERT;
            EXIT(ScheduleLine."Outstanding Qty.");
        END;
    end;

    procedure ValidateProdOrderForAll(var Schedule2LPar: Record Schedule2);
    begin
        Schedule2LPar.CALCFIELDS("Prod. Order Quantity");
        IF Schedule2LPar."Prod. Order Quantity" > Schedule2LPar.Quantity THEN
            ERROR(Text001);
    end;
}

