table 33000254 "Specification Line"
{
    // version QC1.1

    DrillDownPageID = "Specification Subform";
    LookupPageID = Characteristics;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Spec ID"; Code[20])
        {
            TableRelation = "Specification Header"."Spec ID";
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Character Code"; Code[20])
        {
            TableRelation = Characteristic.Code;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Character Type" = "Character Type"::Standard then
                    if Characterstic.Get("Character Code") then begin
                        "Inspection Group Code" := Characterstic."Inspection Group Code";
                        Description := Characterstic.Description;
                        "Unit Of Measure Code" := Characterstic."Unit Of Measure Code";
                        Qualitative := Characterstic.Qualitative;
                    end;
            end;
        }
        field(4; Description; Text[50])
        {
            NotBlank = false;
            DataClassification = CustomerContent;
        }
        field(5; "Sampling Code"; Code[20])
        {
            TableRelation = "Sampling Plan Header".Code;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Character Type", "Character Type"::"Begin");
            end;
        }
        field(6; "Normal Value (Num)"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Character Type", "Character Type"::Standard);
                TestField(Qualitative, false);
                TestField("Character Type", "Character Type"::Standard);
                if ("Max. Value (Num)" = 0) and ("Normal Value (Num)" < "Min. Value (Num)") then
                    Error('%1 should not be less than %2', FieldCaption("Normal Value (Num)"), FieldCaption("Min. Value (Num)"));

                if "Max. Value (Num)" <> 0 then
                    if ("Normal Value (Num)" < "Min. Value (Num)") or ("Normal Value (Num)" > "Max. Value (Num)") then
                        Error('%1 should be within %2 and %3', FieldCaption("Normal Value (Num)"), FieldCaption("Min. Value (Num)"),
                        FieldCaption("Max. Value (Num)"));
            end;
        }
        field(7; "Min. Value (Num)"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Validate("Max. Value (Num)");
                Validate("Normal Value (Num)");
            end;
        }
        field(8; "Max. Value (Num)"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Max. Value (Num)" < "Min. Value (Num)") and ("Max. Value (Num)" <> 0) then
                    Error('%1 should not be greater than %2 specification line %3', FieldCaption("Min. Value (Num)"), FieldCaption("Max. Value (Num)")
                  ,
                      "Line No.");
                Validate("Normal Value (Num)");
            end;
        }
        field(9; "Normal Value (Char)"; Code[20])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Character Type", "Character Type"::Standard);
                TestField(Qualitative, true);
            end;
        }
        field(10; "Min. Value (Char)"; Code[20])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Validate("Normal Value (Char)");
            end;
        }
        field(11; "Max. Value (Char)"; Code[20])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Validate("Normal Value (Char)");
            end;
        }
        field(12; "Inspection Group Code"; Code[20])
        {
            TableRelation = "Inspection Group";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Validate("Sampling Code");
            end;
        }
        field(13; "Unit Of Measure Code"; Code[20])
        {
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Character Type", "Character Type"::Standard);
            end;
        }
        field(14; Qualitative; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Character Type", "Character Type"::Standard);
            end;
        }
        field(15; "Character Type"; Option)
        {
            OptionCaption = 'Standard,Heading,Begin,End';
            OptionMembers = Standard,Heading,"Begin","End";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Character Type" in ["Character Type"::"Begin", "Character Type"::"End"] then begin
                    "Normal Value (Num)" := 0;
                    "Min. Value (Num)" := 0;
                    "Max. Value (Num)" := 0;
                    "Normal Value (Char)" := '';
                    "Min. Value (Char)" := '';
                    "Max. Value (Char)" := '';
                    "Unit Of Measure Code" := '';
                    Qualitative := false;
                end;
            end;
        }
        field(16; Indentation; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(20; "Version Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60001; "Inspection Time(In Min.)"; Decimal)
        {
            Caption = 'Inspection Time(In Min.)';
            Description = 'B2B1.0-ESPLQC';
            DataClassification = CustomerContent;
        }
        field(60002; "Item No."; Code[20])
        {
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Spec ID", "Version Code", "Line No.")
        {
            SumIndexFields = "Inspection Time(In Min.)";
        }
        key(Key2; "Inspection Group Code")
        {
        }
        key(Key3; "Spec ID", "Character Code", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        TestStatus;
    end;

    trigger OnInsert();
    begin
        if "Character Type" = "Character Type"::Standard then
            TestField("Character Code");
        TestStatus;
    end;

    trigger OnModify();
    begin
        if "Character Type" = "Character Type"::Standard then
            TestField("Character Code");
        TestStatus;
    end;

    var
        Characterstic: Record Characteristic;
        SpecHeader: Record "Specification Header";


    procedure TestStatus();
    var
        SpecVersion: Record "Specification Version";
    begin

        if "Version Code" = '' then begin
            SpecHeader.Get("Spec ID");
            if SpecHeader.Status = SpecVersion.Status::Certified then
                SpecHeader.FieldError(Status);
        end else begin
            SpecVersion.Get("Spec ID", "Version Code");
            if SpecVersion.Status = SpecVersion.Status::Certified then
                SpecVersion.FieldError(Status);
        end;
    end;
}

