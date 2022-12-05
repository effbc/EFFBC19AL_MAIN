table 60100 "Measuring Parameters"
{
    DataClassification = CustomerContent;
    // version Cal1.0


    fields
    {
        field(1; "Equipment No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "UOM Code"; Code[20])
        {
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                UOM.Get("UOM Code");
                Description := UOM.Description;
            end;
        }
        field(4; Description; Text[30])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; "Lower Limit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Upper Limit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Least Count"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Usage Subjective"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Actual Lower Limit"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Usage Subjective", true);
            end;
        }
        field(10; "Actual Upper Limit"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Usage Subjective", true);
            end;
        }
        field(11; "Standard Reference"; Code[10])
        {
            TableRelation = Calibration."Equipment No" WHERE("Usage Type" = FILTER(Master));
            DataClassification = CustomerContent;
        }
        field(12; "Correction Value"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Equipment No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        UOM: Record "Unit of Measure";
}

