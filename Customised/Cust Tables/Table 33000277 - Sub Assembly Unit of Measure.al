table 33000277 "Sub Assembly Unit of Measure"
{
    // version WIP1.0

    Caption = 'Item Unit of Measure';
    LookupPageID = "Sub Assembly Unit of Measure";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Sub Assembly No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = "Sub Assembly";
            DataClassification = CustomerContent;
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(3; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            InitValue = 1;
            DataClassification = CustomerContent;
        }
        field(7300; Length; Decimal)
        {
            Caption = 'Length';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(7301; Width; Decimal)
        {
            Caption = 'Width';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(7302; Height; Decimal)
        {
            Caption = 'Height';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(7303; Cubage; Decimal)
        {
            Caption = 'Cubage';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(7304; Weight; Decimal)
        {
            Caption = 'Weight';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Sub Assembly No.", "Code")
        {
        }
        key(Key2; "Sub Assembly No.", "Qty. per Unit of Measure")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label 'must be greater than 0';
        Item: Record Item;


    procedure CalcCubage();
    begin
    end;

    procedure CalcWeight();
    begin
    end;
}

