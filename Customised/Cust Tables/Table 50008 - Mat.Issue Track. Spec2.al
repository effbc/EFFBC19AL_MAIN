table 50008 "Mat.Issue Track. Spec2"
{
    // version MI1.0

    Caption = 'Mat.Issue Track. Specification';
    DrillDownPageID = "Material Issue Reservation";
    DataClassification = CustomerContent;

    fields
    {
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(3; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckSerialNoQty;
                /*IF Quantity < "Assay Quantity" THEN
                  "Actual Quantity" := "Actual Quantity" + ("Assay Quantity" - Quantity)
                */

            end;
        }
        field(5; "Actual Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(8; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            DataClassification = CustomerContent;
        }
        field(10; "Actual Qty to Receive"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16; "Appl.-to Item Entry"; Integer)
        {
            Caption = 'Appl.-to Item Entry';
            TableRelation = "Item Ledger Entry";
            DataClassification = CustomerContent;
        }
        field(24; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckSerialNoQty;
            end;
        }
        field(25; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            DataClassification = CustomerContent;
        }
        field(28; Positive; Boolean)
        {
            Caption = 'Positive';
            DataClassification = CustomerContent;
        }
        field(29; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
            DataClassification = CustomerContent;
        }
        field(40; "Warranty date"; Date)
        {
            Caption = 'Warranty date';
            DataClassification = CustomerContent;
        }
        field(41; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(62; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
            DataClassification = CustomerContent;
        }
        field(63; Correction; Boolean)
        {
            Caption = 'Correction';
            DataClassification = CustomerContent;
        }
        field(65; "Quantity (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(66; "Order No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(67; "Order Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(68; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Order No.", "Order Line No.", "Item No.", "Location Code", "Lot No.", "Serial No.", "Appl.-to Item Entry")
        {
        }
        key(Key2; "Item No.", "Location Code", "Lot No.", "Serial No.", "Appl.-to Item Entry")
        {
            SumIndexFields = Quantity;
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label 'You cannot invoice more than %1 units.';
        Text001: Label 'You cannot handle more than %1 units.';
        Text002: Label 'must not be less than %1';
        Text003: Label '%1 must be -1, 0 or 1 when %2 is stated.';
        Item: Record Item;


    procedure CheckSerialNoQty();
    begin
        if "Serial No." <> '' then
            if not (Quantity in [-1, 0, 1]) then
                Error(Text003, FieldCaption(Quantity), FieldCaption("Serial No."));
    end;


    procedure CalcQty(BaseQty: Decimal): Decimal;
    begin
        if "Qty. per Unit of Measure" = 0 then
            "Qty. per Unit of Measure" := 1;
        exit(Round(BaseQty / "Qty. per Unit of Measure", 0.00001));
    end;


}

