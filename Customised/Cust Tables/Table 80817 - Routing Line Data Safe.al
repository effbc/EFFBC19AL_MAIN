table 80817 "Routing Line Data Safe"
{
    // version NAVW16.00,QC1.0,B2B1.0

    Caption = 'Routing Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
            NotBlank = true;
            TableRelation = "Routing Header";
            DataClassification = CustomerContent;
        }
        field(2; "Version Code"; Code[10])
        {
            Caption = 'Version Code';
            TableRelation = "Routing Version"."Version Code" WHERE("Routing No." = FIELD("Routing No."));
            DataClassification = CustomerContent;
        }
        field(4; "Operation No."; Code[10])
        {
            Caption = 'Operation No.';
            NotBlank = true;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus;

                SetRecalcStatus;
            end;
        }
        field(5; "Next Operation No."; Code[30])
        {
            Caption = 'Next Operation No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                SetRecalcStatus;
            end;
        }
        field(6; "Previous Operation No."; Code[30])
        {
            Caption = 'Previous Operation No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                SetRecalcStatus;
            end;
        }
        field(7; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = '"Work Center,Machine Center, "';
            OptionMembers = "Work Center","Machine Center"," ";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                SetRecalcStatus;

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
                SetRecalcStatus;

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

            trigger OnValidate();
            begin
                SetRecalcStatus;
            end;
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

            trigger OnValidate();
            begin
                SetRecalcStatus;
            end;
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
            begin
                if "Standard Task Code" = '' then
                    if "Standard Task Code" <> xRec."Standard Task Code" then begin
                        DeleteRelations;
                        exit;
                    end;

                StandardTask.Get("Standard Task Code");
                Description := StandardTask.Description;

                DeleteRelations;

                StdTaskTool.SetRange("Standard Task Code", "Standard Task Code");
                if StdTaskTool.Find('-') then
                    repeat
                        RtngTool."Routing No." := "Routing No.";
                        RtngTool."Version Code" := "Version Code";
                        RtngTool."Operation No." := "Operation No.";
                        RtngTool."Line No." := StdTaskTool."Line No.";
                        RtngTool."No." := StdTaskTool."No.";
                        RtngTool.Description := StdTaskTool.Description;
                        RtngTool.Insert;
                    until StdTaskTool.Next = 0;

                StdTaskPersonnel.SetRange("Standard Task Code", "Standard Task Code");
                if StdTaskPersonnel.Find('-') then
                    repeat
                        RtngPersonnel."Routing No." := "Routing No.";
                        RtngPersonnel."Version Code" := "Version Code";
                        RtngPersonnel."Operation No." := "Operation No.";
                        RtngPersonnel."Line No." := StdTaskPersonnel."Line No.";
                        RtngPersonnel."No." := StdTaskPersonnel."No.";
                        RtngPersonnel.Description := StdTaskPersonnel.Description;
                        RtngPersonnel.Insert;
                    until StdTaskPersonnel.Next = 0;

                StdTaskQltyMeasure.SetRange("Standard Task Code", "Standard Task Code");
                if StdTaskQltyMeasure.Find('-') then
                    repeat
                        RtngQltyMeasure."Routing No." := "Routing No.";
                        RtngQltyMeasure."Version Code" := "Version Code";
                        RtngQltyMeasure."Operation No." := "Operation No.";
                        RtngQltyMeasure."Line No." := StdTaskQltyMeasure."Line No.";
                        RtngQltyMeasure."Qlty Measure Code" := StdTaskQltyMeasure."Qlty Measure Code";
                        RtngQltyMeasure.Description := StdTaskQltyMeasure.Description;
                        RtngQltyMeasure."Min. Value" := StdTaskQltyMeasure."Min. Value";
                        RtngQltyMeasure."Max. Value" := StdTaskQltyMeasure."Max. Value";
                        RtngQltyMeasure."Mean Tolerance" := StdTaskQltyMeasure."Mean Tolerance";
                        RtngQltyMeasure.Insert;
                    until StdTaskQltyMeasure.Next = 0;

                StdTaskComment.SetRange("Standard Task Code", "Standard Task Code");
                if StdTaskComment.Find('-') then
                    repeat
                        RtngComment."Routing No." := "Routing No.";
                        RtngComment."Version Code" := "Version Code";
                        RtngComment."Operation No." := "Operation No.";
                        RtngComment."Line No." := StdTaskComment."Line No.";
                        RtngComment.Comment := StdTaskComment.Text;
                        RtngComment.Insert;
                    until StdTaskComment.Next = 0;
            end;
        }
        field(40; "Unit Cost per"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost per';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(41; Recalculate; Boolean)
        {
            Caption = 'Recalculate';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(45; Comment; Boolean)
        {
            CalcFormula = Exist("Routing Comment Line" WHERE("Routing No." = FIELD("Routing No."),
                                                              "Version Code" = FIELD("Version Code"),
                                                              "Operation No." = FIELD("Operation No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
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
        field(60001; "Operation Description"; Text[50])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60002; "QAS/MPR"; Option)
        {
            Description = 'B2B';
            OptionMembers = " ",QAS,MPR;
            DataClassification = CustomerContent;
        }
        field(60003; "Man Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(33000250; "Sub Assembly"; Code[20])
        {
            TableRelation = "Sub Assembly";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Sub Assembly" = '' then begin
                    "Sub Assembly Unit of Meas.Code" := '';
                    "Spec Id" := '';
                    "QC Enabled" := false;
                    "Qty. Produced" := 0;
                end else begin
                    Subassembly.Get("Sub Assembly");
                    "Sub Assembly Unit of Meas.Code" := Subassembly."Unit Of Measure Code";
                    "Spec Id" := Subassembly."Spec Id";
                    "QC Enabled" := Subassembly."QC Enabled";
                    "Sub Assembly Description" := Subassembly.Description;
                end;
            end;
        }
        field(33000251; "Qty. Produced"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Sub Assembly");
            end;
        }
        field(33000252; "Sub Assembly Unit of Meas.Code"; Code[10])
        {
            TableRelation = "Sub Assembly Unit of Measure".Code WHERE("Sub Assembly No." = FIELD("Sub Assembly"));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Sub Assembly");
            end;
        }
        field(33000253; "Spec Id"; Code[20])
        {
            TableRelation = "Specification Header";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Sub Assembly");
                if "Spec Id" = '' then
                    "QC Enabled" := false;
            end;
        }
        field(33000254; "QC Enabled"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Sub Assembly");
                TestField("Spec Id");
            end;
        }
        field(33000255; "Sub Assembly Description"; Text[30])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Routing No.", "Version Code", "Operation No.")
        {
            SumIndexFields = "Man Cost";
        }
        key(Key2; "Routing No.", "Version Code", "Sequence No. (Forward)")
        {
        }
        key(Key3; "Routing No.", "Version Code", "Sequence No. (Backward)")
        {
        }
        key(Key4; "Work Center No.")
        {
        }
        key(Key5; Type, "No.")
        {
        }
        key(Key6; "Routing Link Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        TestStatus;

        DeleteRelations;
    end;

    trigger OnInsert();
    begin
        TestStatus;
    end;

    trigger OnModify();
    begin
        TestStatus;
    end;

    trigger OnRename();
    begin
        TestStatus;

        SetRecalcStatus;
    end;

    var
        WorkCenter: Record "Work Center";
        MachineCenter: Record "Machine Center";
        RtngTool: Record "Routing Tool";
        RtngPersonnel: Record "Routing Personnel";
        RtngQltyMeasure: Record "Routing Quality Measure";
        RtngComment: Record "Routing Comment Line";
        StdTaskTool: Record "Standard Task Tool";
        StdTaskPersonnel: Record "Standard Task Personnel";
        StdTaskQltyMeasure: Record "Standard Task Quality Measure";
        StdTaskComment: Record "Standard Task Description";
        "--QC--": Integer;
        Subassembly: Record "Sub Assembly";


    procedure TestStatus();
    var
        RtngHeader: Record "Routing Header";
        RtngVersion: Record "Routing Version";
    begin
        if "Version Code" = '' then begin
            RtngHeader.Get("Routing No.");
            if RtngHeader.Status = RtngHeader.Status::Certified then
                RtngHeader.FieldError(Status);
        end else begin
            RtngVersion.Get("Routing No.", "Version Code");
            if RtngVersion.Status = RtngVersion.Status::Certified then
                RtngVersion.FieldError(Status);
        end;
    end;


    procedure DeleteRelations();
    begin
        RtngTool.SetRange("Routing No.", "Routing No.");
        RtngTool.SetRange("Version Code", "Version Code");
        RtngTool.SetRange("Operation No.", "Operation No.");
        RtngTool.DeleteAll;

        RtngPersonnel.SetRange("Routing No.", "Routing No.");
        RtngPersonnel.SetRange("Version Code", "Version Code");
        RtngPersonnel.SetRange("Operation No.", "Operation No.");
        RtngPersonnel.DeleteAll;

        RtngQltyMeasure.SetRange("Routing No.", "Routing No.");
        RtngQltyMeasure.SetRange("Version Code", "Version Code");
        RtngQltyMeasure.SetRange("Operation No.", "Operation No.");
        RtngQltyMeasure.DeleteAll;

        RtngComment.SetRange("Routing No.", "Routing No.");
        RtngComment.SetRange("Version Code", "Version Code");
        RtngComment.SetRange("Operation No.", "Operation No.");
        RtngComment.DeleteAll;
    end;


    procedure WorkCenterTransferfields();
    begin
        "Work Center No." := WorkCenter."No.";
        "Work Center Group Code" := WorkCenter."Work Center Group Code";
        if "Setup Time Unit of Meas. Code" = '' then
            "Setup Time Unit of Meas. Code" := WorkCenter."Unit of Measure Code";
        if "Run Time Unit of Meas. Code" = '' then
            "Run Time Unit of Meas. Code" := WorkCenter."Unit of Measure Code";
        if "Wait Time Unit of Meas. Code" = '' then
            "Wait Time Unit of Meas. Code" := WorkCenter."Unit of Measure Code";
        if "Move Time Unit of Meas. Code" = '' then
            "Move Time Unit of Meas. Code" := WorkCenter."Unit of Measure Code";
        Description := WorkCenter.Name;
        //Cost1.0
        "Man Cost" := "Run Time" * WorkCenter."Unit Cost";
        //Cost1.0
    end;


    procedure MachineCtrTransferfields();
    begin
        WorkCenter.Get(MachineCenter."Work Center No.");
        WorkCenterTransferfields;

        Description := MachineCenter.Name;
        "Setup Time" := MachineCenter."Setup Time";
        "Wait Time" := MachineCenter."Wait Time";
        "Move Time" := MachineCenter."Move Time";
        if "Setup Time Unit of Meas. Code" = '' then
            "Setup Time Unit of Meas. Code" := MachineCenter."Setup Time Unit of Meas. Code";
        if "Wait Time Unit of Meas. Code" = '' then
            "Wait Time Unit of Meas. Code" := MachineCenter."Wait Time Unit of Meas. Code";
        if "Move Time Unit of Meas. Code" = '' then
            "Move Time Unit of Meas. Code" := MachineCenter."Move Time Unit of Meas. Code";
        "Fixed Scrap Quantity" := MachineCenter."Fixed Scrap Quantity";
        "Scrap Factor %" := MachineCenter."Scrap %";
        "Minimum Process Time" := MachineCenter."Minimum Process Time";
        "Maximum Process Time" := MachineCenter."Maximum Process Time";
        "Concurrent Capacities" := MachineCenter."Concurrent Capacities";
        "Send-Ahead Quantity" := MachineCenter."Send-Ahead Quantity";
        //Cost1.0
        "Man Cost" := "Run Time" * MachineCenter."Unit Cost";
        //Cost1.0
    end;


    procedure SetRecalcStatus();
    begin
        Recalculate := true;
    end;


    procedure RunTimePer(): Decimal;
    begin
        if "Lot Size" = 0 then
            "Lot Size" := 1;

        exit(Round("Run Time" / "Lot Size", 0.00001));
    end;
}

