table 33000264 "Posted Inspect Datasheet Line"
{
    // version QC1.0,Cal1.0

    // B2B 10sep2007
    // added a field "Rework Reason Code"

    DrillDownPageID = "PostedInspec DataSheet Subform";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "Posted Inspect DatasheetHeader";
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
        }
        field(4; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Sampling Plan Code"; Code[20])
        {
            TableRelation = "Sampling Plan Header".Code;
            DataClassification = CustomerContent;
        }
        field(6; "Normal Value (Num)"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(7; "Min. Value (Num)"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(8; "Max. Value (Num)"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(9; "Actual Value (Num)"; Decimal)
        {
            BlankZero = false;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*IF ("Normal Value (Num)" = 0) AND ("Min. Value (Num)" = 0) AND ("Max. Value (Num)" = 0)  THEN
                  ERROR('You Can''t define Actual Numeric Value')
                ELSE BEGIN
                  IF ("Normal Value (Text)" = '') AND ("Min. Value (Text)" = '') AND ("Max. Value (Text)" = '') THEN
                    IF ("Actual Value (Num)" <= "Max. Value (Num)") AND ("Actual Value (Num)" >= "Min. Value (Num)") THEN
                      Accept := TRUE
                    ELSE
                      Accept := FALSE;
                END;
                 */

            end;
        }
        field(10; "Normal Value (Text)"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Min. Value (Text)"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Max. Value (Text)"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(13; "Actual  Value (Text)"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(14; "Unit Of Measure Code"; Code[20])
        {
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(15; "Character Group No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(16; Accept; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(17; "Lot Size - Min"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 0;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(18; "Lot Size - Max"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 0;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(19; "Sampling Size"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 0;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(20; "Allowable Defects - Min"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 0;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(21; "Allowable Defects - Max"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 0;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(29; "Reason Code"; Code[20])
        {
            TableRelation = "Quality Reason Code";
            DataClassification = CustomerContent;
        }
        field(30; Remarks; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(31; "Inspection Persons"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(35; "Character Type"; Option)
        {
            OptionCaption = 'Standard,Heading,Begin,End';
            OptionMembers = Standard,Heading,"Begin","End";
            DataClassification = CustomerContent;
        }
        field(36; Indentation; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(37; Qualitative; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60001; "Actul Time(In Hours)"; Decimal)
        {
            Description = 'B2B1.0-ESPLQC';
            DataClassification = CustomerContent;
        }
        field(60002; "Time Taken(In Hours)"; Decimal)
        {
            Description = 'B2B1.0-ESPLQC';
            DataClassification = CustomerContent;
        }
        field(60003; "Rework Reason Code"; Code[20])
        {
            Description = 'B2B1.0-ESPLQC';
            TableRelation = "Quality Reason Code";
            DataClassification = CustomerContent;
        }
        field(60005; "Serial No."; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(60100; "IDS No."; Code[20])
        {
            Description = 'B2B1.0-ESPLQC';
            DataClassification = CustomerContent;
        }
        field(60101; "IDS Line No."; Integer)
        {
            Description = 'B2B1.0-ESPLQC';
            DataClassification = CustomerContent;
        }
        field(60103; "Item No."; Code[20])
        {
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.", "Item No.")
        {
            SumIndexFields = "Actul Time(In Hours)", "Time Taken(In Hours)";
        }
        key(Key2; "Character Code", "Character Group No.")
        {
        }
        key(Key3; "Document No.", "Character Code", "Character Group No.", Accept)
        {
            SumIndexFields = "Min. Value (Num)";
        }
    }

    fieldgroups
    {
    }
}

