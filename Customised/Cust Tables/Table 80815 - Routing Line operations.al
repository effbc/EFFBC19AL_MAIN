table 80815 "Routing Line operations"
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
        }
        field(5; "Next Operation No."; Code[30])
        {
            Caption = 'Next Operation No.';
            DataClassification = CustomerContent;
        }
        field(6; "Previous Operation No."; Code[30])
        {
            Caption = 'Previous Operation No.';
            DataClassification = CustomerContent;
        }
        field(80000; "Operation No. Length"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(80001; "Next Operation No. Length"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(80002; "Previous Operation No. Length"; Integer)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Routing No.", "Version Code", "Operation No.")
        {
        }
    }

    fieldgroups
    {
    }

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
    end;


    procedure DeleteRelations();
    begin
    end;


    procedure WorkCenterTransferfields();
    begin
    end;


    procedure MachineCtrTransferfields();
    begin
    end;


    procedure SetRecalcStatus();
    begin
    end;


    procedure RunTimePer(): Decimal;
    begin
    end;
}

