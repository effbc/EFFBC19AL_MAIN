table 33000267 "Assay Line"
{
    // version QC1.0

    LookupPageID = Characteristics;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Assay No."; Code[20])
        {
            TableRelation = "Assay Header";
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
                if Characterstic.Get("Character Code") then begin
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
        field(6; "Normal Value (Num)"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField(Qualitative, false);
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
        field(13; "Unit Of Measure Code"; Code[20])
        {
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(14; Qualitative; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Assay No.", "Line No.")
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
        TestField("Character Code");
        TestStatus;
    end;

    trigger OnModify();
    begin
        TestField("Character Code");
        TestStatus;
    end;

    var
        Characterstic: Record Characteristic;
        AssayHeader: Record "Assay Header";


    procedure TestStatus();
    begin

        AssayHeader.Get("Assay No.");
        if AssayHeader.Status = AssayHeader.Status::Certified then
            AssayHeader.FieldError(Status);
    end;
}

