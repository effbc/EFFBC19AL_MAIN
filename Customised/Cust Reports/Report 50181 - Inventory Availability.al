report 50181 "Inventory Availability New"
{
    // version NAVW17.00,Rev01

    Caption = 'Inventory Availability';
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = false;

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = SORTING("Prod Start date")
                                ORDER(Ascending)
                                WHERE(Status = CONST(Released),
                                      "Prod Start date" = FILTER(<> ''),
                                      "Location Code" = CONST('PROD'),
                                      "Product Group Code" = FILTER('FPRODUCT' | 'CPCB'));
            dataitem("Prod. Order Component"; "Prod. Order Component")
            {
                CalcFields = "Qty. in Posted Material Issues", "Qty. in Material Issues";
                DataItemLink = "Prod. Order No." = FIELD("No.");
                DataItemTableView = SORTING("Prod. Order No.", "Item No.", "Material Required Day")
                                    ORDER(Ascending)
                                    WHERE("Expected Quantity" = FILTER(> 0));

                trigger OnAfterGetRecord();
                begin
                    //Rev01
                    //Code From Sections
                    SHORTAGE := FALSE;
                    SHORTAGE_AT := '';
                    SHORTAGE_QTY := 0;
                    Required_Qty_Aftr_Alt := 0;

                    "Prod. Order Component".CALCFIELDS("Prod. Order Component"."Qty. in Posted Material Issues", "Prod. Order Component"."Qty. in Material Issues");
                    IF ("Prod. Order Component"."Type of Solder2" = 'SMD') THEN BEGIN
                        "PO-LINE".RESET;
                        "PO-LINE".SETRANGE("PO-LINE"."Prod. Order No.", "Prod. Order Component"."Prod. Order No.");
                        "PO-LINE".SETRANGE("PO-LINE"."Line No.", "Prod. Order Component"."Prod. Order Line No.");
                        IF "PO-LINE".FINDFIRST THEN BEGIN
                            ProdCompLine.RESET;
                            ProdCompLine.SETFILTER(ProdCompLine."Prod. Order No.", "Prod. Order Component"."Prod. Order No.");
                            ProdCompLine.SETFILTER(ProdCompLine."Prod. Order Line No.", FORMAT("Prod. Order Component"."Prod. Order Line No."));
                            ProdCompLine.SETFILTER(ProdCompLine."Product Group Code", 'PCB');
                            IF ProdCompLine.FINDFIRST THEN BEGIN
                                IF STENCIL_PCB(ProdCompLine."Item No.") THEN BEGIN
                                    Location := 'MCH'; // Need to Added Locations (Vishnu)
                                    IF USERID = 'EFFTRONICS\PRANAVI' THEN
                                        SHORTAGE := VERIFY_WITH_STR_QTY("Item No.", "Prod. Order Component"."Expected Quantity" - "Prod. Order Component"."Qty. in Posted Material Issues", "Prod. Order No.")
                                    ELSE
                                        SHORTAGE := VERIFY_WITH_MCH_QTY("Item No.", "Prod. Order Component"."Expected Quantity" - "Prod. Order Component"."Qty. in Posted Material Issues", "Prod. Order No.");
                                    SHORTAGE_AT := 'MCH'; // Need to Added Locations (Vishnu)
                                END
                                ELSE BEGIN
                                    Location := 'STR'; // Need to Added Locations (Vishnu)
                                    SHORTAGE := VERIFY_WITH_STR_QTY("Item No.", "Prod. Order Component"."Expected Quantity" - "Prod. Order Component"."Qty. in Posted Material Issues", "Prod. Order No.");
                                    SHORTAGE_AT := 'STR'; // Need to Added Locations (Vishnu)
                                END;
                            END
                            ELSE BEGIN
                                Location := 'STR'; // Need to Added Locations (Vishnu)
                                SHORTAGE := VERIFY_WITH_STR_QTY("Item No.", "Prod. Order Component"."Expected Quantity" - "Prod. Order Component"."Qty. in Posted Material Issues", "Prod. Order No.");
                                SHORTAGE_AT := 'STR'; // Need to Added Locations (Vishnu)
                            END;
                            /*

                            //"Prod. Order Component"."Item No."
                            IF STENCIL_PCB("PO-LINE"."Item No.") THEN
                            BEGIN
                                SHORTAGE:=VERIFY_WITH_MCH_QTY("Item No.","Prod. Order Component"."Expected Quantity"-"Prod. Order Component"."Qty. in Posted Material Issues","Prod. Order No.");
                                SHORTAGE_AT:='MCH';
                            END
                            ELSE
                            BEGIN
                              SHORTAGE:=VERIFY_WITH_STR_QTY("Item No.","Prod. Order Component"."Expected Quantity"-"Prod. Order Component"."Qty. in Posted Material Issues","Prod. Order No.");
                              SHORTAGE_AT:='STR';
                              {
                              IF SHORTAGE=FALSE THEN   //sundar
                                BEGIN
                                  SHORTAGE:=VERIFY_WITH_PRDSTR_QTY("Item No.","Prod. Order Component"."Expected Quantity"-"Prod. Order Component"."Qty. in Posted Material Issues","Prod. Order No.");
                                  SHORTAGE_AT:='PRODSTR';
                                END;     //sundar
                               }
                            END;
                            */
                        END;
                    END
                    ELSE BEGIN
                        Location := 'STR'; // Need to Added Locations (Vishnu)
                        SHORTAGE := VERIFY_WITH_STR_QTY("Item No.", "Prod. Order Component"."Expected Quantity" - "Prod. Order Component"."Qty. in Posted Material Issues", "Prod. Order No.");
                        SHORTAGE_AT := 'STR'; // Need to Added Locations (Vishnu)
                                              /*   IF SHORTAGE=FALSE THEN  //sundar
                                                  BEGIN
                                                    SHORTAGE:=VERIFY_WITH_PRDSTR_QTY("Item No.","Prod. Order Component"."Expected Quantity","Prod. Order No."-"Prod. Order Component"."Qty. in Posted Material Issues");
                                                    SHORTAGE_AT:='PRODSTR';
                                                  END;    //sundar
                                              */
                    END;

                    IF SHORTAGE THEN BEGIN
                        PO_SHORTAGE_ITEMS.RESET;
                        PO_SHORTAGE_ITEMS.SETRANGE(PO_SHORTAGE_ITEMS."Production Order", "Prod. Order Component"."Prod. Order No.");
                        PO_SHORTAGE_ITEMS.SETRANGE(PO_SHORTAGE_ITEMS.Item, "Prod. Order Component"."Item No.");
                        PO_SHORTAGE_ITEMS.SETRANGE(PO_SHORTAGE_ITEMS."Shortage At", SHORTAGE_AT);
                        IF NOT PO_SHORTAGE_ITEMS.FINDFIRST THEN BEGIN
                            PO_SHORTAGE_ITEMS.INIT;
                            PO_SHORTAGE_ITEMS."Production Order" := "Prod. Order Component"."Prod. Order No.";
                            PO_SHORTAGE_ITEMS.Item := "Prod. Order Component"."Item No.";
                            PO_SHORTAGE_ITEMS.Description := "Prod. Order Component".Description;
                            PO_SHORTAGE_ITEMS.Shortage := SHORTAGE_QTY;
                            PO_SHORTAGE_ITEMS."Shortage At" := SHORTAGE_AT;
                            PO_SHORTAGE_ITEMS."Prod. Start Date" := "Prod. Order Component"."Production Plan Date";   //added by pranavi on 30-Nov-2015
                            PO_SHORTAGE_ITEMS.INSERT;
                        END ELSE BEGIN
                            PO_SHORTAGE_ITEMS.Shortage += "Prod. Order Component"."Expected Quantity" - "Prod. Order Component"."Qty. in Posted Material Issues";
                            PO_SHORTAGE_ITEMS.MODIFY;
                        END;
                    END;

                    //Rev01

                end;

                trigger OnPostDataItem();
                begin
                    IF ForPlanning = FALSE THEN BEGIN
                        "Production Order"."Shortage Verified" := TRUE;
                        "Production Order".MODIFY;
                    END;
                end;

                trigger OnPreDataItem();
                begin
                    //"Prod. Order Component".MODIFYALL("Prod. Order Component"."Completely Picked",FALSE);
                    /*
                    IF USERID = 'EFFTRONICS\PRANAVI' THEN
                    BEGIN
                      TestItems := 'ECDIOZE00059|ECDIOZE00020';
                      "Prod. Order Component".SETFILTER("Prod. Order Component"."Item No.",TestItems);
                    END;
                    */
                    /*IF USERID = 'EFFTRONICS\DURGAMAHESWARI' THEN
                      "Prod. Order Component".SETFILTER("Prod. Order Component"."Item No.",'ECPCBSS00393');
                    */

                end;
            }

            trigger OnAfterGetRecord();
            begin
                WINDOW.UPDATE(1, "Production Order"."No.");
            end;

            trigger OnPostDataItem();
            begin
                WINDOW.CLOSE;
            end;

            trigger OnPreDataItem();
            begin
                WINDOW.OPEN(T1);

                IF USERID = 'EFFTRONICS\PRANAVI' THEN BEGIN
                    IF ForPlanning = TRUE THEN BEGIN
                        /*
                          Include_Purchase_Qty(WORKDATE);
                          Include_Qc_Qty;
                        */
                        "Reserve Running Order Material";
                    END;
                END;

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(General)
                {
                    field(ForPlanning; ForPlanning)
                    {
                        Caption = 'ForPlanning';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        DUM: Record Item temporary;
        WINDOW: Dialog;
        T1: Label 'CALCULATING SHORTAGE #1################';
        ITEM: Record Item;
        STOCK: Decimal;
        ItemLedgEntry: Record "Item Ledger Entry";
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
        AVB: Boolean;
        Alter_PO: Record "Production Order";
        "Alternative Items": Record "Alternate Items";
        POCOMPONENT1: Record "Prod. Order Component";
        "Material Issues Line": Record "Material Issues Line";
        PO_SHORTAGE_ITEMS: Record "Production Order Shortage Item";
        "MAT. ISSUES TRACKING SPEC": Record "Mat.Issue Track. Specification";
        SHORTAGE: Boolean;
        SHORTAGE_AT: Code[10];
        "PO-LINE": Record "Prod. Order Line";
        SHORTAGE_QTY: Decimal;
        PcbGRec: Record PCB;
        LotItemAvail: Record "Lot wise Item Availability";
        ItemLED: Record Item;
        loopVar: Integer;
        asignedQty: Decimal;
        prevLot: array[10000, 3] of Code[20];
        loopPrev: Integer;
        qty: Decimal;
        altPrevLot: array[3000, 3] of Code[20];
        altLoopPrev: Integer;
        ProdCompLine: Record "Prod. Order Component";
        Location: Code[20];
        ForPlanning: Boolean;
        Required_Qty_Aftr_Alt: Decimal;
        TestItems: Text;
        Test_Item: Code[30];
        ProdOrderCmpnt: Record "Prod. Order Component";
        ProdOrder: Record "Production Order";

    procedure Include_Item(item1: Code[20]; Verify: Boolean);
    var
        "Material Issues Line": Record "Material Issues Line";
        ProdOrderCmpnt: Record "Prod. Order Component";
        ProdOrder: Record "Production Order";
    begin
        IF USERID = 'EFFTRONICS\PRANAVI' THEN
            ForPlanning := TRUE;

        ITEM.RESET;
        // ITEM.SETFILTER(ITEM."No.",item1);
        // IF ITEM.FIND('-') THEN
        IF ITEM.GET(item1) THEN BEGIN
            IF (ITEM."Product Group Code Cust" <> 'CPCB') AND (ITEM."Product Group Code Cust" <> 'FPRODUCT') THEN BEGIN
                IF (ForPlanning = TRUE) OR ((NOT ITEM."Dispatch Material") AND (ForPlanning = FALSE)) THEN BEGIN
                    ITEM.CALCFIELDS(ITEM."Inventory at Stores", ITEM."Qty. on Purch. Order",
                                    ITEM."Quantity Under Inspection", ITEM."Stock At MCH Location");
                    DUM.INIT;
                    DUM."No." := ITEM."No.";
                    DUM.Description := ITEM.Description;
                    DUM."Standard Cost" := ITEM."Qty. on Purch. Order";
                    DUM."Unit Cost" := ITEM."Quantity Under Inspection";
                    STOCK := 0;
                    ITEM.CALCFIELDS(ITEM."Quantity Under Inspection", ITEM."Quantity Rejected", ITEM."Quantity Rework",
                    ITEM."Quantity Sent for Rework", ITEM."Inventory at Stores");
                    IF ITEM."QC Enabled" = TRUE THEN BEGIN
                        IF (ITEM."Quantity Under Inspection" = 0) AND (ITEM."Quantity Rejected" = 0) AND
                           (ITEM."Quantity Rework" = 0) AND (ITEM."Quantity Sent for Rework" = 0) THEN BEGIN
                            ItemLedgEntry.RESET;
                            ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                            "Expiration Date", "Lot No.", "Serial No.");
                            ItemLedgEntry.SETRANGE("Item No.", ITEM."No.");
                            ItemLedgEntry.SETRANGE(Open, TRUE);
                            ItemLedgEntry.SETFILTER("Location Code", '%1|%2', 'STR', 'MCH'); // Need to Added Locations (Vishnu)
                            IF ItemLedgEntry.FIND('-') THEN
                                REPEAT
                                    IF NOT MSLItemExpiryDate(ItemLedgEntry, ForPlanning) THEN  // Condition Added by Pranavi on 22-05-2017 for MSL Process
                                    BEGIN
                                        IF ItemLedgEntry."Location Code" = 'STR' THEN // Need to Added Locations (Vishnu)
                                            STOCK += ItemLedgEntry."Remaining Quantity";
                                        //Lot wise item availability  //mnraju  06-JUN-2014
                                        IF ITEM."Product Group Code cust" = 'LED' THEN BEGIN
                                            LotItemAvail.RESET;
                                            LotItemAvail.SETRANGE(LotItemAvail."Item No", ItemLedgEntry."Item No.");
                                            LotItemAvail.SETRANGE(LotItemAvail."LOT No", ItemLedgEntry."Lot No.");
                                            LotItemAvail.SETRANGE(LotItemAvail.Location, ItemLedgEntry."Location Code");
                                            IF LotItemAvail.FINDFIRST THEN BEGIN
                                                LotItemAvail."Total Qty" := LotItemAvail."Total Qty" + ItemLedgEntry."Remaining Quantity";
                                                LotItemAvail.MODIFY;
                                            END
                                            ELSE BEGIN
                                                LotItemAvail.INIT;
                                                LotItemAvail."Item No" := ItemLedgEntry."Item No.";
                                                LotItemAvail."LOT No" := ItemLedgEntry."Lot No.";
                                                LotItemAvail."Total Qty" := ItemLedgEntry."Remaining Quantity";
                                                LotItemAvail."Allocated Qty" := 0;
                                                LotItemAvail.Location := ItemLedgEntry."Location Code";
                                                LotItemAvail.INSERT;
                                            END;
                                        END;
                                        //END Lot wise item availability  //mnraju  06-JUN-2014
                                    END;
                                UNTIL ItemLedgEntry.NEXT = 0;
                        END ELSE BEGIN
                            STOCK := 0;
                            ItemLedgEntry.RESET;
                            ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                                                        "Expiration Date", "Lot No.", "Serial No.");
                            ItemLedgEntry.SETRANGE("Item No.", ITEM."No.");
                            ItemLedgEntry.SETRANGE(Open, TRUE);
                            ItemLedgEntry.SETFILTER("Location Code", '%1|%2', 'STR', 'MCH'); // Need to Added Locations (Vishnu)
                            IF ItemLedgEntry.FIND('-') THEN
                                REPEAT
                                    ItemLedgEntry.MARK(TRUE);
                                    IF (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") AND (QualityItemLedgEntry."Inspection Status" =
                                        QualityItemLedgEntry."Inspection Status"::"Under Inspection")) OR
                                        (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.")
                                        AND (QualityItemLedgEntry."Inspection Status" = QualityItemLedgEntry."Inspection Status"::Rejected)) THEN
                                        ItemLedgEntry.MARK(FALSE);

                                UNTIL ItemLedgEntry.NEXT = 0;
                        END;
                    END;
                    ItemLedgEntry.MARKEDONLY(TRUE);
                    IF ItemLedgEntry.FIND('-') THEN
                        REPEAT
                            IF NOT MSLItemExpiryDate(ItemLedgEntry, ForPlanning) THEN  // Condition Added by Pranavi on 22-05-2017 for MSL Process
                            BEGIN
                                IF ItemLedgEntry."Location Code" = 'STR' THEN // Need to Added Locations (Vishnu)
                                    STOCK := STOCK + ItemLedgEntry."Remaining Quantity";
                                //Lot wise item availability  //mnraju  06-JUN-2014
                                IF ITEM."Product Group Code cust" = 'LED' THEN BEGIN
                                    LotItemAvail.RESET;
                                    LotItemAvail.SETRANGE(LotItemAvail."Item No", ItemLedgEntry."Item No.");
                                    LotItemAvail.SETRANGE(LotItemAvail."LOT No", ItemLedgEntry."Lot No.");
                                    LotItemAvail.SETRANGE(LotItemAvail.Location, ItemLedgEntry."Location Code");
                                    IF LotItemAvail.FINDFIRST THEN BEGIN
                                        LotItemAvail."Total Qty" := LotItemAvail."Total Qty" + ItemLedgEntry."Remaining Quantity";
                                        LotItemAvail.MODIFY;
                                    END
                                    ELSE BEGIN
                                        LotItemAvail.INIT;
                                        LotItemAvail."Item No" := ItemLedgEntry."Item No.";
                                        LotItemAvail."LOT No" := ItemLedgEntry."Lot No.";
                                        LotItemAvail."Total Qty" := ItemLedgEntry."Remaining Quantity";
                                        LotItemAvail."Allocated Qty" := 0;
                                        LotItemAvail.Location := ItemLedgEntry."Location Code";

                                        LotItemAvail.INSERT;
                                    END;
                                END;
                                //END Lot wise item availability  //mnraju  06-JUN-2014
                            END;
                        UNTIL ItemLedgEntry.NEXT = 0;

                    "MAT. ISSUES TRACKING SPEC".RESET;
                    "MAT. ISSUES TRACKING SPEC".SETRANGE("MAT. ISSUES TRACKING SPEC"."Item No.", DUM."No.");
                    "MAT. ISSUES TRACKING SPEC".SETFILTER("MAT. ISSUES TRACKING SPEC"."Location Code", 'STR|MCH'); // Need to Added Locations (Vishnu)
                    "MAT. ISSUES TRACKING SPEC".SETFILTER("MAT. ISSUES TRACKING SPEC".Quantity, '>%1', 0);
                    IF "MAT. ISSUES TRACKING SPEC".FIND('-') THEN
                        REPEAT
                            IF STOCK > "MAT. ISSUES TRACKING SPEC".Quantity THEN BEGIN
                                IF ForPlanning = FALSE THEN
                                    IF "MAT. ISSUES TRACKING SPEC"."Location Code" = 'STR' THEN // Need to Added Locations (Vishnu)
                                        STOCK := STOCK - "MAT. ISSUES TRACKING SPEC".Quantity;
                                // Lot wise item availability  //mnraju  06-JUN-2014
                                LotItemAvail.RESET;
                                LotItemAvail.SETRANGE(LotItemAvail."Item No", "MAT. ISSUES TRACKING SPEC"."Item No.");
                                LotItemAvail.SETRANGE(LotItemAvail."LOT No", "MAT. ISSUES TRACKING SPEC"."Lot No.");
                                LotItemAvail.SETRANGE(LotItemAvail.Location, "MAT. ISSUES TRACKING SPEC"."Location Code");
                                IF LotItemAvail.FINDFIRST THEN BEGIN
                                    LotItemAvail."Total Qty" := LotItemAvail."Total Qty" - "MAT. ISSUES TRACKING SPEC".Quantity;
                                    LotItemAvail.MODIFY;
                                END;  // Lot wise item availability  //mnraju  06-JUN-2014
                            END;
                        UNTIL "MAT. ISSUES TRACKING SPEC".NEXT = 0;
                    ITEM.CALCFIELDS(ITEM."Stock at PROD Stores");  //sundar  // Need to Added Locations (Vishnu)
                    IF ForPlanning = TRUE THEN BEGIN
                        IF USERID = 'EFFTRONICS\PRANAVI' THEN
                            DUM."Maximum Inventory" := STOCK + ITEM."Stock at PROD Stores" + ITEM."Stock At MCH Location"   //sundar  // Need to Added Locations (Vishnu)
                        ELSE
                            DUM."Maximum Inventory" := STOCK + ITEM."Stock at PROD Stores";   //sundar // Need to Added Locations (Vishnu)
                    END
                    ELSE
                        DUM."Maximum Inventory" := STOCK;
                    IF (ForPlanning = TRUE) AND (USERID = 'EFFTRONICS\PRANAVI') THEN
                        DUM."Total Inventory" := STOCK + ITEM."Stock at PROD Stores" + ITEM."Stock At MCH Location"
                    ELSE
                        DUM."Total Inventory" := ITEM."Stock At MCH Location";
                    DUM."Base Unit of Measure" := ITEM."Base Unit of Measure";
                    DUM."Stock at Stores" := STOCK;  // Need to Added Locations (Vishnu)
                    DUM."Safety Stock Qty (CS)" := ITEM."Stock At MCH Location";
                    DUM."Product Group Code Cust" := ITEM."Product Group Code cust";

                    IF FORMAT(ITEM."Safety Lead Time") = '' THEN BEGIN
                        IF Verify THEN BEGIN
                            IF USERID <> 'EFFTRONICS\PRANAVI' THEN BEGIN
                                ERROR('There Is No Saftey Lead Time For the Item ' + DUM.Description + '(' + DUM."No." + ')');
                                CurrReport.BREAK;
                            END;
                        END
                    END ELSE
                        DUM."Safety Lead Time" := ITEM."Safety Lead Time";
                    DUM.INSERT;
                    /*
                    //>> Added by Pranavi on 04-Mar-2017 for Reserver Mat issues stock of planning
                    IF (ForPlanning = TRUE) THEN
                    BEGIN
                      SHORTAGE:=FALSE;
                      "Material Issues Line".RESET;
                      "Material Issues Line".SETCURRENTKEY("Material Issues Line"."Item No.",
                                                           "Material Issues Line"."Prod. Order No.",
                                                           "Material Issues Line"."Prod. Order Line No.");

                      "Material Issues Line".SETFILTER("Material Issues Line"."Qty. to Receive",'>%1',0);
                      "Material Issues Line".SETRANGE("Material Issues Line"."Item No.",DUM."No.");
                      "Material Issues Line".SETRANGE("Material Issues Line".Status,"Material Issues Line".Status::Released);
                      "Material Issues Line".SETRANGE("Material Issues Line"."Transfer-from Code",'STR');
                      "Material Issues Line".SETRANGE("Material Issues Line"."Transfer-to Code",'PROD');
                      IF "Material Issues Line".FIND('-') THEN
                      REPEAT
                        ProdOrderCmpnt.RESET;
                        ProdOrderCmpnt.SETCURRENTKEY(ProdOrderCmpnt."Production Plan Date",ProdOrderCmpnt."Item No."
                                                             ,ProdOrderCmpnt."Prod. Order No.");
                        ProdOrderCmpnt.SETFILTER(ProdOrderCmpnt."Production Plan Date",'>%1',WORKDATE);
                        ProdOrderCmpnt.SETRANGE(ProdOrderCmpnt."Item No.","Material Issues Line"."Item No.");
                        IF (ProdOrderCmpnt.FIND('-')) THEN
                        BEGIN
                          ProdOrderCmpnt.SETRANGE(ProdOrderCmpnt."Prod. Order No.","Material Issues Line"."Prod. Order No.");
                          ProdOrderCmpnt.SETRANGE(ProdOrderCmpnt."Prod. Order Line No.","Material Issues Line"."Prod. Order Line No.");
                          IF NOT (ProdOrderCmpnt.FIND('-')) THEN
                          BEGIN
                            IF Dum."Maximum Inventory">="Material Issues Line"."Qty. to Receive" THEN
                            BEGIN
                              Dum."Maximum Inventory"-="Material Issues Line"."Qty. to Receive";
                              Dum.MODIFY;
                            END
                            ELSE
                            BEGIN
                              SHORTAGE:="Verify Alternate"(DUM."No.","Material Issues Line"."Qty. to Receive","Material Issues Line"."Prod. Order No.");
                              DUM.GET("Material Issues Line"."Item No.");
                              IF SHORTAGE THEN
                              BEGIN
                                IF DUM.GET("Material Issues Line"."Item No.") THEN
                                BEGIN
                                  IF (Required_Qty_Aftr_Alt <> "Material Issues Line"."Qty. to Receive") AND (Required_Qty_Aftr_Alt > 0) THEN
                                  BEGIN
                                    IF Required_Qty_Aftr_Alt  > DUM."Maximum Inventory" THEN
                                      SHORTAGE_QTY:=Required_Qty_Aftr_Alt-DUM."Maximum Inventory"
                                    ELSE
                                    BEGIN
                                      DUM."Maximum Inventory":=DUM."Maximum Inventory"-Required_Qty_Aftr_Alt;
                                      DUM.MODIFY;
                                      SHORTAGE := FALSE;
                                    END;
                                  END
                                  ELSE
                                  BEGIN
                                    SHORTAGE_QTY:="Material Issues Line"."Qty. to Receive"-DUM."Maximum Inventory";
                                    IF DUM."Maximum Inventory">0 THEN
                                    BEGIN
                                      DUM."Maximum Inventory":=0;
                                      DUM.MODIFY;
                                    END;
                                  END;
                                END;
                              END;
                              IF SHORTAGE THEN
                              BEGIN
                                PO_SHORTAGE_ITEMS.SETRANGE(PO_SHORTAGE_ITEMS."Production Order","Material Issues Line"."Prod. Order No.");
                                PO_SHORTAGE_ITEMS.SETRANGE(PO_SHORTAGE_ITEMS.Item,DUM."No.");
                                PO_SHORTAGE_ITEMS.SETRANGE(PO_SHORTAGE_ITEMS."Shortage At",'STR');
                                IF NOT PO_SHORTAGE_ITEMS.FINDFIRST THEN
                                BEGIN
                                  PO_SHORTAGE_ITEMS.INIT;
                                  PO_SHORTAGE_ITEMS."Production Order":="Material Issues Line"."Prod. Order No.";
                                  PO_SHORTAGE_ITEMS.Item:=DUM."No.";
                                  PO_SHORTAGE_ITEMS.Description:=DUM.Description;
                                  PO_SHORTAGE_ITEMS.Shortage:=SHORTAGE_QTY;
                                  PO_SHORTAGE_ITEMS."Shortage At":='STR';
                                  ProdOrder.RESET;
                                  ProdOrder.SETRANGE(ProdOrder.Status,ProdOrder.Status::Released);
                                  ProdOrder.SETRANGE(ProdOrder."No.","Material Issues Line"."Prod. Order No.");
                                  IF ProdOrder.FINDFIRST THEN
                                    PO_SHORTAGE_ITEMS."Prod. Start Date":=ProdOrder."Prod Start date";   //added by pranavi on 30-Nov-2015
                                  PO_SHORTAGE_ITEMS.INSERT;
                                END ELSE
                                BEGIN
                                  PO_SHORTAGE_ITEMS.Shortage+="Prod. Order Component"."Expected Quantity"-"Prod. Order Component"."Qty. in Posted Material Issues";
                                  PO_SHORTAGE_ITEMS.MODIFY;
                                END;
                              END;
                            END;
                          END;
                        END;
                      UNTIL "Material Issues Line".NEXT=0;
                    END;
                    //<< Added by Pranavi on 04-Mar-2017 for Reserver Mat issues stock of planning
                    */
                END;
            END;
        END;

    end;

    procedure "Verify Alternate"(Item1: Code[20]; Req_Qty: Decimal; "Prod. Order": Code[20]) SHORTAGE: Boolean;
    begin
        SHORTAGE := TRUE;
        Required_Qty_Aftr_Alt := 0;
        Required_Qty_Aftr_Alt := Req_Qty;
        Alter_PO.RESET;
        Alter_PO.SETRANGE(Alter_PO.Status, 3);
        Alter_PO.SETRANGE(Alter_PO."No.", "Prod. Order");
        IF Alter_PO.FIND('-') THEN BEGIN
            IF ITEM.GET(Alter_PO."Source No.") THEN BEGIN
                //"Alternative Items".SETRANGE("Alternative Items"."Proudct Type",ITEM."Item Sub Group Code"); //This line commented by pranavi on 08-Dec-2015
                "Alternative Items".SETFILTER("Alternative Items"."Proudct Type", '%1|%2', ITEM."Item Sub Group Code", 'ALL PRODUCTS'); //This line Added by pranavi on 08-Dec-2015
                "Alternative Items".SETRANGE("Alternative Items"."Item No.", Item1);
                IF "Alternative Items".FIND('-') THEN
                    REPEAT
                        IF NOT (DUM.GET("Alternative Items"."Alternative Item No.")) THEN
                            Include_Item("Alternative Items"."Alternative Item No.", TRUE);

                        IF DUM.GET("Alternative Items"."Alternative Item No.") THEN BEGIN
                            IF ForPlanning = FALSE THEN BEGIN
                                //MNRAJU
                                IF (ItemLED.GET("Alternative Items"."Alternative Item No.")) AND (ItemLED."Product Group Code cust" = 'LED') THEN //LED POSTING     MNRAJU 06-JUN-2014
                                BEGIN
                                    altLoopPrev := 1;
                                    "PO-LINE".RESET;
                                    "PO-LINE".SETFILTER("PO-LINE"."Prod. Order No.", "Prod. Order Component"."Prod. Order No.");
                                    "PO-LINE".SETFILTER("PO-LINE"."Line No.", '%1', "Prod. Order Component"."Prod. Order Line No.");
                                    IF "PO-LINE".FINDFIRST THEN BEGIN
                                        loopVar := 0;
                                        REPEAT
                                            SHORTAGE := TRUE;
                                            loopVar := loopVar + 1;
                                            LotItemAvail.RESET;
                                            LotItemAvail.SETCURRENTKEY(LotItemAvail."Item No", LotItemAvail."LOT No", LotItemAvail.Location);
                                            LotItemAvail.SETRANGE(LotItemAvail."Item No", "Alternative Items"."Alternative Item No.");
                                            LotItemAvail.SETRANGE(LotItemAvail.Location, Location);
                                            IF LotItemAvail.FINDSET THEN
                                                REPEAT
                                                    IF ((LotItemAvail."Total Qty" - LotItemAvail."Allocated Qty") >= "Prod. Order Component"."Quantity per") THEN BEGIN
                                                        altPrevLot[altLoopPrev, 1] := LotItemAvail."Item No";
                                                        altPrevLot[altLoopPrev, 2] := LotItemAvail."LOT No";
                                                        altPrevLot[altLoopPrev, 3] := FORMAT("Prod. Order Component"."Quantity per");
                                                        altLoopPrev := altLoopPrev + 1;
                                                        LotItemAvail."Allocated Qty" := LotItemAvail."Allocated Qty" + "Prod. Order Component"."Quantity per";
                                                        LotItemAvail.MODIFY;
                                                        SHORTAGE := FALSE;
                                                    END;
                                                UNTIL (LotItemAvail.NEXT = 0) OR (SHORTAGE = FALSE);
                                        UNTIL ((loopVar = "PO-LINE".Quantity) OR (SHORTAGE = TRUE));
                                    END;

                                    IF NOT SHORTAGE THEN BEGIN
                                        Change_Alternate_Item(Item1, DUM."No.", "Prod. Order");
                                        IF loopPrev > 1 THEN BEGIN
                                            REPEAT
                                                loopPrev := loopPrev - 1;
                                                LotItemAvail.RESET;
                                                LotItemAvail.SETCURRENTKEY(LotItemAvail."Item No", LotItemAvail."LOT No", LotItemAvail.Location);
                                                LotItemAvail.SETRANGE(LotItemAvail."Item No", prevLot[loopPrev, 1]);
                                                LotItemAvail.SETRANGE(LotItemAvail."LOT No", prevLot[loopPrev, 2]);
                                                LotItemAvail.SETRANGE(LotItemAvail.Location, Location);
                                                IF LotItemAvail.FINDSET THEN
                                                    REPEAT
                                                        EVALUATE(qty, prevLot[loopPrev, 3]);
                                                        LotItemAvail."Allocated Qty" := LotItemAvail."Allocated Qty" - qty;
                                                        LotItemAvail.MODIFY;
                                                    UNTIL LotItemAvail.NEXT = 0;
                                            UNTIL loopPrev = 1;
                                        END;
                                    END
                                    ELSE BEGIN
                                        IF altLoopPrev > 1 THEN BEGIN
                                            REPEAT
                                                altLoopPrev := altLoopPrev - 1;
                                                LotItemAvail.RESET;
                                                LotItemAvail.SETCURRENTKEY(LotItemAvail."Item No", LotItemAvail."LOT No", LotItemAvail.Location);
                                                LotItemAvail.SETRANGE(LotItemAvail."Item No", altPrevLot[altLoopPrev, 1]);
                                                LotItemAvail.SETRANGE(LotItemAvail."LOT No", altPrevLot[altLoopPrev, 2]);
                                                LotItemAvail.SETRANGE(LotItemAvail.Location, Location);
                                                IF LotItemAvail.FINDSET THEN
                                                    REPEAT
                                                        EVALUATE(qty, altPrevLot[altLoopPrev, 3]);
                                                        LotItemAvail."Allocated Qty" := LotItemAvail."Allocated Qty" - qty;
                                                        LotItemAvail.MODIFY;
                                                    UNTIL LotItemAvail.NEXT = 0;
                                            UNTIL altLoopPrev = 1;
                                        END;
                                    END;

                                END  //MNRAJU
                                ELSE BEGIN
                                    IF DUM."Maximum Inventory" > 0 THEN BEGIN
                                        IF DUM."Maximum Inventory" >= Req_Qty THEN BEGIN
                                            DUM."Maximum Inventory" := DUM."Maximum Inventory" - Req_Qty;
                                            DUM.MODIFY;
                                            Change_Alternate_Item(Item1, DUM."No.", "Prod. Order");
                                            SHORTAGE := FALSE;
                                            EXIT(SHORTAGE);
                                        END ELSE BEGIN
                                            DUM."Maximum Inventory" := 0;
                                            DUM.MODIFY;
                                        END;
                                    END;
                                END;
                            END ELSE BEGIN // $Start--Shortage Calculation for Plannin Purpose
                                IF DUM."Maximum Inventory" > 0 THEN BEGIN
                                    IF DUM."Maximum Inventory" >= Req_Qty THEN BEGIN
                                        DUM."Maximum Inventory" := DUM."Maximum Inventory" - Req_Qty;
                                        DUM.MODIFY;
                                        SHORTAGE := FALSE;
                                        EXIT(SHORTAGE);
                                    END ELSE BEGIN
                                        IF DUM."Maximum Inventory" > 0 THEN BEGIN
                                            Req_Qty := Req_Qty - DUM."Maximum Inventory";
                                            DUM."Maximum Inventory" := 0;
                                            DUM.MODIFY;
                                        END;
                                    END;
                                END;
                            END;  // $Start--Shortage Calculation for Plannin Purpose
                        END;
                    UNTIL "Alternative Items".NEXT = 0;
                IF ForPlanning = TRUE THEN BEGIN
                    Required_Qty_Aftr_Alt := Req_Qty;
                END;
            END;
        END;
        EXIT(SHORTAGE);
    end;

    procedure "Reserve Running Order Material"();
    begin
        /*
        "Material Issues Line".SETCURRENTKEY("Material Issues Line"."Item No.",
                                             "Material Issues Line"."Prod. Order No.",
                                             "Material Issues Line"."Prod. Order Line No.");
        "Material Issues Line".SETFILTER("Material Issues Line"."Qty. to Receive",'>%1',0);
        "Material Issues Line".SETRANGE("Material Issues Line".Status,"Material Issues Line".Status::Released);
        "Material Issues Line".SETRANGE("Material Issues Line"."Transfer-from Code",'STR');
        "Material Issues Line".SETRANGE("Material Issues Line"."Transfer-to Code",'PROD');
        IF "Material Issues Line".FIND('-') THEN
        REPEAT
          POCOMPONENT1.SETCURRENTKEY(POCOMPONENT1."Production Plan Date",
                                     POCOMPONENT1."Item No.",
                                     POCOMPONENT1."Prod. Order No.");
          POCOMPONENT1.SETRANGE(POCOMPONENT1."Production Plan Date",TODAY+2);
          POCOMPONENT1.SETRANGE(POCOMPONENT1."Item No.","Material Issues Line"."Item No.");
          IF POCOMPONENT1.FIND('-') THEN
          BEGIN
            IF NOT DUM.GET("Material Issues Line"."Item No.") THEN
               Include_Item("Material Issues Line"."Item No.",FALSE);
        
            IF DUM."Maximum Inventory">="Material Issues Line"."Qty. to Receive" THEN
            BEGIN
              DUM."Maximum Inventory"-="Material Issues Line"."Qty. to Receive";
              DUM.MODIFY;
            END;
          END;
        UNTIL "Material Issues Line".NEXT=0;
        */
        // FILTERING THE PENDING  MATERIAL REQUETS BASED ON FOLLOWING CONDITIONS
        // 1) TRANSFER- FROM -CODE MUST BE "STR" & TRANSFER-TO-CODE MUST BE "PROD"
        // 2) REQUEST MUST BE RELEASED
        ForPlanning := TRUE;
        "Material Issues Line".RESET;
        "Material Issues Line".SETCURRENTKEY("Material Issues Line"."Item No.",
                                             "Material Issues Line"."Prod. Order No.",
                                             "Material Issues Line"."Prod. Order Line No.");
        "Material Issues Line".SETFILTER("Material Issues Line"."Qty. to Receive", '>%1', 0);
        //"Material Issues Line".SETRANGE("Material Issues Line"."Item No.",'ECPCBSS00635');
        "Material Issues Line".SETRANGE("Material Issues Line".Status, "Material Issues Line".Status::Released);
        "Material Issues Line".SETRANGE("Material Issues Line"."Transfer-from Code", 'STR');   // Need to Added Locations (Vishnu)
        "Material Issues Line".SETRANGE("Material Issues Line"."Transfer-to Code", 'PROD');
        //Test_Item:='BOICHAR00036';
        IF Test_Item <> '' THEN
            "Material Issues Line".SETRANGE("Material Issues Line"."Item No.", Test_Item);
        IF "Material Issues Line".FIND('-') THEN
            REPEAT
                IF NOT DUM.GET("Material Issues Line"."Item No.") THEN
                    Include_Item("Material Issues Line"."Item No.", FALSE);
                // VERIFYING THAT MATERIAL IS PLANNED IN FUTURE PRODUCTION (OR) NOT
                ProdOrderCmpnt.RESET;
                ProdOrderCmpnt.SETCURRENTKEY(ProdOrderCmpnt."Production Plan Date", ProdOrderCmpnt."Item No."
                                                     , ProdOrderCmpnt."Prod. Order No.");
                ProdOrderCmpnt.SETFILTER(ProdOrderCmpnt."Production Plan Date", '>%1', WORKDATE);
                ProdOrderCmpnt.SETRANGE(ProdOrderCmpnt."Item No.", "Material Issues Line"."Item No.");
                IF (ProdOrderCmpnt.FIND('-')) THEN BEGIN
                    ProdOrderCmpnt.SETRANGE(ProdOrderCmpnt."Prod. Order No.", "Material Issues Line"."Prod. Order No.");
                    ProdOrderCmpnt.SETRANGE(ProdOrderCmpnt."Prod. Order Line No.", "Material Issues Line"."Prod. Order Line No.");
                    IF NOT (ProdOrderCmpnt.FIND('-')) THEN BEGIN
                        // UPDATING INFORMATION INTO VIRTUAL STOCK
                        IF DUM.GET("Material Issues Line"."Item No.") THEN BEGIN
                            IF DUM."Maximum Inventory" >= "Material Issues Line"."Qty. to Receive" THEN BEGIN
                                DUM."Maximum Inventory" -= "Material Issues Line"."Qty. to Receive";
                                DUM.MODIFY;
                            END
                            ELSE BEGIN
                                SHORTAGE := "Verify Alternate"(DUM."No.", "Material Issues Line"."Qty. to Receive", "Material Issues Line"."Prod. Order No.");
                                DUM.GET("Material Issues Line"."Item No.");
                                IF SHORTAGE THEN BEGIN
                                    IF DUM.GET("Material Issues Line"."Item No.") THEN BEGIN
                                        IF (Required_Qty_Aftr_Alt <> "Material Issues Line"."Qty. to Receive") AND (Required_Qty_Aftr_Alt > 0) THEN BEGIN
                                            IF Required_Qty_Aftr_Alt > DUM."Maximum Inventory" THEN
                                                SHORTAGE_QTY := Required_Qty_Aftr_Alt - DUM."Maximum Inventory"
                                            ELSE BEGIN
                                                DUM."Maximum Inventory" := DUM."Maximum Inventory" - Required_Qty_Aftr_Alt;
                                                DUM.MODIFY;
                                                SHORTAGE := FALSE;
                                            END;
                                        END
                                        ELSE BEGIN
                                            SHORTAGE_QTY := "Material Issues Line"."Qty. to Receive" - DUM."Maximum Inventory";
                                            IF DUM."Maximum Inventory" > 0 THEN BEGIN
                                                DUM."Maximum Inventory" := 0;
                                                DUM.MODIFY;
                                            END;
                                        END;
                                    END;
                                END;
                                IF SHORTAGE THEN BEGIN
                                    IF DUM.GET("Material Issues Line"."Item No.") THEN BEGIN
                                        PO_SHORTAGE_ITEMS.RESET;
                                        PO_SHORTAGE_ITEMS.SETRANGE(PO_SHORTAGE_ITEMS."Production Order", "Material Issues Line"."Prod. Order No.");
                                        PO_SHORTAGE_ITEMS.SETRANGE(PO_SHORTAGE_ITEMS.Item, DUM."No.");
                                        PO_SHORTAGE_ITEMS.SETRANGE(PO_SHORTAGE_ITEMS."Shortage At", 'STR'); // Need to Added Locations (Vishnu)
                                        IF NOT PO_SHORTAGE_ITEMS.FINDFIRST THEN BEGIN
                                            PO_SHORTAGE_ITEMS.INIT;
                                            PO_SHORTAGE_ITEMS."Production Order" := "Material Issues Line"."Prod. Order No.";
                                            PO_SHORTAGE_ITEMS.Item := DUM."No.";
                                            PO_SHORTAGE_ITEMS.Description := DUM.Description;
                                            PO_SHORTAGE_ITEMS.Shortage := SHORTAGE_QTY;
                                            PO_SHORTAGE_ITEMS."Shortage At" := 'STR'; // Need to Added Locations (Vishnu)
                                            ProdOrder.RESET;
                                            ProdOrder.SETRANGE(ProdOrder.Status, ProdOrder.Status::Released);
                                            ProdOrder.SETRANGE(ProdOrder."No.", "Material Issues Line"."Prod. Order No.");
                                            IF ProdOrder.FINDFIRST THEN BEGIN
                                                IF ProdOrder."Prod Start date" <> 0D THEN
                                                    PO_SHORTAGE_ITEMS."Prod. Start Date" := ProdOrder."Prod Start date"   //added by pranavi on 30-Nov-2015
                                                ELSE
                                                    PO_SHORTAGE_ITEMS."Prod. Start Date" := TODAY;
                                            END
                                            ELSE
                                                PO_SHORTAGE_ITEMS."Prod. Start Date" := TODAY;
                                            PO_SHORTAGE_ITEMS.INSERT;
                                        END;
                                    END ELSE BEGIN
                                        PO_SHORTAGE_ITEMS.Shortage += "Material Issues Line"."Qty. to Receive";
                                        PO_SHORTAGE_ITEMS.MODIFY;
                                    END;
                                END;
                            END;
                        END;
                    END;
                END;
            UNTIL "Material Issues Line".NEXT = 0;

    end;

    procedure Change_Alternate_Item(Actual_Item: Code[20]; Replaced_Item: Code[20]; Prod_Order: Code[20]);
    begin
        POCOMPONENT1.RESET;
        POCOMPONENT1.SETCURRENTKEY(POCOMPONENT1."Prod. Order No.",
                                   POCOMPONENT1."Item No.",
                                   POCOMPONENT1."Material Required Day");
        POCOMPONENT1.SETRANGE(POCOMPONENT1."Prod. Order No.", Prod_Order);
        POCOMPONENT1.SETRANGE(POCOMPONENT1."Item No.", Actual_Item);
        IF POCOMPONENT1.FIND('-') THEN
            REPEAT
                POCOMPONENT1."Item No." := Replaced_Item;
                POCOMPONENT1.VALIDATE(POCOMPONENT1."Item No.", Replaced_Item);
                POCOMPONENT1.MODIFY;
            UNTIL POCOMPONENT1.NEXT = 0;
    end;

    procedure VERIFY_WITH_STR_QTY(ITEM: Code[20]; REQUIRED_QTY: Decimal; PROD_ORDER: Code[20]) SHORTAGE: Boolean;
    var
        SHORT: Boolean;
    begin
        IF NOT (DUM.GET(ITEM)) THEN
            Include_Item(ITEM, TRUE);

        asignedQty := 0;
        IF DUM.GET(ITEM) THEN BEGIN
            SHORTAGE := FALSE;
            IF ForPlanning = FALSE THEN BEGIN
                IF (ItemLED.GET(ITEM)) AND (ItemLED."Product Group Code cust" = 'LED') THEN //LED POSTING     MNRAJU 06-JUN-2014
                BEGIN
                    loopPrev := 1;
                    "PO-LINE".RESET;
                    "PO-LINE".SETFILTER("PO-LINE"."Prod. Order No.", "Prod. Order Component"."Prod. Order No.");
                    "PO-LINE".SETFILTER("PO-LINE"."Line No.", '%1', "Prod. Order Component"."Prod. Order Line No.");
                    IF "PO-LINE".FINDFIRST THEN BEGIN
                        loopVar := 0;
                        REPEAT
                            loopVar := loopVar + 1;
                            //SHORTAGE:=VERIFY_WITH_STR_QTY("Item No.","Prod. Order Component"."Quantity per","Prod. Order No.");
                            LotItemAvail.RESET;
                            LotItemAvail.SETCURRENTKEY(LotItemAvail."Item No", LotItemAvail."LOT No", LotItemAvail.Location);
                            LotItemAvail.SETRANGE(LotItemAvail."Item No", ITEM);
                            LotItemAvail.SETRANGE(LotItemAvail.Location, Location);
                            SHORT := TRUE;

                            IF LotItemAvail.FINDSET THEN
                                REPEAT
                                    IF ((LotItemAvail."Total Qty" - LotItemAvail."Allocated Qty") >= "Prod. Order Component"."Quantity per") THEN BEGIN
                                        prevLot[loopPrev, 1] := LotItemAvail."Item No";
                                        prevLot[loopPrev, 2] := LotItemAvail."LOT No";
                                        prevLot[loopPrev, 3] := FORMAT("Prod. Order Component"."Quantity per");
                                        loopPrev := loopPrev + 1;
                                        LotItemAvail."Allocated Qty" := LotItemAvail."Allocated Qty" + "Prod. Order Component"."Quantity per";
                                        LotItemAvail.MODIFY;
                                        SHORT := FALSE;
                                    END
                                UNTIL (LotItemAvail.NEXT = 0) OR (SHORT = FALSE);

                        UNTIL ((loopVar = "PO-LINE".Quantity) OR (SHORT = TRUE));
                        IF SHORT THEN BEGIN
                            SHORTAGE_QTY := ("PO-LINE".Quantity - (loopVar - 1)) * "Prod. Order Component"."Quantity per";
                        END;
                    END;

                    IF SHORT THEN BEGIN
                        SHORTAGE := "Verify Alternate"(DUM."No.", REQUIRED_QTY, PROD_ORDER);
                        /*   IF SHORTAGE THEN               //anil
                           BEGIN
                           IF DUM.GET(ITEM) THEN
                           BEGIN
                             SHORTAGE_QTY:=REQUIRED_QTY-DUM."Maximum Inventory";
                             IF DUM."Maximum Inventory">0 THEN
                             BEGIN
                               DUM."Maximum Inventory":=0;
                               DUM.MODIFY;
                             END;
                           END;
                         END;
                          //anil
                        */
                    END;

                END
                ELSE BEGIN
                    IF DUM."Maximum Inventory" >= (REQUIRED_QTY) THEN BEGIN
                        DUM."Maximum Inventory" := DUM."Maximum Inventory" - (REQUIRED_QTY);
                        DUM.MODIFY;
                        SHORTAGE := FALSE;
                    END ELSE BEGIN
                        SHORTAGE := "Verify Alternate"(DUM."No.", REQUIRED_QTY, PROD_ORDER);
                        IF SHORTAGE THEN BEGIN
                            IF DUM.GET(ITEM) THEN BEGIN
                                SHORTAGE_QTY := REQUIRED_QTY - DUM."Maximum Inventory";
                                IF DUM."Maximum Inventory" > 0 THEN BEGIN
                                    DUM."Maximum Inventory" := 0;
                                    DUM.MODIFY;
                                END;
                            END;
                        END;
                    END;
                END;
            END ELSE BEGIN    // Start--shortage calculation for planning purpose
                IF DUM."Maximum Inventory" >= (REQUIRED_QTY) THEN BEGIN
                    DUM."Maximum Inventory" := DUM."Maximum Inventory" - (REQUIRED_QTY);
                    DUM.MODIFY;
                    SHORTAGE := FALSE;
                END ELSE BEGIN
                    SHORTAGE := "Verify Alternate"(DUM."No.", REQUIRED_QTY, PROD_ORDER);
                    IF SHORTAGE THEN BEGIN
                        IF DUM.GET(ITEM) THEN BEGIN
                            IF (Required_Qty_Aftr_Alt <> REQUIRED_QTY) AND (Required_Qty_Aftr_Alt > 0) THEN BEGIN
                                IF Required_Qty_Aftr_Alt > DUM."Maximum Inventory" THEN
                                    SHORTAGE_QTY := Required_Qty_Aftr_Alt - DUM."Maximum Inventory"
                                ELSE BEGIN
                                    DUM."Maximum Inventory" := DUM."Maximum Inventory" - Required_Qty_Aftr_Alt;
                                    DUM.MODIFY;
                                    SHORTAGE := FALSE;
                                END;
                            END
                            ELSE BEGIN
                                SHORTAGE_QTY := REQUIRED_QTY - DUM."Maximum Inventory";
                                IF DUM."Maximum Inventory" > 0 THEN BEGIN
                                    DUM."Maximum Inventory" := 0;
                                    DUM.MODIFY;
                                END;
                            END;
                        END;
                    END;
                END;
            END;  // END--shortage calculation for planning purpose
        END;
        EXIT(SHORTAGE);

    end;

    procedure VERIFY_WITH_MCH_QTY(ITEM: Code[20]; REQUIRED_QTY: Decimal; PROD_ORDER: Code[20]) SHORTAGE: Boolean;
    var
        SHORT: Boolean;
    begin
        IF NOT (DUM.GET(ITEM)) THEN
            Include_Item(ITEM, TRUE);

        asignedQty := 0;
        IF DUM.GET(ITEM) THEN BEGIN
            SHORTAGE := FALSE;
            IF ForPlanning = FALSE THEN BEGIN
                IF (ItemLED.GET(ITEM)) AND (ItemLED."Product Group Code cust" = 'LED') THEN //LED POSTING     MNRAJU 06-JUN-2014
                BEGIN
                    loopPrev := 1;
                    "PO-LINE".RESET;
                    "PO-LINE".SETFILTER("PO-LINE"."Prod. Order No.", "Prod. Order Component"."Prod. Order No.");
                    "PO-LINE".SETFILTER("PO-LINE"."Line No.", '%1', "Prod. Order Component"."Prod. Order Line No.");
                    IF "PO-LINE".FINDFIRST THEN BEGIN
                        loopVar := 0;
                        REPEAT
                            loopVar := loopVar + 1;
                            SHORT := TRUE;
                            //SHORTAGE:=VERIFY_WITH_STR_QTY("Item No.","Prod. Order Component"."Quantity per","Prod. Order No.");
                            LotItemAvail.RESET;
                            LotItemAvail.SETCURRENTKEY(LotItemAvail."Item No", LotItemAvail."LOT No", LotItemAvail.Location);
                            LotItemAvail.SETRANGE(LotItemAvail."Item No", ITEM);
                            LotItemAvail.SETRANGE(LotItemAvail.Location, Location);
                            IF LotItemAvail.FINDSET THEN
                                REPEAT
                                    IF ((LotItemAvail."Total Qty" - LotItemAvail."Allocated Qty") >= "Prod. Order Component"."Quantity per") THEN BEGIN
                                        prevLot[loopPrev, 1] := LotItemAvail."Item No";
                                        prevLot[loopPrev, 2] := LotItemAvail."LOT No";
                                        prevLot[loopPrev, 3] := FORMAT("Prod. Order Component"."Quantity per");
                                        loopPrev := loopPrev + 1;
                                        LotItemAvail."Allocated Qty" := LotItemAvail."Allocated Qty" + "Prod. Order Component"."Quantity per";
                                        LotItemAvail.MODIFY;
                                        SHORT := FALSE;
                                    END
                                UNTIL (LotItemAvail.NEXT = 0) OR (SHORT = FALSE);

                        UNTIL ((loopVar = "PO-LINE".Quantity) OR (SHORT = TRUE));
                        IF SHORT THEN BEGIN
                            SHORTAGE_QTY := ("PO-LINE".Quantity - (loopVar - 1)) * "Prod. Order Component"."Quantity per";
                        END;
                    END;

                    IF SHORT THEN BEGIN
                        SHORTAGE := VERIFY_MCH_ALTERNATE(DUM."No.", REQUIRED_QTY, PROD_ORDER);
                        /*  IF SHORTAGE THEN
                          BEGIN
                          IF DUM.GET(ITEM) THEN
                          BEGIN
                            SHORTAGE_QTY:=REQUIRED_QTY-DUM."Maximum Inventory";
                            IF DUM."Maximum Inventory">0 THEN
                            BEGIN
                              DUM."Maximum Inventory":=0;
                              DUM.MODIFY;
                            END;
                          END;
                        END;
                        */
                    END;

                END
                ELSE BEGIN
                    IF DUM."Total Inventory" >= (REQUIRED_QTY) THEN BEGIN
                        DUM."Total Inventory" := DUM."Total Inventory" - (REQUIRED_QTY);
                        DUM.MODIFY;
                        SHORTAGE := FALSE;
                    END ELSE BEGIN
                        SHORTAGE := VERIFY_MCH_ALTERNATE(DUM."No.", REQUIRED_QTY, PROD_ORDER);
                        IF SHORTAGE THEN BEGIN
                            IF DUM.GET(ITEM) THEN BEGIN
                                SHORTAGE_QTY := REQUIRED_QTY - DUM."Total Inventory";
                                IF DUM."Total Inventory" > 0 THEN BEGIN
                                    DUM."Total Inventory" := 0;
                                    DUM.MODIFY;
                                END;
                            END;
                        END;
                    END;
                END;
            END ELSE BEGIN
                IF DUM."Total Inventory" >= (REQUIRED_QTY) THEN BEGIN
                    DUM."Total Inventory" := DUM."Total Inventory" - (REQUIRED_QTY);
                    DUM.MODIFY;
                    SHORTAGE := FALSE;
                END ELSE BEGIN
                    SHORTAGE := VERIFY_MCH_ALTERNATE(DUM."No.", REQUIRED_QTY, PROD_ORDER);
                    IF SHORTAGE THEN BEGIN
                        IF DUM.GET(ITEM) THEN BEGIN
                            IF (Required_Qty_Aftr_Alt <> REQUIRED_QTY) AND (Required_Qty_Aftr_Alt > 0) THEN BEGIN
                                IF Required_Qty_Aftr_Alt > DUM."Total Inventory" THEN
                                    SHORTAGE_QTY := Required_Qty_Aftr_Alt - DUM."Total Inventory"
                                ELSE BEGIN
                                    DUM."Total Inventory" := DUM."Total Inventory" - Required_Qty_Aftr_Alt;
                                    DUM.MODIFY;
                                    SHORTAGE := FALSE;
                                END;
                            END
                            ELSE BEGIN
                                SHORTAGE_QTY := REQUIRED_QTY - DUM."Total Inventory";
                                IF DUM."Total Inventory" > 0 THEN BEGIN
                                    DUM."Total Inventory" := 0;
                                    DUM.MODIFY;
                                END;
                            END;
                        END;
                    END;
                END;
            END;
        END;

    end;

    procedure STENCIL_PCB(PCB_BOM: Code[20]) STENCIL_PCB: Boolean;
    begin
        /*
           IF PCB_BOM IN ['ECPBPCB00431','ECPBPCB00434','ECPBPCB00549','ECPBPCB00553',
                         'ECPBPCB00882','ECPBPCB00554','ECPBPCB00566','ECPBPCB00856',
                         'ECPBPCB00936','ECPBPCB00934','ECPBPCB01049','ECPBPCB01038',
                         'ECPBPCB00534','ECPBPCB01058','ECPBPCB01063','ECPBPCB00908',
                         'ECPBPCB01070','ECPBPCB01072','ECPBPCB01111','ECPBPCB00864',
                         'ECPBPCB01231','ECPBPCB00906','ECPBPCB01145','ECPBPCB01146',
                         'ECPBPCB00933','ECPBPCB00935','ECPBPCB00937','ECPBPCB01073',
                         'ECPCBDS00878','ECPCBDS01137','ECPBPCB01000','ECPBPCB01270',
                         'ECPBPCB00582','ECPBPCB00889','ECPBPCB01306','ECPBPCB01258',
                         'ECPCBDS01123','ECPBPCB01344','ECPBPCB01343','ECPCBDS01230',
                         'ECPCBDS01228','ECPCBDS01229','ECPCBDS01243','ECPCBDS01257',
                         'ECPCBDS01256','ECPCBDS01258','ECPCBSS00447','ECPBPCB01351',
                         'ECPBPCB01348','ECPBPCB01347','ECPBPCB01300','ECPBPCB01381',
                         'ECPBPCB01109','ECPBPCB01436','ECPBPCB01437','ECPBPCB01461'{,
                         'ECPCBSS00497','ECPCBDS01390','ECPCBSS00499','ECPCBSS00496',
                         'ECPCBSS00480'},'ECPBPCB01486','ECPBPCB01487','ECPBPCB01528',
                         'ECPBPCB01529','ECPBPCB01193','ECPBPCB01591','ECPBPCB00172',
                         'ECPBPCB00173','ECPBPCB00015','ECPBPCB00016','ECPBPCB00029',
                         'ECPBPCB01289','ECPBPCB00418','ECPBPCB00481',{'ECPBPCB00873',}
                         'ECPBPCB00869','ECPBPCB01026','ECPBPCB00400','ECPBPCB00890',
                         'ECPBPCB00487','ECPBPCB00559','ECPBPCB00802','ECPBPCB00813',
                         'ECPBPCB00938','ECPBPCB00971','ECPBPCB01016','ECPBPCB01075',
                         'ECPBPCB01311','ECPBPCB01077','ECPBPCB01076','ECPBPCB01078',
                         'ECPBPCB01092','ECPBPCB01224','ECPBPCB01205','ECPBPCB01155',
                         'ECPBPCB01185','ECPBPCB01228','ECPBPCB01225','ECPBPCB01226',
                         'ECPBPCB01227','ECPBPCB01230','ECPBPCB01263','ECPBPCB01257',
                         'ECPBPCB01385','ECPBPCB01384','ECPBPCB01373',{'ECPBPCB01396',}
                         {'ECPBPCB01398',}'ECPBPCB01394','ECPBPCB01443','ECPBPCB01442',
                         'ECPBPCB01516','ECPBPCB01269','ECPBPCB01282','ECPBPCB01399',
                         'ECPBPCB01452','ECPBPCB01455','ECPBPCB01451','ECPBPCB01567',
                         'ECPBPCB01566','ECPBPCB01345','ECPBPCB01571','ECPBPCB01545',
                         'ECPBPCB01205','ECPBPCB01439','ECPBPCB00400','ECPBPCB01544',
                         'ECPBPCB01476','ECPBPCB01469','ECPBPCB01472','ECPBPCB01481',
                         'ECPBPCB01260','ECPBPCB01312','ECPBPCB01525','ECPBPCB01533',
                         'ECPBPCB01532','ECPBPCB01572','ECPBPCB01573','ECPBPCB01508',
                         'ECPBPCB01321','ECPBPCB01488','ECPBPCB01468','ECPBPCB01596',
                         'ECPBPCB01572','ECPBPCB01573','ECPBPCB01508','ECPBPCB01321',
                         'ECPBPCB01600','ECPBPCB01602','ECPBPCB01603','ECPBPCB01617',
                         'ECPBPCB01644','ECPBPCB01650','ECPBPCB01649'] THEN
        
        */
        //Added by swathi on 24-10-13 for stencil process
        PcbGRec.RESET;
        PcbGRec.SETRANGE(PcbGRec."PCB No.", PCB_BOM);
        PcbGRec.SETFILTER(PcbGRec.Stencil, '<>%1', '');
        IF PcbGRec.FINDFIRST THEN
            //Added by swathi on 24-10-13 for stencil process
              STENCIL_PCB := TRUE
        ELSE
            STENCIL_PCB := FALSE;

        EXIT(STENCIL_PCB);

    end;

    procedure VERIFY_MCH_ALTERNATE(Item1: Code[20]; Req_Qty: Decimal; "Prod. Order": Code[20]) SHORTAGE: Boolean;
    begin
        SHORTAGE := TRUE;
        Required_Qty_Aftr_Alt := Req_Qty;
        Alter_PO.RESET;
        Alter_PO.SETRANGE(Alter_PO.Status, 3);
        Alter_PO.SETRANGE(Alter_PO."No.", "Prod. Order");
        IF Alter_PO.FIND('-') THEN BEGIN
            IF ITEM.GET(Alter_PO."Source No.") THEN BEGIN
                // "Alternative Items".SETRANGE("Alternative Items"."Proudct Type",ITEM."Item Sub Group Code");
                "Alternative Items".SETFILTER("Alternative Items"."Proudct Type", '%1|%2', ITEM."Item Sub Group Code", 'ALL PRODUCTS'); //This line Added by pranavi on 08-Dec-2015
                "Alternative Items".SETRANGE("Alternative Items"."Item No.", Item1);
                IF "Alternative Items".FIND('-') THEN
                    REPEAT
                        IF NOT (DUM.GET("Alternative Items"."Alternative Item No.")) THEN
                            Include_Item("Alternative Items"."Alternative Item No.", TRUE);

                        IF DUM.GET("Alternative Items"."Alternative Item No.") THEN BEGIN
                            IF ForPlanning = FALSE THEN BEGIN
                                //MNRAJU
                                IF (ItemLED.GET("Alternative Items"."Alternative Item No.")) AND (ItemLED."Product Group Code cust" = 'LED') THEN //LED POSTING     MNRAJU 06-JUN-2014
                                BEGIN
                                    altLoopPrev := 1;
                                    "PO-LINE".RESET;
                                    "PO-LINE".SETFILTER("PO-LINE"."Prod. Order No.", "Prod. Order Component"."Prod. Order No.");
                                    "PO-LINE".SETFILTER("PO-LINE"."Line No.", '%1', "Prod. Order Component"."Prod. Order Line No.");
                                    IF "PO-LINE".FINDFIRST THEN BEGIN
                                        loopVar := 0;
                                        REPEAT
                                            SHORTAGE := TRUE;
                                            loopVar := loopVar + 1;
                                            LotItemAvail.RESET;
                                            LotItemAvail.SETCURRENTKEY(LotItemAvail."Item No", LotItemAvail."LOT No", LotItemAvail.Location);
                                            LotItemAvail.SETRANGE(LotItemAvail."Item No", "Alternative Items"."Alternative Item No.");
                                            LotItemAvail.SETRANGE(LotItemAvail.Location, Location);
                                            IF LotItemAvail.FINDSET THEN
                                                REPEAT
                                                    IF ((LotItemAvail."Total Qty" - LotItemAvail."Allocated Qty") >= "Prod. Order Component"."Quantity per") THEN BEGIN
                                                        altPrevLot[altLoopPrev, 1] := LotItemAvail."Item No";
                                                        altPrevLot[altLoopPrev, 2] := LotItemAvail."LOT No";
                                                        altPrevLot[altLoopPrev, 3] := FORMAT("Prod. Order Component"."Quantity per");
                                                        altLoopPrev := altLoopPrev + 1;
                                                        LotItemAvail."Allocated Qty" := LotItemAvail."Allocated Qty" + "Prod. Order Component"."Quantity per";
                                                        LotItemAvail.MODIFY;
                                                        SHORTAGE := FALSE;
                                                    END;
                                                UNTIL (LotItemAvail.NEXT = 0) OR (SHORTAGE = FALSE);
                                        UNTIL ((loopVar = "PO-LINE".Quantity) OR (SHORTAGE = TRUE));
                                    END;

                                    IF NOT SHORTAGE THEN BEGIN
                                        Change_Alternate_Item(Item1, DUM."No.", "Prod. Order");
                                        IF loopPrev > 1 THEN BEGIN
                                            REPEAT
                                                loopPrev := loopPrev - 1;
                                                LotItemAvail.RESET;
                                                LotItemAvail.SETCURRENTKEY(LotItemAvail."Item No", LotItemAvail."LOT No", LotItemAvail.Location);
                                                LotItemAvail.SETRANGE(LotItemAvail."Item No", prevLot[loopPrev, 1]);
                                                LotItemAvail.SETRANGE(LotItemAvail."LOT No", prevLot[loopPrev, 2]);
                                                LotItemAvail.SETRANGE(LotItemAvail.Location, Location);
                                                IF LotItemAvail.FINDSET THEN
                                                    REPEAT
                                                        EVALUATE(qty, prevLot[loopPrev, 3]);
                                                        LotItemAvail."Allocated Qty" := LotItemAvail."Allocated Qty" - qty;
                                                        LotItemAvail.MODIFY;
                                                    UNTIL LotItemAvail.NEXT = 0;
                                            UNTIL loopPrev = 1;
                                        END;
                                    END
                                    ELSE BEGIN
                                        IF altLoopPrev > 1 THEN BEGIN
                                            REPEAT
                                                altLoopPrev := altLoopPrev - 1;
                                                LotItemAvail.RESET;
                                                LotItemAvail.SETCURRENTKEY(LotItemAvail."Item No", LotItemAvail."LOT No", LotItemAvail.Location);
                                                LotItemAvail.SETRANGE(LotItemAvail."Item No", altPrevLot[altLoopPrev, 1]);
                                                LotItemAvail.SETRANGE(LotItemAvail."LOT No", altPrevLot[altLoopPrev, 2]);
                                                LotItemAvail.SETRANGE(LotItemAvail.Location, Location);
                                                IF LotItemAvail.FINDSET THEN
                                                    REPEAT
                                                        EVALUATE(qty, altPrevLot[altLoopPrev, 3]);
                                                        LotItemAvail."Allocated Qty" := LotItemAvail."Allocated Qty" - qty;
                                                        LotItemAvail.MODIFY;
                                                    UNTIL LotItemAvail.NEXT = 0;
                                            UNTIL altLoopPrev = 1;
                                        END;
                                    END;

                                END  //MNRAJU
                                ELSE BEGIN
                                    IF DUM."Total Inventory" > 0 THEN BEGIN
                                        IF DUM."Total Inventory" >= Req_Qty THEN BEGIN
                                            DUM."Total Inventory" := DUM."Total Inventory" - Req_Qty;
                                            DUM.MODIFY;
                                            Change_Alternate_Item(Item1, DUM."No.", "Prod. Order");
                                            SHORTAGE := FALSE;
                                            EXIT(SHORTAGE);
                                        END ELSE BEGIN
                                            DUM."Total Inventory" := 0;
                                            DUM.MODIFY;
                                        END;
                                    END;
                                END;
                            END ELSE BEGIN // $Start--Shortage Calculation for Plannin Purpose
                                IF DUM."Total Inventory" > 0 THEN BEGIN
                                    IF DUM."Total Inventory" >= Req_Qty THEN BEGIN
                                        DUM."Total Inventory" := DUM."Total Inventory" - Req_Qty;
                                        DUM.MODIFY;
                                        SHORTAGE := FALSE;
                                        EXIT(SHORTAGE);
                                    END ELSE BEGIN
                                        IF DUM."Total Inventory" > 0 THEN BEGIN
                                            Req_Qty := Req_Qty - DUM."Total Inventory";
                                            DUM."Total Inventory" := 0;
                                            DUM.MODIFY;
                                        END;
                                    END;
                                END;
                            END;  // $Start--Shortage Calculation for Plannin Purpose
                        END;
                    UNTIL "Alternative Items".NEXT = 0;
                IF ForPlanning = TRUE THEN BEGIN
                    Required_Qty_Aftr_Alt := Req_Qty;
                END;
            END;
        END;
        EXIT(SHORTAGE);
    end;

    procedure VERIFY_WITH_PRDSTR_QTY(ITEM: Code[20]; REQUIRED_QTY: Decimal; PROD_ORDER: Code[20]) SHORTAGE: Boolean;
    begin
        //sundar

        IF NOT (DUM.GET(ITEM)) THEN
            Include_Item(ITEM, TRUE);

        IF DUM.GET(ITEM) THEN BEGIN
            IF DUM."Stock at Stores" >= (REQUIRED_QTY) THEN BEGIN
                DUM."Stock at Stores" := DUM."Stock at Stores" - (REQUIRED_QTY);
                DUM.MODIFY;
                SHORTAGE := FALSE;
            END ELSE BEGIN
                SHORTAGE := "Verify Alternate"(DUM."No.", REQUIRED_QTY, PROD_ORDER);
                IF SHORTAGE THEN BEGIN
                    IF DUM."Stock at Stores" > 0 THEN BEGIN
                        SHORTAGE_QTY := REQUIRED_QTY - DUM."Stock at Stores";
                        DUM."Stock at Stores" := 0;
                        DUM.MODIFY;
                    END ELSE
                        SHORTAGE_QTY := REQUIRED_QTY;
                END;
            END;

        END;
        EXIT(SHORTAGE);
    end;

    procedure SetCalcType(CalcTyp: Boolean);
    begin
        ForPlanning := CalcTyp;
    end;

    procedure Include_Purchase_Qty("Plan Date": Date);
    var
        "Purchase line": Record "Purchase Line";
    begin
        /* //previous code commenting by pranavi on 23-11-2015 for considering all purchase qty
        "Purchase line".RESET;
        "Purchase line".SETCURRENTKEY("Purchase line"."Deviated Receipt Date");
        "Purchase line".SETFILTER("Purchase line"."Qty. to Receive",'>%1',0);
        "Purchase line".SETRANGE("Purchase line"."Deviated Receipt Date","Plan Date"-4);
        "Purchase line".SETRANGE("Purchase line"."Location Code",'STR');
        "Purchase line".SETFILTER("Purchase line"."Document Type",'ORDER');
        IF Test_Item<>'' THEN
        "Purchase line".SETRANGE("Purchase line"."No.",Test_Item);
        IF "Purchase line".FIND('-') THEN
        REPEAT
         //IF("Purchase line"."No."='ECPCBDS00514') THEN
         //MESSAGE('"Saftey Items"."No."');
        
         //IF("Purchase line"."No."='ECPCBSS00599') THEN
         //MESSAGE('"Saftey Items"."No."');
        
        
          IF NOT Dum.GET("Purchase line"."No.") THEN
             Include_Item("Purchase line"."No.",FALSE);
          IF Dum.GET("Purchase line"."No.") THEN
          BEGIN
            Dum."Maximum Inventory"+="Purchase line"."Qty. to Receive";
            Dum."Stock at Stores"+="Purchase line"."Qty. to Receive";
            Dum.MODIFY;
          END;
        UNTIL "Purchase line".NEXT=0;
        */ //previous code commenting by pranavi on 23-11-2015 for considering all purchase qty
        //New code added by pranavi on 23-11-2015 for considering all purchase qty
        "Purchase line".RESET;
        "Purchase line".SETCURRENTKEY("Purchase line"."Deviated Receipt Date");
        //IF USERID = 'EFFTRONICS\PRANAVI' THEN
        //  "Purchase line".SETFILTER("Purchase line"."No.",'%1','ECRESSD00036');
        "Purchase line".SETFILTER("Purchase line"."Qty. to Receive", '>%1', 0);
        //"Purchase line".SETRANGE("Purchase line"."Deviated Receipt Date","Plan Date"-4);  //commented by pranavi
        "Purchase line".SETFILTER("Purchase line"."Deviated Receipt Date", '>=%1', WORKDATE);  //added by pranavi
        "Purchase line".SETRANGE("Purchase line"."Location Code", 'STR'); // Need to Added Locations (Vishnu)
        "Purchase line".SETFILTER("Purchase line"."Document Type", 'ORDER');
        IF Test_Item <> '' THEN
            "Purchase line".SETRANGE("Purchase line"."No.", Test_Item);
        IF "Purchase line".FIND('-') THEN
            REPEAT
                //IF("Purchase line"."No."='ECPCBDS00514') THEN
                //MESSAGE('"Saftey Items"."No."');

                //IF("Purchase line"."No."='ECPCBSS00599') THEN
                //MESSAGE('"Saftey Items"."No."');


                IF NOT DUM.GET("Purchase line"."No.") THEN
                    Include_Item("Purchase line"."No.", FALSE);
                IF DUM.GET("Purchase line"."No.") THEN BEGIN
                    DUM."Maximum Inventory" += "Purchase line"."Qty. to Receive"; // Need to Added Locations (Vishnu)
                    DUM."Stock at Stores" += "Purchase line"."Qty. to Receive"; // Need to Added Locations (Vishnu)
                    DUM.MODIFY;
                END;
            UNTIL "Purchase line".NEXT = 0;
        //New code added by pranavi on 23-11-2015 for considering all purchase qty

    end;

    procedure Include_Qc_Qty();
    var
        QILE: Record "Quality Item Ledger Entry";
    begin
        // FILTERING THE QC PENDING INWARDS & UPDATE THOSE INFORMATION INTO VIRTUAL STOCK
        QILE.RESET;
        QILE.SETCURRENTKEY(QILE."Posting Date", QILE."Item No.");
        //QILE.SETFILTER(QILE."Item No.",'%1|%2|%3','ECICSDI00245','ECICSDI00545','ECICSDI00567');
        QILE.SETRANGE(QILE."Inspection Status", QILE."Inspection Status"::"Under Inspection");
        QILE.SETRANGE(QILE."Sent for Rework", FALSE);
        QILE.SETFILTER(QILE."Remaining Quantity", '>%1', 0);
        QILE.SETRANGE(QILE."Location Code", 'STR'); // Need to Added Locations (Vishnu)
        QILE.SETRANGE(QILE.Accept, TRUE);
        IF Test_Item <> '' THEN
            QILE.SETRANGE(QILE."Item No.", Test_Item);

        IF QILE.FIND('-') THEN
            REPEAT
                IF NOT DUM.GET(QILE."Item No.") THEN
                    Include_Item(QILE."Item No.", FALSE);

                IF DUM.GET(QILE."Item No.") THEN BEGIN
                    DUM."Maximum Inventory" += QILE."Remaining Quantity";
                    STOCK := DUM."Maximum Inventory";
                    DUM."Stock at Stores" += QILE."Remaining Quantity"; // Need to Added Locations (Vishnu)
                    DUM.MODIFY;
                END;
            UNTIL QILE.NEXT = 0;
    end;

    procedure MSLItemExpiryDate(ILE: Record "Item Ledger Entry"; ForPlan: Boolean) Expired: Boolean;
    var
        MSL_ILE: Record "Item Ledger Entry";
        Itm: Record Item;
        IsExpired: Boolean;
        //B2BUpg>>
        /*
        DateAndTime: DotNet "'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.DateAndTime";
        DayofWeekInput: DotNet "'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.FirstDayOfWeek";
        WeekofYearInput: DotNet "'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.FirstWeekOfYear";*///B2BUpg<<
        Itm_floor_life: Decimal;

    begin
        IsExpired := FALSE;
        Itm_floor_life := 0;
        IF Itm.GET(ILE."Item No.") THEN BEGIN
            //IF (Itm.MSL <> 0) THEN// Commented by sujani
            IF ((Itm.MSL <> 0) AND NOT (Itm."No." IN ['ECICSDI00631', 'ECICSAN00091', 'ECREGPV00029', 'ECICSDI00438', 'ECDIOPN00241', 'ECICSAN00122', 'ECICSAN00095',
              'ELWLS00035', 'ECTRNPN00003', 'ECICSAN00005', 'ECICSDI00067', 'ECVARAX00057', 'ECDIOPN00241', 'ECICSDI00438', 'ECICSDI00706'])) THEN  //added by sujani by the anil sir approval
            BEGIN
                MSL_ILE.RESET;
                MSL_ILE.SETCURRENTKEY("Item No.", "Entry Type");
                MSL_ILE.SETRANGE("Item No.", ILE."Item No.");
                MSL_ILE.SETRANGE("Entry Type", MSL_ILE."Entry Type"::Purchase);
                MSL_ILE.SETRANGE("Document Type", MSL_ILE."Document Type"::"Purchase Receipt");
                MSL_ILE.SETRANGE("Lot No.", ILE."Lot No.");
                IF MSL_ILE.FINDFIRST THEN BEGIN
                    IF (MSL_ILE."MFD Date" <> 0D) AND (Itm."Component Shelf Life(Years)" > 0) THEN BEGIN
                        IF CALCDATE(FORMAT(ITEM."Component Shelf Life(Years)") + 'Y', MSL_ILE."MFD Date") < TODAY THEN
                            IsExpired := TRUE;
                    END;
                    IF NOT ForPlan THEN BEGIN
                        IF IsExpired = FALSE THEN BEGIN
                            IF NOT (Itm."Floor Life at 25 C 40% RH" IN ['', ' ', 'INFINITE']) THEN BEGIN
                                EVALUATE(Itm_floor_life, Itm."Floor Life at 25 C 40% RH");
                                IF (MSL_ILE."Floor Life" >= Itm_floor_life) AND (Itm_floor_life > 0) THEN
                                    IsExpired := TRUE;
                                IF IsExpired = FALSE THEN
                                    IF MSL_ILE."Recharge Cycles" >= 2 THEN
                                        IsExpired := TRUE;
                            END;
                        END;
                    END;
                END;
            END;
        END;
        EXIT(IsExpired);
    end;
}

