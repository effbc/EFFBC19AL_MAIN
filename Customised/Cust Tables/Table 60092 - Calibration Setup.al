table 60092 "Calibration Setup"
{
    // version Cal1.0

    Caption = 'Calibration Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Equipment No."; Code[20])
        {
            Caption = 'Equipment No.';
            TableRelation = Calibration."Equipment No";
            DataClassification = CustomerContent;
        }
        field(2; "Procedure No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "Calibration Procedure Header";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CalcFields("Procedure Description");
            end;
        }
        field(3; "Procedure Description"; Text[50])
        {
            CalcFormula = Lookup("Calibration Procedure Header".Description WHERE("No." = FIELD("Procedure No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Equipment No.", "Procedure No.")
        {
        }
        key(Key2; "Procedure No.", "Equipment No.")
        {
        }
    }

    fieldgroups
    {
    }
}

