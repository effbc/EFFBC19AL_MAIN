table 33000278 "Ins Prod. Order Routing Line"
{
    // version WIP1.0

    Caption = 'Prod. Order Inspect. Component';
    DrillDownPageID = "Prod. Order Routing";
    LookupPageID = "Prod. Order Routing";
    Permissions = TableData "Prod. Order Capacity Need" = rimd;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
            TableRelation = "Routing Header";
            DataClassification = CustomerContent;
        }
        field(3; "Routing Reference No."; Integer)
        {
            Caption = 'Routing Reference No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(4; "Operation No."; Code[10])
        {
            Caption = 'Operation No.';
            NotBlank = true;
            TableRelation = "Prod. Order Routing Line"."Operation No." WHERE("Prod. Order No." = FIELD("Prod. Order No."),
                                                                              "Routing Reference No." = FIELD("Routing Reference No."),
                                                                              "Routing No." = FIELD("Routing No."));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                GetLine;
                "Starting Time" := ProdOrderLine."Starting Time";
                "Ending Time" := ProdOrderLine."Ending Time";
                "Starting Date" := ProdOrderLine."Starting Date";
                "Ending Date" := ProdOrderLine."Ending Date";
            end;
        }
        field(5; "Next Operation No."; Code[30])
        {
            Caption = 'Next Operation No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                GetLine;
            end;
        }
        field(6; "Previous Operation No."; Code[30])
        {
            Caption = 'Previous Operation No.';
            DataClassification = CustomerContent;
        }
        field(7; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Work Center,Machine Center';
            OptionMembers = "Work Center","Machine Center";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "No." := '';
                "Work Center No." := '';
                "Work Center Group Code" := '';
            end;
        }
        field(8; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST("Work Center")) "Work Center"
            ELSE
            IF (Type = CONST("Machine Center")) "Machine Center";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "No." = '' then
                    exit;

                case Type of
                    Type::"Work Center":
                        begin
                            WorkCenter.Get("No.");
                            WorkCenter.TestField(Blocked, false);
                            WorkCenterTransferfields;
                        end;
                    Type::"Machine Center":
                        begin
                            MachineCenter.Get("No.");
                            MachineCenter.TestField(Blocked, false);
                            MachineCtrTransferfields;
                        end;
                end;

                GetLine;
                if ProdOrderLine."Routing Type" = ProdOrderLine."Routing Type"::Serial then;
            end;
        }
        field(9; "Work Center No."; Code[20])
        {
            Caption = 'Work Center No.';
            Editable = false;
            TableRelation = "Work Center";
            DataClassification = CustomerContent;
        }
        field(10; "Work Center Group Code"; Code[10])
        {
            Caption = 'Work Center Group Code';
            Editable = false;
            TableRelation = "Work Center Group";
            DataClassification = CustomerContent;
        }
        field(11; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(12; "Setup Time"; Decimal)
        {
            Caption = 'Setup Time';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(13; "Run Time"; Decimal)
        {
            Caption = 'Run Time';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(14; "Wait Time"; Decimal)
        {
            Caption = 'Wait Time';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(15; "Move Time"; Decimal)
        {
            Caption = 'Move Time';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(16; "Fixed Scrap Quantity"; Decimal)
        {
            Caption = 'Fixed Scrap Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(17; "Lot Size"; Decimal)
        {
            Caption = 'Lot Size';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(18; "Scrap Factor %"; Decimal)
        {
            Caption = 'Scrap Factor %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(19; "Setup Time Unit of Meas. Code"; Code[10])
        {
            Caption = 'Setup Time Unit of Meas. Code';
            TableRelation = "Capacity Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(20; "Run Time Unit of Meas. Code"; Code[10])
        {
            Caption = 'Run Time Unit of Meas. Code';
            TableRelation = "Capacity Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(21; "Wait Time Unit of Meas. Code"; Code[10])
        {
            Caption = 'Wait Time Unit of Meas. Code';
            TableRelation = "Capacity Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(22; "Move Time Unit of Meas. Code"; Code[10])
        {
            Caption = 'Move Time Unit of Meas. Code';
            TableRelation = "Capacity Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(27; "Minimum Process Time"; Decimal)
        {
            Caption = 'Minimum Process Time';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(28; "Maximum Process Time"; Decimal)
        {
            Caption = 'Maximum Process Time';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(30; "Concurrent Capacities"; Decimal)
        {
            Caption = 'Concurrent Capacities';
            DecimalPlaces = 0 : 5;
            InitValue = 1;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(31; "Send-Ahead Quantity"; Decimal)
        {
            Caption = 'Send-Ahead Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(34; "Routing Link Code"; Code[10])
        {
            Caption = 'Routing Link Code';
            TableRelation = "Routing Link";
            DataClassification = CustomerContent;
        }
        field(35; "Standard Task Code"; Code[10])
        {
            Caption = 'Standard Task Code';
            TableRelation = "Standard Task";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                StandardTask: Record "Standard Task";
                StdTaskTool: Record "Standard Task Tool";
                StdTaskPersonnel: Record "Standard Task Personnel";
                StdTaskQltyMeasure: Record "Standard Task Quality Measure";
                StdTaskComment: Record "Standard Task Description";
            begin
            end;
        }
        field(40; "Unit Cost per"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost per';
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                GLSetup.Get;
                "Direct Unit Cost" :=
                  Round(
                    ("Unit Cost per" - "Overhead Rate") /
                    (1 + "Indirect Cost %" / 100),
                    GLSetup."Unit-Amount Rounding Precision");
            end;
        }
        field(41; Recalculate; Boolean)
        {
            Caption = 'Recalculate';
            DataClassification = CustomerContent;
        }
        field(50; "Sequence No. (Forward)"; Integer)
        {
            Caption = 'Sequence No. (Forward)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(51; "Sequence No. (Backward)"; Integer)
        {
            Caption = 'Sequence No. (Backward)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(52; "Fixed Scrap Qty. (Accum.)"; Decimal)
        {
            Caption = 'Fixed Scrap Qty. (Accum.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(53; "Scrap Factor % (Accumulated)"; Decimal)
        {
            Caption = 'Scrap Factor % (Accumulated)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(55; "Sequence No. (Actual)"; Integer)
        {
            Caption = 'Sequence No. (Actual)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(56; "Direct Unit Cost"; Decimal)
        {
            Caption = 'Direct Unit Cost';
            DecimalPlaces = 2 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Validate("Indirect Cost %");
            end;
        }
        field(57; "Indirect Cost %"; Decimal)
        {
            Caption = 'Indirect Cost %';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                GLSetup.Get;
                "Unit Cost per" :=
                  Round(
                    "Direct Unit Cost" * (1 + "Indirect Cost %" / 100) + "Overhead Rate",
                    GLSetup."Unit-Amount Rounding Precision");
            end;
        }
        field(58; "Overhead Rate"; Decimal)
        {
            Caption = 'Overhead Rate';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Validate("Indirect Cost %");
            end;
        }
        field(70; "Starting Time"; Time)
        {
            Caption = 'Starting Time';
            DataClassification = CustomerContent;
        }
        field(71; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;
        }
        field(72; "Ending Time"; Time)
        {
            Caption = 'Ending Time';
            DataClassification = CustomerContent;
        }
        field(73; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            DataClassification = CustomerContent;
        }
        field(74; Status; Enum "Production Order Status")
        {
            Caption = 'Status';
            InitValue = Released;
            DataClassification = CustomerContent;
        }
        field(75; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            Editable = false;
            NotBlank = true;
            TableRelation = "Production Order"."No." WHERE(Status = FIELD(Status));
            DataClassification = CustomerContent;
        }
        field(76; "Unit Cost Calculation"; Option)
        {
            Caption = 'Unit Cost Calculation';
            OptionCaption = 'Time,Units';
            OptionMembers = Time,Units;
            DataClassification = CustomerContent;
        }
        field(77; "Input Quantity"; Decimal)
        {
            Caption = 'Input Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(78; "Critical Path"; Boolean)
        {
            Caption = 'Critical Path';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(79; "Routing Status"; Option)
        {
            Caption = 'Routing Status';
            InitValue = "In Progress";
            OptionCaption = '" ,Planned,In Progress,Finished"';
            OptionMembers = " ",Planned,"In Progress",Finished;
            DataClassification = CustomerContent;
        }
        field(81; "Flushing Method"; Enum "Flushing Method Routing")
        {
            Caption = 'Flushing Method';
            InitValue = Manual;
            DataClassification = CustomerContent;
        }
        field(90; "Expected Operation Cost Amt."; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Expected Operation Cost Amt.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(91; "Expected Capacity Need"; Decimal)
        {
            Caption = 'Expected Capacity Need';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = Normal;
            DataClassification = CustomerContent;
        }
        field(96; "Expected Capacity Ovhd. Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Expected Capacity Ovhd. Cost';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(98; "Starting Date-Time"; Decimal)
        {
            AutoFormatExpression = 'DATETIME';
            AutoFormatType = 10;
            Caption = 'Starting Date-Time';
            DecimalPlaces = 2 :;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*
                "Starting Date" := DatetimeMgt.Datetime2Date("Starting Date-Time");
                "Starting Time" := DatetimeMgt.Datetime2Time("Starting Date-Time");
                *///B2B Commented

            end;
        }
        field(99; "Ending Date-Time"; Decimal)
        {
            AutoFormatExpression = 'DATETIME';
            AutoFormatType = 10;
            Caption = 'Ending Date-Time';
            DecimalPlaces = 2 :;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*
                "Ending Date" := DatetimeMgt.Datetime2Date("Ending Date-Time");
                "Ending Time" := DatetimeMgt.Datetime2Time("Ending Date-Time");
                *///B2B Commented

            end;
        }
        field(100; "Schedule Manually"; Boolean)
        {
            Caption = 'Schedule Manually';
            DataClassification = CustomerContent;
        }
        field(33000250; "Sub Assembly"; Code[20])
        {
            TableRelation = "Sub Assembly";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Sub Assembly" = '' then begin
                    "Spec Id" := '';
                    "QC Enabled" := false;
                end else begin
                    SubAssembly.Get("Sub Assembly");
                    "Spec Id" := SubAssembly."Spec Id";
                    "QC Enabled" := SubAssembly."QC Enabled";
                    "Sub Assembly Description" := SubAssembly.Description;
                end;
            end;
        }
        field(33000251; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(33000252; "Spec Id"; Code[20])
        {
            TableRelation = "Specification Header";
            DataClassification = CustomerContent;
        }
        field(33000253; "QC Enabled"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(33000254; "Sub Assembly Unit Of Meas.Code"; Code[20])
        {
            TableRelation = "Sub Assembly Unit of Measure".Code;
            DataClassification = CustomerContent;
        }
        field(33000255; "Qty.To Produce"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Qty.To Produce" < 0 then
                    Error('Qty.To be  Produced should not be Negative');
                if "Qty.To Produce" + "Quantity Produced" > Quantity then
                    Message('Quantity To Produce and Quantity Produced is more than Quantity');
            end;
        }
        field(33000256; "Quantity Produced"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Qty.To Produce" := Quantity - "Quantity Produced";
            end;
        }
        field(33000257; "Sub Assembly Description"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(33000258; "Inspection Receipt No."; Code[20])
        {
            TableRelation = "Inspection Receipt Header"."No.";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Status, "Prod. Order No.", "Routing Reference No.", "Routing No.", "Operation No.", "Inspection Receipt No.")
        {
            SumIndexFields = "Expected Operation Cost Amt.", "Expected Capacity Need", "Expected Capacity Ovhd. Cost";
        }
        key(Key2; Status, "Prod. Order No.", "Routing Reference No.", "Routing No.", "Sequence No. (Forward)")
        {
        }
        key(Key3; Status, "Prod. Order No.", "Routing Reference No.", "Routing No.", "Sequence No. (Backward)")
        {
        }
        key(Key4; Status, "Prod. Order No.", "Routing Reference No.", "Routing No.", "Sequence No. (Actual)")
        {
        }
        key(Key5; "Work Center No.")
        {
            SumIndexFields = "Expected Operation Cost Amt.";
        }
        key(Key6; Type, "No.", "Starting Date")
        {
            SumIndexFields = "Expected Operation Cost Amt.";
        }
        key(Key7; Status, "Work Center No.")
        {
        }
        key(Key8; "Prod. Order No.", Status, "Flushing Method")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    var
        CapLedgEntry: Record "Capacity Ledger Entry";
    begin
        if Status = Status::Finished then
            Error(Text006, Status, TableCaption)
        else
            if Status = Status::Released then begin
                CapLedgEntry.SetCurrentKey(
                  "Order No.", "Order Line No.",
                  "Routing No.", "Routing Reference No.", "Operation No.");
                CapLedgEntry.SetRange("Order No.", "Prod. Order No.");
                CapLedgEntry.SetRange("Routing Reference No.", "Routing Reference No.");
                CapLedgEntry.SetRange("Routing No.", "Routing No.");
                CapLedgEntry.SetRange("Operation No.", "Operation No.");
                /*
                IF CapLedgEntry.FIND('-') THEN
                  ERROR(
                    Text000,
                    Status,TABLECAPTION,"Operation No.",CapLedgEntry.TABLECAPTION);
               */
            end;
        CheckReworkStatus;

    end;

    trigger OnInsert();
    begin
        if Status = Status::Finished then
            Error(Text006, Status, TableCaption);

        if "Next Operation No." = '' then
            SetNextOperations(Rec);
        CheckReworkStatus;

        "Starting Time" := Time;
        "Starting Date" := WorkDate;
        "Ending Date" := WorkDate;
        "Ending Time" := Time;
    end;

    trigger OnModify();
    begin
        if Status = Status::Finished then
            Error(Text006, Status, TableCaption);
        CheckReworkStatus;
    end;

    trigger OnRename();
    begin
        Error(Text001, TableCaption);
    end;

    var
        Text000: Label 'You can not delete %1 %2 %3, because there exists at least one %4 associated with it.';
        Text001: Label 'You cannot rename a %1.';
        Text002: Label 'This routing line cannot be moved because of critical work centers in previous operations';
        Text003: Label 'This routing line cannot be moved because of critical work centers in next operations';
        WorkCenter: Record "Work Center";
        MachineCenter: Record "Machine Center";
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderRtngLine: Record "Prod. Order Routing Line";
        ProdOrderRoutTool: Record "Prod. Order Routing Tool";
        ProdOrderRtngPersonnel: Record "Prod. Order Routing Personnel";
        ProdOrderRtngQltyMeas: Record "Prod. Order Rtng Qlty Meas.";
        ProdOrderRtngComment: Record "Prod. Order Rtng Comment Line";
        GLSetup: Record "General Ledger Setup";
        ProdOrderCapNeed: Record "Prod. Order Capacity Need";
        CalcProdOrder: Codeunit "Calculate Prod. Order";
        ProdOrderRouteMgt: Codeunit 99000772;
        Text004: Label 'Some routing lines are referring to the operation just deleted. The references are\in the fields %1 and %2.\\This may have to be corrected as a routing line referring to a non-existent\operation will lead to serious errors in capacity planning.\\Do you want to see a list of the lines in question?\(Access the columns Next Operation No. and Previous Operation No.)';
        Text005: Label 'Routing Lines referring to deleted Operation No. %1';
        Text006: Label 'A %1 %2 can not be inserted, modified, or deleted.';
        SubAssembly: Record "Sub Assembly";

    procedure Caption(): Text[100];
    var
        ProdOrder: Record "Production Order";
    begin
        if GetFilters = '' then
            exit('');

        if not ProdOrder.Get(Status, "Prod. Order No.") then
            exit('');

        exit(
          StrSubstNo('%1 %2 %3',
            "Prod. Order No.", ProdOrder.Description, "Routing No."));
    end;


    procedure GetLine();
    begin
        ProdOrderLine.SetRange(Status, Status);
        ProdOrderLine.SetRange("Prod. Order No.", "Prod. Order No.");
        ProdOrderLine.SetRange("Routing No.", "Routing No.");
        ProdOrderLine.SetRange("Routing Reference No.", "Routing Reference No.");
        ProdOrderLine.Find('-');
    end;


    procedure WorkCenterTransferfields();
    begin
        "Work Center No." := WorkCenter."No.";
        "Work Center Group Code" := WorkCenter."Work Center Group Code";
        "Setup Time Unit of Meas. Code" := WorkCenter."Unit of Measure Code";
        "Run Time Unit of Meas. Code" := WorkCenter."Unit of Measure Code";
        "Wait Time Unit of Meas. Code" := WorkCenter."Unit of Measure Code";
        "Move Time Unit of Meas. Code" := WorkCenter."Unit of Measure Code";
        Description := WorkCenter.Name;
        "Flushing Method" := WorkCenter."Flushing Method";
        "Unit Cost per" := WorkCenter."Unit Cost";
        "Direct Unit Cost" := WorkCenter."Direct Unit Cost";
        "Indirect Cost %" := WorkCenter."Indirect Cost %";
        "Overhead Rate" := WorkCenter."Overhead Rate";
        "Unit Cost Calculation" := WorkCenter."Unit Cost Calculation";
    end;


    procedure MachineCtrTransferfields();
    begin
        WorkCenter.Get(MachineCenter."Work Center No.");
        WorkCenterTransferfields;

        Description := MachineCenter.Name;
        "Setup Time" := MachineCenter."Setup Time";
        "Wait Time" := MachineCenter."Wait Time";
        "Move Time" := MachineCenter."Move Time";
        "Fixed Scrap Quantity" := MachineCenter."Fixed Scrap Quantity";
        "Scrap Factor %" := MachineCenter."Scrap %";
        "Minimum Process Time" := MachineCenter."Minimum Process Time";
        "Maximum Process Time" := MachineCenter."Maximum Process Time";
        "Concurrent Capacities" := MachineCenter."Concurrent Capacities";
        "Send-Ahead Quantity" := MachineCenter."Send-Ahead Quantity";
        "Setup Time Unit of Meas. Code" := MachineCenter."Setup Time Unit of Meas. Code";
        "Wait Time Unit of Meas. Code" := MachineCenter."Wait Time Unit of Meas. Code";
        "Move Time Unit of Meas. Code" := MachineCenter."Move Time Unit of Meas. Code";
        "Flushing Method" := MachineCenter."Flushing Method";
        "Unit Cost per" := MachineCenter."Unit Cost";
        "Direct Unit Cost" := MachineCenter."Direct Unit Cost";
        "Indirect Cost %" := MachineCenter."Indirect Cost %";
        "Overhead Rate" := MachineCenter."Overhead Rate";
    end;


    procedure SetNextOperations(var RtngLine: Record "Ins Prod. Order Routing Line");
    var
        RtngLine2: Record "Ins Prod. Order Routing Line";
    begin
        RtngLine2.SetRange(Status, RtngLine.Status);
        RtngLine2.SetRange("Prod. Order No.", RtngLine."Prod. Order No.");
        RtngLine2.SetRange("Routing Reference No.", RtngLine."Routing Reference No.");
        RtngLine2.SetRange("Routing No.", RtngLine."Routing No.");
        RtngLine2.SetFilter("Operation No.", '>%1', RtngLine."Operation No.");

        if RtngLine2.Find('-') then
            RtngLine."Next Operation No." := RtngLine2."Operation No."
        else begin
            RtngLine2.SetFilter("Operation No.", '');
            RtngLine2.SetRange("Next Operation No.", '');
            if RtngLine2.Find('-') then begin
                RtngLine2."Next Operation No." := RtngLine."Operation No.";
                RtngLine2.Modify;
            end;
        end;
    end;


    procedure CheckReworkStatus();
    var
        InspectReceipt: Record "Inspection Receipt Header";
    begin
        if InspectReceipt.Get("Inspection Receipt No.") then
            InspectReceipt.TestField("Rework Completed", false);
    end;
}

