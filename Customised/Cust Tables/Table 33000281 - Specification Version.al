table 33000281 "Specification Version"
{
    // version QC1.1

    Caption = 'Specification Version';
    DataCaptionFields = "Specification No.", "Version Code", Description;
    DrillDownPageID = "Specification Version List";
    LookupPageID = "Specification Version List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Specification No."; Code[20])
        {
            Caption = 'Specification No.';
            NotBlank = true;
            TableRelation = "Specification Header";
            DataClassification = CustomerContent;
        }
        field(2; "Version Code"; Code[10])
        {
            Caption = 'Version Code';
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(7; Status; Option)
        {
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = New,"Under Development",Certified;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Status = Status::Certified then
                    TestStatus;
            end;
        }
        field(10; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;
        }
        field(22; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Specification No.", "Version Code")
        {
        }
        key(Key2; "Specification No.", "Starting Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    var
        SpecLine: Record "Specification Line";
    begin
        SpecLine.SetRange("Spec ID", "Specification No.");
        SpecLine.SetRange("Version Code", "Version Code");
        SpecLine.DeleteAll(true);
    end;

    trigger OnInsert();
    begin
        SpecHeader.Get("Specification No.");
        if "Version Code" = '' then
            SpecHeader.TestField("Version Nos.");
        NoSeriesMgt.InitSeries(SpecHeader."Version Nos.", xRec."No. Series", 0D, "Version Code", "No. Series");
    end;

    trigger OnModify();
    begin
        "Last Date Modified" := Today;
    end;

    var
        SpecHeader: Record "Specification Header";
        SpecVersion: Record "Specification Version";
        NoSeriesMgt: Codeunit 396;
        SpecIndent: Codeunit "Spec Line-Indent";


    procedure AssistEdit(OldSpecVersion: Record "Specification Version"): Boolean;
    begin
        SpecVersion := Rec;
        SpecHeader.Get(SpecVersion."Specification No.");
        SpecHeader.TestField("Version Nos.");
        if NoSeriesMgt.SelectSeries(SpecHeader."Version Nos.", OldSpecVersion."No. Series", SpecVersion."No. Series") then begin
            NoSeriesMgt.SetSeries(SpecVersion."Version Code");
            Rec := SpecVersion;
            exit(true);
        end;
    end;

    procedure TestStatus();
    var
        SpecLine2: Record "Specification Line";
        SpecIndent: Codeunit "Spec Line-Indent";
        InspectGroupCode: Code[20];
        SamplingPlanCode: Code[20];
        EndCheck: Boolean;
        BeginCheck: Boolean;
    begin
        SpecIndent.ChangeStatus;
        SpecIndent.IndentSpecVersion(Rec);
        SpecLine2.SetRange("Spec ID", "Specification No.");
        if SpecLine2.Find('-') then begin
            SpecLine2.TestField("Character Type", SpecLine2."Character Type"::"Begin");
            repeat
                if BeginCheck then begin
                    BeginCheck := false;
                    SpecLine2.TestField("Character Type", SpecLine2."Character Type"::Standard);
                end;

                if EndCheck then begin
                    EndCheck := false;
                    SpecLine2.TestField("Character Type", SpecLine2."Character Type"::"Begin");
                end;

                if SpecLine2."Character Type" = SpecLine2."Character Type"::"Begin" then begin
                    BeginCheck := true;
                    SpecLine2.TestField("Sampling Code");
                    SpecLine2.TestField("Inspection Group Code");
                    SamplingPlanCode := SpecLine2."Sampling Code";
                    InspectGroupCode := SpecLine2."Inspection Group Code"
                end else begin
                    if SpecLine2."Character Type" = SpecLine2."Character Type"::"End" then
                        EndCheck := true;
                    SpecLine2."Sampling Code" := SamplingPlanCode;
                    SpecLine2."Inspection Group Code" := InspectGroupCode;
                    SpecLine2.Modify;
                end;
            until SpecLine2.Next = 0
        end else
            Error('No specification lines exists');
    end;
}

