table 33000279 "Prod. Order Inspect Component"
{
    // version WIP1.0

    Caption = 'Prod. Order Inspect Component';
    DataCaptionFields = Status, "Prod. Order No.";
    DrillDownPageID = "Prod. Order Comp. Line List";
    LookupPageID = "Prod. Order Comp. Line List";
    PasteIsValid = false;
    DataClassification = CustomerContent;

    fields
    {
        field(1; Status; Enum "Production Order Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(2; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            TableRelation = "Production Order"."No." WHERE(Status = FIELD(Status));
            DataClassification = CustomerContent;
        }
        field(3; "Prod. Order Line No."; Integer)
        {
            Caption = 'Prod. Order Line No.';
            TableRelation = "Prod. Order Line"."Line No." WHERE(Status = FIELD(Status),
                                                                 "Prod. Order No." = FIELD("Prod. Order No."));
            DataClassification = CustomerContent;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(11; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Item.Get("Item No.");
                Description := Item.Description;
                Item.TestField("Base Unit of Measure");
                Validate("Unit of Measure Code", Item."Base Unit of Measure");
            end;
        }
        field(12; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(13; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Item.Get("Item No.");
                GetGLSetup;

                "Unit Cost" := Item."Unit Cost";

                "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item, "Unit of Measure Code");
                "Quantity (Base)" := CalcBaseQty(Quantity);

                "Unit Cost" :=
                  Round(Item."Unit Cost" * "Qty. per Unit of Measure",
                    GLSetup."Unit-Amount Rounding Precision");

                "Indirect Cost %" := Round(Item."Indirect Cost %" * "Qty. per Unit of Measure", 0.00001);

                "Overhead Rate" :=
                  Round(Item."Overhead Rate" * "Qty. per Unit of Measure",
                   GLSetup."Unit-Amount Rounding Precision");

                "Direct Unit Cost" :=
                  Round(
                    ("Unit Cost" - "Overhead Rate") / (1 + "Indirect Cost %" / 100),
                    GLSetup."Unit-Amount Rounding Precision");
            end;
        }
        field(14; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(15; Position; Code[10])
        {
            Caption = 'Position';
            DataClassification = CustomerContent;
        }
        field(16; "Position 2"; Code[10])
        {
            Caption = 'Position 2';
            DataClassification = CustomerContent;
        }
        field(17; "Position 3"; Code[10])
        {
            Caption = 'Position 3';
            DataClassification = CustomerContent;
        }
        field(18; "Production Lead Time"; DateFormula)
        {
            Caption = 'Production Lead Time';
            DataClassification = CustomerContent;
        }
        field(19; "Routing Link Code"; Code[10])
        {
            Caption = 'Routing Link Code';
            TableRelation = "Routing Link";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                ProdOrderLine: Record "Prod. Order Line";
                ProdOrderRtngLine: Record "Prod. Order Routing Line";
            begin
            end;
        }
        field(20; "Scrap %"; Decimal)
        {
            Caption = 'Scrap %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Validate("Calculation Formula");
            end;
        }
        field(21; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
            DataClassification = CustomerContent;
        }
        field(25; "Expected Quantity"; Decimal)
        {
            Caption = 'Expected Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                //QC
                if "Expected Quantity" <= "Remaining Quantity" + "Quantity Consumed" then
                    Error('Expected Quantity should not be more than Remaining Quantity');
                //QC
            end;
        }
        field(26; "Remaining Quantity"; Decimal)
        {
            Caption = 'Remaining Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(27; "Act. Consumption (Qty)"; Decimal)
        {
            CalcFormula = - Sum("Item Ledger Entry".Quantity WHERE("Entry Type" = CONST(Consumption),
                                                                   "Order No." = FIELD("Prod. Order No."),
                                                                   "Order Line No." = FIELD("Prod. Order Line No."),
                                                                   "Prod. Order Comp. Line No." = FIELD("Line No.")));
            Caption = 'Act. Consumption (Qty)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Flushing Method"; Option)
        {
            Caption = 'Flushing Method';
            OptionCaption = 'Manual,Forward,Backward,Pick + Forward,Pick + Backward';
            OptionMembers = Manual,Forward,Backward,"Pick + Forward","Pick + Backward";
            DataClassification = CustomerContent;
        }
        field(30; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
            DataClassification = CustomerContent;
        }
        field(31; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(32; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(33; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                WMSManagement: Codeunit "WMS Management";
                BinCode: Code[20];
            begin
            end;

            trigger OnValidate();
            var
                WMSManagement: Codeunit "WMS Management";
            begin
            end;
        }
        field(35; "Supplied-by Line No."; Integer)
        {
            Caption = 'Supplied-by Line No.';
            TableRelation = "Prod. Order Line"."Line No." WHERE(Status = FIELD(Status),
                                                                 "Prod. Order No." = FIELD("Prod. Order No."),
                                                                 "Line No." = FIELD("Supplied-by Line No."));
            DataClassification = CustomerContent;
        }
        field(36; "Planning Level Code"; Integer)
        {
            Caption = 'Planning Level Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(37; "Item Low-Level Code"; Integer)
        {
            Caption = 'Item Low-Level Code';
            DataClassification = CustomerContent;
        }
        field(40; Length; Decimal)
        {
            Caption = 'Length';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Validate("Calculation Formula");
            end;
        }
        field(41; Width; Decimal)
        {
            Caption = 'Width';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Validate("Calculation Formula");
            end;
        }
        field(42; Weight; Decimal)
        {
            Caption = 'Weight';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Validate("Calculation Formula");
            end;
        }
        field(43; Depth; Decimal)
        {
            Caption = 'Depth';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Validate("Calculation Formula");
            end;
        }
        field(44; "Calculation Formula"; Option)
        {
            Caption = 'Calculation Formula';
            OptionCaption = '" ,Length,Length * Width,Length * Width * Depth,Weight"';
            OptionMembers = " ",Length,"Length * Width","Length * Width * Depth",Weight;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                case "Calculation Formula" of
                    "Calculation Formula"::" ":
                        Quantity := "Quantity per";
                    "Calculation Formula"::Length:
                        Quantity := Round(Length * "Quantity per", 0.00001);
                    "Calculation Formula"::"Length * Width":
                        Quantity := Round(Length * Width * "Quantity per", 0.00001);
                    "Calculation Formula"::"Length * Width * Depth":
                        Quantity := Round(Length * Width * Depth * "Quantity per", 0.00001);
                    "Calculation Formula"::Weight:
                        Quantity := Round(Weight * "Quantity per", 0.00001);
                end;
                "Quantity (Base)" := Quantity * "Qty. per Unit of Measure";
            end;
        }
        field(45; "Quantity per"; Decimal)
        {
            Caption = 'Quantity per';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Item No.");
                Validate("Calculation Formula");
            end;
        }
        field(50; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DecimalPlaces = 2 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Item No.");

                Item.Get("Item No.");
                GetGLSetup;
                if Item."Costing Method" = Item."Costing Method"::Standard then
                    if CurrFieldNo = FieldNo("Unit Cost") then
                        Error(
                          Text99000003,
                          FieldCaption("Unit Cost"), Item.FieldCaption("Costing Method"), Item."Costing Method")
                    else begin
                        "Unit Cost" :=
                          Round(
                            Item."Unit Cost" * "Qty. per Unit of Measure",
                            GLSetup."Unit-Amount Rounding Precision");

                        "Indirect Cost %" := Round(Item."Indirect Cost %" * "Qty. per Unit of Measure", 0.00001);

                        "Overhead Rate" :=
                          Round(
                            Item."Overhead Rate" * "Qty. per Unit of Measure",
                            GLSetup."Unit-Amount Rounding Precision");

                        "Direct Unit Cost" :=
                          Round(
                            "Unit Cost" / (1 + "Indirect Cost %" / 100) - "Overhead Rate",
                            GLSetup."Unit-Amount Rounding Precision");
                    end;
                Validate("Calculation Formula");
            end;
        }
        field(51; "Cost Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(52; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                CheckDateConflict: Codeunit "Reservation-Check Date Confl.";
            begin
            end;
        }
        field(53; "Due Time"; Time)
        {
            Caption = 'Due Time';
            DataClassification = CustomerContent;
        }
        field(60; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(61; "Remaining Qty. (Base)"; Decimal)
        {
            Caption = 'Remaining Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(62; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(63; "Reserved Qty. (Base)"; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry"."Quantity (Base)" WHERE("Reservation Status" = CONST(Reservation),
                                                                            "Source Type" = CONST(5407),
                                                                            "Source Subtype" = FIELD(Status),
                                                                            "Source ID" = FIELD("Prod. Order No."),
                                                                            "Source Batch Name" = CONST(''),
                                                                            "Source Prod. Order Line" = FIELD("Prod. Order Line No."),
                                                                            "Source Ref. No." = FIELD("Line No.")));
            Caption = 'Reserved Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = true;
            FieldClass = FlowField;
        }
        field(71; "Reserved Quantity"; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry".Quantity WHERE("Reservation Status" = CONST(Reservation),
                                                                   "Source Type" = CONST(5407),
                                                                   "Source Subtype" = FIELD(Status),
                                                                   "Source ID" = FIELD("Prod. Order No."),
                                                                   "Source Batch Name" = CONST(''),
                                                                   "Source Prod. Order Line" = FIELD("Prod. Order Line No."),
                                                                   "Source Ref. No." = FIELD("Line No.")));
            Caption = 'Reserved Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(73; "Expected Qty. (Base)"; Decimal)
        {
            Caption = 'Expected Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Status <> Status::Simulated then begin
                    if Status in [Status::Released, Status::Finished] then
                        CalcFields("Act. Consumption (Qty)");
                    "Remaining Quantity" := "Expected Quantity" - "Act. Consumption (Qty)";
                    "Remaining Qty. (Base)" := Round("Remaining Quantity" * "Qty. per Unit of Measure", 0.00001);
                end;
                "Cost Amount" := Round("Expected Quantity" * "Unit Cost");
                "Overhead Amount" :=
                  Round(
                    "Expected Quantity" *
                    (("Direct Unit Cost" * "Indirect Cost %" / 100) + "Overhead Rate"));
                "Direct Cost Amount" := Round("Expected Quantity" * "Direct Unit Cost");
            end;
        }
        field(76; "Due Date-Time"; Decimal)
        {
            AutoFormatExpression = 'DATETIME';
            AutoFormatType = 10;
            Caption = 'Due Date-Time';
            DecimalPlaces = 2 :;
            DataClassification = CustomerContent;
        }
        field(5750; "Pick Qty."; Decimal)
        {
            CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding" WHERE("Activity Type" = FILTER(<> "Put-away"),
                                                                                  "Source Type" = CONST(5407),
                                                                                  "Source Subtype" = FIELD(Status),
                                                                                  "Source No." = FIELD("Prod. Order No."),
                                                                                  "Source Line No." = FIELD("Prod. Order Line No."),
                                                                                  "Source Subline No." = FIELD("Line No."),
                                                                                  "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                                                  "Action Type" = FILTER(" " | Place),
                                                                                  "Original Breakbulk" = CONST(false),
                                                                                  "Breakbulk No." = CONST(0)));
            Caption = 'Pick Qty.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(7300; "Qty. Picked"; Decimal)
        {
            Caption = 'Qty. Picked';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(7301; "Qty. Picked (Base)"; Decimal)
        {
            Caption = 'Qty. Picked (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(7302; "Completely Picked"; Boolean)
        {
            Caption = 'Completely Picked';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(7303; "Pick Qty. (Base)"; Decimal)
        {
            CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding (Base)" WHERE("Activity Type" = FILTER(<> "Put-away"),
                                                                                         "Source Type" = CONST(5407),
                                                                                         "Source Subtype" = FIELD(Status),
                                                                                         "Source No." = FIELD("Prod. Order No."),
                                                                                         "Source Line No." = FIELD("Prod. Order Line No."),
                                                                                         "Source Subline No." = FIELD("Line No."),
                                                                                         "Action Type" = FILTER(" " | Place),
                                                                                         "Original Breakbulk" = CONST(false),
                                                                                         "Breakbulk No." = CONST(0)));
            Caption = 'Pick Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(33000250; "Quantity Consumed"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(33000251; "Inspection Receipt No."; Code[20])
        {
            TableRelation = "Inspection Receipt Header"."No.";
            DataClassification = CustomerContent;
        }
        field(33000253; "Rework Completed"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(99000754; "Direct Unit Cost"; Decimal)
        {
            Caption = 'Direct Unit Cost';
            DecimalPlaces = 2 : 5;
            DataClassification = CustomerContent;
        }
        field(99000755; "Indirect Cost %"; Decimal)
        {
            Caption = 'Indirect Cost %';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Direct Unit Cost" :=
                  Round("Unit Cost" / (1 + "Indirect Cost %" / 100) - "Overhead Rate");

                Validate("Unit Cost");
            end;
        }
        field(99000756; "Overhead Rate"; Decimal)
        {
            Caption = 'Overhead Rate';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Validate("Indirect Cost %");
            end;
        }
        field(99000757; "Direct Cost Amount"; Decimal)
        {
            Caption = 'Direct Cost Amount';
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(99000758; "Overhead Amount"; Decimal)
        {
            Caption = 'Overhead Amount';
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Status, "Prod. Order No.", "Prod. Order Line No.", "Inspection Receipt No.", "Line No.")
        {
        }
        key(Key2; Status, "Prod. Order No.", "Prod. Order Line No.", "Due Date")
        {
            SumIndexFields = "Expected Quantity", "Cost Amount";
        }
        key(Key3; Status, "Prod. Order No.", "Prod. Order Line No.", "Item No.", "Line No.")
        {
        }
        key(Key4; Status, "Item No.", "Variant Code", "Location Code", "Due Date")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Expected Quantity", "Remaining Qty. (Base)", "Cost Amount", "Overhead Amount";
        }
        key(Key5; "Item No.", "Variant Code", "Location Code", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Due Date")
        {
            Enabled = false;
            SumIndexFields = "Expected Quantity", "Remaining Qty. (Base)", "Cost Amount", "Overhead Amount";
        }
        key(Key6; Status, "Prod. Order No.", "Routing Link Code", "Flushing Method")
        {
        }
        key(Key7; Status, "Prod. Order No.", "Location Code")
        {
        }
        key(Key8; "Item No.", "Variant Code", "Location Code", Status, "Due Date")
        {
            SumIndexFields = "Expected Quantity", "Remaining Qty. (Base)", "Cost Amount", "Overhead Amount";
        }
        key(Key9; Status, "Prod. Order No.", "Prod. Order Line No.", "Item Low-Level Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    var
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderBOMComment: Record "Prod. Order Comp. Cmt Line";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
    begin
        if Status = Status::Finished then
            Error(Text000, Status, TableCaption);
        CheckReworkStatus;
        if "Quantity Consumed" <> 0 then
            Error('%1 can not be deleted as consumption is posted', TableCaption);
    end;

    trigger OnInsert();
    begin
        if Status = Status::Finished then
            Error(Text000, Status, TableCaption);
        CheckReworkStatus;
    end;

    trigger OnModify();
    begin
        if Status = Status::Finished then
            Error(Text000, Status, TableCaption);
        CheckReworkStatus;
    end;

    trigger OnRename();
    begin
        Error(Text99000001, TableCaption);
        CheckReworkStatus;
    end;

    var
        Text000: Label 'A %1 %2 cannot be inserted, modified, or deleted.';
        Text99000000: Label 'You cannot delete %1 %2, because there exists at least one %3 associated with it.';
        Text99000001: Label 'You cannot rename a %1.';
        Text99000002: Label 'You cannot change %1 to %2, when there exists at least one %3 associated with it.';
        Text99000003: Label 'You cannot change %1 when %2 is %3.';
        Text99000004: Label 'Change %1 from %2 to %3?';
        Item: Record Item;
        ItemLedgEntry: Record "Item Ledger Entry";
        ReservEntry: Record "Reservation Entry";
        PickWkshLine: Record "Whse. Worksheet Line";
        GLSetup: Record "General Ledger Setup";
        Location: Record Location;
        //ReservMgt: Codeunit "Reservation Management";
        ReservEngineMgt: Codeunit 99000831;
        ReserveProdOrderComp: Codeunit 99000838;
        UOMMgt: Codeunit "Unit of Measure Management";
        DimMgt: Codeunit DimensionManagement;
        WhseProdRelease: Codeunit "Whse.-Production Release";
        WhseValidateSourceLine: Codeunit "Whse. Validate Source Line";
        Reservation: Page Reservation;
        ItemAvailByDate: Page 157;
        ItemAvailByVar: Page 5414;
        ItemAvailByLoc: Page 492;
        Blocked: Boolean;
        GLSetupRead: Boolean;
        Text99000005: TextConst ENU = 'Warehouse picking is required for %1 = %2. ';
        Text99000006: Label 'The entered information will be disregarded by warehouse operations.';
        Text99000007: Label 'You cannot change %1 to %2 because a pick has already been created for %3 %4.';
        Text99000008: Label 'You cannot change %1 to %2 because %3 %4 has already been picked.';


    procedure Caption(): Text[100];
    var
        ProdOrder: Record "Production Order";
        ProdOrderLine: Record "Prod. Order Line";
    begin
        if not ProdOrder.Get(Status, "Prod. Order No.") then
            exit('');

        if not ProdOrderLine.Get(Status, "Prod. Order No.", "Prod. Order Line No.") then
            Clear(ProdOrderLine);

        exit(
          StrSubstNo('%1 %2 %3',
            "Prod. Order No.", ProdOrder.Description, ProdOrderLine."Item No."));
    end;


    local procedure CalcBaseQty(Qty: Decimal): Decimal;
    begin
        TestField("Qty. per Unit of Measure");
        exit(Round(Qty * "Qty. per Unit of Measure", 0.00001));
    end;


    local procedure GetGLSetup();
    begin
        if not GLSetupRead then
            GLSetup.Get;
        GLSetupRead := true;
    end;

    local procedure GetLocation(LocationCode: Code[10]);
    begin
        if LocationCode = '' then
            Clear(Location)
        else
            if Location.Code <> LocationCode then
                Location.Get(LocationCode);
    end;


    procedure CheckReworkStatus();
    var
        InspectReceipt: Record "Inspection Receipt Header";
    begin
        if InspectReceipt.Get("Inspection Receipt No.") then
            InspectReceipt.TestField("Rework Completed", false);
    end;
}

