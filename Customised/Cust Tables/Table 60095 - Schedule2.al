table 60095 Schedule2
{
    // No. sign   Description
    // ---------------------------------------------------
    // 1.3 UPG    BOM Replacement process changes Function SetSkipOrderVerification and
    //            testOrderVerification code added.

    DrillDownPageID = "Schedule List";
    LookupPageID = "Schedule List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(2; "Document Line No."; Integer)
        {
            Editable = true;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*
                TenderLine.RESET;
                TenderLine.SETRANGE("Document No.","Document No.");
                TenderLine.SETRANGE("Line No.","Document Line No.");
                IF TenderLine.FIND('-') THEN BEGIN
                  VALIDATE("No.",TenderLine."No.");
                  Quantity := TenderLine.Quantity;
                  TenderLine.CALCFIELDS("Estimated Unit Cost");
                  "Estimated Total Unit Cost" := TenderLine."Estimated Total Unit Cost";
                
                END ELSE BEGIN
                  SalesLine.RESET;
                  SalesLine.SETRANGE("Document Type","Document Type");
                  SalesLine.SETRANGE("Document No.","Document No.");
                  SalesLine.SETRANGE("Line No.","Document Line No.");
                  IF SalesLine.FIND('-') THEN BEGIN
                   VALIDATE("No.",SalesLine."No.");
                    Quantity := SalesLine.Quantity;
                  END
                END
                */

            end;
        }
        field(3; "Line No."; Integer)
        {
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(4; Type; Enum "Sales Line Type")
        {
           
            DataClassification = CustomerContent;
        }
        field(5; "No."; Code[30])
        {
            TableRelation = IF (Type = CONST(Item)) Item."No."
            ELSE
            IF (Type = CONST("G/l Account")) "G/L Account"."No.";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Document Line No." <> "Line No." then begin
                    //ADDED BY VIJAYA ON 16-jUN-16
                    SalesHeader.Reset;
                    SalesHeader.SetRange(SalesHeader."Document Type", SalesHeader."Document Type"::Order);
                    SalesHeader.SetRange(SalesHeader."No.", "Document No.");
                    if SalesHeader.FindFirst then begin
                        if SalesHeader."Order Verified" = true then
                            if not SkipOrderVerification then//UPG1.3 19Feb2019
                                Error('Schedule item cannot be Change the Item when sale order is verified');
                    end;
                    //END BY VIJAYA
                end;


                if Item.Get(TenderLine."No.") then begin
                    Description := TenderLine.Description;
                    "Unit Cost" := TenderLine."Unit Cost"
                end else
                    if Item.Get("No.") then begin
                        //   Description := Item.Description; // commented by sujani in order to not to reset sales people updated item details
                        if Description = '' then
                            Description := Item.Description; //added by vishnu priya on 02-07-2019
                                                             //  "Unit Cost" := Item."Avg Unit Cost"; // commented by sujani in order to not to reset sales people updated item details
                        "Posting Group" := Item."Inventory Posting Group";    //Added by Pranavi on 10-Dec-2015 for updating Posting Group
                        Item.TestField(Blocked, false);
                        if Item."Item Status" = Item."Item Status"::"In-Active" then   //added by pranavi on 03-06-2015 not to allow in-active items in sales lines
                            Error('Item is IN-Activated! You cannot select this Item!');

                    end;
                //B2B SH1.0
                ItemDesignWorksheet.Reset;
                if ItemDesignWorksheet.Get("No.") and (Item."Replenishment System" = Item."Replenishment System"::"Prod. Order") then
                    "Estimated Total Unit Cost" := ItemDesignWorksheet."Total Cost"
                else
                    if Item."Replenishment System" = Item."Replenishment System"::Purchase then
                        "Estimated Total Unit Cost" := Item."Avg Unit Cost";

                if Type = Type::"G/l Account" then begin
                    "G/LAccount".Get("No.");
                    Description := "G/LAccount".Name;
                end;

                if "No." <> xRec."No." then begin
                    "Estimated Unit Price" := 0;
                    "Calcaulated Amont" := 0;
                end;
                //B2B SH1.0
            end;
        }
        field(6; Description; Text[250])
        {
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(7; Quantity; Decimal)
        {
            BlankZero = true;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                //ADDED BY VIJAYA ON 16-jUN-16
                SalesHeader.Reset;
                SalesHeader.SetRange(SalesHeader."Document Type", SalesHeader."Document Type"::Order);
                SalesHeader.SetRange(SalesHeader."No.", "Document No.");
                if "Document Line No." <> "Line No." then begin

                    if SalesHeader.FindFirst then begin
                        if SalesHeader."Order Verified" = true then
                            Error('Schedule item cannot be Change the Quantity when sale order is verified');
                    end;
                end;
                //END BY VIJAYA

                //TESTFIELD("Qty. Shipped",0);
                "Estimated Total Unit Price" := "Estimated Unit Price" * Quantity;
                "Outstanding Qty." := Quantity - "Qty. Shipped";  // $Pranavi
                //"Outstanding Qty.(Base)" := "Outstanding Qty.";   //$Pranavi
                "Outstanding Qty.(Base)" := "Quantity(Base)" - "Qty.Shipped (Base)";
                //B2BSP
                //"Outstanding Qty." := Quantity;
                //"Outstanding Qty.(Base)" := Quantity;
                //"Quantity(Base)" := Quantity;
                IUOM.Reset;
                IUOM.SetRange(IUOM."Item No.", "No.");
                IUOM.SetRange(IUOM.Code, "Unit of Measure Code");
                if IUOM.FindFirst then
                    "Quantity(Base)" := Quantity * IUOM."Qty. per Unit of Measure"
                else
                    "Quantity(Base)" := Quantity;
                Amount := Quantity * "Unit Cost";
                //B2BSP
            end;
        }
        field(8; "RDSO Required"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Insp. Letter Sent"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(10; Date; Date)
        {
            DataClassification = CustomerContent;
        }
        field(11; Priority; Option)
        {
            OptionMembers = " ","1","2","3","4","5";
            DataClassification = CustomerContent;
        }
        field(12; "Document Type"; Enum ScheduleTypeEnum)
        {
            Editable = true;
          
            DataClassification = CustomerContent;
        }
        field(13; Remarks; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(14; "Tender Schedule"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(15; "Sales Description"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(16; "Design Conclusions1"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(17; Dispatched; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(18; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,Release;
            DataClassification = CustomerContent;
        }
        field(19; "Reserved Qty. (Base)"; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry"."Quantity (Base)" WHERE("Source ID" = FIELD("Document No."),
                                                                            "Source Ref. No." = FIELD("Line No."),
                                                                            "Source Type" = CONST(37),
                                                                            "Source Subtype" = FIELD("Document Type"),
                                                                            "Reservation Status" = CONST(Reservation)));
            FieldClass = FlowField;
        }
        field(100; SetSelection; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(101; "M/S Item"; Code[40])
        {
            DataClassification = CustomerContent;
        }
        field(102; "Source Document Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(103; "Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(104; "Estimated Total Unit Cost"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(105; "Estimated Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*IF "Estimated Total Unit Price"<"Estimated Total Unit Cost" THEN
                ERROR('Estimated Total Unit Price less then the Estimated Total Unit Cost');*/
                "Calcaulated Amont" := "Estimated Total Unit Price" + ("Estimated Total Unit Price" * Percentage / 100);
                "Estimated Total Unit Price" := "Estimated Unit Price" * Quantity;

            end;
        }
        field(106; Percentage; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Estimated Total Unit Price" < 1 then
                    FieldError("Estimated Total Unit Price");
                Validate("Estimated Total Unit Price");
            end;
        }
        field(107; "Calcaulated Amont"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                //  "Calcaulated Amont" := ("Estimated Unit Price" +("Estimated Total Unit Price" * Percentage/100))*Quantity ;
            end;
        }
        field(108; "RPO Completion Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(109; "Packet No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(110; "Estimated Total Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Calcaulated Amont" := ("Estimated Unit Price" + ("Estimated Unit Price" * Percentage / 100)) * Quantity;
                //"Calcaulated Amont" := ("Estimated Unit Price" +("Estimated Total Unit Price" * Percentage/100))*Quantity ;
            end;
        }
        field(111; "Serial No"; Text[250])
        {
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(112; "Batch No"; Text[250])
        {
            Caption = 'Lot No.';
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(150; "Purchase Expected Receipt Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(151; "Serial No."; Code[250])
        {
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                ItemLedgerEntry: Record "Item Ledger Entry";
            begin
                ItemLedgerEntry.Reset;
                ItemLedgerEntry.SetCurrentKey(ItemLedgerEntry."Item No.",
                                              ItemLedgerEntry."Location Code",
                                              ItemLedgerEntry."Global Dimension 1 Code",
                                              ItemLedgerEntry."Global Dimension 2 Code",
                                              ItemLedgerEntry.Open,
                                              ItemLedgerEntry."Remaining Quantity");


                ItemLedgerEntry.SetRange(ItemLedgerEntry."Item No.", "No.");
                ItemLedgerEntry.SetRange(ItemLedgerEntry."Location Code", 'Prod');
                ItemLedgerEntry.SetFilter(ItemLedgerEntry."Remaining Quantity", '<>%1', 0);
                ItemLedgerEntry.SetFilter(ItemLedgerEntry."Entry Type", '%1|%2',
                                          ItemLedgerEntry."Entry Type"::Transfer,
                                          ItemLedgerEntry."Entry Type"::Output);
                if PAGE.RunModal(0, ItemLedgerEntry) = ACTION::LookupOK then begin
                    if "Serial No." = '' then
                        "Serial No." := ItemLedgerEntry."Serial No."
                    else
                        "Serial No." := xRec."Serial No." + ',' + ItemLedgerEntry."Serial No.";
                    if "Lot No." = '' then
                        "Lot No." := ItemLedgerEntry."Lot No."
                    else
                        "Lot No." := xRec."Lot No." + ',' + ItemLedgerEntry."Lot No.";

                end;
            end;
        }
        field(152; "Lot No."; Code[250])
        {
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                ItemLedgerEntry: Record "Item Ledger Entry";
            begin
                ItemLedgerEntry.Reset;
                ItemLedgerEntry.SetCurrentKey("Entry Type", "Item No.", "Location Code", Open, "Lot No.", "Serial No.", "Global Dimension 2 Code");
                ItemLedgerEntry.SetRange(ItemLedgerEntry."Item No.", "No.");
                ItemLedgerEntry.SetRange(ItemLedgerEntry."Location Code", 'Prod');
                ItemLedgerEntry.SetFilter(ItemLedgerEntry."Remaining Quantity", '<>%1', 0);
                if PAGE.RunModal(0, ItemLedgerEntry) = ACTION::LookupOK then begin
                    if "Serial No." = '' then
                        "Serial No." := ItemLedgerEntry."Serial No."
                    else
                        "Serial No." := xRec."Serial No." + ',' + ItemLedgerEntry."Serial No.";
                    if "Lot No." = '' then
                        "Lot No." := ItemLedgerEntry."Lot No."
                    else
                        "Lot No." := xRec."Lot No." + ',' + ItemLedgerEntry."Lot No.";

                end;
            end;
        }
        field(153; "To be Shipped Qty"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(154; "Material Required Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(155; "Plan Shifting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(156; "Change To Specified Plan Date"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(157; "Design Conclusion2"; Text[200])
        {
            DataClassification = CustomerContent;
        }
        field(158; "Posting Group"; Code[10])
        {
            Description = 'Pranavi';
            DataClassification = CustomerContent;
        }
        field(159; "Prod. Order Quantity"; Decimal)
        {
            CalcFormula = Sum("Production Order".Quantity WHERE("Sales Order No." = FIELD("Document No."),
                                                                 "Sales Order Line No." = FIELD("Document Line No."),
                                                                 "Schedule Line No." = FIELD("Line No."),
                                                                 "Source No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50000; "Qty. Per"; Decimal)
        {
            DecimalPlaces = 4 : 4;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Clear("Qty. to Ship");
                Clear("Qty. to ship (Base)");
                if "Document Line No." <> "Line No." then begin
                    //ADDED BY VIJAYA ON 16-jUN-16
                    SalesHeader.Reset;
                    SalesHeader.SetRange(SalesHeader."Document Type", SalesHeader."Document Type"::Order);
                    SalesHeader.SetRange(SalesHeader."No.", "Document No.");
                    if SalesHeader.FindFirst then begin
                        if SalesHeader."Order Verified" = true then
                            Error('Schedule item cannot be Change the Item when sale order is verified');
                    end;
                    //END BY VIJAYA
                end;
            end;
        }
        field(50001; "Qty. to Ship"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                //
                if "Qty. to Ship" > "Outstanding Qty." then
                    Error(Text50000);

                //B2BSP
                if "Qty. Per" = 0 then
                    Error('Qty. Per Must have a value in shed line no.:' + Format("Line No.") + ' of sales line: ' + Format("Document Line No."));

                IUOM.Reset;
                IUOM.SetRange(IUOM."Item No.", "No.");
                IUOM.SetRange(IUOM.Code, "Unit of Measure Code");
                if IUOM.FindFirst then
                    "Qty. to ship (Base)" := "Qty. to Ship" * IUOM."Qty. per Unit of Measure"
                else
                    "Qty. to ship (Base)" := "Qty. to Ship";
                //B2BSP
            end;
        }
        field(50002; "Qty. Shipped"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50003; "Outstanding Qty."; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50004; "Qty. to ship (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50005; "Qty.Shipped (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50006; "Outstanding Qty.(Base)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50007; "Quantity(Base)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50008; "Location Code"; Code[20])
        {
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
            DataClassification = CustomerContent;
        }
        field(50009; "Qty. per Unit of Measure"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50010; Amount; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50011; "Prod. Qty"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin

                CalcFields("Prod. Order Quantity");
                if "Prod. Order Quantity" + "Prod. Qty" > Quantity then
                    Error(text112);
            end;
        }
        field(50012; "Prod. Due Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50013; "Reserved Quantity"; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry".Quantity WHERE("Source ID" = FIELD("Document No."),
                                                                   "Source Ref. No." = FIELD("Line No."),
                                                                   "Source Type" = CONST(37),
                                                                   "Source Subtype" = FIELD("Document Type"),
                                                                   "Reservation Status" = CONST(Reservation)));
            CaptionML = ENU = 'Reserved Quantity',
                        ENN = 'Reserved Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50014; "Variant Code"; Code[10])
        {
            CaptionML = ENU = 'Variant Code',
                        ENN = 'Variant Code';
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("No."));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*
                TestJobPlanningLine;
                IF "Variant Code" <> '' THEN
                  TESTFIELD(Type,Type::Item);
                TestStatusOpen;
                CheckAssocPurchOrder(FIELDCAPTION("Variant Code"));
                
                IF xRec."Variant Code" <> "Variant Code" THEN BEGIN
                  TESTFIELD("Qty. Shipped Not Invoiced",0);
                  TESTFIELD("Shipment No.",'');
                
                  TESTFIELD("Return Qty. Rcd. Not Invd.",0);
                  TESTFIELD("Return Receipt No.",'');
                  InitItemAppl(FALSE);
                END;
                
                CheckItemAvailable(FIELDNO("Variant Code"));
                
                IF Type = Type::Item THEN BEGIN
                  GetUnitCost;
                  UpdateUnitPrice(FIELDNO("Variant Code"));
                END;
                
                GetDefaultBin;
                InitQtyToAsm;
                AutoAsmToOrder;
                IF (xRec."Variant Code" <> "Variant Code") AND (Quantity <> 0) THEN BEGIN
                  IF NOT FullReservedQtyIsForAsmToOrder THEN
                    ReserveSalesLine.VerifyChange(Rec,xRec);
                  WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
                END;
                
                GetItemCrossRef(FIELDNO("Variant Code"));
                */

            end;
        }
        field(50015; "Bin Code"; Code[20])
        {
            CaptionML = ENU = 'Bin Code',
                        ENN = 'Bin Code';
            TableRelation = IF ("Document Type" = FILTER(Order),
                                Quantity = FILTER(>= 0)) "Bin Content"."Bin Code" WHERE("Location Code" = FIELD("Location Code"),
                                                                                      "Item No." = FIELD("No."),
                                                                                      "Variant Code" = FIELD("Variant Code"))
            ELSE
            Bin.Code WHERE("Location Code" = FIELD("Location Code"));
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                WMSManagement: Codeunit "WMS Management";
                BinCode: Code[20];
            begin
                /*
                IF NOT IsInbound AND ("Quantity (Base)" <> 0) THEN
                  BinCode := WMSManagement.BinContentLookUp("Location Code","No.","Variant Code",'',"Bin Code")
                ELSE
                  BinCode := WMSManagement.BinLookUp("Location Code","No.","Variant Code",'');
                
                IF BinCode <> '' THEN
                  VALIDATE("Bin Code",BinCode);
                */

            end;

            trigger OnValidate();
            var
                WMSManagement: Codeunit "WMS Management";
            begin
                /*
                IF "Bin Code" <> '' THEN BEGIN
                  IF NOT IsInbound AND ("Quantity (Base)" <> 0) AND ("Qty. to Asm. to Order (Base)" = 0) THEN
                    WMSManagement.FindBinContent("Location Code","Bin Code","No.","Variant Code",'')
                  ELSE
                    WMSManagement.FindBin("Location Code","Bin Code",'');
                END;
                
                IF "Drop Shipment" THEN
                  CheckAssocPurchOrder(FIELDCAPTION("Bin Code"));
                
                TESTFIELD(Type,Type::Item);
                TESTFIELD("Location Code");
                
                IF (Type = Type::Item) AND ("Bin Code" <> '') THEN BEGIN
                  TESTFIELD("Drop Shipment",FALSE);
                  GetLocation("Location Code");
                  Location.TESTFIELD("Bin Mandatory");
                  CheckWarehouse;
                END;
                ATOLink.UpdateAsmBinCodeFromSalesLine(Rec);
                */

            end;
        }
        field(50016; "Unit of Measure Code"; Code[10])
        {
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Qty. Shipped", 0);

                IUOM.Reset;
                IUOM.SetRange(IUOM."Item No.", "No.");
                IUOM.SetRange(IUOM.Code, "Unit of Measure Code");
                if IUOM.FindFirst then
                    "Quantity(Base)" := Quantity * IUOM."Qty. per Unit of Measure"
                else
                    "Quantity(Base)" := Quantity;
            end;
        }
        field(50017; "Planned Dispatch Date"; Date)
        {
            Description = 'Pranavi-for BOI Planning';
            DataClassification = CustomerContent;
        }
        field(50018; "Purchase Remarks"; Option)
        {
            OptionCaption = '" ,Sales Configuration Pending,Purchase order placed Mat Exp,Call letters Pending,Purchase Prices under negotiations,Material Received,Material Supplied-Invoice Pending,PO will place before Mfg items Ready"';
            OptionMembers = " ","Sales Conformation Pending","Purchase order placed Mat Exp","Call letters Pending","Purchase Prices under negotiations","Material Received","Material Supplied-Invoice Pending","PO will place before Mfg items Ready";
            DataClassification = CustomerContent;
        }
        field(50019; "LOA Schedule No"; Text[60])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Document Line No.", "Line No.")
        {
        }
        key(Key2; "M/S Item")
        {
        }
        key(Key3; "Material Required Date", "No.")
        {
            SumIndexFields = "To be Shipped Qty";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    var
        PrdOrder: Record "Production Order";
        rpoQty: Integer;
    begin
        /*
        rpoQty:=0;
        PrdOrder.RESET;
        PrdOrder.SETFILTER(PrdOrder."Sales Order No.","Document No.");
        PrdOrder.SETFILTER(PrdOrder."Sales Order Line No.",'%1',"Document Line No.");
        PrdOrder.SETFILTER(PrdOrder."Schedule Line No.",'%1',"Line No.");
        IF PrdOrder.FINDSET THEN
        REPEAT
          rpoQty:=rpoQty+PrdOrder.Quantity;
        UNTIL PrdOrder.NEXT=0;
        
        IF rpoQty>0 THEN
          ERROR('Already '+FORMAT(rpoQty)+' Production Orders was released on this Product. Please contact Production manager for further actions');
        */



        /*
        // Added by Rakesh on 5-Jul-14 to block deleting the schedule if the saleorder is released
        SalesHeader.RESET;
        SalesHeader.SETRANGE(SalesHeader."Document Type",SalesHeader."Document Type"::Order);
        SalesHeader.SETRANGE(SalesHeader."No.","Document No.");
        IF SalesHeader.FINDFIRST THEN
        BEGIN
          IF SalesHeader.Status = 1 THEN
            ERROR('Schedule item cannot be deleted when sale order is released');
        END;
        // end by rakesh
        */
        //ADDED BY VIJAYA ON 16-jUN-16
        if SalesHeader.FindFirst then begin
            if SalesHeader."Order Verified" = true then
                Error('Schedule item cannot be inserted when sale order is verified');
        end;
        //END BY VIJAYA

    end;

    trigger OnInsert();
    begin
        // Added by Rakesh on 5-Jul-14 to block inserting the schedule if the saleorder is released
        SalesHeader.Reset;
        SalesHeader.SetRange(SalesHeader."No.", "Document No.");
        SalesHeader.SetRange(SalesHeader."Document Type", SalesHeader."Document Type"::Order);
        if SalesHeader.FindFirst then begin
            if SalesHeader.Status = 1 then
                Error('Schedule item cannot be inserted when sale order is released');
        end;
        // end by rakesh
        //ADDED BY VIJAYA ON 16-jUN-16
        if "Document Line No." <> "Line No." then begin

            if SalesHeader.FindFirst then begin
                if SalesHeader."Order Verified" = true then
                    Error('Schedule item cannot be inserted when sale order is verified');
            end;
        end;
        //END BY VIJAYA

        // $Pranavi
        SalesLine.Reset;
        SalesLine.SetRange(SalesLine."Document No.", "Document No.");
        SalesLine.SetRange(SalesLine."Line No.", "Document Line No.");
        if SalesLine.FindFirst then
            "Location Code" := SalesLine."Location Code";
        // $Pranavi End
    end;

    trigger OnModify();
    var
        PrdOrder: Record "Production Order";
        rpoQty: Integer;
    begin
        /*
        rpoQty:=0;
        PrdOrder.RESET;
        PrdOrder.SETFILTER(PrdOrder."Sales Order No.","Document No.");
        PrdOrder.SETFILTER(PrdOrder."Sales Order Line No.",'%1',"Document Line No.");
        PrdOrder.SETFILTER(PrdOrder."Schedule Line No.",'%1',"Line No.");
        IF PrdOrder.FINDSET THEN
        REPEAT
          rpoQty:=rpoQty+PrdOrder.Quantity;
        UNTIL PrdOrder.NEXT=0;
        
        IF rpoQty>0 THEN
        BEGIN
          IF xRec."No."<>"No." THEN
            ERROR('Already Production Orders was released for the item '+xRec."No."+'. Please contact Production Manager for further actions');
        
          IF rpoQty>Quantity THEN
            ERROR('Already Production Orders was released for the quantity  '+FORMAT(rpoQty)+' on this Product. Please contact Production Manager for further actions');
        END;
        */
        "Outstanding Qty." := Quantity - "Qty. Shipped";  // $Pranavi
        //"Outstanding Qty.(Base)" := "Outstanding Qty.";   // $Pranavi
        "Outstanding Qty.(Base)" := "Quantity(Base)" - "Qty.Shipped (Base)";

    end;

    var
        Item: Record Item;
        StdTxt: Record "Standard Text";
        TenderLine: Record "Tender Line";
        SalesLine: Record "Sales Line";
        ItemDesignWorksheet: Record "Item Design Worksheet Header";
        "G/LAccount": Record "G/L Account";
        SalesHeader: Record "Sales Header";
        Text50000: Label 'Qty. to Ship must be less than Outstanding Quantity';
        text112: Label 'You can''t create more porduction order''s than Qty';
        IUOM: Record "Item Unit of Measure";
        SkipOrderVerification: Boolean;


    procedure CopySchedule(var Rec: Record Schedule2);
    var
        Schedule: Record Schedule2;
        ScheduleInsert: Record Schedule2;
        ScheduleInsert1: Record Schedule2;
        "LineNo.": Integer;
    begin
        if PAGE.RunModal(0, Schedule) = ACTION::LookupOK then begin
            Schedule.LockTable;
            Schedule.SetRange(SetSelection, true);
            if Schedule.Find('-') then
                repeat
                        ScheduleInsert."Document Type" := Rec."Document Type";
                    ScheduleInsert."Document No." := Rec."Document No.";
                    ScheduleInsert."Document Line No." := Rec."Document Line No.";
                    ScheduleInsert.SetRange("Document No.", Rec."Document No.");
                    if ScheduleInsert.Find('+') then
                        ScheduleInsert."Line No." := ScheduleInsert."Line No." + 10000
                    else
                        ScheduleInsert."Line No." := 10000;
                    ScheduleInsert.Type := Schedule.Type;
                    ScheduleInsert."No." := Schedule."No.";
                    ScheduleInsert.Description := Schedule.Description;
                    ScheduleInsert."Unit of Measure Code" := Schedule."Unit of Measure Code";
                    ScheduleInsert.Quantity := Schedule.Quantity;
                    ScheduleInsert.Validate(Quantity);
                    ScheduleInsert."RDSO Required" := Schedule."RDSO Required";
                    ScheduleInsert."Insp. Letter Sent" := Schedule."Insp. Letter Sent";
                    ScheduleInsert.Date := Schedule.Date;
                    ScheduleInsert.Priority := Schedule.Priority;
                    ScheduleInsert.Remarks := Schedule.Remarks;
                    ScheduleInsert."Tender Schedule" := Schedule."Tender Schedule";
                    ScheduleInsert."Sales Description" := Schedule."Sales Description";
                    ScheduleInsert."Design Conclusions1" := Schedule."Design Conclusions1";
                    ScheduleInsert.Dispatched := Schedule.Dispatched;
                    ScheduleInsert.Insert;
                until Schedule.Next = 0;
            Schedule.SetRange(SetSelection, true);
            Schedule.ModifyAll(SetSelection, false);
        end;
    end;


    procedure "--B2BSP--"();
    begin
    end;


    procedure InitTrackingSpecification(var ScheduleComp: Record Schedule2; var TrackingSpecification: Record "Tracking Specification");
    begin
        TrackingSpecification.Init;
        TrackingSpecification."Source Type" := DATABASE::Schedule2;
        TrackingSpecification."Item No." := ScheduleComp."No.";
        TrackingSpecification."Location Code" := ScheduleComp."Location Code";
        TrackingSpecification.Description := ScheduleComp.Description;
        //TrackingSpecification."Variant Code" := "Variant Code";
        TrackingSpecification."Source Subtype" := ScheduleComp.Type;
        TrackingSpecification."Source ID" := ScheduleComp."Document No.";
        TrackingSpecification."Source Batch Name" := '';
        TrackingSpecification."Source Prod. Order Line" := ScheduleComp."Document Line No.";
        TrackingSpecification."Source Ref. No." := ScheduleComp."Line No.";
        TrackingSpecification."Quantity (Base)" := ScheduleComp."Quantity(Base)";
    end;


    procedure CallTracking(var Schedule: Record "Posted Material Issues Header");
    var
        TrackingSpecification: Record "Tracking Specification";
        ItemTrackingForm: Page "Item Tracking Lines";
    begin
        InitTrackingSpecification(Rec, TrackingSpecification);
        ItemTrackingForm.SetSourceSpec(TrackingSpecification, 0D);//ItemTrackingForm.SetSource(TrackingSpecification, 0D)//EFFUPG
        ItemTrackingForm.SetInbound(true);
        ItemTrackingForm.RunModal;
    end;


    procedure IsInbound(): Boolean;
    begin
        case "Document Type" of
            "Document Type"::Order:
                exit("Quantity(Base)" < 0);
        end;

        exit(false);
    end;


    procedure RowID1(): Text[250];
    var
        ItemTrackingMgt: Codeunit "Item Tracking Management";
    begin
        exit(ItemTrackingMgt.ComposeRowID(DATABASE::Schedule2, "Document Type",
            "Document No.", '', "Document Line No.", "Line No."));
    end;


    procedure SetSkipOrderVerification();
    begin
        //UPG1.3 19Feb2019 //New function
        SkipOrderVerification := true;
    end;
}

