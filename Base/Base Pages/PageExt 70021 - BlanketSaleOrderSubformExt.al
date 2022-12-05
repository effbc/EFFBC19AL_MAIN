pageextension 70021 BlanketSaleOrderSubformExt extends "Blanket Sales Order Subform"
{

    layout
    {

        addafter(Control1)
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;

            }
        }
        modify("No.")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                myInt: Integer;
            begin
                /*item.RESET;
                IF (COPYSTR(Rec."Document No.", 15, 1) = 'L') THEN BEGIN
                    item.SETFILTER(item."Item Category Code", 'FPRODUCT');
                    item.SETFILTER(item."Item Sub Group Code", '%1|%2', 'LED LIGHT', 'IDLC');
                END;
                item.SETFILTER(item."Item Status", '<>In-Active');
                item.SETFILTER(item.Blocked, 'NO');
                IF PAGE.RUNMODAL(31, item) = ACTION::LookupOK THEN
                    Rec.VALIDATE("No.", item."No.");*/

                IF Rec.Type = Rec.Type::Item THEN BEGIN
                    item.RESET;
                    item.SETFILTER(item."Item Status", '<>In-Active');
                    item.SETFILTER(item.Blocked, 'NO');
                    IF Rec."No." <> '' THEN
                        item.SETRANGE("No.", Rec."No.");
                    IF PAGE.RUNMODAL(31, item) = ACTION::LookupOK THEN
                        Rec.VALIDATE("No.", item."No.");
                END                      // copied code by swathi on 25-sep-13
                ELSE
                    IF Rec.Type = Rec.Type::"G/L Account" THEN BEGIN
                        GLAccount.RESET;
                        IF Rec."No." <> '' THEN
                            GLAccount.SETRANGE("No.", Rec."No.");
                        IF PAGE.RUNMODAL(18, GLAccount) = ACTION::LookupOK THEN
                            Rec.VALIDATE("No.", GLAccount."No.");
                    END;
            end;
        }
        addafter("VAT Prod. Posting Group")
        {
            field("Schedule No"; Rec."Schedule No")
            {
                ApplicationArea = All;

            }

        }
        addafter(Description)
        {
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
        }
        /* addafter("Unit Cost (LCY)")
         {
             field()
             {

             }
         }*/
        addafter("Quantity Shipped")
        {
            field("Qty. Shipped (Base)"; Rec."Qty. Shipped (Base)")
            {
                ApplicationArea = All;

            }
        }
        addafter("Quantity Invoiced")
        {
            field("Qty. Invoiced (Base)"; Rec."Qty. Invoiced (Base)")
            {
                ApplicationArea = All;

            }
        }
        addafter("Shortcut Dimension 1 Code")
        {
            field("Unitcost(LOA)"; Rec."Unitcost(LOA)")
            {
                ApplicationArea = All;

            }
            field("Pending By"; Rec."Pending By")
            {
                ApplicationArea = All;

            }
            field("Outstanding Amount"; Rec."Outstanding Amount")
            {
                ApplicationArea = All;

            }
            field("Outstanding Quantity"; Rec."Outstanding Quantity")
            {
                ApplicationArea = All;

            }
            field("Outstanding Qty. (Base)"; Rec."Outstanding Qty. (Base)")
            {
                ApplicationArea = All;

            }

        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Qty. Shipped Not Invd. (Base)"; Rec."Qty. Shipped Not Invd. (Base)")
            {
                ApplicationArea = All;

            }
            field("Qty. Shipped Not Invoiced"; Rec."Qty. Shipped Not Invoiced")
            {
                ApplicationArea = All;

            }
        }
        addafter("ShortcutDimCode[8]")
        {
            field(Reason; Rec.Reason)
            {
                ApplicationArea = All;

            }
            field(MainCategory; Rec.MainCategory)
            {
                ApplicationArea = All;

            }
            field(SubCategory; Rec.SubCategory)
            {
                ApplicationArea = All;

            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;

            }
            field(ProductGroup; Rec.ProductGroup)
            {
                ApplicationArea = All;

            }

        }
    }

    actions
    {
        addafter("Co&mments")
        {
            action("Create Production Order")
            {
                ApplicationArea = All;

                Image = CreateDocument;

                trigger OnAction()
                begin
                    SalesPlanLine.DELETEALL;
                    //Rec.Quantity := CurrPage.TotalSalesLine.PAGE.MakeLines(SalesLineRec);
                    Rec.Quantity := MakeLines(SalesLineRec);

                    FOR I := 1 TO Rec.Quantity
                      DO BEGIN
                        Qty := 1;
                        CreateOrders(Qty);
                    END;
                END;

            }
        }
        addafter("Event")
        {
            action("&Attachment")
            {
                CaptionML = ENU = '&Attachment';
                Visible = false;
                ApplicationArea = All;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    CustAttachments;
                end;
            }

        }
        addbefore("F&unctions")
        {
            action("CreateProd.Order")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    NewStatus2: Option Simulated,Planned,"Firm Planned",Released;
                    NewOrderType2: Option ItemOrder,ProjectOrder;
                begin
                    SalesPlanLine.DELETEALL;
                    Rec.Quantity := MakeLines(SalesLineRec);

                    NewStatus2 := NewStatus2::Released;
                    NewOrderType2 := NewOrderType2::ItemOrder;
                    Saleshdr.RESET;
                    Saleshdr.SETFILTER(Saleshdr."Document Type", '%1', Saleshdr."Document Type"::"Blanket Order");
                    Saleshdr.SETFILTER(Saleshdr."No.", Rec."Document No.");
                    IF Saleshdr.FINDFIRST THEN
                        IF Saleshdr."Order Assurance" = FALSE THEN
                            ERROR('Order Was not Assured By Sales Dept.')
                        ELSE BEGIN
                            FOR I := 1 TO Rec.Quantity
                              DO BEGIN
                                Qty := 1;
                                CreateOrders(Qty);
                            END;
                        END;
                end;
            }
        }
        addafter("Insert &Ext. Texts")
        {
            action("Structure Details")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Structure Details';

                trigger OnAction()
                begin

                    ShowStrDetailsForm();
                end;
            }
            action("Sc&hedule")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Sc&hedule';

                trigger OnAction()
                begin
                    ShowSchedule;
                end;
            }
            action("Design WorkSheet")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Design WorkSheet';

                trigger OnAction()
                begin
                    ShowSalesOrderWorkSheet;
                end;
            }
        }

    }
    PROCEDURE ShowStrDetailsForm();
    VAR
    //StrOrderLineDetails: Record "Structure Order Line Details";
    //StrOrderLineDetailsForm: Page "Structure Order Line Details";
    BEGIN
        /*
        StrOrderLineDetails.RESET;
        StrOrderLineDetails.SETCURRENTKEY(Rec."Document Type", Rec."Document No.", Rec.Type);
        StrOrderLineDetails.SETRANGE(Rec."Document Type", Rec."Document Type");
        StrOrderLineDetails.SETRANGE(Rec."Document No.", Rec."Document No.");
        StrOrderLineDetails.SETRANGE(Rec.Type, StrOrderLineDetails.Type::Sale);
        StrOrderLineDetails.SETRANGE("Item No.", Rec."No.");
        StrOrderLineDetails.SETRANGE(Rec."Line No.", Rec."Line No.");
        StrOrderLineDetailsForm.SETTABLEVIEW(StrOrderLineDetails);
        StrOrderLineDetailsForm.RUNMODAL
        */
    END;



    LOCAL PROCEDURE ValidateSaveShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20]);
    BEGIN
        Rec.ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
        CurrPage.SAVERECORD;
    END;


    PROCEDURE ShowSchedule();
    VAR
        Schedule: Record Schedule2;
        SalesLine: Record "Sales Line";
    BEGIN
        /* {
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
         }*/

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
    END;


    PROCEDURE ShowSalesOrderWorkSheet();
    VAR
        DesignWorksheetHeader: Record "Design Worksheet Header";
        DesignWorksheetLine: Record "Design Worksheet Line";
        Item: Record Item;
        ItemDesignWorksheetHeader: Record "Item Design Worksheet Header";
        ItemDesignWorksheetLine: Record "Item Design Worksheet Line";
    BEGIN
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
    END;


    PROCEDURE MakeLines(VAR SalesLineparam: Record "Sales Line"): Decimal;
    VAR
        SalesLine: Record "Sales Line";
        ProdOrderLine: Record "Prod. Order Line";
        PurchLine: Record "Purchase Line";
        ReqLine: Record "Requisition Line";
        ReservEntry2: Record "Reservation Entry";
    BEGIN
        SalesPlanLine.DELETEALL;
        //ValidateProdOrder;
        ValidateProdOrderSingle(SalesLineparam);//EFF151122
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::"Blanket Order");
        SalesLine.SETRANGE("Document No.", Rec."Document No.");
        //NSS 301207
        SalesLine.SETRANGE("Line No.", SalesLineparam."Line No.");//EFF151122
        //NSS
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);

        IF SalesLine.FINDFIRST THEN BEGIN
            REPEAT
                //SalesLine.TESTFIELD("Prod. Qty");
                //SalesLine.TESTFIELD("Prod. Due Date");
                SalesPlanLine.INIT;
                SalesPlanLine."Sales Order No." := SalesLine."Document No.";
                SalesPlanLine."Sales Order Line No." := SalesLine."Line No.";
                SalesPlanLine."Item No." := SalesLine."No.";

                SalesPlanLine."Variant Code" := SalesLine."Variant Code";
                item.RESET;
                IF item.GET(SalesLine."No.") THEN
                    SalesPlanLine.Description := item.Description
                ELSE
                    SalesPlanLine.Description := SalesLine.Description;
                SalesPlanLine."Shipment Date" := SalesLine."Shipment Date";
                SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::Released;
                SalesLine.CALCFIELDS("Reserved Qty. (Base)");
                SalesPlanLine."Planned Quantity" := SalesLine."Reserved Qty. (Base)";
                /*  {ReservEngineMgt.InitFilterAndSortingLookupFor(ReservEntry,FALSE);
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
                    UNTIL ReservEntry.NEXT = 0;}*/
                SalesPlanLine."Needs Replanning" :=
                  (SalesPlanLine."Planned Quantity" <> SalesLine."Outstanding Qty. (Base)") OR
                  (SalesPlanLine."Expected Delivery Date" > SalesPlanLine."Shipment Date");
                /* {CalculateDisposalPlan(
                   SalesLine."Variant Code",
                   SalesLine."Location Code",SalesLine."Bin Code");}*/
                SalesPlanLine.INSERT;
            UNTIL SalesLine.NEXT = 0;
            EXIT(SalesLine."Outstanding Quantity");
            //
        END;
    END;


    PROCEDURE ValidateProdOrder();
    BEGIN
        Rec.CALCFIELDS("Prod. Order Quantity");
        IF Rec."Prod. Order Quantity" > Rec.Quantity THEN
            ERROR(Text001);
    END;



    PROCEDURE ValidateProdOrderSingle(SalesLineRec: Record "Sales Line"); //EFF151122
    BEGIN
        SalesLineRec.CALCFIELDS("Prod. Order Quantity");
        IF SalesLineRec."Prod. Order Quantity" > SalesLineRec.Quantity THEN
            ERROR(Text001);
    END;

    PROCEDURE CustAttachments();
    VAR
        CustAttach: Record Attachments;
    BEGIN
        CustAttach.RESET;
        CustAttach.SETRANGE("Table ID", DATABASE::"Sales Header");
        CustAttach.SETRANGE("Document No.", Rec."Document No.");
        CustAttach.SETRANGE("Document Type", Rec."Document Type");
        PAGE.RUN(PAGE::"ESPL Attachments", CustAttach);
    END;


    PROCEDURE CreateOrders(Qtyparam: Decimal) OrdersCreated: Boolean;
    VAR
        Item: Record Item;
        SalesLine: Record "Sales Line";
        ProdOrderFromSale: Codeunit 99000792;
    BEGIN
        IF NOT SalesPlanLine.FINDSET THEN
            EXIT;

        REPEAT
            SalesLine.GET(
              SalesLine."Document Type"::"Blanket Order",
              SalesPlanLine."Sales Order No.",
              SalesPlanLine."Sales Order Line No.");
            SalesLine.CALCFIELDS("Reserved Qty. (Base)");
            Item.GET(SalesLine."No.");
            IF Item."Replenishment System" = Item."Replenishment System"::"Prod. Order" THEN BEGIN
                OrdersCreated := TRUE;
                ProdOrderFromSale.CreateProductionOrder(SalesLine, NewStatus::Released, NewOrderType::ItemOrder);
                IF NewOrderType::ProjectOrder = NewOrderType::ProjectOrder THEN
                    EXIT;
            END;
        UNTIL (SalesPlanLine.NEXT = 0);
    END;

    var
        SalesPlanLine: Record "Sales Planning Line";
        Text001: Label 'ENU=Prod. Order is already created against the Sales Order.';
        item: Record Item;
        SalesLineRec: Record "Sales Line";
        Saleshdr: Record "Sales Header";
        I: Integer;
        Qty: Integer;
        mystr: Code[1000];
        temprec: Record "Production Order";
        NewStatus: Enum NewStatus;
        NewOrderType: Enum OrderType;
        Sch: Record Schedule2;
        GLAccount: Record "G/L Account";




}





